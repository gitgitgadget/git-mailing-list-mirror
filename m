Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F8C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 06:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358422AbiCYGNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 02:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358419AbiCYGNb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 02:13:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E3CBD891
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 23:11:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a8so13314282ejc.8
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z2haNZp8TL0WvYmGnTBm/3T0e/0NU9BID9VL/W2eRf0=;
        b=mc6MoAz0ztASQ6YLtRWS5o/68d90Ab690a6vGg6mJ9vCZNksFHX+MPTw76o0dGiGWm
         jyZNeCMG8PROw6erZzp7CVg/5novvLEJcVi5VLyq4sT6F1tBPT8+iwyaiwuI7rZBeJRk
         aVDUZOY00qryjTjKXWX6x7j1Mh8DqENc8PgFztgZXjvYXT4hg20Fgmwssq2tCOsXz4If
         dF+FNUjHLehJBu2/nT1ndFREyZ+boSZByHJvL1Lq028QFP+KSYcy3c+6MDAXgnXcpIBz
         sgxKuFZo+sDEJvekJyWNtrqyz7c4+c5LjREHjPIdv6DB9H2cbRuqqqSVlEDZOWaiH90y
         fz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z2haNZp8TL0WvYmGnTBm/3T0e/0NU9BID9VL/W2eRf0=;
        b=ix2zYjIg3SB1tjGTwziF58lGmbyh0UoVWgh9OQY3L96a8pdWjK/lqONipVLEEhiu+6
         z3BNPhjd6loTdzH3j0ZE6j/XfDkHHM3G3QRQNo91dJyvwSP/davo+BxpwrHBPaZD0GUE
         5p2xFIqxR5Eplf8go8j2ovKd/6QUcmm995wlaO5unxhOHsLSRC5Oy4plYrl6IeWrXZTE
         9a/EKbjo/gXCRufywNpJIVpfqbCh/7drRl8gQkw7KWy/wkyLUB1K7gZQ1U4JR9IelKrN
         EV5Y8MnIrH245eFEBuZpDMKt3mwiS12mb+57GiBilTVg4RgJ2O3ej4kuJNIo/AXyoxGk
         rHfw==
X-Gm-Message-State: AOAM530Gj6arLFMjA4WGWVOQVL84/ZIHtqXF22TeR1fS7lI6oqP7USBA
        aLP82l2eqsb/T7D9GcO8S8pVQknQW2E=
X-Google-Smtp-Source: ABdhPJyVs9uil1GSAuGo0GllEgR5/y9pRJY56FkZUbiuooiXedA6xGe1t4UAvrbMyXCQp3sOAi9Oaw==
X-Received: by 2002:a17:907:a089:b0:6df:f619:6f55 with SMTP id hu9-20020a170907a08900b006dff6196f55mr9601764ejc.661.1648188715725;
        Thu, 24 Mar 2022 23:11:55 -0700 (PDT)
Received: from szeder.dev (84-236-109-113.pool.digikabel.hu. [84.236.109.113])
        by smtp.gmail.com with ESMTPSA id bm24-20020a170906c05800b006d58518e55fsm1916003ejb.46.2022.03.24.23.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 23:11:55 -0700 (PDT)
Date:   Fri, 25 Mar 2022 07:11:49 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] core.fsync: new option to harden references
Message-ID: <20220325061149.GA2571@szeder.dev>
References: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
 <47dd79106b93bb81750320d50ccaa74c24aacd28.1646992380.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47dd79106b93bb81750320d50ccaa74c24aacd28.1646992380.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 11, 2022 at 10:58:59AM +0100, Patrick Steinhardt wrote:
> When writing both loose and packed references to disk we first create a
> lockfile, write the updated values into that lockfile, and on commit we
> rename the file into place. According to filesystem developers, this
> behaviour is broken because applications should always sync data to disk
> before doing the final rename to ensure data consistency [1][2][3]. If
> applications fail to do this correctly, a hard crash of the machine can
> easily result in corrupted on-disk data.
> 
> This kind of corruption can in fact be easily observed with Git when the
> machine hard-resets shortly after writing references to disk. On
> machines with ext4, this will likely lead to the "empty files" problem:
> the file has been renamed, but its data has not been synced to disk. The
> result is that the reference is corrupt, and in the worst case this can
> lead to data loss.
> 
> Implement a new option to harden references so that users and admins can
> avoid this scenario by syncing locked loose and packed references to
> disk before we rename them into place.

In 't5541-http-push-smart.sh' there is a test case called 'push 2000
tags over http', which does pretty much what it's title says.  This
patch makes that test case significantly slower.


diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ca50f8b18..d7e94cb791 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -415,7 +415,7 @@ test_expect_success CMDLINE_LIMIT 'push 2000 tags over http' '
 	  sort |
 	  sed "s|.*|$sha1 refs/tags/really-long-tag-name-&|" \
 	  >.git/packed-refs &&
-	run_with_limited_cmdline git push --mirror
+	run_with_limited_cmdline /usr/bin/time git push --mirror
 '
 
 test_expect_success GPG 'push with post-receive to inspect certificate' '

Before this patch (bc22d845c4^) 'time' reports:

  3.62user 0.03system 0:03.83elapsed 95%CPU (0avgtext+0avgdata 11904maxresident)k
  0inputs+312outputs (0major+4597minor)pagefaults 0swaps

With this patch (bc22d845c4):

  3.56user 0.04system 0:33.60elapsed 10%CPU (0avgtext+0avgdata 11832maxresident)k
  0inputs+320outputs (0major+4578minor)pagefaults 0swaps

And the total runtime of the whole test script increases from 8-9s to
37-39s.


I wonder whether we should relax the fsync options for this test case.

> 
> [1]: https://thunk.org/tytso/blog/2009/03/15/dont-fear-the-fsync/
> [2]: https://btrfs.wiki.kernel.org/index.php/FAQ (What are the crash guarantees of overwrite-by-rename)
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/ext4.rst (see auto_da_alloc)
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> 
> Hi,
> 
> here's my updated patch series which implements syncing of refs. It
> applies on top of Neeraj's v6 of "A design for future-proofing fsync()
> configuration".
> 
> I've simplified these patches a bit:
> 
>     - I don't distinguishing between "loose" and "packed" refs anymore.
>       I agree with Junio that it's probably not worth it, but we can
>       still reintroduce the split at a later point without breaking
>       backwards compatibility if the need comes up.
> 
>     - I've simplified the way loose refs are written to disk so that we
>       now sync them when before we close their files. The previous
>       implementation I had was broken because we tried to sync after
>       closing.
> 
> Because this really only changes a few lines of code I've also decided
> to squash together the patches into a single one.
> 
> Patrick
> 
>  Documentation/config/core.txt | 1 +
>  cache.h                       | 7 +++++--
>  config.c                      | 1 +
>  refs/files-backend.c          | 1 +
>  refs/packed-backend.c         | 3 ++-
>  5 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 37105a7be4..812cca7de7 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -575,6 +575,7 @@ but risks losing recent work in the event of an unclean system shutdown.
>  * `index` hardens the index when it is modified.
>  * `objects` is an aggregate option that is equivalent to
>    `loose-object,pack`.
> +* `reference` hardens references modified in the repo.
>  * `derived-metadata` is an aggregate option that is equivalent to
>    `pack-metadata,commit-graph`.
>  * `committed` is an aggregate option that is currently equivalent to
> diff --git a/cache.h b/cache.h
> index cde0900d05..033e5b0779 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1005,6 +1005,7 @@ enum fsync_component {
>  	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
>  	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
>  	FSYNC_COMPONENT_INDEX			= 1 << 4,
> +	FSYNC_COMPONENT_REFERENCE		= 1 << 5,
>  };
>  
>  #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
> @@ -1017,7 +1018,8 @@ enum fsync_component {
>  				  FSYNC_COMPONENTS_DERIVED_METADATA | \
>  				  ~FSYNC_COMPONENT_LOOSE_OBJECT)
>  
> -#define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS)
> +#define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS | \
> +				    FSYNC_COMPONENT_REFERENCE)
>  
>  #define FSYNC_COMPONENTS_ADDED (FSYNC_COMPONENTS_COMMITTED | \
>  				FSYNC_COMPONENT_INDEX)
> @@ -1026,7 +1028,8 @@ enum fsync_component {
>  			      FSYNC_COMPONENT_PACK | \
>  			      FSYNC_COMPONENT_PACK_METADATA | \
>  			      FSYNC_COMPONENT_COMMIT_GRAPH | \
> -			      FSYNC_COMPONENT_INDEX)
> +			      FSYNC_COMPONENT_INDEX | \
> +			      FSYNC_COMPONENT_REFERENCE)
>  
>  /*
>   * A bitmask indicating which components of the repo should be fsynced.
> diff --git a/config.c b/config.c
> index eb75f65338..3c9b6b589a 100644
> --- a/config.c
> +++ b/config.c
> @@ -1333,6 +1333,7 @@ static const struct fsync_component_name {
>  	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
>  	{ "index", FSYNC_COMPONENT_INDEX },
>  	{ "objects", FSYNC_COMPONENTS_OBJECTS },
> +	{ "reference", FSYNC_COMPONENT_REFERENCE },
>  	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
>  	{ "committed", FSYNC_COMPONENTS_COMMITTED },
>  	{ "added", FSYNC_COMPONENTS_ADDED },
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f59589d6cc..6521ee8af5 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1787,6 +1787,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
>  	fd = get_lock_file_fd(&lock->lk);
>  	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
>  	    write_in_full(fd, &term, 1) < 0 ||
> +	    fsync_component(FSYNC_COMPONENT_REFERENCE, get_lock_file_fd(&lock->lk)) < 0 ||
>  	    close_ref_gently(lock) < 0) {
>  		strbuf_addf(err,
>  			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 27dd8c3922..9d704ccd3e 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1262,7 +1262,8 @@ static int write_with_updates(struct packed_ref_store *refs,
>  		goto error;
>  	}
>  
> -	if (close_tempfile_gently(refs->tempfile)) {
> +	if (fsync_component(FSYNC_COMPONENT_REFERENCE, get_tempfile_fd(refs->tempfile)) ||
> +	    close_tempfile_gently(refs->tempfile)) {
>  		strbuf_addf(err, "error closing file %s: %s",
>  			    get_tempfile_path(refs->tempfile),
>  			    strerror(errno));
> -- 
> 2.35.1
> 


