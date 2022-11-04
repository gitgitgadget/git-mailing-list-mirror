Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4FFC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 14:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiKDOHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiKDOHg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 10:07:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167AC2FFF7
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 07:07:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i3so4595883pfc.11
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CtZL01qYzPvMY+nvpAWv/xNntDnYlOGFuZDb42e//M4=;
        b=g9FGbbFJF3Fi8ikZtWzFQlYLDlw6k2DMJZ6JKLbQzJNuMhSGcJGfhDtXDeUkp6/iI9
         RTaPJfPOtsTO/rjfh71uyk1qUGBzLa9VSMlFc45AsIOWO7usM2uMDuZjh9L3BXRapMXy
         y2QGeEogZKbP3lprFtVzdKahlPBrSLLbcIFoNWQOqkkLOxGE4Yca4YsBwULnQvBO/TEO
         4iYmuWe/mTVhmVfqQfJGqU2HZiVgQF9KN0Y7MIGfPmd2tG2urUeP9EGqEJQBrgsl7h0V
         agU5xVRf/xMkskAmqbR+72GiZMhBOWTMZpjqC0nSXJecQVnLzQHv7SZfCvfqprac9pjS
         0B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtZL01qYzPvMY+nvpAWv/xNntDnYlOGFuZDb42e//M4=;
        b=n4i+1WZx4sHJF3ztdSu/RGKUJL2mbBIQ7VC19PvWRklQJ64XzfZ6/+vcWw62S3HuXO
         oD5nEB8tEtEOGFBoox1ORKGzoRfpmnQPMDCkOV3ghwsHYp9xCG8rBh2vil4H4yWgPZp2
         FfF9ojJg+FxlY4w847dWsayWX14/yzoL2v9FoTaXKE/5QVFUh/yLeXfq1bl2Hw4ZXGwd
         x0mUzZc8Et8FovxsiVwjqxdu3k1FQPTqOFoZNypMABHXOeqTR3S0mbilC9M8zQFrKXUv
         p1PDsEXQplNK3EZ94Pr+u5qKaTvDwLURbGXoqH0QhbKOI7zH2eS7BE1m2gQNrzvurtH2
         5Z+A==
X-Gm-Message-State: ACrzQf1sb3K82kzp7ykAp0SvyUagIH3BGTCIPAkp8we9kKCIfzIQw3Hv
        QHwD2Hd93OmAbFaFP9w0No4=
X-Google-Smtp-Source: AMsMyM5u5lZgJ2mH7aQLSWBDkdUaHIxsXHc8/Bzg04f7NHkPuZx+m23+MwDcCJUKAT21EuJ5cHEBSw==
X-Received: by 2002:aa7:88d5:0:b0:56d:8d62:5f44 with SMTP id k21-20020aa788d5000000b0056d8d625f44mr25351196pff.72.1667570838452;
        Fri, 04 Nov 2022 07:07:18 -0700 (PDT)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b0018099c9618esm2663313plc.231.2022.11.04.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:07:17 -0700 (PDT)
Date:   Fri, 4 Nov 2022 21:07:15 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] bisect--helper: parse subcommand with OPT_SUBCOMMAND
Message-ID: <Y2Uckyj2JlpsxetS@danh.dev>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover.1667561761.git.congdanhqx@gmail.com>
 <76c585d22bf415e719762fcf5decf4b71efa5bfb.1667561761.git.congdanhqx@gmail.com>
 <221104.86mt96ygj9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221104.86mt96ygj9.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-04 14:46:18+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Fri, Nov 04 2022, Đoàn Trần Công Danh wrote:
> 
> > As of it is, we're parsing subcommand with OPT_CMDMODE, which will
> > continue to parse more options even if the command has been found.
> >
> > When we're running "git bisect run" with a command that expecting
> > a "--log" or "--no-log" arguments, or one of those "--bisect-..."
> > arguments, bisect--helper may mistakenly think those options are
> > bisect--helper's option.
> >
> > We may fix those problems by passing "--" when calling from
> > git-bisect.sh, and skip that "--" in bisect--helper. However, it may
> > interfere with user's "--".
> >
> > Let's parse subcommand with OPT_SUBCOMMAND since that API was born for
> > this specific use-case.
> 
> If we go for this approch over my series, let's pretty please...
> 
> > +		OPT_SUBCOMMAND("bisect-reset", &fn, cmd_bisect__reset),
> > +		OPT_SUBCOMMAND("bisect-terms", &fn, cmd_bisect__terms),
> 
> Not call this "bisect-reset" etc, but just "reset", the whole point of
> the greater problem here is...

Yes, we should strip "bisect-" from those sub-commands.

> 
> > -		git bisect--helper --bisect-start "$@" ;;
> > +		git bisect--helper bisect-start "$@" ;;
> 
> ...to be able to eventually remove this shimmy layer completely,
> which...
> 
> >  	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
> > -		git bisect--helper --bisect-state "$cmd" "$@" ;;
> > +		git bisect--helper bisect-state "$cmd" "$@" ;;
> 
> ...as you can see in my
> https://lore.kernel.org/git/patch-12.13-13745e3f18f-20221104T132118Z-avarab@gmail.com/
> we still need to handle this special snowflake, but...
> 
> 
> >  	skip)
> > -		git bisect--helper --bisect-skip "$@" || exit;;
> > +		git bisect--helper bisect-skip "$@" || exit;;
> >  	next)
> >  		# Not sure we want "next" at the UI level anymore.
> > -		git bisect--helper --bisect-next "$@" || exit ;;
> > +		git bisect--helper bisect-next "$@" || exit ;;
> >  	visualize|view)
> > -		git bisect--helper --bisect-visualize "$@" || exit;;
> > +		git bisect--helper bisect-visualize "$@" || exit;;
> >  	reset)
> > -		git bisect--helper --bisect-reset "$@" ;;
> > +		git bisect--helper bisect-reset "$@" ;;
> >  	replay)
> > -		git bisect--helper --bisect-replay "$@" || exit;;
> > +		git bisect--helper bisect-replay "$@" || exit;;
> 
> ...instead of doing all of this, get rid of most of this case statement, and just do:
> 
> 	bad|good|...)
> 		[...]
> 	*)
> 		git bisect--helper "$cmd" "$@" 
>                 ;;
> 
> >  	log)
> > -		git bisect--helper --bisect-log || exit ;;
> > +		git bisect--helper bisect-log || exit ;;
> 
> But note that there are subtle behavior differences in some,
> e.g. because we do the "|| exit" we'll eat the exit code, and this one

No, there're nothing different between "|| exit" and simply run the
command, since "|| exit" will exit with old exit status code.
I don't think there're any other different.

> also doesn't get parameters, so it should be left out of such a list
> (see tests in my topic for a regression check for that, we're currently
> flying blind in that area).
> 
> > +# We want to make sure --log is not eaten
> > +test_expect_success '"git bisect run" simple case' '
> > +	git bisect start &&
> > +	git bisect good $HASH1 &&
> > +	git bisect bad $HASH4 &&
> > +	git bisect run printf "%s\n" --log >my_bisect_log.txt &&
> > +	grep -e --log my_bisect_log.txt &&
> > +	git bisect reset
> > +'
> 
> Check out my 1/13 to see all the cases you missed:
> https://lore.kernel.org/git/patch-01.13-beb1ea22a27-20221104T132117Z-avarab@gmail.com/
> :)

-- 
Danh
