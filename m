Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6013FE66F
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403205; cv=none; b=GonlsbHrErhf8QC6RBmfxCGgaQ1E0H4fHZCAytoaxHfABn8RFjtG+XaZyg6NGefKh88u0T33YvygQpnJvWDW+bcNZaNxbOWZXvBPalhwFeicUCF61rZJY9oE/3lFKtMbKUv6FmvB4OgMVlX09CtnM1U4bSWCFZaio9a/AYHKxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403205; c=relaxed/simple;
	bh=jrvzBSQQJa0OZjY+b6jlWKIMAGJcXYmF8hH9nGC8uN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGbmCMpb0CsExVOvtJqbXNa4A8TnMxkQFHprAut99NY56PGyEE21ayTJntD1okp5mptA9dlpVTp0LackuRu99HEAoLCT4TsLsc/NnuxLuS2uirYomWafghtYHbNazMCFoHzQ93dKOKluqPXgRFqhjeZeEeNwIoGs/NNVUKVUZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SNYr+TfZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DVpOSc6A; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SNYr+TfZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVpOSc6A"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEE2C7A01C4;
	Thu, 30 Jul 2026 05:20:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 05:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403202;
	 x=1785489602; bh=TlLDZxv7cRW+e0ioz5NAVcTpXwFtDG3WORhNaALehks=; b=
	SNYr+TfZ7C2t40ZrXzG09NEfR2cdhaV8dUgxpSvzPJgJYYifrp7eloGyw/EGEcoS
	0EEaCYd8L2E59zXfAt0gGAyfGAPoJujg6mQVtYHgQDuG/g5XYwAqcDMpTpTVjuZx
	oiUdYM3otIgZ8iCiweCCEaWILXMyGxodxqIcl9VsV3D6y9KZg/Iyakb0rwwfscwY
	4hms5WWxFou0Fa1x3pSE7Hi1hcxC9BNJTD4UAdakEu1UHJaPJTGVzn64Y1fTJQrC
	dDlcGJiRBTm2WUeDLZjSIosWkaTNJBWn0GclT7p1hReY5/CPkWFnWK2sPncxKFs/
	OSzKp6zj5dZd0CybRTADzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403202; x=
	1785489602; bh=TlLDZxv7cRW+e0ioz5NAVcTpXwFtDG3WORhNaALehks=; b=D
	VpOSc6AviblR7AFkXi4vSyHPZcPxEjCwbbrzla4/lWdfDpRE16hYot/+MiQ+pNrZ
	Ydm56dkVK9av0Zw7RFi7drcV4NMsLOz6oYPYSos62rSECE4TcnCJKeMlo+TBKjoC
	YrD2fFzca7ctnwf/M/EVF/Rrt5yc/7siQnQrfWnZRVE5BtlJcKTD7OBuu61YPjM9
	3mVn02Rf+pCcqEoP6I8DXobyJ3qPQGftmS57XqPNX4Jb0vHR2WuBWFPR9vQNYMCl
	3vFz0LjPRjqHqTUA8KrMa6jfc0fV97P+6HyuHDkhsNz8+UZ38pjJB7tOiuqeSnDJ
	0HsiW4GR3L2U94blT1McQ==
X-ME-Sender: <xms:QhdraiFX_Vs8qM0L8Li8cQ8tK0sKGMPbkDaQ5YUrkjIshL2CGZZ2OHg>
    <xme:Qhdraia6-kXGeL_hETj1vMaJ5gpn9__LNr2YSbc361qfG1X_Cyl0PbWfZGx_GYWf4
    Ooq4yw2n3bFO4vvLuv6ficoQ7nw09dvB1_uRcTw4PX_ypE4qK5NPw>
X-ME-Received: <xmr:QhdraiUklDH_xrnbV7B2IX72p-gUP4Vwae83D6rviv6510Zw_Bpq6nG2mzUYvLxImyIM7T3Dnb8XnRSfl1Ea2otGDEkbg_RaxbGRIOrcw5_qxaA4zhW678w>
X-ME-Proxy-Cause: dmFkZTEQRaEnp20JHpkZN84W0Q6WHP48FXgPbfDynCccs1aRUH7OTcWv14/9sQKcd3mlNw
    cNwb/n+9BQBBGue2hk8pje/LcGgLUW27pJUGEKVe4HF1dVfkZGOdX9ynw3XapXdoE/Aazt
    igSQlf9AzI8Wf7moh0eWcCkc7o1tplhOgXEX9VazN6RbSvEzsHM61maQEBnNB/6olueJb7
    1465y6Br3pCDzlfMELcHsNzFjCqNxPUCGBiVMsMrGOoRJXHJfVf2kJjGdep5Nc0wMPTIEm
    bYl2FFqIRqrq2iLm4PJtQhzdHasuyxV8J8l8WydIceVVYxQD485lKvS/iMIosI/5SG1QeT
    a8FnC1nbavH+ImpMzV6cQDgnNSjnziE2cLhyPh2bRtqvDE2J+2xbhlaUChvFu+8MU44Ozf
    8HZav+j5TAriVMx+A5kdj+LTPM9FKobUUNqHjtHK16N6fgABUh3AX0WHvmh+0a99EJKFXc
    rZAPJfI2FgflPTajaE962wyipmGgQTRu/6YeoR2wpSRxuiltmChXE8VgQemX+yjqT2lp8H
    Jb4Yq3WhWnxp3G6gWJRNWEbA/HC0+vxLJBQH8sjXXiwSaV7w+AVHieVqHiQqFWPNRpVoKT
    R4e1p5qG8u92H0SglDfRnhrmsB5de1+W2SJdEz/F2ewB/OZFLzkLbhjwRrUA
X-ME-Proxy: <xmx:Qhdraom_kREeXmJSGgsgKXjWAQVF6EntgzSORNw9UMPQTZnxvstPsw>
    <xmx:QhdratAxrvXMbBQTx1quLplCo935sq3Cn6QV1cnfCtN4TRzBQyp7Kg>
    <xmx:QhdrangTZEh6yMk471WNqPSdvILWk6539BxWVH4h_rc5tsN0NCagNQ>
    <xmx:QhdraqxqfUFSbVy-4iq5s8Gji7tXVb8wgR2dilWb_4zKGoIGfb2jJg>
    <xmx:QhdrauATUSvaYG62DDCiNfJgn-ex8GF-iCEbE4CA4yWPatldOkzdOdKT>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:20:00 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/11] doc: interpret-trailers: not just for commit messages
Date: Thu, 30 Jul 2026 11:18:17 +0200
Message-ID: <V4_cmt_msg_or_other_texts.ae6@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This command doesn’t interface with commits directly. You can
interpret or modify any kind of text, even though commit messages
are the most relevant.

The git(1) suite also isn’t restricted to only direct commit support
since git-tag(1) learned `--trailer` in 066cef77 (builtin/tag: add
--trailer option, 2024-05-05)

Now, we already introduce the command in the “Name” section as dealing
with commit messages as well. That is fine since that intro line needs
to remain pretty short.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 5e776f0059a..ab3627c2cba 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -15,8 +15,8 @@ git interpret-trailers [--in-place] [--trim-empty]
 DESCRIPTION
 -----------
 Add or parse trailer metadata at the end of the otherwise
-free-form part of a commit message. For example, in the following commit
-message
+free-form part of a commit message, or any other kind of text.
+For example, in the following commit message
 
 ------------------------------------------------
 subject
-- 
2.54.0.22.g9e26862b904

