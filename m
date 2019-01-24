Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8891F453
	for <e@80x24.org>; Thu, 24 Jan 2019 20:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfAXUG4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:06:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39555 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfAXTaX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:30:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so4291717wmi.4
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d2Gp/0oR7cjpvMn+02NmxEr2tgl+J7DAUal1Ey6Xajc=;
        b=KXmYCUQ01DA17tQJS+KXF15YujrsYxlGAQS3E0KmF07fIkrtwgq+7+VBQZ6lgyi7VC
         avM2NVDcH3Sv0QkM05rOzFLr/oOhaPA0svc/xJHe1usV6mLDrjW21IdWHmZK0AbKzCiV
         hruZxMQk5o2SZfotG2QIzN88sVKGDmwe5PHVUPKjQQRtlkm9e+zkIyDMkb4MKdm83LkJ
         Qvp4wwsoeIRoWBdQbW1fKc6N7kC6Dm8LQC1L2+ibvQHAxCysidK5QtlKYnvgqaz5ulss
         kH3gYgwdBmFt7mkaO6x0mmqwanP8MpRvHDn1xee06ymFoKNIFwwFsbcPZ0apgMMWhORP
         tsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d2Gp/0oR7cjpvMn+02NmxEr2tgl+J7DAUal1Ey6Xajc=;
        b=lnf7I7dkkb5mpiRrf/xHYaO2FynmCnRpGnDEtBEk/SeCDOUrgVvPI8q4UiwRJM4/iC
         eLhrebdDPDp661f1eBh8dwAwgmCKsQIj+1c8DL5W1aQzfE/l3c6SwCsdNINGZxUsG1ag
         x/mqBILM3SmQ/w7pJZqxBwkkwG491fJzbWA4AjDfuWqK3HLhzNEc23Tdmd6lk9IBiixf
         z0WbFnKveLRYVMaFqvVwAH3cm6qptgeT6HmOsrdxezcMK7t6qzdNEQHOE7nXMFHHvEA7
         0pI1+Y/hTr3oR/X8PON1xETMNxZwnrR14NNrriCd5NJHlvsb3ExZ1N4tR1S2YvMBv67R
         2bYg==
X-Gm-Message-State: AJcUukfXGDGgje9g5SMfTE7a8LCUi0OGtnrc4BXAGCGGgZWodJaI42J5
        OARRNXkn+p2b4EF7oKFNMCOVneIb
X-Google-Smtp-Source: ALg8bN4GUu63karwfAmM4jmd1v9+7rRXBHXK8NRUNhL37Vwi7lhodjtuOtZqhiZ8EqyY7WF+5oDrew==
X-Received: by 2002:a1c:6489:: with SMTP id y131mr3938938wmb.34.1548358221672;
        Thu, 24 Jan 2019 11:30:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c8sm85500242wrx.42.2019.01.24.11.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 11:30:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
References: <20190122232301.95971-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190122232301.95971-2-nbelakovski@gmail.com>
        <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
        <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
        <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
        <20190124183235.GA16580@sigill.intra.peff.net>
Date:   Thu, 24 Jan 2019 11:30:20 -0800
In-Reply-To: <20190124183235.GA16580@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 Jan 2019 13:32:35 -0500")
Message-ID: <xmqqd0olj1kj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> What if you have other atoms that need worktrees? E.g., does
> %(worktreepath:foo) use the same used_atom slot? What if we have another
> worktree-related atom?
> ...
> And that one is a good example where we _do_ need the global, because we
> already have multiple atoms pulling from it.

I guess that we broke the original atom design by mistake when we
added ":<modifiers>" support.  There should have been one layer of
indirection that binds the instances of the same atom with different
modifiers together---I agree with you that we cannot avoid globals
without fixing that mistake first.

Thanks.
