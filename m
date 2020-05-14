Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B938C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5B820709
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="1gwnVF2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgENWpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 18:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728229AbgENWpL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 18:45:11 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B65C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 15:45:11 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k18so662435ion.0
        for <git@vger.kernel.org>; Thu, 14 May 2020 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=updI4Oi+IY6X96qXaXL6/Wnt3GSMnNrXi9jUojhD6yk=;
        b=1gwnVF2besGjwviOyUOw74RQbt504qmsDGoC903Z9+lksVVzAeZXZzOfHicC8j7VON
         5GzZcSRjONR+4TUYr2KNERY9LeLQvXsNwOevei7a2vk8uiieEVSBsSWmJl1x1aHgDowQ
         FpO5ganW8iMe/WgFdycS99dLb6WucdKJRUZGnD64oRXwV8q9OU1EGvj4yIqg3S8OOrP3
         iui4nSshXiIcVJSFR+vxW+WQCIPR41nks1EH77v1AM/M59hLhFvIGlcM06cDGeAF4FjD
         QlcRLLhZoHvwCeX+59exhESIkjvtpWrcKgr3C1zgq444yqwfXXK+D0f/UdukUCsJzcIB
         Lzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=updI4Oi+IY6X96qXaXL6/Wnt3GSMnNrXi9jUojhD6yk=;
        b=GWSe7keOg5Kv32UOx0IyUO9/0pM97Pjboow7fLWA2l1ce1FU6J5SLMIdQOtUFp1AgD
         kvFqsUKYVv3coUpSgQnYGtbySqMKHh32RA+sSsWRLf4fJg3Qzj+kJeSbw6qd1nf+Ouwl
         LlpgqkVGAhLaOrOGzC9z2SxrlHCyjA9CKtjJbT4c7oXPHror9PRFsMbn+wyxVjjnP9Jx
         /vxla5HQXB6D/hZERjZj99F4hYi0x7H0TwGLJ2CH6LzQz80e1KhmlqLrKWE8bw36dlWM
         SFjKl32C0R/5SPhJiwLLxm/Cs2utw2y53nPRzz0JEv3IRJKwoQG+hHew6Ijk1xs97Or1
         KH3g==
X-Gm-Message-State: AOAM533muFPkhV/EG7vCvl6JXD3Ep4cR3u0YLHnc46tD/aLsFgW/FJeF
        CTzwU2KDuwM4OOFSBtiwbdJJFQtnlmeOff4qaDp2I3m+Rvc=
X-Google-Smtp-Source: ABdhPJwOxbl80KMER8DmlsCE3t8w8Pi0huhIHJJC5m1WIS+wxDwN/+OatW2SWbZ7TuWTzhPQzOrx7YEN70rIqL4roRs=
X-Received: by 2002:a5d:8b8e:: with SMTP id p14mr374266iol.110.1589496310914;
 Thu, 14 May 2020 15:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local> <20200514210501.GY1596452@mit.edu>
 <CAGjfG9bsQh2C6WP242v4LoiaSdghZDPuqns0VO82Txe-V54_KA@mail.gmail.com>
 <xmqqmu6ap4dw.fsf@gitster.c.googlers.com> <CAGjfG9akT+KG-tttRWEX_ZqxrqPoY_4Ed7Pymt4DkV5Rgc1CEA@mail.gmail.com>
In-Reply-To: <CAGjfG9akT+KG-tttRWEX_ZqxrqPoY_4Ed7Pymt4DkV5Rgc1CEA@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 14 May 2020 15:44:59 -0700
Message-ID: <CAGyf7-Fvyes2AwPhqAz=GhpDb=P664DLpK+4o3-ChKyR5KmJQw@mail.gmail.com>
Subject: Re: Add a "Flattened Cache" to `git --clone`?
To:     Caleb Gray <hey@calebgray.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 3:05 PM Caleb Gray <hey@calebgray.com> wrote:
>
> Actually those are the steps that I'm explicitly hoping can be
> skipped, both on server and client, after the first successful clone
> request transaction. The cache itself would be of the end resulting
> `.git` directory (client side)... unless I have misconceptions about
> the complexity of reproducing what ends up on the client side from the
> server side... I figured the shared library probably offers endpoints
> for the information I'd need to achieve that.

I don't know that such an approach would ever get accepted. At most it
could only be a partial replica of a `.get` directory. For example,
including `.git/config` or `.git/hooks` carries some heavy security
considerations that make it very unlikely such a change would get
accepted. When you pare down the things from the `.git` directory that
can reasonably be included, I suspect you're pretty much going to be
left with `.git/objects/pack/pack-<something>.pack`, and perhaps
`.git/packed-refs` (although the ref negotiations the client needs to
do in order to even request a pack means you're unlikely to actually
_benefit_ from including `packed-refs`).

For such client-side caching, really you may be better of not trying
to reinvent the wheel and instead, as others have suggested, simply
use `git clone --reference` (possibly plus `--dissociate` if you don't
want any long-term connection between clones) to allow `git clone` to
reference all the objects you have available locally to skip most of
the pack transfer. If you do this, then `git clone` can _already_ make
use of local `idx` files, in addition to packs, to save work.

Bryan Turner
