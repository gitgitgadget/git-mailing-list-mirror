Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94798C56202
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 10:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1945E22227
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 10:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQC6MMwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgKRKUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 05:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgKRKUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 05:20:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFEC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 02:20:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 7so2010685ejm.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 02:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lcT4KMl1uF/MCwU+OqOkDITb+kIkDGUgUCsl0CsGmMk=;
        b=IQC6MMwgUEk9PpE7eNqoHY6qXaBz3Lp/f0efExADXNJSjSnIFu1O/CIE2xCX1nt7D2
         aja6xq51Ng4xWAoHLAVqcYeeoZ+l/tT/U5K1aYlvEzm2ieSL1jKMdOYqg6WoEa0orK3T
         niPmMXCZGuFyHnMDifQqxb/VZ9Lqvl3wrYiKZeNI1dyjkusUsH2pNoqkPHqPirXa5FoO
         ewuIDU1fhnw9NoSfCU0MsZ2O0a4rO/cxNocjFbtxmsgUHZdfTfuquB2HIRFZlMqfjwgq
         5pYKoyIGb6AKDufkNFQI+5YOL2M8+xM7zoYEV7LdNRnNjJiKXzGEO/qwsnLMTemSuxjs
         ykJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lcT4KMl1uF/MCwU+OqOkDITb+kIkDGUgUCsl0CsGmMk=;
        b=kqgdyK0bbQh1QRIj+wjO7GBr/AdY6w5DOFZcT2ogZGSQxayqvEaUOElzQZ8Z4XwAnc
         OyaiDWEq6rxNKivahcLI1pYg210KbYuZtsXBo6Lt4zj704Cqfqe8yvEr/2FdKG5mppX6
         xZjwpapW61eWTo9tWzH5yPu8NHvtswvhh2Xzhe8SbFtrUQzx2///OuksCjdpFemUERsc
         9Rh3ZD+ww5iTW5qH/sWhmaGETsFEWlDI6J0P8qa7XoMO362W2YAzR9VTuMWwiDt+wAbE
         uyY3MSgO/2GYYyCS/EElXONTSfbnuMDFnYDnnjFvyje46ijogpesu6QQsXVzLzG4+uKd
         Gikw==
X-Gm-Message-State: AOAM530cM3qwst89Hl1hjOpn0r/+sZ5iiHnDBJXtTnHCt1ALy+Wl1cdr
        jhxfY31VJ0SZ6w82VvuA9AhnSMjvCTx2mm2cBc1cojmv620=
X-Google-Smtp-Source: ABdhPJyqwfJlIhYp0OQfWqQWiFHqLODZxZ923nfriJUoI4tFs++3QummF6rKlI4YU2ImUuKn3BIGEdQX/zRK71Glie8=
X-Received: by 2002:a17:906:2b06:: with SMTP id a6mr24605584ejg.283.1605694831283;
 Wed, 18 Nov 2020 02:20:31 -0800 (PST)
MIME-Version: 1.0
References: <CAD9n_qjKyxNjtd1YrcHzshLg0-vbwXkHRwMveXHAWSOXMWLKAg@mail.gmail.com>
 <20201114002902.GN6252@camp.crustytoothpaste.net> <20201114162700.cvmxzcs4sdhsxpak@chatter.i7.local>
 <87blfzg5qa.fsf@evledraar.gmail.com>
In-Reply-To: <87blfzg5qa.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 18 Nov 2020 11:20:20 +0100
Message-ID: <CAP8UFD35kk10FpUnPpiAUzTHJbm=SJ-76OTmkTwBstGFe3Zgdw@mail.gmail.com>
Subject: Partial clone demo for large files (Re: Why Git LFS is not a built-in feature)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alireza <rezaxm@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 14, 2020 at 7:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sat, Nov 14 2020, Konstantin Ryabitsev wrote:
>
> > On Sat, Nov 14, 2020 at 12:29:02AM +0000, brian m. carlson wrote:
> >> Additionally, in many cases, projects can avoid the need for storing
> >> large files at all by using repository best practices, like not storin=
g
> >> build products or binary dependencies in the repository and instead
> >> using an artifact server or a standard packaging system.  If possible,
> >> that will almost always provide a better experience than any solution
> >> for storing large files in the repository.
> >
> > Well, I would argue that if the goal is ongoing archival and easy
> > replication, then storing objects in a repository like git makes a lot
> > more sense than keeping them on a central server that may or may not be
> > there a few years down the line. Having large file support native in gi=
t
> > is a laudable goal and I quite often wish that it existed.
>
> That native support does exist right now in the form of partial clones,
> the packfile-uris support, core.bigFileThreshold etc.
>
> It's got a lot of rough edges currently, but if it's something you're
> interested in you should try it out and see if the subset of features
> that works well now is something that would work for you.

I have been working on a partial clone demo that stores large files on
an HTTP server:

https://gitlab.com/chriscool/partial-clone-demo/-/blob/master/http-promisor=
/demo.txt

It has a lot of rough edges indeed. Fetching from the HTTP server
promisor remote is very slow. For the last part you need a hacked Git.
The scripts have a lot of bugs and limitations and are not finished
(to say the least).

The goal for now is just to give people (especially product managers,
developers and managers inside GitLab) an outlook about how it could
work.
