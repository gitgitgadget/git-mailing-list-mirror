Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD95C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 04:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiEYEfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 00:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiEYEfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 00:35:16 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872660AA5
        for <git@vger.kernel.org>; Tue, 24 May 2022 21:35:14 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id m2so20225922vsr.8
        for <git@vger.kernel.org>; Tue, 24 May 2022 21:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dCIt7BDJFVh0HUwqYAG/GOFDwo4w0lLKaPm2pL7UHvE=;
        b=HVK5aLdZoURpe20/Si7PGsV9Jtnvg0KUMblKte72eIOF/JFbhaEVxxW7m+i5DFCWAr
         /g8iyRcTprVbd4F4oQ2bPX4M1kC0byUjIUBPdt63Sn6+Hc7Ytzl/vOhCsklWzwBD6Id0
         laIrllXJ5T2wmGVDQk4j3K1BanZLr9kvFTOkzztNRfaJgl3j4kNjRw/vyuitl7Yymech
         vC8vIvELn+JD87AEtTcyLHR+KFiM6LywDkovRfSTjCkbExJbKrNH7nw9kB8DVjgWnn8W
         9dsyFsBGkGsjaSSukEta2KKd1XuUbn7IgKHWE0uc9LH268vC+a9o1ztLiLfM/6RWFH00
         d0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dCIt7BDJFVh0HUwqYAG/GOFDwo4w0lLKaPm2pL7UHvE=;
        b=XoAnv9hpiv83q5UadobcJgdOzqg6F5LHfa973cjlA7Ywtsn7jIuTbFYz8/YqlJ9QTs
         4K0Yul+USyC/pMtzqBNuh0IEqchxay3RHTvvtF9guS5qYywMAg8IFK3cVMe4Z/bBHc+P
         BmoTO5C5+fSkxA2V4NG5r+CG5lNptBuGu+iZdcr513Wx1xqgGUKyes0a2/4wjTfEgakl
         y/h7obkeng5Xr/y50SzRywIM3KA1CpMkAOoqN7haKQXqe8S6BZgeMzCdBaf2cS7pfB+h
         pzM3g+YP3f7qrtmhMHJHRCnkq4ZzhqEq87/POdjuJxB7qvUVo/7QzPv3BNnDERgjAxco
         sYbg==
X-Gm-Message-State: AOAM533MBLwlqbiFoCGyp1RFwlPiwH3uhlZOtgFjiFjWAljzALCPOp4e
        vyOUjXWdTScgClT70igBtCnZvTOHMSUTI4N5+TYTpQXdUro=
X-Google-Smtp-Source: ABdhPJwhAUg/at8HAUjfFWRkGfqRKgUqx4GpiuxaaGlMz2+ATN6yUv38kJpFhII96cmmZkRA5b3h32hKe6++edgaWH4=
X-Received: by 2002:a67:c19a:0:b0:337:9fb2:7c63 with SMTP id
 h26-20020a67c19a000000b003379fb27c63mr6354674vsj.52.1653453313727; Tue, 24
 May 2022 21:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
 <20220524192026.2373nfcrs6bsa4ce@carlos-mbp.lan> <6a3aecf1-1c0d-f4fc-7d0e-455eb0ccc92c@gmail.com>
In-Reply-To: <6a3aecf1-1c0d-f4fc-7d0e-455eb0ccc92c@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 24 May 2022 21:35:02 -0700
Message-ID: <CAPUEspi0q_vNeQ9qYfNzCt7w1noBdNRWZ2dM1hqJroH4zt2x=g@mail.gmail.com>
Subject: Re: [PATCH] ci: update Cirrus-CI image to FreeBSD 13.0
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, Ed Maste <emaste@freebsd.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 1:53 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Carlo,
>
> Le 2022-05-24 =C3=A0 15:20, Carlo Marcelo Arenas Bel=C3=B3n a =C3=A9crit =
:

> > did you try to use 12.3 which should be supported for a little longer?
>
> Yes, I tested 12.3 and it also works. We could switch to that and
> keep 13.0 for later.

This seems like the better option overall; feel free to include
whatever footer you decide to use with my name in your next reroll.

> >> The FreeBSD image we use is FreeBSD 12.2, which is unsupported since
> >> March 31st, 2022 [1]. Switching to a supported version, 13.0,
> >> makes this error disappear [2].
> >
> > I think 13.1 might be better, since with this change we are also implic=
itly
> > making a move to say that we don't really care about the old (but still
> > supported) maintenance branch, but will only look at the "latest" versi=
on
> > instead.
>
> I agree with your reasoning, but 13.1 was not listed in the list of image=
s on Cirrus-CI [1]. They
> say they support all Google Compute Engine images, but I could not find a=
 public list
> of these images ([2] seems to be it but I don't want to create an account=
 just
> to see a list!).

Good point; BTW I'd noticed before that the easiest way is to "try it"
since the Cirrus documentation seems to lag behind for a little while,
and so as you can
see in this[0] run, it is working fine as well.

[0] https://github.com/carenas/git/runs/6584764718
> [1] https://cirrus-ci.org/guide/FreeBSD/
> [2] https://console.cloud.google.com/compute/images
