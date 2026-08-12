Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4853FE363
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526061; cv=none; b=lMmvWpxk/VxGEAoc3lSm43xHGlCxDtjtnlldHYhDOIMt24PAtTS94b5qsJMq4sIgAqnLuDukWjRmp28cLTiJ8DdzYZ2pAcmPrzUXB4mIqy1FfXwYHhFJjwcaU1RJ+7T5luQiTaTDJGjnn1oeicQDPY+DkmauOlvst6W3jGe1Yic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526061; c=relaxed/simple;
	bh=kAxda6F0FCXDHtc2QKkxaxrhmyriwKas8EYnOKN324k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYacZtTbgqNFEpjc7ryDRBJpaICUoroHycGvqdRCz6pivm7czGVYBigto+XjA5P+IvmoSEQAmnzcTa9hOpTBtviMXtIwHdL8D245LZppkf6C/Mw/3iGiRzqJA9ZdjQvke3L+qLw0Ar5hkbfHMw45gwXoaEeUUg2UFGOPdad5N7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iBedgJjS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cwUEdfsz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iBedgJjS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cwUEdfsz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 21C73EC0079;
	Wed, 12 Aug 2026 05:14:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 05:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786526059;
	 x=1786612459; bh=ofh5tBbw1WwvrOqH1q5x9DHBSAtHuvTWiB5KYH1on0o=; b=
	iBedgJjSbqAWahParKjP2HukeYfXn0gCYYVtZg82GpwU9BPwRN0b3ZFVOwGeg+oS
	86PT+Xoyikc0mlZ4RBhZ5Lcw7Yln8wBnJNaJqMYEtsjHPzkZRnCrnhJWiOHXC2yu
	UittXGgjlqanNkOW/RQGVSKnn4r7zUUTwzhDhCIewOF14W7DgrfZI95UYcrGxVNk
	xyP4G9Fk+9Uc9ukf23MRN49GPmNEYMagDwRZ/r6G1saPRBiSIVEw8OFFb7gLNNlg
	IJKMEZigIBhFAjf48EOlhC/w1k7lO2yF3eYxnXC1GW1F4+Ze28F23bkPnd7WQAlo
	AUjUTJLE54YmOSY5dQXK3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786526059; x=
	1786612459; bh=ofh5tBbw1WwvrOqH1q5x9DHBSAtHuvTWiB5KYH1on0o=; b=c
	wUEdfszy9aFGQxhqifWjTOV0d4aPJIVU2vlbtERXWr8Q11U9sKPsOVaHPkBvVFh9
	0aFuM7fvmkQL1VJ9ulhqE//qjWMEt6HznY7/FllsWdnUcMx2wnEc3C7PJBhuMRQV
	SqL+Xfwe2WgkLGetkVjCvun32zCYpDtnqf+q01kIzWjpItAS89qYNJgkAozCxxRV
	opkTgqQKNm4Kv6DPUySU/KZCyhmMpkiuyZ42orS8NTm5PoIbUUo2jgpNB8Ut+Mt7
	tuAWhjX28L576w5b6IlBluswOjiVvlWG1e4+UI68Oa9zDvD62SeX4EmVs8fq38ky
	LFjz5kELxphJKHW7M3LvA==
X-ME-Sender: <xms:azl8aj3F8FFzUFZ2hZSM4w4OUODFpJM5GdsGLNLr0mPouwwEdUfwrw>
    <xme:azl8aoFoiMc3enCpAFlRMFt_RJTQiQh9uX6BOUsqi0bpvHHWmuNPj0ST9yKFjTgQE
    btpvjq3mbbnY27yziRB_5bOF6CNGELZLGAZOAlhWYmOv01eudTJPw>
X-ME-Received: <xmr:azl8ahhbLezr4BDUAGRCDLofG3yhYFNvWaSbP2YP1h4kr82pXb5pc0ovu-JSRoF6UDcfUEiChf-2Mqp3JdWbKYixf4tdI7Dl-0bhLaOrxw>
X-ME-Proxy-Cause: dmFkZTF1ikDNmXNl5XfIDqNninmRif7z5Lfmk3ugFf8hnACpeOQdPc2+dupsug77UWHRuJ
    ticuIOQAWRQqnot4uWGkntmyebsNZTngCzpPOWfx/lFuuZBmBi2uQHZfr34nIjb/e0h4Dw
    3VNRvI6VS16N4Nj2LqWKUw9pR1IgRPRfdlaR1VVFYN8LkIWZt13QKLSKAVxpwT3xe4h+km
    8hZ16tHZuM1LONjYn+6T7T79X/mNt6nPWXAZ0PXJoseOpSegd0GdL85AMtzsZKLj2vnRg6
    fbvduZbsoj9tt4XW4dwiQuyDQiSRjQH/j4vxPXl/AJBvq7t4K/jKtbi4/vAprm/TOnmnW0
    qDUnc1j3LU4I+MiAoZ8COqeeluv6+nJm3NZwp0oz6DQw3Ba7MeAP5Fi4WIkD3x/3rNpuFp
    E4lQLyWBY1/WJC7bwPlhwKc68CpL977MN8l+ir6bqsQKnrnBf2pYc6TNfOZ6GOB9CkfnaE
    IyosvX+U5RW28fzl7iy3pOjrFK8Hy5FVBtn2B8Le3XKn0rmakKevxQR0ByOr26t53tDVw8
    suOujImdY8RnDd0kulmDjWt8kSY2RLMnXOZfJgJo+J+ZXFImc51xBYILPnFXuovukWHhr9
    QDI67L62Lz2oJkA5puVYOjwsb2xD7o6MK6+t/NAC4GpLQfpWccKZ46kVJh5w
X-ME-Proxy: <xmx:azl8aj-iIUExizx_nhTQqT_KbIGJa3ZlfpuCYpw10hfAk6qJzNRM4w>
    <xmx:azl8aoos8RDWahE3x0GkXsOWvFwUWXMlISNp8xzni58wbMMH9VQLrg>
    <xmx:azl8ai_egz3YFPDAGT7gaT34vTPiDn-U5E8CgVwHXuPi5QQmQBe2Nw>
    <xmx:azl8asWGrBtiehITaR1SxoTrHKK1xbDftUwpUqNJPT-3KQUQE8imFg>
    <xmx:azl8agkMScg9s2bNtUdihw9vqEUVSLPnCNKVN_FBAYHUdqNrf2A0_ree>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:14:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b9b3943 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 09:14:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Aug 2026 11:14:00 +0200
Subject: [PATCH v2 4/4] odb: drop `alternates_db` field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-pks-odb-eagerly-prepare-alternates-v2-4-522b9a5bc1ea@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The `struct object_database::alternates_db` field tracks the value of
the "GIT_ALTERNATE_OBJECT_DIRECTORIES" environment variable and is
used in `odb_prepare_alternates()`. It's not necessary to store it as a
separate field anymore though, as we stopped lazy-loading alternates.
Consequently, we can simply pass it to `odb_prepare_alternates()` via
`odb_new()` now.

Do so and remove the field.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 17 +++++++++--------
 odb.h |  7 -------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/odb.c b/odb.c
index 2eb37a2f44..0212eaa998 100644
--- a/odb.c
+++ b/odb.c
@@ -490,12 +490,14 @@ int odb_for_each_alternate(struct object_database *odb,
 	return r;
 }
 
-static void odb_prepare_alternates(struct object_database *odb)
+static void odb_prepare_alternates(struct object_database *odb,
+				   const char *alternate_db)
 {
 	struct strvec sources = STRVEC_INIT;
 
-	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
+	parse_alternates(alternate_db, PATH_SEP, NULL, &sources);
 	odb_source_read_alternates(odb->sources, &sources);
+
 	for (size_t i = 0; i < sources.nr; i++)
 		odb_add_alternate_recursively(odb, sources.v[i], 0);
 
@@ -1062,11 +1064,11 @@ struct object_database *odb_new(struct repository *repo,
 
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
-	o->alternate_db = secondary_sources;
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
-	odb_prepare_alternates(o);
+	odb_prepare_alternates(o, secondary_sources);
 
+	free(secondary_sources);
 	free(primary_source);
 	return o;
 }
@@ -1100,8 +1102,6 @@ void odb_free(struct object_database *o)
 	if (!o)
 		return;
 
-	free(o->alternate_db);
-
 	oidmap_clear(&o->replace_map, 1);
 	pthread_mutex_destroy(&o->replace_mutex);
 
@@ -1123,10 +1123,11 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
 	 * Reprepare alt odbs, in case the alternates file was modified
 	 * during the course of this process. This only _adds_ odbs to
 	 * the linked list, so existing odbs will continue to exist for
-	 * the lifetime of the process.
+	 * the lifetime of the process. Consequently, we don't have to
+	 * reprocess GIT_ALTERNATE_OBJECT_DIRECTORIES here.
 	 */
 	if (flags & ODB_PREPARE_FLUSH_CACHES) {
-		odb_prepare_alternates(o);
+		odb_prepare_alternates(o, NULL);
 		o->object_count_valid = 0;
 	}
 
diff --git a/odb.h b/odb.h
index aefb34213f..748366a610 100644
--- a/odb.h
+++ b/odb.h
@@ -69,13 +69,6 @@ struct object_database {
 	 */
 	int source_paths_icase;
 
-	/*
-	 * A list of alternate object directories loaded from the environment;
-	 * this should not generally need to be accessed directly, but will
-	 * populate the "sources" list when odb_prepare_alternates() is run.
-	 */
-	char *alternate_db;
-
 	/*
 	 * Objects that should be substituted by other objects
 	 * (see git-replace(1)).

-- 
2.55.0.679.g6767b8d81c.dirty

