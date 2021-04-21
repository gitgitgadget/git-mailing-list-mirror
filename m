Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C5C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFBB61449
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhDUKUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbhDUKTz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:19:55 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B669C06138A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:19:21 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id v23so12941390uaq.13
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f6xbiIvb8nTQFsom2htBUCFCOso2eP+uimhYIy7jWZA=;
        b=PZNgFEMDlGUd4JVpASmGSYCUX6mclqrtqwTkDgeUt0aLHTYEx+e6S1zWYTyFIfbvaZ
         MxnXRpJuCh4B6OWiIbiOxaCUa2Lor4nB86dvNOQ3qIr4bmKEJEr8yxpqthqyur/3Gek0
         2w1Wm/FOOZSmZPHh2kqX66xlkBx1G+JU8I0puIt8YkaNSPJLIEd7auSeWmN6J2c7edL6
         z1UunyhbWs7VBytn9RQrpBPaNU8my7b4qsxYsVtd+Yweip4z0u9qVCs+DIim7kJySgMP
         e9QSU1/ZEHDyZDOI3l6P4Du6olcfIg5GpQ7WeFsBSrPxUBr9ou5M6Buak2GyxWMxdbBw
         cK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f6xbiIvb8nTQFsom2htBUCFCOso2eP+uimhYIy7jWZA=;
        b=b4gNLK0iwMfJy5T64/yuSZfxy2wgtYxKl2O8BmqVxr7I5HUlufk2cO6Qj1+gJSIaM7
         hKZaTH2KIeT/SmiCHwkAkZkjbck7cxfyfXeuiHyNP1m8Cyf0NHSm68KaCx8YJKW0G2Bw
         UXwzkkCQuuH/IKjYpd5x+y6h8JF1HZH0Al0uLzFCYYv40n2ELEF5P4bk7CP3tWIVmM4C
         xHtf4gzAHAaJ28iE+bEp75N0f6h7jmBdW1msEJyQbEBQ5aaxPDFgjaPd12cigAgF5vl2
         likmXv/y9JM2pbacSuEp9MmMkl3kEtAn8rv/H/wUy0NSbxoFMnSmLl+muW4opJ9D77DG
         V/rQ==
X-Gm-Message-State: AOAM5329WW+vsYA9RqpxjImuOmVp3ltxuQG9xugBZ/ea7+AYr6Gy1eki
        9pxyngtIY+K77eipVlVyo4C94N9wiT6q7XNPMtp0tg==
X-Google-Smtp-Source: ABdhPJzhrxsbyASf0/RNol4l2vtFRKikpJ53caDqv82fZwRoGZNvPtuMH28rH9Ec/u9AboY1ax9oZhxbof79y9m5UHs=
X-Received: by 2002:ab0:6030:: with SMTP id n16mr16632137ual.87.1619000360383;
 Wed, 21 Apr 2021 03:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <2fd7cb8c0983501e2af2f195aec81d7c17fb80e1.1618832277.git.gitgitgadget@gmail.com>
 <xmqqk0ow37as.fsf@gitster.g>
In-Reply-To: <xmqqk0ow37as.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 21 Apr 2021 12:19:09 +0200
Message-ID: <CAFQ2z_Nm4Mixhi0kXTdN+nVj412_WPe=k9v6FpJFyaOx9qMRUA@mail.gmail.com>
Subject: Re: [PATCH v7 23/28] Reftable support for git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 12:44 AM Junio C Hamano <gitster@pobox.com> wrote:
> > +if test -n "$GIT_TEST_REFTABLE"
> > +then
> > +  test_set_prereq REFTABLE
> > +fi
>
> How would this interact with what the test prep series did which was
> to unconditionally add
>
> test_seq_prereq REFFILES
>
> around the same place?  Should $GIT_TEST_REFTABLE disable REFFILES?
> IOW, do you want the above to read
>
>         if test -n "$GIT_TEST_REFTABLE"
>         then
>                 test_set_prereq REFTABLE
>         else
>                 test_set_prereq REFFILES
>         fi
>
> when both series are in effect?

Yes, but on 2nd thought it's probably better to stick with just
REFFILES, and rewrite any reftable specific tests as !REFFILES.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
