Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F48C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbiCKQVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbiCKQVr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:21:47 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEAB1D0860
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:20:43 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id h7so6308512ile.1
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5fNeKhUEd7vxQYo6TccyxU5K9Ji2MUNDspwapGwzAHo=;
        b=jr1dk6w5t9b5zT4FymCTnavgVcwlwGPLF98yzgTXN1XWi4uXYBRgmG7hGbHR6b7Www
         shCN2Dz2HfjL+usNtH6T6EA7FaK0p7cZ57Tw1txfMSKZPpKhVbkk2AYXoKC6QWNhwEOG
         az/N+rqo31kxlDsmw3r0nFyTtjj3XeVdckxYuwU0zqDShyr5/scQjP4gLvDoEmqnY/KL
         JhxiBsBC8ReeUxi86teUj5MgXtSQXUsCnF0M8MmbY53E8wlkCdakQJGZ4n5MYFELDwWw
         bVAjJlXv8HPOReKR8WmTOAK73HFJRth+X7rZCzLJicX+/kQu5rxkQ7RODArVhUKq+FH3
         UjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5fNeKhUEd7vxQYo6TccyxU5K9Ji2MUNDspwapGwzAHo=;
        b=J1UrSZSJf7UCvObowxmof5AWoIExEqw5CipFR+VAfnBbXavXHuwmvBfEguoszLDbvs
         XdefCLPrlqRtuM+yvmzkYBUlDJkKpnlZf9u+fcufFybWdRDSDxFXwTphnrvgnjuE8Opg
         1bu9UojCNEEsb8itRvpa4C1MK1edNqEwEtQ7Q98HpWkfYnhdZvGn6WzmbG648hOe2Exe
         d72PE3gJJX6hA7VrCG1Yti6xGPreMobOOUrhFgMPyRA15VsJairhPEw1DyJbRbdZ2++Z
         vO6wig/yp+uWX69ery5keHdIhzzdN0yBBbM1gFcDXTPyirKZV+udHY6hKhxqWrrwzbBS
         Wakw==
X-Gm-Message-State: AOAM5307wMpm5mTsDTZVNnEFY8rLtcF4kVoVQULBeizTD+Z+qE9nRcJK
        /ftOeDkCvjAkIddvmIlwia4deH7C+N5+tdkY
X-Google-Smtp-Source: ABdhPJyr7aZLtsPzMnx4a7h3YZMLXcMyw+ALsy2Cokl1z/0pWbJP1Q4fqNQVDAWux99zIZV89ZlvDw==
X-Received: by 2002:a92:c810:0:b0:2c6:ba9:6a42 with SMTP id v16-20020a92c810000000b002c60ba96a42mr7986349iln.275.1647015642645;
        Fri, 11 Mar 2022 08:20:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s13-20020a6bdc0d000000b006408888551dsm4291715ioc.8.2022.03.11.08.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:20:42 -0800 (PST)
Date:   Fri, 11 Mar 2022 11:20:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] repack: add config to skip updating server info
Message-ID: <Yit22Xcs6iF4MVB7@nand.local>
References: <659d5528df56f6b9aece6b1f3c4e2e5a4ae04e1e.1646996936.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <659d5528df56f6b9aece6b1f3c4e2e5a4ae04e1e.1646996936.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 11, 2022 at 12:09:30PM +0100, Patrick Steinhardt wrote:
> diff --git a/Documentation/config/repack.txt b/Documentation/config/repack.txt
> index 9c413e177e..22bfc26afc 100644
> --- a/Documentation/config/repack.txt
> +++ b/Documentation/config/repack.txt
> @@ -25,3 +25,6 @@ repack.writeBitmaps::
>  	space and extra time spent on the initial repack.  This has
>  	no effect if multiple packfiles are created.
>  	Defaults to true on bare repos, false otherwise.
> +
> +repack.updateServerInfo::
> +	If set to false, git-repack will not run git-update-server-info.

Can you clarify here what the default value of this config variable is,
and how it interacts with repack's `-n` flag? E.g., something along the
lines of:

    repack.updateServerInfo::
        If set to false, linkgit:git-repack[1] will not run
        linkgit:git-update-serve-info[1]. Defaults to true. Can be
        overridden when true by the `-n` option of
        linkgit:git-repack[1].

Perhaps a little verbose, but I think it leaves less ambiguity about
what this new configuration variable is for.

> diff --git a/builtin/repack.c b/builtin/repack.c
> index da1e364a75..3baa993da2 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -22,6 +22,7 @@ static int delta_base_offset = 1;
>  static int pack_kept_objects = -1;
>  static int write_bitmaps = -1;
>  static int use_delta_islands;
> +static int no_update_server_info = 0;

Not the fault of this patch, but I wonder if this would be less
confusing if we stored `update_server_info` instead of
`no_update_server_info`. If you have time, I think it may be worth a
preparatory patch at the beginning to swap the two.

> +test_expect_success 'updates server info by default' '
> +	git init repo &&
> +	test_when_finished "rm -rf repo" &&
> +	test_commit -C repo message &&
> +	test_path_is_missing repo/.git/objects/info/packs &&
> +	test_path_is_missing repo/.git/info/refs &&
> +	git -C repo repack &&
> +	test_path_is_file repo/.git/objects/info/packs &&
> +	test_path_is_file repo/.git/info/refs
> +'

I wonder if this and the below tests might be cleaned up with a pair of
helper functions, perhaps:

    test_server_info_present () {
      test_path_is_file .git/objects/info/packs &&
      test_path_is_file .git/info/refs
    }

    test_server_info_missing () {
      test_path_is_missing .git/objects/info/packs &&
      test_path_is_missing .git/info/refs
    }

t7700 has a mix of styles, but it may shorten some of the lines to use a
subshell that is changed into the repo directory, e.g., the test above
would become:

    test_expect_success 'updates server info by default' '
      git init repo &&
      test_when_finished "rm -fr repo" &&
      (
        test_commit message &&
        test_server_info_missing &&
        git repack &&
        test_server_info_present
      )
    '

which reads a little more easily to me. It would be nice to avoid
creating the sub-repos at all, perhaps by removing these files
ourselves in between tests.

> +test_expect_success '-n skips updating server info' '
> +test_expect_success 'repack.updateServerInfo=true updates server info' '
> +test_expect_success 'repack.updateServerInfo=false skips updating server info' '
> +test_expect_success '-n overrides repack.updateServerInfo=true' '

Great, these four and the above together cover all of the cases I think
we'd be interested in.

Thanks,
Taylor
