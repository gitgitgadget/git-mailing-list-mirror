Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249CDC433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 18:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029C8613BD
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 18:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhD3SKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3SJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 14:09:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E311C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 11:09:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i3so57952706edt.1
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82/1/WrH6tHXmejxHYEp0chf2IXzZTh1/wGpq7FDgh0=;
        b=pTbgP7485lfe2eIZmQQgdFEnUjfQivVvfH+fEMbknr0KxFTpxddtoEZXUN6B/P5U9P
         ASb8hKmqf8aEsveOHcs1Wg+Vn9FK7UEhUSXTCBSFJ7iEU2QG85x4KfLHzShgrKVHLQ2l
         l5Ps8RzObi/zV3zLApXRIg2sYTZ80fHKyIJekO20Qcw4w41w5xTmmYo37v0/28sRx7AW
         YDadNfd6R6U3n2jqeXQT5fcjQ5pjuSWDF1j0tkHZBGay4RLpaK9X9XqHfRrOGKeK5Cyh
         x+xuoC7I+htJ6Gendu2JO4+wr40d/IH4RmhPBmPwAnZc1FEGvBS4MfCuc24MbFmuxdx9
         nNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82/1/WrH6tHXmejxHYEp0chf2IXzZTh1/wGpq7FDgh0=;
        b=pkyTSDHNDReQzDRijdrx5fiBLXFeqx9bliW2eWwuZ2/g/5tdnWKvpbnD92GOH8J+lH
         8wgnbShCbhH2+0vYxaXGOQEvhXKJWUe3uJtU63E/QihSv/a/75+/mslS+9XUz0Sq4zXR
         pJoyUjY7OMxYH5aXv4u/pXT7x2tLgAu/BX6VWEYMcopXL3nxQz1SYx/VhKg4sQq7GzKA
         6ck4eD+8JF2CWM+Ru6qJ1WbJTcPMUD8IjTUAyrSLcmE2uCctXu7c18TYRHAajYNz/cMp
         v2fUdabdLH/kfbbribmqRYY3Dz8YZPVtgBk/WLSHJySUPKt0ppkl3bPWQ49AH2zOvr6w
         3iRw==
X-Gm-Message-State: AOAM531WDBah/e8bHLOzqxtrfuaZq+fw0j3AFAF510jwto0xhBSISGwj
        sHiYAen7HK4foGtx97g7QV+yJtKIeSmkvzNWRuY=
X-Google-Smtp-Source: ABdhPJwfvo2tv7N9JKWzV4bGT+RslUwOeQSlrwon8ArAnLjc/aagp/6uOA+O3+4CuPfXEBUN4cEsHJrhKv+msIcgAMQ=
X-Received: by 2002:a05:6402:10c6:: with SMTP id p6mr7469496edu.241.1619806148107;
 Fri, 30 Apr 2021 11:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210412085251.51475-1-andrew@adoakley.name> <20210412085251.51475-3-andrew@adoakley.name>
 <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
 <20210430095342.58134e4e@ado-tr> <021c0caf-8e6f-4fbb-6ff7-40bacbe5de38@diamand.org>
In-Reply-To: <021c0caf-8e6f-4fbb-6ff7-40bacbe5de38@diamand.org>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Fri, 30 Apr 2021 11:08:57 -0700
Message-ID: <CAKu1iLWbmPrVjAcgLKP1yisjmVxJr+kKQWJLiqkRzh=aAzETwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
To:     Luke Diamand <luke@diamand.org>
Cc:     Andrew Oakley <andrew@adoakley.name>,
        Git List <git@vger.kernel.org>, Feiyang Xue <me@feiyangxue.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 8:33 AM Luke Diamand <luke@diamand.org> wrote:
>
> Tzadik - is your server unicode enabled or not? That would be
> interesting to know:
>
>      p4 counters | grep -i unicode
>
> I suspect it is not. It's only if unicode is enabled that the server
> will convert to/from utf8 (at least that's my understanding). Without
> this setting, p4d and p4 are (probably) not doing any conversions.

My server is not unicode.

These conversions are happening even with a non-Unicode perforce db.
I don't think it's the p4d code per se that is doing the conversion, but
rather an interaction between the OS and the code, which is different
under Linux vs Windows.  If you create a trivial C program that dumps
the hex values of the bytes it receives in argv, you can see this
different behavior:

#include <stdio.h>

void main(int argc, char *argv[]) {
    int i, j;
    char *s;
    for (i = 1; i < argc; ++i) {
        s = argv[i];
        for (j = 0; s[j] != '\0'; ++j)
            printf(" %X", (unsigned char)s[j]);
        printf("\n");
        printf("[%s]\n\n", s);
    }
}

When built with Visual Studio and called from Cygwin, if you pass in
args with UTF-8 encoded characters, the program will spit them out in
cp1252. If you compile it on a Linux system using gcc, it will spit them out
in UTF-8 (unchanged).  I suspect that's what's happening with p4d on
Windows vs Linux.

In any event, if you look at my patch (v6 is the latest...
https://lore.kernel.org/git/20210429073905.837-1-tzadik.vanderhoof@gmail.com/ ),
you will see I have written tests that pass under both Linux and Windows.
(If you want to run them yourself, you need to base my patch off of "master",
not "seen").  The tests make clear what the different behavior is and
also show that p4d is not set to Unicode (since the tests do not change the
default setting).
