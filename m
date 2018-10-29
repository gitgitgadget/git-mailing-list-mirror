Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805111F453
	for <e@80x24.org>; Mon, 29 Oct 2018 05:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeJ2OLp (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 10:11:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33919 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeJ2OLp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 10:11:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so8657808wmg.1
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 22:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xGaTU9/242PQ3GLuX1oUUSdT2ZXxBncQFaxBXOFRPOw=;
        b=QJ/rP/VQ3YlFPWREfKUUGzfd9etMIhkAy1gt4a6CTlmxJJRRI4zGWYdslqQK7oh0NK
         nbqQ0V6rIphfGWgGzPHPyeJNxQZ0RfwxhshoDfdO04FBtPOo8QZ/bzUcwI+vxSMr/3uf
         A8KSWuafozDavQ18e7Og3+lecTLLR+hq8jcE5AL/BKyzLsGcDLg2w262hKYufYUXSn5S
         tWswVBU8Clo1l8xYDX3ww9WoFPNpoh9caN0680xQnodTi8nq1RMM7HX4x6Tk3q+XMnWA
         q+6zqWrRC4slOEnJWwlng/EGeNRUgV2CIwpAmXdXtaw6wUu0dxwx5S4z93hoTcD/v6Ki
         u9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xGaTU9/242PQ3GLuX1oUUSdT2ZXxBncQFaxBXOFRPOw=;
        b=pXQAKWBmrqov61Nhued5AY0M52yRPphrXmc8Xu3v37ryp0ox9cwzIi1/Gg9KPfo/9+
         QlGOVkAXkGJB11GjdxiPd3rKitjK5e3cFYMlVgxdBUQGWPytOZ1MLwVp8762TAm5CliM
         kHSBxaglQgkdoey1IRBh3ejVeNAQt2vzhIZs8LGTGBHNllBpnb4QMDIxg+wAiktEQM83
         bn/byCfDAc4uktGLAq/XCnSwdViPZpO+/g2Jdj7c2w/KpTBtE1QsVF4OorCvpzVRau2B
         DKOcvtFsPOwJCQOT7w58tQ3eCHLJnPhgj1Ng/k0JwG+xUDcJswKlAanfv/vNsATyts/c
         F49w==
X-Gm-Message-State: AGRZ1gK1jwmR1tGkG5bXDZukF0jTnAEA1zrjOcgtUI5PZQSCPyhz5o+k
        /DPZCfPMY0+mOLBGHsM1pWc=
X-Google-Smtp-Source: AJdET5chM8jqTM8Nv+tv3IXDSeti4rv6pkcoMdkAu9wJwTrGCp8HpNpJB3GyXMrQJ9eH2fp8sqAe2w==
X-Received: by 2002:a1c:3e8d:: with SMTP id l135-v6mr12356421wma.13.1540790677854;
        Sun, 28 Oct 2018 22:24:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i7-v6sm37384489wrb.30.2018.10.28.22.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 22:24:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/8] push: add DWYM support for "git push refs/remotes/...:<dst>"
References: <20181026192734.9609-1-avarab@gmail.com>
        <20181026230741.23321-8-avarab@gmail.com>
Date:   Mon, 29 Oct 2018 14:24:35 +0900
In-Reply-To: <20181026230741.23321-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Oct 2018 23:07:40 +0000")
Message-ID: <xmqqlg6h4964.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add DWYM support for pushing a ref in refs/remotes/* when the <dst>

I think most people call it do-what-*I*-mean, not do-what-you-mean.

> ref is unqualified. Now instead of erroring out we support e.g.:
>
>     $ ./git-push avar refs/remotes/origin/master:upstream-master -n
>     To github.com:avar/git.git
>      * [new branch]            origin/master -> upstream-master
>
> Before this we wouldn't know what do do with
> refs/remotes/origin/master, now we'll look it up and discover that
> it's a commit (or tag) and add a refs/{heads,tags}/ prefix to <dst> as
> appropriate.

I am not sure if this is a good change, as I already hinted earlier.
If I were doing "git push" to any of my publishing places, I would
be irritated if "refs/remotes/ko/master:something" created a local
"something" branch at the desitnation, instead of erroring out.

On the other hand, I do not think I mind all that much if a src that
is a tag object to automatically go to refs/tags/ (having a tag
object in refs/remotes/** is rare enough to matter in the first
place).
