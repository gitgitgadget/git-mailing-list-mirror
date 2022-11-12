Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50525C4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 08:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiKLI2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 03:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiKLI2k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 03:28:40 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C913F89
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 00:28:38 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id p4so7107140vsa.11
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 00:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqiNuyjbm9TJN7GEuPwKFfPUbaSMfYG98fsQdhXw+oc=;
        b=K5tk5bpWUrJZZXj/sYN8Y6fPSCHp4Fyts50Im8U00hw5DEQb5L8jUvhWT42CaQ+zZb
         Wi87DPqR1bni6gOtwHjRsLBymjB4am659AhOvKwZu57O2sivWz5kggLHY1jqyz6PEY18
         PIUqTmUKH3FPwcJpubqPUthYdBuOSO3z8W6z3wGuXBRJWU1QurnioUW7XxvHptxFieO0
         Osf5yynh6WM0DNO3AZtxRzDOBwUZgovARhOfgdkMXD0bZW5OBZZxz8YzGKtNbFdouSN6
         V1fjXxVJlCXAAybw5aYZnIDAVzOWC7Oax5YgeaRt7k/3kGsZ9TqqHHlWc4zlLeEGdYU9
         SwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqiNuyjbm9TJN7GEuPwKFfPUbaSMfYG98fsQdhXw+oc=;
        b=M1xTsdAXyBFz+HGE6v0jSjMdxo+Xj7a7VRSp6BxHHFhTmLWYZnUlRohrej67T9qLmH
         xVya6LJfTNkYnCFuBH0/wTXgpqUUkKZkEOrT34csyd6T0rlAf2nMYSLf0MfwaHsrll9F
         NqPRbeaIniqxaHMdMHOrDxkobhMdZ9jaYG85B4lrmjNRZ+3Dczf4viX0uqREBLgW5c33
         8bvYw4hNOgxdjLWjEf7LQHWjHWf6Aqsen4GLmYiVX74iM0AqWi7jbmawJV4HxZmtQAX3
         /m916g7cg+N78AaarDKmL1rq6P6PnPpyzzK5YRp6MnRPObsRyiAhAPSHtabe6M+NSNnM
         bOsQ==
X-Gm-Message-State: ANoB5pn23gDTIO8rjwqUuY7LEPSJtXJO+NQ2iajN4jQClfCaVnwU1CQE
        BDooDkEc+GQtz8tg0lPUwQdCqV+q7gx4xwZB22O4FBmP4kNehbAB
X-Google-Smtp-Source: AA0mqf6ZeHnDwhv/5uRW1NUBvOxb3hS0/XmxklmQMY2iTNTY37DZhaWz6lrnzEtTUxEgO2e5Ppk+QD8JtINIro8rpYo=
X-Received: by 2002:a05:6102:150d:b0:3aa:2ee9:3264 with SMTP id
 f13-20020a056102150d00b003aa2ee93264mr2291329vsv.85.1668241718084; Sat, 12
 Nov 2022 00:28:38 -0800 (PST)
MIME-Version: 1.0
References: <CABAGCCq-bFYX+9kU-GGWBstjMjOcO1nSQdi6Udugtkd2McO3Tg@mail.gmail.com>
 <20221112071313.GE1159673@szeder.dev>
In-Reply-To: <20221112071313.GE1159673@szeder.dev>
From:   Adam Lee <adam8157@gmail.com>
Date:   Sat, 12 Nov 2022 16:28:26 +0800
Message-ID: <CABAGCCpdKesUaNiJmH4w8OqTWbXiPNJ2tRM-XwPs6ndUpzEXbg@mail.gmail.com>
Subject: Re: [Bug report] git log shows a wrong history
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 3:13 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> 'git log' shows the commis in reverse chronological order by default,
> which means that if development happens on multiple parallel running
> branches, then commits made on different branches might be shown
> intermixed.
>
> And indeed the commit timestamp of f9c655 is between that of the other
> two:
>
>   $ git log --format=3D'%H %ct' |grep -A2 ^9ac9a7
>   9ac9a7fd4138988d744e0b5767883c06c20ffa6f 1657232286
>   f9c655d647427b45ae0d7bd9baf3551a013b8ea1 1657195677
>   fe0a9ddbdd7eee572f7321f9680280044fd5f258 1657177514
>
> (Using the seconds since epoch timestamp format here, because those
> three commits were made in different time zones, making their ordering
> by simply looking at them not quite that straightforward.)
>
> Showing commits in topographical order "avoids showing commits on
> multiple lines of history intermixed" (quoting the manpage), although
> at the cost of slightly more processing time:
>
>   $ git log --format=3D'%H %ct' --topo-order |grep -A2 ^9ac9a7
>   9ac9a7fd4138988d744e0b5767883c06c20ffa6f 1657232286
>   fe0a9ddbdd7eee572f7321f9680280044fd5f258 1657177514
>   5a9a4091ad1a187cec9d7da0faafac15b088fe60 1657172979
>
> > `git log --graph` is fine.
>
> '--graph' implies '--topo-order' by default.
>

Ah, I see, thanks.

I didn't expect that default behavior, looks so strange to me...

--=20
Adam
