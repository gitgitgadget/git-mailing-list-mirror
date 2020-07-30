Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ADBC433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00C22072A
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596069861;
	bh=fOTuStNJSVn/blVFte0+p25XyVA75JSn5JocJIMSrsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sZ7K3CzPxbp6v8bMeG2QqvGXhn0tJKT6f0D9+zlMDIP9BoytSy59oYsv2+cfCseCC
	 4o3mOHwG7x0YrPLgl4/sQEtzOvv8/zF40KmGS8lBWX8u8Hikc5b7Z05adfg/U9JJWi
	 I9NqNXWSn2Wdj0M/6k40kLP/vf6Qk7FQjQtrGp+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgG3AoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgG3AoU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:44:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCDEC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:44:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h8so14005219lfp.9
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VzUipUD+ZfCAM40gLa775TRCXa9zhUfwrf2xbknByU=;
        b=T0i4sxz9xoflAlleM6Igqs1aW3x5jb3qwzBL/c2AvyG/FZOcS3ERi/KElZs0OjRuF+
         +0x6MZ3iIw+Pp2KTOPn+BEPHsNQlNbKg21fxTahpbnTSlZ5P8EPGrfM4mKwyHLMiVhtP
         Wtbxe+MxKzlZ60jHcNgRyTJgguoP7l378Uy8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VzUipUD+ZfCAM40gLa775TRCXa9zhUfwrf2xbknByU=;
        b=J8Hie+xXeuH1EIGWCZdLfVae18PaelazTQzBwaokAdbJfhOFBdqyAd7uHRG4vbTEyT
         swBzpAS/zo0Wyna8hwoumNIESc3luKivLC1rvyWV9rfe0RxVqRVi2VqUXmjWV658B0pP
         qQvdlf7S/9zeDjoRh5oSLTxUqV426qxtn3WX4HQeW4BLvkZ51ZSqJf9Mp9q0WrF7nrC0
         g8n0p52q6ZePj277AgH2yXcRdMiAGTcILjvKCn/8rYSUbxoHc+c/5uiWDUtD2iJJj4zB
         t7dntVp6WLnIxoJNs9zNTfTqypobso9RHl/ZOOQ3TxDrrZYtdJY9fA1+k3GCmkvjwGIw
         AaBQ==
X-Gm-Message-State: AOAM530ufE4tvadyfFC6ZgT/BcFByYaWsLbFP6Gx6k5DpFSQalnOzgyB
        DzwVjcJlkSkoe/KHYZ9URdMEEFX/N2s=
X-Google-Smtp-Source: ABdhPJz9x6b5sDrElJLPj3KJ6HDAIpEQlIEeFvBzHiKG5LXYLaM+4HewRK3T6MaIEoT2y3eo65/emA==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr283361lfl.176.1596069857500;
        Wed, 29 Jul 2020 17:44:17 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id h18sm687889ljk.7.2020.07.29.17.44.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 17:44:16 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id t23so3505412ljc.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:44:16 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr218186ljf.285.1596069856206;
 Wed, 29 Jul 2020 17:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com> <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net> <CAHk-=wg7r=y_tYpWuRwNFP0JU5D4g=UN1puCzkvQP4bey0-Hmw@mail.gmail.com>
 <20200730002944.GB2996059@coredump.intra.peff.net>
In-Reply-To: <20200730002944.GB2996059@coredump.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 17:44:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdKi+Mhq3TKVKLKTm0RBxjHpg7C2co8xRnvPuV5sgJUw@mail.gmail.com>
Message-ID: <CAHk-=wgdKi+Mhq3TKVKLKTm0RBxjHpg7C2co8xRnvPuV5sgJUw@mail.gmail.com>
Subject: Re: Avoiding 'master' nomenclature
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 5:29 PM Jeff King <peff@peff.net> wrote:
>
> This is an interesting middle ground. I'm a little iffy on it just
> because it complicates the very simple case of "should I mention the
> destination branch",

No, you're absolutely right. After sending that message I went and
looked at how nasty it would be, and it's not worth it.

If we were doing perl or shell or whatever (like the original scripts
were), it would have been trivial. But as things are now, I'll retract
that idea as being overly complicated.

It would solve my "rewrite repo name" thing, but I've solved that with
a hook, and it's a bit hacky, but it's not horrendous or wrong. As you
say, hooks are for special cases, and that hostname rewriting I do is
very much a special case.

             Linus
