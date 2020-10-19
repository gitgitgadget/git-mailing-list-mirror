Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E7AC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 12:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A74C222BA
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 12:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxe8Wvb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgJSMzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 08:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgJSMzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 08:55:48 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C9C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 05:55:48 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r7so2776825ool.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDHQLEbXjpgOUlSf3sW1cI+ighTlwK6H5mgt7q4CGrw=;
        b=Vxe8Wvb1btXJcxg5ZGvd+8MXQYPpXYbOmMKnZiITJDqAgofC7D2YcH4fGyJWDIb3di
         HDWIrj65qBe2DqtNFuOHxNM8f3ffQxlDSEYAEW4hXRO4/e+z4gVcpm1xRsNmdIpGLOir
         VCwQULXcZwM/llfim09zirdLkSLf6Ok3ryKTYiFfoTg4Ht+eoG12UmMj9gAHhWHr+63H
         BBN46bWhKvlRssVEKncVt/baIAoIESW5sStJLUEP835P5qdMLmBn3fdu77Wr6FigKL/m
         UY5Hblekx4xmdCnZngCKxEqWE1tBn2IpfM2VWZeLz8qmC4nFRnqNIICihRkruZkTPPus
         AuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDHQLEbXjpgOUlSf3sW1cI+ighTlwK6H5mgt7q4CGrw=;
        b=L72ViX5QJs421Blgsl2jrHwZ1spstmY0NQoAGi12FITzgRGiyUCPOvRQn7DpyfNmwD
         vQ/XeMdKg8pI7Pcw4LdjNkoYPUtE5QpeGu1BOyJBOdKPzIlwPWV2ww/Kuwk86PsyOaHB
         yU4elqiSXjb1zd6hn4+lCj7LbOFYZvyaU80fCyd0ZRTOquhOAEpequQHKOXuONFTqcXb
         Vy+s3ZGYbCwpxeU2orvCY/75w5AxwoPD68ka8cgpaZjVQvrk50mmVqeoTBUi42nM6kLP
         m0Vh1kesh/6U/NsVl49jzt3h5B+qigUeIbct05OnhyaW+5dqxiRQ1Dw8uD3+VrbPXyXb
         bd3w==
X-Gm-Message-State: AOAM530+WK+doiEi2GW9eGKBzpgF+56qdGxCn2l7KV3qXd1GLGVRTOrm
        zAyWzL+x0QNIEN2lIPqbLXVJ+LiMc6tlG1PbGTk=
X-Google-Smtp-Source: ABdhPJzfnbZT/LrR3GQYUo2JJM68AvkxTkRu8gB/0JIyu8Lk+o2+d+BT7wzOiihfE2jxkghncTGK8H721CtTS1M2zVw=
X-Received: by 2002:a4a:d04c:: with SMTP id x12mr11779388oor.61.1603112146460;
 Mon, 19 Oct 2020 05:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201015175709.20121-1-charvi077@gmail.com> <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-5-charvi077@gmail.com> <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
In-Reply-To: <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 19 Oct 2020 18:25:35 +0530
Message-ID: <CAPSFM5ejRWUc2mCtqTPH4a6Q-WWUC4mQHU=bsHkjJOdG4kwW0g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of subshells
To:     phillip.wood@dunelm.org.uk
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 18 Oct 2020 at 21:09, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Charvi
>
> Congratulations on posting your first patch series.
>
> On 17/10/2020 08:54, Charvi Mendiratta wrote:
> > Avoid using `cd` outside of subshells since, if the test fails, there is no guarantee that the current working directory is the expected one, which may cause subsequent tests to run in the wrong directory.
>
> That is an accurate description of why we want to avoid using `cd`
> outside of subshells. However this conversion is converting `cd` inside
> a subshell to use `git -C`. I think that is worthwhile as it avoids
> having to use a subshell but the description should say explain that the
> conversion is desirable to avoid the cost of starting a subshell as the
> original test does not suffer from the problem described in your commit
> message.
>

Thank you Philip, for corrections . I somewhat able to understand that
commit message
should be " avoid using cd inside the subshells " because running a
shell script itselfs starts
a new subshell, please correct me if I am wrong . But still I am
unable to get that why you
mentioned the description as "cost of starting a new subshell " . Will
this not be the same subshell ?

> Best Wishes
>
> Phillip
>
> >
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> >   t/t7201-co.sh | 10 ++--------
> >   1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> > index 74553f991b..5898182fd2 100755
> > --- a/t/t7201-co.sh
> > +++ b/t/t7201-co.sh
> > @@ -339,10 +339,7 @@ test_expect_success 'switch branches while in subdirectory' '
> >       git checkout master &&
> >
> >       mkdir subs &&
> > -     (
> > -             cd subs &&
> > -             git checkout side
> > -     ) &&

Is there any specific meaning of writing these above two commands in
parentheses . Will this not work the same without it ?

> > +     git -C subs checkout side &&
> >       ! test -f subs/one &&
> >       rm -fr subs
> >   '
> > @@ -357,10 +354,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
> >
> >       git checkout master &&
> >       mkdir -p subs &&
> > -     (
> > -             cd subs &&
> > -             git checkout side -- bero
> > -     ) &&
> > +     git -C subs checkout side -- bero &&
> >       test -f subs/bero
> >   '
> >
> >
Thanks and Regards ,
Charvi
