Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B73920248
	for <e@80x24.org>; Thu,  7 Mar 2019 07:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfCGHxB (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 02:53:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53454 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHxA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 02:53:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id e74so8247003wmg.3
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 23:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ka6nvwiy0305+xrLvrYG1aKO83ZvKvmMQwG2356Y85U=;
        b=pps59CHh3331V3/HY1jCgM22YfrqMUv2L1FwMdUjfu0cMM5H/jhH6rI12XVFr2Kc2p
         rFsI3sbPdcVPXN+WTA06MkIoCgd+ioPobB2KqvqnaVBIf/n4D17nCf0WtTRFt+0yOg6x
         Za1bh8VZHVNK/YijCZIyVZNjX7XjqlbDWAsbg2WG8oGMI1cDOqCYVCuU6AZoDqGhAShN
         ZNencfl5xXmREeejeuAeDAN3cBr97AavNUe4rwWDF6x0f8++AR3NJEjv2NYyViDAivhh
         vpaTCNnahNNpMJ6o4Fl5uzLKPdXcID1lvVT/P20SkkKs7dTlLZgvjUBVOFeVSBJS6Wdq
         nELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ka6nvwiy0305+xrLvrYG1aKO83ZvKvmMQwG2356Y85U=;
        b=qTmSUnwfUOJ2vGMvi4TnLvOmxZZv9mpqmH/RWEhZxOlJ0su+iJVsAO9Yx/QCg+UGAE
         KhFtD6SsJJWYNbcaJTIaI4ZOeYI3Jp61AidBD2vUD6E5773F4AHm5Uml9HYsh2qFHv4P
         UYs/OYVL+99BgNtdl3iV11asEP8w7H+IYa6NulGM8o/017QHFNdo7uaC9wpmowNniDfL
         fEtbodv0WFBPMHFTPZUIPqgJvnzJb7kuU+DWJ3O5+GiTKmswF0uUXqjwe1113olQ9KPG
         hWQ2GaYIS2hlnQoTj8fNth6BOkJIvrKKP0l959v62zViBcMMc3bgc2EVd8d491BaNRTe
         K1Og==
X-Gm-Message-State: APjAAAXGHuQpmBMFYC9hI4wWj7AkPXHf/0ygen9OxpLvgtD4VirNm9V5
        V8R6L443viqoItnAYswYlE5xg/AnS2I=
X-Google-Smtp-Source: APXvYqx2hISuSqZbNk1UjP8bh5XjrEshN8jUe0KQ4J1/Wgf70rKNRn33ndzZdCwxtkuElXW8XChs6g==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr4992547wmh.106.1551945178585;
        Wed, 06 Mar 2019 23:52:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z16sm3423669wrr.66.2019.03.06.23.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 23:52:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/3] cherry-pick/revert: add scissors line on merge conflict
References: <cover.1551867827.git.liu.denton@gmail.com>
        <cover.1551940635.git.liu.denton@gmail.com>
        <8fdc5bfb151e4224eba01021c6f0be3e61e1f535.1551940635.git.liu.denton@gmail.com>
Date:   Thu, 07 Mar 2019 16:52:57 +0900
In-Reply-To: <8fdc5bfb151e4224eba01021c6f0be3e61e1f535.1551940635.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 6 Mar 2019 22:44:26 -0800")
Message-ID: <xmqqa7i7m886.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Fix a bug where the scissors line is placed after the Conflicts:
> section, in the case where a merge conflict occurs and
> commit.cleanup = scissors.
>
> Note that the removal of the if-else tower in git_sequencer_config may
> appear to be a no-op refactor but it actually isn't. First of all, we
> now accept "default". More importantly, though, if
> commit.cleanup = scissors, the cleanup enum will be set to
> COMMIT_MSG_CLEANUP_SCISSORS instead of COMMIT_MSG_CLEANUP_SPACE when we
> are reverting or cherry-picking. This allows us to append scissors to
> MERGE_MSG in the case of a conflict.

Good thing to point out in the log message.

> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index d35d771fc8..5c086d78c8 100644
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index 837707a8fd..1894010e60 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -66,6 +66,13 @@ more details.
>  	With this option, 'git revert' will not start the commit
>  	message editor.
>  
> +--cleanup=<mode>::
> +	This option determines how the commit message will be cleaned up before
> +	being passed on. See linkgit:git-commit[1] for more details. In
> +	addition, if the '<mode>' is given a value of `scissors`, scissors will
> +	be prepended to MERGE_MSG before being passed on in the case of a
> +	conflict.

These both say "prepended", but shouldn't the code

 - add the merge message proper, with the expectation that it would
   be used more or less intact in the final commit message; then

 - add the scissors; then

 - append informative cruft that would be removed, only to help
   human users.

in this order?  I'd expect that most people would consider that the
primary payload of MERGE_MSG file is the part that would become the
commit message, so I would have expected the second step would be
described as "appended to".

Another thing I notice is that this singles out "scissors" mode;
doesn't the code do anything worth describing with other clean-up
modes?

> +	sed "s/[a-f0-9]\{40\}/objid/" .git/MERGE_MSG >actual &&

Use $_x40 (or $OID_REGEX) to make it more readable and also
future-proof?

