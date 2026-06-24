Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6EA248F72
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297433; cv=none; b=dJZMuDQ/2VbVx29agJjVTHFnnPN8Q4kOWysk8UDoMQqy2zMEg/tqytNFGSrQ+QR613KPOlciNkBHismy99XdYS0ZJzS2Fi+8szp/Agnx/kCMv5qsjU0IU5GJ4c1b0Dyw53JnP4TGh8/N2r336CKRfZsZqeKmYXJPAa/Y2JKQQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297433; c=relaxed/simple;
	bh=aJAeTaV6W7LwxDFnQOtL+v0gT1r9fpT7vMcJjASu0I4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Jk/g1r1oRYn8rnTFGVarD7Rr7jF1Z6d0qqa37eXriWDLeB1SnXwQADO21AvwFvulVFxDySIjGyPvLNthte6zMDznkGkWxa+iB/ukEnuKDYOdkcZTpbidcXQbIsUmEdzdB7Q8is9nqMrjxAAIbrHOBE9aSSMpF8jHGrezp0hsHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J7Zy982o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FiboOisV; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J7Zy982o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FiboOisV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A98F31D00161;
	Wed, 24 Jun 2026 06:37:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 24 Jun 2026 06:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782297431;
	 x=1782383831; bh=W1nFZ4uQbTrPMnn95P4Z15vHKySGSuZ9ZOZDvoYNEJY=; b=
	J7Zy982oJ4G1povij6FcjhzZyQRAIm2PMh2czNxnziCV1rFX1BYQCqkWEfQzhBy4
	wF/A2pnct0NUwsHjukvxlHkC46V15Ro7kdb2ZYlOKKjxw5zwZVT7RnErGfJdJ5Vm
	KYAVw+34IXKWx0+7T1Bba/s6eYO7dKPvquw1LsFqvWUFCEIEbkllfi/71AHJY7PO
	ii1V4RhGsg6kUEcPlJog5H2jX7YWI1zOn8yyS54i2LkjM/5JUrJeIXvhLitm7LMD
	CKZs8FDhMSWEq0bdOID7nFmCSPmUjJtQL0vBeRMeoKzCuo6BmTqd7SddLjt0gVpB
	BsK8Olp+IYCUWey1daJdgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782297431; x=
	1782383831; bh=W1nFZ4uQbTrPMnn95P4Z15vHKySGSuZ9ZOZDvoYNEJY=; b=F
	iboOisV82Jbp3Rqs/nQ7a0TY0wo6s7fIqZkOWf4dB2r+XjUlDsClYwZIiv2wPHQV
	h8B+mu3q7yEyE+ff08lI88u9LgrjYALtt/dN/Q3B8oKAX2zAGoamOGnUpV5anrAu
	/9ivL+b6qmA8j4lSSULJm6VF/NUCuSnvvbkQ3E9yPP1mb3TuZkaxfw8NAVYaGxWF
	KOAfkWV6MIFd2/um2xMU0pffo24UCeOEXSLTWzUxOKUl3fcntKsYhlODSmHP9CTI
	VqdWOE835iWnBqJ9b/kyynbnIWn3DIgDwUPTU6/m+wJe9YLC6lM958jMKR8wGwdU
	RT9bpOKSvzeZF9pXrfsrA==
X-ME-Sender: <xms:V7M7avrWqsSAZAPLLjCEOGoiCUPqOPnYPK3rADdQsf3ehesqGAXUuw>
    <xme:V7M7ahEcLOZpLtlSw_xJBqowkHM5c2ZQ_bbcXz0SRXNU9z3pogmeD_xJkmePvqIJ5
    xVguG9bYb-gq6sEVYkUUUo8P72LE58n01ecluV5D2w2oYccHF_I>
X-ME-Received: <xmr:V7M7aplBKXSlXgJOGeZnhVlziNCsFUzXQiNvrxdig-oAI9U0JAdVmNAlhMy4Xy9fRVJvPqDMGLTZSLe-vthkDBVPYjkCPI0xZODKpRZz>
X-ME-Proxy-Cause: dmFkZTFrbXKIoOdpigswINqkiw7TxDddtoNcajVkBDKVkDjRuVPlb2GpvK5MtZXqi++T4N
    bbeGsSHa1O35o52IqMUjRsvOv33Fv/fe1iE/Lvi/TqwSdQS/4Uxd3/HnAsoej+JWyi3RFb
    o1B7lWVpshkZ3N4keNPoFn19/n1VKWa6kcJhhwGZbqDXroXgMX5zo6Z3HYi5FXENMmWQK9
    yGe6+P/wcSJIK4HvRbu/hg1YuPp+/0/8n3hbmpouuwpfRDpzrGvqe55TKaToL3wEaULJnH
    kYFYlGGbJR6uTzmk7G+GzgPlV2buI1le1c7QgguYAxSpI8wbIA4PrpoXsPXqOTGZkzF5Co
    3YzuXTAntodVuNVd40Vg3zsnTDuxBf4GDSgUhoioR4s0cTVm40n2o6FV4v+pJSrlvEZuGK
    SmoBLIXTE5XXy9lK7nOxz1pJyPvy2oCqgc2JCHOsDbRgpp17pDAg8y5WSOpPtcsbmKM1O8
    EQnMvegi1ogOma8FuRdORapEJRSDr67fSeKFPMCMeNI/9EYtqGan10dTizyF28ClVIo1+t
    43v3NS3jPZ5uL6wR2RKyE1DTA7JV2Rs1gVjpkbFvjLRLyONjt0SANtEfTZl56/R4gGoC5z
    CCFwt3MVbgCHrRyhvGHMirl2Fuwe25XBA+AjuePWswVSRVtBJ3W3bXpoGcaA
X-ME-Proxy: <xmx:V7M7asnnVpaWMlKQ3s05RAO82eNdWH4GHGti1oCjLAFuPnf5eJaesA>
    <xmx:V7M7aivC7Hz_qof8X79sVu_8FeJi1fQUQ6g0BT0ou6Pt_pmhqAI7XQ>
    <xmx:V7M7annPdjvULAWYpzLidhn8Ue9to1dmWgJjBDg1F3o3TaXyZ0HOdg>
    <xmx:V7M7alsWXK--lr3787kX0mwLed6ypjhwsCst7QrZM0j3CeNuwRyVww>
    <xmx:V7M7av1wND3I-rO5rYQjszPRmDXRYIVN8NwR38IWzBs7Rkf5_FdbDLcU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 06:37:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eda386c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 10:37:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] connected: search promisor objects generically
Date: Wed, 24 Jun 2026 12:37:02 +0200
Message-Id: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+zO2oC/42OQQ6CQBAEv0L27JhliAQ8+Q/DAZZBRsMu2UGiI
 fzdAX2Ax0q6u3oxQpFJzDlZTKSZhYNXwENiXF/7GwG3ygYt5jZPEcaHgAvek5uohRt57TsYYxh
 YQgTXk9MEllnWdF1msWiNbo2ROn7tnmv1ZXk2dx3ZxrdEzzKF+N6PzOmW+znxX+ecggU8UVNjX
 hZavmjvyIOp1nX9AP+24QfpAAAA
X-Change-ID: 20260612-pks-connected-generic-promisor-checks-2933bff3028d
In-Reply-To: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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

Changes in v2:
  - Fix the accidentally-dropped call to `odb_reprepare()`.
  - Add a preparatory commit that splits out `check_connected_promisor()`.
    I think also splitting out `check_connected_rev_list()` would only
    have diminishing returns, so I skipped that part.
  - Link to v1: https://patch.msgid.link/20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (4):
      odb/source-packed: extract logic to skip certain packs
      odb/source-packed: support flags when iterating an object prefix
      connected: split out promisor-based connectivity check
      connected: search promisor objects generically

 connected.c         | 95 ++++++++++++++++++++++++++++++++++-------------------
 odb/source-packed.c | 50 ++++++++++++++++++++--------
 2 files changed, 98 insertions(+), 47 deletions(-)

Range-diff versus v1:

1:  6ff1fc8d89 = 1:  a1a1af0fc6 odb/source-packed: extract logic to skip certain packs
2:  1022a1fdcc = 2:  bd81a9e478 odb/source-packed: support flags when iterating an object prefix
3:  102fab7df2 < -:  ---------- connected: search promisor objects generically
-:  ---------- > 3:  f39ef68c3e connected: split out promisor-based connectivity check
-:  ---------- > 4:  558f30a6f2 connected: search promisor objects generically

---
base-commit: 4a8e7a446f41435e157131162dfe901eca9250fe
change-id: 20260612-pks-connected-generic-promisor-checks-2933bff3028d

