Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0E0C4167D
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 12:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiCNMLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiCNML1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 08:11:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BCB33A34
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 05:10:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dr20so33061645ejc.6
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=in5RMpP94cRvrZESXCUpjg1G2Vzopix0tDNvzVRGmG8=;
        b=Vwe3gMdqWlVX50t0a2nw8FaSLTjwiZvoyNR6TXo0AEQ+GSGqVD8FfQqWgaIlsl0Kdw
         YRz84oxtdXtiU8rX5rLqKnaOGeGBPRjoPP/ckG4hPv7Dn5rvKPXvl3eGgYfSDy0qn4H0
         +fQ86cyPu6/f5XC/n371buGeVSO7cP+r/xEkjuG7RXRQWdyh1fNOHP9CARv+n0Dpbge6
         NtcjTSqQrrmQdg+Fw4VbVaHiEc/E4+QaaaX36Tzt0IracKigok+APLiczV3bsDfmIpFE
         zTziAGBWU2fdUT7yTBTq0JyjqUrDEbFoIAysV+cAaUshiC5X6ssoAaskUXXOg2Z9E7FS
         CErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=in5RMpP94cRvrZESXCUpjg1G2Vzopix0tDNvzVRGmG8=;
        b=KiBietkNjYSN+6qGOBENG6YSExYKXSBwI6Vv6M5nltXRFBXxDmyj1MMkoYEM9rPD6T
         v7qusLwlaZm+KasqwGOfWtVMkLZdZ6/4GzttQg5Yv+45h46GQC6VK384mLJjhI9LtYLu
         H4ag8n80PnE7BXL2DLkhNhKho07GoLAM6A6sMDJzyPJdNnecSHBQDbNh02ugqbZlMHKB
         +stJSWd2Zqqm284U6nZndhGUpKL+0wkItnKU5RWCFxnI1bKMXnJDpaHoe1Lojnl2/1Jh
         pOQg1aDhFnfqzcemG675aWjrKKYcHZjWr0aM8wRq/RQWUyDgtdqMA8lvQQdjTcJwh+ce
         rZCg==
X-Gm-Message-State: AOAM533yuK+pSsM40Af/ODI6yXE2pcn39dWUI24j3elKwGKivcE79bI2
        DoaApLZQHmZdEy6khwkrGhfdIT3WEz9Xf6r5pE1FKg==
X-Google-Smtp-Source: ABdhPJxCPHPgUvi7KDEUVOSm3qE63aNmLB/BqYyfpN02Vr4/dpNYrJMTP+OG1xmk8bSxm1ez/V3P5nJ/78+e2mR/lsE=
X-Received: by 2002:a17:906:a210:b0:6d5:9fa:11ce with SMTP id
 r16-20020a170906a21000b006d509fa11cemr19537548ejy.172.1647259813144; Mon, 14
 Mar 2022 05:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
 <CAFQ2z_Oht=-QrzoH8FW_Jm-B7u9O0wXUaY-ifwZah6gkcgVVSA@mail.gmail.com>
 <220308.868rtky4q8.gmgdl@evledraar.gmail.com> <CAPMMpoiDTprbf_9J3gY6WQwUVWfOTms6LVyJDYQUOcUp-42doA@mail.gmail.com>
 <220314.86y21cerhe.gmgdl@evledraar.gmail.com>
In-Reply-To: <220314.86y21cerhe.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 14 Mar 2022 13:10:01 +0100
Message-ID: <CAPMMpohNi4LhyQm+WYfmRRVZ_B2YfoqeRzWRusza6VUwkJUOWg@mail.gmail.com>
Subject: Re: Keep reflogs for deleted (remote tracking) branches?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 14, 2022 at 11:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> I think you might find it interesting to have pre-receive hooks
> e.g. reject pushes if you're deleting a topic whose commits aren't
> entirely <your author> i.e. just something like:
>
>     git push -o ireallymeanit=3D1 --delete topic
>
> I.e. it's an easy to implement extra safety check that people can always
> opt-out of, print a scary message and most people will think twice :)

That is indeed very interesting, thanks! I need to think about exactly
when this is the right thing to do, but it's a tool in the box that I
was not aware of!


> > My question is specifically about the, in my opinion, very surprising
> > behavior of deleting reflogs along with deleted branches - I mainly
> > provided the example use-case for context.
>
> Yes it's quite a mess, e.g. if you follow the rabit hole at the
> recent[1].
>
> One fundimental problem (discussed in various places around the reftable
> backend) is that we carry N meanings for an empty reflog:
>
> A. "This is an active branch, but we have expired the entries".
>
> B. "I manually created this, knowing that the various core.* configs
>    around reflog will say "oh, a reflog exists, let's log to it" (in
>    some cases).
>
> C. Another is: This is "stale" log, i.e. no branch exists, but the log
>    is there.
>
> Which is one reason[2] we'd delete them on branch deletion, because
> otherwise we'd start logging again when a branch is re-created, which
> possibly isn't what we wanted.
>
> 1. https://lore.kernel.org/git/de5e2b0e290791d0a4f58a893d8571b5fc8c4f1a.1=
646952843.git.avarab@gmail.com
> 2. I'm not saying this was intended, and haven't looked into this case,
>    just that's it it's an emergent effect of how these files are treated
>    now.

Very interesting, thx. Fwiw I would argue that resuming full logging
when a new branch appears with the same name (within the period of
time where the reflog is not empty yet) is a very reasonable thing to
end up doing, but I guess Han-Wen's note about potential path
conflicts on branches *after* a deletion make this a hard thing to
change, even if "accidental logging resuming" were accepted as a
sensible outcome here.
