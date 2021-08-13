Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998D4C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 17:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7902860F51
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 17:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhHMRWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHMRWK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 13:22:10 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69878C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 10:21:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h11so17018413oie.0
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkz6npMTu20dkV9eoRv0rfhIKK4KNZrOLujlcBzNW40=;
        b=hNAz0addAKNwo1x0S+jY6zYiVCTOvY/cMf+FpAy38D13VkPKy5gZzQ0LFx7ZOLEQqv
         /Pms9UpRntMTJHLzEP+hoDXPoFJYQgwSsoDhqaBU+ytqGUfdIFw8PoqcrZ/TRqaowClS
         ruBev+4QUds7/kwTnEn/LBW6oFev0sd7WOCT0STH+WQfPIdbxWs1Hl5poHYubPej2jjC
         n4L1vxgRrdI/ekWiE/vEZ2JhCg94K1Y+Exz74CUJh+WFFM62adDUxthrDWXCn5m4S7C8
         Ud9veBVAfvy9oyZ5fgImRjO9ZPIsYnBqwpmq2QAg/PV/zHjLUI4oF1tjs1AIitaZiKjb
         4gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkz6npMTu20dkV9eoRv0rfhIKK4KNZrOLujlcBzNW40=;
        b=elMtzKg2y91C+S2l6ETBTyOXGzkAx61cX0NYI1/+JJDKSOlXZ5d+6Kbcpq/wHXuC6Q
         4C9Y0XNs/y4uMZIYGRQXrqwAucrO40QgSTL3UjRC9nkQUNSZOb6Y9FAFrjqdsWfH8nDw
         Ye3Pfyqk1sBKWWve8pEc1Tls5C+DIFh38Hxwo49Y+ZPJ7IhtrkLbSWCdNknBnjq9u8bV
         INypmWrPPt4956UIPQHnRc20nx07REoF/Wszyiv9vNj3jkUqLOnqpuQsrKOt+B5/W4c0
         qbjK+ULryXqnzqsKwx5uNom826uNingA12VxJnNU2r7IigABnzjiUrSD/EDfe/s0PYv9
         37vA==
X-Gm-Message-State: AOAM531wvdRwFYDJ7OzLYjtq9YvBRiwbCOi9VUywLJV/1E/lOS16lpwr
        w8EreenGAWph5DKNQKtsu+khTmeZKkWbYur/65Q=
X-Google-Smtp-Source: ABdhPJyD93lmUVP45wCbTP54XeOmru68cUdHYMVb64WF6ZrxRy4u49GAoRaRStOv7f9XZCxbSHUuZ3ip9c0pdWOSPAY=
X-Received: by 2002:aca:c0c3:: with SMTP id q186mr2926879oif.39.1628875302467;
 Fri, 13 Aug 2021 10:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
 <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com> <CABPp-BGHmCCeY7j9hVDGZPuLU8gR-ka3iEzUjK0wvkSUSYdNxA@mail.gmail.com>
 <xmqqim09xswt.fsf@gitster.g>
In-Reply-To: <xmqqim09xswt.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Aug 2021 10:21:31 -0700
Message-ID: <CABPp-BHi2GG8zmFEHHhMOUjkmmUfmj+ODT+KYUAXrXcgypRVYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rebase --continue: remove .git/MERGE_MSG
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 8:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Thanks, this version looks good to me.
>
> Thanks, both.  Elijah, can I take that as your Reviewed-by?

I typically do a bit more checking when adding a Reviewed-by and had
just a short time available yesterday.  But I've done the extra
checking now, so yes:

Reviewed-by: Elijah Newren <newren@gmail.com>
