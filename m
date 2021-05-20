Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CD3C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 13:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033096121E
	for <git@archiver.kernel.org>; Thu, 20 May 2021 13:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbhETOBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 10:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243547AbhETOAH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 10:00:07 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577DC06175F
        for <git@vger.kernel.org>; Thu, 20 May 2021 06:58:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j75so16423797oih.10
        for <git@vger.kernel.org>; Thu, 20 May 2021 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ACtF0REr4MHiN4NcryBTBLzZRAhSTlqMhPolhqjzzn8=;
        b=mABNC17wFDFftNAoyoraHWr1dggKqPxBt6uNUXa2GK2TkpOESSW5n01c/RjEIMOUpe
         7yk8cRjCCw4zKaTNZoJVXR/rj0deaX/BtqtxAdQn86VWcrzMT4O9xIeFSvESvUWUHj9b
         3aeblkOV9cns0EvwnFJgoYHAs+tV2FTdjeVumyPQDHAxqJyOZvfApsIgOqI3JLjLTCFp
         FnZUXPJcnG2/wVvEUhVN6hG7MYWW8ggJnMgzH7yH+a9HlNGJ8tU8arCAKxdUTB/621dD
         FCFL3a2seJS29dv7cyjx1Yb6vaxZRscX1zVvI8hZbdBTTWmAcM3zNJV068VLnqa6wIVf
         3+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ACtF0REr4MHiN4NcryBTBLzZRAhSTlqMhPolhqjzzn8=;
        b=Fp7pVJiq+uvFN2O/XiSuoPkWF/0DMiik+aP6aigsHmzo6S0L0TKdt9+b8ZCmy+M1fd
         dKgmHTpmW/0wb9/PVTB3gbbl/T/Ug1c1KOBmSjgJQwD2I2Q2kRHanh6J6YJGMCCci0BG
         1uom+U+uk/UMxzWqIlGsZ9uRIDuqmZq85dYQr7T922ZrbzzuGTz4f0vm4OU83UuBTDj1
         cpT7u/KE1KrPlbyOzudCVOTRYrOcUTJ1WLPmObTgywvgAFq3DmkD4sNPPGjiz6ge388Q
         sBR6ZnzOGdlYTIVSjuI8+08XbEN2XQQUXk0RELBQnA448lO4UgmJGb5cJ6ffmGq2z6fM
         7pPw==
X-Gm-Message-State: AOAM530swffWMGYdPGEmQUGWEXSoUZl6Avq92yKX1lyprj4V/O9+xVuw
        eqI6NLY2e52ScZ/guImF3Uo=
X-Google-Smtp-Source: ABdhPJxjLDoPP1W0HEXiONxCvV8yyjBl+5A+EEHuyOanUXBMMjmKQ/ei64xMvTPtwLdUBXu9mLHQfA==
X-Received: by 2002:a05:6808:10d0:: with SMTP id s16mr3331819ois.10.1621519123613;
        Thu, 20 May 2021 06:58:43 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id q63sm576142oic.15.2021.05.20.06.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:58:43 -0700 (PDT)
Date:   Thu, 20 May 2021 08:58:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a66b11d6ffd_2448320885@natae.notmuch>
In-Reply-To: <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
Subject: Re: [PATCH v4] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 20/05/2021 05:07, Felipe Contreras wrote:
> > We already colorize tools traditionally not colorized by default, like
> > diff and grep. Let's do the same for man.
> 
> I think there is a distinction between 'diff' and 'grep' where we are 
> generating the content and help where we are running man

It makes a difference for git developers, not for the user.

The user doesn't care how the output of `git grep` was generated, all
she sees is that it's different from `grep`. It's in fact more
surprising than a difference in `git help` because it's even the same
comand.

Maybe if the command was `git man` they would be equally surprising, but
it's not, in fact, `git help` can be used to 1) output directly to the
terminal 2) view in a browser, 3) view in info program, 4) view man page
in woman, 5) view the man page in koqueror 6) view the man page in man.

Only in one case among many would the user expect to see man, therefore
a colorized `git grep` is more surprising.

> > Our man pages don't contain many useful colors (just blue links),
> > moreover, many people have groff SGR disabled, so they don't see any
> > colors with man pages.
> > 
> > We can set the LESS variable to render bold, underlined, and standout
> > text with colors in the less pager.
> > 
> > Bold is rendered as red, underlined as blue, and standout (prompt and
> > highlighted search) as inverse magenta.
> > 
> > Obviously this only works when the less pager is used.
> > 
> > If the user has already set the LESS variable in his/her environment,
> > that is respected, and nothing changes.
> 
> However if they have specified the colors they would like by using the 
> LESS_TERMCAP_xx environment variables that the previous versions of this 
> patch used their choice is overridden by this new patch.

That is true. We could add a check for that:

  if (getenv("LESS_TERMCAP_md"))
          return;

However, it may not be necessary since many of the tips online set these
variables inside a function.

> I've got LESS_TERMCAP_xx set and running
> 	LESS='Dd+r$Du+b$Ds' man git add
> changes the output colors

You have them set in the environtment? Not inside a function like
man () { ... command man "$@" } ?

> > A new color configuration is added: `color.man` for the people that want
> > to turn this feature off, otherwise `color.ui` is respected.
> > Additionally, if color.pager is not enabled, this is disregarded.
> > 
> > Normally check_auto_color() would check the value of `color.pager`, but
> > in this particular case it's not git the one executing the pager, but
> 
> s/git the one/git is not/

You mean s/it's not git/git is not/

Fine by me.

Cheers.

-- 
Felipe Contreras
