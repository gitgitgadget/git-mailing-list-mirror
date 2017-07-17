Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4279A20357
	for <e@80x24.org>; Mon, 17 Jul 2017 17:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdGQRuB (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 13:50:01 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33388 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdGQRt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 13:49:59 -0400
Received: by mail-pg0-f42.google.com with SMTP id k14so83529932pgr.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hJ2dS2w9Cziu7Sj2jWz4dv/91Ts1jJ4ScVE1QyhCn4E=;
        b=HL5Z3jeFP0HGR3xUy0V/28xWNxLy3YUWbnJuulU9M6MZwHIrncqO+ODqakL+jaqL65
         6xDxDhxU1CYqCutnCHstvDSUdGgVLBVnYW4lj/Ml81E5raqpDGg9IyFW0h26BSI2e85b
         Q7v0Ga7MniqeZotLK/HbNt/Tm3RBNtFmfw/Md8mVTt7WxGT0EeaHqn+hZvV0XNS7+37M
         ImCyJ8mHJNcKdphW1e5BcIgbRyhOCHQC9lR8nQBEeXHYRSE/7j3oJur4OoKTTQUjF0/b
         2dGhaBx9VnfnSaSdpRvw+l2QPkjNyO/Nf2dxx7conVQUyh9i4c+JV+wQHSiFqN9LxYaY
         oKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hJ2dS2w9Cziu7Sj2jWz4dv/91Ts1jJ4ScVE1QyhCn4E=;
        b=ZCr1Kul+2unqi5kgEkE3GUK/x5XHfmMt/FsRSiynRAB0WK2scISIIM9ClXfGHktCds
         X2IKna5Ce3Y9StDPI9CraM+eM6+7ufzYCcyFTPn/kG6DK9kxumt54hQvhjr3sj1EBd/e
         1UBODyQWSZGHTy2PMlctWd0W1FDeTf39CT7qQt/BrIMGey9htXA5/6RjPHKb2o5EectE
         MYvD7ofSWh+/sd1VpukqAc/RuDsDprqKKDiVLJlufJ5Y7e+ktRYWpJvJaH5F+yTSb5do
         Ywo6OfVG+3RFbuszjo3BsSHS3UJK9KjtyEj+8VNALp9BtpqCKFSe/tZ/WkFUyNJvoY/v
         FoDA==
X-Gm-Message-State: AIVw112qOgCsIPEQhEuDvbcDhXPTijjkWBAA2eu1EGqVIksLubRsOMx4
        C0YQy1ZtQYkyWiRfii5vVggWIVnurJ0bVrEgOA==
X-Received: by 10.98.147.142 with SMTP id r14mr20546399pfk.150.1500313798931;
 Mon, 17 Jul 2017 10:49:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Mon, 17 Jul 2017 10:49:58 -0700 (PDT)
In-Reply-To: <41004589-4a98-2084-b542-51b7458f607b@durchholz.org>
References: <41004589-4a98-2084-b542-51b7458f607b@durchholz.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Jul 2017 10:49:58 -0700
Message-ID: <CAGZ79kYvup5yOqsgbphwvQe-2sKfXO3a8E1S548WLOXRp4SB_g@mail.gmail.com>
Subject: Re: Detect invalid submodule names from script?
To:     Joachim Durchholz <jo@durchholz.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 4:17 AM, Joachim Durchholz <jo@durchholz.org> wrote:
> Hi all
>
> I'm hacking some script that calls into git, and I need to detect whether a
> repository was configured with a submodule name that will work on "git
> submodule init" and friends.

There is no such a thing as "git submodule valid-name" unfortunately.
Looking through "git submodule add", I think it is safe to assume
that any string valid as a subsection in git-config is a valid submodule name.
Our man page says:

    Subsection names are case sensitive and can contain any characters
    except newline (doublequote " and backslash can be included by escaping
    them as \" and \\, respectively).

I am not sure about the quality of submodule shell code to handle the quotations
for double quote and backslash correctly, so I would suggest not using them,
either.

> I *can* run a git init and see whether it works, but I need to be 100% sure
> that the error was due to an invalid submodule name and not something else.
> Bonus points for every version of git for which it works.

I do not think Git offers a universal solution across versions except actually
running "submodule init" and then making an educated guess if the error
comes from bad naming or something else.

This sounds like you're taking user input or otherwise untrustworthy data
as submodule names?

Thanks,
Stefan

>
> Any suggestions?
> Thanks!
>
> Regards,
> Jo
