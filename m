Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A356BC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD4A6144F
	for <git@archiver.kernel.org>; Fri,  7 May 2021 08:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhEGI44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhEGI44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 04:56:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BE7C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 01:55:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so6679587pga.11
        for <git@vger.kernel.org>; Fri, 07 May 2021 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PYJ/JPYOG5ucGKjA38I3CRVtmJL7QZ9rHxnFtJwmdo4=;
        b=OMoZzwLGd7bKqfGXSHHEEH1fmXIiGzbts30RKWjpcj+cKrPQm/517pMp3qjxh07Cz2
         zL1pkcxq0b8tNp8c9UMzBE6ziqe2vHZS9mAdMIF4J9uYNnm+8tMq5KypwVPdJbnEyjtH
         j9OzHp4EUwAzLsHPa0YbVLS3pcERs1WfFjwHnvjVlSSrWWK0J+u2W9mo5TWGkPznjKvi
         4MsU6lIsUFYXUubiI8+UEOrlfZrQel/5tGR4qhef/f2tRsfNigtAOTNXCz2Z52k9eKGq
         8w6Bv9OvBnSOa8iVCZJwj+pgOXDM2lYMBjCF7+HyujrZmLdIyyHC9VSQJTLIP/1ftLA8
         CvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PYJ/JPYOG5ucGKjA38I3CRVtmJL7QZ9rHxnFtJwmdo4=;
        b=S8o4GAJ2coeoy38HQ8twH1/lxHSr+6UVeOtm+4zAcMBxmXyIpGIxidy/fTEBsJ4UZk
         ZZIskFilxfNGL7ub9+AhHdz8dZHFfJahOXnh9qJcNMvH4UgqO6JPQulT2dYV2U7UOSHO
         NAluu+DMpGyFZCMTbp/s2jAEVUvtGSyJ6/IhOd82KvbAReDdtv18iDPH9rN/DvFilq79
         jAElU5D8pmt2+GNOWvBF0lLP5kV9U9k2rgQbLxRFWr7JW2zOdetY5e+U44auO4DJ2Ptv
         4k1bWqsOT65qKbm9PSOXvxZ6viObbvBmmzIkJS4iVECModb3f9DQcEXj6HYgbt5fISbd
         YuAQ==
X-Gm-Message-State: AOAM5326VXC3Zoif9aazzfKhDE7D5M0FCNISfvhckRmT8HQO/i+ydROn
        kiIK0khdsib8QEsN8Uqbcis=
X-Google-Smtp-Source: ABdhPJxZH995n9lWJUJs4wLfTVHa1Ehz1gaWmEQ2RvUl9MQDkwyYSnwt1pZjr8qaOOZU8FaTstnAOQ==
X-Received: by 2002:a63:f252:: with SMTP id d18mr8912879pgk.20.1620377756710;
        Fri, 07 May 2021 01:55:56 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id y17sm4079735pfb.183.2021.05.07.01.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 01:55:55 -0700 (PDT)
Date:   Fri, 7 May 2021 01:55:53 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
Message-ID: <YJUAmUJiHmJRQBMj@generichostname>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <60949be8613c1_8c2220882@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60949be8613c1_8c2220882@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

On Thu, May 06, 2021 at 08:46:16PM -0500, Felipe Contreras wrote:
> Firmin Martin wrote:
> > Currently, git-format-patch, along with the option --cover-letter,
> > unconditionally overwrites a cover letter with the same name (if
> > present). Although this is a desired behaviour for patches which are
> > auto-generated from Git commits log, it might not be the case for a
> > cover letter whose the content is meticulously written manually.
> 
> This is one of the reasons I never use git format-patch directly, but I
> use a tool on top: git send-series[1].

It seems like everyone has written some sort of tooling on top of
format-patch at this point. Taking a cursory look at your tool, perhaps
a feature like `--previous-cover-letter <file>` might provide most of
the functionality that most tooling that I've seen gives.

Perhaps this option could parse a cover letter from a previous version
of a patch and use it to populate the next version number, In-Reply-To,
cover letter subject/body, To/Cc lists and maybe more. I think that
extracting the information would be pretty easy but designing the UI it
in a non-obtuse way would be pretty challenging.

> It would be nice if git format-patch grabbed the text of the body from
> somewhere, and even better if git branch learned --edit-cover-letter.

Well, you're in luck! I wanted the same thing a couple of years back so
I implemented the --cover-from-description option[0]. It allows the cover
letter to be populated by the text given in
`git branch --edit-description`.

-Denton

[0]: https://git-scm.com/docs/git-format-patch#Documentation/git-format-patch.txt---cover-from-descriptionltmodegt
