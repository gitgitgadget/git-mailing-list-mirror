Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1C2C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 03:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE2222D5A
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 03:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbhAQDkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 22:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbhAQDke (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 22:40:34 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E32C061573
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 19:39:53 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q25so14120514oij.10
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 19:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLMGGHWFuT+coK/3vWGYYJsDzhpdoZW/3CPkbVgeQ+o=;
        b=KKNhbU/zo1taiJpbW6d/GVJ2/5uTYDCmSNF5N4XbdOoPpqv+zNTbq8tsqITIHK4/bY
         NYjALhSRj4CnX5FIBqzSh6ZPZzlZ4pzs9gd1Nphbe7ixkT7mvoO9PFvNT8E3e0+EyPYH
         98khAtjCgyut3B53jE55sotSePy0VmIaI618GOIq/zGSwv7A62SzwgGc8mNXOwLqAALh
         UoIJMIUvBiJs/Y2bFmbpjRc7+p/FtV8yOWM6TiuJpG/aCqScJih5/axU7JDOTI0iACIA
         b+BAh1OgI6a5b8yAv2oia+fXi2a1KOzEun49jdJAO6WJofJace8zmA2868CjyhsBCDk0
         Steg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLMGGHWFuT+coK/3vWGYYJsDzhpdoZW/3CPkbVgeQ+o=;
        b=QC+AqACgkizBGs/Qc7aX4lUQXnmS4CSDRiJIiBQUZSrZm977HNLtKcOgytzAW4pmUD
         9EvhNMtR5AXaw/irUVRr17NYhIXVrTMzoiIwrqFsiDjkz/ODVgqW2xectVoXwgtORq/7
         v2uT0wh1d6/qbzToGgMspXIWblfQ4DdOgR3bRl9EEC1vTWYtalE/TBmopw9ti9glgkp3
         xvMyEIMDHCC6/Cth6Xq/i43fUi196YcN5n6piAkfYk/vQbp5m7c2TwP0s0aD23jgopLD
         EII0M3DWZDxWgB591FTeiN2Ccut9qavFgZS/MCZvaPIdTNXELA+zX+mZpb7nUbS67Tkn
         pjFg==
X-Gm-Message-State: AOAM530BUjUvHwnCijOc99g12OpsF4UdEJDSALhWPgdAzWtSl8wpUtxa
        gis3NwzoEPy2ADYEgc7LjtbvGWIFDmjvbvHcxVE=
X-Google-Smtp-Source: ABdhPJy4tm8CpW8niLDzJ6KEgauzE8QF5yfCO2bij/sGA2L3QBwbCOjBTe2q4XkV6c94GYgTpuqU50qoEIzx+ov+ads=
X-Received: by 2002:a54:479a:: with SMTP id o26mr9833253oic.48.1610854792175;
 Sat, 16 Jan 2021 19:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-4-charvi077@gmail.com>
 <X/9DdGnYo7RQz5CE@nand.local> <CAPSFM5fuT0QAK9wJ_HuH3t=qThPx7Opwy0GrYieVntJ8A4ARMA@mail.gmail.com>
 <abc9334d-a9ec-a041-aa04-16cb4f01372a@gmail.com>
In-Reply-To: <abc9334d-a9ec-a041-aa04-16cb4f01372a@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sun, 17 Jan 2021 09:09:41 +0530
Message-ID: <CAPSFM5eZ=_yaeNmF_SnL2jx+Tz4HdgROF=SjhbL=UbB75eFHxA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip and Taylor,

> [...]
> >>> @@ -224,7 +223,7 @@ test_expect_success 'auto squash that matches longer sha1' '
> >>>        git cat-file blob HEAD^:file1 >actual &&
> >>>        test_cmp expect actual &&
> >>>        git cat-file commit HEAD^ >commit &&
> >>> -     grep squash commit >actual &&
> >>> +     grep "extra para" commit >actual &&
> >>>        test_line_count = 1 actual
> >>>   '
> >>
> >> Worth checking that "squash" doesn't appear in an uncommented part of
> >> actual? Or better yet, checking that "# squash ..." _does_ appear.
> >>
> >> I.e., that we would leave this as:
> >>
> >>      -   grep squash commit >actual &&
> >>      +   grep "^# squash" commit >actual &&
> >>      +   grep "extra para" commit >actual &&
>
> This test is checking the message that gets committed, not the contents
> of the file passed to the editor. I like the idea of checking that the
> squash! line is indeed commented out, but we'd need to test it with
>
> grep -v squash
>

It seems to me that you suggest to use 'grep -v squash' instead of
grep "^#squash". So I added to check the test as here:

             -   grep squash commit >actual &&
             +   grep -v "squash" commit >actual &&
             +   grep "extra para" commit >actual &&

> Looking at the changes to the tests in this commit it highlights the
> fact that I don't think we ever check exactly what the user sees in
> their editor. We do add such a test for the new `fixup -C` functionality
> in a later patch but perhaps we should improve the test coverage of the
> squash message presented to the user before then.

I agree and in this test  it's now just checking if the commit message body of
"squash!" i.e  line "extra para", is added in commit message or not. So, I am
doubtful if the above is the right way to test whether squash! line is commented
out or not , as "grep "extra para" commit >actual &&" will rewrite the
'actual' file.

Thanks and Regards,
Charvi
