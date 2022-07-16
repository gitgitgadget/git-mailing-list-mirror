Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D06C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 12:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiGPMXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiGPMXh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 08:23:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105A1C926
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 05:23:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sz17so13213395ejc.9
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ZsjEL6Oob5pGuWDbC48cY4tabf8ChKVD6BL7FD7h+c=;
        b=Y5UfF/uK/StL8i5oKWnDIt2Fp/BLhULP8+togw0O62XGgynxCzow5rZTu0dSUn7qsL
         w64GZ2ugnXqSPA2Gsv61lOwkr9Z7b8EC1B0ybGbjNPL4X+urbZJK4++dzYEmrsxZVOoh
         9U6E8UaXRz2F5Qvd/yfOJmaXkiKGI2DlaL2WgGCbZ8qoKo5xesAWXcqayXZelisND4IG
         RKFnU2fDcsNyf0/2Jn5AlMpNzIXVzS7/GbGz1qahHzB+oPRPsQwJZ5w7PUXsqgALYaxs
         nHTXZDAv8679dX5G7B8ToKxFro7mPnAqNhNqLrSi77UhWHqO/Xgo+XVPOKzRyUWNZr0P
         yO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ZsjEL6Oob5pGuWDbC48cY4tabf8ChKVD6BL7FD7h+c=;
        b=cDLG5Kf9UX9Hc5kFTgjzv2TT0UQry5PZPbOx8Z1ItVuqJYrgOc6wBY+Fn5ZoxFNPpV
         tGQqDEemTtYgzyMvrdpiVIlyNuNKTM2Prh7HUcz98qyuuv4yz+G9Zi4kjXI0ZpHgMJ8/
         QV+J6WYU+GhrSRzPoh1XOb1Grzfr1uYaBFfAqHV+Sa794lpJ1PMFmocwaC6dpoym+KiW
         0B0SlU4VTnQ40i6sVncWQQotVVU+rnmhEch86R+l859FdsJG7B9B/wQth2S8sVw/EOU/
         kVf9KiMetdQopXoGVUykYBkshE/W513DOBS42M/lLoRgrWfYTxx7g6K/SGEATi7rFwle
         7Xeg==
X-Gm-Message-State: AJIora/MyIKpR9+cxRoPhTSW/Rtp7AvoG6tcRkeyOU5EJgZdlRbLidOE
        Z99LTRh9BwJ8cLRq5vX+JRLTJ5O4MeOjjpdvMGrHS4zeqXE=
X-Google-Smtp-Source: AGRyM1vFCpTMaLC3yoe2v409P74AeRD+A0dNmq2d+dMQvoBl2JM3AoXOOqvZaC41DddyUo94h+6WvaHM2Q0+KVTlTNA=
X-Received: by 2002:a17:907:b11:b0:72b:54a5:7d2f with SMTP id
 h17-20020a1709070b1100b0072b54a57d2fmr18308947ejl.173.1657974214569; Sat, 16
 Jul 2022 05:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq7d4g8onl.fsf@gitster.g> <220715.86bktqzdb8.gmgdl@evledraar.gmail.com>
In-Reply-To: <220715.86bktqzdb8.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Sat, 16 Jul 2022 20:23:23 +0800
Message-ID: <CAO0brD3fdjQNfQaUBJRAHxDc24K00zpBUa62zST0=cZ5uz3vGA@mail.gmail.com>
Subject: Re: ab/squelch-empty-fsync-traces & hx/unpack-streaming bug (was:
 What's cooking in git.git (Jul 2022, #04; Wed, 13))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CC: Johannes Schindelin

On Fri, Jul 15, 2022 at 10:18 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> I hadn't had time to look at this until now. There's some interesting
> behavior here.
>
> The code to check the hardware flush was added in aaf81223f48
> (unpack-objects: use stream_loose_object() to unpack large objects,
> 2022-06-11) (that series is now on master).
>
> But as my ab/squelch-empty-fsync-traces notes we always add this to the
> event, so the:
>
>         grep fsync/hardware-flush trace2.txt &&
>
> Is equivalent to:
>
>         true &&
>
> I.e. it's not testing worthwhile at all. The reason you're seeing a
> failure is deu to 412e4caee38 (tests: disable fsync everywhere,
> 2021-10-29), i.e. our tests disable fsync(). What you have queued will
> pass as:
>
>         GIT_TEST_FSYNC=3Dtrue ./t5351-unpack-large-objects.sh
>
> But I think that would be meaningless, since we'll write out that on
> FSYNC_HARDWARE_FLUSH whether we actually support "bulk" or not. AFAICT
> the way to detect if we support "bulk" at all is to check for
> fsync/writeout-only.
>
> *Except* that we we unconditionally increment the "writeout only"
> counter, even if we don't actually support that "bulk" mode. We're just
> doing a regular fsync().
>

Agree with you.

In fact, since stream_loose_object() only works with objects of type
*blob*, the rest objects of *commit* and *tree* will still use
write_loose_object(), so "grep fsync/hardware-flush trace2.txt" did
not check for the changes in stream_loose_object() at all.

I haven't found any reference cases in the existing tests.

Perhaps, we need more efficient "fsync" test cases?

Thanks.
-Han Xin
