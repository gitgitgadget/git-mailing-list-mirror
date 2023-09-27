Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37734E80A93
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 06:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjI0GSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjI0GSf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 02:18:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6046DE
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 23:18:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c12ae20a5cso168368751fa.2
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695795512; x=1696400312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOaAaD9oUJ0FNDy5hQrOsfimXuCOzKWmnoAXkSHyT14=;
        b=K0wWHAKPrx+3NT/y60/7WTIOTuD6Ms3N3MX5JB+O04W47ryjt9PwJ0K5fmNyC66bVv
         7QDd8mgNIg0Q8z8omeP+LV7ZBuahxWZQPxPd62Fd91qSDquCUGSMgWGdMuhWB1zVpmP6
         zE95sLmTNe3i+LTVSr2ZErmx3U/8Ygx2HmhxE3xxmGgTlcH+o1Sc+gLUh3yTylJTTlMN
         QXByXDrUrauU106d0JcIpPi1iFw2kgkZoU1pZ2N0dEKveeJP2+rDEN/6OjnMR12186Ty
         BQaDvKv4gUHdkpSwfL1QyQxxnTEOeka8Vw+as5D3BZdnokNeXAP3lapcOOuy60okscNc
         IOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695795512; x=1696400312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOaAaD9oUJ0FNDy5hQrOsfimXuCOzKWmnoAXkSHyT14=;
        b=LdH+y5Z5JOoEg4qVaz9HTsbAdJOZYXQvdgZ6nog30KEf2VlRpSvs/V7LBhFiX0mdo+
         JQCp3ItEeIMZf21ewabegPc5UFE3NkaG0Xyw8n4Ce8h3sIzBw3mcnr+KPPoRvL+8vlNt
         1ivlJ7j8eICH4f04iBaGb/YauIaBT5eotRpqSp6CPzArWtApufFuEPcqXdvbmA3z039R
         A5uHGNha9s52xm5QtoiFFNoqrRe1WvZ4XbD+shtKvr2Eazitd6WPsfPrt1rbHAqL2jGy
         49zXbJDVi37BK/3NxrUoounqswsJDS9tvTxTeW2DE1cjoLDtRBEJdxs52MErvaVEUqf2
         PlrQ==
X-Gm-Message-State: AOJu0YzHts+/ahaqnNgfeNZ7c8OGmgZr2fCNK47q32ynbuRAWYYRAAcH
        VCW2ajmwG+qYIejRLHqdSw7dQc3383W1Ss10/zU=
X-Google-Smtp-Source: AGHT+IHXBhDaCC4/pUlmrkJTd+T1gZ5jm4WSur2aiRgZDwXvaLbGTOCdvHGg1av5wZsihnMOCxO3Fp/Qi9jWemreSyk=
X-Received: by 2002:a2e:b1d1:0:b0:2b9:ee3e:2412 with SMTP id
 e17-20020a2eb1d1000000b002b9ee3e2412mr1100169lja.22.1695795511605; Tue, 26
 Sep 2023 23:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
 <1c12ac0a-5e45-bb27-c452-250ffd4b9320@github.com>
In-Reply-To: <1c12ac0a-5e45-bb27-c452-250ffd4b9320@github.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Sep 2023 08:18:19 +0200
Message-ID: <CAP8UFD1S-rc8gWREEDe1LU4aojbXND85SmRGGBoJ-0E_KpS2Bg@mail.gmail.com>
Subject: Re: Projects for the next Outreachy round
To:     Victoria Dye <vdye@github.com>
Cc:     git <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Shuqi Liang <cheskaqiqi@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Tue, Sep 26, 2023 at 7:18=E2=80=AFPM Victoria Dye <vdye@github.com> wrot=
e:
>
> Christian Couder wrote:
> > About the "More Sparse Index Integrations" Shuqi worked on, mentored
> > by Victoria, I am likely not the best person to mentor it, but I think
> > I could manage. It would be nice though if I got an idea about what
> > should be done next and how much work is left in general in this area.
> > (Shuqi's GSoC final report at
> > https://cheskaqiqi.github.io/2023/08/22/Final/ doesn't talk much about
> > this.) Perhaps even if Shuqi is continuing to work on the project,
> > there is still work that could be done in parallel on other commands
> > than the ones he is working on.
>
> To be honest, I'd recommend against using "More Sparse Index Integrations=
"
> as a project again - I was actually going to suggest "retiring" the proje=
ct
> after this past GSoC term. The remaining commands are all fairly complex,=
 to
> the point that they'd be challenging even for someone that's done a lot o=
f
> sparse index work.

Ok, I will not propose that project then.

> All that said, if someone is *really* interested in this project, you mig=
ht
> be able to get it to work. You'll probably want to limit the scope to one
> command and make sure there's a strong emphasis placed on testing. Sparse
> index integrations can introduce a lot of subtle bugs (e.g. the one Shuqi
> found in 'diff' [1]), and a buggy command is worse for users than lacking
> sparse index compatibility.
>
> I hope that helps!

Sure, thanks for the interesting update on this,
Christian.
