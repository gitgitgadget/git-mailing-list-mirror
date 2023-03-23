Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B26C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 18:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCWSRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 14:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCWSRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 14:17:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C3E421B
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 11:17:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j11so28958960lfg.13
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679595422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+anZFXIqwW8bh8byP/5bCpTWkDSVHhKX3D1vmL6VF4=;
        b=lr/esdXSa90HuRHWxqydK5RM+M/BTLI19IBwGATq20FbwN+fhmv8Wcn74YGz5/2AId
         wDrCsZyTh5Hx8AZhRygCqOoPvKBkgQryBiNBStCi6dcUtec+7JQEVL/wFVFaaPOLL79g
         lUSJKamSNYS20hRkpZJcQweFIPSp+CbuA6/Q6EdG3lERznh73WFstiHdNylPdiGD7dKc
         CUzseduBFwEUg/eVa27N1vzJnYOu4Mz09IJCv2C+5YfNVN//2+Ph7yfcLyeej4SLaNp4
         ePMjIAlzRq0Ca36/kksx5gUPkyKyJnhJ5vai2iMsJLlkI/LwQHNwZ3bw6F4rMHMjKCrk
         6i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679595422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+anZFXIqwW8bh8byP/5bCpTWkDSVHhKX3D1vmL6VF4=;
        b=q6vfbF4wRddV3lfGe1dHAfLm06sAd+mZFoqD7lYkFLIF0A8kP4Q3Zxl1jyCIVhgJ3m
         1pZczOEP7HLiXKNm0XV26uMxkRmRuEnwxovbkOnY5L5/TtdwTjmnP3A5So9ASb72Qvhl
         iE5qMwOCVpK0AiMO0khDvFlwb+AYuVgnMxVBtG+xms/Bfgn+ai4z/DpndUJQFHyw1v9A
         NuQGE2WwNhmrvEPePI8zMyfp2F+QiVuzX4Ce2mavvfK5ZRnIEAZXITMo0qnvUtZjJ3tV
         viXwg19PRIUns7Gk7yBhKhyEQslo6SJAsiu9txANOXKSNWETobZVWxovluzZqWw6g2tq
         L49g==
X-Gm-Message-State: AO0yUKVTYyjfFvBf/sURdEJTPbPJXuGUEFSdzC30LXEqpOs78dBZ8Gd/
        0an955w2UemdZ/ubTs4J8nmWX03QYGAPK3eAg+o=
X-Google-Smtp-Source: AK7set8lvI+0Pu5tcghh+yOSt/pcTr+86bSNb9tDQPNiNIl8621o5mBAOS7AdrbkomUTeP3JYrsrSoHqvJsajCX01t4=
X-Received: by 2002:a19:f504:0:b0:4e9:bcf5:a0b6 with SMTP id
 j4-20020a19f504000000b004e9bcf5a0b6mr3274690lfb.11.1679595422495; Thu, 23 Mar
 2023 11:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
 <xmqqlejrmj4y.fsf@gitster.g> <20230321172223.GA3119834@coredump.intra.peff.net>
 <xmqqjzzahufj.fsf@gitster.g> <CAEpdKf=pMcMn6q0wGGcrFN1yi1duguSNLDkqhDmvMBeKQ--yuA@mail.gmail.com>
 <20230323180159.GA1015351@coredump.intra.peff.net>
In-Reply-To: <20230323180159.GA1015351@coredump.intra.peff.net>
From:   Stanislav M <stanislav.malishevskiy@gmail.com>
Date:   Thu, 23 Mar 2023 21:16:50 +0300
Message-ID: <CAEpdKfm0S4tkLz8DMnkJmhMmJk8Cj1tUm7NbMe7kpATq0bkxCw@mail.gmail.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey types.
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stanislav Malishevskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my opinion they need the same set of tests which is used as usual
for https. But use the right certificate and key.
But I don't have any idea how to do that with hardware usb eToken in my cas=
e.

=D1=87=D1=82, 23 =D0=BC=D0=B0=D1=80. 2023=E2=80=AF=D0=B3. =D0=B2 21:02, Jef=
f King <peff@peff.net>:
>
> On Thu, Mar 23, 2023 at 12:33:59PM +0300, Stanislav M wrote:
>
> > I want to do some clarification there. Those changes are not related
> > to http or https directly.
> > That only configures curl to know how to access the certificate and
> > key locally on the client box, so if the way is wrong there is a
> > simple error: Certificate or key not found.
>
> Yes, but I'm not sure if there is a way for Git to trigger curl to look
> at the certificate that does not involve feeding it an https URL (and we
> want a valid one, because we want to see that it correctly speaks to the
> server).
>
> -Peff
