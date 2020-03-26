Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C0FC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 12:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3FF20658
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 12:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20150623.gappssmtp.com header.i=@smile-fr.20150623.gappssmtp.com header.b="1Eq9nsmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgCZMk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:40:58 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41924 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgCZMk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 08:40:58 -0400
Received: by mail-ed1-f46.google.com with SMTP id v1so6599581edq.8
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c04Xep7QIi8I9uvyF1sICruhwLaBPRU4Iwt5J6U62bs=;
        b=1Eq9nsmWK3CLcZnoi+6GQl0LrDy+MhObHTcQrfR5wbecliwmE+yMbZfjTvwUEZhfxY
         oIr9fybtT43Cjf9lJqg6AurYKc2n96LwIOUp/2mTIbjLd4+deNaYpq/YPdYIBLmHpkXp
         PfEzrQCKQpE4Z7PqdnOXtR3dCTomOgU7u5voH4zdOfqCeJWCYpE3L2HTbDBnGg6jbOGg
         1j77G7KVP92Tc2GhYtcRyWjP2vU9iM5N6XXLCAHDwmk6fTCEwWq3F4rM//jEenfEIgg0
         MsuYPSwYt79NrSclTZuVWRWPJmp9juYtFlWThPgVdjfr831YXpvDNfeS2VmAABRD2N1S
         Y0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c04Xep7QIi8I9uvyF1sICruhwLaBPRU4Iwt5J6U62bs=;
        b=nCe3w7df0W/1vf+G/PvxpQj2QkVX+P6wpBh3IscNHHCmILZf57r95gy9cZ3zvJl5HR
         GVExWfYoVEBHffthikdIPzeUZ2pwX16/IfigNFb7dyXgS3mFg8f13BtSzN/fmyHKGC14
         mBzkdIA9Y3Quukr1M7fYGBE5vSA6GmzlR1kQLa/RkedbKRcAbkbKfAilasyCEmVTx19V
         HA9NCmarfqUntupgFWzgcfquMlfg2EL+gxVcsu6C4bv8Hf24qDL383QCfT/Eag2maqEi
         VWGy7vh9v2/tgk3Ne1ujBp2vfIAZ3Fh0FZm8L1X4DhsYEwJSsJ8i9X1G21DfIAb2v0yD
         UYqw==
X-Gm-Message-State: ANhLgQ36mISdVRK8HMvX68O9fvKlb/l+OYbPR5pUDTqFvjtBM05iEn4L
        z7AoQ8mxYjc1qiAFNyE17lfcjL5x/F5LHe3MVLSpMrX6Sy0=
X-Google-Smtp-Source: ADFU+vv+geqsUcFwhmq57FsJbxoaNIyZE8e9VhB03Lx7mBg22zhlqET8SxkvSkB5wqSaRn8LRuo64xfd50k8xdw8zog=
X-Received: by 2002:aa7:cf91:: with SMTP id z17mr1797847edx.29.1585226454100;
 Thu, 26 Mar 2020 05:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABt=S26FB1zkwDCdmXeyVvFYvpvuGSX_y1Fg5N3K=yq0ZMyR7A@mail.gmail.com>
 <20200326111500.GB4193632@coredump.intra.peff.net>
In-Reply-To: <20200326111500.GB4193632@coredump.intra.peff.net>
From:   =?UTF-8?Q?S=C3=A9bastien_BRUCKERT?= <sebastien.bruckert@smile.fr>
Date:   Thu, 26 Mar 2020 13:40:43 +0100
Message-ID: <CABt=S24vy0QpuVHoXdzTcRb3r6mU1AdswrGxOPksdwdrBGpEBg@mail.gmail.com>
Subject: Re: [RFC] Representation of diff with trailing spaces
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > # Abstract
> > Something that always bothered me with git diff was how trailing
> > spaces are represented. If I add spaces, then diff, they are
> > represented in the terminal by a red background. If I then remove
> > them, they are not represented. That's how I can have a diff with two
> > exact lines, and I'm looking for the diff in it, but can't find it.
> > Because it is the non-represented spaces.
>
> Have you tried setting diff.wsErrorHighlight? By default we only
> highlight whitespace problems in new lines, but it can be told to show
> them in old lines or in context.
>
> -Peff

Oh yes, that was what I was looking for, thank you Peff!

Well, if there is a config for it then, no need to change anything.
