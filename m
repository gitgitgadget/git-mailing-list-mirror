Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4485EC433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 07:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347554AbiDDHvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377817AbiDDHvv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 03:51:51 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2792611D
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 00:49:55 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-de48295467so9741723fac.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hp3oJ55EIkGTfNjS8dShWVcNvg+fA+omEN0oabLh6qw=;
        b=ZFyyEBygd4rCid7s7HxscuE53BiHjkVABqjfmIaJsu0AkxNs2mXhvYxu9SfoUTGAuW
         oyjZhwfacdFz2jaxsqo2k0HgEQvrq6oPxA4t4117B3nQa4AtBhRh2ci+dCEsMccRMA9i
         EY/rXGiPidUJeQm49TMQ3+w+ZMjSUFmv7lzKaCbih80uyQTqwJ4rqousR8gu5Ir6kj+O
         0HzfuMqUZzXtLUNrn0bbH8+ghOl7W+YcURd7VjDv25Cb2S7chezWNxB1vVVgXyr1/QI2
         7PMl+tK/h5BkDz7PmMb5LcZF+8iNw+pEa6ner4dnRZgZXxHRYGaBY6tIJlP8QAolykm7
         x8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hp3oJ55EIkGTfNjS8dShWVcNvg+fA+omEN0oabLh6qw=;
        b=73GpMl3d7lHxdvu+PyIR41uNLVZ3u/gsCexEN1qOmLbFvPKWZFp2JDjYzd7dSqPjuo
         pLmhQv6GVn4Um3YTy2cCu7OotkJtmG563G689s+7cSoXF+e2t/CHDKQUgnhgmjSFA/0f
         +xPrVdXnj1A4kqvdLXZt5F/a5SNYkWZacyknN5LjNYBn32Xa7hCHbgD6sxXA00TJFrGn
         CHw6LP91IqO7pVIMDkjKVCW0hmVQm1Phvux8inG+L0iP5XpXyWeanQzYV1ooBv5JVFG+
         LXphrFGVUi1wyz5NYeLl/LiVwJrggHHFA/lD0Ne6FzAWMnpRbdhT63Bz0ckvXqfB1Tfe
         QCNQ==
X-Gm-Message-State: AOAM530uah/Io87Bc+4s/HqlPPQ881voYwXxG1t93jkX7LO1rTEI5f9g
        5VGCBHL716Aq4OJdMjtRvJWatlvaYSuMyssRqAc=
X-Google-Smtp-Source: ABdhPJwL1+ODaOP4j+NHEsv1vnhl8Sn/qp8H8FjyAmHy3o1Qfciaake9wUTwHja8SIj/CetERuLK0dmlCBY8xoj6XSY=
X-Received: by 2002:a05:6870:f697:b0:da:b3f:3268 with SMTP id
 el23-20020a056870f69700b000da0b3f3268mr10169501oab.280.1649058594249; Mon, 04
 Apr 2022 00:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-3-shaoxuan.yuan02@gmail.com> <52784078-c748-a4a0-68b4-db3c133dfa80@github.com>
 <CAJyCBOQmUYe53ahpEXQZAWMoers0o7b1xuCYu_k-LrfvKTkV-g@mail.gmail.com>
 <22aadea2-9330-aa9e-7b6a-834585189144@github.com> <CAJyCBOSQVA5oEW7_iKZW895ycQ4T=XAx422s4m+6VFDSDVeNMA@mail.gmail.com>
In-Reply-To: <CAJyCBOSQVA5oEW7_iKZW895ycQ4T=XAx422s4m+6VFDSDVeNMA@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Mon, 4 Apr 2022 15:49:43 +0800
Message-ID: <CAJyCBOREzrGSwzjAz_89q1+O2X-qqa-qB2ywPVGU=q37O-QdzQ@mail.gmail.com>
Subject: Re: [WIP v1 2/4] mv: add check_dir_in_index() and solve general dir
 check issue
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 3:25 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> I read and think about this part a few times, but I'm still confused.
>
> As Victoria pointed out earlier, and I quote, "Sparse directories *only* appear
> when you're using a sparse index, so, theoretically, this shouldn't ever
> come up (and thus isn't testable) until you're using a sparse index."
> So I'm not so sure what do you mean by putting "full index" and "sparse
> directory" together.
>
> Thus, I go ahead and try to detect a directory that is outside of
> sparse-checkout cone, without sparse-index enabled.
>
> I found a problem that if you use cache_name_pos() to do this
> detection, I imagined the following example (I'm trying to imitate an
> output of "git ls-files -t"):
>
> H a
> H b
> S d/file1
> H e/file1
>
> So in this index, I use cache_name_pos() to find a directory "c/". I imagine the
> the value returned would be -3, which indicates this directory would be inserted
> at index position 2. However, the cache entry at position 2 is
> "d/file1", which is
> marked with SKIP_WORKTREE, and this fact cannot guarantee that "c/" is
> a sparse directory, since ''c/" is not in the index per se.
>
> Probably I'm missing something, or I'm just dumb.

Though I think doing a strncmp() after the cache_name_pos()
can get the job done :)

-- 
Thanks & Regards,
Shaoxuan
