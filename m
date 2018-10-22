Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B981F453
	for <e@80x24.org>; Mon, 22 Oct 2018 02:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJVLJd (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:09:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52059 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeJVLJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 07:09:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so8579911wmf.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 19:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6BbkCti+AGMEx5IuoQ2OqD1kXqoB/0ppNWasyiZaFzs=;
        b=mxk4y7b1NfT1RNUpk/Jla0gF04HDAAtuuU3SBLZnsZLDSI7o1V7xwvyc6svEyVkaeT
         e25WIYMUgCe9t+rAyybf4C0NJwTd6bK7N07sOyaGCCfOlaBEv4a0HPrfYp25zkqSO/GO
         TNqbILgCBIVCy9+R2axS0y8j0i4wq9KSbgvearmB2jmT2o3Pxwiyd0CPY8w3b/tpy34H
         s0RjwU3tDi8IgtnPf0LqJzGT2S6WmUbscpHlqzjz9Pm/WOkCjRRtFouBWotur84S9F/Y
         TYckG88leeu3JyCtKBL9J8we9/LumCKqJBkMxtEBnRIyHvNeHJq5mvxrFtbSmrTvHHqG
         cJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6BbkCti+AGMEx5IuoQ2OqD1kXqoB/0ppNWasyiZaFzs=;
        b=L55a1Rg4x+FtIgtMrVcbhA1v/ZruXzuAbAlgezfkLQV8kI3khEcaIGZPBxcL+Ac897
         vFUoR6dNqAqjvA3u9LB7DOmYhnEP5zkczcHORgUSdsGEJwzHgwpb0poa3Ym2QsKSJZ2V
         hXgnDfn3LbUJoPDLLMIaQsk4myqVpt+c2pdX5Ezz2ABe9SPm1IzpTcpgT1Z2gWYEH8I8
         WND/GE7X1eZ0eo1No1I00tSvO7FUQOpJTOZVMKPe3OUqEKRojNzjIXDItwj6CDrxn2WT
         0AroZF+dIxbrKOa5ALGnF/IACU8hOxXf7iu8Ag0g/pmNWllz7xR2gVuECpoJjGflgf9g
         uYGg==
X-Gm-Message-State: ABuFfoj4XOr6X8KSLDLP6c8wcoJ9ctgRdATRHtDirRqtneOw+V0hwfK9
        aVxR6NqO3Do+XkNIb7sCWAs=
X-Google-Smtp-Source: ACcGV62gq7/XM2feehcdu5l0YHVeKu+MkQ73fwHhHwUpiL35DMOkMTpwRspvFAYSBGu1PNg2Q6XaeA==
X-Received: by 2002:a1c:d10d:: with SMTP id i13-v6mr13837024wmg.68.1540176776311;
        Sun, 21 Oct 2018 19:52:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i6-v6sm30574113wrq.4.2018.10.21.19.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 19:52:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, juergen.vogl@jku.at,
        git <git@vger.kernel.org>
Subject: Re: Bug with "git mv" and submodules, and with "git submodule add something --force"
References: <c4792c95-9a19-fd0e-9171-fded095b78a6@jku.at>
        <CAGZ79kZ4NSCknQTkpurdj_CzD+XvFzdaz1bdxPTFizjwV8=rpA@mail.gmail.com>
        <20181019205837.GA84932@aiede.svl.corp.google.com>
Date:   Mon, 22 Oct 2018 11:52:54 +0900
In-Reply-To: <20181019205837.GA84932@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 19 Oct 2018 13:58:37 -0700")
Message-ID: <xmqqd0s2y9o9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> Maybe for now we can do with just an update of the documentation/bugs
>> section and say we cannot move files in and out of submodules?
>
> I think we have some existing logic to prevent "git add"-ing a file
> within a submodule to the superproject, for example.

There is die_path_inside_submodule() that sanity-checks the pathspec
and rejects.  But I think that is done primarily to give an error
message and not strictly necesary for correctness.

The real safety of "git add" is its call to dir.c::fill_directory();
it collects untracked paths that match the pathspec so that they can
be added as new paths, but because it won't cross the module
boundary, you won't get such a path in the index to begin with.

> So "git mv" should learn the same trick.  And perhaps the trick needs
> to be moved down a layer (e.g. into the index API).  Hints?

You would want to be able to remove a submodule and replace it with
a directory, but you can probably do it in two steps, i.e.

	git reset --hard
	git rm --cached sha1collisiondetection
	echo Now a regular dir >sha1collisiondetection/READ.ME
	find sha1collisiondetection ! -type d -print0 | 
	git update-index --add --stdin -z

So from that point of view, forbidding (starting from the same state
of our project) this sequence:

	git reset --hard
	echo Now a regular dir >sha1collisiondetection/READ.ME
	find sha1collisiondetection ! -type d -print0 | 
	git update-index --add --remove --stdin -z

that would nuke the submodule and replace it with a directory within
which there are files would be OK.  Making the latter's default
rejection overridable with ADD_CACHE_OK_TO_REPLACE would also be
fine.

