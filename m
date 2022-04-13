Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E60C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 15:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiDMPbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiDMPbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 11:31:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42E264703
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:28:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so2804786edu.10
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Gk2PsMs59e0bhdEnsHqp5koRqvsbTMDAnoUnM5ueNEo=;
        b=fA4+xcjy0qfM7uaSSV6jfEIPddXsPYoeeNsiZzK9kYqkXIlI422noHuLc/Mi2jd2kv
         +wQN5254AMOyLTwhgCyw2yjSZcJD8aPPqSCW5bmqtZ5Tp/MgQ4YooXmqB45UNEy7xv2+
         JDO0WJjOUKqLJHshk7j3QjzibLJ0yyLRn8TNr/CH9e73Ja0BA+MI4R6f1VmYDmwYCIiL
         N5Ifr11aXTAiuzL6rJnvKNe56czzYKGzNh6ZbW0rloMM/VkYT5k4A2SEC9aeDEeuUEST
         hPNMDWHB+JzIq5SFfIck9Yop3TqrYqdLlMK95VgKnEcfYqoXq6Oc+fRUi+HnBXW9NN9R
         IKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Gk2PsMs59e0bhdEnsHqp5koRqvsbTMDAnoUnM5ueNEo=;
        b=OQ8UVKXkIVPU0U7wkvUP7jy3CLiHrg59lAECnBl7caCVcX/rx9ZdTql/ErDsjk7dQO
         zckMEUH+LSvIZom7ahQ7K7zKhaqsz8/LG/TyWXibGmgeNRu5vaQVEGOjJauVITZs67Co
         OSK7A68P2rINmll4C1mAuhBs7lXlrsrvMdy27H9uV2fpDZ2aPhIzvLKxFxjIkgBHXJpx
         oegGoNNGhYFtZ4GkZt6zNO5c1KSSskWYSlpq2uJHyf8FnZfKof5u6FC8zaDzdEo5c/Zp
         wfykvMhfIIurs7E+9gYFjVAayjIlQc74BfEbU25c35RqZmwDneHn1+5KNhEVIloX3brT
         UfgQ==
X-Gm-Message-State: AOAM531zsXJg2DlUnssFWk7Awq2AnrbaxIFw7uGyp3H6DfmDOgQOn4Zh
        Rx6D6/jAo5hu8tEr5iF+NEFI+tArTHo=
X-Google-Smtp-Source: ABdhPJyf+488kQYknw4VEgBCTICD/1cZlvPPsuKjEEMizTdS7HYYZJhAahmKoBy7G6/L5jZSGPlgVQ==
X-Received: by 2002:a05:6402:5193:b0:419:3d19:ce9e with SMTP id q19-20020a056402519300b004193d19ce9emr43998212edd.199.1649863724009;
        Wed, 13 Apr 2022 08:28:44 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe680dbfcsm105712ejc.43.2022.04.13.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:28:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neevC-0057CW-PN;
        Wed, 13 Apr 2022 17:28:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 0/4] Importing and exporting stashes to refs
Date:   Wed, 13 Apr 2022 17:25:41 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220407215352.3491567-1-sandals@crustytoothpaste.net>
Message-ID: <220413.86mtgpf1ed.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 07 2022, brian m. carlson wrote:

> * Use oid_array.

It looks like only 1/2 of the functions using the manual
not-quite-an-oid_array were converted. Here's a diff to squash for the
other one:

diff --git a/builtin/stash.c b/builtin/stash.c
index e4b99188836..7d5493581e6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1925,8 +1925,7 @@ static int do_export_stash(const char *ref, int argc, const char **argv)
 	struct object_id base;
 	struct object_context unused;
 	struct commit *prev;
-	struct object_id *items = NULL;
-	int nitems = 0, nalloc = 0;
+	struct oid_array items = OID_ARRAY_INIT;
 	int res = 0;
 	int i;
 	struct strbuf revision = STRBUF_INIT;
@@ -1954,14 +1953,16 @@ static int do_export_stash(const char *ref, int argc, const char **argv)
 		 * Find each specified stash, and load data into the array.
 		 */
 		for (i = 0; i < argc; i++) {
-			ALLOC_GROW_BY(items, nitems, 1, nalloc);
+			struct object_id oid;
+
 			if (parse_revision(&revision, argv[i], 1) ||
 			    get_oid_with_context(the_repository, revision.buf,
 						 GET_OID_QUIETLY | GET_OID_GENTLY,
-						 &items[i], &unused)) {
+						 &oid, &unused)) {
 				res = error(_("unable to find stash entry %s"), argv[i]);
 				goto out;
 			}
+			oid_array_append(&items, &oid);
 		}
 	} else {
 		/*
@@ -1978,8 +1979,7 @@ static int do_export_stash(const char *ref, int argc, const char **argv)
 						 GET_OID_QUIETLY | GET_OID_GENTLY,
 						 &oid, &unused))
 				break;
-			ALLOC_GROW_BY(items, nitems, 1, nalloc);
-			oidcpy(&items[i], &oid);
+			oid_array_append(&items, &oid);
 		}
 	}
 
@@ -1988,14 +1988,15 @@ static int do_export_stash(const char *ref, int argc, const char **argv)
 	 * but where their first parents form a chain to our original empty
 	 * base commit.
 	 */
-	for (i = nitems - 1; i >= 0; i--) {
+	for (i = items.nr - 1; i >= 0; i--) {
 		struct commit_list *parents = NULL;
 		struct commit_list **next = &parents;
 		struct object_id out;
+		const struct object_id *oid = items.oid + i;
 
 		next = commit_list_append(prev, next);
-		next = commit_list_append(lookup_commit_reference(the_repository, &items[i]), next);
-		res = write_commit_with_parents(&out, &items[i], parents);
+		next = commit_list_append(lookup_commit_reference(the_repository, oid), next);
+		res = write_commit_with_parents(&out, oid, parents);
 		if (res)
 			goto out;
 		prev = lookup_commit_reference(the_repository, &out);
@@ -2006,7 +2007,7 @@ static int do_export_stash(const char *ref, int argc, const char **argv)
 		puts(oid_to_hex(&prev->object.oid));
 out:
 	strbuf_release(&revision);
-	free(items);
+	oid_array_clear(&items);
 
 	return res;
 }
