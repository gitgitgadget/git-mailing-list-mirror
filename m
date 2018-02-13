Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D840D1F576
	for <e@80x24.org>; Tue, 13 Feb 2018 11:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934887AbeBMLtM (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 06:49:12 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42376 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934577AbeBMLtK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 06:49:10 -0500
Received: by mail-pg0-f67.google.com with SMTP id y8so2473172pgr.9
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OsMXYAdijC0uDZp/tHtNazxNLiVmRNZRgF02jfp0UiY=;
        b=PR2O4Pe1/blmgToFchij5TuMRhZnPumkNo/yTatjNxI53Y66cQUu5KNBqborRNk9l0
         JgjzFx4VlZWYoTgiFOFlPZkZB8DKnaTfm29TxOLlwt8/dybS+XQxBTixFKHHHbT6AVK8
         PjNtzLn+K/NiCfKZtgX/vrQ33LFAvjlZfaqBeJkx7AN8bYf+Dj3snBctfgRE82TAh9Ws
         7oHeB0hsqcUt11RZbwD7zDbGTfOZO1yWfB7sluSvnkDbks/AN43zGsVxnEUIVt98GEIr
         Om9XCba0iDxGTSsjmxcqbLVecMv98rThB0ZUz6I9e2ofPqCwvmZ15VVclIA4pF+ng3t2
         mDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OsMXYAdijC0uDZp/tHtNazxNLiVmRNZRgF02jfp0UiY=;
        b=FNARPOSq78WfAsku9Z2HYepC0ii2x8O8t01qvKEGvuV0m/BFADdhsYYyp6OqtRpO88
         CX+OWSg9mUMFeQ3uxEh1EMXAMl5sp6tMKM642JxQsMWZVXcrS49XWYGBKgxC94mHaw3p
         Rxgs4+lniLNSt+a0hdx9Qq/+9ksIsrv8eLbogBrb+qGkttUHmLQQfZ2PY1pOhBS6dC1f
         1rY987hKrh//WfyaMAgOVyrqD+5qm5FX+BLIjkQ+/PIA29/Bk0TPh8g6iMPSccRp69IT
         OsrcD68rh2cUXTBiKaQb1tkSGFA9Ig4ihzHpChqZOsuh8ApsbYzBJyam0fjCEp0SamSv
         BKNw==
X-Gm-Message-State: APf1xPAGdkR/dMdO0cYusrF/T0vRPQQY3nOpVVPjG2YoDmebJnqvCLbD
        0cf2qns2tQZW3qFVZ6RvUc2LSg==
X-Google-Smtp-Source: AH8x2278Cd40skW8ttS3PrZX5IK/siKtzrd8p0aA6mdsPz1IDuO+lSfsB0bvDSR14rDOUgQsegczaA==
X-Received: by 10.101.73.143 with SMTP id r15mr791046pgs.161.1518522549727;
        Tue, 13 Feb 2018 03:49:09 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id o2sm28913697pgq.87.2018.02.13.03.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2018 03:49:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 13 Feb 2018 18:49:04 +0700
Date:   Tue, 13 Feb 2018 18:49:04 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
Message-ID: <20180213114903.GA21015@ash>
References: <20180213012241.187007-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 05:22:15PM -0800, Stefan Beller wrote:
> This is a real take on the first part of the recent RFC[1].
>
> ...
> 
> Duy suggested that we shall not use the repository blindly, but
> should carefully examine whether to pass on an object store or the
> refstore or such[4], which I agree with if it makes sense. This
> series unfortunately has an issue with that as I would not want to
> pass down the `ignore_env` flag separately from the object store, so
> I made all functions that only take the object store to have the raw
> object store as the first parameter, and others using the full
> repository.

Second proposal :) How about you store ignore_env in raw_object_store?
This would not be the first time an object has some configuration
passed in at construction time. And it has a "constructor" now,
raw_object_store_init() (I probably should merge _setup in it too)

The core changes look like this. I have a full commit on top of your
series [1] that keeps sha1_file.c functions take 'struct
raw_object_store' instead.

[1] https://github.com/pclouds/git/tree/object-store-part1

-- 8< --
diff --git a/object-store.h b/object-store.h
index f164c4e5c9..a8bf1738f2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -34,9 +34,13 @@ struct raw_object_store {
 	 * packs.
 	 */
 	unsigned packed_git_initialized : 1;
+
+	unsigned ignore_env : 1;
 };
 #define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_INIT, NULL, NULL, 0, 0, 0 }
 
+void raw_object_store_init(struct raw_object_store *ros, struct repository *r);
+void raw_object_store_setup(struct raw_object_store *ros, char *);
 void raw_object_store_clear(struct raw_object_store *o);
 
 struct packed_git {
diff --git a/object.c b/object.c
index 79c2c447bc..a4534bf4c4 100644
--- a/object.c
+++ b/object.c
@@ -461,6 +461,20 @@ static void free_alt_odbs(struct raw_object_store *o)
 	}
 }
 
+void raw_object_store_init(struct raw_object_store *o,
+			   struct repository *r)
+{
+	/* FIXME: memset? */
+	o->ignore_env = r->ignore_env;
+}
+
+void raw_object_store_setup(struct raw_object_store *o,
+			    char *objectdir)
+{
+	free(o->objectdir);
+	o->objectdir = objectdir;
+}
+
 void raw_object_store_clear(struct raw_object_store *o)
 {
 	free(o->objectdir);
diff --git a/repository.c b/repository.c
index bd2ad578de..ac5863d7e1 100644
--- a/repository.c
+++ b/repository.c
@@ -49,9 +49,9 @@ static void repo_setup_env(struct repository *repo)
 						    !repo->ignore_env);
 	free(repo->commondir);
 	repo->commondir = strbuf_detach(&sb, NULL);
-	free(repo->objects.objectdir);
-	repo->objects.objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
-					    "objects", !repo->ignore_env);
+	raw_object_store_setup(&repo->objects,
+			       git_path_from_env(DB_ENVIRONMENT, repo->commondir,
+						 "objects", !repo->ignore_env));
 	free(repo->graft_file);
 	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
 					     "info/grafts", !repo->ignore_env);
@@ -142,6 +142,8 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 
 	repo->ignore_env = 1;
 
+	raw_object_store_init(&repo->objects, repo);
+
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
 
diff --git a/sha1_file.c b/sha1_file.c
index c3f35914ce..3be58651a1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -677,14 +677,14 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(struct repository *r)
+void prepare_alt_odb(struct raw_object_store *ros)
 {
 	if (r->objects.alt_odb_tail)
 		return;
 
 	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
 
-	if (!r->ignore_env) {
+	if (!ros->ignore_env) {
 		const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
 		if (!alt)
 			alt = "";
-- 8< --


--
Duy
