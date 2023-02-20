Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88E8C636D6
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 18:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBTSdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 13:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBTSdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 13:33:16 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706416310
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 10:33:13 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17213c961dfso1829978fac.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7joTHcaJGHtefQLmru9+nhcmsFJuwWVAQew87GGQHJ0=;
        b=iztdYQrmC/nPvaE+Rc5+2539H+TX+Nc0l3XV6RojwU7BYPWauY1EMwuVE+XQWEQSRe
         juZDSZInx2KhzrnHfp4jYd5wucW/il+9bSWLU1k2skBEPN3Su25W1mJGsAFFY9nKGz9/
         kn5G4/MpxK+IE5BoJE8SRxUsDL2avSJrp2kuKXM/WSRZUyV7bQKt7KVu5JuO7SwntofR
         b/lcDjL0y9SSH0suVmFzrNQjNtv60cWAfe9zouXqc4b1YKI85BpT2Zh769jdvqFy2ISw
         3EB2wV2oLNmHibvmoDvAUbkYV9bmfaM1QF18R96YBELidjJ2OhYZ+EKu9wunESf10kG8
         uhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7joTHcaJGHtefQLmru9+nhcmsFJuwWVAQew87GGQHJ0=;
        b=zztWQlOC8MpvU8L2Bx8e8mrwef95LBYSS29vsUhEBWDeyxbZcBXTa6iuHxetsvmdP3
         t3o5Ig1IrhNKP2IXmd/veH4X3nYLwkWiNhqnQRflb/qPI0s3S3uo4ZEZ+HsAns7BOKwm
         6YryBdbOqkulxBOP27+dGyZo2Tf44jRvOuwcgAFQspYJ/dRo1FRvkKo6vwdDQtpCjmUm
         gMfdDdSq/a1TOxncYr7v/ov3x+mIQXXDVU0chzgoTZs7owtH7i2b7hAvYHDaQRDjQAkd
         HMGw8Nx7wRx1QrbK41p/XE3wj7u4CX35jjRHAYNsKFsc4h+43jwyI8zuKIL3SDs/lPrR
         oT6Q==
X-Gm-Message-State: AO0yUKWyFIRLQ7LKYDzvLCSCKgRkSlZ/r2fEvLiIbbO2cM/vqr66BLWe
        zE8maPltZ1FjtvJHr5Q0fCuws/wm1JO9zM4GzjU/PqNn5r0=
X-Google-Smtp-Source: AK7set9gzLXmGSJkT/p+pgCSO61sDyNS15xoqhagcd7PyLFX5PKG1j8RRIPCu0Hf5FkS5BK3gru9zI/NnsKaw9+O7nQ=
X-Received: by 2002:a05:6870:1d06:b0:16e:902e:39df with SMTP id
 pa6-20020a0568701d0600b0016e902e39dfmr785222oab.154.1676917992515; Mon, 20
 Feb 2023 10:33:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <CAPMMpojCYAwwu6_BE+myFaUy6fLqVSWAyiRWr_dGAmMqqUF12Q@mail.gmail.com> <CABPp-BEtXf9ja7Ec1fZ=BZwFDa+50zSAhtm3nN_=k+Nc2c=RXw@mail.gmail.com>
In-Reply-To: <CABPp-BEtXf9ja7Ec1fZ=BZwFDa+50zSAhtm3nN_=k+Nc2c=RXw@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 20 Feb 2023 11:33:01 -0700
Message-ID: <CAMMLpeSZs8DqrN6_F9-eg7fcbjV-O5+3V+hUsOhyd0x10xsCaQ@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 5, 2023 at 9:41 AM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tao Klerks <tao@klerks.biz>
>
> Unfortunately, this rebase configuration can easily lead to non-expert users
> accidentally rebasing not their own commits, instead others' commits, if the
> new commits they have locally before the "pull" include a merge of another
> branch, eg "main".

On Mon, Feb 20, 2023 at 10:21 AM Elijah Newren <newren@gmail.com> wrote:
>
> When we teach new folks about git, and get to rebasing, there is a
> simple and easy rule to tell users: don't mix merges and rebases.
> (There's a minor exception there in that merges with the upstream
> branch are fine and rebasing can let you get rid of those otherwise
> ugly-and-frequent back-merges that users sometimes make.)

The "minor exception" is merging a topic branch into main, right? And
the "ugly-and-frequent back-merges" are the merges from main into a
topic branch?

Tao, the primary motivation behind the `git pull` warning was to help
prevent users from merging main into a topic branch when that's not
what they really want to do. The fact that novices sometimes do that
has been a point of pain for many people, including Linus Torvalds:
See "Don't merge upstream code at random points" at [1] and "github
creates absolutely useless garbage merges" at [2].

If you're seeing users merge main into topic branches without a good
reason, that does sound like more of an education problem than a
bad-defaults problem. We might still want to change the default to
better support the more unusual cases, but if you're going for a quick
win, it would be faster to teach users the wisdom of not mixing rebase
and merge in the first place.

-Alex

[1] https://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg39091.html
[2] https://lore.kernel.org/lkml/CAHk-=wjbtip559HcMG9VQLGPmkurh5Kc50y5BceL8Q8=aL0H3Q@mail.gmail.com/
