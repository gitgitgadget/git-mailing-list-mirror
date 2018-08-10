Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C7A21F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeHJX7L (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:59:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39886 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbeHJX7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:59:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so9399823wre.6
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ns85OcWzHaUh2gDn45KcxxGxRjeyCJcNmDIPzNGiZS4=;
        b=mlLF+xhBo9n6vGRKhGSvoQSvEJ4ifbPzp5Z04r5fH9UbnPhhAKyGW+m+3/xbYlEaMF
         QgArmGg3+hxvmKx1dvrit0xBipgOWpwWRR2dCt8Gv+qRxGfowZyj07UPlG4z2hnBwjGI
         cj2b31rvQ1+NiM0MZIHt5PaBaDmuhulhfTHUSbS4W7Ttxqzc3t/aqpZvJLBvcCOsldeJ
         lMYgrqrqL+A8i8lXiFVvvFNRry4cvGVRt1+mfoGuImzE5HyMJo8+iTvupdQFc1ayqDdg
         XRIsXHmU3ZHQtWjR+GhxfueNp8rp9143B7wg+qQo+PT9W6Kar8+3jcGz6EKfWRbz2eul
         Zt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ns85OcWzHaUh2gDn45KcxxGxRjeyCJcNmDIPzNGiZS4=;
        b=U2yhD/UY39mivBNcwMWnrPxHIZZB9F1OmtM+X1RETA/P94eAgENWSAnyr8QBU+EIf5
         C4ZI3FY5P27uCIU4D5k+Zi48bIGi0zPa8r8TNpRXb13qPanvSDEmJ0pz/Mqj49nubjpp
         BQWK5GZD/1cker2jjNRpQ9C5Y8uNR19JZ7ne5lrvCK+paLmnQPnzQG1xAAYyGOsIlwzY
         NmWe2WyLBRPjWVRIb0jWqNkb6VmrmzoJ7oMjq6p0sJhdiCYzO7xbcGn27wdKICsUWPXQ
         clIdKb6gwlK/GJeRkRRlDKdtfJP0ei1Ct45XEfiwyD/D7PAGd8WaoijcvvkByouK96fK
         PBwA==
X-Gm-Message-State: AOUpUlFYrhLeBsiDqPYG+3f0qJEoQgDlz8Knd9PULGKw2CcMEHbRvOUg
        t0Fv//duxfRsdhZxp47HXXs=
X-Google-Smtp-Source: AA+uWPwuBGmAkgHVOaz0Te7X6lcXljpgw1GKvNtnXHbqGO+MpZGJto0k+bPstUF6KBrWqg2tLLDhSQ==
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr5524530wrd.176.1533936453486;
        Fri, 10 Aug 2018 14:27:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v10-v6sm12170169wrm.18.2018.08.10.14.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 14:27:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] submodule: create helper to build paths to submodule gitdirs
References: <20180807230637.247200-1-bmwill@google.com>
        <20180808223323.79989-1-bmwill@google.com>
        <20180808223323.79989-2-bmwill@google.com>
Date:   Fri, 10 Aug 2018 14:27:32 -0700
In-Reply-To: <20180808223323.79989-2-bmwill@google.com> (Brandon Williams's
        message of "Wed, 8 Aug 2018 15:33:22 -0700")
Message-ID: <xmqqpnyp7vzv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Introduce a helper function "submodule_name_to_gitdir()" (and the
> submodule--helper subcommand "gitdir") which constructs a path to a
> submodule's gitdir, located in the provided repository's "modules"
> directory.
>
> This consolidates the logic needed to build up a path into a
> repository's "modules" directory, abstracting away the fact that
> submodule git directories are stored in a repository's common gitdir.
> This makes it easier to adjust how submodules gitdir are stored in the
> "modules" directory in a future patch.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
> ...
> @@ -2018,7 +2039,7 @@ static int connect_gitdir_workingtree(int argc, const char **argv, const char *p
>  	name = argv[1];
>  	path = argv[2];
>  
> -	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> +	submodule_name_to_gitdir(&sb, the_repository, name);
>  	sm_gitdir = absolute_pathdup(sb.buf);
>  
>  	connect_work_tree_and_git_dir(path, sm_gitdir, 0);

This function goes away with 1c866b98 ("submodule--helper: replace
connect-gitdir-workingtree by ensure-core-worktree", 2018-08-03) in
sb/submodule-update-in-c topic.  git-submodule.sh has simlar
conflicts.

I guess its replacement function does not care as deeply as its
predecessor used to about where the submodule's $GIT_DIR is, so the
correct resolution may be just to ignore the change made to this
caller to the new name-to-gitdir function.

It would have been nicer to see a bit better inter-developer
coordination, especially between two who sit practically next to
each other ;-)

Thanks.
