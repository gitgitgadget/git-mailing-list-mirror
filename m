Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6CCC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 18:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCISpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCISpt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 13:45:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F40F9D32
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 10:45:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id k10so10804467edk.13
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 10:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678387543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhIrh4P8FP1wkg4lumTQHte9K3CZmaJiQYRGFycvGjc=;
        b=bn/kyP5Ov78vD57aH5AFHMNNz+EpgT4bU7XmxTL3T81iI7qlX30YmzIHPr+1QvlGNw
         Tn5PWbSy2kCcqIIEgALLHvsbN70edSonGkNSdljncLUZRTu2sfTXLd5iXisGYivBc1GH
         e7fEM+/tRFsgvARXMfq9UHYsERDiQMHL0+9NukRnFK22DmEbs6H+6+60TJr43x6+jIFD
         3Adza1B/zlJLj5I/SXyENrIROKfNBNrKNqAVa+QMFY1+X1oUpEft4i6V3Zb0vG6wzNj5
         4f+RTVlXwiy3FOMoFLVxUenrxezpgaUXURvabCx49WjTcg/Baa6sIG5VRkFGBB45XJE/
         r+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678387543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhIrh4P8FP1wkg4lumTQHte9K3CZmaJiQYRGFycvGjc=;
        b=FQ0efMtPoCKYBJyws6RPjqNzhtraJ2xvCk3oE+3v49X33MnKZWo/7EMEKthrv5Zl5W
         gYLHAC1eMCpz/M8fgN0O7pUA9QI71+hsxWXo/iFwoK63aFKD4o8wRzOadSzlDcUUMyX5
         6glRV9lx2wz+sYkplFupBPqTU6cnzKgX7v+xiHX6Gq5Wpt17zRR5+fsklIVTvNnIvonF
         LaAbSISKto5vsXxu1IFZbkob+UoNtY7ASDYKZuR4zTRn/nXP8BaxnQURaCBH27QFnsjj
         D5nMDo7taTC/tdrDTw9Kx/NgeEEVgMHOu7bnzOlKvDKrmz5civM3nZcVT018k8bHqmqo
         M64Q==
X-Gm-Message-State: AO0yUKWgJZqemN3f7xUNDyWzF1AwgYXPC22qjFT2AaomyEynpvJ+gCWM
        a/G2Xwph+5XFQyHaQXmp9HnNFPFx6q2nntpHjiqQz2PVUjRgnQ==
X-Google-Smtp-Source: AK7set8ntQ4PXk4Qv1ykIG1StRPPV/4nnTbIQN1ldHGA1CpBtw6rnooqn0UdrptMYQx0A/Waej7OGyLbSOh4hNuOL6E=
X-Received: by 2002:a50:d581:0:b0:4ad:7ba3:5bce with SMTP id
 v1-20020a50d581000000b004ad7ba35bcemr12774332edi.7.1678387543364; Thu, 09 Mar
 2023 10:45:43 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <CAP8UFD20=SScM3XA4mjiNs=rHJY3i_9MOcL8uxsFT-mn1-JH1A@mail.gmail.com> <07423D73-8CD9-498B-89E7-7241AC6490D3@gmail.com>
In-Reply-To: <07423D73-8CD9-498B-89E7-7241AC6490D3@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 10 Mar 2023 00:15:32 +0530
Message-ID: <CA+CkUQ-T73NqPjzRT3t7X0PgoszHwVVWwPOnhxwFL7TcVhT_3g@mail.gmail.com>
Subject: Re: GSoC 2023
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Mar 9, 2023 at 10:49=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Victoria and Hariom,
>
> Do kindly log into the portal and complete the process and let us know.
> Once that's done, we'll add you as mentors to the 2023 GSoC program.
>

I have accepted the agreements. Let me know if anything else needs to be do=
ne.

Thanks,
Hariom
