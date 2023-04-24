Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A92C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjDXUMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjDXUMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 16:12:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA11AD
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:12:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so8441095a12.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682367144; x=1684959144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQn5SUCUBVUZVBsr68Q0jIVqk9SyhRiZ3uQbqfcUYDE=;
        b=p8x8x4FuDoYEqzGzExMqhbztc+azx91Cp5TDzj6Gzsx1JepR4o8TLL2det+YOeOUg/
         xie8WExhH2u/U8wzg/RUkRerPeB4VcRjpQvLu/cAo8E8NqC5+V8rWD0y/0z8ksWwegq7
         W/YQYOt4j+Xt/7toAYFWAnCUGICXizwCUCDPqvq4X4mfya4TnttmJzqPF2c0BS07Su43
         4FnopmTlALKVDHhk87aih8X+PKDdQ2oWGfyklu52xgpYal+CTnlmvaJmiWsxo4jBpPAH
         3hSRNP9Fdz1YpccfVecaIvU9hsErpcpoN7aB0atd1+6U3nKNnXtkX52L7I5JXvpGgZAy
         Mc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682367144; x=1684959144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQn5SUCUBVUZVBsr68Q0jIVqk9SyhRiZ3uQbqfcUYDE=;
        b=UOm8fTOauUFSOvLmlLMwUYBUK+TAPQgA8jLtl85Jq7/7mBDacdfYa2F2CWK1fO9L2S
         Iioh+/PD8QEH3LnuZmegYULnwOfPvhf5YhfqS/P17EarXdAGjMJj7oPHkfc5kpYxlyoY
         MVmMExQi8ZryKwKtfDNO8vs2Bo7+srlbFj8INtkyCQM6mHcdBNMBLgX3H1Iqt0oZlWL/
         /Iruky005tlpz7fziPdKRnAGxJG9NSCPRZm3rK6powv3KVwtFPkjmrZqDeFf2ERBkwbi
         Mrp+4Kx4Uw1vtDeOAd8tj1ugFajbbGA2IFL6x5/vN5vz6K0Q+KKUmAHfGxoCVRx9fpqS
         uiYw==
X-Gm-Message-State: AAQBX9fPbb8kvObi3feXPRKqEp4PkuY2QE27qp7WXKE0+8FeWUSafqhV
        7xEIuPxmeF+sC/UMMy4yT3DQrap5Yj9x2WEFTfj8M5xkHOY=
X-Google-Smtp-Source: AKy350afMrBH9+qxCUljC87ksVirwoLqCyen08gKB0zA0s9Yj7hql19TnALrFPWiKCPAXvDAJHCQ66GHMxgeA4FGK6M=
X-Received: by 2002:a05:6402:1010:b0:4fd:2b04:6e8b with SMTP id
 c16-20020a056402101000b004fd2b046e8bmr15354853edu.29.1682367144238; Mon, 24
 Apr 2023 13:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1394.git.1678776364753.gitgitgadget@gmail.com>
 <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com> <xmqqildpkwnb.fsf@gitster.g>
In-Reply-To: <xmqqildpkwnb.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Mon, 24 Apr 2023 21:11:47 +0100
Message-ID: <CAGJzqsnAj-yHHY9-79WSF7gCNN-x6scrFkXMxC6xQQMHWeeuKw@mail.gmail.com>
Subject: Re: [PATCH v2] credential: new attribute oauth_refresh_token
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 21 Apr 2023 at 17:50, Junio C Hamano <gitster@pobox.com> wrote:
>
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >     Patch v2 adds an additional test
>
> What we have below shows some differences outside the test, but the
> range-diff I see locally does show that the change since v1 is
> purely to the tests.

Thank Junio for your reply. Yes I also rebased.

>
> >  Documentation/git-credential.txt   |  6 ++++++
> >  builtin/credential-cache--daemon.c |  3 +++
> >  credential.c                       |  6 ++++++
> >  credential.h                       |  1 +
> >  t/lib-credential.sh                | 30 ++++++++++++++++++++++++++++++
> >  t/t0300-credentials.sh             | 18 ++++++++++++++++++
> >  t/t0301-credential-cache.sh        |  1 +
> >  7 files changed, 65 insertions(+)
>
> Will replace what I kept in 'seen'.
>
> The original unfortunately did not see anybody interested enough in
> the topic to review and comment.  Let's hope this time is different
> ;-)
>
> THanks.
