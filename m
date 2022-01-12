Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F6C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 20:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbiALUG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 15:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357519AbiALUGv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 15:06:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE9EC061751
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 12:06:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so14435764edj.7
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YRbRa88uAyxenbjAcXDo7/3Ex94muwkA9ss4Wl5EAzk=;
        b=LTBqIz7nGMfctKhU1XhAE7KRvXt25P47486WOLq2gVh+/aLRM5PN4pFf5cb03PU2lf
         aXK96os3j7voJJk9f6rvdUULENCh9MOuDtV8/954LTfVGWJxVSq3uOON2Icv4XQe64+k
         1L84/mbw7d20QzcvyrUV4wd3KtBIJHz4ARZ45uRAIP8Jjmqs6sbGTiLEcCyrOgi0cZKY
         DXLN3SrOtfgf/Agy9Q7Ni2KdGpQCTAPpVA+E1alIrOeirJtNkY1pcNm4Jq32q1F7Hx2M
         3SIAXHOLeL8yx6pmAphFqGrY+pDGZMA/5FMJ+JdFNtz8M0Fzl9rvgXF/kQJd55KTw1v9
         25FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YRbRa88uAyxenbjAcXDo7/3Ex94muwkA9ss4Wl5EAzk=;
        b=K+RrbUUVRf+LI72jS0i+aoswHxMJlFL5/NEn0a/NI6GzqIl1Qaa2MuC+4SC4tU6Ry0
         exsc7lWchZiSrpVwl6adOAnT01sFatyC1bRX0yvsIjuj8MHIxqMjmf8mxmF3f2GRD5/4
         qGCEThNJvZ0aXZLCPiyBNBMnPXI/+rSnmv6wDHW4SVhLLNCuLgL30FNUnfX/kSKk+vGJ
         sbVBbTp7IVc2NXrnV++f6MHDbuSnI89MdQWzFGzXcN8W+4SNmkrwALZuJoclV5gWvBe3
         fkEtDXuZurb4oX92d8/QLs5ytZpHGDWuK0Qvy4QzdR0k2J89mPIpip2NXE3ycloH1XK8
         AZ0A==
X-Gm-Message-State: AOAM532iYI+bluWOpecWbrCs/Yvz/kyBRlsHPaonOhlb/pmwyruT7+mo
        03GAp2Ii4vbYsxAmPbtIuXgf7QFlzEYq+RsaJio=
X-Google-Smtp-Source: ABdhPJw42RbEI+ITqA15wgCoDM8k8yZUCuciMFNxvKBpFNS37xCa9i8RKSS6/a2JWH8N1ChWrJEv+Z7ahzkZUEiarjc=
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr1034021ejc.493.1642018009520;
 Wed, 12 Jan 2022 12:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
 <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> <xmqq8rvn1nkw.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet> <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com>
 <CABPp-BFei07srZBgyKs6HCm+G+hmPR-3_EkKjRK8WwGL1Uf2oA@mail.gmail.com> <xmqqk0f4x20a.fsf@gitster.g>
In-Reply-To: <xmqqk0f4x20a.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 Jan 2022 12:06:38 -0800
Message-ID: <CABPp-BHQdkhAEmTrtc+XMgj5A5ASBVRw0_bXH10NSrMsyRK+oA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 10:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
...
> I however suspect that =C3=86var didn't mean by "legacy merge plumbing
> built-in" the strategy backends.  IOW, I had an impression that what
> is on the chopping block is merge-tree and not merge-recursive.
>
> But since you brought up deprecation of recursive, let's spend a few
> minutes on the topic.

Not sure it matters, but for reference, =C3=86var explicitly brought up
merge-recursive.c.  The fuller quote was:

> >> I.e. is it really costing us
> >> to just leave these "legacy merge" plumbing built-ins and
> >> merge-recursive.c etc. in place?

Because he brought it up, I decided to address it.  It was unclear to
me whether he meant builtin/merge-recursive.c or the toplevel
merge-recursive.c, so I just addressed both.

> I suspect that we may be able to just invoke ort when recursive is
> invoked, and such a wrapping may even be easier than wrapping "git
> blame" to replace "git annotate" (where a command line option or two
> needs to change behaviour).

Yes, that was the plan I had.

> I doubt there is -X<strategy-option>
> that affects recursive that ORT does not understand,

Technically there are currently two.  As documented in
merge-strategies.txt, ORT takes the same -X options as recursive, but
currently ignores both -Xdiff-algorithm (instead passing
HISTOGRAM_DIFF down to ll_merge()), and -Xno-renames (instead passing
DIFF_DETECT_RENAME down to diffcore_rename_extended()).  I guess there
are three if you count -Xpatience separately from
-Xdiff-algorithm=3Dpatience.

> so it may be quite simple to deprecate "merge -s recursive".

Yes...but why deprecate?  I thought the plan was to (eventually) make
requests for either `recursive` or `ort` be handled by running the
`ort` backend.  Making that kind of switch is much smaller than the
one we already made to switch the default backend from `recursive` to
`ort`, so I'm not sure I see what we gain by doing such a switch in
stages.  Maybe I'm missing something?
