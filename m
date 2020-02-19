Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075FCC34031
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 01:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B173924654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 01:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVzzrMMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBSBnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:43:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41590 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgBSBnj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 20:43:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so25269782ljc.8
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 17:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EvfXbBBFwAUoqmWfPe+IVzf0eX7eAzbGs1zZ25Lcx8=;
        b=EVzzrMMlXHBsC9HYAjuki1HAZ/+MD2JOfCV+MTtJdUvUxBS0fVnrbdAe8CLrVMB4n/
         ms//CSvIAHhnfXaWtuBZNQIO1HepxQfq9HmvNxjpA6sWU85IupahULAbulEmJWhJoisZ
         YipfOsmk2Hk3w/Ps/4QtLrdfWe97zVFbcfILNqzawekg3UIp4LCADvv7XiJHJshdlChl
         yiy5aQ0fQ2vbzDVnSoS0MtaGS5wGmnB2+2pJXAdL76hRFWw9p4cnv339kePU8cmp5E5Z
         QcNnzqeKxERLKecK594uWgPdvolQLH75GZFH4VHi1NF1DQykMke/pufDrwG+X9P+xsWH
         523w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EvfXbBBFwAUoqmWfPe+IVzf0eX7eAzbGs1zZ25Lcx8=;
        b=dbOi9EniRNLihhna3XuWqjQTdPzjPlU7+6clenMp0rtzllclb5G3EMm+AlQTYqDNAj
         z3OdSgrrt9FhgIBTahEpySnaZULiC+0mc/pw2IamVNBFSiiqiAwPY5X/k8wzysfXq4ir
         EcYkvNOApSpbHjVH1AU2ViYJkCpn14BzJFvoGntbsgd5Ka0cMZ+0SyofrmnJxFTKpZev
         ftZfLz9oDUANolV4TWqryOdqisqJbiO52UM84Qh5DQZfFH7GWVXDHW45KuFmMbOsuwoP
         RxIBB7J7/YW5iTlvtHI7+wZVrMXYV1X3Tn95kBRIHVWXYr8rUWqxj7zlXtcZI18xIokn
         XtCg==
X-Gm-Message-State: APjAAAVNJpfVjOW0HkYfnHUti3uhlwZapx1XUmDqwOfZp0HYvCjPbojo
        vhpd48+obGg5PAOMdiw39ci4e5kPwR1e2LZGMuY=
X-Google-Smtp-Source: APXvYqwTOhVmVZ8yPxCCRXJ08HBY17uT1EncQ+77LpjZELfLcTXrphCzgLYiSQ2etURRpJEwm1Pt7VCyGf+w2ou9G4w=
X-Received: by 2002:a2e:1459:: with SMTP id 25mr14852212lju.189.1582076616957;
 Tue, 18 Feb 2020 17:43:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHk66fskrfcJ0YFDhfimVBTJZB4um7r=GdQuM8heJdZtF8D7UQ@mail.gmail.com>
 <xmqq36b7k4i6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36b7k4i6.fsf@gitster-ct.c.googlers.com>
From:   Robear Selwans <rwagih.rw@gmail.com>
Date:   Wed, 19 Feb 2020 03:43:26 +0200
Message-ID: <CALH1-Xr3HVZzDn2-9EvmdiBWmxWQ-zfExM2LNJyR1wR+dgxRSQ@mail.gmail.com>
Subject: Re: [GSoC][RFC][PATCH 2/2] STRBUF_INIT_CONST: Adapting strbuf_* functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Pratik Karki <predatoramigo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 10:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> >> STRBUF_INIT_CONST: a new way to initialize strbuf
> > Use imperative mood and be more specific in the commit title -
> > `strbuf: Teach strbuf to initialize immutable strings`
> s/T/t/;
I don't get what you mean by that.

> Also, isn't "if (sb->alloc < sb->len)" too loose a check for the new
> feature?  AFAICS in 1/2, a strbuf that is still borrowing a const
> string always has sb->alloc==0.  Other instances of strbuf that
> happens to satisify the above condition, e.g. (sb->len == 5 &&
> sb->alloc == 1), is an error.  If we are to check the condition
> about sb->len, shouldn't we diagnose such a case as an error, no?
AFAIK after reading the documentation for `strbuf`, there is no other
case where `sb->len > sb->alloc` as `alloc` needs to always be more
than `len`. I'd like to be corrected if mistaken, though.

> As Peff, I am a bit hesitant about leaving a strbuf that hasn't been
> made mutable around, though.
Yeah, I started to get that when I read Peff's reply. I think I'll go with
the approach that Peff suggested, where the constant string is
copied to a stack array and so is made mutable to a degree. Since
this is a different way, I guess I'll make that from scratch instead of
editing the existing one.
