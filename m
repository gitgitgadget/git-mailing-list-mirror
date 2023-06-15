Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115EDEB64DB
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 07:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbjFOHs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbjFOHrw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 03:47:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE2199D
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 00:47:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5189f49c315so1991682a12.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686815266; x=1689407266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Va02RGdsln+/JX1dNTqxG/+SWUn5PIoH0K4rfJDn4E=;
        b=PTK8RWvDclFntUSS+BPTIyPbCq37/ociVhxmeqrGjI4rGqva/e9ABXRgza+w9c4bhl
         mPPWWThHd6+Y2Y7hwX+vb6UpHbCi+5oeyYTpoq+RPOz4VB92bgvQkhngQwOUzsvK21DL
         y7v60ZHcUsd1TxeZHqdRjS/SJmegYcscP4Ca1oqJcf5krWCrFKxtypSGL4XAUUgExuWx
         Pv5HycCbxct/1tGwwF4k1pvR35B/Bz+GjeFC4RVLWVI4EXQVSZAp9++2tmLry1I6g5il
         EZUFbFVJTvvqgtIR6gdFWpaYE0Wy/dzIH7ZXhqWMQvgSwN52cqUVfj/G/4A5D+3rE0Mh
         nsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686815266; x=1689407266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Va02RGdsln+/JX1dNTqxG/+SWUn5PIoH0K4rfJDn4E=;
        b=Xcy4d0ihC714pIksMBgMt+XOo56kjpm+RIUMjRXZF7epGrnr1viGMwPCuIwqqKaQMP
         56i8bohaKm/4rfW46Q4dvMt6/IFjFQBMUv9od3ESGBzuLgdKtvZlCTmJ0KHZUdifY2pk
         +1kBi2aI4Tgymw+7vY/VkNJZ8fSUVNC9InYdFCIcgl5N94g10qyRkrtGEquUqPf7C4j3
         XKQciTLZgAp5RXXhodwRu6au0Dzj0nR8+Tvsc4+CVwp/mov7V/k26F8JMMTyKvWmoRmV
         F0S6mgynoiJj/wLBRfpT0IPtBbsp0HeMSWk+2t5gQruLMIiaD0/KuhBpfTtfpuE9R+Tj
         X1EQ==
X-Gm-Message-State: AC+VfDx290MFCaSrWT/EFSgsZ9j8p9JnEzCxS2xSX+MFblzJAZP7C/Nm
        GCtUyDjDJOFU3lEh5p7hcP2GyDwQ04MseKsEn80=
X-Google-Smtp-Source: ACHHUZ6rAwLBnme1cT0//qD/BTwTuk8EDTq9yRC7prNemlXGJPbNFSlG0Vh4aNOdHVkcBoKSTL2a2c2mmjZkCEfoljQ=
X-Received: by 2002:a17:907:a40d:b0:94f:1c90:cb71 with SMTP id
 sg13-20020a170907a40d00b0094f1c90cb71mr20580483ejc.65.1686815265953; Thu, 15
 Jun 2023 00:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
 <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com> <CAP8UFD1uTFCMoh9SnxNpRkvAK=6_VLLo_7yH5tuqS2auyX5G4Q@mail.gmail.com>
 <owlycz1xo243.fsf@fine.c.googlers.com>
In-Reply-To: <owlycz1xo243.fsf@fine.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 15 Jun 2023 09:47:33 +0200
Message-ID: <CAP8UFD3ryDoewoKnSWQcXE2H7OFn6aqK-D6Gjav=qXFGmUnHLw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] docs: interpret-trailers: reword and add examples
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 5:06=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > Thanks, and sorry for the late review. I found a few things that I
> > think could be improved, but I like the direction.
>
> No worries. Thank you for your review comments!

The version 4 looks good to me now. Thanks!
