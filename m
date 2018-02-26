Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962781F404
	for <e@80x24.org>; Mon, 26 Feb 2018 12:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeBZMeL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 07:34:11 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36415 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeBZMeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 07:34:10 -0500
Received: by mail-wm0-f49.google.com with SMTP id 188so16342841wme.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 04:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ghj5l7EFYNc8qNWp/cF2fJWUvwpkh5C6dLUJRg0RKVY=;
        b=X9wWJz6u1kGjkNbICINIvA10uZv5X45jQMX+XzoR3Qabkx29XL0nAjl9eEXu/8sB/9
         2Wd337+vRfMMTGLV3Q0A9Sj5oxy3MxmVQCLC2bRBMMn3CwURKhVN074dhX35Y8S5Ls/L
         tAf5sS5RmLWFNEC7xr/vzRC4BRwO0TmdEwsouRys173x/xLckQOrp7LbxOmVu3fBIYAr
         4WpjKfMRG0GxwFkvjLRj4ZWIC26iXz3M3EEceNzOVPuqjIhtSZer+G+QecyTrTUkI/+T
         7/UAcPfTAZkBu43DiT59leZU3ck9xSAk8KHcKtuZW2/dnBLr7AI+FCXIa0a6ZoXQDwKW
         5FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ghj5l7EFYNc8qNWp/cF2fJWUvwpkh5C6dLUJRg0RKVY=;
        b=ZIbSJ31lv97r03IXnmN6Rbq5lWdDeAS+Lsefg4GOkVvYROOCGQG/Qfw7dCFa68vzSe
         ZDIKB3JXuJkwCnyzhhUF4u7C/u+6ADnqSgATJW55uv9880rS6fMi2VzM3m2sF+lEiNo9
         msEg4M5p4lGpNKTJzttptA+qXVvuSNHK43BQDrY0iCuV6ORxV0c20IRVAneaYkzuRS7z
         nOhH0Lf5jBAO/e9sbUMbzSlyMtNsKr3EecjLf4WfySFjGO2E/x32yKObeNa4cMYOZZiJ
         IO2pQv5SJRsvEcvQKKDAYT3NFdLD27BfDxamUr8BBcFoRc3S6ruwPYKFeS42IkA9D5qV
         cfQw==
X-Gm-Message-State: APf1xPAHk7lk/J3ya/9S1eYW6Cn18bhIpLvsan332TUcpivfMz7qNjp1
        9VzZTKZRNqTjK6GzZmsQEFI=
X-Google-Smtp-Source: AH8x224Zs36bgu38s58LDPX8pQY2TZRQ166Nk9BemWml+AByJ4zFLCO6+RnLDBpK226eNYRdoUiwGg==
X-Received: by 10.80.224.72 with SMTP id g8mr14234784edl.218.1519648449185;
        Mon, 26 Feb 2018 04:34:09 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id y8sm7380127edk.43.2018.02.26.04.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 04:34:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] wildmatch precompilation interface
References: <20180225203537.28318-1-avarab@gmail.com> <CACsJy8COegzVZ99PqsfrDq=uPfQewEZKXF5WK3K6ah62QfQV9g@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8COegzVZ99PqsfrDq=uPfQewEZKXF5WK3K6ah62QfQV9g@mail.gmail.com>
Date:   Mon, 26 Feb 2018 13:34:07 +0100
Message-ID: <87muzwdj5s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 26 2018, Duy Nguyen jotted:

> On Mon, Feb 26, 2018 at 3:35 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> My recently landed wildmatch test series was in preperation for some
>> more major wildmatch changes.
>>
>> Here's another series that prepares for bigger changes in wildmatch,
>> it adds an interface to pre-compile the patterns. Right now there's no
>> point in doing this, and it's harmless since none of the codepaths are
>> that performance sensitive, but down the line this'll save us time as
>> we'll be able to skip re-parsing the pattern each time with a better
>> wildmatch backend.
>
> I don't see any big problem with this, but should this be a standalone
> series? Some changes look harmless now, but I'd rather see the real
> precompile implementation to see how it impacts (or benefits) the
> converted call sites.

Let's drop this for now sinceyou're on the fence about it, I wasn't all
that sure myself and thought I'd send it in for comments.

I don't have anything ready for submission from the rest of this series,
but figured (if you/others didn't mind) that it might be easier to
review the addition of the interface at first, but indeed, on second
thought that doesn't make sense.

The state of what I have is:

 1. <this tiny series>
 2. <WIP add the wildmatch compile interface to more stuff, notably dir.c>

    The dir.c use (and some tree-related stuff) are the real hot
    codepaths using wildmatch.
 3. <WIP Replace the wildmatch backend with syntax-compatible PCRE>

    This is somewhat of a mess right now. Preliminary tests reveal that
    the pathological case tested for by t/perf/p0100-globbing.sh is
    wildly faster, but that most regular matching is a bit slower,
    although that might be me being stupid with the interface.
