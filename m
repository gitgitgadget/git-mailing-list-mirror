Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8C1201A7
	for <e@80x24.org>; Sat, 20 May 2017 23:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbdETXt5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 19:49:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36206 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdETXt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 19:49:56 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so13329680pfb.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 16:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zFMwVGUWgcfD4j90JeoEBkwDzEcyh3PlqlHP+ID+bag=;
        b=n+EQINk/c4n4uSQ5kny/fS3njPLFlOgzKvQCsR4XmXxpE4bUwIV0ilItt6iqnmhFnB
         vLJHumc3G5//sT8Tik3zOJ1nQVm3rMyr4FCMQxSkNpd8JIYIUBuOEC9NLRcAOosq/2x5
         tgcYKocCBkwxsevNelhx63ZokWnLNZiZZd6PS0aZagDdfr7obmDvdJnGvbVJULYbXJIt
         7JEhydSE7oxDYGLoMHJ/R+STlsNvr4JVpxWRdj2SE6YLU4HzL1DNr4qtBK0QlocFRhxK
         N1rbrO2IMoAz0Du+SA8m0GWN5R1/IOMOxcPWMElxluLn/pB7sHINdim4ohgSIv0VBJkz
         Nfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zFMwVGUWgcfD4j90JeoEBkwDzEcyh3PlqlHP+ID+bag=;
        b=AS/HhJLYf1m4vhKquuYJ3z25iCQfaLXiKTOzsHXSkovuLCRcOSVhXf0ycfG3dGvzMd
         1ZWVm7rfMWIWjBywShEaHJxPmBcY8AKxOXV5tolsC1+a2C8OQQycmygNRN3Rh1r8wKE8
         gNXYTwk9K9OciGLP/HaMqnXUus8GXDDpf5FvhMwT21ZSQyIyP0nnYk0Yb9cgo59Kdoh8
         1lbiZ2SqXkhqmyyyS56W4QyPAqazZqIQyqMWEfwhjC8biYZq8gpnueqp34rQG2MEYdT6
         NvPHcVvEr75cHxSa/HLxSYKAUBtfvuk8pe+VvWEBSrbKTGwzgtcv5UPmNBm8m8P8H67D
         0SDQ==
X-Gm-Message-State: AODbwcBMYdq8xXVrRjph5EmcmRZH6srmYZqPnFwygXQNB5dR8EIU0OzA
        lo/KuXooNHmzrw==
X-Received: by 10.84.143.68 with SMTP id 62mr14020443ply.123.1495324195623;
        Sat, 20 May 2017 16:49:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a59e:fcd8:9df2:4b0f])
        by smtp.gmail.com with ESMTPSA id j191sm24012801pgc.53.2017.05.20.16.49.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 20 May 2017 16:49:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Manish Goregaokar <manishearth@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating over all worktree HEADs
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
        <20170518014210.94189-1-manishearth@gmail.com>
        <xmqqy3trstup.fsf@gitster.mtv.corp.google.com>
        <CACpkpxmGzz0hUsypX5ORX7FLB3rh_xbyPOKz4SUt-zrjSjCq_g@mail.gmail.com>
Date:   Sun, 21 May 2017 08:49:54 +0900
In-Reply-To: <CACpkpxmGzz0hUsypX5ORX7FLB3rh_xbyPOKz4SUt-zrjSjCq_g@mail.gmail.com>
        (Manish Goregaokar's message of "Sat, 20 May 2017 10:33:25 -0700")
Message-ID: <xmqqzie7qeal.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Manish Goregaokar <manishearth@gmail.com> writes:

> One thing which I think hasn't been covered yet is the rebase
> ORIG_HEAD. I'll see if that's still a problem on `pu` and make a patch
> for it if so.

IIRC, ORIG_HEAD, FETCH_HEAD, MERGE_HEAD and others are be transitory
and never served as the starting points of reachability traversal,
even in the primary worktree (also when you are not using any extra
worktrees).  The commits listed in the todo list of "rebase -i" and
"git cherry-pick A..B" are the same way.

Because ORIG_HEAD is expected to be in a reflog of some ref (at
least, the reflog of HEAD), I do not see much benefit (or "more
safety") in adding it to the starting points.

Among the ones that appear in .git/ and we never considered as
starting points, the commits in FETCH_HEAD might be the ones we may
want to give extra protection over what we currently have, simply
because the ones that do not have remote-tracking branches have NO
other refs pointing at them (compared to these transitory artifacts
resulting from a local operation, i.e. ORIG_HEAD and ones in the
todo list).  But they by definition are "new" objects, and the
reason why the user does *not* use remote-tracking branches for them
is because the user does not want to keep record of them unless the
user decides to merge them somewhere in the repository's history, so
even for them the benefit is dubious...

