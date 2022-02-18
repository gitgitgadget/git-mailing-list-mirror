Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F60AC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 06:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiBRGFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 01:05:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiBRGFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 01:05:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6E265139
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 22:04:59 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h18so13616415edb.7
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 22:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GdTWd7ka9BoXSGFb4v30fAjD5FkwoXI0KldCvuxaQDA=;
        b=VSl0BplkORmOlFHcKsvdOL3FQhT8obIln41sbXlpdXPQ7ZQNdV9nV2JafNQPmosjkl
         yzPOrESmGQ3gTceUUsVVoAmeOfZtEjx51sBNrg5dnQC7wXkMvkJz7CDdjR6V1KOtNXjF
         vnkwyaDeTFPEJosspsALlFjfHf6CQCMGMnMJ01aUlFgcN0DpRAoLFEr5KBPV0nf3tAxr
         xlPw5pxWLXAmlt89Y2zGHbQQ+CQbctQw5mVHL3ksDtJlh9jYskNAbXP9/0XumSppgYbp
         wp4wDbCC8UZYbfXXyLpe6jLgEXWbYCBHdxDEE6Dw31LvO8Edh3epPSQbVxoxxF1DcJ9y
         aHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GdTWd7ka9BoXSGFb4v30fAjD5FkwoXI0KldCvuxaQDA=;
        b=Ttu17qotXP5ok2Pa6aRV1GwI8sFQgCOU1Pg2WJb+7YWWYP3h7kS+/bPdhPfjOSz4BT
         YSuYtsCiyrN3hcVUeHLaAMnlGJAR+Um8WRaPwDiGtYBlWUhTk74Ig44OHwUZQ9lC76uT
         TXTsVoDP0O4iLHhufTyaIU2EKYiCpvxpgwrDRtFXjapU4C7XWR7x1fNJWLRaBMKgYuAe
         mkHvLydNwfLoxxEPj6Yg0XabSx1iEDzSe+4aP/8UNM2o2vdpTVOoYVU9BJ5YgO6rB1E3
         +HoMaBfYadQlT+eGUju+52KSAL04hUMjTOI+R9HO9xFJAvmVCwAv3J0Gp9GLRaXCF7hl
         2sLA==
X-Gm-Message-State: AOAM530LyB67JYqbMtOOBpRUb2NRl9auXOS/I4wWNx8fI06UtZ7IIyXT
        ZiTvP6sEzhflJcJ75S6fpNfLOxPwVOvsKu2FlS0=
X-Google-Smtp-Source: ABdhPJw+mkhe3sKIusMioG/A3sRc/9X4D19E/gUPfUtgGssNoYVlm1SZH79pGJ4/Vn2p2POh2/TsvfUvDXeWRwDFHCc=
X-Received: by 2002:a05:6402:11cd:b0:410:d432:2e30 with SMTP id
 j13-20020a05640211cd00b00410d4322e30mr6347849edw.119.1645164298169; Thu, 17
 Feb 2022 22:04:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com> <f57820e25d67b6c26958d3dfbd33234dcaf4aee4.1644913943.git.gitgitgadget@gmail.com>
 <220217.864k4xkgn4.gmgdl@evledraar.gmail.com>
In-Reply-To: <220217.864k4xkgn4.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Feb 2022 22:04:46 -0800
Message-ID: <CABPp-BGUQiBXFMcWicz-6bYC4YPp4o6YNRwq4MwpZze1QwbpeQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] sparse-checkout: pay attention to prefix for {set, add}
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 1:05 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Feb 15 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
>
> > +                     die("please run from the toplevel directory in no=
n-cone mode");
>
> Isn't this missing _() for i18n?

Yes; thanks.
