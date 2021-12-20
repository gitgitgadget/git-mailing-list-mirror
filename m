Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBDDC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 13:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhLTNL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 08:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhLTNL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 08:11:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B118C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:11:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m21so10911678edc.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QtBYBZ/QZrdMmVoLZfjfq7euI9xpj/WIuabdz8XDtqg=;
        b=NUibO5RqvwAIGdiL6XLHiVipLVR3I3OG68bmF9XDmcmsm12qsttSZ8GvqMuJFxAJyi
         eq2R78BfEPaJPCYmhKMsKenbEJFHMcvjkgRU/NBteM9mt2sPCqO8TQ2oxu2Pas9Ij8v/
         z3HPhbk3xhpiW93QnrwL7B92KbGYzwmIEgPN7kYLRo2Q+mVFrLPW5wjAe/1OnJ5bV/D4
         7S22s8Ca/i0T3jTqmIfXsK7utKRV5s3JUHrrYd0MTBTpQ+Le+md4H4JTQ/5JQxiinUDJ
         TZpDHgZTrVVb1cY8fpKxjHsX73IbkJn/I0REBqc1PFmlmiYh3M0+Zof64XVAqaDT6FTz
         rWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QtBYBZ/QZrdMmVoLZfjfq7euI9xpj/WIuabdz8XDtqg=;
        b=H7K02hhsQOtAAN7WAYAFOwgG7px7M9nknv4wjD00/1vrvyhVW6EyyvxkpzxNevCCWs
         jm5T15thcf3OgTVKukgkO0Zlpaa0yPi+8RxM6CLrMDeCDruiAwzpKa+AgXCgoyKLx+sP
         Y8mSnQ4TzviFpt6+ETOHVyGoX/1MFy4Se7xQd/hkaHlseCNXdHbs4XuhNkWPWdkkVRrV
         nHG2UlD+7j8H5gfb1yZ3UUig/hJoAwZrRolNaodmkyrkgCe6Q1+6+zlHen+Wgo9RA65f
         6CA/MJKDbQCMJyhROTmO9EAJ8VJ0MB+JVeS0N/Y1gZBGiC5tb7g+3lsQj8tlpI+KRmJE
         rLKA==
X-Gm-Message-State: AOAM530sMeowv5fW9HZA7BrejrjvRPXTmnuBMG83oIRR0K+iq8t3vF39
        vBHNG2lRb5+f3j9jI74eelg=
X-Google-Smtp-Source: ABdhPJx0PQ+8EvGihTw9su4+3ZQl4jAskak/AzF0pveU9b54iNY5t/FuG5HmdWIWsev717/3NfeJCw==
X-Received: by 2002:a05:6402:50ca:: with SMTP id h10mr15401406edb.70.1640005885632;
        Mon, 20 Dec 2021 05:11:25 -0800 (PST)
Received: from gmail.com (178.115.45.32.wireless.dyn.drei.com. [178.115.45.32])
        by smtp.gmail.com with ESMTPSA id l18sm5353064ejo.114.2021.12.20.05.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 05:11:25 -0800 (PST)
Date:   Mon, 20 Dec 2021 14:11:21 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] t/perf: do not run tests in user's $SHELL
Message-ID: <20211220131121.mdxe7o6p3y25fzbw@gmail.com>
References: <f22f978a-26eb-8fe9-cab4-3fd60df69635@web.de>
 <211220.86bl1bwkp9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211220.86bl1bwkp9.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 12:56:58PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, René Scharfe wrote:
> 
> > From: Johannes Altmanninger <aclopte@gmail.com>
> >
> > The environment variable $SHELL is usually set to the user's
> > interactive shell. We never use that shell for build and test scripts
> > because it might not be a POSIX shell.
> >
> > Perf tests are run inside $SHELL via a wrapper defined in
> > t/perf/perf-lib.sh. Use $TEST_SHELL_PATH like elsewhere.
> >
> > Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
> > Acked-by: Jeff King <peff@peff.net>
> > ---
> > Original submission:
> > https://lore.kernel.org/git/20211007184716.1187677-1-aclopte@gmail.com/
> 
> This LGTM & I think it could be picked up as-is.
> 
> Just a nit in case af a re-roll. I think it would help to summarize the
> history a bit per
> https://lore.kernel.org/git/YV+1%2F0b5bN3o6qRG@coredump.intra.peff.net/. I.e. something
> like:
>     
>     In 342e9ef2d9e (Introduce a performance testing framework, 2012-02-17)
>     when t/perf was introduced the TEST_SHELL_PATH was not part of
>     GIT-BUILD-OPTIONS.

(but SHELL_PATH was, which is what we should have used back then)

>     That was added later in 3f824e91c84 (t/Makefile:
>     introduce TEST_SHELL_PATH, 2017-12-08). We will always have that
>     available in perf-lib.sh since test-lib.sh will load it before this code
>     is executed.

yes that's a good thing to point out

> 
> >  t/perf/perf-lib.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> > index 780a7402d5..407252bac7 100644
> > --- a/t/perf/perf-lib.sh
> > +++ b/t/perf/perf-lib.sh
> > @@ -161,7 +161,7 @@ test_run_perf_ () {
> >  	test_cleanup=:
> >  	test_export_="test_cleanup"
> >  	export test_cleanup test_export_
> > -	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
> > +	"$GTIME" -f "%E %U %S" -o test_time.$i "$TEST_SHELL_PATH" -c '
> >  . '"$TEST_DIRECTORY"/test-lib-functions.sh'
> >  test_export () {
> >  	test_export_="$test_export_ $*"
> 
