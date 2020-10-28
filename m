Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B54C4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6BC208FE
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARZ+uJEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbgJ1Wlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388986AbgJ1Wiq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:38:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C6C0613D1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:38:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 13so755614wmf.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVtHiJciHGtgOi8YDqV5woZg2lL03DD9QtKZpIc1pZA=;
        b=ARZ+uJEZTTh7ARXgNENGGO+L5hddbUMDy2W9ioRmCPgjkks+obN2BuqOSL8yVDfPZu
         MynPY1LZhKk1TXOw9uOWvFeoLD6xve0X7QSKGhSJdb7tKTxA4E4tv1SKZqlsBmuf9xKs
         ZDk+r2i/gyGJ6M8DuqxKMDK9dVVSH7wpA/YB3gMBqSF/pKC5fqucKYP/AjvrkErVwc7s
         5RAyCIRv4BhpRM7F3OWi1MDYRnhoeMcxeRhln88txXsqDLuBJPH/rL1vpBbhKkd7u085
         IeT19seZXPTbVLsGUNngc5g76ReDwPiDwUgSQbmjN3+C8RgLwS34FIp6HNwHh3eobcoh
         w5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVtHiJciHGtgOi8YDqV5woZg2lL03DD9QtKZpIc1pZA=;
        b=f/QJgM1M2HuqAQR5wCe00rjp1PbtuB1Yg4jaNUyJuOgu845bM6fBACBj/G2Ju8Fl/I
         h8pJkOGKuNLUzAYepxW+I4K1eQirLDnfwoXEadEqaG5xR9w9YShH1d7QrRqlEk18kdQB
         aAPTl7tCxe8lD8E/ai45FjTPeUPTDsm4TZO2wqUAnbmWFzLNEONERNB2gWByxJhPA7sc
         fUAM5+OMx8FpTlHCCrOlSMKZI3RDVvk8xjyDiEq/NvdVNiD0VfJd8iCMZhnaZFSx16fo
         a8Ru15y3P2gwv9+pwJkUokqYLIsmjFJi3Pt1HiIcs9QBRZSQRDLNPcvSIlE29bn4F7GG
         62dg==
X-Gm-Message-State: AOAM533awwR03XEXzBsL9Mf0UoKCSGPCrH+Mwoy/u7N+Xt4uwW53fEe9
        /PTTmNgBQg+LNrTDQeCcwPoiZbnqH/wXyyTBEn2N1fhLl8U=
X-Google-Smtp-Source: ABdhPJwnB4l5t5chZkDnvTrTivNARZ2NepX9k1mGKlWgbFXVho246kdZAFwSHur6btqL3qP5RaG70xNrpvVRlKH5NKE=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr5207632wmk.37.1603849718043;
 Tue, 27 Oct 2020 18:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201025031343.346913-1-felipe.contreras@gmail.com> <xmqqo8knbf4t.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8knbf4t.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 27 Oct 2020 19:48:27 -0600
Message-ID: <CAMP44s3HM5gqZhK8+266jgW1hO1SpoE4+1K-SmCErb7G9YhcBQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] completion: zsh: latest patches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 2:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > I've been carrying around these patches for quite some time, many have already
> > been sent, others I refactored to make them more clear.
> >
> > But what is clear is that they are needed. I see a lot of people in different
> > forums (e.g. Stack Overflow, Oh-My-Zsh, etc.) getting bit by many of these
> > issues.
>
> Is this "v2" an update to the 14-patch series you have a late reply to?
>
> There is a tiny zsh completion patch in flight, but hopefully it can
> be rebased on this series and graduate together, provided if zsh
> users on the list find the topic as a whole agreeable.

Yes. That v1 should be dropped, this v2 supersedes that, but I'll send
v3 in a moment.

-- 
Felipe Contreras
