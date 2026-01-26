Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161233556A
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429875; cv=none; b=ZlPqamFXXD/ve/srz/xZQvuRYtECnz23BOPenKWjRtUAY8FqXtxTjAI5O+FHzVpMi4HGnoYlKvfW1VB+JWBvWGJA7QTkZiR4r+CA08u3PFeNNAjgHMnrkpQEl0+2bhVAM0AuUt2/CPsyZ6WOvScKg8jHrjg5iU2zhFcly3ebw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429875; c=relaxed/simple;
	bh=ROGHlVWXpKKyhXjAxW3giLPJ+uKOKn4EQ+KCf4btQ24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=majLZ5kJ2DIIBAXbGxHbG59iEWm7t8VaMKOc1oqivvo27Usd/Rfo6elm/85T//KFASTvYjqzlC0+w6zTWRFSLsMHpwN+LAivFLshVHH7lkhxTDsF9n5BuT3bB9I5cJ2Po3KphUKp8Bbyc/X1Nsz3jfOkyMC/w/xC40kNeiYrRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=grqbqQIL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGHSiChD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="grqbqQIL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGHSiChD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 545D0EC011F
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 07:17:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 26 Jan 2026 07:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1769429872; x=1769516272; bh=Zd3fuEqqki
	juEVdFV2i2s97J0spIPQX5BRBFsPL3CZc=; b=grqbqQILhN/A3RR2a4sX5t3z3d
	xOl4eKUFwMY9gS2kHHjHonqmPNDuEM2rDwYg+57OV4euhYW6kmkXEFTdk5juUG4L
	zr5drrclTN/iW9T8IukVBFDtDm/itiX/2zyiRJhPGDURnfKn3RLl+jKnm8Oz1UH0
	8foZPuMZepoGJoulL8hdNKx++6lMaSPXDAFrhnkNyc1B9NP60mgloNlJ5GBb1Cpu
	0NtNtwd2rRmvqQlVTCfmHA6UwsAW+C69+b6B/RZxw3f2ledftHjWl+eq6XfPumaE
	dFnF3e2qqtN/4vAv4PLHbzFaIcKXZf3YPh1gWUukfRzdxwIGiI8dJAmJPR+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1769429872; x=1769516272; bh=Zd3fuEqqkijuEVdFV2i2s97J0spI
	PQX5BRBFsPL3CZc=; b=lGHSiChDGNhOptYK7v7Fc3ThUwVSK7C3noGUzYjEVvAC
	P9xYtqr0HneqT3Cigki+0KucsNLUSXNmt7OoY5a0LpoSffs74dBzifnuRHoIr5aL
	PLobeM+CHQJFxrBmia8ykvVkSNQGNknsom2wpTWi761XT7FxKLK4JW6e5vzDfZ0Z
	I3B2imYKt807coyOdSYnRLMz9QLsUYZgV4WRAhXql01Bopyc4OnB7a41iTc84Feo
	CmLO4QcsyBxyp2Ry6C+I0JkNYS8BdCsxTA159eLcjhAOoBD+VeXGc9O5GFefs6CK
	Bm1EnDmJll1pWhKT/8WJuu3GFwrVmeEFNbh6Pet2ww==
X-ME-Sender: <xms:b1t3af7tWsqlUeIzSjsFoWjr_Bz0p8ABcTM9xn0kd_KImUHIEhvSOg>
    <xme:b1t3ab2dUSvuFEbEutcLg1Z-HiBRja5bQIzhOuSk07iRzLmUSUvUA9GQEmgk-N88Y
    cW56Ekv7SrogIIg1n3dTPQ0MnlbtFrtVit9hC4HK4EPJK2x7DTkwg>
X-ME-Received: <xmr:b1t3acFi1pH9KQioGAxz8spAwFBhpkt47yoB7UyXtPBK_pVe_p4SfXltD-bwBrGv-yn5a3SfMCpkDaOUE0fvMFCAEZsn3yJ2Sc0_438c7tm1rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:b1t3aVTzYoUAwH55FhGjDTi-bvKwahYyRYx6MzeJR2OCG6x6nwQyQQ>
    <xmx:b1t3aTAIVHz3mkwQD5046p8nIx21UObiYFHFYCNBF1S3ic6kJ8Fesg>
    <xmx:b1t3aV2JDV3AuKNt7JQ6T_CnKypwaimqFf7Zd2QJFWV-o7FUCZ2quw>
    <xmx:b1t3aRUU6B4_sirvFbU33qps-u_2rUryZREPCAmbkAs-wrq55s61Fw>
    <xmx:cFt3aca_CsgtxwKmaJgk0YjsoA_CkhOZDO6LTKQArVVsw3I_-yZesq5q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Jan 2026 07:17:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 59496bb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Jan 2026 12:17:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] Small fixups for `OBJECT_INFO` flags
Date: Mon, 26 Jan 2026 13:17:40 +0100
Message-Id: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGRbd2kC/x3MwQqDMAwA0F+RnBfQtnawXxk71JhqprTSyBiI/
 27x+C7vAOUirPBqDij8E5WcKrpHAzSHNDHKWA2mNb7tjMfB4bYoFg4j5uHLtKOkmDGuYVI01pN
 z9kmReqjHVjjK//7fn/O8AOZDXWdvAAAA
X-Change-ID: 20260126-b4-pks-read-object-info-flags-236c4437cfc5
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

I was kind of curious why there were gaps in the `OBJECT_INFO_*` flags,
but eventually found out that these gaps are of historic nature: there
used to be more flags, but their respective values got removed at one
point in time. So naturally, I wanted to clean this up a bit so that the
next reader wouldn't have the same question.

Surprisingly though I found out that this breaks tests, which of course
puzzled me. As it turns out though, we were incorrectly using a couple
of these flags for `odb_has_object()`, and the changed definitions had
overlap with the existing meaning of other `HAS_OBJECT_*` flags. There
isn't really any bug here as far as I can see, but this is only really
by chance.

In any case, the first two commits fix calls to `odb_has_object()` that
used invalid flags. The last commit then removes the gaps and converts
the flags to use an enum instead.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      builtin/backfill: fix flags passed to `odb_has_object()`
      builtin/fsck: fix flags passed to `odb_has_object()`
      odb: drop gaps in object info flag values

 builtin/backfill.c |  3 +--
 builtin/fsck.c     |  3 ++-
 odb.h              | 38 ++++++++++++++++++++++----------------
 3 files changed, 25 insertions(+), 19 deletions(-)


---
base-commit: ea24e2c55433012a0a6c4ae947a87bc66404e484
change-id: 20260126-b4-pks-read-object-info-flags-236c4437cfc5

