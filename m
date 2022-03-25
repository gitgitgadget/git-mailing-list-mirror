Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B82CC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347575AbiCYO1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiCYO1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:27:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D061D1108
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:26:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r13so11092107wrr.9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Odg9BWOuMeQ3zwMVE3T3LoTsPcsmjeyRq6bBG78Xces=;
        b=NT6GT61mLbeL/bdBQNyzAr+tXp976AjLhOPNgjGssLXezNXSoPr7CsMKHkNbWOraYQ
         DZBdFft0Va88NzgJg9xGc1/IwztNu02v45ojlZoqKFeo8aGUM56Qrkv0C3YHYU4PKIFY
         CS6tD65Tt/7CPvHklLrUSUGJdTTqODczXfvxvo73PO+8CCQo7TeAujCE7z5g+m19EEoa
         hPb+SmgjZqoLPlu+RKGUxufj6v2hVZS/pn4v9GbSvuIcDLnaKeZAOY3u3KCO5ADNgnKg
         YkyGrrRc/54Td7ZbP9cz7qcNsXUJ09dlroiUu+k3E3RD94/V8Wdsw4hFCnKOzcReQ8ve
         MEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Odg9BWOuMeQ3zwMVE3T3LoTsPcsmjeyRq6bBG78Xces=;
        b=o0DZoR1XxdJ06udJXoTfsLaiWIu5BaDy6HzoUQY0GPHunlsDmQb8ZGWILa9k0v/jF8
         IA2uaW6s3nY/7SdvLGlownRd1d/S4uFplaDXCXwfCgn4JtTOJbjeC455IfK1Rq1YPMZr
         G4FcUeO3xIVjFgbfXD//yFGJtUqiKvmqLiIqvHu6PkAbzDD5KTw0WyhPQm1rJjQ+om3i
         MgX9MlwUtbx6kPIxpjzpNNyTe0oIqfW4DLh7EeMfpgAFQHq8YYX7qkp9BaDwT1ThZ6KX
         hYvKmFxZ/3oIoV7EuwFV/le2GXnysgz8NYEBokaKJED6Ci4t5klvFnHS0TzSKvVKaUYc
         P00g==
X-Gm-Message-State: AOAM530l9e9wTyDPbGIbRDey0ApKvaqRDIIBSIp+OUGeo/2qEN8UuEqi
        o1YVnggfukxxQ71ZagbbGXHT9PnOYwc=
X-Google-Smtp-Source: ABdhPJwtm10noY/RbyPVEZbbN5IHHnPNdk6pzI7neHsEqUkTLnBXbqlOF1uHVuTxRu/+C3w3pyOAVQ==
X-Received: by 2002:adf:a3da:0:b0:205:8fd7:872b with SMTP id m26-20020adfa3da000000b002058fd7872bmr9302574wrb.187.1648218370156;
        Fri, 25 Mar 2022 07:26:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm4536347wmq.6.2022.03.25.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:26:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] pack-objects: lazily set up "struct rev_info", don't leak
Date:   Fri, 25 Mar 2022 15:25:55 +0100
Message-Id: <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding [1] (pack-objects: move revs out of
get_object_list(), 2022-03-22) the "repo_init_revisions()" was moved
to cmd_pack_objects() so that it unconditionally took place for all
invocations of "git pack-objects".

We'd thus start leaking memory, which is easily reproduced in
e.g. git.git by feeding e83c5163316 (Initial revision of "git", the
information manager from hell, 2005-04-07) to "git pack-objects";

    $ echo e83c5163316f89bfbde7d9ab23ca2e25604af290 | ./git pack-objects initial
    [...]
	==19130==ERROR: LeakSanitizer: detected memory leaks

	Direct leak of 7120 byte(s) in 1 object(s) allocated from:
	    #0 0x455308 in __interceptor_malloc (/home/avar/g/git/git+0x455308)
	    #1 0x75b399 in do_xmalloc /home/avar/g/git/wrapper.c:41:8
	    #2 0x75b356 in xmalloc /home/avar/g/git/wrapper.c:62:9
	    #3 0x5d7609 in prep_parse_options /home/avar/g/git/diff.c:5647:2
	    #4 0x5d415a in repo_diff_setup /home/avar/g/git/diff.c:4621:2
	    #5 0x6dffbb in repo_init_revisions /home/avar/g/git/revision.c:1853:2
	    #6 0x4f599d in cmd_pack_objects /home/avar/g/git/builtin/pack-objects.c:3980:2
	    #7 0x4592ca in run_builtin /home/avar/g/git/git.c:465:11
	    #8 0x457d81 in handle_builtin /home/avar/g/git/git.c:718:3
	    #9 0x458ca5 in run_argv /home/avar/g/git/git.c:785:4
	    #10 0x457b40 in cmd_main /home/avar/g/git/git.c:916:19
	    #11 0x562259 in main /home/avar/g/git/common-main.c:56:11
	    #12 0x7fce792ac7ec in __libc_start_main csu/../csu/libc-start.c:332:16
	    #13 0x4300f9 in _start (/home/avar/g/git/git+0x4300f9)

	SUMMARY: LeakSanitizer: 7120 byte(s) leaked in 1 allocation(s).
	Aborted

Narrowly fixing that commit would have been easy, just add call
repo_init_revisions() right before get_object_list(), which is
effectively what was done before that commit.

But an unstated constraint when setting it up early is that it was
needed for the subsequent [2] (pack-objects: parse --filter directly
into revs.filter, 2022-03-22), i.e. we might have a --filter
command-line option, and need to either have the "struct rev_info"
setup when we encounter that option, or later.

Let's just change the control flow so that we'll instead set up the
"struct rev_info" only when we need it. Doing so leads to a bit more
verbosity, but it's a lot clearer what we're doing and why.

We could furthermore combine the two get_object_list() invocations
here by having repo_init_revisions() invoked on &pfd.revs, but I think
clearly separating the two makes the flow clearer. Likewise
redundantly but explicitly (i.e. redundant v.s. a "{ 0 }") "0" to
"have_revs" early in cmd_pack_objects().

This does add the future constraint to opt_parse_list_objects_filter()
that we'll need to adjust this wrapper code if it looks at any other
value of the "struct option" than the "value" member.

But that regression should be relatively easy to spot. I'm
intentionally not initializing the "struct wrap" with e.g. "{ 0 }" so
that various memory sanity checkers would spot that, we just
initialize the "value" in po_filter_cb(). By doing this e.g. we'll die
on e.g. this test if we were to use another member of "opt" in
opt_parse_list_objects_filter()>

    ./t5317-pack-objects-filter-objects.sh -vixd --valgrind-only=3

While we're at it add parentheses around the arguments to the OPT_*
macros in in list-objects-filter-options.h, as we need to change those
lines anyway. It doesn't matter in this case, but is good general
practice.

1. https://lore.kernel.org/git/619b757d98465dbc4995bdc11a5282fbfcbd3daa.1647970119.git.gitgitgadget@gmail.com
2. https://lore.kernel.org/git/97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This is on top of ds/partial-bundle-more: I thought the fix for this
new leak was involved enough to propose it as a commit-on-top rather
than a fixup for a re-roll, especially since aside from the newly
leaked memory I don't think ds/partial-bundle-more is breaking
anything by doing that.

Except that is, interacting badly with my release_revisions() series
in "seen", which currently causes the "linux-leaks" job to fail there:
https://lore.kernel.org/git/cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com/

This is proper fix for the issue the interaction with my topic
revealed (not caused, we just started testing for this leak there),
i.e. it obsoletes the suggestion of adding an UNLEAK() there.

 builtin/pack-objects.c        | 30 +++++++++++++++++++++++++-----
 list-objects-filter-options.h |  8 +++++---
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d39f668ad56..735080a4a95 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3857,6 +3857,23 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
+struct po_filter_data {
+	unsigned have_revs:1;
+	struct rev_info revs;
+};
+
+static int po_filter_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct po_filter_data *data = opt->value;
+	struct option wrap; /* don't initialize! */
+
+	repo_init_revisions(the_repository, &data->revs, NULL);
+	wrap.value = &data->revs.filter;
+	data->have_revs = 1;
+
+	return opt_parse_list_objects_filter(&wrap, arg, unset);
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -3867,7 +3884,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int rev_list_index = 0;
 	int stdin_packs = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
-	struct rev_info revs;
+	struct po_filter_data pfd = { .have_revs = 0 };
 
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -3954,7 +3971,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			      &write_bitmap_index,
 			      N_("write a bitmap index if possible"),
 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
-		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
+		OPT_PARSE_LIST_OBJECTS_FILTER_CB(&pfd, po_filter_cb),
 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action),
@@ -3973,8 +3990,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 
-	repo_init_revisions(the_repository, &revs, NULL);
-
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
@@ -4076,7 +4091,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (revs.filter.choice) {
+	if (pfd.have_revs && pfd.revs.filter.choice) {
 		if (!pack_to_stdout)
 			die(_("cannot use --filter without --stdout"));
 		if (stdin_packs)
@@ -4152,7 +4167,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			add_unreachable_loose_objects();
 	} else if (!use_internal_rev_list) {
 		read_object_list_from_stdin();
+	} else if (pfd.have_revs) {
+		get_object_list(&pfd.revs, rp.nr, rp.v);
 	} else {
+		struct rev_info revs;
+
+		repo_init_revisions(the_repository, &revs, NULL);
 		get_object_list(&revs, rp.nr, rp.v);
 	}
 	cleanup_preferred_base();
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 90e4bc96252..910f4a46e91 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -107,10 +107,12 @@ void parse_list_objects_filter(
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
 
+#define OPT_PARSE_LIST_OBJECTS_FILTER_CB(fo, cb) \
+	OPT_CALLBACK(0, "filter", (fo), N_("args"), \
+		     N_("object filtering"), (cb))
+
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
-	OPT_CALLBACK(0, "filter", fo, N_("args"), \
-	  N_("object filtering"), \
-	  opt_parse_list_objects_filter)
+	OPT_PARSE_LIST_OBJECTS_FILTER_CB((fo), opt_parse_list_objects_filter)
 
 /*
  * Translates abbreviated numbers in the filter's filter_spec into their
-- 
2.35.1.1501.g363d33e530b

