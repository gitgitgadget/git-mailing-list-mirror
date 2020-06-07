Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E63C433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 06:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDC320663
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 06:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rup1LGsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgFGG2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 02:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgFGG2N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 02:28:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911D0C08C5C2
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 23:28:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t21so8029024edr.12
        for <git@vger.kernel.org>; Sat, 06 Jun 2020 23:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WaMBbX8GXiN27ezofZe0tMlsYuStSThhwiO22XDDuKk=;
        b=rup1LGsShKqN9YoNsm1esPjxyho/Xfpol3yan5Djk/h0YB1BrU+5SeOjZd2Rh3YWA6
         lz01fpzufgeeDChUv3O0uhFGZW05VY5t8eqlPnLiiGIiU9UbUU8ygLPJsvPHMZ/YUO+f
         oWTkjCueR8M12qbYZuwx/CsWFJV39lOi38ReDXnPjI8fRVj1fALhHS/msUjB1f1MGlm4
         V58rMG5vWNVvq3wF4R3RuSb63vy4JV/un0FBi0rStD2xmnNrvJ37N2+phcnfyBSiFDLo
         PxIUV7bms27pRXcRbSDWF6XMdbySA9juVkrB6Vo+uufKh2y507rQg9n25ZZ2Ag+UP2SH
         OpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WaMBbX8GXiN27ezofZe0tMlsYuStSThhwiO22XDDuKk=;
        b=SCKGeYEmaAVd22eSIeNdwqTrgt/D/o6i47BTN94aUQbIm7LHQFDLagrvymdWUtMhPD
         YcUmzXCUz5AW0NZm414hsw5Wr7NfVWdDlgKJC0HngEtMJ42B6djutJ+bJLN9h9tTLVwa
         OPnTVTnj5R/27uEMT1DlrDLlEs8Z4zdbUVOIDt6zDDksf38HQ6mjXFNdby1CX+lr/Jda
         Fn4WqZS+UzoOoWAs+oP/mnrQwOEGEL14H377Uk8EcJnVuY4os6jPN2jX5eVNmuQamw30
         ajRlwDKTg9Cc74wETIv6QpUdvLIluEDls9kGaZdb7uyPZimyEgn9cDy8nb4eXP5b4S46
         XUrw==
X-Gm-Message-State: AOAM532CXsyB/BukD4aJ2JNe2DSm3M9nJOaP2Tf3JETqFL+5tytapUw+
        SPmU9qrgZfch8xvNU2OytCO5eixVazlg8NCCVrU=
X-Google-Smtp-Source: ABdhPJw+STcG93gH5oCR88p+mRDWVmi7CglDb3pDJwI4XeVQEzVRbROz1LBUuss01whtV2WwySUmJiFqZJiCps6A8HQ=
X-Received: by 2002:a50:9d46:: with SMTP id j6mr17065179edk.362.1591511290826;
 Sat, 06 Jun 2020 23:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com> <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
 <CAP8UFD0V+=tq8CGFk_Mz+N=HjRtkhkMbX9Cy2-=WfHL8wrj6=Q@mail.gmail.com> <8e479e02-81c5-6329-ff1f-304b1cd4e292@gmail.com>
In-Reply-To: <8e479e02-81c5-6329-ff1f-304b1cd4e292@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 7 Jun 2020 08:27:59 +0200
Message-ID: <CAP8UFD3O=+FyY4TrwjDdwGBAEEK1QPPzMZ0WSEL8UM_cecBgoQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2020, #01; Wed, 3)
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 6, 2020 at 4:53 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 04-06-2020 20:02, Christian Couder wrote:

> > Then there
> > is the issue of making it easier to build Git and to understand and
> > fix build issues.
>
> Yeah, that would be nice. As a first step we could link to steps for
> building Git from the hypothetical article about the '-rc'.
> The "Install Dependencies" section of MyFirstContribution is
> an option[1].
>
> [1]: https://git-scm.com/docs/MyFirstContribution#dependencies

A related issue (https://github.com/git/git.github.io/issues/435) was
opened recently about https://git.github.io/ not helping with
debugging Git, so there is a new page to try to help with this. You
can see it at:

https://git.github.io/Hacking-Git/

and:

https://github.com/git/git.github.io/blob/master/Hacking-Git.md
