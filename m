Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60641ECAAD8
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 03:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIRDTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 23:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIRDTH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 23:19:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9AD28E19
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 20:19:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so3113047pjl.0
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 20:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9/KlK6LE77rCtqqKjQ2GxRwqUo1L3/HySAoc4Nu+Id8=;
        b=FHOfZnKbAtsLfrkFasfOxoJYEp+TO2Kgjb73i6O37obw9CZyJ2QFkN+X4aZ0NrhPIl
         ZpbOeqOogCoD7Sb9I/NzVyeTOIBH1Zt7wbfa6iv2Q1vTACgOcNIF3/8MDfAwULNA4IPu
         LF0IY+G5s+szSaWbx2k8lhNbMzQYh4kwTsVrEYtJzIVz4hmEG7mYfIABfygygpIJOsCt
         tUnnMcLqjQEIZbO73Raxzm7zuj/Wb/oP3P4LTLt49wfpE/PxYHS7f5C0jdss+22AjDDG
         BT0aAlNAZTDRw2o1icfBhRqdt64C65Nf1EYoj4E/dMtZauiRhGOZdfLLoJUz7wOwipPa
         xcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9/KlK6LE77rCtqqKjQ2GxRwqUo1L3/HySAoc4Nu+Id8=;
        b=k8uwFtvwmPf4V0y41YNhXNuiY/5ttUbzrkvi5dwPt1L9aK5ZjBjWoOC4++m150TeRk
         CEfLbT9MulwdGkov3nwpRWTA1JilpB8yGjBh7hLijossBsJUtxa9pkuPsLY1GkxY3Qd2
         ZNVQUzWs+4X6tb1Fc9KQvZkpisbJhBIONKE9kDr3xn2eSXZbr1SRdZTBzk2rTf8NMO98
         1UZv7cmYb0ItfEjJexnbiBw8Cuz9dHdGDEYKWhw+T56MP5/QjkP9QIQi2/66WRYhhwpT
         OkTK75uGpvIaePu6Uw4Ul+ud5CatrhsAHdqfVEOPwF+DXQNBxXQupP+ThuZlp/smap2C
         dfbg==
X-Gm-Message-State: ACrzQf2IQ+RbxfXDIMSMxow+JTNrznv7jKw3IjZCeEJsMxd3aOHoGinW
        0OPZHReDgwTsVdSPU8kva0ouc1dTT5h3HQ==
X-Google-Smtp-Source: AMsMyM7D3v8WO8Vw+V0+LgsRXim/LWzBNzNFx20YsZiyC6glIU/D3+dvqR9dBHXfsL0GOcdHBAND2Q==
X-Received: by 2002:a17:902:a611:b0:178:6b71:2ee5 with SMTP id u17-20020a170902a61100b001786b712ee5mr6923343plq.53.1663471145467;
        Sat, 17 Sep 2022 20:19:05 -0700 (PDT)
Received: from initialcommit.io ([2600:8801:9c0a:f300:7870:e05a:daae:7b0e])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090a6a4e00b002007b60e288sm3844297pjm.23.2022.09.17.20.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:19:04 -0700 (PDT)
Date:   Sat, 17 Sep 2022 20:19:01 -0700
From:   Jacob Stopak <jacob@initialcommit.io>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Newbie contribution idea for 'git log --children': input
 requested
Message-ID: <YyaOJa1FNyWK+M4U.jacob@initialcommit.io>
References: <Yx5qjPhZ5AHkPHr7@MacBook-Pro-3.local>
 <xmqqillth1am.fsf@gitster.g>
 <YyKzOk5AQBz1pmAh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyKzOk5AQBz1pmAh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2022 at 12:08:10AM -0500, Jeff King wrote:
> 
> I usually solve this by doing a single traversal, and asking the pager
> to jump straight to the commit of interest, at which point I can scroll
> up and down to see the context. Like:
> 
>   git log --color | less +/$some_old_commit
> 
> I'm not 100% sure I understand the original use case. But if I do, and
> that solves it, I wonder if we could make it more ergonomic somehow.

Great points thanks for the details. I do think your method addresses the use
case I was trying to describe, which is being able to quickly see context in
both directions when you jump to a commit far from any branch/tag.

But like you implied, it would be nice to be able to do it with a real command
line option to git log instead of repiping into less, something like:

    git log --scroll-to=commit_id

I peeked into builtin/log.c and saw how it calls setup_pager(); at the end of
cmd_log_init_finish(...). I have a basic understanding now of how the default
pager and pager environment are roped in.

One obvious issue is that different pagers might have different ways (or no way
at all) to auto-scroll to a pattern. But this might be solved by allowing the
user to add their pager option such as +/ to the pager environment, which would
only be applied when the user adds the --scroll-to=commit_id option to git log.

(I guess this would rely on the user knowing what the option format is for their
pager, which isn't ideal... but I assume that it's not great practice to have git
store option formats for external tools like pagers since they could change over
time and then there is the can of worms of which pagers git would even support this
feature for - although it does seem git stores default flags for LESS and LV).

Anyway, then the commit_id would be dynamically added after, probably in a format like
"commit <commit_id>" so that the same pattern in commit messages doesn't match.
 
But I don't think I saw an existing way to pass in dynamic parameters, such as a
commit id, into the pager environment. This ability could potentially be useful
for setting other dynamic pager options as well, which can currently only be
done by stuff like repiping git log's output as in your example.

From what I can tell only static content like flags appear to be able to be set
in the current pager environment, but maybe I'm missing something obvious...

It would be great to get your thoughts.

-Jack
