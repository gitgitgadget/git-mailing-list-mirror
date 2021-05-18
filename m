Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA33C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 04:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE4061354
	for <git@archiver.kernel.org>; Tue, 18 May 2021 04:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbhERE2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 00:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhERE2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 00:28:46 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8683C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 21:27:27 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id h9so8600740oih.4
        for <git@vger.kernel.org>; Mon, 17 May 2021 21:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sf9AAPYABY/FRKaKoAq4HSt5GQYN6GrxON0+peSgzrE=;
        b=k9TEKKLk7pGL8t9CzJr0/XKjQdR5Y/CGfSXb17HuvxX/fazdQC+wih/a3T6k7F0OKn
         uFzIGh5BSxq5qowTSd1r3sgBGf7escuV52x6ekpYtnR5UqJsRNriT7J5NviR2BDRI0tV
         qANdUExlBaJ6Aly33eQh7a5V1S6xFRnCwHtF6DSXuIFR4RmlkXkx/sJxeNvtSdP6yLLC
         Vfn/y5IAzy2CJWaAsirbtLxz57n1VooAdNBkwNcAj3mSQRK38XWCCDwQtvBVplD9Gs87
         c5E4PGBpJ0ES9e92NO9MUeQLmrXxh2M5N5GF7xVaoA4L8uaqZKsZJWm2vEp4381rhx6Y
         YuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sf9AAPYABY/FRKaKoAq4HSt5GQYN6GrxON0+peSgzrE=;
        b=MF64iichkD1V45l1q9I+TZrwg7MrYtEEyTf2jnoKRQ05B0G5l/AIKi2eb6d/eo0F/L
         qukN8f1b7wn9OFclev6Q1E2GuX64Ab07EAu+f/Cn6ydpgy/tDAwgIRFBLdJTQfdbOe+7
         WYxnYGXHjMpcPb8qgInki4bmMwDlaee6Z5CjvJSzQ//R4paikgzmhn4varWuK7L7jp6T
         CmLrAsUOC8f1CgKjSjpkGtJVchIVyv/K1P5PXopvYT90Vzn1MwZb+4yMT8lbWB+gAE2y
         TWFTpQRGqKybx5CkoylkG1fNsF1yGWCrONKTUVHNT31JltK7YDUd8JHR0OKTnbtZANSJ
         zSzg==
X-Gm-Message-State: AOAM533QKfCwR8Kras7Ct++HgdK222d6N6G8SFOd7VEiWqSpSXn+cjqV
        kXCHDbRnDSNAbFszKXeGQuQ=
X-Google-Smtp-Source: ABdhPJx26Ho1FRqdu2amqhyV0sGPHa+CDeFC3zEMOGtZ8KJ0JG7/FsoTImE3H2RitH/WqV7evp5YKg==
X-Received: by 2002:aca:53d8:: with SMTP id h207mr1970289oib.177.1621312047092;
        Mon, 17 May 2021 21:27:27 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id y11sm3530557ooq.2.2021.05.17.21.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:27:26 -0700 (PDT)
Date:   Mon, 17 May 2021 23:27:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Message-ID: <60a3422b9556c_14d1bc2082f@natae.notmuch>
In-Reply-To: <xmqqim3g4ys5.fsf@gitster.g>
References: <60a046bd83001_f4b0f20861@natae.notmuch>
 <87tun1qp91.fsf@evledraar.gmail.com>
 <xmqqlf8d6ty5.fsf@gitster.g>
 <60a2f1c4cab0d_13c3702083a@natae.notmuch>
 <xmqqim3g4ys5.fsf@gitster.g>
Subject: Re: Man pages have colors? A deep dive into groff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > Why not use color.pager?
> 
> I dug a bit to refresh my memory and it turns out that the reason we
> should not do so is because it means something totally different.
> 
> color.[ch] defines want_color() that applications like "diff" and
> "log" can use to see if the application is configured to paint its
> output in colors.
> 
> When that layer says for that particular application it should be
> decided automatically, then we call into color.c::check_auto_color()
> which is the only user of pager_use_color (which is set from the
> color.pager configuration variable).  The purpose of that call is to
> ask if the pager is capable of colors.

That is not true. check_auto_color() returns 1 when the fd is a tty.

For example advice() would indirectly call check_auto_color() and no
pager is involved.

Inside the help built-in want_color(GIT_COLOR_UNKNOWN) will always
return 1 (unless you do something like `git help git > file`).

pager_use_color is completely ignored in this case.

It's used only when 1) the fd is not a tty, 2) it's stdout, 3) git is
using a pager... Only _then_ it checks for pager_use_color
(color.pager).

So no; the first purpose of check_auto_color() is to find out if the fd
is capable of showing colors, secondary, if we are using a pager, then
check the user configuration.

In the case we are using a pager it's not check if the pager is capable
of colors, the pager could be capable of colors and yet the user would
disable them: it's the check for the user preference.

> So in short, the color.pager is about "is the pager capable of
> colors?"

That's not the case.

Even the documentation says so:

  color.pager::
    A boolean to enable/disable colored output when the pager is in
    use (default is true).

> and the color.ui (and color.<cmd>) is about "does the user
> wants output from <cmd> in color?"

> Tying it directly to "color.pager" is wrong.

Why? color.pager is to enable/disable colored output when a pager is in
use.

The fact that it's man executing the pager and not git makes no
difference to the user.

Cheers.

-- 
Felipe Contreras
