Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190FDC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1A420661
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIxLoWWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgAPTZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:25:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35021 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgAPTZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 14:25:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so20336726wro.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 11:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCsPVMZeL7Ad8EL5Ued9U2qM1VurdY+/zEbF7MknVqE=;
        b=JIxLoWWVicQ0RV4iXRHlG6yRyYfx4aKL0mPouPzIdjL3XWW8hfBlRrU60c+gFVXTf/
         LikdjpCG/WK0sS0T/SWl63obmKNWP5k2XQytgVYnBdCFmyXP3GOuqTgUdmfuilvERu0g
         lqxtzuFSbUy9xP6dPLZ7rHlJu0N40tAQURCreHnSstUBL0VjvYBQH93jIzklu84rFSPU
         jbhtcHaB1frGS30pAQpWhAXKWeSXlzwrl8Wfgiv9Q7mMFZRsGIza5cpQdOoN9EbFRQgI
         0GgWElWX3skpCeBfej2GPf2mVSLlLV54OFPosxZmTs1WQNjmmE4tyDqc+aCEWBdWKH44
         q3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCsPVMZeL7Ad8EL5Ued9U2qM1VurdY+/zEbF7MknVqE=;
        b=UB6pNGCTVJ1yC7w7MzMKSL1v0pdXxEA4fVIoGiiNyuyoQSPQFgIdcEDJCQncnTJPs6
         ha8OX/pMtbqqFl1OI6oqNs1+AKa/vetdN66gIDddIlVzEQQjqo6rPDVdQjexEHfMIINO
         esM/kqglHnDvHMwabPsH74fIGHkqUTggW6Nm4bx9XZ9+zCsBOFC5LMN7m8EU3l5Ju3uK
         HVLAqMi1kjorwanudo9d94ANTaXTxerJuxlk03nHGrq5BKQlFbnOkdOxgJC8or+Jj/b3
         0xzqTBFp5o4e+Mhl1PqdsFt/qotkt4HykgnpbtoNxpvJ0jD1uKTXtS5tUQcK/8JgK5aP
         2cnA==
X-Gm-Message-State: APjAAAWDRd609hZvxi3XzuAZtyf9FSqlggD94AekGkKet5G1NLFCEggb
        WiENMIcfSHkKaDxWnQjBiYlHj+tURcEUhsPlm+IAbbGbPhQ=
X-Google-Smtp-Source: APXvYqzzBoNYj48WKpOcS9teahi5WLFx9/2fl+N90Uy9rdlnwpeJ68m48Hg5vhQA30UpO3UwgwgjN2r+B/p0i97cAug=
X-Received: by 2002:a5d:5403:: with SMTP id g3mr5003176wrv.302.1579202740722;
 Thu, 16 Jan 2020 11:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20200110111516.GA474613@coredump.intra.peff.net>
 <20200110150547.221314-1-shawarmakarma@gmail.com> <xmqq5zhbi8l3.fsf@gitster-ct.c.googlers.com>
 <20200116182331.GA2946050@coredump.intra.peff.net>
In-Reply-To: <20200116182331.GA2946050@coredump.intra.peff.net>
From:   Eyal Soha <shawarmakarma@gmail.com>
Date:   Thu, 16 Jan 2020 14:25:29 -0500
Message-ID: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] color.c: Refactor color_output to use enums
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My original version of the change extended the enum to include both
COLOR_ANSI and COLOR_AIXTERM.  That preserves the 0-7 value and
instead adds more branching to figure out if you want to add 30 or 40
or 90 or 100.  All that extra branching didn't look great so we
instead used COLOR_ANSI for both.

I think that adding a bright flag to the color struct would be a poor
choice because it doesn't mean anything in the context of COLOR_256
and COLOR_RGB, as you've pointed out.

Having an argument to the color_output function called "type" that is
a char is really obtuse, especially considering that c->type exists,
too!  Perhaps the best way would really be to have a boolean argument
called "background" indicating if the color is meant to be foreground
or background and then let color_output do the math to add or not add
10.

Thoughts?

Eyal


Eyal

On Thu, Jan 16, 2020 at 1:23 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jan 16, 2020 at 10:01:44AM -0800, Junio C Hamano wrote:
>
> > Not that I agree with the (untold) reasoning why we chose to use
> > 30-37 instead of 0-7, though.  If this were up to me, I would have
> > rather defined COLOR_BACKGROUND_ANSI = 40, kept .value to 0-7 and
> > passed COLOR_{FORE,BACK}GROUPD_ANSI to callers of color_output().
> >
> > Since I haven't seen 2/3 and 3/3, perhaps there is a good reason why
> > this step was done this way instead, though, I guess.
>
> Yeah, it becomes more clear in patch 2, where the value can be either
> "31" or "91", for the bright or non-bright variant, and adding "30" is
> wrong. (But certainly I agree this needs to be explained here).
>
> Another way to write it would be to store 0-7 in the value as before,
> and then add a separate "bright" flag to "struct color". And then the
> output becomes:
>
>   COLOR_FOREGROUND_OFFSET + c->value + (c->bright ? COLOR_BRIGHT_OFFSET : 0)
>
> or similar. One minor confusion there is that COLOR_256 and COLOR_RGB
> would ignore the "bright" field.
>
> -Peff
