Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F2C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9A960FC4
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhKATmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhKATmX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:42:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E63C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:39:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s1so68014869edd.3
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BaDS9ZJtzYiRf+2ussa2iNjeSLgc38o7g14YCsAFtXE=;
        b=Ucsk2uoN75/snt57lZjcTYFP/oiAzT8hmtSbppfl3o+KjDjy30mDm1LtdrdCaIhxTC
         peIcBkYFjvbL7gqqc8e/uugORlj8BBXsKE9/VVzqVkWjMLozBC1eO9WqiQwHygmWiLGo
         40NKEgxHhwPKyidm2HN+X5Tzazd77csCTXFyMXCYnry1xXP9eIanI1sH0lYhT08UfX7K
         wLP58UqPGPqmGP/ldhuWTn9OgRKli2WvKVMgyz318TxtBiavXv8sebBsxMs01P1fgtO8
         4NAUt5W8fPvq5C4UWZjTidFRgpimUIZV5w8exLqT2vBFJV+ECfg/IC8A2PrzSfVCCiTE
         XATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BaDS9ZJtzYiRf+2ussa2iNjeSLgc38o7g14YCsAFtXE=;
        b=VzxU08bfG4dpIQlQm+O/w/UXWYiFo1OOGKPpjungcEris8knlYLrjLtwednREQDoGl
         1bw+aJdLd5wHXB0VndYy+cDyYktbu9SI2JsnSYloPQvsb1dWSO2UssvGp1yX8BeG0FRZ
         Kfz2QAwnrkmORXrrGl0DPU/fdqNMeBETcrxenObcyV99jj6SU/DMEB0qX9vonCit2EqA
         TTVqxx9LCE3boUXIRkTKt+KOYnrRt4slytqskrVcmTukVnc6QlViHzg5l6uBu9aRkDGg
         m22UtTJI5YCHXgtI2gwtJsAiZdlbarJE+oiYn6eMxZVXjch9//REWIwavo4aOY7v5yCs
         4DKA==
X-Gm-Message-State: AOAM533isaXs8Q/8eFw9cunJMr13L9+UqynR5h/Qie9K+P5DafBiHfP/
        4iUotpVUOC4hy/70YzyVdu9MqgvFKh8X4Uio
X-Google-Smtp-Source: ABdhPJwAM6r5cTiKzl2Dm46mVBvGDuVd+9vZuy58JyEaAA6DYEhCgIL+pOSKTTLHr53eUks1J/daHg==
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr10563682ejc.547.1635795588296;
        Mon, 01 Nov 2021 12:39:48 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ht20sm7470320ejc.97.2021.11.01.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:39:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhd9n-002Biu-GN;
        Mon, 01 Nov 2021 20:39:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: js/scalar (was: What's cooking in git.git (Oct 2021, #07; Fri, 29))
Date:   Mon, 01 Nov 2021 20:34:11 +0100
References: <xmqqr1c3e57a.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqr1c3e57a.fsf@gitster.g>
Message-ID: <211101.86k0hr3bss.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Junio C Hamano wrote:

> * js/scalar (2021-10-27) 15 commits
>  - scalar: accept -C and -c options before the subcommand
>  - scalar: implement the `version` command
>  - scalar: implement the `delete` command
>  - scalar: teach 'reconfigure' to optionally handle all registered enlistments
>  - scalar: allow reconfiguring an existing enlistment
>  - scalar: implement the `run` command
>  - scalar: teach 'clone' to support the --single-branch option
>  - scalar: implement the `clone` subcommand
>  - scalar: implement 'scalar list'
>  - scalar: let 'unregister' handle a deleted enlistment directory gracefully
>  - scalar: 'unregister' stops background maintenance
>  - scalar: 'register' sets recommended config and starts maintenance
>  - scalar: create test infrastructure
>  - scalar: start documenting the command
>  - scalar: create a rudimentary executable
>
>  Add pieces from "scalar" to contrib/.
>
>  What's the status of this thing?

I've been noting breakages in the build integration and submitted a
patch-on-top[1] as part of the general RFC Derrick Stolee[2] started
about how to integrate such components in-tree.

I think it would be helpful if you weighted in on this whole discussion
about if/how in-tree path prefixes are meaningful as a method of
"marking" certain components or not.

It seems to me that some assumptions in the approaches described in [2]
ultimately come down to reading the tea leaves vis-a-vis what patches
the maintainer might accept in the future to the discussed components

1. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/
2. https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/
