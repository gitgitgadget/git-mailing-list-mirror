Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0F1D798E
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328184; cv=none; b=T2KtVcn13mwon/TsyJkEH9RKUTCGc201IZCMRxSKQcQaBETa0r38jmeelgxpvYeRLFbLkXs0flzJxCJ3eoy4UDefm2XvTz/FKBoWdaiuvFwru2tWqtHbKLYdXh/ZGbFt8a6spFR2NxGosLSu04seibEzm0kY+Q8bPXpk1zPR5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328184; c=relaxed/simple;
	bh=JzGzGB+Utq3vXvBno8Hg7Lqa2pFuvvahrjZyIwzWawA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N+cWihtAMblxLMRPzwK5p9j0guwGe22noVVIcFBao2hE4OkC8lEIO8SdPk5YleGoTYa91Q7/Dw+2mlHQafEnjgn05/1DbbBZhCtH/ORT/qhqL6mUdOL0EQjw2T/T9a2xjfDUBDmwvfO98AZH/Bft71e3TfdzbRafoUX0lz4CnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mx9zzaj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A4RM8N3s; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mx9zzaj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4RM8N3s"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A3DC1400106
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 11:36:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 01 Jun 2026 11:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1780328182; x=1780414582; bh=C7pM4CP0Lm
	QvbYS4mcMCUnz46tG2yMWn60HlUNNAlFU=; b=Mx9zzaj8SzRUNQ6s9/ckwpAvSC
	Ri86xSpmVxcRZrOlk4giffXKZc5sK5EM6+bz13KYYDlt6eQ3zoLz1iiGKoJcrmBM
	5ZbYzckXO+iJIu30IL8JMHlrlgH1HA9aQI6ww1qyw5Zhodhkkdr9Q2TF1grzZfF/
	N2SbZ05wmrSQamXiqniKMNWP70uJzyp3Q3qMyLu0GGe+iRDTD7ymnlo/Teaxhsv+
	NyqNBZVQDbE1M6oMTRr0mMfqWZ9pIkEm9L78AIhX7UfMN9+FDTziS+Z8vFXCKlJi
	pZm4MmcmZmTj+N7q5LRw5Z7z4VUZS/0GVzXgJPxb2AZE8O4lu08eYdhSbWCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780328182; x=1780414582; bh=C7pM4CP0LmQvbYS4mcMCUnz46tG2
	yMWn60HlUNNAlFU=; b=A4RM8N3srvJx4AKySJpxlrACvn4b5Y5FCuZwDNWxxctN
	eTmUwd52sIa/yPsh8EjuwQROxHlY2GkCLVtmr3J1JR818BWITLis+5JDyRKRcOEL
	GS5M3DfeisZIx6cs/Kbg6KpawBOwxyHBP79U8V6osp8PL9Tdi6g0awV/KO+H5P63
	+ALRMpwQYnmjjhf4IU7c7WIyfGotEadJ5Td4UbRV0mBA2dqbLojwxdFsFQL75Dmx
	Gd75U3JrEXyJh3N5dgBKPkUPT6L0tNjky8DQMnkzTPDDwTyWvGDWLwk6avKepSqg
	YNSTF0if9Li3XZHvIRlvyiBiLnI+9mcnMUPlCxC0Hw==
X-ME-Sender: <xms:9aYdavelw9wMpLaeFFDNtBHomGxnfora0otLPmF83LnC2C_1h6s4-Q>
    <xme:9aYdasKovZ67DlsZIbDBaDBIZk36e4S64zTKH8Eg5YK8qHPtZZDY4081yEYkphC6C
    HTv6I94HIuRIXt3MUq3VDyuqmiAKQ1I3XqDcOQprrxQLFNWnJty>
X-ME-Received: <xmr:9aYdauKRWUe8Bp_KFfuED9ZpKxsBRNn2aR2nQSWD2gi_hU-KFAhkMJTSh7OEZIXjHCflAIoyQKQbJfDZj8Xm1M2MUELKDKWtmf1Yyz1YzhvL>
X-ME-Proxy-Cause: dmFkZTEE5UY4AcoDeXKt9E0Hoi6TrXTwJJlMTcU79aVUTX+jhxWA6Xo8IjaQhg1BQk0aLu
    l+ofzGl/HUxlNkEEL7yB3O3eHJfMxIK/mkcntnCg/7QBBPOq4PsZWRFaQ4RKuLSBVia73B
    lRf7oRDvcL2spYzb7P8Sm4jnLyoRSdyJb7wL10seR0n5AZWh+7/ge81lvJCrSJPrHHQdz7
    /ljN4InC2WAtllIEhSArg5Zqc/xG6la2Vlixk+6EBu9DtlVl3Sx41RiiuYPsDIpjqfp/xn
    vTRg89o4u+oLvhi9DrGBz0i6HCK1UfZJdT+BaRBmtL6YHmzsuGU1uOp/10E2qRGq5lyXd2
    r5VFMoPeHRlbjN0Hspc0ltxdlgq4x8UhaWclGYlr4tIV9+MpfxFP18AYVZOikzKrGyRWC8
    1XPSglHUP97grsGHULUMV3iWJjTlSjizms/OT3WuOVK5cFWVRDZSLG08rFAYuLjCfZtKiZ
    I8ozOrIQ+tk3cb+mXX6+gx+Nat/pQHbIjBGGeUZw4DvbxOk9+d84BVBQFPe+R1O1NauTLW
    gijYsYH68JkrPW829BuOV5FzAhm2rnI9Xf53RHuQZnRW8zCnNxCJJI1SWpxzHibWeitvAr
    g1eiCQ1zUEKqyWo/IXlhHFZZaU4Q4sp7QxJpD2l7ia3LLk68HZlB+RHSx4WA
X-ME-Proxy: <xmx:9aYdamGqAbvRvgNco0PMeskKK-TZ6hUTbYoUN2lIIQ_x6_fx8GM3LQ>
    <xmx:9aYdarmmWe-keaMED4oWjGEX0ttORWzzcAK_uFUDBms3lLTDfSwN0w>
    <xmx:9aYdarIfLVdN_0Bz6sO6Oj5fh-3h88NYTcMFVamfYbK8oQdXECOBgQ>
    <xmx:9aYdakZ0x0uK7Wo_MYYKvzX7FPYpnCR9Y9wyOQjNlKTmXHO-LTFXxw>
    <xmx:9qYdahNUqXSHekcb_iKcPs5mpUQ6I_Vpmfz0dAsTmfALSl5YpS7iPbuz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 1 Jun 2026 11:36:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44c2d2da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 1 Jun 2026 15:36:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] builtin/history: introduce "drop" subcommand
Date: Mon, 01 Jun 2026 17:36:12 +0200
Message-Id: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOymHWoC/yXMQQ6CMBBA0auQWTNJqaYIVyEuaBlgJKHNDBIN4
 e5WXb7F/wcoCZNCWxwgtLNyXDOqsoAw9+tEyEM2WGOdcaZCf8W0KM6sW5Q3DhIT2tvogrs0DdU
 ecpmERn79rt39b336B4Xtu4Lz/ADu7OdbdwAAAA==
X-Change-ID: 20260601-b4-pks-history-drop-28f6c6399e7b
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this small patch series introduces the new "drop" subcommand for
git-history(1). As a reader might guess, the command does exactly that:
given a commit, it will drop that commit from the commit history and
replay descendant branches on top of it.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      builtin/history: split handling of ref updates into two phases
      builtin/history: implement "drop" subcommand

 Documentation/git-history.adoc |  38 ++-
 builtin/history.c              | 333 +++++++++++++++++++++++---
 t/meson.build                  |   1 +
 t/t3454-history-drop.sh        | 513 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 846 insertions(+), 39 deletions(-)


---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-b4-pks-history-drop-28f6c6399e7b

