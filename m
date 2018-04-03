Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1941F404
	for <e@80x24.org>; Tue,  3 Apr 2018 19:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeDCTt5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:49:57 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:33642 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeDCTt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 15:49:56 -0400
Received: by mail-yb0-f180.google.com with SMTP id f5-v6so2725607ybg.0
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GdxnAH534NvOeuxQw5B5x2OVSw7y1du0g4SnzY3uq9U=;
        b=AFufm76Td/XQ5469J88Nqqr8tZyxPdgPCUbI0JcJ+Uc1yXQKo4+WBiUOD+X/RKURKy
         uixUiIJ8sVqONnzBfyv1QRBKPK8qQSK96hDCnAdbUjo2g/5j1Rt0Jwk+853MYzhX6nvR
         A5S4kqManEPamcVuefbzZtlHUHTs0G+G8F4LmBo3xJDpxFx4I7myZia0XQRkAFgV6LmI
         spHmvEgKMNbX4GB6mCL1ePvtd2/P7XaGbNqTMMHEc/WkBgcH4jBSc8W3tTxHzM66wAKc
         1K09HBprhWVj9QAkzxfQS1lHxLiSKIhoH16rnszmwnO4lgglVA/f5qSYtQ4Yg2puhsYk
         UjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GdxnAH534NvOeuxQw5B5x2OVSw7y1du0g4SnzY3uq9U=;
        b=RsA4SyYhd9Io5xMTWmA6+sHIAPO1a7NpPuSjV/LVhwgHOwkbZvP2qT2ji3A9LXQhCj
         h1NWa1wNVKwbaw8flmZ76u+tWyqFpmZ+uZM821Ym/C9cSCOh3gM+zTfeGTozjG6nO/DG
         6yGShssuEDjk15v8j3fv7eqD5lMVHGhanHRw39uHfRIaQDR6YOtMP+odgC9NK3FG5S2d
         u3+pF413gr9t/xu7sD0K/LGcBa80FVL3AIHYUAWEZEtkXFBlVBci22NNWkJ2W1Zdz+WX
         UMM5EtzhnkANLYzD8VdzjcHfDFdfN/hedwnRb17+mXRtiw4qaZGxu74vCXEp2IE4veVP
         JlIA==
X-Gm-Message-State: ALQs6tDARVfbWba3G7w+GYeOtLg4/JQBsy83DL+g+59BdIkLlzN3A6Fo
        LSUz2YdmR9Ofr8UNip+y9USEx/8/fcyojVDuOgm+LA==
X-Google-Smtp-Source: AIpwx4/a30Z3KXScGr6pPFIh7Iyf+Z6nA1tKye45nBwUYaShe0kECeZcB+7wjrcVS/E4fmgsX5m37XksNt85zuJsrmY=
X-Received: by 10.13.208.199 with SMTP id s190mr474949ywd.33.1522784995110;
 Tue, 03 Apr 2018 12:49:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 3 Apr 2018 12:49:54 -0700 (PDT)
In-Reply-To: <87o9j0uljo.fsf@evledraar.gmail.com>
References: <20180402224854.86922-1-sbeller@google.com> <20180402224854.86922-6-sbeller@google.com>
 <87o9j0uljo.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Apr 2018 12:49:54 -0700
Message-ID: <CAGZ79kaQV-F0by52fbv3fmOH_ZVMU6u=KOkJFxALyHHaH2Enfw@mail.gmail.com>
Subject: Re: [PATCH 5/7] diff.c: refactor internal representation for coloring
 moved code
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Simon Ruderich <simon@ruderich.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 12:39 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Apr 02 2018, Stefan Beller wrote:
>
>> At the time the move coloring was implemented we thought an enum of mode=
s
>> is the best to configure this feature.  However as we want to tack on ne=
w
>> features, the enum would grow exponentially.
>>
>> Refactor the code such that features are enabled via bits. Currently we =
can
>> * activate the move detection,
>> * enable the block detection on top, and
>> * enable the dimming inside a block, though this could be done without
>>   block detection as well (mode "plain, dimmed")
>>
>> Choose the flags to not be at bit position 2,3,4 as the next patch
>> will occupy these.
>
> When I've been playing with colorMoved the thing I've found really
> confusing is that the current config has confused two completely
> unrelated things (at least, from a user perspective), what underlying
> algorithm you use, and how the colors look.

Not sure I follow. The colors are in color.diff.X and the algorithm is in
diff.colorMoved, whereas some colors are reused for different algorithms?

>
> I was helping someone at work the other day where they were trying:
>
>     git -c color.diff.new=3D"green bold" \
>         -c color.diff.old=3D"red bold" \
>         -c color.diff.newMoved=3D"green" \
>         -c color.diff.oldMoved=3D"red" \
>         -c diff.colorMoved=3Dplain show <commit>
>
> But what gave better results was:
>
>     git -c color.diff.new=3D"green bold" \
>         -c color.diff.old=3D"red bold" \
>         -c color.diff.newMoved=3D"green" \
>         -c color.diff.oldMoved=3D"red" \
>         -c diff.colorMoved=3Dzebra \
>         -c color.diff.oldMovedAlternative=3Dred \
>         -c color.diff.newMovedAlternative=3Dgreen show <commit>
>
> I don't have a public test commit to share (sorry), but I have an
> internal example where "plain" will consider a thing as falling under
> color.diff.old OR color.diff.oldMoved, but zebra will consider that
> whole part only color.diff.old.

What do you mean by "OR" ?
Is the hunk present multiple times and colored one or the other way?
Is it colored differently in different invocations of Git?
Is one hunk mixing up both colors?

Is the hunk "small" ?
small hunks are un-colored, to avoid showing empty lines
or closing braces as moved. But plain mode ignores this heuristic.

> I see now that that might be since only the "zebra" supports the
> *Alternative that it ends up "stealing" chunks from something that would
> have otherwise been classified differently, so I have no idea if there's
> an easy "solution", or if it's even a problem.

Can you describe the issue more to see if it is a problem?
(It sounds like a problem in the documentation/UX to me already
as the docs could not tell you what to expect)

> Sorry about being vague, I just dug this up from some old notes now
> after this patch jolted my memory about it.

ok.
