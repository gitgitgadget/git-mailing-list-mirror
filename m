Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C819D8B7
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886032; cv=none; b=oqLCYNnrphIvyVlzoW7kKxlJM3nTEfHnbeRgHJvre7CSlTNTxzI0Q/ZgtFlDSrASLqzoVvCizkjvBKLmXJtdDIWocCRc9ci/BTsGsGBjJGwZ3Db5BmVS4eGH46BmukG5M3xF8NtgvAe9TxWjmimQs3nLzPuKjWRwELxDwgfb4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886032; c=relaxed/simple;
	bh=uzG4D6f0cRD73qE2kSPWnhPEUclXnvOONMhtgDEFfCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oecvb4FpJ9Iufm6vSPnYev+zUI1j212CdAHEyigIJUkmDhC9HbUKgagj8rqK5qE0SKmYWE+WXVoiahn94cwQM11c5sZj8Pepgh0vKVjKGzw/aZnZbaf832cwyrtcBnRlRBixRDzJQZDYu7BiQt74R6zcGpMJyImKdbRehWToRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pE7YKOKE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnpR/TEb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pE7YKOKE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnpR/TEb"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADE8C254018F
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 29 Nov 2024 08:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732886027;
	 x=1732972427; bh=Fz3/RqVx4WQHgOlLd9G/Uj9F5oXMMZuDotUJtdP+2Wk=; b=
	pE7YKOKEtB1ytQxvuavkbuAuG7ee2gKA3sUmXCfyk/dhlhu+wBE3ExwDv/nDSTHo
	UQuqTkb1XQqpgloP91LswbQnst4UlaUu9e+p78sfuL2Vhx90F/rJEuKbz8bemkqL
	mh06QKlWQ8rR0LpXG+0JI3y16y+74Vv9CYHxcoInQ1hBn73sO85bOPqb1Lims2f4
	LiYc7ZUKDTQiDDrO940AWmNDL1ozFr9sYpvI0+ik/XFJcep+FTYgzmzrMl6aUIgl
	CMDs2WtArdU1YodwMGcdP/Q5fRezjC+rCmNr5RW6YkdznvOf+sEyc1dsSbaLkWA8
	zsYEt4RJidSKXemXO04Ong==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732886027; x=
	1732972427; bh=Fz3/RqVx4WQHgOlLd9G/Uj9F5oXMMZuDotUJtdP+2Wk=; b=M
	npR/TEbwFRbKAVt6LfcSzvsFmsn3kA+xWqSDp4NsSz35UgtFW09u5FK0iVXoPYcf
	AeSRqR/PN7olDeYl9zDOmYf58ObDsGkJLjU31FRvEgeEP4FpsTcZDhQTOSqhn73K
	z5zrpEJvTJc4w7nC0EXM41k2zfahIm4ifCRMMeCNH69dSlLJqjTi6/xJPRYVOwGD
	LVRSsX5f01TurWkfLw6B6xnqcPbOL0IIFOpXBkWofhrCoJjMkfvIbmsNUC7+Q76A
	4pEUDCuG/zymjychE43QRx9WQo8RfQIKAja658Tb3o+kwFSN8AsvcrZDM6fTDUM7
	U/RKTwuMiQFL6HiMattbQ==
X-ME-Sender: <xms:C75JZxx27x-C-UwtPcRIMnrE1SAvCXb_SSfF0R-gtwF2JwPk3OkSkw>
    <xme:C75JZxSO2C4GrGbcjPp7Bxi4m8hRgjJHDuigYQdx5yg13vEh9tKEPXZh_1DzQ8y7q
    -H48vXU1HYnkXKu5A>
X-ME-Received: <xmr:C75JZ7XOqsuuaES9Yh2lsnfE8V8lRnwhQaYSTun4WcEcsYmX--wzyGAv9OIeBAYyLld0l9RNIet3Qu8W2OExn0DvP1sKQ2UftKHOsvrMVKJcBnYJ9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:C75JZzgNMPciivyyVob4m6ghrerx5FNv8UEVdUdEVL5a1_7qVHgLxQ>
    <xmx:C75JZzC1OWfzECIcbT2F4xxqSP1EFElpLUapN4vyyJy-Ik8xHsdp8w>
    <xmx:C75JZ8LhgfXtmTK8kUG4DR_Dhpe1o0KTihqV78ZgM70ODa6rZgYQ9Q>
    <xmx:C75JZyD9lgbcLb1d0f-IdsQ-0IXDjd1X_37p0KfHvDQCYdlxsRiJTw>
    <xmx:C75JZ46H1oF99gsUvpTNHVqV8ADmB2Twi5K6y0V4cEOofx1F_mD7VjrZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d5af1bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 29 Nov 2024 13:12:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 29 Nov 2024 14:13:22 +0100
Subject: [PATCH 01/10] git-compat-util: introduce macros to disable
 "-Wsign-compare" warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-pks-sign-compare-v1-1-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When compiling with DEVELOPER=YesPlease, we explicitly disable the
"-Wsign-compare" warning. This is mostly because our code base is full
of cases where we don't bother at all whether something should be signed
or unsigned, and enabling the warning would thus cause tons of warnings
to pop up.

Unfortunately, disabling this warning also masks real issues. There have
been multiple CVEs in the Git project that would have been flagged by
this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
the vicinity of these CVEs). Furthermore, the final audit report by
X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
that it might be a good idea to become more strict in this context.

Now simply enabling the warning globally does not fly due to the stated
reason above that we simply have too many sites where we use the wrong
integer types. Instead, introduce a new set of macros that allow us to
mark a file as being free of warnings with "-Wsign-compare". The
mechanism is similar to what we do with `USE_THE_REPOSITORY_VARIABLE`:
every file that is not marked with `DISABLE_SIGN_COMPARE_WARNINGS` will
be compiled with those warnings enabled.

These new markings will be wired up in the subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e4a306dd5639b58a4ec4d2a6269fb649348fb4e7..31a059820f3b1536a3c1a887390b70098a6fbd09 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -44,6 +44,16 @@ struct strbuf;
  #define GIT_GNUC_PREREQ(maj, min) 0
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#  define PRAGMA(pragma)           _Pragma(#pragma)
+#  define DISABLE_WARNING(warning) PRAGMA(GCC diagnostic ignored #warning)
+#else
+#  define DISABLE_WARNING(warning)
+#endif
+
+#ifdef DISABLE_SIGN_COMPARE_WARNINGS
+DISABLE_WARNING(-Wsign-compare)
+#endif
 
 #ifndef FLEX_ARRAY
 /*

-- 
2.47.0.366.g5daf58cba8.dirty

