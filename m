Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1CBC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A0961416
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhGARs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhGARs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 13:48:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E313C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 10:46:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id k8so9611180lja.4
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=f2aMVvhg2+AVvt+xpyKdwMAcUW2w7Dw7IcOPMmR8vbQ=;
        b=f0sr92PfIxLoBQQqg7Rw0O+nOg7KO/yPYvJBtBnwlCbp3ghIj8ATRByFXeAnHbQ/ws
         CBzliHPOIhDg9T4dmsZUv30WBjVSUXVk6NlO7CBYHEE9MTzyDwx6cwErWoIPwc3oZF2P
         FJBJU/l0oOv1HiaSbcJQ4YVFZNedEg31QuVCOYoCVBmI4kmu9cFjFVlpBG+aa3F3yZZE
         iypoQ7gbt+C+12hsBMlxhRaXoBvx7hwPSJe8E84Dz/dJbwtL/I+tXGV/1wheuXZJvGV9
         27ZAX2c5/yQqY+BVCJHKMkB4XHx//W2Z6Wa/nnuzen9qGSO2nsgIm7wzy9DxV8Kl450N
         XK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=f2aMVvhg2+AVvt+xpyKdwMAcUW2w7Dw7IcOPMmR8vbQ=;
        b=i1txG8UdOgsYlkSoFrJIt8LsKoqDIxgOP46YIRpjX/gudFzmIF9BjQKBHUludbR5ir
         lDdqyvN9lJMLLLHwRfTUw2t6BmdDHsUDhrdApJ/i9uzamG9CE6LA08eDtGNqEjmz0pYd
         CAE31ESTdXHsXJ4oyqtAKsTSHzuKLnhjcuYRv+TgF+n9BZTCUndIxv5ir8iBIRVC13XD
         yxJ5tthgoKX/o+9XDkJ0XIC86GtVmiVUNDOoim6VRWSeSroe9zH1dmmtMfb9at8E1V5j
         xSIr4hqSpbL89xdsrfdMzkkNnib1GR4Ww6HkUFPhXjO8581dOYrP1poTsCya1b4+TZB+
         UayQ==
X-Gm-Message-State: AOAM533p2LZUQNUUpuekVqkCQwxzv/mWD0e5AFoAUjugonVVG0LKmDno
        5f9Nt42DV5KxlflrU7JuElA+D+lH6Cg=
X-Google-Smtp-Source: ABdhPJxTGTBsLOJl9ui+Zlel2mkRvun1dixuaIspV8WPB20T6srsbm6VMzzhP+LiO49SRvobDJ4vZg==
X-Received: by 2002:a2e:bf2a:: with SMTP id c42mr586164ljr.1.1625161582579;
        Thu, 01 Jul 2021 10:46:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v138sm31952lfa.79.2021.07.01.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 10:46:21 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqk0mcy6g2.fsf@gitster.g>
        <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
        <xmqqpmw4uwh2.fsf@gitster.g>
        <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
        <xmqqy2arrmba.fsf@gitster.g>
        <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
        <xmqqh7hersgp.fsf@gitster.g>
        <167b8fe6-0586-b980-dfb9-9fa3a29d48bb@mfriebe.de>
Date:   Thu, 01 Jul 2021 20:46:20 +0300
In-Reply-To: <167b8fe6-0586-b980-dfb9-9fa3a29d48bb@mfriebe.de> (Martin's
        message of "Thu, 1 Jul 2021 19:29:06 +0200")
Message-ID: <874kdeapw3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> On 01/07/2021 16:58, Junio C Hamano wrote:
>> If I understand you correctly, the confusion your hypothetical
>> newbie would have is caused by the word "start-point" in
>>
>> 	git branch -f <branch-name> <start-point>
>>
>> That is, if we repoint the branch that is currently at Z to point at
>> X with "git branch -f B X", it is possible to imagine that we build
>> more history on top of "X" simply because "X" is called "start-point",
>> i.e. we start at X and do something more.
> It is probably more the use of the word "branch" than it is "start point"
>
> Sergey made an excellent point:
>> On 01/07/2021 13:27, Sergey Organov wrote:
>>> For example:
>>>
>>> "branch": a chain of commits
>>>
>>> "branch tip": the most recent commit in a branch
>>>
>>> "branch name": specific type of symbolic reference pointing to a branch tip
>
> A lot of people think of the "chain of commits" when the word "branch" is used.
>
> If we take the sentence from the current doc:
>    --force-create
>     Similar to |--create| except that if |<new-branch>| already
> exists, it will be reset to |<start-point>|
> and replace "branch" with "chain of commits"
>     Similar to |--create| except that if |<new-||"chain of commits">|
> already exists, it will be reset to |<start-point>|
>
> What would you expect to happen?
> I would think the "chain of commits" is created at the new
> <start-point>

I find current "git switch" documentation utterly confusing, even for
experienced user, let alone for a novice. I'm only afraid that it's not
only documentation, but the design as well.

>
> What we want to say is
>     The "branch name" will point to a new "branch tip" at <start-point>
>
> However, this still leaves the point, that new users need to
> understand certain concepts and implications.
> Such as moving a "branch name" abandons the old "chain of commits" (they do not follow).
> "branch name" helps to remember that distinction, but it still needs to be learned first.
> "abandon" => leave them to the reflog until expiry.

Not necessarily. There could be other references left to this exact
commit. User doesn't need to be aware of reflog at this point at all.

>
> The point is, that those concepts (difference between branchname, and
> commits in branch) may all be documented.
> But the reader may still be learning all this.

There is no way around. Either they are expected to understand basics,
or documentation will lie to them trying to be helpful, that'd only
create even more confusion.

Thanks,

-- 
Sergey Organov
