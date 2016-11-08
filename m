Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9055B2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 01:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbcKHBj1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 20:39:27 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:35234 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbcKHBj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 20:39:26 -0500
Received: by mail-it0-f47.google.com with SMTP id e187so127107590itc.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 17:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+C8iv3Z4ygm0pbwy3PvNcYR8buIJ1pBs9RhjoBb/TsQ=;
        b=L4jsgna0Kb7FBXvNVzq6w4/UMWZ1PdffcZF1zZTN6h3IeFKasLBbiUiZ9wwEsXK4iE
         O65OYBMWoM1YbNaH3OJl1Ct/rj8wLCm7m4/54xWZsLisVO8hd3+D612dZmnbcT1P9LwF
         VWFoih4EmsKT3utKOadPYJDvQxDw7fZOrKZAxeziSXZFA6VxTPq2hLbE6IO9AJvxa1N2
         V0Q0maTn64Bhq8882rEdAk/F7QcA4F/FVyImPpWtkMG3M5CyueVbSPePi9Zlf8vw0Lu/
         xJ+yPJW/8QyPpV7IpaQ2QjBT4QQ7Beo5kJ0aaV/ZTDO7YxMd5kmp6QtvcqbedqOHuL1X
         xH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+C8iv3Z4ygm0pbwy3PvNcYR8buIJ1pBs9RhjoBb/TsQ=;
        b=ZITynhxesOZU9UC35/sy3zFuR2BHwJxKedEyldR9WR3Oq2bCKhgPAMqNujmBQWgHg/
         3KKgpbATzc9/enk0ofW5g5iST44OOZVLAoJe3mYjb4dqu+OYAW2CukGpybtQqcFiBqDW
         ncd365jqRfc4LnlNL448KoPiXAqpDDqKObsvvlMwK9iTuck1/EeLh1Sjjrrfc2VbADrq
         wlyZeJkw7OenWE0PFBHIwE9j+aBgJBWxuYUqCoZt/c39TAeaEdJeCs6At2Ij989ADrL6
         Nm3Lf6mx4b9Qdky/v4SaEFDZnRGiFfC0ldggffnnxJ8xOt2nRr6hpRZ5dSdozZeo4JXz
         ekzQ==
X-Gm-Message-State: ABUngvd3ESjav/1VEHTZZ/kXMK8AqxLOmfhM57iodJEyF8w7GIvo4WxPOJ75ZGIKw/IXc2f7OVr+rW32vG0N2w==
X-Received: by 10.107.132.74 with SMTP id g71mr10220298iod.19.1478569165710;
 Mon, 07 Nov 2016 17:39:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Mon, 7 Nov 2016 17:38:55 -0800 (PST)
In-Reply-To: <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net> <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
 <20161107211010.xo3243egggdgscou@sigill.intra.peff.net> <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 8 Nov 2016 08:38:55 +0700
Message-ID: <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree .gitattributes
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 4:15 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 07, 2016 at 04:10:10PM -0500, Jeff King wrote:
>
>> And I'll admit my main motivation is not that index/filesystem parity,
>> but rather just that:
>>
>>   git clone git://host.com/malicious-repo.git
>>   git log
>>
>> might create and read symlinks to arbitrary files on the cloner's box.
>> I'm not sure to what degree to be worried about that. It's not like you
>> can't make other arbitrary symlinks which are likely to be read if the
>> user actually starts looking at checked-out files. It's just that we
>> usually try to make a clone+log of a malicious repository safe.

This I can buy.

> Another approach is to have a config option to disallow symlinks to
> destinations outside of the repository tree (I'm not sure if it should
> be on or off by default, though).

Let's err on the safe side and disable symlinks to outside repo by
default (or even all symlinks on .gitattributes and .gitignore as the
first step)

What I learned from my changes in .gitignore is, if we have not
forbidden something, people likely find some creative use for it. As
long as it's can be turned on or off, i guess those minority will stay
happy.

> Again, I don't know that there is a specific security issue, but it
> makes things easier for services which might clone untrusted
> repositories (e.g., things like CI). They'd obviously have to be careful
> with the contents of the repositories anyway, but it's one less thing to
> have to worry about.
>
> -Peff



-- 
Duy
