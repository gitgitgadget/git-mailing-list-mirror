Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE1120A40
	for <e@80x24.org>; Wed, 22 Nov 2017 17:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbdKVRpo (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:45:44 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:44920 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdKVRpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:45:43 -0500
Received: by mail-lf0-f47.google.com with SMTP id w23so19147266lfd.11
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MiEoLWoCIUPUYAWNPI3IJKkkSZz/xt95mIKsraTRZvc=;
        b=ZDICLOcX8+pmHEIThdytJPsL5gv+O4Mg3zGyLUtIjP5lq1h/oA6gIBAkBJILpdGV+6
         jVpexL3MzXy8Umzi/QSv2h4mR3yKQ/UA69PWqNeUXwQd5KJip/pPW/1BXMPoZm4VtMiY
         bm/Fty9l9uW9x0ueSF6sdd2v5sUwEH/pwglI8Cpe140dAXb4JFiqu2FTbZuPE6elMytZ
         1KErWB8hiJGy8tQH2xBcNwOxVo+zxbcqsopcYKPqNUNEHJNV07/Zy256k1rEKxgrTGp7
         m2gPkbSLoGxpqSuZw+qgmebs5eqbR5EfCCnAE9JS4cDebVcRTiKxSLDFLfmgL6qKSyve
         TyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MiEoLWoCIUPUYAWNPI3IJKkkSZz/xt95mIKsraTRZvc=;
        b=RK+bgMS9cKlJvlXRRTLC4YLNn8lMKUKfT3HSjsaGrdurjxYdWydn62vyeoWI5PGwA8
         rXsXAk/gwCXgvLxW9rLyLGb8mxlEwo+loYE0qe5dQhBygVocBBcCDM5Mv89vQzbNASLM
         PZwpAwdwcFmOb2XxglXvZJM5sZKnPizc2dvcHdyhYkJPapGhAjjRRaa0jUd+qd+mPNXm
         G3Rt6bO5cCMM6fJP1HTxt65BhDCVutGk9u9dVZ8XklDhwdf3pMJhstYRRa6mixjGGlXp
         5s+il83lxmGM8Iktwd0w5fzrUJa7f4pxPqLz9ex5NpC3kwrnk0OOeFMn9xQw6QVnxUGV
         aXpQ==
X-Gm-Message-State: AJaThX7t+C1dTWEpdx3eXFH337Fi+GpjTwlx/17ME5w7wryhnEVQsjf5
        tD3lzGgZrdWSNY+gNCSy+MUJvYCxO4lDoE9QZhzsHip5
X-Google-Smtp-Source: AGs4zMaI3T9juYfu5yCrtSUJjnn1ika8al3zYvWdEdW5Q9P6WUJg7w1WJU9QZ2Zn5sohAGXjpLwBycTpwd0QBxfGZ6k=
X-Received: by 10.46.5.12 with SMTP id 12mr7416905ljf.116.1511372741879; Wed,
 22 Nov 2017 09:45:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.179.22.16 with HTTP; Wed, 22 Nov 2017 09:45:21 -0800 (PST)
In-Reply-To: <xmqqk1yiu9fo.fsf@gitster.mtv.corp.google.com>
References: <20171121234336.10209-1-phil.hord@gmail.com> <xmqqbmjuvrab.fsf@gitster.mtv.corp.google.com>
 <xmqqk1yiu9fo.fsf@gitster.mtv.corp.google.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Wed, 22 Nov 2017 09:45:21 -0800
Message-ID: <CABURp0rNfdXaXH-meRvM+mjf+ucHKfePjDU7ZGKt0ug3wOanhA@mail.gmail.com>
Subject: Re: [PATCH] defer expensive load_ref_decorations until needed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> I am not sure if "maybe_" is a good name here, though.  If anything,
> you are making the semantics of "load_ref_decorations()" to "maybe"
> (but I do not suggest renaming that one).
>
> How about calling it to load_ref_decorations_lazily() or something?

I groped about for something conventional, but "..._gently" didn't fit
the bill, so I went with "maybe".  I like "lazily" better for this
case. I will change it for v2.

>> Other than that, I like what this patch attempts to do.  A nicely
>> identified low-hanging fruit ;-).
>
> Having said that, this will have a bad interaction with another
> topic in flight: <20171121213341.13939-1-rafa.almas@gmail.com>
>
> Perhaps this should wait until the other topic lands and stabilizes.
> We'd need to rethink if the approach taken by this patch, i.e. to
> still pass the info to load() but holding onto it until the time
> lazy_load() actually uses it, is a sensible way forward, or we would
> want to change the calling convention to help making it easier to
> implement the lazy loading.

I noticed that after just after cleaning this one up, but didn't look
closely yet.  I'll hold this in my local queue until ra lands.

P
