Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D5C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FEE61439
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbhI2Q53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbhI2Q52 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 12:57:28 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1892C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 09:55:47 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 61-20020aed2143000000b002a6a0f52ce7so9382752qtc.0
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LjI9VkFEcMyWvigmo4Y1h16ZScjUqLstXyWh3Ns5QkQ=;
        b=F4TUmXcYUZpxZf3sGVxeBf/Iy1Xy6zWTrGbQwb0Em1JNfV0ceWzeGYlqF6kkyZUcoV
         7FtdUWPJ1RDO8rc9foT7XjYLoCZLKDlnJo+ppbgdAV/Io6FqNZTBp2+0XjAithmFLT7J
         ZJy2gBPc86keOOpzCOR49Zt7350ItPLz2IhNBBJpmWSTm4GGdPd6xegiWEGwUwscmCAe
         bOAr3hWJGSZ+97j5iSahdV4wZx+3Zs6tLUNfQ+hWi2knL3GBolfbYmJtdYFXlyr8TGmB
         TyaAySFFPWzocWyldsyTtX01KAadKoetlQ6pAH1UlQWBLEFRwUgAn5UcL51qrV1pO11K
         se6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LjI9VkFEcMyWvigmo4Y1h16ZScjUqLstXyWh3Ns5QkQ=;
        b=v6bBP9A/wF1KbOmuJnZXU0sDzmogrVMY9XBg0R8OkQHVNKqF1f+4bIaE9BpSNSRZVR
         A3f8mWfuhhj5FTHzEwSQp3AJWIelSrWFaGqwFhnRf4JOtYN6Q+NjCCHFoz+lEI9Zsh+u
         /ofv96ddYVcuJGlUkie2Mp0/UWpDyxukKE8mUsMmODK1ijukKjvg2nuuIpX2fVPguZez
         ZiO+/Ta6ad8PEe5BPhQCGv0NrLeHObR2BtZ3Ko2PBTs2fPDzJEwnRy+BZcotQjXx6Nsb
         3q9mYOP49mtrBmNmv271/Pz3/KhARs2lKMj52hUje6d1Lrlse0FGkj5p6hkV/1LDn0E/
         RmJA==
X-Gm-Message-State: AOAM532LsfIVE6zCPYPEvi4qMZqOE6h6wcF3NsRpSbtkbu7zLM3QzBGe
        fWYOd/TV9h+vlQvWjFN1I2Z74OJj8FKT4A==
X-Google-Smtp-Source: ABdhPJxzerG5YDOzw+69qT6PWWYoyq/AwjwCJYcr/Y9KQAcPfC5bmbNWCmFqCbs3NmvkNJAt+yqoWzG/yFE/Mw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:ad4:4652:: with SMTP id
 y18mr917322qvv.2.1632934546973; Wed, 29 Sep 2021 09:55:46 -0700 (PDT)
Date:   Wed, 29 Sep 2021 09:55:45 -0700
In-Reply-To: <87y27gv5bk.fsf@evledraar.gmail.com>
Message-Id: <kl6lwnmzpbhq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAENgTz2DoStQEqoKYKa-qMcyaez64u55mnv1HHOzDm392fuEqQ@mail.gmail.com>
 <CAENgTz0st6RpnVusP67-SSh2eENSxQn1_qiEqUDiMKzg=r54vQ@mail.gmail.com>
 <CAPUEspgr71t-thozi+Ez4xwxAkSJizsLuV=0TnROKZ85M6-kBg@mail.gmail.com>
 <kl6l1r58r6ba.fsf@chooglen-macbookpro.roam.corp.google.com> <87y27gv5bk.fsf@evledraar.gmail.com>
Subject: Re: Feature Request: `git commit --amend-to`
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Aidan Gallagher <aidgal2@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> [...] I think the problem
>> has more to do with how Git manages merges and conflicts and less to do
>> with having shortcuts in the CLI.
>
> I think that users who'd like an --amend-to would probably be happy with
> or might want to try out something like "hg absorb", which is something
> I think we should have stolen in git already, but it's never too late.

Agree. I think some "hg absorb" features get at the heart of what I
meant, which is that users would benefit from making this merge conflict
resolution a lot simpler.

> I.e. it's a "git commit --squash" on steroids, which tries to find what
> commit to amend things into.

But this is an even bigger step up from what I was suggesting. I blame
my own lack of imagination for not even considering this possibility.

To me, what really sells the feature is the "history of lines" approach
cited in
https://gregoryszorc.com/blog/2018/11/05/absorbing-commit-changes-in-mercur=
ial-4.8/:

  The automatic rewriting logic of hg absorb is implemented by following
  the history of lines. This is fundamentally different from the approach
  taken by hg histedit or git rebase, which tend to rely on merge
  strategies based on the 3-way merge to derive a new version of a file
  given multiple input versions.

Traditional 3-way merge is extremely frustrating when you find yourself
touching the same lines over and over in a rebase, and I think "history
of lines" maps quite cleanly to how humans think of lines. However I'm
not sure if Git has any machinery for doing this.
