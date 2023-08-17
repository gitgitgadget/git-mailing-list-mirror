Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF3C5ACA1
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 20:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354837AbjHQUUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354868AbjHQUUk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 16:20:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDC30DF
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 13:20:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-997c4107d62so20536766b.0
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692303637; x=1692908437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziZC12+VheBuvvXCLQPx3obZ/vcSDjWsL4Oc3OdQang=;
        b=lQV8ZL5nC7vugadMtn+jDGlBs57l/AbYZjiofdt1Tk3zzdUAWrIjH5vptu+xoua+AV
         1365X0d416xaB9zi+Zou/BItjF1O8dQSWiKvwXIzD/sNPXiQmWZWhAhm5y+rRQynEV/4
         WlV3/oV4mdQ5dYaXCrLCrtdDCLrB18ruVHizhJVqWZruOVYLalIOj/b+i94+YGJSu1Ay
         Cbz2Br6X7QEj69yzYnsDckep2N6Xz4LcfgMQF7dX9Rtdr/skoBbpQvxdc5sqD0DkEtQ8
         saRyxdvkmwdgu4C7CPST0kljDLl5ZUeXygBU9d/u6/VNnfBIxQEicL9TsauMrknPrBBm
         Kt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692303637; x=1692908437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziZC12+VheBuvvXCLQPx3obZ/vcSDjWsL4Oc3OdQang=;
        b=VBpn3HPr58m57IawB526n9QdL/Ef48gOzob8zxnwi+P97IH5gWd78AXIuLoNBn7cze
         zi0OSzIHAzsAowJ2rhtzbsIExO/hft3glGxNQr5C/5jHDH/2OQfJ1Zf0ogj/8nTm6ei+
         KWmdCxJNY7nryA4YJlTyTZOxFYhotdgff0I/0P8jwuSq38bSNPYfzdUK6iiIDtYNNufV
         Zn8kDU3uOlaB3swekI3lLQqRW1vaAOirSsvnXT0R8wDlIEn8Lnuq1GQd/iKJn/LvD2Tk
         WHXzQhtWZqhe1EHMr4AMzKUWWcU8K9FlabR6fXPiClvmp6QSiSxZqB7W/FRMiS9vIABR
         K6UQ==
X-Gm-Message-State: AOJu0YwTsSH2FgH1M03wd+UkKR2WgmhKlc//WO5fEewOH6r2I2TliFh9
        /WJLZOFQv3/VUkS0iyii4ZXgVCsqz1RVKCCTt+0V8lGk
X-Google-Smtp-Source: AGHT+IHX4lrXg6T5YYYQRGtc3qBe2C7XqxhDNJAZv5jQHjBXGbS/C1LLqM1Zszvvy1gBRz3SpfhO0UYa4IrBQ5PC31w=
X-Received: by 2002:a17:907:7719:b0:99b:f392:10b2 with SMTP id
 kw25-20020a170907771900b0099bf39210b2mr377428ejc.39.1692303637433; Thu, 17
 Aug 2023 13:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <CABtpZSGcL8hkk3HA3ECtt7KeLPOhuB0n7EKN1Tg5ZHpFBE0V0A@mail.gmail.com>
 <20230817195641.GD3032779@coredump.intra.peff.net>
In-Reply-To: <20230817195641.GD3032779@coredump.intra.peff.net>
From:   =?UTF-8?Q?Patrik_H=C3=A4gglund?= <patrik.h.hagglund@gmail.com>
Date:   Thu, 17 Aug 2023 22:20:20 +0200
Message-ID: <CABtpZSFT2BLJpeDwizZiXB8+tRRLqz+iAFuWaXAiwH_EgS5gag@mail.gmail.com>
Subject: Re: clone (single) commit id?
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As said, I want to use a commit id for reproducability and
performance. The CI flow starts several jobs, all using the same
commit id. A remote branch may be updated, and therefore considered
not good (reproducible) enough as the reference here.

(Regarding you proposal of using partial clones: Unfortunately, our
remote server don't support filtering yet.)

On Thu, Aug 17, 2023 at 9:56=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 17, 2023 at 09:45:19PM +0200, Patrik H=C3=A4gglund wrote:
>
> > In our CI setup, for reproducibility and performance reasons, I want
> > to be able to clone a repository with only a single given commit id
> > (commit hash). (Using 'git init' + 'git fetch' + 'git checkout' is
> > possible, but more elaborate/low-level.)
> >
> > At https://lore.kernel.org/git/MN2PR12MB3616C1F2E97A18547740651DF9E29@M=
N2PR12MB3616.namprd12.prod.outlook.com/
> > it is stated that:
> >
> > > Never mind, I see, feature exists but server needs to allow it. Sigh.
> >
> > However, I'm not able to find this in the Git documentation. Can
> > someone point out how to configure this? Can this be better
> > documented?
>
> I'd use a shallow clone with depth 1, like:
>
>   git clone -b $your_branch --depth 1 $remote_url
>
> Note that "--depth" implies --single-branch, so it will really just grab
> that one branch (and if it's the remote's default branch that you want,
> you can omit the "-b $your_branch" part).
>
> If you find the shape of history useful (e.g., your CI wants to look at
> just new commits), you might also find partial clones useful. Something
> like:
>
>   git clone --filter=3Dblob:none $remote_url
>
> will fetch all commits and trees, but only load blobs on-demand (so
> basically whatever is needed to check out that tip commit). You can
> pare it down further by switching to "--filter=3Dtree:0", which will avoi=
d
> trees (but note that filling in trees when you need them is a bit more
> expensive, since inherently you have to make a round-trip to the server
> for each level of tree).
>
> -Peff
