Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE3CC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbiCDSdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiCDSdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D61D3AEB
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p9so13898133wra.12
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esYQ+86wsLh8U9Lx+I44lNo2zbABulL0Ff2dDV8rZjI=;
        b=cIEDM/ki4YUgIjEKg2nekBALPWaWLc0K/K6iDIdqJDpUBkv28da8rHjy7+mjhvzZNy
         iCpMgNZgIFAQmDn9vyMW1SslbJvF57iHJ/PX6S/KenY2uTYzfM+NkS7J8/ksqVEJc3bQ
         LMyy9O9rvCGkGHv2gGsH2pAr0aUDFNUaGysOfzxVG+pcOuiRvcgym8FahK1Kp3B+ybws
         Qj2GQgKmLTaQJTeKvJdgSeugU33FSYsewa6RobkybUkc4H9F/Yu2TAMsX7g52G8QGkwn
         1SmlRJCydZuDFCE6YEt5rPvEm9Qu6lAyT7psyYArnV3BfeuTMKSiSTNq8QEhmwhWTUNx
         9Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esYQ+86wsLh8U9Lx+I44lNo2zbABulL0Ff2dDV8rZjI=;
        b=6MPk4Mp0LnAWMOuHHuAkbcu1drcMWmmbAexSX7rIuWednONRK6CMx70x1bERKF6KZP
         tScg6T3sO12wYJwGIPpFUHgG4qCQ3AKCnE9BOkHdT2RFCk6qZJVdZJnXdSarXBl0jU5u
         qTxtdNN9gTPXK3uzhNmwrNEJdpQOpdvL8hkUZmncsJnpBB0fW8r2kYlKnloONpalk0VW
         h30FHB/sAiMXjdaB50OQgx6aBDQrrlCpQUK0ibyTYKJUH8WDxH03kU+h23nhzCcqeJ2E
         pEQX4L94Tkc8WZ8kCZ9b96Aw+coFEDTDJ36zWbteGMTHnZscZ3urOKFqVNaiWwEOy/R2
         iM3Q==
X-Gm-Message-State: AOAM531t8C9xYmLVuIsjhSfcVoESfPeIIa0CZiPpnPI7PVjzVNDZoN5n
        AQDNPRmqyyNhFdnWfI7S8A2aEPoeywaeuA==
X-Google-Smtp-Source: ABdhPJybBwYSX5tEN1Bt5pa31pebqWXwNA1sdjTUjZQSWS1MnXxja2LyvMDmjUEGPZyVJRqwtaNwEg==
X-Received: by 2002:adf:e98c:0:b0:1f0:2f5c:2e9 with SMTP id h12-20020adfe98c000000b001f02f5c02e9mr40236wrm.356.1646418739936;
        Fri, 04 Mar 2022 10:32:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/14] tree-wide: small fixes for memory leaks
Date:   Fri,  4 Mar 2022 19:32:03 +0100
Message-Id: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a collection of various otherwise unrelated tree-wide fixes
for memory leaks. See v1 for a (short) overview:
https://lore.kernel.org/git/cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com/

This re-roll addresses issues Derrick Stolee noted. There's a trivial
commit-message change in 1/14, and a rather trivial (but important)
change in how a variable is incremented in 7/14.

That change to v1 is actually small, but the range-diff is big since
"git diff" picks a different way to "anchor" the diff as a result.

Ævar Arnfjörð Bjarmason (14):
  index-pack: fix memory leaks
  merge-base: free() allocated "struct commit **" list
  diff.c: free "buf" in diff_words_flush()
  urlmatch.c: add and use a *_release() function
  remote-curl.c: free memory in cmd_main()
  bundle: call strvec_clear() on allocated strvec
  transport: stop needlessly copying bundle header references
  submodule--helper: fix trivial leak in module_add()
  commit-graph: fix memory leak in misused string_list API
  commit-graph: stop fill_oids_from_packs() progress on error and free()
  lockfile API users: simplify and don't leak "path"
  range-diff: plug memory leak in common invocation
  range-diff: plug memory leak in read_patches()
  repository.c: free the "path cache" in repo_clear()

 apply.c                     |  7 ++++++-
 apply.h                     |  2 ++
 builtin/bundle.c            |  1 +
 builtin/commit-graph.c      |  6 +++---
 builtin/config.c            |  2 +-
 builtin/index-pack.c        |  5 +++++
 builtin/merge-base.c        |  5 ++++-
 builtin/sparse-checkout.c   |  3 +--
 builtin/submodule--helper.c |  5 ++++-
 commit-graph.c              | 18 +++++++++++-------
 commit-graph.h              |  2 +-
 credential.c                |  1 +
 diff.c                      |  1 +
 path.h                      | 14 --------------
 range-diff.c                | 30 +++++++++++++-----------------
 remote-curl.c               | 12 ++++++++----
 repository.c                | 16 ++++++++++++++++
 repository.h                | 14 +++++++++++++-
 transport.c                 | 25 ++++++++++++++++---------
 urlmatch.c                  |  5 +++++
 urlmatch.h                  |  1 +
 21 files changed, 113 insertions(+), 62 deletions(-)

Range-diff against v1:
 1:  bcba06e1d28 !  1:  f46af9ad13f index-pack: fix memory leaks
    @@ Commit message
     
         Fix various memory leaks in "git index-pack", due to how tightly
         coupled this command is with the revision walking this doesn't make
    -    any new tests pass, but e.g. this now passes, and had several failures before:
    +    any new tests pass.
    +
    +    But e.g. this now passes, and had several failures before, i.e. we
    +    still have failures in tests 3, 5 etc., which are being skipped here.
     
             ./t5300-pack-object.sh --run=1-2,4,6-27,30-42
     
    -    it is a bit odd that we'll free "opts.anomaly", since the "opts" is a
    +    It is a bit odd that we'll free "opts.anomaly", since the "opts" is a
         "struct pack_idx_option" declared in pack.h. In pack-write.c there's a
         reset_pack_idx_option(), but it only wipes the contents, but doesn't
         free() anything.
 2:  4c28f056ec2 =  2:  4ee2881adfb merge-base: free() allocated "struct commit **" list
 3:  5d2793039ad =  3:  90517a05582 diff.c: free "buf" in diff_words_flush()
 4:  7f7077e8476 =  4:  d51f6ae0963 urlmatch.c: add and use a *_release() function
 5:  8891fd44c7c =  5:  f0a26db8a87 remote-curl.c: free memory in cmd_main()
 6:  52e2c2a8281 =  6:  c636770b5d6 bundle: call strvec_clear() on allocated strvec
 7:  be62ca89bf5 !  7:  b3f7753a790 transport: stop needlessly copying bundle header references
    @@ transport.c: struct bundle_transport_data {
      	unsigned get_refs_from_bundle_called : 1;
      };
      
    +-static struct ref *get_refs_from_bundle(struct transport *transport,
    +-					int for_push,
    +-					struct transport_ls_refs_options *transport_options)
     +static void get_refs_from_bundle_inner(struct transport *transport)
    + {
    + 	struct bundle_transport_data *data = transport->data;
    +-	struct ref *result = NULL;
    +-	int i;
    +-
    +-	if (for_push)
    +-		return NULL;
    + 
    + 	data->get_refs_from_bundle_called = 1;
    + 
    +@@ transport.c: static struct ref *get_refs_from_bundle(struct transport *transport,
    + 		die(_("could not read bundle '%s'"), transport->url);
    + 
    + 	transport->hash_algo = data->header.hash_algo;
    ++}
    ++
    ++static struct ref *get_refs_from_bundle(struct transport *transport,
    ++					int for_push,
    ++					struct transport_ls_refs_options *transport_options)
     +{
     +	struct bundle_transport_data *data = transport->data;
    ++	struct ref *result = NULL;
    ++	int i;
     +
    -+	if (data->fd > 0)
    -+		close(data->fd);
    -+	data->fd = read_bundle_header(transport->url, &data->header);
    -+	if (data->fd < 0)
    -+		die(_("could not read bundle '%s'"), transport->url);
    -+
    -+	transport->hash_algo = data->header.hash_algo;
    -+}
    ++	if (for_push)
    ++		return NULL;
     +
    - static struct ref *get_refs_from_bundle(struct transport *transport,
    - 					int for_push,
    - 					struct transport_ls_refs_options *transport_options)
    -@@ transport.c: static struct ref *get_refs_from_bundle(struct transport *transport,
    - 	if (for_push)
    - 		return NULL;
    - 
    --	data->get_refs_from_bundle_called = 1;
    --
    --	if (data->fd > 0)
    --		close(data->fd);
    --	data->fd = read_bundle_header(transport->url, &data->header);
    --	if (data->fd < 0)
    --		die(_("could not read bundle '%s'"), transport->url);
    --
    --	transport->hash_algo = data->header.hash_algo;
     +	get_refs_from_bundle_inner(transport);
      
      	for (i = 0; i < data->header.references.nr; i++) {
      		struct string_list_item *e = data->header.references.items + i;
     @@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
    - 	if (transport->progress)
      		strvec_push(&extra_index_pack_args, "-v");
      
    --	if (!data->get_refs_from_bundle_called)
    + 	if (!data->get_refs_from_bundle_called)
     -		get_refs_from_bundle(transport, 0, NULL);
    -+	if (!data->get_refs_from_bundle_called++)
     +		get_refs_from_bundle_inner(transport);
      	ret = unbundle(the_repository, &data->header, data->fd,
      		       &extra_index_pack_args);
 8:  122fdf7bb41 =  8:  af3ca2f0b5f submodule--helper: fix trivial leak in module_add()
 9:  b5512deb26f =  9:  3fadb265d13 commit-graph: fix memory leak in misused string_list API
10:  27f0883e8d8 = 10:  27f5190ce59 commit-graph: stop fill_oids_from_packs() progress on error and free()
11:  cc8beed10be = 11:  217754edc62 lockfile API users: simplify and don't leak "path"
12:  6d13c2530db = 12:  148382d9529 range-diff: plug memory leak in common invocation
13:  e7b823f70c8 = 13:  c6e61b85491 range-diff: plug memory leak in read_patches()
14:  954de5191c3 = 14:  d70a4394f2b repository.c: free the "path cache" in repo_clear()
-- 
2.35.1.1248.gb68c9165ad8

