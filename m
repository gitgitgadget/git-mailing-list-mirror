Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AA81F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 09:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeDLJ1g (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 05:27:36 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33432 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeDLJ1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 05:27:35 -0400
Received: by mail-ot0-f195.google.com with SMTP id 23-v6so5239524otj.0
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qVDBJm3eBxy7uxj7ZXPDJxR3UvYQ21jAh4sODpYXqLo=;
        b=flaynQMtW7Q3Yx3bCV+yu6g8q8ZFRb1Ko+DlcV4V0V2lQCDaYdbu057ljpLgEQMUeO
         OiwZsgPKX3i1rnnDchtRBVMi/G0/rvuinpzOXOCgI/4Aw4hEhGAF91S7IkLvqaWmV6ax
         bwsgIfTvaj9w9ABN79JScgZcN2dy+3C4xa618=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qVDBJm3eBxy7uxj7ZXPDJxR3UvYQ21jAh4sODpYXqLo=;
        b=tpTbT3uw5KZBRUr7Ecuo5GZB3KlDPtI44DFdb90PcLb5OEw14DYr8dCEA2C9aJ2ZK4
         2uabfu+A4aVSTIE+AE/07S80GuyDC5aEtFSekVjI93/GdCnC8pMEYVwlq7RlRc8OkuIf
         +CBPjYcL+zmMFi8w24SkamUuqybjxDrOYfxnPpCBwKtgmcEKAz8S6pLUkUL/wsKdsTAv
         0tsH12uz+KR3TNPTYeFxJDjsLjI/sAc9K+UE2YceoFpsaKuz0EcymnAKv8o79WqdscnS
         CC3jzFYRGBL2nk1cFGsTsuisEQ6VuC/KTf6phTtZdYEw2zfWWevp6i5dnaIyeG6qDbgO
         0s8w==
X-Gm-Message-State: ALQs6tDU27jHl/BV4QGO0qqdfQc/oz7mTcTDXifRX0X19o9gGK14ze9o
        QZ0LxxPAUsvt5BvXf56PciSuvw8rsGXZedMdw1K6qA==
X-Google-Smtp-Source: AIpwx4/MaHperykWRtQw4v7+yNoOFk66L2RHb7BqYz54I1vd9BWDifeMnLQR/aMSTHL+wuLScuLu9Hx8kyQsZlfA6hg=
X-Received: by 2002:a9d:16ce:: with SMTP id s14-v6mr99934ots.356.1523525255066;
 Thu, 12 Apr 2018 02:27:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.200.2 with HTTP; Thu, 12 Apr 2018 02:27:34 -0700 (PDT)
In-Reply-To: <CAP8UFD3j-MGY7jHQK52zVLYMB=1vhCSFKxrvQ1JsRW-Rmnn8Qg@mail.gmail.com>
References: <20180411225534.48658-1-haraldnordgren@gmail.com>
 <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com>
 <CAHwyqnVg83xSQHRnDVz+aMxPPMj-3bWF4P8YUxEjurxnpDhFEQ@mail.gmail.com> <CAP8UFD3j-MGY7jHQK52zVLYMB=1vhCSFKxrvQ1JsRW-Rmnn8Qg@mail.gmail.com>
From:   Tiago Botelho <tiago@gitlab.com>
Date:   Thu, 12 Apr 2018 10:27:34 +0100
Message-ID: <CAF2Guqum5dak4us_HJtiW_gL0xgsihgUpidFEJzBgw-tEMunkQ@mail.gmail.com>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 9:58 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Apr 12, 2018 at 9:49 AM, Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
>> I think it looks similar. But if I'm reading that thread correctly
>> then there was never a patch created, right?
>
> (It is customary on this mailing list to reply after the sentences we
> reply to. We don't "top post".)
>
> On the GSoC idea pages (like https://git.github.io/SoC-2018-Ideas/) we
> have been suggesting "Implement git bisect --first-parent" and there
> are the following related links:
>
> https://public-inbox.org/git/20150304053333.GA9584@peff.net/
> https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/
>
> Tiago in Cc also tried at a recent London hackathon to implement it
> and came up with the following:
>
> https://github.com/tiagonbotelho/git/pull/1/files
>
> I tried to help him by reworking his commit in the following branch:
>
> https://github.com/chriscool/git/commits/myfirstparent

Thank you for the cc Christian, I=E2=80=99ve been quite busy and was not ab=
le
to work on the PR for quite some time.

I intended to pick it back up again next week. If it is ok with Harald
I would love to finish the PR that I started,
since it is quite close to being finished (I think it was just specs
missing if I am not mistaken).

Kind regards,

Tiago Botelho
