Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89812C47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5525060BD3
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhE3QeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhE3QeB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 12:34:01 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E81C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:32:23 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id z3so9908578oib.5
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3iBU04IiPY9LxSbmMSCVfjcJwU713B+xPPUQf5IZPdY=;
        b=glRoMurHwOWao9RJxCkzHVgNvbRwOB9mbDbxfjSbHurjOmXrwxALAJ1JeOK4oyw9j+
         woUzoDg2R0IoPRdCwxZHzJZktDPQNGNufh9CeH2G3DvR/1Enlg3gBvkLv1RVxP2sIwlw
         ZkNfsHb5mpcxGo0pm+iC/0DDhteIFsGvdVexRGoMWI0a4VmRBPvcsk1TDBUwOyw7gYLQ
         PcP++cfbqoZ0nEQtAxnkezQ3piKe0QP++MrokAG4HxfgdL63y4YBnxPh29AHvkkonMCz
         SbUpi7fHO+t3qbbWFgjEAo2Eo+U4nEekDBUBGZ316Pt1DzdCbJ9gi0S8cb70pvpStg7O
         2W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3iBU04IiPY9LxSbmMSCVfjcJwU713B+xPPUQf5IZPdY=;
        b=i0UyP/v8jJRMZ6Hsm9xOuNSFSJf83wrTmHOzeYRFTUgNttzfEa3fPmY+kWQV3lnrkH
         cg07oCnPdaeKLXYLuruAuxo1RDbpDz6LvKh7dhMgcvLK1JrO3fu4d0Hz5+XAwrFSXG/H
         v21qMXmMc+LrtRILex7U2AreX4FAHyjjx/POW2IRuiiG2Zr1GR2zuBCvh+7g/6pVJsrH
         o9nUS4ErUX08UO/w/gf3L9jGc5Zdz2ihg4UyFYyUzWfvVGJDva39QOTaEwWDgU8sTszV
         ZbkU7cQRmO/nXciMAiGBGMf1TPDkF+DLOxcWNJ9HozIL3RyM2OoyQhTPqXQDKHj06u36
         gViw==
X-Gm-Message-State: AOAM532e5u95J378IxTSEOdhFVd2u9gVnvTh7oVkx+P7qn8/rCdtDeyj
        ac/KPT3VkRbU4dgE2ooXtak=
X-Google-Smtp-Source: ABdhPJynuyL9UjF74G5pXMASofDoQPoDIJFb2nWvG92/hIQSdspjRMNedfNRebDx3gGsJt/GrSd1Sg==
X-Received: by 2002:aca:b406:: with SMTP id d6mr4098085oif.71.1622392341926;
        Sun, 30 May 2021 09:32:21 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m66sm2353611oia.28.2021.05.30.09.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 09:32:21 -0700 (PDT)
Date:   Sun, 30 May 2021 11:32:20 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <60b3be1476401_b937208e1@natae.notmuch>
In-Reply-To: <d9e212fa-4c6a-f6ce-eab0-8073a65e96fd@gmail.com>
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
 <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
 <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
 <f9f38d42-2b93-0d3b-798b-4c6f44eb111d@gmail.com>
 <287483ba-d682-6d04-23fa-22c33ab70376@gmail.com>
 <60b15cd2c4136_2183bc20893@natae.notmuch>
 <d9e212fa-4c6a-f6ce-eab0-8073a65e96fd@gmail.com>
Subject: Re: git push default doesn't make sense
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Kunter wrote:
> Am 28.05.21 um 23:12 schrieb Felipe Contreras:
> 
> > Cloning automatically sets up an upstream branch for "master", and
> > therore it passes the safety check of `push.default=simple`, and that is
> > much more dangerous than pushing any other branch.
> > 
> > Why do we barf with "fix-1", but not "master"? Doesn't make sense.
> > 
> > This is what we want:
> > 
> > 	if (centralized &&
> > 		(branch->merge_nr && branch->merge && branch->remote_name))
> > 	{
> > 		if (branch->merge_nr != 1)
> > 			die(_("The current branch %s has multiple upstream branches, "
> > 			    "refusing to push."), branch->name);
> > 
> > 		/* Additional safety */
> > 		if (strcmp(branch->refname, branch->merge[0]->src))
> > 			die_push_simple(branch, remote);
> > 	}
> > 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
> > 
> > 
> > In other words: `simple` should be the same as `current`, except when
> > there's an upstream branch configured *and* the destination branch has a
> > different name.
> 
> I guess so. In particular, as a simple git user, I'd expect the 
> following to work out of the box, without having to manually adjust the 
> configuration settings:
> 
>    git clone ssh://originUrl .
>    git checkout -b myBranch
>    git push           # expected push to origin/myBranch, but fails
>    git push origin    # expected push to origin/myBranch, but fails
>    git remote add myRemote ssh://myRemoteUrl
>    git push myRemote  # expected push to myRemote/myBranch - works
> 
> Will your provided patch fix these failing push commands?

It's not really a patch (yet), but yeah: it will.

-- 
Felipe Contreras
