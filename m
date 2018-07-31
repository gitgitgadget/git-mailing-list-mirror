Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DAE41F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbeGaUyq (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 16:54:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32824 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbeGaUyq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 16:54:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so11823481wmh.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pXbIBC86FG5UOsqljHLZUvPhKkhh26eonIVLOMJ+DqI=;
        b=MMYclhVfktqUbbIcu90sSOCLEaHtT0er3rnymhtJRrVMKKx7MJBRA845PGg52VMfA5
         l7jYqIxM+CJH00u8iJu03CaBZSnSkh9OtBss561qIuKy4k8hnoW3h5rr7SYVi4re68uv
         StO2gWMk3DJoYnTPhS1/Y5gsVav/Q+yfVaU/PADcm2rNVuafrMbs4FsYjMWqQj0u5GNN
         yjL3wmI2oabRBp6nuwAeic3CB+NaCnW053nKNla8SYNjlbWRlSy8KxbfukoNZUrqtHHO
         VfkfBFnUUBOvDjpat4C9LBUdq33soBDe/wdSKhEGRWbXqPpd+HA2xnN8JZRLfqS2J53f
         AIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pXbIBC86FG5UOsqljHLZUvPhKkhh26eonIVLOMJ+DqI=;
        b=NIOnM/zpCh+YAHRXLWni/nzucNv2q9+kepr2EPoiCl7vVTxPxrmiHlS/FnmQXpQuPX
         Iizk5qyBBz14WTAFUetFnVojn3MUCLhta+2x9s0kcPExvtXcie6oGeqiPcPR6gEFeb8y
         NB5y/F+UoKWq++mCUtTa/aR9gCnXxKzshn1NfE9RU0oXi0pDwIpfk3VB0rXPSSG4zn2W
         iCtfbsUh4FPQ0tAhbW120PXuNufWswq5rxobf1RyA8Xc6lLyMZPT4bVI7EBTja+suhd7
         L6WawhLyu9paSbJbR3jhXlDd5DgPMv+1tOxjgFv8XHIWLBaix0+v0Q+cr2z31y+RjzWg
         F+/Q==
X-Gm-Message-State: AOUpUlGJdyAS2LV1pBPSvvB/TXSr0zs9UJ9XPpc9ROdey2WaxqLp2ytr
        eB/KiLPVDI4Xk1sCvBfy7411R4fE
X-Google-Smtp-Source: AAOMgpfnc/hvfWnWdzNeXxcFpI56myGcke63xrkeQEhRhcdfE7BCx3G8ZY197dI9buBOh/tcmdX80A==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26-v6mr632695wmh.61.1533064379591;
        Tue, 31 Jul 2018 12:12:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q8-v6sm22603975wrj.97.2018.07.31.12.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:12:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
References: <20180729092759.GA14484@sigill.intra.peff.net>
        <20180730152756.15012-1-pclouds@gmail.com>
        <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
Date:   Tue, 31 Jul 2018 12:12:58 -0700
In-Reply-To: <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 31 Jul 2018 11:44:27 -0700")
Message-ID: <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Is it worth attempting to also warn about paths that only differ in
> UTF-normalization on relevant MacOS systems?

I hate to bring up a totally different approach this late in the
party, but I wonder if it makes more sense to take advantage of
"clone" being a command that starts from an empty working tree.

builtin/clone.c::checkout() drives a single-tree unpack_trees(),
using oneway_merge() as its callback and at the end, eventually
unpack_trees.c:check_updates() will call into checkout_entry()
to perform the usual "unlink and then create" dance.

I wonder if it makes sense to introduce a new option to tell the
machinery to report when the final checkout_entry() notices that it
needed to remove the working tree file to make room (perhaps that
bit would go in "struct unpack_trees_options").  In the initial
checkout codepath for a freshly cloned repository, that would only
happen when your tree has two (or more) paths that gets smashed
by case insensitive or UTF-normalizing filesystem, and the code we
would maintain do not have to care how exactly the filesystem
collapses two (or more) paths if we go that way.  We only need to
report "we tried to check out X but it seems your filesystem equates
something else that is also in the project to X".



