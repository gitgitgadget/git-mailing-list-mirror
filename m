Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FAECDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 10:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbjJLKo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbjJLKoz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 06:44:55 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B8CCA
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 03:44:54 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4c594c0eeso524249a34.0
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697107494; x=1697712294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPuHkPcgVlwYK0ALaxIWwIAEGbm8g6liEkHPHPDfL4g=;
        b=Ek4MAQ3J1mUMH4LRvruVUZ/poVbzPPMi9vjOfTmTxUX18SuI9gSrJMyesKS97K82h2
         NXbCV9txVHmCesKSrHdn6pQkx7J86/j04iHw8wUO03g7Ooz62AnLr/+V8FLYspX8PIKq
         QtJSjApDTb/M0SuZbrw9JumnOI8fl7/sFexeSbWJ5PxzyIPytviNeW6Le/9xjOEj8Hxo
         yc44GTIHOXguPOoudXS/+q4QuU5Dfb9VBpg/fxUPGi+0XOmQgAnz5YSZncSU2sgywycG
         hSiTZ+YkgVz3nGX0SolTnYizYXo/T1HcWk8qJSFlxDJUFNKElnNMtRP0PL08jaC5NzHS
         wBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697107494; x=1697712294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPuHkPcgVlwYK0ALaxIWwIAEGbm8g6liEkHPHPDfL4g=;
        b=ipAwpmJDus+xOzKudvCl5w58N5RSg9XFixdHnJ4R2qZrw9WVOToGB0XrKThL6sPMUG
         /n4CJGiY6h3EH0SdaWXlCkoxxdP4+PsuB6NM6jL8Kq1bbQXGCsI6CSymv1eOsX4SBh55
         VsbfYXFScDh7TID2Yj4jrE8uQIoNvLWiZjaU5N94JH0qIsK1a97nNQ5sfzFPs5FzUThr
         jlh7t7NMHcl5Qh1085zZSqEvD7L9OCsrhC2atTDpfvADtGNZ/NcqsyTWqwMzsCbUU4yo
         xhgtfC1/iOHzrVRI3AK0+ReDUzPhu2WejRxBY6uBpl6E9nPsP7ZnekmIekJy2A3InALC
         FcuQ==
X-Gm-Message-State: AOJu0YwzmQN3pUgtbO2/u4sqRGNNKx3xdefcP8uos2PXBHX+W0q4WwI2
        vtci86P4of8SWDE2SOw2QUIDpPNk/G2LaHAt3pE=
X-Google-Smtp-Source: AGHT+IHLwmRe1k+bH2IB+j5Vllqmfkr5+IwV3d3sLJlEAtEkeiz1VfuDr4syol/+MnXTuQp4KRy5+4qlNnA9GMKX6F0=
X-Received: by 2002:a05:6871:6001:b0:1e9:8182:a2a6 with SMTP id
 qx1-20020a056871600100b001e98182a2a6mr6093671oab.28.1697107493667; Thu, 12
 Oct 2023 03:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231009105528.17777-1-karthik.188@gmail.com> <ZSTs3BUVtaI9QIoA@tanuki>
 <xmqqil7etndo.fsf@gitster.g> <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
 <xmqqbkd5nlq0.fsf@gitster.g>
In-Reply-To: <xmqqbkd5nlq0.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 12 Oct 2023 12:44:27 +0200
Message-ID: <CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 6:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > Seems like this is because of commit-graph being enabled, I think
> > the best thing to do here would be to disable the commit graph of
> > these tests.
>
> If the CI uncovered that the new code is broken and does not work
> with commit-graph, wouldn't the above a totally wrong approach to
> correct it?  If the updated logic cannot work correctly when
> commit-graph covers the history you intentionally break, shouldn't
> the code, when the feature that is incompatible with commit-graph is
> triggered, disable the commit-graph?  I am assuming that the new
> feature is meant to be used to recover from a corrupt repository,
> and if it does not work well when commit-graph knows (now stale
> after repository corruption) more about the objects that are corrupt
> in the object store, we do want to disable commit-graph.  After all,
> commit-graph is a secondary information that is supposed to be
> recoverable from the primary data that is what is in the object
> store.  Disabling commit-graph in the test means you are telling the
> end-users "do not use commit-graph if you want to use this feature",
> which sounds like a wrong thing to do.

I agree with what you're saying. Disabling writing the commit-graph for
only the test doesn't serve the real usage. To ensure that the feature shou=
ld
work with corrupt repositories with stale commit-graph, I'm thinking of
disabling the commit-graph whenever the `--missing` option is used. The
commit graph already provides an API for this, so it should be simple to do=
.

Thanks!
