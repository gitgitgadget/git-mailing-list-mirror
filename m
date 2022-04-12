Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09597C433FE
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 21:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiDLVGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 17:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiDLVGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 17:06:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9069115281D
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:53:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bg9so85360pgb.9
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VcE9XGEekjudM+GHDf8WwH/meHt+uJn7TW7C00gpqDQ=;
        b=Rc3lZbxqbz9jrcT95RxZ3ngoUrb9CYyECiURtxg759xfqT248M6bCHx3ulwCYOyJiZ
         1+8A4f4+wZ4Jom+89Bh/aEYB6PW3jZIjwKhFM2+XNI644ldAHe/HdIQypX7aKPG0g4B8
         A8EDSxBdCtYv/zR05Thc+KR+bWE2v0B3f0tD1jtX8uW8yjYf7doOjDTX0Ukawt77gYkK
         V1yh0b6Z8xP13uo5CuQBDRUb+oz06L7gzDfAxgWGL0xnbykE97g3nUgAS0iKxC1ZNYDK
         AGEcXcGCOa5Too33eAevYgu1JZ0OFz9jTithqzMriL4VjhP90xJv130e6o1Vbi5EOlNq
         zMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcE9XGEekjudM+GHDf8WwH/meHt+uJn7TW7C00gpqDQ=;
        b=tRcWdkTfaDa+tAfIlFDJNrpqQjVjnu0bGZJLas2TiUxSKIq688pYlfKL2AhoqeHHLF
         zYK6v2qyY9OtKF67k2Ziie5LwwUYPohdl44OSH7Isp4W65AYoyq6cmJLL0fBT68GftB7
         XLUQh1oueWZsIPxyUT6dai380f6LuYFs8fraE++aR+jiSRks9ElAADdilgNGhLuutpw7
         dm+gsrDwzz0bT6nSMhYUQP5+BPFje8CRaFYxj2BUSMUmG1v5ZizQt3jHzX0b/8Ql1SqA
         NIkejDirM8oacZRzaPYJqPk2WMcEYs2cHUw4fA8ydfhZUuBQOSX2Y57ezQB3xQQEOV+x
         hgCg==
X-Gm-Message-State: AOAM532EeFAZvaI0yXsxRo5Ax7hb1GITSYeUQNCWnEdMb9PVWuDDkZFc
        NlgDoHrZFAJEmziT7wTYhlD2LPmpUYpL20mgLj6HWM3SXPMxbQ==
X-Google-Smtp-Source: ABdhPJx/LqxiJhg1/MlsOd8KCBC+WdxOYTHPsvpl2WDgRX4YW3EAm4a8Nwia92Hzh60cI4TtskJMK/OaVamJfSQa/ck=
X-Received: by 2002:a05:6a00:2349:b0:4fa:934f:f6db with SMTP id
 j9-20020a056a00234900b004fa934ff6dbmr39625020pfj.44.1649796825060; Tue, 12
 Apr 2022 13:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
In-Reply-To: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 12 Apr 2022 13:53:34 -0700
Message-ID: <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
Subject: Re: reference-transaction regression in 2.36.0-rc1
To:     Git Users <git@vger.kernel.org>
Cc:     Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 12, 2022 at 2:20 AM Bryan Turner <bturner@atlassian.com> wrote:
>
> It looks like Git 2.36.0-rc1 includes the changes to eliminate/pare
> back reference transactions being raised independently for loose and
> packed refs. It's a great improvement, and one we're very grateful
> for.
>
> It looks like there's a regression, though. When deleting a ref that
> _only_ exists in packed-refs, by the time the "prepared" callback is
> raised the ref has already been deleted completely. Normally when
> "prepared" is raised the ref is still present. The ref still being
> present is important to us, since the reference-transaction hook is
> frequently not passed any previous hash; we resolve the ref during
> "prepared", if the previous hash is the null SHA1, so that we can
> correctly note what the tip commit was when the ref was deleted.

I've re-tested this with 2.36.0-rc2 and it has the same regression (as
expected). However, in playing with it more, the regression is more
serious than I had initially considered. It goes beyond just losing
access to the SHA of the tip commit for deleted refs. If a ref only
exists packed, this regression means vetoing the "prepared" callback
_cannot prevent its deletion_, which violates the contract for the
reference-transaction as I understand it.

Here's a slightly modified reproduction:
git init ref-tx
cd ref-tx
git commit -m "Initial commit" --allow-empty
git branch to-delete
git pack-refs --all
echo 'exit 1;' > .git/hooks/reference-transaction
chmod +x .git/hooks/reference-transaction
git branch -d to-delete

Running this reproduction ends with:
$ git branch -d to-delete
fatal: ref updates aborted by hook
$ git rev-parse to-delete --
fatal: bad revision 'to-delete'

Even though the reference-transaction vetoed "prepared", the ref was
still deleted.

In Bitbucket, we use the reference-transaction to perform replication.
When we get the "prepared" callback on one machine, we dispatch the
same change(s) to other replicas. Those replicas process the changes
and arrive at their own "prepared" callbacks (or don't), at which
point they vote to commit or rollback. The votes are tallied and the
majority decision wins.

With this regression, that sort of setup no longer works reliably for
ref deletions. If the ref only exists packed, it's deleted (and
_visibly_ deleted) before we ever get the "prepared" callback. So if
coordination fails (i.e. the majority votes to rollback), even if we
try to abort the change it's already too late.

Best regards,
Bryan Turner
