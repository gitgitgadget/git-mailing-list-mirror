Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593D4C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 19:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDST3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDST3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 15:29:43 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8168192
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 12:29:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63b4e5fdad0so207960b3a.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 12:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681932582; x=1684524582;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzKe1a2TwSR1PYu+B7ykLov8vMzARKA0N/If0eAHUuY=;
        b=ILlnuLLnkos9XTr4Hz/GGKJhpVWlDm/v8zcW+MLDTPFVE7qUoziNT1oqwubghDG2IP
         PwDB94soSAeKgoEiV1ziiNhUxiz3Qykk3kYd1hT0Wda25L6/QfL2Y1o78Hmvw3v+Ff2/
         m5LpIRB2klKD9YCx35QubT6B3KElPPx/4NjM9BZcv9OFyNgHLd+kQ6a+x1qggjchljF8
         qNX2tPpBccWvkbLHHlSv49skAfTGC7fxCQcCw9ktJ55Q7WWG6+2a4+jbEUIXxx138QOb
         IBoa2QdwSAhMsHQXq7FifrGw94fE8MqkiBRAqD5mRodcpu2geExYtLgnB0nHs3hZKvTv
         1bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681932582; x=1684524582;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AzKe1a2TwSR1PYu+B7ykLov8vMzARKA0N/If0eAHUuY=;
        b=BvLoWbj/GXKjhlFsCuSHgOkSvHASgegyrXt/Et1BfGP4/VLlBdJrHZnga8fV5lJ+WP
         vssGo+2xjUZQYukQYMkMvMsz4Ew/9EQ7z9G4v8n0jukKPV840rDCu8qhYN30ULY8IJo9
         un1+opmDWQ1PvZtwOnyQi3xafLP4C0NdGNwofPIbGi6HfLCMfXO2iJulosBrMCmr1r7b
         Z1vsUL9cRCcLYtt3fadUFMs4fTlNkn57IbvIqw1TfOCIbiwx1gdSwm57KTr7mF26yKGE
         nGKykwdOhujd9/heNC9yaiQw4t7ZsxSfDbcf+G8lIBSkfr4nEVvPv8NnJPQmo7L71EiX
         Scaw==
X-Gm-Message-State: AAQBX9cCIkEbzBuu78xXVUPo7CxVn2U28sBZURbn5JHObYk3wena2ook
        nJjVJe++GSi5cYTBG2Tw3XAhpfCc9ohDtw==
X-Google-Smtp-Source: AKy350YGeD7iATzdw5mRmXtIIocvVEPUvp39OCgRTkw+Ew7CPvWRAqlhgacqAk5YnAGHHAIE09pmSXxW6Vm8mg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1ac6:b0:629:f9a2:64e6 with SMTP
 id f6-20020a056a001ac600b00629f9a264e6mr2158988pfv.4.1681932581816; Wed, 19
 Apr 2023 12:29:41 -0700 (PDT)
Date:   Wed, 19 Apr 2023 12:29:32 -0700
In-Reply-To: <20230416074212.GB3271@szeder.dev>
Mime-Version: 1.0
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
 <75feb18dfd8af03f5e7ba02403a16a0ed4c2edaa.1681329955.git.gitgitgadget@gmail.com>
 <20230416074212.GB3271@szeder.dev>
Message-ID: <kl6lzg731xib.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/2] cocci: codify authoring and reviewing practices
From:   Glen Choo <chooglen@google.com>
To:     "SZEDER =?utf-8?Q?G=C3=A1bor?=" <szeder.dev@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason" 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +* .cocci rules should target only the problem it is trying to solve; "c=
ollateral
>> +  damage" is not allowed.
>> +
>> +* .cocci files used for refactoring should be temporarily kept in-tree =
to aid
>
> How should such semantic patches be kept in-tree?
> As .pending.cocci?  Then I think it would be better to point this out
> here.  Or as a "regular" semantic patch?  Then I'm not sure I agree
> with this recommendation, but perhaps a commit message explaining the
> reasoning behind this would help me make up my mind :)

I don't feel strongly about this, but I was envisioning keeping them as
a "regular" patch, e.g. what =C3=86var proposed in:

  https://lore.kernel.org/git/230326.86ileow1fu.gmgdl@evledraar.gmail.com/

In theory, this means that a long running fork (that didn't get updated
during the initial refactor) can run coccicheck, notice the failure, and
then automatically fix themselves with the included semantic patch. In
practice, I don't know how many forks run coccicheck, or whether these
refactors are just easy enough to do by hand.

For refactors, I suspect that the impact on the 'make coccicheck'
runtime will be low, since we're typically targeting just a few tokens
and cocci can skip whatever files don't have those tokens, so keeping it
as a "regular" patch might be okay.

> It might also be worth mentioning that before submitting a new
> semantic patch developers should consider its cost-benefit ratio, in
> particular its effect on the runtime of 'make coccicheck',

Makes sense, though I'm not sure what practical advice to give in order
to evaluate the impact on runtime (besides just running it themselves).

> in the hope
> that we can avoid another 'unused.cocci' fiasco.

Maybe this is a good starting point for discussing cost-benefit
analysis. I'm not familiar with this fiasco, though. Was an early
version of 'unused.cocci' too broad, resulting in a massive hit to
runtime?
