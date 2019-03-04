Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C1620248
	for <e@80x24.org>; Mon,  4 Mar 2019 11:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCDLTn (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 06:19:43 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54483 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCDLTm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 06:19:42 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so6707457itj.4
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y18prikqJXpJbS+v6J+SBKAIDOt0cvoiSS7TyVOraao=;
        b=tR8sQLWzgQWPyrtGaNFNgLxyNNb0R9zfniH1CGvCXRLHZ3sp8icgoqODO+x1uje86E
         NEfxP/cQaikyx4PRAmB7XmOLRyE0mBnVQSjYHIbiA12HIe4Q2RWW4CiXG1hHuVsfz7eW
         Kwd190kOMQOVK9mFc8JZCkvsYFj43LhsLocfE+4cVaf1AH24KDtMtGoNAMlMTv7LH+8B
         pR7VW4daqUHJjZVPxWWGrh9IpT5AdtvJyxTJxOni4KF4mJsPKC/N3PnhucIUDwveTgA3
         Pf7/sdOX4oY44VZecHJsUuokiAP2BvS1UnkjL/OVK3AAwz3gLYocV1GKyzSKlgRdg84s
         nNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y18prikqJXpJbS+v6J+SBKAIDOt0cvoiSS7TyVOraao=;
        b=SBT1ZWWK3O7L6HC7VgC2n7LwCfWTz71TdwdlwSC6U8p8y5BYeW9zxd9xAnW3ALbGHI
         zDt2QJ5A201U5Hau7t1sbU3Fw1Si+jD1UH9g1dONDImmiV1X/gJedOlE/N4JICjmSPfA
         fU14f2Pe0VR/GoaptAbIIL3FFWUIReW37jj6h8L3jE3ltA/+W8UIMZEl2UZE/v9/qHOz
         9ipmEyPiuGkzxinCqXGYSgRtwG/4zACqMiD4PODUssQ0+4Z0PJ6Rkkjg6s7xa2btqpF1
         CCCZoYI4FMKn3uSmkrTeqgYRVqWcliHH6peGmb5fqpvJcFJzXPq50UfLT+l+ydU7uEIC
         yiqg==
X-Gm-Message-State: APjAAAVEjGQDc/J4vuCTjTx2g52jeCgAKHZzOtgVldtno6Nks4ya4DXz
        CqLCEMDwycMGlsOx3dlU05hdvmDK9qLdHbINfPM=
X-Google-Smtp-Source: AHgI3IYbfJ5e62f1FORWC+381Z9A1oVME+Msi9E9wz5PbmRr8m76Ln39Mp4hFjwchfHCYhkrNQwd1yowMgx/IF25bos=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr8780246ita.10.1551698381499;
 Mon, 04 Mar 2019 03:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20190221121943.19778-1-pclouds@gmail.com> <20190226105851.32273-1-pclouds@gmail.com>
 <20190226105851.32273-2-pclouds@gmail.com> <20190227120859.GB10305@sigill.intra.peff.net>
 <CAPig+cRJZBvwsptPOzx3oPSOnt6+uGLoyOr_JbUnku4kdSwdgA@mail.gmail.com> <20190227160457.GA30817@sigill.intra.peff.net>
In-Reply-To: <20190227160457.GA30817@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 4 Mar 2019 18:19:15 +0700
Message-ID: <CACsJy8D0o6-ihNcpmfhCfQPNo-t2i=NySp65Y8h2e3md2GvXVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] worktree add: sanitize worktree names
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 11:05 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Feb 27, 2019 at 09:23:33AM -0500, Eric Sunshine wrote:
>
> > > If we just cared about saying "is this worktree name valid", I'd suggest
> > > actually constructing a sample refname with the worktree name embedded
> > > in it and feeding that to check_refname_format(). But because you want
> > > to actually sanitize, I don't think there's an easy way to reuse it.
> > >
> > > So this approach is probably the best we can do, though I do still think
> > > it's worth renaming that function (and/or putting a big warning comment
> > > in front of it).
> >
> > The above arguments seem to suggest the introduction of a companion to
> > check_refname_format() for sanitizing, perhaps named
> > sanitize_refname_format(), in ref.[hc]. The potential difficulty with
> > that is defining exactly what "sanitize" means. Will it be contextual?
> > (That is, will git-worktree have differently sanitation needs than
> > some other facility?) If so, perhaps a 'flags' argument could control
> > how sanitization is done.
>
> I agree that sanitize_refname_format() would be nice, but I'm pretty
> sure it's going to end up having to duplicate many of the rules from
> check_refname_format(). Which is ugly if the two ever get out of sync.
>
> But if we could write it in a way that keeps the actual policy logic in
> one factored-out portion, I think it would be worth doing.

I think we could make check_refname_format() returns the bad position
and several different error codes depending on context. Then
sanitize_.. can just repeatedly call check_refname_format and fix up
whatever error it reports. Performance goes straight to hell but I
don't think that's a big deal for git-worktree, and it keeps
check_refname_format() simple (relatively speaking).

The second option is make check_refname_format() call some callback
instead of returning error. This allows sanitize_ to fix up in one go
(inside the callback), but check_refname_format could be a lot uglier,
and verifying all refs (I think pack-refs does this?) could also be
slowed down.
-- 
Duy
