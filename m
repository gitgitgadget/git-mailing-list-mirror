Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C9920A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 08:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLJIYc (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 03:24:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45450 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeLJIYb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 03:24:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so8672635edb.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 00:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VdN9p4L1t4FCZ2WVrXIsKgQEjM8qqBBJJ9eTZXCVlnQ=;
        b=BHUd/QiXyKxI2Sa5P4HQFZoo1KVrsaRxaeEkHhqC4NdefW3YwIDgE5nt4R84iWZD3T
         Q1ZHCFls4B0goWIZBlFFsif3Ls4BMnMFv3TulbgmQI+WuVGSRtHRGByZCDmuNT1cbykb
         3VhVnbLR1zMBe/jqEYVRrioRj1BT4Af+bLvoxnHFTQZz5cJQ+8H7d3htGXKz3PFenewl
         3Qr6oLD0kyJMBAuLwfuI1VfVc4jJU151ALmxMg/7XD/ARg8/R2QgbuVkwVRYdMUoQzVm
         sdRpZ8zXrFX2mitcknqpKO9TITCI9buoSqUS8eXZI+13yEBJxE8VhI9eClfv4FK8/Se0
         1Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=VdN9p4L1t4FCZ2WVrXIsKgQEjM8qqBBJJ9eTZXCVlnQ=;
        b=NbM3/Mg5D7/oa0cAjTnX+AtncZXRCu6K4WpQwcMMAFqvUODdX+1wmz8lt/iewkkA63
         5cZ0ZC5qsSh8F0nYZx5o5wzRVVB9mi2C9/927QqOhFfPyaU2qEup6CGBg0HmYx/gEU7s
         IbtNV7sChObsdxAzjuw0BGy4k4iLUsFl/mMT5MbjylPt2PUfJepl2x5f48Au5m24Tj0x
         9FYIQEtBlSw3VyjL0ZVxf7mQba8hiAR9IMk9eTgQb4BW90d4fdasmhr8Wt489zHOotIy
         YgJ+jvVG+9gO77Ov/D/n9RacnXTA33ZBhi77VCp65YejsW3TiYPulFH+SBDWrfHE27KI
         YscA==
X-Gm-Message-State: AA+aEWb3M6Huvs/4hbOcCtCEzOqS0XeabbiFUT4UDYmk9t34J9edB2lM
        pVDCBWn4CM7UoIt/wYjk7VuiX7Ip
X-Google-Smtp-Source: AFSGD/Ucr+PP/aE4y+VkDI/1Z05GNs/ch4MmRJ+1VS3SJHBsp60tKu6Gn9HxZZYggP0V/bbCMk07Xw==
X-Received: by 2002:a17:906:48c5:: with SMTP id d5-v6mr8981366ejt.85.1544430268621;
        Mon, 10 Dec 2018 00:24:28 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id v1-v6sm1689360ejq.47.2018.12.10.00.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 00:24:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, pcre-dev@exim.org
Subject: Re: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with pcre1
References: <20181209230024.43444-1-carenas@gmail.com> <20181209230024.43444-2-carenas@gmail.com> <87r2eqxnru.fsf@evledraar.gmail.com> <20181210004252.GK890086@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181210004252.GK890086@genre.crustytoothpaste.net>
Date:   Mon, 10 Dec 2018 09:24:27 +0100
Message-ID: <87pnu9yekk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 10 2018, brian m. carlson wrote:

> On Mon, Dec 10, 2018 at 12:51:01AM +0100, Ævar Arnfjörð Bjarmason wrote:
>> Obviously this & what you have in 2/2 needs to be fixed in some way.
>>
>> Is the issue on SELinux, OpenBSD, NetBSD etc. *how* PCRE is creating the
>> the JIT'd code? I.e. presumably Google Chrome's JIT engine, Java JIT and
>> the like work on those setup, or not? I.e. is this something upstream
>> can/is likely to fix eventually?
>
> From the cover letter (but without testing), it seems like it would
> probably be fine to first map the pages read-write to write the code and
> then, once that's done, to map them read-executable. I know JIT
> compilation does work on the BSDs, so presumably that's the technique to
> make it do so.
>
> Both versions of PCRE map pages both write and executable at the same
> time, which is presumably where things go wrong. I assume it can be
> fixed, but whether that's easy in the context of PCRE, I wouldn't know.
>
>> Are we mixing a condition where one some OS's or OS versions this just
>> won't work at all, and thus maybe should be something turned on in
>> config.mak.uname, v.s. e.g. SELinux where presumably it'll dynamically
>> change.
>
> Considering that some Linux users use PaX kernels with standard
> distributions and that most BSD kernels can be custom-compiled with a
> variety of options enabled or disabled, I think this is something we
> should detect dynamically.

Right. I'm asking whether we're mixing up cases where it can always be
detected at compile-time on some systems v.s. cases where it'll
potentially change at runtime.

>> I'm inclined to suggest that we should have another ifdef here for "if
>> JIT fails I'd like it to die", so that e.g. packages I build (for
>> internal use) don't silently slow down in the future, only for me to
>> find some months later that someone enabled an overzealous SELinux
>> policy and we swept this under the rug.
>
> My view is that JIT is a nice performance optimization, but it's
> optional. I honestly don't think it should even be exposed through the
> API: if it works, then things are faster, and if it doesn't, then
> they're not. I don't see the value in an option for causing things to be
> broken if someone improves the security of the system.

For many users that's definitely the case, but for others that's like
saying a RDBMS is still going to be functional if the "ORDER BY"
function degrades to bubblesort. The JIT improves performance my
multi-hundred percents sometimes, so some users (e.g. me) rely on that
not being silently degraded.

So I'm wondering if we can have something like:

    if (!jit)
        if (must_have_jit)
            BUG(...); // Like currently
        else
            fallback(); // new behavior
