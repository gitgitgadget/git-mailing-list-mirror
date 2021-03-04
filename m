Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A56C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 09:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DC764E60
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 09:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbhCDJBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 04:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhCDJB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 04:01:26 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7ACC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 01:00:46 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id f26so6411552oog.5
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqdaOBSX9jYCJAgOMkDbt8ffIhUkqfxVI9W73cDUQ8w=;
        b=OO21NOOFVZrwBzGna1QMOnRuCv3aC37JRiUo/crM95esKDDKjBWIdQ225TbVyMpsGf
         0OwPEegGckKaTNFgKpuviKi3ShPLWjjIKls9jftUkYXBWm1TQbYjjFdhE+cElUIe3xXh
         9773mKp+JubBuAPodIoOvtJFwQEMyLhBuZ5R6eAkx4Hcx3BjGpCtEjwkhbeOrNgFEZgv
         KO07okLMi7O0pDserwdLkQ7gUD1JCAJoU+SpqZVQaPda9lGLLA84tPHZzFV/hq1CQNbl
         Np7y1+M+FltwUJ5Wzah9xCtMKpbwemYB7HDuryBNoEeshQrndsDKM99iYlX9KjiHJVLx
         +U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqdaOBSX9jYCJAgOMkDbt8ffIhUkqfxVI9W73cDUQ8w=;
        b=tgAruphMlVqU6TO3oeervzGiWB/AoaMugU8fIiuiAtDGFIPaSLFD57tbYP0ac6Ufww
         SKgEMSssh0e8SX+lSgxrRNrdFM9Ek+uiPGHyTZbvzrhyN8ztchr69AifObCZR/qx8ftn
         7hnNVTCswL/FEFjfsxf0dR4Rn5UNku6n0thDfZfoGA/xTTmKS0Uh7F5Z6xd8IH14eMZu
         w9/CTq4pd7QFuhnwCumgKEsLJ8AOslFn+4oSoXI+zfIPM+Yqf2ZkykjMTYhGqfmAkiSI
         7IPsr+oNvCYzIZjeZjphKEklJCPzR+GSeQe85qibkoJS1KgvaQRmUrOyuAuwsXC9zzGb
         Z5Ug==
X-Gm-Message-State: AOAM530A871TSrJrdKeLAOf0p3mrkdY9LlHuBxIQJllK+AXiwLenfvZH
        jzc3IL2E4N9cH/ZoL8ilcPlcczfiwkJrPbeB79g=
X-Google-Smtp-Source: ABdhPJxAVdHctHfZpIME/xuCnyxfHy3t2CVeIz7ImlEt+NuU8i5Z0K7DKTyRjRS8sJoLiGH4V6ZUdr2Q8YH8i4a5oH4=
X-Received: by 2002:a4a:e70a:: with SMTP id y10mr2554302oou.75.1614848446054;
 Thu, 04 Mar 2021 01:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-7-charvi077@gmail.com>
 <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
 <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
 <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com> <xmqqczwfg23t.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqczwfg23t.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 4 Mar 2021 14:30:34 +0530
Message-ID: <CAPSFM5cM4fdyWXD33PkT2bH6kM+3ixkxgAnhjUVYFtjUHgwU5g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 4 Mar 2021 at 06:35, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > Hmm, I see. So "reword!" is really just an "amend!" with only commit
> > message but no patch content. That makes perfect sense from an
> > implementation standpoint, but it makes me wonder if it would be
> > easier for users to understand if it created a "reword!" commit which
> > would be recognized as an alias of "amend!". (But maybe that's getting
> > too confusing, and my musing should be ignored.)
>
> Perhaps related, perhaps not, but I wonder if we really need --fixup=amend
> and --fixup=reword to begin with.  The "amend" variant,
>
>     $ git commit --fixup=amend:<original> ... other args ...
>
> is about shaping the index with "other args" and recording the
> resulting tree with the log message taken from <original>, marked
> with the "amend!" prefix.  The --fixup=reword:<original> variant
> is a mere special case of it where the recorded tree is made of the
> index in the same way as a partial commit with pathspec that matches
> no paths, i.e.  If you have --fixup=amend, you can do
>
>     $ git commit --fixup=amend:<original> --only
>
> and you do not need --fixup=reword:<original> at all, no?
>

Maybe as an alternative User interface, we can remove the
`--fixup=reword:<original>`.

But for this patch, as we have kept separate suboption
`--fixup=reword:<original>` , so if now we do
`--fixup=amend:<original> --only` then it will return the error as
below :
fatal: No paths with --include/--only does not make sense.
So, `amend` works only if staged changes are present otherwise to
change only the commit message `reword` option is there.

I agree we can change to the above UI but still I wonder which one is
more friendly ? Also, I think we need to add complete `--allow-empty
--only` to mirror the working of `reword` so this may result in a lot
of typing and hard to remember.

Thanks and Regards,
Charvi
