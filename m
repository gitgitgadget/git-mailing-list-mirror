Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60300C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150556109F
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhEMVSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 17:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhEMVSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 17:18:35 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA53C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 14:17:25 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g38so36400502ybi.12
        for <git@vger.kernel.org>; Thu, 13 May 2021 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jqkUdR3hMbB6EZxRVZqXTq+x0QVNoGWBL7ZfMgLqmj4=;
        b=nL2YNMtWes3zEES0Oy0oRz19sJ8uq7HyIIUopjAH06UXycUadO2xus7Xv1VOVSsEF/
         Dfq+w71xl+bJjEjBUSPcKUesLvZeinP5Irya4nqWjFfXWKoE6L3WBnKKcXbRAhNvPkMT
         fjc4fMy7KrMU+sgY0PBBOo5TABndFukGuxB+YpohWAx5BUIyZ43Wb5ACaNuDYmXfUM1t
         ZIad5+CcDbQjlV9J6KEqwfLWL4GeB8uHpTDILZ+jI58j4BMvKy3Npcsh9t5BlatmBhcB
         gKrKJlRfmFjNst1ysfXfeBqKmgb1a2rFlTAFBc7WZik1eQ84cMKG+eDzOdKcQxGWixm+
         QbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jqkUdR3hMbB6EZxRVZqXTq+x0QVNoGWBL7ZfMgLqmj4=;
        b=f+3jyZS33wki8OYpAe6KxssrAjw458Lq3VKT90wNk0KrGiIfCtm7S3MAFQh3+3wFpj
         HbUwP1zdc/ykWM8lQ9+6wqN6HzAMLKqsdTTm6Kv4oX0sGOkr+FyveWQi2N55CEjOA/fB
         xe+EYHLKEtzUyQUUqfGYhxmUMMZPvmZlfWARpGEHucyMPZhbTwYePrHLuWvPBAZ0/Sq4
         3bSBKP5vTvLZ2q1Gilf9+rGdX+N2JV20BdypojFEXKruikSl5/lK5EEjihdCGLZB9r7n
         UVHhgsbpGDq/KRPrtggKfqj9ZQ2a22X6UOY9ouWtcT3mmiWCLX5JygA20xgmIKZeNqbd
         FSWg==
X-Gm-Message-State: AOAM532ojjhT1Nj8j7GMTgSFAiy+HSbeoc12I++EuU3/D99IATGFcE7t
        4UtvD7T6FcwM3I/fCfRNd8h3UlB0VXoPczBgSg==
X-Google-Smtp-Source: ABdhPJwM1AzOdQvNzhSBc3JW9DlgvHjLepgJcGB8uNO98d2r/dilzA1+5smBj5JlnLmgafAMdCNWCzYoTL799LSISAs=
X-Received: by 2002:a25:11c5:: with SMTP id 188mr56464543ybr.322.1620940644585;
 Thu, 13 May 2021 14:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKToE5BnzXd_2pjhJY13E=e6b1ZgOV=NmXr_WfpCQd+LxXsO3A@mail.gmail.com>
 <81d06db6-fd91-7ec5-6aa5-84f69a227204@kdbg.org> <CAKToE5DgtW1Kuw4AE5+Am_=9gATN-S=xk1kYXMZUWvtdtNy_PQ@mail.gmail.com>
 <CAKToE5DEL1ZFwUbvcC-M3y-3mSVsVgMXDig4G=jcKbc-nJ_GnQ@mail.gmail.com>
 <68a4ebd3-3c80-8983-9a26-f205debc4b5b@kdbg.org> <xmqqeeeabdml.fsf@gitster.g> <dbf1e10c-c43c-3293-61b7-eff5fceecb84@kdbg.org>
In-Reply-To: <dbf1e10c-c43c-3293-61b7-eff5fceecb84@kdbg.org>
From:   Alexandre Remy <alexandre.remy.contact@gmail.com>
Date:   Thu, 13 May 2021 23:17:13 +0200
Message-ID: <CAKToE5B7xsNiXV2U4gRJeqEke9Y3gPpFfBwAtBPrvBx4jAx3VQ@mail.gmail.com>
Subject: Re: Git pathspecs difference in behavior between linux (wsl) and windows
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yep, I know, no problem. The primary subject is closed. thank you.

Le jeu. 13 mai 2021 =C3=A0 23:03, Johannes Sixt <j6t@kdbg.org> a =C3=A9crit=
 :
>
> Am 13.05.21 um 22:08 schrieb Junio C Hamano:
> > Johannes Sixt <j6t@kdbg.org> writes:
> >
> >> Am 13.05.21 um 11:31 schrieb Alexandre Remy:
> >>> I have an additional question, does double-quotes be safely used in
> >>> both windows (that's ok) and linux shell  for pathspecs (git status -=
-
> >>> "src/test.js") in case of spaces in the path?
> >>
> >> They can be used in both POSIX shell and Windows CMD and, I would
> >> assume, also in the PowerShell. Note though, that there are subtle
> >> differences when other special characters occur between double-quotes,
> >> notably the backslash. Please use your favorite search engine to learn=
 more.
> >
> > And a dollar sign, in addition to the backslash?
>
> Granted, there's not a subtle, but a big difference how the dollar sign
> is treated ;) but I don't want to write a tutorial here. Hence, my hint
> towards a search engine.
>
> -- Hannes
