Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7316C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BB5233FB
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 08:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgLQI2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 03:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLQI2e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 03:28:34 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D7BC061794
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 00:27:54 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id i18so6603670ooh.5
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 00:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=e4bwZNEQUcY+C6HMpIC/sEWpUcRY54K3hiZVVKPx3g4=;
        b=ukK7jSu1mumCj0XZromWjHkhGo5TawbgzrUq5/O+uKR6guM8nkfZ7h29vNF11ddMJl
         68QRCIWI0GcYIewjP46TA8DpBTexiETEA2XbBnXMrKULsj44D7y3H9B3YUHXY3MNJ5Pl
         MWjUoW4zDBldj4R15Pbcpsa5gX0k29RxDhvARBXvRJUPos9sl5rZfWHS2H/gUpux3GNY
         o1Hu9JM8YKXqc0VUY6+akIZbSo+tFPhhigwEnM9L8EK7LlDsLifvYbxrxJ1Pg/vQNoPJ
         3nWoTJqGIAuKHZbnCukvDfg2gQXTYOPG3Ziw25bYcRIaEgD4GmkQHKn04xo7VYJrl3Ph
         uj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=e4bwZNEQUcY+C6HMpIC/sEWpUcRY54K3hiZVVKPx3g4=;
        b=s3VRqumFKcSNG81PKpHWvTgBOS8h7ezMC8sJ4oQA0IHEvrRMfwEYwKtQsVR903quAZ
         V/OspSk+kTDwYIb8WeY3Z2oXdh/EizJkvbCLV0qfyvFaRyd9Aq2iL48c3k6zGdoHMMI7
         EDyVQc3N6yeeK8yAXLARuwsz433ppvkEi5RRuxkscDi5/flQx3hWQcy0NZzBvz7ABH4w
         bxnSqVUkMbBhggGoewmbR0da5tbURdKfOIanITHZYsvuUKvQHs4dSHtXRjLM9Ly5UJWx
         1O8bDcwawjKs+t6w+2sefbbC5w6NX1PMWjYNnqNCYKqbFnr2rDFQYgRxyIwuR9eiMNr2
         n/2g==
X-Gm-Message-State: AOAM5324QD4fWIV+mTItjAkmkhOyzVEjG0i7VvBWES2mIdZP9NtLKtwP
        hgPs1TuxTNbwq+20RE/hkGQ=
X-Google-Smtp-Source: ABdhPJw59GkcrXiYHZvZBJm0OQ5g8KR/QXnUP+dOL/rw5XLLWZGOOg2NBeveg7TzFA+DLDdPEp/IcQ==
X-Received: by 2002:a4a:94e2:: with SMTP id l31mr12818813ooi.66.1608193673411;
        Thu, 17 Dec 2020 00:27:53 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v92sm1071281otb.75.2020.12.17.00.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 00:27:52 -0800 (PST)
Date:   Thu, 17 Dec 2020 02:27:51 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <5fdb1687825e9_d35b620855@natae.notmuch>
In-Reply-To: <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 17.12.20 um 06:41 schrieb Felipe Contreras:
> > Seth House wrote:
> >> I appreciate Felipe getting the discussion started.
> >>
> >> On Wed, Dec 16, 2020 at 02:24:23PM -0800, Junio C Hamano wrote:
> >>> If there is none, then what is the benefit of doing the same thing
> >>> without running 3 checkout-index?
> >>
> >> I wasn't aware of this plubming when I wrote the initial shell-script
> >> version of the technique. This is a much better approach (even *if*
> >> there's a negligible performance penalty). This nicely avoids
> >> UNIX/Windows line-ending surprises, and instead leans on
> >> already-configured Git defaults for those. Plus the non-text files
> >> benefit you mentioned is also huge.
> > 
> > I think you misunderstood.
> > 
> > This command:
> > 
> >   git checkout-index --stage 2 --temp -- poem.txt
> > 
> > Will give you *exactly* the same output as LOCAL.
> > 
> > The context is "git mergetool", not the mergetool itself.
> > 
> >>> as I understand "mergetool" is handed an
> >>> already conflicted state and asked to resolve it, it would not be
> >>> possible without at least looking at the stage #1 to recover the
> >>> base for folks who do not use diff3 style.
> >>
> >> I feel strongly that LOCAL, REMOTE, and BASE should be left intact for
> >> this reason, Also because they aid readers in understanding the
> >> pre-conflicts versions of the file.
> >>
> >> Rather mergetools (that support it) should be given the stage 1-3
> >> versions of the file in addition to the usual, unmodified, above three.
> >> Then each tool can decide whether or how to show each. Some graphical
> >> tools might be able to make effective use of all five (six?).
> > 
> > Except as you stated in your blog post, not a *single* tool does this
> > correctly using LOCAL, REMOTE, and BASE.
> > 
> >  * Araxis: a mess of changes
> >  * Beyond Compare: a mess of changes
> >  * DiffMerge: a mess of changes
> >  * kdiff3: a mess of changes
> >  * Meld: a mess of changes
> >  * Sublime Merge: displays unnecessary changes
> >  * SmartGit: ignores the other files
> >  * Fork: displays unnecessary changes
> >  * P4Merge: displays unnecessary changes
> >  * IntelliJ: a mess of changes
> >  * Tortoise Merge: uncertain
> >  * tkdiff: displays unnecessary changes
> >  * vimdiff: so, so wrong
> >  * vimdiff2: displays unnecessary changes
> >  * diffconflicts: RIGHT!
> > 
> > So all tools would benefit from the patch (except yours).
> > 
> > Which tool would be negatively affected?
> 
> Where's WinMerge in your list?

It's not my list; it's Seth's list.

> I'm mostly using WinMerge these days, and it can do what your patch
> does all by itself.

Really? Because under Wine it doesn't look like it:

 1. Before: https://snipboard.io/8JA5Oz.jpg
 2. After: https://snipboard.io/HUXnOg.jpg

> I don't know, though, whether your patch would have a negative effect
> for WinMerge.

Seems like it has a *positive* effect. Like in all mergetools.

Cheers.

-- 
Felipe Contreras
