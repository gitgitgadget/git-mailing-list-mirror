Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB3DC35DEB
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67310218AC
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOHyoecG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBXXv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:51:26 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46443 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBXXv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 18:51:26 -0500
Received: by mail-ed1-f68.google.com with SMTP id p14so14011535edy.13
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 15:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjOBApPraqXX+BerGtlcbAC1j+nYc0MW34y2NPRG8/Y=;
        b=lOHyoecGMte3roUMsEvZlR7l5joiUT9XxH+77BfWTDpQtvmAkPqq2N67moSi7QCECE
         UyUeinP4MCVbKuEOxNm/i9e/1tbJpxq/+oo/2UtUu5EUl63+Rw9H1sBu8BLm/u2NjfTu
         YIvFfQgJUIZOuLLXmvD7wE2on2JwNYwceYc46L9zLZnYl2W4rmzmZFI+yxuQNQeZrcsf
         /qzMUIXpfI3tyOK/epe636qe2tFGnA83OBbXgzkIM4PqCkYXlgw4MosQRw1BuYeZo9dJ
         FTuw5NtBa0M6m/7BMLA2z/yCx/R1L2zoxpKNS78qJrmM8/vmPwIJUMiSr/GhlT7eEtzs
         n9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjOBApPraqXX+BerGtlcbAC1j+nYc0MW34y2NPRG8/Y=;
        b=JZ1DXbepWcmE0OKcRKpJVykd5AJxJ+8dOHWgyLWcJsTMrzf/FsqQVhXCBAh2qmIDY8
         JvgAA6kJe9EzAyjNYYhSFp7rVfv8G6BvPbg6SoS3+umt/YmJByLMzon2dLMB2p+qtXI7
         BLB+JR3RSP+p7qsVLbHscKte0umptpctCOYSPbVEu3RiXtcbV3Lg74SABC/mIRxVWhQU
         FAEC0/H6DwE6e7dZxs2hqx39ncNFBmbJP22Ve4+6V8QTdojXF3Fq5UXsf9GFP6s4Ev0v
         /aX0+YAHihIqOo8xLWxJhcj+9psdQK+DRFsEM5zxB1VU3J/ZgzFp+nsKyf/4jYTjuyiE
         OTTQ==
X-Gm-Message-State: APjAAAX9sFRm8ugP3AHtIiapk2MKYNMpLo1Thk0ZiYoycvoWETMoX72k
        sBuOL8KcS2IeigffJroqCxmVgH+sEaiT2e/Th/I=
X-Google-Smtp-Source: APXvYqzkJNmLAa/ERfZcUS333jjKNfA067iv8vUGyPVKDkyske2KblnaGtXJFKD7fXn6DYsmXz/igpWoqAwEWBYm0VY=
X-Received: by 2002:a50:8f66:: with SMTP id 93mr48006780edy.33.1582588284733;
 Mon, 24 Feb 2020 15:51:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
 <pull.548.v4.git.1582557199.gitgitgadget@gmail.com> <04c3e5760f60cf394af66bfdb4fe1d561a093567.1582557199.git.gitgitgadget@gmail.com>
 <xmqqftezod3n.fsf@gitster-ct.c.googlers.com> <CAPig+cRWEnQL2Pye=20M0cjHsAFPvLVFWpOv_JM-Gm0hXZUS7w@mail.gmail.com>
In-Reply-To: <CAPig+cRWEnQL2Pye=20M0cjHsAFPvLVFWpOv_JM-Gm0hXZUS7w@mail.gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 25 Feb 2020 12:51:13 +1300
Message-ID: <CACg5j27MmFgo5vLse2RroRPUaaOh_nH2cWpvLKZhuFmQFw939A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] advice: revamp advise API
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 25, 2020 at 11:11 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Feb 24, 2020 at 5:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> > "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > +test_expect_success 'advise should be printed when config variable is unset' '
> > > +     test-tool advise "This is a piece of advice" 2>actual &&
> > > +     test_i18ncmp expected actual
> > > +'
> >
> >  - Prepare the expected output inside test_expect_success block that
> >    uses it.
> >  - There should be no SP between a redirection operator and the
> >    filename.
> >  - Here-doc that does not use parameter expansion should use a
> >    quoted EOF marker.
> >  - The file that gets compared with "actual" is by convention called
> >    "expect", not "expected".
> >
> > test_expect_success 'advise should be printed when config variable is unset' '
>
> Also, s/advise/advice/ in the test title.
>
> >         cat >expect <<-\EOF &&
> >         hint: ...
> >         hint: ...
> >         EOF
> >         test-tool advise "This is a piece of advice" 2>actual &&
> >         test_i18ncmp expected actual
> > '
>
> s/expected/expect/

Noted, thank you.

Heba
