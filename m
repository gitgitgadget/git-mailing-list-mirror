Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5951EC433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 15:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0543F64D9C
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 15:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBSPUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSPUB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 10:20:01 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8133C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 07:19:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id a4so4581964pgc.11
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mQWDSnswz7RTxpkEt/44+LY66WozIWP3Wtc31uGK+6s=;
        b=k1a1xm4Mz4jx2u2ZVgmAEvhIm0fqAg0Upl/L2vx4/bl3lvlyMB/SyXjFcbaPkXvdET
         dSvBt03nSlUolB/9JaNyf727hEBQLPg3QTIue5GRqcVBxiAH9izruDg+4zww6xN+ZGkD
         AdBpxZjO24oXb0iTU+Yn7TD/emNv0BMf2r9ZDluS0EpGfW8PqGfNCTBgnk5w65vLEVNi
         7Wt5d/rO82pp4cyPOFMCRfm0NlLWS5f1v10jCYWx+c+8vcgsK2t1GpHezz54QJ7bbp8Z
         lbRyUZhYRIUl25+WnniB2XC0kWYE4+LT272+7Ev4L3fCkF0uPB4vS/BXRKV7eFrEjfNr
         crEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mQWDSnswz7RTxpkEt/44+LY66WozIWP3Wtc31uGK+6s=;
        b=INjrmi36rOqdrSnuCVvqvG9JwIN+i0d5VnA3oh+Ewyd3pmRcTnPA0HabDgAppGh93G
         fV7lJtT2NbwGDwm0mwscMurj1fUE6jUqPXiPX96ftSlazMQsDx4w8EtfWHLacfbd3fiT
         UnK4a6pahofIT/t//HatVPyHs5T9feWfZzEyo4I0+xN558I9UfIb3FIieKM4oUFG5iEl
         gMe2E60RRPJuejWfg1fU1Wtd2NcQ/s+JbZhbrg8TYNIsVQ2/y+Z43kmYIB9m8jYbDCfl
         4vPZ/HRfuZ3iy0hkBeLKn7+EIkVFBRoTcu+8Nhsv4N1noO8rJlupX+eKhWPEXAU6ud0F
         zCgQ==
X-Gm-Message-State: AOAM531sk8XKyfqR5O5F9yST8sjI8iqMH1ARlSZrYxNN3y9QfeNTWi+l
        4HJoZj7/i2Wi9rEmBeasMDg=
X-Google-Smtp-Source: ABdhPJy7j7g7506fQj7iRVaf3ndH+5AyQvX1UtWoo517sxiuOO+zEl9m+GQUUyNag0WJTwhejOtrBA==
X-Received: by 2002:a63:5016:: with SMTP id e22mr8913762pgb.420.1613747959280;
        Fri, 19 Feb 2021 07:19:19 -0800 (PST)
Received: from konoha ([122.176.159.190])
        by smtp.gmail.com with ESMTPSA id k128sm10196114pfd.137.2021.02.19.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:19:18 -0800 (PST)
Date:   Fri, 19 Feb 2021 20:49:13 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] rm: changes in the '.gitmodules' are staged after
 using '--cached'
Message-ID: <20210219151913.GA6254@konoha>
References: <20210218184931.83613-1-periperidip@gmail.com>
 <20210218184931.83613-2-periperidip@gmail.com>
 <0577f84b-f594-6b8a-76a2-29fb9453ee25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0577f84b-f594-6b8a-76a2-29fb9453ee25@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/02 03:14, Philippe Blain wrote:
> Hello Shourya,
> 
> Le 2021-02-18 à 13:49, Shourya Shukla a écrit :
> > Earlier, on doing a 'git rm --cached <submodule>' did not modify the
> > '.gitmodules' entry of the submodule in question hence the file was not
> > staged. Change this behaviour to remove the entry of the submodule from
> > the '.gitmodules', something which might be more expected of the
> > command.
> 
> We prefer using the imperative mood for the commit message title,
> the present tense for describing the actual state of the code,
> and finally the imperative mood again to give order to the code base
> to change its behaviour [1]. So something like the following would fit more
> into the project's conventions:

I have no idea how I missed that one. Apologies, will make the change.

>     rm: stage submodule removal from '.gitmodules' when using '--cached'
> 
>     Currently, using 'git rm --cached <submodule>' removes submodule <submodule> from the index
>     and leaves the submodule working tree intact in the superproject working tree,
>     but does not stage any changes to the '.gitmodules' file, in contrast to
>     'git rm <submodule>', which removes both the submodule and its configuration
>     in '.gitmodules' from the worktree and index.
>     Fix this inconsistency by also staging the removal of the configuration of the
>     submodule from the '.gitmodules' file, leaving the worktree copy intact, a behaviour
>     which is more in line with what might be expected when using '--cached'.
> 

Okay. I will use the above message.

> However, this is *not* what you patch does; it also removes the relevant
> section from the '.gitmodules' file *in the worktree*, which is not acceptable
> because it is exactly contrary to what '--cached' means.
> 
> This was verified by running Javier's demonstration script that I included in the
> Gitgitgadget issue [2], which I copy here:
> 
> 
> ~~~
> rm -rf some_submodule top_repo
> 
> mkdir some_submodule
> cd some_submodule
> git init
> echo hello > hello.txt
> git add hello.txt
> git commit -m 'First commit of submodule'
> cd ..
> mkdir top_repo
> cd top_repo
> git init
> echo world > world.txt
> git add world.txt
> git commit -m 'First commit of top repo'
> git submodule add ../some_submodule
> git status  # both some_submodule and .gitmodules staged
> git commit -m 'Added submodule'
> git rm --cached some_submodule
> git status  # only some_submodule staged
> ~~~
> 
> With your changes, at the end '.gitmodules' is modified in both the
> worktree and the index, whereas we would want it to be modified
> *only* in the index.
> 
> And we would want it to be staged for deletion (and only deleting the config
> entry and keeping an empty ".gitmodules' file in the index)
> if the user is removing the only submodule in the superproject.

Correct.

> >   builtin/rm.c | 48 +++++++++++++++++++++++++++---------------------
> >   1 file changed, 27 insertions(+), 21 deletions(-)
> > 
> 
> Once implemeted correctly (leaving the worktree version of '.gitmodules'
> intact), that patch should also change the documentation to stay up-to-date,
> since the "Submodules" section of Documentation/git-rm.txt states [3]:
> 
>     If it exists the submodule.<name> section in the gitmodules[5] file will
>     also be removed and that file will be staged (unless --cached or -n are used).

Understood. I have to let the working tree '.gitmodules' be left as-is
and only change the copy in the index.

