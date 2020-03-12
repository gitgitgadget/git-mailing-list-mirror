Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA30DC1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7F120724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJYt3x+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCLV7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:59:15 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:42914 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCLV7P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:59:15 -0400
Received: by mail-ed1-f51.google.com with SMTP id n18so9409173edw.9
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Xy0VZ2arqqaQdJfN4rfe/emCp4zwLCz6nW4Rxba20E=;
        b=gJYt3x+MoWT3qIdjwMzg5fdpbPOOboj4OAU1mIROwVhHZEo/Z5NuT00xJ5Z+yHtjvP
         hkeJU0A7CVIHQhdk/BK1juNZ8H873bYoSUHTbxko4QuXEXPQiJCEWybGRXJEorKSVN8I
         +yAWMw8G7Ph8Hh4rL6WyvU2cGyhhmWTiNlEqRdZhTyv8BXQvoRODKD3X3VU+jgUKbUeR
         VPeL9r4LRYPA9XcLo4UuCEhYT7EoLf9YlFqNHGguD3fESA4qwl65Gg9Rub31/T/ypKpr
         NxTM14kvrlmcWfpoDEx4E6HTJ6hT8w1TI9u0zUEypj/viR2gCV/y35fpBThH0vbVOJ4M
         KVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Xy0VZ2arqqaQdJfN4rfe/emCp4zwLCz6nW4Rxba20E=;
        b=Gw3xxGnTZf2xi7Bok+E8myE8ZgntmAgYSjyn6+eN/1LCkchgmLitViKRHyTzFE/yaw
         /TKVA6w7nfM7ppCCn/0xvicGqY5O1045famZ5uAEBONaNNRM5dN7YuiieQT7tKoxTnyV
         Rc6aVVtfjQ2MrOrDNO5eEyLj5L7J2K8LOYPx5RE8NeRH0XCNg40A1Bgx0nRoaE9IfK4j
         FLKRF3S84WKyE/8ukuoGk56Mi5eCw8uu436dNhj/J9UADpfQv1nsrDvVcVcszxuo4o1+
         2L++mr9U66Fdb+Qs+tP//uD2LK3koqDdBG/LQ64w3kr9QuTFFjTmP8Vun3jD6AUMn+c0
         xa1Q==
X-Gm-Message-State: ANhLgQ0GzD3isq7shacgyZzQfumxtP83TARQ868lbJ85QWAQdQTLna23
        Wj4CsUeYd0D5DOQDp04uGMQy5ombXo7bmxhlqAF3RMJr
X-Google-Smtp-Source: ADFU+vt1LcrRWUG4sNTMpqdxY6nLJfLycOtTX3XiwIrXm23V2faL9woLmCZKieNb+w3R/h2ZyM+U6Ole4NwN3y4thxg=
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr10304015edv.273.1584050353584;
 Thu, 12 Mar 2020 14:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
 <20200312170714.180996-1-jonathantanmy@google.com> <20200312175151.GB120942@google.com>
 <CAP8UFD0+fyz=S_VN=EzPOOxNSNkge0uB84kEqQD_mudsFtR8Lg@mail.gmail.com>
In-Reply-To: <CAP8UFD0+fyz=S_VN=EzPOOxNSNkge0uB84kEqQD_mudsFtR8Lg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 Mar 2020 22:59:02 +0100
Message-ID: <CAP8UFD1LibB=BBhhAvVENCrZy52vUMDNnY04Hvkh=OJtzhQpNw@mail.gmail.com>
Subject: Re: [Question] Is extensions.partialClone defunct?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 10:54 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Mar 12, 2020 at 6:51 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> > Jonathan Tan wrote:
> > > Derrick Stolee wrote:
> >
> > >> but it appears that we rely on the "remote.<name>.promisor = true"
> > >> setting instead of this extension.
> > >
> > > Hmm...besides giving the name of the promisor remote, the
> > > extensions.partialClone setting is there to prevent old versions of Git
> > > (that do not know this extension) from manipulating the repo.
>
> That could be true of "remote.<name>.promisor = true".

I mean for future versions, not for old versions.
