Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A2CC77B71
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 07:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDOHJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDOHJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 03:09:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE83C5270
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 00:09:25 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a29so22007018ljq.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 00:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681542564; x=1684134564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGl7/GwxQ+g+UZc8XSKi31mIUyVUr0fDIV5IFexB87U=;
        b=ZotxYExI7XNyqSMTfJgINcqXV+G+QYJFoooFTtFEX0P1pMzvzjEJn1bjJxXs8oz0lw
         dljzUm6NlVjTrzII0ehKeytQ0DdMm/hg2j2/Kv7dHjUZ7rMisgNP7byzEATk+uJz4D77
         rIJt19UGyDJr95PxR8LTFQyxBeqZaeMinn3yQEvZCbseG75eFtbkNEJ7x7GD/DtdvtvW
         Oh3dy3H6PzIbtCe+5Ob0GAFDhk18zXXYB/sWhEIi2CDLHRqTM/hzhoWy4jEMvlKKkhZw
         ah4rBJjlTwjMkKKRczNm6elXnn8lyd/oj+BX2IPVu9rH/tIrhe/P7pU4d25dB0lZs7ia
         UB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681542564; x=1684134564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGl7/GwxQ+g+UZc8XSKi31mIUyVUr0fDIV5IFexB87U=;
        b=GLz7Ge3aTGvGwfDoQwuVHsCDNVixdsLsW/N6BjRNy3y3btdIHFP2vTlDdegm0CYBWv
         k2W24OHN3YQOWHCqN9R1xLFPL4Cs02Cxfg+7QVz2y0YbCKVTOwMzA2Z3OjDTPf2QRgZt
         JVMBgrZsgOlX8ZzirKsztlCH7lahcvtvKvRchM6Q7Y0cPNp54QDWkuZ7LHIRF3CrIzoh
         SUyE+nKi1ZL6oYdeT3mj1gm08cYzXdCoLUcH3Dno6heZkk6+KEAsNspjkTnGw2IW8gRL
         YJ37aJaBp7TWd647sJlJ1+ZtogOpqIW9urz04dNetN47Nz6NUZuLHiyUG950oP7oLVHV
         OaxA==
X-Gm-Message-State: AAQBX9fRKO2DIhXrsrH4ovZjjq2ri0X2PDQdkpzIabbq/uH2cvtpTqiR
        gwJ5y3Qpw4zffLDRYqB62iqUWD/OxCaDrDrlnYI=
X-Google-Smtp-Source: AKy350YLPl1zfI4sgE1LiccjSLkC5CV/nvLmFAJhPpkMGX0yRCUQtG0aly2tqeHmz+hdJsIQ/OTE3BF64l1U4d7UK4Y=
X-Received: by 2002:a2e:9811:0:b0:299:a9db:95 with SMTP id a17-20020a2e9811000000b00299a9db0095mr2722511ljj.1.1681542564014;
 Sat, 15 Apr 2023 00:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 00:09:11 -0700
Message-ID: <CABPp-BFCv4rk6Z3jhqCSs0p59vVdhSvdmc2kSBFUnwsCuj5rng@mail.gmail.com>
Subject: Re: [PATCH 0/5] Document 'AUTO_MERGE' and more special refs
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 10:58=E2=80=AFAM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series adds documentation (and completion!) for AUTO_MERGE. In doing=
 so
> I noticed that some other special refs where not mentioned in 'gitrevisio=
ns'
> nor suggested by the completion, so I also tried to improve that.
>
> Since the changes are in the same parts of the same files, I thought it m=
ade
> more sense to send everything in the same series to avoid conflicts, but =
I
> can send the AUTO_MERGE patches on top of the other ones in a separate
> series if that would be preferred.
>
> Here is a breakdown of the patches. First the "other special refs" patche=
s:
>
>  * [PATCH 1/5] revisions.txt: document more special refs
>  * [PATCH 2/5] completion: complete REVERT_HEAD and BISECT_HEAD
>
> Then a preparatory cleanup for the AUTO_MERGE patches:
>
>  * [PATCH 3/5] git-merge.txt: modernize word choice in "True merge" secti=
on
>
> Finally the AUTO_MERGE patches:
>
>  * [PATCH 4/5] Documentation: document AUTO_MERGE
>  * [PATCH 5/5] completion: complete AUTO_MERGE
>
> Thanks Elijah for this very useful feature! Dscho, I'm CC-ing you since y=
ou
> opened https://github.com/gitgitgadget/git/issues/1471, I hope that's OK.

Sweet, thanks for sending this in.  I like the little touches you
added such as 3/5,
and fixing up docs of other refs.

I found a couple typos and some slightly misleading text in 4/5.

I'm also curious if it'd be worth attempting to point out the link
between AUTO_MERGE and the --remerge-diff flag to `git log` and `git
show`, though even if it is, it could always be added after this
series.
