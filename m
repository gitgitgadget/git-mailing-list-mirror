Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054991F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCOREH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:04:07 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:55822 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeCOREE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:04:04 -0400
Received: by mail-wm0-f43.google.com with SMTP id q83so11873945wme.5
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JhWO4XPeSHQgkDQhcy39GvfvIhOBv7PYTN5hmVOLvyc=;
        b=FlxqlNaX1DpqWUOF/W+4j8gZ50waVDriiYRcZ+UjaAuLlXsOIVEInAtl/GFKegmkzo
         0gCGVsbZpEfarrEkBaqLjJ4FCSnziZra4X+VwwciEY/+Es79Q4c00VVpiuaNXFg75RRm
         mjHJjDQWIEnirytvkbhOy/WSJVIkD/aQO928iN30osPDIITUb5Qay/E10yWhpnxtCwHr
         T0WV3mFdI/xD8loLg5TLjGElAGpF49nYJVCsmtxnXZTp1VuALcif4rNZrmjfwxDgiKwL
         2jzwqUrQTsPjukiuZsCYrvpT6MjQOF1mpch8hXh5OdSCcIsQ9uaXKCZLXk6DKgp2KPGd
         HX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JhWO4XPeSHQgkDQhcy39GvfvIhOBv7PYTN5hmVOLvyc=;
        b=E4YOXV6ELDBFc1esu4MmXWtDYleHHMBETclJNrhadxuKLTc+NHpyXWou6+uy6e3GT5
         0cYzBhOR6w1qrsNsKRjgJP4s3uMPS2ZekjOC5zaCTyL5QJhZ2XdqHC80iRj5+IBzBkLh
         qwFKcwGkxH2BqTZ2ORypoxbSuiD51pjEoS4QEq182MSDEZXNtB/vecXfKMXHi+ZSf4eP
         ZgqErVMzJZedqvdKi9mXXtUEjYSSSiHt7iiLE80N9BDwN7YET9JnuKBCb6Dya32YSFDi
         5mb8hyKL/loGWBLS9Ny0rnYsh+Uy8xSWcJtaEA4yJjaQM5UQGu+76/YXgNXKU1wj/NE8
         qA9g==
X-Gm-Message-State: AElRT7EOEnGgH0hJXunZuho6jAfLAmjSyAe1KVSyEV+dj4BO6vIndxxD
        vkzJFAq49RMe3l3nMFbhdUnWPwoNP0E=
X-Google-Smtp-Source: AG47ELsvrfzFmUnXuK6A7O4OCpcZ6yP0lOQaL+a5jOYZkin4kPfSHn/8x7UcmX5F5olVJLdBgtJeiA==
X-Received: by 10.28.37.196 with SMTP id l187mr1900794wml.13.1521133443250;
        Thu, 15 Mar 2018 10:04:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d4sm4408366wmh.42.2018.03.15.10.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 10:04:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [GSoC] [PATCH] test: avoid pipes in git related commands for test suite
References: <20180313201945.8409-1-predatoramigo@gmail.com>
        <CAPig+cRPzyw525ODC4=-E7w=zbpbhVN2eqxSYDSLij5wfW8S_A@mail.gmail.com>
        <87zi3bdlo2.fsf@evledraar.gmail.com>
        <CAPig+cTLCswg_=q5ybnyN3As4Au05q5eAcA7Prr643KCgZ0OAw@mail.gmail.com>
Date:   Thu, 15 Mar 2018 10:04:01 -0700
In-Reply-To: <CAPig+cTLCswg_=q5ybnyN3As4Au05q5eAcA7Prr643KCgZ0OAw@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 14 Mar 2018 14:22:45 -0400")
Message-ID: <xmqqsh915kzi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks for presenting an opposing opinion. While I understand your
> position, the reason for my suggested transformation is that if the
> patch already transformed the code in the way suggested, it would
> increase my confidence, as a reviewer, that the patch author had
> _studied_ and _understood_ the code. Increased confidence is
> especially important for mechanical transformations since -- as seen
> in the unsnipped review comment below -- blindly-applied mechanical
> transformations can be suboptimal or outright incorrect.
>
> It's also the sort of review comment I would make even to very
> seasoned project participants[1].
>
> [1]: https://public-inbox.org/git/CAPig+cQLmYQeRhPxvZHmY7gApnbE25H_KoSWs-ZjuBo4BruimQ@mail.gmail.com/

Yes, it is a good example that mechanical conversions are often
mind-numbing and make even seasoned participants miss trivially
obvious improvement opportunities ;-)

It however is OK to be more lenient to newer participants and allow
deferring such "while at it, make it right" on top of "minimally
required for correctness", in order to encourage them by getting
something to the tree early ;-)
