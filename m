Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47935BDA9
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962393; cv=none; b=XvfaMpTxYPnQ7IXDKJTcxK15BkqmWDY+iLgG7xWkVoZxJ2caIeDUvQy0rZEXOC6wk8TOtrHMywJH5hpsuBzDDYcUXZgrR02vU7RKhIuWlYACnRSFU8djsEoXK22nIoXLPJcbxZxIMXaGC93fupZKZT2HW34gBz06lYIVKdEdVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962393; c=relaxed/simple;
	bh=cbUEWrMcw037E5WbWS1gW7FnXADi1z9RQvCX7ecSR/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxplmdZK1NC5wEEYFApOT9kht8IU1NkbNP7zlQvCGaONoi5jGlGZWwVdmX9EYEzgJTQENzfpdKCeqo+0DrE9yPi4z3MW18VIC4ey7TMn3Ej3OWIJxmM022DjaF7oZE9ln6kjzcyZRWi203EMJdZJVYxLpebixfpqBy1X8LT8GXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RPKkI6It; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XAvUHgOk; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RPKkI6It";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XAvUHgOk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D9591D00185;
	Fri,  9 Jan 2026 07:39:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 07:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962391;
	 x=1768048791; bh=QdkJtRbyKYyvVhiz+2RPdNz+BXbdcrEwewHdTwA5gMM=; b=
	RPKkI6ItOWYa6/rvmWZrXJwp/b23mR7BCFdL2Pz3CvrxDA5xUxLMXuXm3vdxTwrc
	ZGJADbNzmkTnlAF9a4U+Udzp+lIAn884WW4IqMLnM9XItDbElp2ZPf+H5ayRyYtM
	0reUbEB5bju85795w2vAG598jShswiDtWQZGqchpJynyLr/cJhcZ5NwVgj60+LCt
	+hHOS59tpQZgfsVCUFCwY0//3GXjP1YfN2MEENLU52jc4QAIBgfMefkvzeYLh7pZ
	6WiFXeeURNHjq/fRe6qusZ7E4JcfdJkfYaYXrFlupWiBXvZydwgu8qJgKbw3qX8P
	00monOGHutFXItx7eNG+yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962391; x=
	1768048791; bh=QdkJtRbyKYyvVhiz+2RPdNz+BXbdcrEwewHdTwA5gMM=; b=X
	AvUHgOkV55LIFYxCBf9CL35M1kWjy+qkguoxr8FUdweBloinWm5NWLxgST5T78Kf
	kMGMuWQ9s9g98BooZPlZN0HRjleFQlP2hSiKSxGTb6wnyn3vNPhvku+VpRgbdzYD
	w6ks7hM6oZu2QLjd3UN9rY0dBTAnvLnVcdPN5k3r3siJU7kNofNce7ejC40IOJfr
	J3gdx+36OeOeO19VHedN7f+6wtFmbwYXQNOP/52dBucQu7+oDRJsf9Jiwv7UHUWk
	8NPcpF5HLwfnK7DqUI6m5vw8uFR/23NL02zaq0R7vtiVGtL3DOnEd6PKHMHaxxOL
	LkuO/Czo4highuJS4VLBg==
X-ME-Sender: <xms:F_dgaSHRWHFDoyonXxrwPRZynA4TtWFIMr_KEwIkFhoqpEGFhnYecw>
    <xme:F_dgaayo8igfCfmtCm8Cp_1h-YrAf4OSdaH8aVDHCpYi0qEbpOlPQEra-YfnAMo7C
    NNiWbNcFCWw9Q57YVkmRBZAeJpoRCrxSiVwANg6BKsID_YvkND0R3I>
X-ME-Received: <xmr:F_dgaZhh6k2q6s8agaaFEZfACVvW-PkwoacjmCHSMW9vFncs3wdWJpZI4CAFCZDNfSGIFgS5Hd7NDg7umI059SL3cp63GyLcfCNfA3bRKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:F_dgaVyhZHH-knJ0gIZ6YjxlPoshvt8bE37bvrTuuvufVtd1cspthQ>
    <xmx:F_dgacLXAqRHLg4FIdDdSvCgMJx-q9oKlYxnb50B5FDz7Ovo9Vnk2g>
    <xmx:F_dgacSqd5AQyUCnMmGZlKtzsW5CfccFVoKBtMchF2E-hU8V5Y34Uw>
    <xmx:F_dgaUrX4thgTk9rOjG72OGU0ShsOZPYkvMwdqZ-q_ykdfAUVF22zg>
    <xmx:F_dgabMriCROUw42t2YRUCtTNvb4kwQ9vv0l3QxITyJy8rubW8MTUjqV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b312e088 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:35 +0100
Subject: [PATCH 06/17] refs/files: improve error handling when verifying
 symrefs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-6-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The error handling when verifying symbolic refs is a bit on the wild
side:

  - `fsck_report_ref()` can be told to ignore specific errors. If an
    error has been ignored and a previous check raised an unignored
    error, then assigning `ret = fsck_report_ref()` will cause us to
    swallow the previous error.

  - When the target reference is not valid we bail out early without
    checking for other errors.

Fix both of these issues by consistently or'ing the return value and not
bailing out early.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9972221f9f..abc2165339 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3737,17 +3737,15 @@ static int files_fsck_symref_target(struct fsck_options *o,
 	if (!is_referent_root &&
 	    !starts_with(referent->buf, "refs/") &&
 	    !starts_with(referent->buf, "worktrees/")) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
-				      "points to non-ref target '%s'", referent->buf);
-
+		ret |= fsck_report_ref(o, report,
+				       FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
+				       "points to non-ref target '%s'", referent->buf);
 	}
 
 	if (!is_referent_root && check_refname_format(referent->buf, 0)) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_BAD_REFERENT_NAME,
-				      "points to invalid refname '%s'", referent->buf);
-		goto out;
+		ret |= fsck_report_ref(o, report,
+				       FSCK_MSG_BAD_REFERENT_NAME,
+				       "points to invalid refname '%s'", referent->buf);
 	}
 
 	if (symbolic_link)
@@ -3755,19 +3753,19 @@ static int files_fsck_symref_target(struct fsck_options *o,
 
 	if (referent->len == orig_len ||
 	    (referent->len < orig_len && orig_last_byte != '\n')) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_REF_MISSING_NEWLINE,
-				      "misses LF at the end");
+		ret |= fsck_report_ref(o, report,
+				       FSCK_MSG_REF_MISSING_NEWLINE,
+				       "misses LF at the end");
 	}
 
 	if (referent->len != orig_len && referent->len != orig_len - 1) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_TRAILING_REF_CONTENT,
-				      "has trailing whitespaces or newlines");
+		ret |= fsck_report_ref(o, report,
+				       FSCK_MSG_TRAILING_REF_CONTENT,
+				       "has trailing whitespaces or newlines");
 	}
 
 out:
-	return ret;
+	return ret ? -1 : 0;
 }
 
 static int files_fsck_refs_content(struct ref_store *ref_store,

-- 
2.52.0.542.g9473a8513b.dirty

