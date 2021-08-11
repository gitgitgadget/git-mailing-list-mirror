Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DB8C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006BB60F56
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhHKRSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKRR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 13:17:59 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18504C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 10:17:36 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r5so5615174oiw.7
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Xp2T9WFIC7MTgmUbAj4uYnrYxQxmLNdAC7nVM+Vasbs=;
        b=efjwY4M55K9Te6VAOIrzQIkRoCDB9ImFOcweihux5G+84IC1gwsS4OeMJiu8jUegAu
         BZ0ipngY+R2g2T4E+KxZ/kiu5ZlaZ8kzfz4CXdhISryRJ6qoa//oai8AqIhzJlX5813Z
         KIpXWvKfRjyiQ81pDT+fyRQtfotMOcObJyShBB00YGg9/tZOGYM+N2ZFhr23+nxq74NJ
         3xgFvevcF4BvRVy9i6HCh/j5J9YxgIpNCyEscocxg0rxgW6oaMXt16+VlLZtKd+PAMvs
         jDMO9cf15JH+z8wm4hXHYT6BnwjShOOFMYF7XfEY1tvNeXru2sJb+997MQDlXLrTx+I5
         itmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Xp2T9WFIC7MTgmUbAj4uYnrYxQxmLNdAC7nVM+Vasbs=;
        b=Mvq6boV8iTDzmziFJgn/GWHIbk2FOeI0tG6X7MwSLUJgfKaWl5DxiIRGNzJcNYx5+J
         clEbTyKk2tqTvTRz0ZVo9S5Nh/EoDBeU7joQ+0445yErnbkpWss5Qd2V3U7/9w4MoDt6
         E8uPURA1DL72UqGi3PGRkTvsB1QqBL90O177b+J+dQWMIC1De0ujCcCD/cUftmXglbKq
         G7Rdf0BdD8rnLxf2HK8u89l96SCe/IKDOUyOXRtKCsxE94PX5oMg0x564PmHoobxsNjC
         ny/N0r46Kl1HCZj5Z91vYDWhDSXTJ92yg9rAxREXl5RN0u0F/fLOSdanebM5Zz8JFj5i
         WZhA==
X-Gm-Message-State: AOAM532l7Pom8zXvTqoizOW+GZDK3HGq0wyTK0JhGm1dTVNc+GAhigeM
        EAcgcPpXTgdvphLDQqwBxrM=
X-Google-Smtp-Source: ABdhPJz6Zanks7maWU3vptbU93PF9YyrB7JVPo/WsYoHanaKWD6TvBZi30bpNahWd8T4NRy+I9YguQ==
X-Received: by 2002:aca:4e06:: with SMTP id c6mr8392042oib.161.1628702255399;
        Wed, 11 Aug 2021 10:17:35 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id 7sm3250oth.69.2021.08.11.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:17:35 -0700 (PDT)
Date:   Wed, 11 Aug 2021 12:17:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>
Message-ID: <6114062dc362d_30a208f9@natae.notmuch>
In-Reply-To: <xmqqzgto9dkd.fsf@gitster.g>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <20210811045727.2381-7-felipe.contreras@gmail.com>
 <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
 <xmqqzgto9dkd.fsf@gitster.g>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> A more notable aspect of the above list is not the similarity but
> difference from the rest of Git.  The above organizes various
> operations on the staging area in a single command as its operating
> modes, so you'd use "git stage --diff" for comparing with the
> staging area but use something else ("git commit --diff HEAD"???).

It is not different from the rest of git:

 * git branch --delete
 * git tag --delete
 * git remote remove
 * git stash drop
 * git worktree remove
 * git submodule add
 * git config --edit
 * git notes remove
 * git bundle create
 * git bisect start

Plus it's not unusual for commands and options to be redundant,
especially when they attempt to simplify or improve the user interface,
starting with `git checkout` / `git switch`.

> It is a good example that illustrates that the proposed organization
> may not help learning or using the system for operations that also
> apply to other things like commit and working tree (in other words,
> "git stage --grep" may not be such a good idea for the same reason
> as "git stage --diff").  But if it were limited to operations that
> apply only to the index (e.g. "git add" and "git rm"), it may be an
> improvement (I think we added "git stage" synonym exactly for that
> reason, already).
> 
> Having said that, if we added "git stage --remove", there may be
> complaints that say "the stage command does too many things",

Or there might not.

> just like those that caused "checkout" to be split into "restore"
> (check out contents for selected paths in order to work on the current
> branch) and "switch" (check out a branch in order to start working on
> it).  I dunno.

I don't see many people complaining that `git branch` does "too many
things", neither `git stash` or any of the commands listed above.

Moreover, you are not addressing the most interesting thing my proposal
enables:

  git stage --edit

-- 
Felipe Contreras
