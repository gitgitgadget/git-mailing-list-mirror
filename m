Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393F1C2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D149121527
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdkXN6as"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgKYAnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgKYAnl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 19:43:41 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45891C0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:43:41 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so610217wmb.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geITQjwO8AL5uBbjgYPiBG2hpxSv2jJx0ujrWGI53HA=;
        b=CdkXN6as1rp5cs1nJh0pQNxqXMAIufAQMCI2l3PsQcVqZheg9TQ8vYxvBuMCQbMKS7
         3dHJm5glrw/05py7YYSSZE9f34R1PtLZVJ7skkJZpBwQaw7wbQB1mwhLgwY6O8FtFAj9
         KV8ce1nN75eXWwb/36+JX3gRYedFMBX8bhBdigj9/ZQoQHhHYuN2cmd/p9Dxp98sszKz
         rYXH5p+CV9BuOSNs9RGNL014VGtsXlZwT62v+j/MhzPIj37LpGMKOQYJUYhPFbEfJzro
         EbjeWUe/zgtdHNIIgJoHrAjPQzX/39z+/FVgWiPIKUvRzqNDAC440UrgwCzheq6vDDsW
         fq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geITQjwO8AL5uBbjgYPiBG2hpxSv2jJx0ujrWGI53HA=;
        b=EuNH8t7Qgbf2tBhyY79RNTmgsS9xssqmRPwfmaGo/FFOcA6wWL1LIB9g/0JZDsYUgY
         WRKI/AyHoKpTiIBHDcDDNx5th5J02rA3CoIDmhasA4Ommso5tYh+u4DFwE9MeNXRKiK2
         2nNScdv9vhKNwJcFC6UOGf7ne9tdXDvm/zEzwya+auxdaRyh30snU6BrfIIuiJfCJS7y
         3oYReB5bjnCL1i7hifE5+bqvRhBhTFXifDd9Fyl+ME7h0O3Se1NHuwCVThdTncusbo2T
         idfJWjDD/H3Ye+S1IRfIY+GwIZfafY9CwdtV7W89wLyZtunyXgZcgtRc2d79ZGx52qPt
         7AiQ==
X-Gm-Message-State: AOAM531oopTiI3eyGlQQLPibaHS8ELA/SZOz/Z1yJXui8xD3djDhv8ix
        ARSR/sq45nv/lHei5YxjxkjXy3XqQBPjrbh/C/4=
X-Google-Smtp-Source: ABdhPJy6vaRV6v8E6ga/wJBaaiL8MWNK3Yx8/lbQmlKYMdFSuS8fWdRRzDtAuAnrLTUP6U2EbiYana2K2dGA7mVSoFc=
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr958447wmj.37.1606265019922;
 Tue, 24 Nov 2020 16:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20201125001102.111025-1-felipe.contreras@gmail.com> <xmqqblfmgtlg.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblfmgtlg.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 24 Nov 2020 18:43:29 -0600
Message-ID: <CAMP44s2ChcCjhjksS0s5BoYznqLAoXyFvSkP4GxSCh_ALusOtQ@mail.gmail.com>
Subject: Re: [PATCH v2] refspec: make @ a synonym of HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 6:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > +test_expect_success 'push with @' '
> > +
> > +     mk_test testrepo heads/master &&
> > +     git checkout master &&
> > +     git push testrepo @ &&
> > +     check_push_result testrepo $the_commit heads/master
> > +
> > +'
>
> This is OK, but shouldn't this be placed before the tests with
> various configuration?  Something along the lines of the attached,
> but with the body of the loop properly reindented, would also give
> us a better test coverage at the same time.

I don't see much value in those tests, since I don't see how if one
passes another one would fail. But I guess it cannot hurt.

-- 
Felipe Contreras
