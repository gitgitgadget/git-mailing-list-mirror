Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A163F1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 16:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933348AbeB1QW2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 11:22:28 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51078 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeB1QW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 11:22:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id w128so6179265wmw.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 08:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S2YSX0+qnwRaRcXTI020grcG3Af3n0Mc3VUmOhbnGJg=;
        b=R4YoARj1LdT3FvW0kyn/rnHCZZTO9y1ibSWmPQfqlRRF6SI1CpQiOrXERLuTDKVTF9
         VcJiA4awGesnkabR9eXVAQr7cJIGElere9TZAQH1kyJ0hseNxnmWxFLOhk2+v5m33l8u
         z7ttaO4eqN0JYWNtmNG2+qhKySJ/R9xMduRLvS6hY+zY36MwmXXwDiC0wUV0wF4ZSj6a
         v4Qm6S4hTYu0evRf1WykKfuTXV1b9R0BAdnwRTUZ3wBiffjBB2CZEgk0gmdvLY10wSb3
         Zct02rinRVPgmvfKz2wqCWQraDLl30koa4Mf3azyubWCB22sxGbV06VsSlbbbxescb59
         wtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S2YSX0+qnwRaRcXTI020grcG3Af3n0Mc3VUmOhbnGJg=;
        b=fi7gFsvTIP5XpdNxoKfsV8qxJ0I5zK4NN3O/3x4nuY1+OtovJ63DfoXBTvLZGh6601
         A4zWYp0c+Sqpyuz6jNwbmIjSdqHTOlFygKcLYkznKpjiyGCNC+3yKP0Q9pct1PCuK9WQ
         nRwIFUma24kP4o/AKHVx1JLJ3CDq5AdmX6QnyYg6g6iw3ECzAU1p0NEnp8nb/REaGwwR
         FY0hiIv0iJMUuSBoOSW4yNnC8+pOR8XsT0y9J0uGiE9UhKbhOV3ScPZ01FL4cobOBw1z
         4xRfg5g/GZ8Dt3JLZyMAooMXhSzKW+eJ2nW6L6HjZ/oiJl6iPGM5sAtTQYxMrhelzu40
         exkw==
X-Gm-Message-State: APf1xPAqpBQbFHZzJTn4cL5aJnJKuA8cM+iNHyMvkX6beKRvtql6YtWr
        pm5c0jhv0gkCfyfB21A7G+s=
X-Google-Smtp-Source: AG47ELs50MCpAbM7Nyvj6UPdUPneVAYdjsI9hs+i97nE9Q3WntM177IHdsnWP2mipbtVxK+d+L4Asw==
X-Received: by 10.28.170.205 with SMTP id t196mr8345289wme.42.1519834945290;
        Wed, 28 Feb 2018 08:22:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c1sm2242925wmh.1.2018.02.28.08.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 08:22:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions about exit_code.
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
        <20180228001616.GJ174036@aiede.svl.corp.google.com>
        <20180228040718.GA9043@whir>
        <20180228050034.GA373@sigill.intra.peff.net>
        <20180228074251.GA11673@dcvr>
        <20180228074918.GA32127@sigill.intra.peff.net>
Date:   Wed, 28 Feb 2018 08:22:24 -0800
In-Reply-To: <20180228074918.GA32127@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 28 Feb 2018 02:49:18 -0500")
Message-ID: <xmqqk1uxm6db.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You're right. I cut down my example too much and dropped the necessary
> eval magic. Try this:
>
> -- >8 --
> SIG{__DIE__} = sub {
>   CORE::die @_ if $^S || !defined($^S);
>   print STDERR "fatal: @_";
>   exit 128;
> };
>
> eval {
>   die "inside eval";
> };
> print "eval status: $@" if $@;
>
> die "outside eval";
> -- 8< --
>
> Running that should produce:
>
> $ perl foo.pl; echo $?
> eval status: inside eval at foo.pl line 8.
> fatal: outside eval at foo.pl line 12.
> 128
>
> It may be getting a little too black-magic, though. Embedding in an eval
> is at least straightforward, if a bit more invasive.

I briefly wondered if this affects die that are called by code that
we did not write (i.e. from core or cpan via "use/require"), but (1)
we do want this to affect them, so that we die with status code
known to us, and (2) the way this uses CORE::die or exit depending
on the surrounding 'eval' would "fool" their uses just like we want
it to fool our uses, which is exactly what we want.

So, it looks like a good "black magic" ;-).
