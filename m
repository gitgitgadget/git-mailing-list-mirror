Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106243491F9
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208605; cv=none; b=i+u9PXYFJNfHSpfA6MFGRbAljszGv9Qk6jYN6bDqAXCUSstKwQ0kqJerGiO14Zfr++G6T/zRMIIwvHBx08kZYE8w6/DM20NzGP7JjJb6e3PHO4Pmz/ymaEieF9LOY5iF2uUO7UkEks/s4zRywSlM0G/jgEfznPMuktvdu7MAIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208605; c=relaxed/simple;
	bh=l7Npz1/tcP4ZDF4fMCEfA7tG+xfJxt3eFzXhzO8fgF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXIezM7F5BcLdtmwKwD2RZAUoyW1r4IcGIh5Aec/0l7cS9cRJwpEtlZuL8hFvTnwqDf2COWWOBxTJTZl1QAiMBgaCZpLnZouCTqGlgZqgtmp0ecpu83WKvKk7HROXyIcO7VxanGGwpKtQd/inQiz4b8glr5gVB9crr7D5ObsfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hAmm8wHV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NVdvDShZ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hAmm8wHV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NVdvDShZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D1321D00011;
	Mon, 12 Jan 2026 04:03:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 12 Jan 2026 04:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208603;
	 x=1768295003; bh=g7d/TTCCc2sJWZnsa44rSf7sY1zIZgcOsDYH2hZBHa8=; b=
	hAmm8wHV00KWyP7ZKLLbSugf3685cl4KZqHPj8CqjHofyditR+R/PEK4HhcAGIv4
	05AOnS3FzOKbUdCImq+VeVnlWmVgYJ7Tg3MKl8Pz2Vrxq3Kpb7/hAr5QV/OYE2n+
	foFYhKCo/yE2nPIKB8PZTMjkymqrXruHScDhJXITBPoEjRRd95sG6FjFTz2eL70Y
	eP1NVU5M3c/IR+9ibxAQhklzdFNFf7IPL7jyMT5xuENZrL8YWCDkum3OhIZN/mDu
	xbboehvreIiJsHoaj3Td6H3eJJkyr6CYuYs43+/+vT53ZMnrKlBOEysHwvbomcLS
	3gYMFvDJERC8zhmwUNckMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208603; x=
	1768295003; bh=g7d/TTCCc2sJWZnsa44rSf7sY1zIZgcOsDYH2hZBHa8=; b=N
	VdvDShZZMh7fsfEirC6yvzO3PFEKCN2LuNoJlppwS5LepCMX0YCAERno8RMzTrPg
	U+RrWMBluUDe+oLR2VJGZIPCHLFc2a+TTwnQcSXrIsg65h1yl3PSwQc7+MDop9Oh
	cQx/zboymh11w/69CVITIZzMwQRqyChz6SbK/zWfFEXWCWDUmreUvX6ewfD2qPUA
	ZhLx/gMMndwlqHRAJxjKz/o1Y8+Ah4KEVJItQqYCwK4bZcihxc/YkVtvAO7zPB5e
	EivuAJxyAt3ENxrh1lMUjKYo72/2Eb7uHcBDjOzR0Zmhi9ohi8jwHZJXajuz/KGE
	AJ4qh5Yh7M1yUhz5L/Jmw==
X-ME-Sender: <xms:27hkaQtK0r6JkqH1KgFnLxUK__dvw-3JqEpAUv7NG8tt-DlB0m00VQ>
    <xme:27hkaU5gBayy2E6LqWOaDpy_nRWL52mnVvFGQuBnxOSK3WvVEJDep2NKRKLdLrMhJ
    wyvbKf1y9-bOgYBXovHMtyMos0bGG1SLW615qIfD7z8cOQjoo6lpg>
X-ME-Received: <xmr:27hkaZIdNrOngPXYGFX4xT0XuKX8-8Aq5i5UUeHiJNOhRKogIJJycjFIUZYtb20hpmoicHEIr17WRWzv0lhlE6tGf8d1KpCVAb-mtjWMaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:27hkac5G_rMGsS63E6O2bGOC6wBcsZdnQ9XepyAEm82kSwm5ysRfJQ>
    <xmx:27hkaUy1KmtwPjrL5lNHz95UYTVV8KVXoWM5JJmoO7qZlmes6bbqnQ>
    <xmx:27hkaYb6shTfT7S4R4BRxvrCiaR3lEWyhLc4uw6qD1Bxq5Zmp3mtbw>
    <xmx:27hkaeQYpDJFLVxNbsK4KCs4bEvxtcQQfWySiA991YkVFamZiVWLOg>
    <xmx:27hkaeFgIafa96tsYZ7sqUfrUsM-KJU4f2ulF6GYJMAxWgvLO_iauG6Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1409f231 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:59 +0100
Subject: [PATCH v2 10/17] refs/files: introduce function to perform normal
 ref checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-10-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

In a subsequent commit we'll introduce new generic checks for direct
refs. These checks will be independent of the actual backend.

Introduce a new function `refs_fsck_ref()` that will be used for this
purpose. At the current point in time it's still empty, but it will get
populated in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c               | 7 +++++++
 refs.h               | 8 ++++++++
 refs/files-backend.c | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/refs.c b/refs.c
index 739bf9fefc..4fc1317cb3 100644
--- a/refs.c
+++ b/refs.c
@@ -320,6 +320,13 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
+int refs_fsck_ref(struct ref_store *refs UNUSED, struct fsck_options *o UNUSED,
+		  struct fsck_ref_report *report UNUSED,
+		  const char *refname UNUSED, const struct object_id *oid UNUSED)
+{
+	return 0;
+}
+
 int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
 		     struct fsck_ref_report *report,
 		     const char *refname UNUSED, const char *target)
diff --git a/refs.h b/refs.h
index d91fcb2d2f..f0abfa1d93 100644
--- a/refs.h
+++ b/refs.h
@@ -655,6 +655,14 @@ int check_refname_format(const char *refname, int flags);
 
 struct fsck_ref_report;
 
+/*
+ * Perform generic checks for a specific direct ref. This function is
+ * expected to be called by the ref backends for every symbolic ref.
+ */
+int refs_fsck_ref(struct ref_store *refs, struct fsck_options *o,
+		  struct fsck_ref_report *report,
+		  const char *refname, const struct object_id *oid);
+
 /*
  * Perform generic checks for a specific symref target. This function is
  * expected to be called by the ref backends for every symbolic ref.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 687c26ddcb..240d3c3b26 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3833,6 +3833,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 					      "has trailing garbage: '%s'", trailing);
 			goto cleanup;
 		}
+
+		ret = refs_fsck_ref(ref_store, o, &report, target_name, &oid);
 	} else {
 		ret = files_fsck_symref_target(ref_store, o, &report,
 					       target_name, &referent, 0);

-- 
2.52.0.590.g1f87b77810.dirty

