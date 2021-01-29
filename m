Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F2C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A0564DE9
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhA2WLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhA2WLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 17:11:05 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343EDC061573
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 14:10:25 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id a1so5212312qvd.13
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 14:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=amWwtxq7pUEqznR6ETSHCAiG5WYHGJIdx075Fio2uTs=;
        b=acaXKYlVm5eXNdnevQAzD4YYQUxtdwNVVlcElXRld2U4FZLqpfn/I7iQXWTF+Wj5EV
         rsFfHwSzjDmHdLq/g/1ZJutAHB9TH2exkx6jKDlZnLiuKDw0iZ15FT9mczJ55Sl9p0YO
         X5KTU0WCNks6ROHtfjrH41g5IaEsr4mXST3psXgcyKSPBWm5s/fbSh42R35jxJdQG2lj
         IQljrK5g3Sn9yX7meJLTudswhai7TQ9BhDQR+XlOiEN2y3rQE5DEL+vk2xGHdiwWgZm0
         j0IQYXWDsZ53Xvr2oVhZxKbyTZHe+dib4m3wb3MVtiqQyHYJ62cMAab83Fc6mjNEq9N7
         genA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amWwtxq7pUEqznR6ETSHCAiG5WYHGJIdx075Fio2uTs=;
        b=Cj8nHyFZFgbbColT7e+9ko0E0UsCr4fLiFEae80I5QVhrKkNVJvBPDEbiw8QEsmrMB
         eFCbWg2quZiTWujrrKFytwAh5q+ETt7YIzSOxTznOEIJ6AQKRTO8x8YYCDzwvCq7H2KN
         2doZFQuwhup7bwCnsRQVBKpr8AOWOleOakifbsxJkmMhi1+UIcEv9jPyMDL4GF2dLW31
         XWZ4+m5dUxbnL349MQyxt3CMksW9ZDSYfI4DUswZYd8KgM7H8l3o3gd4h2Uso654tuv1
         vNSVch6aRsCkZ5+apQ+wEKOf1VBB9jQtZSQjh9vUbWrKxh4SF+GY+2aFbdr6lr8uV7mb
         PMhA==
X-Gm-Message-State: AOAM531phwQgBG91rHev7vsT4rW67tiQ/N9jWzKHJd2rNO+7+6LPckn1
        25xIIFxbsMLAW+pFJyqALAJgMxqj7EzDtA==
X-Google-Smtp-Source: ABdhPJx4K8vBmUGHPM6uEX8WtMjhjjyi7Z9J0oIV3LbeFWEbr54vMXTcxhTr00vYzdZc5fKckukEQQ==
X-Received: by 2002:a05:6214:14e2:: with SMTP id k2mr5921079qvw.24.1611958224460;
        Fri, 29 Jan 2021 14:10:24 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f05a:e493:9aaa:4c8c])
        by smtp.gmail.com with ESMTPSA id a2sm6899314qka.11.2021.01.29.14.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:10:23 -0800 (PST)
Date:   Fri, 29 Jan 2021 17:10:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBSHzG9T72nYYVt4@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
 <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
 <YBRprCmIX4IrHAi0@nand.local>
 <YBRvQdHoslnF0OXr@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBRvQdHoslnF0OXr@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 03:25:37PM -0500, Jeff King wrote:
> So it may be reasonable to go that direction, which is really defining a
> totally separate strategy from git-gc's "repack, and occasionally
> objects age out". Especially if we find that the
> assume-kept-packs-closed route is too risky (i.e., has too many cases
> where it's possible to cause corruption if our assumptions isn't met).

Yeah, this whole conversation has made me very nervous about using
reachability. Fundamentally, this isn't about reachability at all. The
operation is as simple as telling pack-objects a list of packs that you
do and don't want objects from, making a new pack out of that, and then
optionally dropping the packs that you rolled up.

So, I think that teaching pack-objects a way to understand a caller that
says "include objects from packs X, Y, and Z, but not if they appear in
packs A, B, or C, and also pull in any loose objects" is the best way
forward here.

Of course, you're going to be dragging along unreachable objects until
you decide to do a full repack, but I'm OK with that since we wouldn't
expect anybody to be solely relying on geometric repacks without
occasionally running 'git repack -ad'.

Junio: I don't think that you have picked this up yet, but please avoid
doing so for now, and I'll send a new series that goes in the direction
I outlined above.

Thanks,
Taylor
