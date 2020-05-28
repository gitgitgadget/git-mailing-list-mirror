Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF3C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3369206E2
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWKqTuxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437720AbgE1Xxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 19:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437677AbgE1Xxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 19:53:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0E5C08C5C8
        for <git@vger.kernel.org>; Thu, 28 May 2020 16:53:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a45so1115552pje.1
        for <git@vger.kernel.org>; Thu, 28 May 2020 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BHBvxpZOuR++2lMcVBcaweMmDugHT6BIBpEaf/lXbCY=;
        b=QWKqTuxSHIAxDbIsEpnJtSVQrDbblR2I3x8+gHjxeWo08QrByNSBGC4lFFwoYt9qHn
         kUYas5oqUy2pB4j5zhw9cTyvzvhUmYIq7ADKZSlIptrQ62g+Z/r0O7eQ/e4J6QxwPDEt
         uqfAEEmuYD6uRZ7saLhEA5C7NLihNI0pG1EdAzYYEG6b+KxzFDmFp2P8i3GqQsdos2it
         +2bHlCt+1xUSNNYgE4ZWJ+E9o86JV6nh6Kf4D3VW441cYeBzs49uno3JK/ldI+mlAkyh
         o9AbhPdYeCy3lXYcU91MmXoZuPxhCooI/R5jOXxqxxi3XI08oW07hW//ZTy2UH0kIYA8
         ygLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHBvxpZOuR++2lMcVBcaweMmDugHT6BIBpEaf/lXbCY=;
        b=evohvCbIx9jEGBmlhTsqx7dDzMleenSCWP9OpNb2r9duKXYoey6WMNQjEEyvD9py3v
         ZwlO8ytRfZkS7b6b55zRuOo2Tds89HIB9Xkb/Yrb+OYj5gBKgBRz8anQbLJ7VZr2jMWe
         lj0tMod2SbfC/xtMUX/QBjf46Dd0lwjDICbu4qbH8ay7xNoJvtbpDPRo5UzdYWC06xAT
         gk0wR2k71oKKk2f9RSEUbifqaDgG33We71w9GQrr6AqRTJ1jCLGfyNnHqoTJS0WG0jRY
         1mamlMb8sstmKgEEqrnmnSkhBoXgmO6LKTnGEUginzKrEAupqYowes9oUWeZEnlwrXFq
         iuUA==
X-Gm-Message-State: AOAM5304dMYndsURlmCgMk8ioinw05DbHEqD3ZBD/zBxmvW68/5OnTzi
        qwsiqtabXAUYO6/7iNBsjLzSauAvDHU=
X-Google-Smtp-Source: ABdhPJyGnayIe12wKCJfJ1TG4h7UD//Urv6P1Ui2irrRM9KkffjOf00miSAO3Zhc7GCcL/eOMqxqqw==
X-Received: by 2002:a17:90b:f8c:: with SMTP id ft12mr6609361pjb.127.1590710018014;
        Thu, 28 May 2020 16:53:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id q4sm5953827pfu.42.2020.05.28.16.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:53:37 -0700 (PDT)
Date:   Thu, 28 May 2020 16:53:30 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [git-scm.com PATCH] community: advertise 'git-bugreport' tool
Message-ID: <20200528235330.GA148632@google.com>
References: <20200528231608.59507-1-emilyshaffer@google.com>
 <xmqqftbj1vpf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftbj1vpf.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 04:33:16PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >    <p>
> >      Bugs in git can be reported directly to the mailing list (see above for
> > -    details). Note that you do not need to subscribe to the list to send
> > -    to it. You can help us out by attempting to reproduce the bug in the latest
> > -    released version of git, or if you're willing to build git from source, the
> > -    <a href="https://github.com/git/git/tree/next"><code>next</code> branch</a>.
> > +    details). Note that you do not need to subscribe to the list to send to it.
> > +    If you are using git 2.27.0 or later, you can run <code>git bugreport</code>,
> > +    which generates a template to guide you through writing a useful bug report
> > +    and gathers some diagnostic information about your environment. You can
> > +    help us out by attempting to reproduce the bug in the latest released
> > +    version of git, or if you're willing to build git from source, the
> > +    <a href="https:/break/github.com/git/git/tree/next"><code>next</code> branch</a>.
> 
> It took me a bit more then necessary to spot this due to rewrapping
> of the string, but I do not think you meant "https:/break/" there.
> 
> Care to share how it happened (what tool has the tendency to
> introduce this particular breakage)?

Yes, I noticed it late. I have no idea how it happened - I imagine I
leaned on my touchpad (middle mouse paste) while typing or otherwise
mashed some keys in Vim.  In other words, the tool was me :)  Have fixed
it locally, thanks for spying it.

 - Emily
