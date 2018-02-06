Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C341F404
	for <e@80x24.org>; Tue,  6 Feb 2018 23:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754182AbeBFXq7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 18:46:59 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:41984 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbeBFXq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 18:46:57 -0500
Received: by mail-pf0-f170.google.com with SMTP id b25so1347622pfd.9
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 15:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RlLN3CjP3QwtabYN9iUvqfV6y2+QrdqSxhXx4X/LpXA=;
        b=ZcMiEsAdmsK/RpOmkd3Jww9h5aiArlp3tJu7n9N6fVaKmcI2k4Dts93OS7YD0UrQCO
         gjEzsoeXAcMJ/Rx2A4WXRmHTlbdKRxM2igpO9BjQbssRB3Yy5pgeY8vicOZynnVFMFQW
         VcvfLTmBEpFSr7qyfnQWQfMN1WtM0mHkRoQ7vrPly3njlfd+R/nNc7d2jEYAczOeOBAr
         NOUSMQDsEl12Pajk8hZYuEwLG/Mj6uIuvFMgiA4w5t+Us2y2YWSbyiciJ5nHnBpLAU20
         wTa+/lPehyeV7dgTN3GSqEA/fCzHQiAI4caS7Y0bAusPqhTfT7LAk0JtwuFZce0s4efe
         OnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RlLN3CjP3QwtabYN9iUvqfV6y2+QrdqSxhXx4X/LpXA=;
        b=dIOwCXS68EH4ADlXE1Gf8/dgf4JmKkMBvIpVaJTnes03di4uE60Jct9V0NoJsBnSCK
         w3Q4EoHyiFAU0O07Pls2O1BxkW19bIPGx5nW+M9o/g9neYzv/MUMskzdKNA/ujlGdFNr
         S+G+RfE/mQyTAF2SWqyM0xdXzP6Cyf/vAi97Jfr7Fk028YeRVZ6YMzSVFYrIJNUz3N/v
         6Ic/vsTgrbBhLt7zRYFKUpzPhEmEsjU+gRM5SVnjz9a0vUQztuKLzRR7/IxcrtTNFNiT
         WjHA3IuWRTi+A42PNmTwkR2zMemmnLg6OLl2zmo4CsFJF49HEimu9kfZBFPMiyGULv90
         l9mg==
X-Gm-Message-State: APf1xPAA15iGH3DjGYh9aEWOASyi2kPlkxysHVnM1LWLJasIbf2FW9MY
        wkp3qSpOeHE2irph2BtjpkymR7Th2Iw=
X-Google-Smtp-Source: AH8x227DN6pMEn51NJaZtv5OYzwhUuytPPQHU4CXBLDfezEVvG/wWAEtFCToHtfJTw+ZnDrcQPPvPg==
X-Received: by 10.98.219.68 with SMTP id f65mr3390851pfg.25.1517960816634;
        Tue, 06 Feb 2018 15:46:56 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c19sm297955pfk.22.2018.02.06.15.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 15:46:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository object
Date:   Tue,  6 Feb 2018 15:46:50 -0800
Message-Id: <20180206234650.126865-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <CAGZ79kYYZ-dmHA5jZeKTk9TFxn+7_zzxLPR7jNS4X8+K-JU_dg@mail.gmail.com>
References: <CAGZ79kYYZ-dmHA5jZeKTk9TFxn+7_zzxLPR7jNS4X8+K-JU_dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It took some time to do fixes in such a long series, mostl of my time spent in
rebasing and being extra careful about selecting the right commit to edit.
Based on feedback so far I have queued the changes below.
The changes are also available at https://github.com/stefanbeller/git/tree/object-store-v2
I do not plan on sending out this series today, as I would want
to wait a couple of days between resending for such a large series.

I think I addressed all issues raised, except finishing the memleak
issues, which I'll continue working on.

Stefan

diff --git c/object-store.h w/object-store.h
index 62763b8412..a6051ccb73 100644
--- c/object-store.h
+++ w/object-store.h
@@ -60,6 +60,8 @@ struct raw_object_store {
 #define RAW_OBJECT_STORE_INIT \
 	{ NULL, MRU_INIT, ALTERNATES_INIT, { NULL, 0, 0, 0 }, 0, 0, 0 }
 
+extern void raw_object_store_clear(struct raw_object_store *o);
+
 struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
diff --git c/object.c w/object.c
index 2fe5fac3ce..f13f9d97f4 100644
--- c/object.c
+++ w/object.c
@@ -440,3 +440,20 @@ void clear_object_flags(unsigned flags)
 			obj->flags &= ~flags;
 	}
 }
+
+
+void raw_object_store_clear(struct raw_object_store *o)
+{
+	/* TODO: free alt_odb_list/tail */
+	/* TODO: clear packed_git, packed_git_mru */
+}
+
+void object_parser_clear(struct object_parser *o)
+{
+	/*
+	 * TOOD free objects in o->obj_hash.
+	 *
+	 * As objects are allocated in slabs (see alloc.c), we do
+	 * not need to free each object, but each slab instead.
+	 */
+}
diff --git c/object.h w/object.h
index 900f1b6611..0b42b09322 100644
--- c/object.h
+++ w/object.h
@@ -43,6 +43,8 @@ extern struct alloc_state the_repository_object_state;
 	&the_repository_object_state, \
 	0 }
 
+extern void object_parser_clear(struct object_parser *o);
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git c/repository.c w/repository.c
index 64fb6d8b34..d5ea158b26 100644
--- c/repository.c
+++ w/repository.c
@@ -141,6 +141,9 @@ static void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
 
+	raw_object_store_clear(&repo->objects);
+	object_parser_clear(&repo->parsed_objects);
+
 	if (repo->config) {
 		git_configset_clear(repo->config);
 		FREE_AND_NULL(repo->config);
diff --git c/submodule.c w/submodule.c
index 9bd337ce99..c9634f84ef 100644
--- c/submodule.c
+++ w/submodule.c
@@ -494,10 +494,7 @@ static int open_submodule(struct repository *out, const char *path)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (submodule_to_gitdir(&sb, path))
-		return -1;
-
-	if (repo_init(out, sb.buf, NULL)) {
+	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
 		strbuf_release(&sb);
 		return -1;
 	}
diff --git c/t/t5531-deep-submodule-push.sh w/t/t5531-deep-submodule-push.sh
index 8b2aa5a0f4..39cb2c1c34 100755
--- c/t/t5531-deep-submodule-push.sh
+++ w/t/t5531-deep-submodule-push.sh
@@ -308,22 +308,6 @@ test_expect_success 'submodule entry pointing at a tag is error' '
 	test_i18ngrep "is a tag, not a commit" err
 '
 
-test_expect_success 'replace ref does not interfere with submodule access' '
-	test_commit -C work/gar/bage one &&
-	test_commit -C work/gar/bage two &&
-	git -C work/gar/bage reset HEAD^^ &&
-	git -C work/gar/bage replace two one &&
-	test_when_finished "git -C work/gar/bage replace -d two" &&
-
-	test_commit -C work/gar/bage three &&
-	git -C work add gar/bage &&
-	git -C work commit -m "advance submodule" &&
-
-	git -C work push --recurse-submodules=on-demand ../pub.git master 2>err &&
-	! grep error err &&
-	! grep fatal err
-'
-
 test_expect_success 'push fails if recurse submodules option passed as yes' '
 	(
 		cd work/gar/bage &&
