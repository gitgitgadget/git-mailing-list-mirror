Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB53385BC
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118178; cv=none; b=JH1pWLtqHoPT4Rj7l/E1YuYQ8A70c6F45rYujdQfuY0MIgTy82MtlzgO5wkygPT3KVXyIOgWPnpHobde9OAauZkW68IRRUKyIsJKF35ZTmu4Tfrn5/tRfWjk+DX/zKw9Y9W8qfQj34NfNlFHZk7DbVw0bvIRvm8GptDdXQV3lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118178; c=relaxed/simple;
	bh=JgMowCngLtANlCL/ZBjiQLSc1Idhwxzod2TUCDvkQZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mY7rGcJh3rNEMAxiD6446dMrv8tyhIZTqOY3HcTjbm1S2cARy8w2nbNSPP72rpZODB6nFcR0fSAF86J5xbRVyG6X/ARdGNukg2rpf4Y9fpxLWew4UvypO/V0Mfp9m8xSvbLJf/bW8GX3Fp4rrG2OIp/w21+ZM4iWlDJhPvsnGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NVbCwx3z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OCdmfKg0; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NVbCwx3z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OCdmfKg0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A04FF7A0187
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:49:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 04:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1782118176; x=1782204576; bh=ciEFoEBr9+
	BxCwF9kBa4YjeRhxrbgMTtLQJyz2sh2xY=; b=NVbCwx3z9jv9NmoIJuSDKbgCd6
	u4N3Q0fiTBveH02VE5zfPTfmgALJlQTafT3D0G6MPAuQU5CdEJARMNUSW3vsXnkZ
	YEaNuhSLqvXJWl75wTvJYZiUaOXDu/KumSpPXHfugdodbU+UQdWSQ0V4yYXTK2bI
	pWLBSE8wvrouBGAeNRZx2iHzJusFunyVqn2iuqryhFuyR4GSaYgRgTzEjbJgAe2W
	zv/VarFQSzcvZ+EoH+0unWm5YDMeMu6bbI+FKN2zQsFIum+WqSzR8TU3JR2rocpP
	X7QgWn5nBBylLwYtiEwSkjQEAzh7ATwngRRnC+hX/J9lrpXKg0KEl14UKW7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782118176; x=1782204576; bh=ciEFoEBr9+BxCwF9kBa4YjeRhxrb
	gMTtLQJyz2sh2xY=; b=OCdmfKg0nwaJMixxK2RoJIRACVi0Bg/vM3Qd+OvxdteN
	RqGN+p+IIJAJNhTgtqt5uPhd3oWDeIb/zVDLvQ7pLn4/BB1JrqFd1O1LWecTIxrd
	CpYW9v5gNobWpH+oqVQ8YZN9nAUsOtBERu2ABtcqoF/tTfAu9k2PWkLVRe4Oy4og
	g66J+303/PSD0KGxih4+0KbuSW1GrQ2BNDxxoXW+RVDNkY5dlwY7WuG33cyfC3Ds
	KZQ0EyPUnGDGEAW4TGojlNMRz5X0JDuCRqlIOds79k46z3Ri+melJcX+AUbZ1OAX
	mOxqDnapnV13JEzoXaMXVYfziUaux/9MVmaRJ2My6g==
X-ME-Sender: <xms:IPc4ajwe1rCBPOcoCxXk8oKGcZwz5aRCDC3IkdTOg4JsWBaVkB4wiw>
    <xme:IPc4aiPcRDjACPcr5jPFMCRdLOVtSwQ-lUrlf5zEwzAUlV2gVQ6UYJf_mtY2cBnVj
    Kd5VB4LJzXO7jdoICjXBM9BqWwiMw_NjpxlAoOoGndTOEqGleAX3A>
X-ME-Received: <xmr:IPc4ai-Yf5lAca8nXEoMpUVdipS4nNcb8_2TW0WaidsQUmqm8rwxtZZPWKRCqmkE265Cjn_BnPDWmO5SYzOdS9W2gjGlR58ombZ7WSFXLA>
X-ME-Proxy-Cause: dmFkZTFjITzjsLpYR4jKkyODniOJETRjZ4PsAW5HOeXh8n0x/6wMd7c/zk0vbyaJr5f45p
    EhmTjJyoI4Bc/zuKl1cb5cdDknqeKY0Afqo1L+SNwCwusVoNX5wYDI4mSZW2OANO1LNhGa
    drYp9Hd9DZ+M6HG74twQk5qaQ1r2RZ53kUnQOXwaokmG3PQeizYA8j47vYUz0sSxD2xEPk
    e3n9/jD/LJCSIP9NZhD0+COitGQ925ULI30RfOUNOlTNa3R7WemRAciLsuYj4CYfCiP6oX
    Aegua+WeFAzIWkHFVALWlWv+0EyfUrmxA9E/nz1nwTJgQPzPFkXU8Gp8kDbWZnVCJa4tTp
    gibsmKdRgIots8ky7+vHZBFbYsnWm0960KsPJ3V7CfemxH4Ti8O1UJ2EioPxGg4UFItqMn
    6BeUNWb5927M2tFkhnyCr/Jp68fXumzRCt82t+Ns5CajHGDluPcS0kjU9XmCj9ocCM1yxk
    jry3vTwavXL012mpj9Mm2smpN0RQ9/ELHcJ5zYMZfZysnVRIgZzlqjbtF3LiV4rTybsDwN
    gu8afPIGx2+EsnNegpMdFCFinPOqWaJoi1+iI3qMzs1ImYjVOeJnPiv99oS7W6fKhM6AbJ
    PS6JiOIBI9t1z4FhKwFTx0zHiJjZBYjw8xSsSN9RWvpJBLydpzmgVKC7wZ8w
X-ME-Proxy: <xmx:IPc4aiqH13N6_1J9pycUiQ5BGFcvvHHZ4CYvNno3hF0_mhgtB28-rQ>
    <xmx:IPc4ak4-EZ4NHCcfe55-1foOaFvxgWvyjJdHWjfONaPVfM1m0FmV7g>
    <xmx:IPc4aiOI5KD5_U9FHIvTQY9QG8s1RlNNFHJhr0r2_2dm3LzkrLf-rQ>
    <xmx:IPc4amNy4LzLby1QO-H2IHnGY5rvTnk8tFlHm8k2-TmxeBKL3BVplg>
    <xmx:IPc4ahz1w3kNvHmBUe5Ic1q9OKXMbXc6lIaqx73GkuOUPTqGw89Gyzvs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 22 Jun 2026 04:49:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ffae3f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 22 Jun 2026 08:49:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] connected: search promisor objects generically
Date: Mon, 22 Jun 2026 10:49:26 +0200
Message-Id: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABb3OGoC/yWN0QrCMAxFf2Xk2UDXwpj+ivjg0nSLYlsaFWHs3
 43u8cC5566g3IQVTt0Kjd+iUrJBf+iAlmueGSUag3d+cEPvsd4VqeTM9OSIM2fbE9ZWHqKlIS1
 MZvhjCFNKwfkxgrVq4ySf/8/5srO+pptFfnHYti+b8M67iQAAAA==
X-Change-ID: 20260612-pks-connected-generic-promisor-checks-2933bff3028d
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series refactors "connected.c" so that we search for promisor
objects in a generic way instead of reaching into internal of the object
database. As a result, the connectivity checks will work properly in
repos that don't use packfiles in the first place.

The series is built on top of 8d96f09e92 (Merge branch
'js/objects-larger-than-4gb-on-windows', 2026-06-19) with
ps/odb-source-packed at 1bba3c035d (odb/source-packed: drop pointer to
"files" parent source, 2026-06-17) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      odb/source-packed: extract logic to skip certain packs
      odb/source-packed: support flags when iterating an object prefix
      connected: search promisor objects generically

 connected.c         | 39 +++++++++++++++++++++++++--------------
 odb/source-packed.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 62 insertions(+), 27 deletions(-)


---
base-commit: 4a8e7a446f41435e157131162dfe901eca9250fe
change-id: 20260612-pks-connected-generic-promisor-checks-2933bff3028d

