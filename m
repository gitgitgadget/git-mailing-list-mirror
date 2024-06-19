Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831255898
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770062; cv=none; b=i0tYjMMz4LTSsKaSuch6dmbQjAu4KgGW19+CLqsIx/L8ATAyjuS8ozgDlyYBlc6S6kOZuO29TnXPoQTpMQ1EQj7p9ax/UrHZeIKBf/f95iwz8KnRuOnGe42CFX4bmN9uAB7EqmrrkVCpXJXoBtKnNyIKThA3FXmSaL6E4zrFsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770062; c=relaxed/simple;
	bh=8Cwl5o7RBkt8KKW6IaPAtNx50jRHMszrxhEG2mspNc8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EC6z08ZmYlgyU7SnztBAOgPcwKHMP9XIadL2zf1IkJY8mVn9R1CngKkZPWv9qELAbFB5kj/q4KD+oMHNSDTRkQbAdAZiRXGRkDYP+guXc9NoL9Cn3JucgiiYeS4vYiCSYyGn8KjsVGcL/s98pOJs66KoiHI2AmDxh1baoAKnNLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmVKq0fD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmVKq0fD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so5525818f8f.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 21:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718770058; x=1719374858; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgK7CYiJc24Ca/CPKOckBNAC5hXOjIWL/DTmuIQBl6c=;
        b=XmVKq0fDukLF7zDRUye1UMAHXWgWM7qQilLDAlEeJKnpLPdbh6fpvKAMt+JAcoW/ro
         GnpbpB3XHbHR04lia/WDtYE8vZqDVm+zcuInLxqG8OT8GH9B3KR0OVJ9u7GvEMB4zjis
         WIIjawK924kkchnkiLoQ/8V643Bpo4i/nMTYd82sntrk1AErud0X1Tn0VPv5PkiaaiSf
         45mUF5nYRbrZnC8BxGXRB2F4iDuRdjYzkOTshyJ2v09MYzPf0SIzaEDWToplGusuX6Dh
         U0DwQfSLNpKLXjNtPjLN5Bxt90wqw/prsKYx8fuP0n7tV4BCKA3Wr8MN7AnQwEwhDS1a
         3qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718770058; x=1719374858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgK7CYiJc24Ca/CPKOckBNAC5hXOjIWL/DTmuIQBl6c=;
        b=iM7eiTSKKCroyZpDcn8vlGaZcwzAy183vB9ZDJILEJxQsG0zMbVDyeW57hW34z+R8G
         MoEKkcH8nS6YqDWFWmzATCnJKpbVhaQNDOh/qIetXbi2RQB9Kv7W9mjEba64KbdzKEWX
         0Vb4qV6ORjPSygMvtjusKK5r+eXcgRfcrsSAOTDrK+Gq+eNPzVxg1I8MaYkmIRfAGUHY
         u6FPz7lrvStE0GAWs+PRQK+yIo/YXZWXDzY/Q1y19+aqgzZKw7XbV9w0gqMCmd3wF1OA
         +/8Wl9KCAo7J50Dq8j5Dcf8XLiQFTqvLqA5mYm8Dh/UWflTjWQUn17i3Vwvx2gdvxS3S
         p49A==
X-Gm-Message-State: AOJu0YymDNespIXayINwH6YtzsBKeI8IJ6UbYiYBCKOzHma8vfsrIol8
	JhW+3D8XkV2aq6HTb18M+oTuOUrQ5bJtz/S1+Ol/TVpmCTQReXqSq1w5Zg==
X-Google-Smtp-Source: AGHT+IEfPEhObCXjNHMBeSj8UiVSRMxK2MO9brq9uqT2e8K/o3gbnAujZPDFenIkoFkJyeBMXEMV8w==
X-Received: by 2002:a5d:4535:0:b0:360:7a01:6afd with SMTP id ffacd0b85a97d-363170eceddmr1167131f8f.10.1718770058267;
        Tue, 18 Jun 2024 21:07:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362c19d798bsm2146497f8f.40.2024.06.18.21.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 21:07:37 -0700 (PDT)
Message-Id: <518584c8698b9ab7d7145b841c22c5c3e430afa0.1718770053.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v8.git.1718770053.gitgitgadget@gmail.com>
References: <pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
	<pull.1730.v8.git.1718770053.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 04:07:32 +0000
Subject: [PATCH v8 2/3] fetch-pack: expose fsckObjects configuration logic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Currently, we can use "transfer.fsckObjects" and the more specific
"fetch.fsckObjects" to control checks for broken objects in received
packs during fetches. However, these configurations were only
acknowledged by `fetch-pack.c:get_pack` and did not take effect in
direct bundle fetches or fetches with _bundle-uri_ enabled.

This commit exposes the fetch-then-transfer configuration logic by
adding a new function `fetch_pack_fsck_objects` in fetch-pack.h. This
new function is used to replace the assignment for `fsck_objects` in
`fetch-pack.c:get_pack`. In the next commit, this function will also be
used to extend fsck support for bundle-involved fetches.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 fetch-pack.c | 17 +++++++++++------
 fetch-pack.h |  5 +++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7d2aef21add..3acff2baf09 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -954,12 +954,7 @@ static int get_pack(struct fetch_pack_args *args,
 		strvec_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (fetch_fsck_objects >= 0
-	    ? fetch_fsck_objects
-	    : transfer_fsck_objects >= 0
-	    ? transfer_fsck_objects
-	    : 0)
-		fsck_objects = 1;
+	fsck_objects = fetch_pack_fsck_objects();
 
 	if (do_keep || args->from_promisor || index_pack_args || fsck_objects) {
 		if (pack_lockfiles || fsck_objects)
@@ -2046,6 +2041,16 @@ static const struct object_id *iterate_ref_map(void *cb_data)
 	return &ref->old_oid;
 }
 
+int fetch_pack_fsck_objects(void)
+{
+	fetch_pack_setup();
+	if (fetch_fsck_objects >= 0)
+		return fetch_fsck_objects;
+	if (transfer_fsck_objects >= 0)
+		return transfer_fsck_objects;
+	return 0;
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[],
 		       const struct ref *ref,
diff --git a/fetch-pack.h b/fetch-pack.h
index 6775d265175..b5c579cdae2 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -101,4 +101,9 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
  */
 int report_unmatched_refs(struct ref **sought, int nr_sought);
 
+/*
+ * Return true if checks for broken objects in received pack are required.
+ */
+int fetch_pack_fsck_objects(void);
+
 #endif
-- 
gitgitgadget

