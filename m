Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4683AC433F5
	for <git@archiver.kernel.org>; Sun,  1 May 2022 15:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348505AbiEAQBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348485AbiEAQBF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 12:01:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C793700A
        for <git@vger.kernel.org>; Sun,  1 May 2022 08:57:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c23so10893367plo.0
        for <git@vger.kernel.org>; Sun, 01 May 2022 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtkAM1mtQZtg6yxf7Hix5rk5LNBhdg3+f+SPKyVKFFA=;
        b=PZMf6o+QwjjTMUA5d6JopMhghKBg0Ynrde+7qoS+R+k1Kb0oieJySFzoxFPAXN97Nl
         RKFWl4rGmcDX1uVm+GTe4viVAvNhiAsAaZB4pB0jVCsoM/LWORM33jUv2Ok0tHlEYUb3
         +333n5aSQCS22TfrKHOdVck6i2DQ+rfqwl2RVbG6PhOuC4kjo25RNKjd+a1nlIKPEZwm
         U5IW9MqkjdmyQzh253jOzE16tC75sQyH7ZwrZR5Y0NAVy2z4WCYXgI7E2/1xVP1nXYfr
         N9JPYx3Ec6LRwztE5hclkj2quBfSOOv3eEMrkSnjCgPkUMb5BvfsN7GeNp+f2ciIqAB8
         JVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtkAM1mtQZtg6yxf7Hix5rk5LNBhdg3+f+SPKyVKFFA=;
        b=dWvHTvqCuOIFQNcpzrErHqs/vOkI/koLPO4FD1+KYJEag7vPHAv9z9Lr+aJsn/vs7e
         ZqEmcf7h+dGbz0WbU8qq8EFuBBNFv/HcCTDWpxEjFUyDOlJqJ/HZJd/CE+0c1ktYJZxo
         mfXlDT07elnITCbSCsXiAGeg5WuALcGTJQmWo1J9FIVmgqHGCje7FhzwgsEJZUgHWFK/
         Tq9PO3wZzoPHjIIJhPT2IUrnFVhQis1U4bNmy4Kr8dpZ3HS3vkWxWLobqsgLFZQf9E/8
         zUzCTQtNs42ogkhDRP5/qufMu+c7FI16nukeM6eYi6dZumb5a9z3edhxaXDLGm/MX3VU
         7bgQ==
X-Gm-Message-State: AOAM53043NISsc0lSJjsPmZoIYTda4F22X3T1NCVFzhxLaMHAIK8jPqF
        5ksaurgCxoF+aQjTkmC+IbQ=
X-Google-Smtp-Source: ABdhPJxNWD2ZoCaMwh5nrMWHDsbJ8OUdl82AbYe7z1plTkp+fhqIN8ysXzqw9uffbVFb4H1YJbB62Q==
X-Received: by 2002:a17:90b:3851:b0:1dc:4f70:1cb with SMTP id nl17-20020a17090b385100b001dc4f7001cbmr3176049pjb.167.1651420659400;
        Sun, 01 May 2022 08:57:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:8f:d15a:dfd:3071:bcbb:fbcc])
        by smtp.gmail.com with ESMTPSA id q89-20020a17090a1b6200b001cd4989ff60sm13914935pjq.39.2022.05.01.08.57.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 May 2022 08:57:38 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/remote.c: teach `-v` to list filters for promisor remotes
Date:   Sun,  1 May 2022 21:27:25 +0530
Message-Id: <20220501155725.93866-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqczgy6zk5.fsf@gitster.g>
References: <xmqqczgy6zk5.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late response.

Junio C Hamano <gitster@pobox.com> wrote:

> Three comments and a half on the code:
>
>  - Is it likely that to new readers it would be obvious that what is
>    in the [square brackets] is the list-objects-filter used?  When we
>    want to add new kinds of information other than the URL and the
>    list-objects-filter, what is our plan to add them? 

I do think that new readers can easily understand the meaning of the
text inside the [square brackets]. These square brackets (with the
list-objects-filter inside it) will be shown only if the remote is
a promisor remote. So, users who don't use promisor remotes, will not
be affected. Those who used the filters can only notice the change.
They can easily understand it. In fact, I think it would give them an
option to quickly check which are the promisor remotes and which are not.
Though this change should be properly documented (which I forgot to
add) so that they can be sure about it.

>  - The presentation order is <remote-name> then <direction> (fetch
>    or push) and then optionally <list-objects-filter>.
>
>    (a) shouldn't the output format be described in the
>        doucmentation?
>
>    (b) does it make sense to append new information like this, or
>        is it more logical to keep the <direction> at the end?

Yeah, it should be documented. I forgot it :|
Will add it in the next version.

I think it is better to keep <list-objects-filter> at the end.
Because I think, people first want to check whether the remote
is (fetch) or (push). After that, they might want to know about the
filter. Another point is that <list-objects-filter> is optional
(i.e. only for promisor remotes). It would not make sense to put an
optional info in between two permanent info (in this case,
<remote-name> and <direction>). It would be difficult for scripts
which parse the output of `git remote -v` on the basis of string
positions.

>  - Now url_buf no longer contains the url of the remote, but it still
>    is called url_buf.  It is merely a "temporary string" now.  Is it
>    a good idea to either rename it, stop reusing the same thing for
>    different purposes, or do something else?

Hmm, this can be a subject for discussion. Yes, it is true that the
name `url_buf` is not suitable for the additional info it contains ( in
the proposed change). I did it to use less memory. I think renaming it
to `remote_info_buf` or similar is a better idea.

>  - By adding this unconditionally, we would break the scripts that
>    read the output from this command and expect there won't be extra
>    information after the <direction>.  It may be a good thing (they
>    are not prepared to see the list-objects-filter, and the breakage
>    may serve as a reminder that they need to update these scripts
>    when they see breakage), or it may be an irritating regression.

I agree. Frankly speaking, I have no counter argument for this. I can
tell that the proposed change will be beneficial for the users who use
promisor remotes along with other remotes. So, may be we can accept the
short term consequences of it. What we can do is we can provide a proper
documentation so that if anything bad happen to those scripts, devs can
see the documentation and update the scripts accordingly.

> But stepping back a bit.
>
> Why do we want to give this in the "remote -v" output in the first
> place?  When a reader really cares, they can ask "git config" for
> this extra piece of information.  When you have more than one
> remote, "git remote -v" that gives the URL is a good way to remind
> which nickname you'd want to give to "git pull" or "git push".

`remote -v` helps users to get the overall idea of the remotes. We can
see how many remotes are there, which remote name corresponds to which
url etc. That is we can get a summary of remotes. Having that said, does
not it make sense to add the extra <list-objects-filter> here? Users
can easily understand which are promisor remotes ( along with their
filter type) and which are not. Of course, they can use git config for
that. But it would be a tidious job to check the the type of remotes
(i.e. which are promisor remotes and which are not) one by one. If the
user try to search for the promisor remotes in the config file, he/she
have to go through the other configuration settings (irrelevant to him/her
at that time) to reach the `[remote]` section. Isn't it?

> ...  If
> it makes sense to add the extra <list-objects-filtrer> information,
> that would mean that there are probably two remote nicknames that
> refer to the same URL (i.e. "remote -v" readers cannot tell them
> apart without extra information), but how likely is that, I wonder?

I think, having a proper documentation about the new changes is the
answer to it.


Thanks :)
