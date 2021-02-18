Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D27C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52F464E92
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhBRMYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhBRKQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 05:16:27 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80704C06178A
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:15:45 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id q4so1367516otm.9
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hR/E1kGyqGUcNMHGctYrL+yvQuZMpZi1zBduQ3SIme8=;
        b=Ss9YZQ08YrPKoCG42jfwwuTNjB8vyhEBQapD1MOzfVdkcPbd2Y5IyP54KEn7a2Uheo
         Ejjh7ZOR5sExjkwwl+ENWzBJ5xHAo7HwM7mDVWMSdUvuDv4mpdsQ3EoDoUEatOYOzs31
         jLSIwBTQq125rpxxzpQFupoJnSBvSAiVZZ779WOwa/4KEI/+gBEwZdcSejW5OYKtbwL0
         jJMH63j2I2hpbucZqeEDt11u4gycYW3qQa8SsQ28yhI43l+ySGbaAdm7D/KCOBHTHndZ
         LUSJRZ6Qwq6CyWBuq0QIvsiZverXBFIRzxsFN0X1rWRDp4W4cOeIBj/slTQmKp5JBL8n
         Sbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hR/E1kGyqGUcNMHGctYrL+yvQuZMpZi1zBduQ3SIme8=;
        b=sUFgr9+61PP698rs8Ei0kBvXLjSIqjQIvBINTedc5oIiSt1LAYG5tLsK855RTa+Kb6
         Yb+NN6hsPXqd2PKKK0qtamea33et43MEgnhrIv5VIEBvJekFIWKSxblRAwXu9pbTrLB/
         AHVh801zH5KFtPi85kNw0W9zA5AYNW0pTh45a8Jnd3iRG+lBeYUm9n1khlDCddC5e6j4
         AVkyim5t4I/WheYcmSXSEesKp1CtJasXc4TZnv1XthINftG0z7xnAtPn/ftAJcjYxs4i
         BlCyyt8nImSzaZlQguaxmDmAfcGUDo6EwaZLpCDVAEfFcXxZ/OJrwdy0l1SCwkEDQ/7Y
         4ldg==
X-Gm-Message-State: AOAM530HpKGzxkdOJs5Rwv9DUMLgkX8X7bykQ8Q2rkXzxUi+ZnCcaupb
        T5/YHiIaGWy0IGghh5RnlUfOjLrGPWUoMsxTbxY=
X-Google-Smtp-Source: ABdhPJwkA8fdZJBK7+x9kNX4DhOpc79F5OE+6haBSmxTfwQ5hIi3cOavKm/OmhDIHw1QGNd7FT4+8Z0SHlgi6Gi6A2Q=
X-Received: by 2002:a05:6830:1481:: with SMTP id s1mr994182otq.184.1613643344977;
 Thu, 18 Feb 2021 02:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-4-charvi077@gmail.com> <xmqqsg5ujwi2.fsf@gitster.g>
In-Reply-To: <xmqqsg5ujwi2.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 18 Feb 2021 15:45:34 +0530
Message-ID: <CAPSFM5cjJ_b510wx+RtVkyxHk-aFDpOHaFRWqQuMuDf=73nBiA@mail.gmail.com>
Subject: Re: [PATCH 4/6] t7500: add tests for --fixup[amend|reword] options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Feb 2021 at 01:29, Junio C Hamano <gitster@pobox.com> wrote:
>
[...]
> > +for opt in --all --include --only
> > +do
> > +     test_fixup_reword_opt $opt
> > +done
>
> As I suspected earlier, a pathspec is not tested here, but it should
> be.
>

Okay, I will add it here.

> > +test_expect_success '--fixup=reword: -F give error message' '
> > +     echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
> > +     test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
> > +     test_cmp expect actual
> > +'
>
> Why?  If you can use -m msg, you should be able to use -F msgfile,
> too, no?

Earlier I was thinking to let the `--fixup=amend:`  use the same options as of
current `--fixup=` . But yes I agree that there should be  -F option
also with `amend`
and `reword`.

Thanks for the corrections, will do all the changes and update in the
next revision.

Thanks and Regards,
Charvi
