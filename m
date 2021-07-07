Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47434C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 04:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD9861C7F
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 04:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhGGEkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 00:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGGEkX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 00:40:23 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C567C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 21:37:42 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id h9so1991224oih.4
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 21:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XvxSOEtC4L3bp834Xv3lpySHnIS9C/mj9hWrZ18X+dM=;
        b=RzxMn2hHqZmjGbuL29+C6PqFK/gsV1j9Q6xib93fzG337TNBRpDPG/mVWIXhBLjh99
         1Oc0ehL4KRotmLjqbEO03lH+AFCuC5uck/gGZAew8jusvHukZgkXZwEdeJgkt4E31NXV
         W7v5EvfVFH6/bioEdmc4FYNr1IiXouAazWtZlDPyuxiXWXmcHDBc1E4Wx543O0q7qOi9
         Fem72wem5FmPXX9Hkt4p1O+MaxWjmCbOWs6PYYXEx/sN0suitjLNwOM3epN/60M1jbey
         KKBqlhwY0spgd0cMNqdz4CZHVCjl+CWEozsID+KYyRZzEYT2PsEz4dXMqJL5ddH4QxAG
         0zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XvxSOEtC4L3bp834Xv3lpySHnIS9C/mj9hWrZ18X+dM=;
        b=YkDOjt++bsdRxlscV34+sRfz7LP+bClvrSQ85IkUoau7mpirznuYqdyAMbBpZBmicc
         A+3x5fian8dwVymVfTA1TAyb50x7+ciFgjOpmW9hZafysp0hkeykcECGt4MNP1C7jXNe
         r0tRacLEk8HDRlkvkeAY9GEeZMNx1hr4saXY0zOs52vV96IoUgPfypAiDyZqD/9N1cnn
         58QTbuaQWn82/6hK3Mc6diSM3eUHZgF6J9PgdM6NFHC2qMZdeFENNx5meAVt8UVGbjH6
         N5DnKNkX9I7ODkikkPcKhH8gnqO9BfXXX4Nb2DtXaRFxc0/VTKDUaOEO3NUJqADuM8sp
         3DjQ==
X-Gm-Message-State: AOAM531QoXRXeRv5kvYv45+ND9G2ufu5UU1Ug1IENoEr246gGijaVsuQ
        618td1/tOYnJCIkyqQI3m3Tc+25Emlc=
X-Google-Smtp-Source: ABdhPJz9bs4svjBjqnde2CaTSCGNSF7J+GVCmdYC/kpHHPH2UGIiJ4GpCFksW+FcFP3Xgq620CooaA==
X-Received: by 2002:aca:1b18:: with SMTP id b24mr3281452oib.65.1625632661946;
        Tue, 06 Jul 2021 21:37:41 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id w42sm2796232ott.67.2021.07.06.21.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:37:41 -0700 (PDT)
Date:   Tue, 06 Jul 2021 23:37:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Hu Jialun <hujialun@comp.nus.edu.sg>
Cc:     git@vger.kernel.org
Message-ID: <60e52f945507_2fe63d2088c@natae.notmuch>
In-Reply-To: <xmqqlf6jla5o.fsf@gitster.g>
References: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
 <xmqqlf6jla5o.fsf@gitster.g>
Subject: Re: [PATCH] commit: remove irrelavent prompt on
 `--allow-empty-message`
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Hu Jialun <hujialun@comp.nus.edu.sg> writes:
> 
> > Currently, COMMIT_EDITMSG contains "...and an empty message aborts the
> > commit", regardless of whether the --allow-empty-message option is
> > specified or not. This is deemed confusing and unintended.
> 
> I have to wonder what reason a user have to use that option, other
> than wanting to record a commit without any message.  In other words,
> wouldn't it be a bug for this command 
> 
>     $ git commit --allow-empty-message
> 
> to open an editor to allow editing the message, instead of just
> committing with an empty message?

To translate this question into more programmatical terms.

Should this commit an empty message?

  % git commit --allow-empty-message -m "$msg"

I say the answer is no.

We need to know what the message is.

-- 
Felipe Contreras
