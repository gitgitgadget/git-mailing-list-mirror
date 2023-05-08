Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD2FC77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjEHV1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEHV1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:27:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2AA86B6
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:27:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f19a80a330so33418495e9.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683581239; x=1686173239;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mySby13VJNpfONvh0D/b04ENRbM9Y9klbvGxZ4LdNyw=;
        b=qxFzBgDOB19cLHs9kPyp03mRap5lH3sufjV/lHRg856Z8NajDjSg5YSuze3yWbrqMW
         p2dEpC7wXVA+iPdLjxAeeiw5ZCKgxZQUPjE9ksGcFuWN9+f67lA54NskNEIjNLOzHYaA
         eB5p3cYYeTR5v4moWb7/D2oJYxIrGeHO1ff7+x+kY9r6zUANjcmDZTFw8EpwZs+6x37t
         cKYWUnN7Hpz6WTUaqFSFgoL2Vohw01GavXXjihOIkbmbBhJZOHR3yNozLEdrS35iCtUM
         5IKzDFgTAPP5PqOH3qysu0fubuD0hRXbKPQa+y12L5xCmA6ETPL5Q7zEFXyeuWlYLlAz
         EG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581239; x=1686173239;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mySby13VJNpfONvh0D/b04ENRbM9Y9klbvGxZ4LdNyw=;
        b=W0o1e29OMvwWT9XOm/rBUaajkQgm9Wkb8j6qtSKU5jkXerQbBl/xgVcBJpzQ4frkOC
         pcI+K6d56Tt+a4I6E4fZnvOXVCx6kXoUMXF7u4teS4lPRxo15eR7bgHFI2Is9HE77A2R
         UZ8pUJ0XIY16ES5EZXRKDzWSYG2ltPfBcpO4vCZlxiM6PxBZFp2A0L1Ad+zoanTxSIle
         5bI0o4E/+TVNssv3S9w7a6ws6Xn5Ou5lW1EwShI96TmR1XiRMEhrlBHZEH8GPpQVReUE
         3P5u1L1mGTWoqux7WzedGElGbAws0fuBebfBm8KfEVIrQJpnO8NkYvWlP/U4gOjsmqXO
         CGgQ==
X-Gm-Message-State: AC+VfDxE9PuzaNegNB9DkRwfFlx0S9EWwLKfTXqpQJ4XxuVdQHwfa07H
        dF1iiK1GNAEpvc8QVkjrNnLR/kLlDAYm1BkrYgo=
X-Google-Smtp-Source: ACHHUZ7lguIyfvA6pT9vydtwQgZMAGvJA2Xo/PNx3wW+jeHCzjQU8szfr9hY3aTXEsjIil9gPFkToiFMxv/MzTF7Pp8=
X-Received: by 2002:a7b:c314:0:b0:3ef:6b97:f0c3 with SMTP id
 k20-20020a7bc314000000b003ef6b97f0c3mr7945979wmj.15.1683581239366; Mon, 08
 May 2023 14:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230508200508.462423-1-cheskaqiqi@gmail.com> <20230508202140.464363-1-cheskaqiqi@gmail.com>
 <xmqqednqmswx.fsf@gitster.g>
In-Reply-To: <xmqqednqmswx.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Mon, 8 May 2023 17:27:07 -0400
Message-ID: <CAMO4yUEmJM1-VYRePn6tjYHXmhEhj5-wkZ4VrX9EaS9=kSX-3w@mail.gmail.com>
Subject: Re: [PATCH v6] write-tree: optimize sparse integration
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, May 8, 2023 at 5:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Shuqi Liang <cheskaqiqi@gmail.com> writes:
>
> > * 'on all' in the title of the test 'write-tree on all' was unclear;
> > remove it.
> >
> > * Add a baseline 'test_all_match git write-tree' before making any
> > changes to the index, providing a reference point for the 'write-tree'
> > prior to any modifications.
> >
> > * Add a comparison of the output of 'git status --porcelain=3Dv2' to te=
st
> > the working tree after 'write-tree' exits.
> >
> > * Ensure SKIP_WORKTREE files weren't materialized on disk by using
> > "test_path_is_missing".
> >
> > Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> > ---
> >
>
> As we have lost the change to the code, the title has become stale.
> How about I retitle it like so after queuing the patch?
>
>     Subject: t1092: update write-tree test

I think it's a good idea to retitle the patch=EF=BC=8C as it better reflect=
s the
current changes in the test.

> The changes to the test seem to match what Victoria already gave a
> thums-up in her review of v4; I see nothing surprising or unexpected
> there.
>
> Thanks.  Will queue.

I really appreciate your and Victoria's continuous support and
guidance throughout
the review process :)

Thanks!
Shuqi
