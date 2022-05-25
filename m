Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639FFC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 02:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243452AbiEYCC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 22:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiEYCC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 22:02:28 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D364739
        for <git@vger.kernel.org>; Tue, 24 May 2022 19:02:26 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id j7so7983128vsp.12
        for <git@vger.kernel.org>; Tue, 24 May 2022 19:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68wpE4sVmk4h/hpdetPvQ8ZT0UybLqqv6gY33NIFDGY=;
        b=cJGY2eye5dvCuLmoPqe7SVP0YMiGUNFi8t4tJxelvN9nvkCk/Wz7DuR/eVPQuvRQ73
         JvOyUKdjVCKcBMfh/tCHqrCOepzbpid28g536F+qdsvHNDho3j/WrXiGMEetxClXtWKR
         2+YW3Dk6PhxyOz287ipzqZzM1tSwmyoO4IJKrChyDZ/iHKHq61OjHgFfiBpsCJLVUnA2
         wtyVNX6EFumTbhGQ2/oiiLdyf2GCpER4eVzFpcMKvwIU+QteJu+hH0CFNMHobwZNfGHk
         y6vVIe9sbOsUcwmv5VZ3+XX5zryASPNoxH0mzqtJGhkWUho2AQtOEC0StsU6g3ngsK+H
         hoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68wpE4sVmk4h/hpdetPvQ8ZT0UybLqqv6gY33NIFDGY=;
        b=DcY7y6g20BXCqRiuCPY0hne7FrMj+X30kXRrQA5o3KFus0pCkuz1xM+88ZXcQqlPOf
         MqM5EB7oriaGMXUuFbQIb2YIhTS1Tof4oThwG51w0BRqFfwL7OeDGv5OuhSdMnV1lzyC
         PbJgUSJHt5pSf/dkglNEgX1UQ5+69fDvPheZJhSOAAfOCB6lssWhU7OGQbJsKmMh+9IT
         Fw5+EP5T9V6srT85JaoFdP2PtSWtKAARcI0nnHTscSsrCL4R97o3j8MW2EgcV3mRlBHs
         pyt1v+NclW5cY2ikbyJCj+eRhZFfqTkyRFUgjCYu5JkgBEBZhWPko0+jK1kG2LZRXKLZ
         CMKg==
X-Gm-Message-State: AOAM530bXFa+LetaSAPW588NTeV4LxWKmcKNGSNrmBwEbJyFWoNyaefn
        4Sa+RKwB3cnNvawt/010urxSCo/ZBYgqSPOORRPvndvt
X-Google-Smtp-Source: ABdhPJxuDTf7X3dgjkoG4IlvNS2H/n++tBuoVUz9rbJzEPaFwFxm1oQVIp0nelg5oGAhlKOJRAprXo2NLbBnzCcrqbw=
X-Received: by 2002:a67:c78d:0:b0:32d:1e85:9337 with SMTP id
 t13-20020a67c78d000000b0032d1e859337mr11331260vsk.76.1653444145929; Tue, 24
 May 2022 19:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651859773.git.git@grubix.eu> <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
 <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
 <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet> <xmqqr14jluu4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet> <xmqqa6b7lrw6.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet> <xmqqleuqj1gy.fsf@gitster.g>
 <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan> <xmqqo7zmcydv.fsf@gitster.g>
In-Reply-To: <xmqqo7zmcydv.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 24 May 2022 19:02:15 -0700
Message-ID: <CAPUEsph5udmc7pyza0WdhXDFfHSm96Xwt3CnEiPnSDSqY6fOUg@mail.gmail.com>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done with it
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please, I apologize in advance because I am making statements way
above my paygrade and without the relevant foundation (because as I
mentioned, I looked at it briefly a while ago, and hadn't been able to
get the time to complete my analysis).

I did read all your analysis and while as Aevar pointed out, I might
be mistaken, or not making myself clear enough, it is not intentional
and if told to do so, will extract myself from this thread until I can
do a full analysis.

On Tue, May 24, 2022 at 4:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Is such a use of the pointer in the structure a cause for an
> undefined behaviour?

If you make an IMHO overly strict reading of the standard (which it
would seem gcc12 implementers might have done) then ANY access to a
pointer that might be out of scope is Undefined Behaviour.

gcc doesn't know what happens to the variable after it gets shipped
out of this function inside that opaque structure that is passed
around between threads in curl, so it MIGHT reasonably assume that:

1) There is a layering violation somewhere and another thread is
modifying that field to point it to a different thread local from the
same function.
2) Once it gets the value back, then it can assume that reading that
pointer might be undefined behaviour because it might be coming from a
different stack frame than ours (after all, any sane developer would
store instead a flag)
3) since the if uses a condition that is UB then it can optimize it out

I can't see any other reason why in the original code, with the if,
the warning was still being triggered, but not without it.

BTW while trying to debug gcc to find out if this is a bug or a lost
opportunity for optimization of something else, I noticed that it
would only trigger in cases where the structure was shipped outside
the function through another function, not when it was returned back
from it, for example.

I don't even have gcc-12 in the current workstation I am using, but
would prepare a machine with it and debug further if you think giving
a more complete answer is necessary.

Carlo
