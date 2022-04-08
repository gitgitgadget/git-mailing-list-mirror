Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05116C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 12:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiDHMGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiDHMGP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 08:06:15 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC9F10DA59
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 05:03:42 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 12so8549986oix.12
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=49O28sq7djOur7u9QnwVztb6Y/Gi4WBV6gkg80I2L/c=;
        b=bWxdCCZqLSLlcx4aibzqAbTZlVkUZaUaWAfPlp/+MO46ckwtjb5NIBLM8CkUeGYJ35
         heLzj8tDOQPNSiSQ6Z8XJEs95nkFIwy1za7KnvBZ8Kp/lpxF/s4g/fy3LhuRG8uGtOPC
         qjU1Ey++eCi1ZyE1z9ht+Dg68KdSdZW3qnAbvNhLKmUMPh+NuLxMK/fmXTEDn/6bjNUt
         2xqDJZsapmeppVBw155tPuD77nSE6T2NLR1QAR0XKdgfvTuImlejhgKh33d4+XS3DCuu
         uH8AcSeQTRsWitubQzxaw5inHP3cCkxeGv90295XKzCxZDSaksGKf6QXjDTGFhnVi0/z
         KyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=49O28sq7djOur7u9QnwVztb6Y/Gi4WBV6gkg80I2L/c=;
        b=Z06jw4ChZHDMoP0+JY5G+v/OHcpONQ0s4VkPjlIcESrUON9qhhrivIazc94a8V1S9z
         j5MG2P/vp/ntEqtRqD7qk4oCpmYnfJ21aFBriZ8GO8zsD//EPL7jXFTYTvtmpQbgtrhw
         UKXCxyJu/TlxJBXxbQ3U/JERuGb+3EfnrBP2xPogTX3wYU0qNYSLOswivjvjm5cig0Ll
         T1PlzhXz+FqXktQMlE2tywc3lPhfWxUy+xZ1ekuAxZ645bA7DJeeL3IqMh6QnrG4hhSL
         vfjTN1ppkmkiyQDce3hP7W9sQpQNko6Q1fCVF8LEHSVk31rEQmDc1Cv8cpQYqPCDf8Hx
         LJjA==
X-Gm-Message-State: AOAM5326PfGmKyvbKZUQXngPdqCuag4avz7AyuzJ9WRvTyqx9VAb+xaT
        YcJ62e4SVb8ZOeCyxiYHkqmBoWmOO3CP3wI5Fg2xGA/H7yOVbA==
X-Google-Smtp-Source: ABdhPJy0C5VeSBTl6GvU0TPNbqTawXzG0IzUKemVwRVUmZB3ItobeYKkW1oH7mvczSIujVixV/8Nl6JH0jO2/iP7t/I=
X-Received: by 2002:a05:6808:10c7:b0:2f9:460b:ddb4 with SMTP id
 s7-20020a05680810c700b002f9460bddb4mr7848973ois.111.1649419421521; Fri, 08
 Apr 2022 05:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJyCBOSAekywgzVSf1uGb8s+hY7a7A=0fC5kFhMVpiqS1KEw4w@mail.gmail.com>
 <Yk9dOoit/Ua69s7A@camp.crustytoothpaste.net> <CAJyCBOTwsGtkEFuPHosQ-v6xot051OCRWh1QdmqMk3gucuEnPQ@mail.gmail.com>
 <220408.86mtgvbx7v.gmgdl@evledraar.gmail.com>
In-Reply-To: <220408.86mtgvbx7v.gmgdl@evledraar.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 8 Apr 2022 20:03:29 +0800
Message-ID: <CAJyCBOQGGpOgOf22Go36a2GnAzbSb4xMZCpCmAi6YzYeoS1jjA@mail.gmail.com>
Subject: Re: How to get git-send-email use a proxy?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 8, 2022 at 8:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Apr 08 2022, Shaoxuan Yuan wrote:
>
> > On Fri, Apr 8, 2022 at 5:53 AM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >>
> >> On 2022-04-06 at 14:19:43, Shaoxuan Yuan wrote:
> >> > Greetings, Git community,
> >> >
> >> > I'm using git-send-email with Git 2.35.1 under system
> >> > 5.4.72-microsoft-standard-WSL2, x86_64 GNU/Linux.
> >> >
> >> > I am on a system-wide socks5 proxy. Although I set the global
> >> > .gitconfig to use the socks5 proxy trying to send emails, the
> >> > connection to the SMTP server seems does not go through the proxy at
> >> > all.
> >> >
> >> > Other git commands do go through the globally set .gitconfig proxy,
> >> > git-send-email seems to be an exception.
> >>
> >> I think you're referring to http.proxy.  That affects only HTTP, HTTPS=
,
> >> and FTP (if we even still support that).  All of those protocols are
> >> handled by libcurl, which includes native proxy support.  It doesn't
> >> affect other protocols like SSH or SMTP.
> >>
> >> > So I'm wondering if there needs to be a code change in
> >> > 'git-send-email.perl' to run the connection through a proxy, or I ju=
st
> >> > need to tune the setting to accomplish this?
> >>
> >> git send-email is written in Perl and doesn't use libcurl, so it doesn=
't
> >> have proxy support.  If there's a particular optional module we could
> >> dynamically load to provide proxy support, that's an option we could
> >> support if someone wanted to provide a patch.
> >>
> >> In the mean time, you could also try using some sort of tool, like
> >> socat, to bind a local port tunnelling over the proxy to the destinati=
on
> >> server and then use SMTP over that local port to connect.
> >> --
> >> brian m. carlson (he/him or they/them)
> >> Toronto, Ontario, CA
> >
> > Thanks, it's pretty informative ;-)
>
> If you want to add a "native" feature to git-send-email.perl (and
> provide a patch) it looks from
> https://stackoverflow.com/questions/3253360/using-socks5-proxy-with-netsm=
tp
> that doing so isn't too hard.
>
> I.e. Net::SMTP (which we use) just uses standard Perl modules to connect
> to the network, and there's other existing modules to ferry any such
> connection through a SOCKS proxy: https://metacpan.org/pod/Net::SOCKS &
> https://metacpan.org/pod/IO::Socket::Socks (I'm not sure which of these
> is a better choice).
>
> So it seems like a rather easy 10-20 line patch (including docs and
> boilerplate) where we'd just create our own Git::Net::SMTP class, and
> that class in turn would be like Net::SMTP, except its @ISA would first
> dispatch to a "new" in a class we own.
>
> We could thus intercept the new() invocation it makes to the socket
> class it's picking now, and direct it to a wrapper.
>
> There's probably even an existing CPAN module for "given this class,
> screw with its @ISA such that socks support is added", I just haven't
> looked.

Thanks for the info, I will definitely try to make a patch and see how it
works :-)

--=20
Thanks & Regards,
Shaoxuan
