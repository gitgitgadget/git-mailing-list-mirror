Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4EDC35640
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212D8222C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCC4ScrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbgBUIjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:39:45 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:35686 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbgBUIjp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 03:39:45 -0500
Received: by mail-lf1-f45.google.com with SMTP id l16so892900lfg.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 00:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9qd+7IBmXQDzVpvjOQpWKvXmf5gaIUynpEBILUI9Xu4=;
        b=iCC4ScrQsgLaJHHzF2IFeCFKRmB1Ey6BqO3t9/JwxUK/022kG0o6XGqTwrrpa8Oz1O
         0tK6Lc/L0JiKRpW8VgB1QweI811R4hHbljNyWHiWGF3my0xIxc6gUBOz8qyVEg60oQie
         D0P7eB2WkWtB3tC3Aeo93jk9TLD85aW5Sklo6250t1HA0pJVNoacVTLEMSDy16Soj04i
         X962XA0Qik822N+kqvPXyZzndQToObvEltmYSMnE8V9RYEN+M/zof8ZdOmmIR6LQyWRl
         QN0XOoVV6YyvUE5HWf/oCu973Wjvk/Zjh98SKWAxChJwIO7Leiw4m1Md7TZgoEJlVjUu
         o6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9qd+7IBmXQDzVpvjOQpWKvXmf5gaIUynpEBILUI9Xu4=;
        b=rQzNj9IKwYK99BGNSjqVWWQVfg/+L5AD6sg7lar4hE72xIX6HX/cK2W69C3Tfwdkv1
         BMUzNsPD7kntxN+SGHmoGMpBGk2goapBBFY9dkr7qjJx4JlJIaak1yn73CTCyK9at+mb
         HTkDaynHEf7Wh82aWqpxU9I8vb79kwgQx/hSND1KK9ASiTWBX1wf/CFGLm89fO1QeRKT
         8XEZ+6vnpJIsUyPppfyruj8tsJsXoLU17MsbAOGdnI/nr6qr9HpgxoLzJIbz/SqO2RDy
         CwBY0t4ES2LJkSHt+F+JUWuT/qC3uR1whJoiiBZ9Hd0xUIgPrM5nmwUeJJt+XH3my+OC
         AdmQ==
X-Gm-Message-State: APjAAAWRY5zop9qMfLNV/IwzNVTp0kMHwaYDjk6aC9Ti9EAUSnL9E7aM
        p1OZU8NAgR48NjujbRRe0cdamBqjOBtmMUAoFPElOC+x
X-Google-Smtp-Source: APXvYqycN/Yh6JsMN8XX8yxC6mCzk9hqz5OmKBP0ngq6nBFBtCn3wK4tzAS2hXGUekS1u48fRhkrsXEbv2lZdD/zeIw=
X-Received: by 2002:a19:5014:: with SMTP id e20mr18800994lfb.3.1582274382855;
 Fri, 21 Feb 2020 00:39:42 -0800 (PST)
MIME-Version: 1.0
From:   Kevin Swinton <kevin.swinton@gmail.com>
Date:   Fri, 21 Feb 2020 08:39:31 +0000
Message-ID: <CAEwB0hh_Kifi4G6zqFJhM0aGzm+FqftvnavMkKqoxFph80PTjg@mail.gmail.com>
Subject: git - file types / metadata
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

Currently converting git (using libgit2) to run on the RISC OS
operating system. There's one specific requirement this OS provides
that, after discussion with the libgit2 folk, I'd be grateful for your
expertise and experience on:

The RISC OS filesystem is not Unix-like. It doesn't use file
extensions like ".txt", but instead associates a 12-bit file type with
each file, to identify what sort of file it is (e.g. 0xfff=text file)

So the filemode value in a tree entry doesn't really apply. I can see
libgit2 uses a uint16_t to store this, and it appears to be written
into the object database in text form, so for a normal file in a tree
object, if I dump it on-screen I see this ASCII sequence: 100644.

Here's the thought: could git introduce some form of "custom" filemode
identifier? For example, a value of 017xxxx could be used to indicate
to git that it's to be treated the same as 0100644, but that those
bottom 12 bits of the filemode could be interpreted differently (in
this case with RISC OS it would actually provide exactly what's
needed).

(Feedback from libgit2 folk is that in future some kind of file
metadata ability - more general than this - could have other uses.)

Any thoughts/feedback/clarity on git policy, appreciated

regards

Kevin Swinton
