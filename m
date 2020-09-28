Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F7C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F184B20773
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH9DUA6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI1Tm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1Tmz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:42:55 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9F9C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:42:55 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 185so2654378oie.11
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSqv8eHSsFc/jmll1K59EcxercoxCUlgGkdnUg7OiMA=;
        b=hH9DUA6nNaSjphnVQVU07p0ljsEv1nePePsOjAAqN5hQxOl5VMvpLMfEUW//QtCrU/
         RmB6C6pzchWpaBaV8OcOw9KttaYc6cs87LcLqw2+Fm3B26+01C/2CYhEf4+FHjo2lcoJ
         Sb8+JpjreRKLxzF2OKo6g2YfG0e6k1ojgl88k+3wMxeM8y/x/2cfMMG9cT25AEiqly3d
         +w3657elIw5AKH8TqTrJsdsRm7Lp8JBCVhjAKB6j9GKimo2NHSWpOQnPKAlSPRR0TFnu
         2Ysj0RLLYwk+mZiSIqczIHOnSVzg/zLHE0OFJA5KPOsH1yyat4xXZNdFOntMFolcLvEn
         Qj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSqv8eHSsFc/jmll1K59EcxercoxCUlgGkdnUg7OiMA=;
        b=qBOz0b+ErWT4YKptc4SU/WPDZ0jbL+b3h4sTUB1bDWPWEQW+VA6tKAgevx+Zseyj42
         YdrL5+4GS6r6ifi4nduLBnNh+jSmGYM8/Y4F6dg3+bkPQa3mqnuuCdroha9YXNRXjhIK
         nBEDhEhnupl8iH2zxbzcnHVsFQE2tfi2Jd1HIvShhj504HRGY+TiV0iyTTYAke6MKjCC
         4wfl021t6G8kYZlBV0BPs3U9w1V4BdPQWF4gNG34Kb2t05krTk9GD991xXuuaDcJ4D0A
         QeA+Bf4+/SmyhxJyK/313g8nvBjsJZSyMqs+UF9bm66jjEx3DqSac+JiPDQXqikaQoPq
         6qOw==
X-Gm-Message-State: AOAM533ZHMbkP4I4QAMWdR0Ztg9tGKkgmVLllpNMBXXOpj6W5/bQenQ7
        w3XpeKU74lzofig9UYzF+lDj9TJnejwPdEmrVpKZkTbsGSY=
X-Google-Smtp-Source: ABdhPJyL1/3z9itTfq/pg4jYW8gxuG3/KXKd1WYQeFRKB2kkV3guSqObKcrazb367hsx7Xi9eK8BKc3J1dVVPh97vng=
X-Received: by 2002:aca:d409:: with SMTP id l9mr302975oig.70.1601322174911;
 Mon, 28 Sep 2020 12:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABX4Un0NQV1wkx-AKTFs12agLiBLEe+Y_FDHgQwgxUT=wnFDmA@mail.gmail.com>
 <xmqqd025n3ik.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd025n3ik.fsf@gitster.c.googlers.com>
From:   Evan Grim <evangrim@gmail.com>
Date:   Mon, 28 Sep 2020 13:42:43 -0600
Message-ID: <CABX4Un3euDWeGr_2DegS3xyoD8VJ23rb9+bj3hBkWS6KZH9FhA@mail.gmail.com>
Subject: Re: git commit-tree does not honor commit.gpgSign config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for that context.  I came across this when I used
`git-subtree` and was surprised the commits it created weren't signed.
Would it be appropriate to look into patching `git-subtree` to honor
the configuration option?

On Mon, Sep 28, 2020 at 12:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Evan Grim <evangrim@gmail.com> writes:
>
> > Is it a bug that `git-commit-tree` doesn't honor the `commit.gpgSign`
> > configuration option?
>
> It would be a bug if it did, as a low level plumbing tool to build
> scripts around, it would not want its behaviour to be affected by
> end-user configuration (rather, scripts that are written using these
> plumbing command do want to handle end-user customization their own
> ways).
