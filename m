Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BBA27E052
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404345; cv=none; b=lg+Nvw9eeWEeWUYXDG1h1QxQvbYXJWX2pFtiI2pQdRRRxBzgV8m2OuMT14EnZPfXpFdbdWitkLHI3hLoMyf14GAgtHmNffDy3J4S6UlcwPIMUrQFrncEp9rLxw35WD2ME9jOcGsvA3V6fPcpuz93kl13J1cMG4UsEmKxfuIUypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404345; c=relaxed/simple;
	bh=xJZ84BPzYR3K5/odATxoJDK2iV3Pj/FQtOsdDsgASd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tR1Os4UNvKn+ql3rxfb+NXsDKIqeOIlUT94QM5bMuVZdfsmy9WVDaNlf1w3r2HoJQlCDBgtZjF50amEvsSyfhR4dsfKQIqPSJKZow+ilnYopT7Ir2AVtetBszxCV7TPJYSueoF5ZRgjlxJci71hI5L+y5eQsRH3XunRQRDBdWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjLOkJ4F; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjLOkJ4F"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23633a6ac50so77026735ad.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751404343; x=1752009143; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+RNQPcBbygDWBWKsg6fdcXi533ACMoNroSr42OmwU0=;
        b=JjLOkJ4Fq3JUR0gL07KCfGFkGUzUorccXe4DxKjlpmn9EU+q725eVVxzNmxavOYFuZ
         0xn0CZ8GP3rWwchFheY/92qCMKk3isYWmAZMaWwTVAX6mFvrwbgDDUUDvfjDDGDIUtEC
         u8o4tq08ce9mDImUxOgBB+X1ay6A1EXB63425FpkSztgnBOBpe4lLZmgQ5QDLdzC3zKo
         FAwpWwwYep1jcdJ/TBfoo7cqX5FhBAfPphSXq/saKVYERsWgSre4A23Yi38fO2wnlQPv
         iRG+CFTMOOm5+QwodV8s0xCMnWeP2YNf+UVQux9f1YEHOv2t/2+ynyogwh6ySOc7SU1B
         qcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751404343; x=1752009143;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b+RNQPcBbygDWBWKsg6fdcXi533ACMoNroSr42OmwU0=;
        b=hwTOcUnG2pFzYM783lozeKgblEhy2pJyRXYmPU6vmcTedwRd3w6a8840Lpv+veDQWm
         q1BbmaA2yFmsQSyMth9/YiJYccxQYJAUxufiK5EAbMmM8vgvTfoEy/Rccf2J2VFrS2nC
         XuPmJ9QgzclGtlZpMgIDVSukzc4nBFXT8gleAMdo1hrFzFvVboHrd7KCGafl04tcBH6d
         FWp5leibM3XpurLEBuGsWVVqKmuipFKkoHxuWSarkCSZReOLs0ijVKP1+RAskPvWOMYW
         PqCSV1RqJ2hjrbWO/6JEqnkBCuYJt0ohoXOvJAlNutyBquWRKjyWgpJuwuk493MXjXUF
         Aj5A==
X-Forwarded-Encrypted: i=1; AJvYcCVL3ovedzgEzYKb1mbHPWPP3rARoQbvFIOeb57861E34qPoQzL6Q8eA7fYw3dUvwnQrMXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwsmjpW37CDXhXMutS0c0n1cflfqKtvalzhbbnq03dKvVDvvF5
	0Wi/xQjjwA5df8cdgdYtit/oOqP4QLc4cqogsjmAMN0MF2m+1DDDMfKF
X-Gm-Gg: ASbGncuP+2NawJ5fO+mFgzeZ9xTwxg5W06LXG67/GsdegjcGR0cFHJro/TpHDfPS7uo
	8s9o8i/lxQN3aZ6WE+W83FywZlbtbprXub8XaIgNTkutacblxsqV+gvLH64gmZjx0Gok8daYlVz
	TpkTwRYSguk75er8tMWBSnbS9EtZcONtFwvIroRXDMIJISkTaVQbfKaGyhDI9dCu7Afz+xUes3V
	n+Pgly9/Eu1h2n3nWEUBSCc9LICq48wcqiPCTweagJqjNhKy1KKfXEY8DneWgCpb+pZJlKHL5e0
	okzfS6PX4yH60iTz1795S96P8L2P708TaF5k5h3AZR131jVpc0lj+J+Es/IImzQd4y4nDnhnKvD
	jRH5Knm58PAXJwYPUrXdk7MHif+A=
X-Google-Smtp-Source: AGHT+IGea8e4XkoWxWqMCzAWExfCG+Dtf9WPAo7Oqs9xkeSbGuG81ZKtgRJz3rWpCf7RPaZp7piigg==
X-Received: by 2002:a17:903:2f43:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23c6e59333bmr2545285ad.30.1751404343278;
        Tue, 01 Jul 2025 14:12:23 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c5a8csm114617505ad.223.2025.07.01.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:12:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Collin Funk
 <collin.funk1@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <xmqqh5zvk5h0.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	01 Jul 2025 13:42:51 -0700")
References: <xmqqmsa3adpw.fsf@gitster.g>
	<aFR-Yf0PMj30ex2O@fruit.crustytoothpaste.net>
	<87msa3quzs.fsf@gmail.com>
	<aFSVhpnNnj6p3r7n@fruit.crustytoothpaste.net>
	<xmqqbjqi5tk3.fsf@gitster.g> <875xgcq9zf.fsf@iotcl.com>
	<xmqqh5zvk5h0.fsf@gitster.g>
Date: Tue, 01 Jul 2025 14:12:21 -0700
Message-ID: <xmqq1pqzk43u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> In this particular patch, there was only one such instance that the
> tools output was noticeably more irritating than the original.  With
> more excercise like this with enough positive experience (I do count
> this one as positive, if we fix the space after "foreach"), I might
> change my mind.

And for completeness, if you choose to take the tool-generated style
changes, here is what I want you to also place on top.

And then, I want those who advocate blind application of tool's
output, only because then we would have somebody else to blame for
poorly formatted code, to think if they can improve the rule to
consider these points as well.

Thanks.


--- >8 ---
Subject: [PATCH] (style) fix bad changes suggested by clang-format

 * The commands array in git.c is traditionally one line per
   command, a possibly long line is not wrapped for grep-ability.

 * No SP between "foreach" and "(".

 * When wrapping a line, keep related things together.
---
 git.c           | 12 ++++--------
 last-modified.c |  8 ++++----
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/git.c b/git.c
index 918d83762a..8ad1ce8dea 100644
--- a/git.c
+++ b/git.c
@@ -576,14 +576,10 @@ static struct cmd_struct commands[] = {
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
-	{ "merge-recursive", cmd_merge_recursive,
-	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-recursive-ours", cmd_merge_recursive,
-	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-recursive-theirs", cmd_merge_recursive,
-	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-subtree", cmd_merge_recursive,
-	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
 	{ "mktag", cmd_mktag, RUN_SETUP },
 	{ "mktree", cmd_mktree, RUN_SETUP },
diff --git a/last-modified.c b/last-modified.c
index f7f6a67d3b..dfa3b2d324 100644
--- a/last-modified.c
+++ b/last-modified.c
@@ -116,7 +116,7 @@ void last_modified_release(struct last_modified *lm)
 	struct hashmap_iter iter;
 	struct last_modified_entry *ent;
 
-	hashmap_for_each_entry (&lm->paths, &iter, ent, hashent)
+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
 		clear_bloom_key(&ent->key);
 
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
@@ -210,7 +210,7 @@ static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
 	if (!filter)
 		return 1;
 
-	hashmap_for_each_entry (&lm->paths, &iter, ent, hashent) {
+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
 		if (bloom_filter_contains(filter, &ent->key,
 					  lm->rev.bloom_filter_settings))
 			return 1;
@@ -218,8 +218,8 @@ static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
 	return 0;
 }
 
-int last_modified_run(struct last_modified *lm, last_modified_callback cb,
-		      void *cbdata)
+int last_modified_run(struct last_modified *lm,
+		      last_modified_callback cb, void *cbdata)
 {
 	struct last_modified_callback_data data;
 
-- 
2.50.0-278-g6118fc98aa

