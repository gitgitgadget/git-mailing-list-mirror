Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A1A209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 19:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbdFFTJr (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 15:09:47 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35597 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdFFTJp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 15:09:45 -0400
Received: by mail-pf0-f173.google.com with SMTP id l89so26757690pfi.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 12:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HEbgjnKbUXIaBggA7wN7YCXo588PcaBoi6yXVOTIc/o=;
        b=fR1K7INE2tFE/0t76UdahPghgmh5sg7wYLophbv9j6LWycbVcyHG4i8ZebvLXvsy6+
         Zw1L+a1yYyUKn4EyGztH6htlee+bVQ4k2Dn0TKw7fJbyIPJ09fFXHsw5q/z9dDVbXmYk
         h81bUlGJy+jX/5pjhNf4+mTeFB6+YgLzdUWLIy4TF/7Bw1w502/5OpyhPc07VHOODs8f
         zScgHLO3vEinDcYGDe1nL/XcPTlDOFBBpCj+ZQSUOF7ty365PzeoHXk3P2ICh9L7qgbc
         boXp/TK3Ydf3U/2YoQH4qrULKBVI2lWqxdVqSLSNMJgqvwkBkE6n76lobQWPkyygSuPP
         bZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HEbgjnKbUXIaBggA7wN7YCXo588PcaBoi6yXVOTIc/o=;
        b=OC6qud2zO6cD526rTAe6HJIuVtvk7eBTebl3965KSDdr4yA24hfdvc0XxOM6FsliJX
         FeXqvkqxCyUGixETBVyVq6NHlXSn/gbw6g3/2jy7lMwaQ6qtOkkjF1podFlDgallDM1J
         2eGYiQAE/BGd++oTi7oVB+9WotBl4H9l6J6rLfxr0/mb+HDss3s47wJLUmAD4vLviSE7
         iPE4WMR9yU6vwdTgUy/DK+OqYSB8Aqg0GMShnWa98XO/5nmPFnwdpFPwUrbdsyFkbWQD
         fFS9CHYHw2kgIhLe/q720xNeNpW4XdJg2Z/agKv8m+Cra7eXOPozITe3FnT/X/tq7f7E
         AkWw==
X-Gm-Message-State: AODbwcByJrXl9aBXhFDZYTWrg2isY937l2vxBerTSF03qxYIIo97YkH8
        ytIwTdKu7RoLz4KOMonVZjUTrdqgpQkJ
X-Received: by 10.84.224.205 with SMTP id k13mr23303834pln.279.1496776179031;
 Tue, 06 Jun 2017 12:09:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 6 Jun 2017 12:09:38 -0700 (PDT)
In-Reply-To: <CACBZZX6WJDrcUj4WMxZsShEaXK91CxR2sMUbWV+K3AudNYAXbA@mail.gmail.com>
References: <20170606124323.GD25777@dinwoodie.org> <20170606151231.25172-1-avarab@gmail.com>
 <20170606151231.25172-3-avarab@gmail.com> <CAGZ79kYGaF6=RQZ2HpTZ8qE50V2SU0DO+-0nx-n9WEkQmM4WoA@mail.gmail.com>
 <CACBZZX6WJDrcUj4WMxZsShEaXK91CxR2sMUbWV+K3AudNYAXbA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Jun 2017 12:09:38 -0700
Message-ID: <CAGZ79kYfX=QXLnwTcZSG=hoBKurYG_Nub5eE_kK4SCQYb6L+MQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 12:03 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jun 6, 2017 at 8:48 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Jun 6, 2017 at 8:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> Add an option to use the sha1collisiondetection library from the
>>> submodule in sha1collisiondetection/ instead of in the copy in the
>>> sha1dc/ directory.
>>>
>>> This allows us to try out the submodule in sha1collisiondetection
>>> without breaking the build for anyone who's not expecting them as we
>>> work out any kinks.
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>>
>> Other projects using submodules sometimes have
>> a .gitattributes entry to have .gitmodules not exported
>> via git-archive. Do we want a similar thing?
>
> Right now we end up with an empty directory due to the issue you noted
> in https://public-inbox.org/git/CAGZ79kZC98CxA69QjmX2s_SU6z1CSgKgwZeqvwiM=
RAQc6+S3xg@mail.gmail.com/
>
> It's probably best to have the .gitmodules file as some hint that
> something should be there. We also ship the other .git* files.

Ok, but then let's talk about the other .git* files, would we want to
distribute these via tarballs? (I guess it is a minor thing if at all and
nobody downloading a git tarball would be surprised by these metadata
files or annoyed by them, so all is good?)

>
>> Speaking of attributes, I wonder if we want to specify
>> the .gitmodules file to be text with unixy file endings:
>> Having an entry
>>     .gitattributes eol=3Dcrlf
>> to simulate a Windows environment doesn't harm
>> submodule operation, which is good. I'll check if we
>> have a test for that.
>
> I have no idea what that would do or why we'd have it, but I'm going
> to understand this as you looking into it :)

I looked briefly into it and it seems to be no problem just as config files
on Windows are no problem. I just spoke up too quickly.
