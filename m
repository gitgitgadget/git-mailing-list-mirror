Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A6C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiAMDeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiAMDeX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:34:23 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE38C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:34:22 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id v192so14188vkv.4
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PethqsiJakSyVVKrmFn3DAKZr9WwT1XbRZM3F98EkwY=;
        b=TJrd6ca5h6yQ6rFayJWNeXcidRwDpKbTuNxoWZa8zLyOE0qf3WryvC7LnVqd9oOGwp
         zo89PEBPPJWBXhoLpMV7Xcmj1PWH2uZ9xFfs5yIcwn2CFLvW2HZ82ZQjG+KW8SjRzeMO
         sCH+Cvtvwa8UXsKP706vm/L51IultNvmA0TwKWzMgs2Lt0FG5XG3g9Mh6AGNoNTldSua
         a/O1F2XBqJBqlKM9xtjHWOtK7uiZFLoVOPc9TOJp2jbNB9bXo7BiZdNgvCS5y2olCxj+
         BwrZnJQIQnSoyiqW91AeJtWh9XdvyOLM0FvrZGZ7Ay7FdCwvD9DoTfmDfSD5JD29GUBj
         yuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PethqsiJakSyVVKrmFn3DAKZr9WwT1XbRZM3F98EkwY=;
        b=vVLj/rI60hO/Y7ZMvd0hL6SLijSQiQZMZyjYRkhYbz3ZHS2UODw6NV4Q9aUEMhzF2z
         GnVHQXrQNa+5tB5Rk2uTkxCq6jPlMuTNTo3sNN+yChpznHsI5dmmamlWFGdvD0gaDKYs
         tg5b61oC4SMOqg1OvHQ4czAJ1wKHqILmn93Zmvh1/s8kWv+3dsuE22jbaC83Ig4c3etb
         1DsFr4SbXym+8BRODtiLFhAxi3JZ31/cRNuF0u4bhZVU92Obie+oA3JL5ViBT3XZQxgn
         eKAZF6Kl4dLUBL7BAikIZntsrwuuq9hgWbknUd3tp7Ej2kT7Rt7xaIALKxnMSl4hk1IA
         0Q3Q==
X-Gm-Message-State: AOAM5303jYiOoLa9KfWzVp50zXBIB9JM7YEDj6Ch1D4SoXtTRX+XJ3mC
        CDZTtQczBiURJunRInS8qoJZdvpRdkfsOu4cS+Y=
X-Google-Smtp-Source: ABdhPJxM8LgT4CZ9RGPFUSTBO6jJeBSEogwQhUtxTVbGaMnR/rnpNUnTGnssTShOxlYGdZLuMyGbTAVkKTVCrlhGL60=
X-Received: by 2002:a05:6122:da0:: with SMTP id bc32mr1391735vkb.26.1642044861924;
 Wed, 12 Jan 2022 19:34:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641440700.git.dyroneteng@gmail.com> <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
 <220110.86ilurzcxo.gmgdl@evledraar.gmail.com> <Yd2zXOrf+4qX8VLD@nand.local>
 <78aa8c28-d78b-7dee-6616-7708c363a244@web.de> <Yd3kZv4Oym1h7zap@nand.local>
In-Reply-To: <Yd3kZv4Oym1h7zap@nand.local>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Thu, 13 Jan 2022 11:34:11 +0800
Message-ID: <CADMgQSTxZ92t34=P0==a3y=7W+vvApZ8qN3mq6r2ot9YNP4WQA@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 4:11 AM Taylor Blau <me@ttaylorr.com> wrote:

> > Silly question, going further off-topic: What's "git always" doing?
>
> Oops, I should have mentioned. It's another alias to ensure that the
> following command is always run in a Git repository (either the current
> one or a hand-picked default):
>
>     $ git config alias.always
>     !git rev-parse 2>/dev/null || cd ~/src/git; git
>
> I often read mail out of my home directory, and the above works with my
> `:Git` command in Vim (which passes its arguments to `git always` and
> inserts the result back into my buffer). That way I don't have to first
> `:cd ~/src/git` and then `:Git ll xyz`, I can just `:Git ll xyz` and it
> does what I meant most of the time.


The same question is clear now=E3=80=82
Thanks for the explanations from Taylor Blau and Ren=C3=A9 Scharfe.
