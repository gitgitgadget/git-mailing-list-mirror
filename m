Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92591F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 17:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeJFAyR (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 20:54:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38114 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFAyR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 20:54:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id l1so195106otj.5
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRZTPy5FKxa6za8EpYcLd8E4lJgRFWzqjx/9Z4h6Nwg=;
        b=nnszQpI8G3kwU9EWEPPNy4oRpr69mx13fYCn9Yzi1T03EWzU3zZuck7nv4i77nA2nq
         cbSowvDZJkcJ65aNcf9sJVlsOpPb3gOWD7IcGOt7bpe3szwJxTFYyrFd0EeJblKeOSYm
         TGXYTERxvdcUsWK7NHf0pEsrdiAx6R/IcErKTC0GAH29GAIJEEKvyY5OF6q+IanobkZ4
         PDmB7bDh4Y9uh4N+MkRQDUYAYxtQrZSSn30ADyj9pmOfSzMoeMpPOtCSd5bxDJq8Si0H
         T59guHr+pQKf/zPDhmzYWO94ksfdEEz/Jp9/bsHNrMxzAH77TxGprJa+07v0TvmTsac+
         4VQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRZTPy5FKxa6za8EpYcLd8E4lJgRFWzqjx/9Z4h6Nwg=;
        b=frurGOwDtFp45CVNK/A+5TtQ5hsgvGCCeHZ2ooDxTiUfexMHYOHYcgJbvXwD5mzVcY
         1xUmg8nynm0sKriPvAB6Z3CuXxtERVnb2NJ5y1qlycj4sQW7bOHRc+1Uhx5ljjRigkqR
         4oSoKlGTmTo1ofOIk/ff5mpVWcrlF9XZjFjndN2s8O6KakG+BFNuUgNgLwwByaUW2xxe
         auXWeNp+UsPUeY8tjhMSGblI+y94m3Z4BYXBzM31uTQk6AqoEvwdpfoO40plWztauMUa
         d25MhF/pG7y9viGhXVgMVZvYwFS4Fp1xvcRlHzMnW6kd1W8SIVvjlVCt1KVhUh9qfQA+
         TXUw==
X-Gm-Message-State: ABuFfogQlA7RqZcD9tVn2zwjqVP7vAjaUWxyIZefW744DRinEaHZGf5Y
        sA+Pchb9Mr7s6OaxiN0eAzYsTTkCCf0uvnN01uwY
X-Google-Smtp-Source: ACcGV62MxKWI31JdNawWqshuy/ZLy5UdZzpS9AqBnbtO3FYISQL0Pvm07F34dl8vlAtv4jnjsO4/P5khhGJP7o/3Dd8=
X-Received: by 2002:a9d:1c87:: with SMTP id l7mr7508679ota.259.1538762069326;
 Fri, 05 Oct 2018 10:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538581868.git.matvore@google.com>
 <8c0821f68570551675901f4bfdd3149884286c48.1538581868.git.matvore@google.com> <xmqqd0sowda4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0sowda4.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 5 Oct 2018 10:54:16 -0700
Message-ID: <CAMfpvhJasrpDxgt+LATsSQf68LB97hCQnCCnRMJP51iXDc34SQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] tests: don't swallow Git errors upstream of pipes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 5, 2018 at 9:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Hopefully this is not a blind mechanical patch, as introduction of
> unexpected temporary files in the working tree could interfere with
> later tests (e.g. they may expect exact set of untracked files, and
> these new temporary files would b unexpected additions).
>
> Thanks.

I reviewed the files modified in this patch. For the svn one, there
are other scratch files being created in the cwd before mine, so my
additions should be fine, I admit I don't fully understand the
commands being run in that test...after the temp files are created, I
see git svn proplist and git svn propget being executed... the public
documentation for them does not seem to contradict my assumption.
(http://svnbook.red-bean.com/en/1.6/svn.ref.svn.c.propget.html)

As for the other test files in this patch, all git invocations are
either "git clone" or "git init <dir>" or "git -C ..." which means
none of them care about extra files in the cwd. After I searched for
Git commands I read through the files somewhat briskly and looked for
any globs or suspicious invocations of awk, grep, or other commands
(we really do use a limited number of commands in the tests I saw :)
and did not find anything that depended on existence or non-existence
of unnamed files.
