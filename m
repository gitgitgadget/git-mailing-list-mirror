Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2094C433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B7464F69
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 08:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhCSIJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhCSIJV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 04:09:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A66C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 01:09:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s21so4277267pjq.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+Oxuj77ilIjC3x2mYR0KEQazJfhJK+3N7xy+VIIizQ=;
        b=RPK2h1yKlpZwv0ZXorlqsd8GVv3pcQm2RDH+bOXb66hx6DGpFG/OTATH6o5XgtCTKh
         VO4Qsft0VN84D4RJUO214NzUkNeun//vpoYAwuJpO3txhXnSOG1PqY1gQhQbDnZ+sTEq
         eyDk41lNZm56ybytpzIUmpOMNxPhpohxiDS85wdmsUmXXL5rDYzASGgfMeeAGPWlAfrp
         wCtjbrYISiOiRqwolxmR+y7yN/z4dr9rLw4QXOIDBrQitJ2CHd3j73yWWbCriFvpEhcM
         9AF/Vdz/Su6yxtBK5gjIjyZ6OL8MFGNOAyERU0KRbuR1qWrGNRpA1SoL60TiVz0uOSJ6
         baRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+Oxuj77ilIjC3x2mYR0KEQazJfhJK+3N7xy+VIIizQ=;
        b=JWF3cjwoeHXAqZBJH+/HxiUXOiZKmtokIMJ+AsPbx+ie39Iebckqq8vLfuP6oX7MzZ
         jeJ958tWzcWBZwZUVZ97teg0761i3rOw+OxFcfMU8aY+ytXjCB2CP2ru+5TG8N+ykAJJ
         pSuo7vZ3HQpZr2CK6gKIUhBW5pDZkwkRxMK+b6fz2jzrRldkFuUXtpCih8oHRFBKE8je
         DrJ7AUzauQcHm4AR6hYqPJ4zJO01sDIV41Jg37/qpojaU9DAaZsiJsSn27xw3hw6o6xq
         JCbTdfsG9LLj4B3DAqcc5t/1IuT6b9IU8HQfvd05/t5NbfI3uqjD0jJeG5WJ1bRbL2Fz
         UPHw==
X-Gm-Message-State: AOAM531u4lZk8ixBXaBjfmMr9lVykXA2BC4mzOiJ9u14xwJXgDXAiqzy
        h4NHdNd3EYQmOitx0aUXPF+N49spUSY=
X-Google-Smtp-Source: ABdhPJzvrkLObjrc3PHbxzREViE5asd1fjuIFmVmBDR0WPZtIoKgeYbu55wr8lPuzvXOIBM9wsyVBQ==
X-Received: by 2002:a17:90a:f298:: with SMTP id fs24mr8745954pjb.57.1616141360768;
        Fri, 19 Mar 2021 01:09:20 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id d19sm4357426pjs.55.2021.03.19.01.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:09:20 -0700 (PDT)
Date:   Fri, 19 Mar 2021 01:09:18 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RESEND PATCH 0/3] git-completion.bash: improvements to
 _git_stash()
Message-ID: <YFRcLpfRNQbqpHoo@generichostname>
References: <cover.1615855962.git.liu.denton@gmail.com>
 <cover.1616060793.git.liu.denton@gmail.com>
 <xmqqv99oqg39.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv99oqg39.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Mar 18, 2021 at 02:58:34PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > This series modernises the _git_stash() completion handler by letting it
> > take advantage of __gitcomp_builtin(). Also, it fixes a bug with how it
> > offers completions when arguments are provided to the main git command.
> >
> > Denton Liu (3):
> >   git-completion.bash: extract from else in _git_stash()
> >   git-completion.bash: fix `git <args>... stash branch` bug
> >   git-completion.bash: use __gitcomp_builtin() in _git_stash()
> >
> >  contrib/completion/git-completion.bash | 103 +++++++++++++------------
> >  1 file changed, 52 insertions(+), 51 deletions(-)
> 
> Hmph, this comflicts with your own "stash show --include-untracked
> and --only-untracked" completion patch d3c7bf73bdb67, it seems.  How
> ready is that topic for 'master'?

Ah, sorry I forgot to mention that it conflicts in the cover letter. The
resolution can be done by just taking these changes. If you'd like, I
can also rebase this series on top of 'dl/stash-show-untracked'.

In any case, unless you have any other concerns, I would declare
'dl/stash-show-untracked' ready for 'master'.

Thanks,
Denton
