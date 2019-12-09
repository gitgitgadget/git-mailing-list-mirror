Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA39CC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 10:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881872073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 10:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owzTtfb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfLIKgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:36:55 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:32965 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfLIKgy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 05:36:54 -0500
Received: by mail-io1-f67.google.com with SMTP id 2so11332867ion.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Ip+1IJYUyOhZt76vVeQoO59hCfE1iMpVGQy2F/yOoA=;
        b=owzTtfb1PMsofJni41F+AnWeQQNS+Rybyj1uDose4igacetyFSR4ZyhhdTHQYSLp75
         sq3RLiE7KLQ4PlQjqh3CswWUpfmK4JEoMvA2luscIcgAQwpUdiogHSK3umNqMt5xHVga
         KPun73woL9dD5qLvYIsa8A2tWz18qAqc2KJvCXQasqNLfQqBmgPLLIzrJK3Qfv5CclpT
         XTezgzE+5N4Yw9p7f3IjBWxcPY58Jw9DvrX916EPUlDzgWu624LhKXedwDMb9aE5hLgj
         obQsWk4XdNytlo7V7HLbQByeL30/ITg7Oj23kfV/69Tw1teJx20AZokBOAWKFvbNNUdB
         KCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Ip+1IJYUyOhZt76vVeQoO59hCfE1iMpVGQy2F/yOoA=;
        b=eRdjo9JNAFwBuSwXp8FAZ5Nq9zVJeAmEULrMFeRLctnYGGmATGU3sQ9T5e7vjxyuY0
         kaQLNBqD7s7SPas9OiHAfIQrtoHbxrIoT4jucPUIG6YooeJhmummS4+kIDrNxZnjeUxd
         g/Nfv4yr+QsCfhZ++gdB4J21h9TAqRax/Y9t1tItDQcrkddqoLAy6s1kK3KNaL1kGXjG
         kwHzuu109sRzgU1x2LPuN2VVTE9UfSvbZhA3A7WKd22j3Ge/lMrPaAvRrUA5F2n7fQKp
         tdJFQ1ck9Og91CLxL3sJvQox3xzEITo3iBauLO+cG6rXdTWWS4kI4w9LWORd6tKQNXhM
         ZO1g==
X-Gm-Message-State: APjAAAXDXDWbfmrJ4uprelKoZf3BoxKuI70t8iYCaby8gF4ATD/dyMQv
        n7q6M8krPqmPDsxZwtKJCPp21dk4SdrnTqZUf54=
X-Google-Smtp-Source: APXvYqyulIzTMrdP1Cvu9NH1E6QU420bwVG7MQpLRIK5bCgNmS6/NV3GdZF1e5MIKuvKSK1RrXDQSZx35wvKQ7Dw9Pc=
X-Received: by 2002:a5d:8744:: with SMTP id k4mr21551777iol.227.1575887814068;
 Mon, 09 Dec 2019 02:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20191209084022.18650-1-mirucam@gmail.com> <CAP8UFD2C0uh+e_tH2H=z2RqDwSC7SEu-JoBx3z2KefVND8OqYQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2C0uh+e_tH2H=z2RqDwSC7SEu-JoBx3z2KefVND8OqYQ@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Mon, 9 Dec 2019 11:36:43 +0100
Message-ID: <CAN7CjDCU=BPA3n6aDEPEzV8VK=JtYFn5_3CbqYrc5Zpg79m5jw@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH] bisect--helper: avoid free-after-use
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El lun., 9 dic. 2019 a las 11:22, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> Hi Miriam,
>
> As Dscho suggests, next time please use [PATCH v2] or [PATCH v3]
> instead of [PATCH] if the patch has already been sent, even if the
> subject has changed.
>
Ok! I take note.

> On Mon, Dec 9, 2019 at 9:40 AM Miriam Rubio <mirucam@gmail.com> wrote:
> >
> > From: Tanushree Tumane <tanushreetumane@gmail.com>
> >
> > In 5e82c3dd22a (bisect--helper: `bisect_reset` shell function in C,
> > 2019-01-02), the `git bisect reset` subcommand was ported to C. When th=
e
> > call to `git checkout` failed, an error message was reported to the
> > user.
> >
> > However, this error message used the `strbuf` that had just been
> > released already. Let's switch that around: first use it, then release
> > it.
>
> Great!
>
> I think keeping Tanushree as the author and changing the commit
> message and the subject was the right thing to do.
>
> > Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
>
> Here (after the line starting with "---") you can add comments about
> the patch. One useful comment here would be to say that this patch is
> a new version of
> https://public-inbox.org/git/20191208172813.16518-1-mirucam@gmail.com/
> which itself has been sent previously by Tanushree
> (https://public-inbox.org/git/64117cde718f0d56ebfa4c30f4d8fe2155f5cf65.15=
51003074.git.gitgitgadget@gmail.com/).
>
Ok, I'll resend another one (v2) adding this comments. :)
Thank you.

> Thanks,
> Christian.
