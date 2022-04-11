Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C4C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 09:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbiDKJ4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344880AbiDKJ4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 05:56:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B36163C1
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 02:54:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d10so17713685edj.0
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lO9rtDsuyCA4kNVijI5X01zWBBBvW9Cyv5r85T37f8k=;
        b=8UPnSO5i89hyZ6A+nATeddhMIod1feJSwi8z2It///6esUP3igPOZcWRSC6JwHWiXe
         ZrsSIg1q+KgO9D8M+f2QUmbycPE1Uouk4xJ7gXB7UpjNaA3E9KEJKk8nziHaS60HcEfM
         5LPq2cjJHO2VRLrDAisYhTIKtK1ZG1D3vpUyl19JqZD1BTsJqOP6d0KH5bBNFCaW2qtW
         CVgxLkpOLjqytVwhLhZEKa9HPu4VBNNovCHwutMGDTZJDwYuuzkcrMeoNE3Itq0KiqLS
         8hhke1BRfXl4TRbPtFNwK+ma8nfWqm7sn8cvUyiyBen6ZQ4L8j/jdAJgJHIL2fhgkLTt
         HGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lO9rtDsuyCA4kNVijI5X01zWBBBvW9Cyv5r85T37f8k=;
        b=JiRaQHFC07sgBGhmd502LkAYaqC1nYgz9GfhLLQgE+fAYEl8rYiPOelay2Oc3qoKBJ
         XO87VWY6yFCBU/pxiz9pwT/YzpXMkHxK0UrFXwhiuHEJThrJ6RQIhYE+ne+kWnUjMW7N
         LjetZRwZeMIcwbF4cYAgNFZrGk43+k1vT9ybjvow6FJ3WKhvkacj6/jIMH7SgyoFZxA2
         68OO2xWLBOZ+Rk5XPYKZbWtr3yi5y8+hXbgTIhi+RuTN+n4+0gbtubOE7GQTC190umGM
         A/d+hclolLSZ1HzSMKmxqVqMz0x0AlsaXGQzY/eRVJzPovF6WLHjG0NnZj0imzKtI5SG
         lnJg==
X-Gm-Message-State: AOAM533mV8pvQ/1bIsmdUXJpNh6V8tLWxCDfdplFlPKbdOA6Xuj4WFJv
        A53hsXrus3MqrFU2RRkl6sc0ExoP6EwvL/8U3TR/Ww==
X-Google-Smtp-Source: ABdhPJzN7FI3abCEFwD8nT0h1ZYAub+9vWEzJc9/AVoUWyd0aOcSJUvNiN69fSpWAtwpfl6PhH8l2ix2cZ4s+91E8FA=
X-Received: by 2002:a05:6402:298c:b0:41d:6b63:aa67 with SMTP id
 eq12-20020a056402298c00b0041d6b63aa67mr10638336edb.42.1649670855813; Mon, 11
 Apr 2022 02:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
 <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com>
 <BL0PR12MB484938E9950EBCA08315544CC8E59@BL0PR12MB4849.namprd12.prod.outlook.com>
 <CAPMMpoggSvPox5tM3B_NZ0GwLzg7LtHkXGhby1mZqpkehZ1G0Q@mail.gmail.com>
 <CAPMMpohm74nVbi-dR=YOLoT+CbPiHGuVo35EoufKGKHP9Urexg@mail.gmail.com>
 <BL0PR12MB4849BAE614E63BBB0B77EC29C8E49@BL0PR12MB4849.namprd12.prod.outlook.com>
 <CAPMMpojFrDL9v=fWfyBx-Ko7fdZkd0yroC058n0+KAvL8SPiYA@mail.gmail.com>
In-Reply-To: <CAPMMpojFrDL9v=fWfyBx-Ko7fdZkd0yroC058n0+KAvL8SPiYA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 11 Apr 2022 11:54:06 +0200
Message-ID: <CAPMMpoiMtGVUv9yHhEWno+eySfiDTgrRZ7SdJLmfOwSk=tLfdg@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] git-p4: Various code tidy-ups
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 5, 2022 at 7:16 PM Tao Klerks <tao@klerks.biz> wrote:
>
> On Tue, Apr 5, 2022 at 2:04 PM Joel Holdsworth <jholdsworth@nvidia.com> w=
rote:
> >
> > > So, an initial test suggests that a recent version of git-p4 at least=
 doesn't fail in
> > > the same way under python3, in the face of at least some of these enc=
oding
> > > issues. I don't know yet whether failures will occur in other places,=
 nor
> > > whether the not-failing behavior is better, worse or the same as I ha=
d under
> > > python2, but it seems plausible that I won't be filing any test_expec=
t_failure
> > > tests after all, and will instead say "yay, python3 ftw!"
> >
> > That would be fabulous.
> >
>

I went a little further in the end, and implemented a full "fix" that
I believe makes sense. I've just submitted as RFC.

> > I myself have a repository that has a variety of such issues. A common =
case is CP-1252 Smart Quote characters produced on Windows which are incomp=
atible with UTF-8, without explicit conversion.
> >
>

I'd love to know how the proposed patch works for you.

> > However, a lot of these problems can be avoided by simply avoiding conv=
ersion to text in the first place. In many cases the incoming data doesn't =
need to be converted and can be passed around as binary.
>
> That's certainly the behavior in git-p4 under python2, but I'm pretty
> sure it's not "right". Git has a formal and coherent strategy for
> encoding - commit (meta)data is interpreted as utf-8 unless an
> "encoding" header is present in the commit. Git's output is utf-8
> (with on-the-fly re-encoding if commits do have a different encoding
> specified), unless you explicitly ask it to output in a different
> encoding. These processes are "forgiving", in that a set of bytes that
> cannot be interpreted as utf-8, in a commit that does not explicitly
> specify an encoding, will be output as-is rather than being rejected
> or warned about... But there is a "right way" to store data. When
> CP-1252 (high-range) bytes are simply "passed through" into the git
> data by python2, the resulting git commits cannot be displayed
> correctly by most or any git clients - they expect utf-8.
>
> On the other hand, in Perforce that does not appear to be the case at
> all: as far as I can tell, p4v in windows is simply using windows's
> active "legacy codepage", and reading or writing bytes accordingly
> (CP1252 in my case); in windows cmd, same thing by default; in linux,
> where utf8 is the norm nowadays, I get "unprintable character" output
> when something was submitted from a CP-1252 environment (same as I do
> for the python2-imported git commits, on any platform). If I switch a
> windows cmd terminal to utf8 ("chcp 65001"), it behaves the same. If I
> create a pending changelist with non-ANSI characters in Linux they get
> submitted as utf8-encoded, and when I view the same pending changelist
> in windows (from the command-line in its default legacy codepage, or
> in p4v which also seems to use the legacy codepage), I see the classic
> utf8-interpreted-as-CP1252 artifact "=C3=83=E2=80=A0" instead of "=C3=86"=
.
>
> I don't see any sort of "codepage selection" configuration either in
> the perforce clients, or in the connection / server relationship.
> Perforce tooling seems to simply assume that the Operating Systems of
> all users will be configured with the same codepage - the bytes are
> the bytes, clients encode and decode them however they will, and there
> is simply no encoding metadata. US/western Windows clients, modern
> linux clients, older mac clients, and cyrillic-configured clients, etc
> will all have produced mutually-unintelligible content in the same
> repo over the years.
>
> In *my* environment, a majority of users have been using Windows over
> the years to write commit messages, and most will have had CP-1252
> configured, so I believe the most reasonable behavior would be "try
> interpreting the bytes as utf-8, and if that fails then fall back to
> interpreting as CP-1252, and either way, store the result in git as
> utf-8" - but I don't know whether that is the right strategy for a
> majority of environments. This strategy makes sense for me because
> it's very rare for something that *can* be correctly read as utf-8 to,
> in fact, not be intended to be utf-8; that was kind of the point in
> the standard's development - so starting by *trying* to interpret as
> utf-8 is a safe bet, and has value if *any* of your clients are likely
> to have used it. In my environment there are linux users, and in fact
> p4 user management happens in linux, so user names/descriptions are
> also utf-8.
>
> For other environments I suspect the "fallback codepage" should be
> configurable (I don't know how codepage identifiers work
> cross-platform in python, that sounds like it might be fun). You could
> imagine having an "auto-detect" fallback option, but for the reasons
> identified above this would need to operate on a per-string basis to
> have high value, and I think CL descriptions (and user names) are
> simply too short for autodetection to be a viable option.
>
> Another reasonable strategy (less optimal for my environment) would be
> to follow the "python2" approach of writing the bytes into git as they
> were read from p4, but also additionally *telling* git what the
> encoding is expected to be, by setting the "encoding" header
> accordingly in the fast-import data. In my case that wouldn't work
> well because, again, author names are utf-8, but commit messages are
> more commonly CP-1252. Git expects all the strings in the commit to
> use the same encoding (unless I've missed something).
>

After working through this, I decided there was no practical value in
using the "encoding" header, *given* that the real encodings are
technically unknowable. There doesn't seem to be any advantage to
keeping the original bytes and slapping an "encoding" header into
place, over simply converting the original bytes into utf-8 following
an assumed (overridable) fallback encoding.

That said, I did keep the original python2 "just copy the bytes over"
strategy in place, and made it available under python3, in case anyone
(you?) prefer that over the attempt to convert to utf-8.

>
> > I'm slowly working toward this goal, and once this patch-set it merged =
I have a couple of other decoding patches in the pipeline. If you have any =
other failure cases, please do submit them as test cases, or bug reports at=
 least.
> >
>

I did not find any issues and did mark "Reviewed-By" for your "git-p4:
Various code tidy-ups" v5 patchset, fwiw. (when I eventually found it
in my gmail spam...:( )

Examples of my problem cases are included in my new "[RFC] git-p4:
improve encoding handling to support inconsistent encodings" patch.
This patch has minor conflicts with your code tidy-ups, but if I'm
reading Junio's latest updates correctly, the tidy-ups are headed to
"next" so I will re-roll when they get there.

>
> > I would prefer the script to discard Python 2 support, but even if the =
consensus is to retain it, Python 3 forces us to address these issues which=
 is a great step in the right direction.
> >
>

Given the (unintentional, but significant) behavior differences
between running under python2 and python3, I decided that it would be
best to support existing behaviors either way - be able to test the
new fallback behavior under python2, be able to maintain the old
behavior under python3, and be able to maintain python3's strict
behavior as well if desired (if, for example, cp1252 is likely to be a
bad guess, and you want to handle problems explicitly).

Obviously, the submitted patch is RFC - please let me know if you see
a better path forward!

Thanks,
Tao
