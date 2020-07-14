Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A0EC433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 03:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2135A2075D
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 03:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A69nwOo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGNDKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGNDKU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 23:10:20 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC18C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 20:10:20 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id m8so6837560qvk.7
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 20:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AQx22NGYps57Nhw98UoXXVvwe4pwjd31ueYfYgyr2p0=;
        b=A69nwOo/dvJeM5YExOp1eJKJu1R+qbrus9KYHkIjJT/kY9n1i2S2FMmLa0qGqYg5YJ
         c8A5G/ojIGrj07N8Ctgk2k1M+Yh08+zoSy/oQeABC6ebMfJ4fdEbHPPyZPg5An1wEgkR
         eX5CGaolzYnHxu05TahkR0m8lrMDTVpftgv9QQUOgZCC6W2P+G7vR2X7jWOYt3CUHshE
         eQR0U/U99U/A7QTqUVMVR7RDpcnFm68ObihecXebu31GykgH9DFj/wZ8iydWrRQZP2Nk
         n3zI3RRl57Z8torn4OseNGn44IJqo0TkTT+e/uER+z64AnR2YOvJQ0AuRbUugOxIsvwE
         qrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AQx22NGYps57Nhw98UoXXVvwe4pwjd31ueYfYgyr2p0=;
        b=ZHrlQ7eM9iVg39UYeS8Ev6Fx6nIUumXXwv+iuhAcqkR3uz68NM3PS347ytX10hI3yU
         1mw0mYFDj/xHWzS+FGAhDPRTZwVGZ547qRCtMDD9Dh+VcF63c76XSoe5dTuK0CLxmy/Z
         8qIYYi8ieoJL9lfxuVySbusPP3s1AdzggEJWpzrDQuOqVDbUiSXosbmkVd0vkqEE0zXb
         33skoCiSb3loU3ICfvS6eVPwVHidUGVmnUwwcZX6sLOIFP7rfLQsWahYcczniXjkCYvn
         41+8qzisFTZOZq5PlLUuzWMpxnhclXQSC6hMlTWdfYaDbSU2oX+11/fTMHlPdCXfE08F
         /NNA==
X-Gm-Message-State: AOAM532q9tp4LLA5mxBd4j7gICro2yKyi/mGIgU9zuV8EmRqklaMb9tw
        CKk9C2P8v6oZTtIx97JewSU=
X-Google-Smtp-Source: ABdhPJxYCEGWKeR5LVtlpXyauf4SoekJarRME5QwR9wKr4PC/mM+OHU+JWUurczB5LhDCcgWk+WV6g==
X-Received: by 2002:a0c:db8a:: with SMTP id m10mr2521630qvk.21.1594696219887;
        Mon, 13 Jul 2020 20:10:19 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id g145sm21265002qke.17.2020.07.13.20.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 20:10:19 -0700 (PDT)
Date:   Mon, 13 Jul 2020 23:10:17 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [RFC] should `git rebase --keep-base` imply
 `--reapply-cherry-picks` ?
Message-ID: <20200714031017.GA15143@generichostname>
References: <0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Mon, Jul 13, 2020 at 10:44:06PM -0400, Philippe Blain wrote:
> Hello,
> 
> I learned today that doing `git rebase --keep-base master` 
> will drop commits that were cherry-picked from master to the current branch. 
> I was simply doing a code clean up on my feature branch (the full command was
> `git rebase -i --keep-base master`), and this kind of confused me for a moment.

Glad I'm not the only one using this feature :)

> Is this a sane default ? I understand that it is a good default when we are rebasing 
> *on top* of master, but here I'm just doing some squashing and fixup's and I did not
> want the commit I had cherry-picked from master to disappear (yet). In fact, because it
> was dropped, it created a modify/delete conflict because in a subsequent commit 
> in my feature branch I'm modifying files that are added in the commit I cherry-picked.

So if I'm not mistaken, if we have the following graph

	A - B - C - D (master)
	     \
	       - C' - D (feature)

and we do `git rebase --keep-base master` from feature, C' will be
dropped? Indeed, I am surprised by how this interacts with the
default setting of --reapply-cherry-picks.

> How would a change that made '--reapply-cherry-picks' be the default when using 'keep-base'
> be received ?

I'm somewhat surprised that --no-reapply-cherry-picks is the default. I
would argue that it _shouldn't_ be the default at all. It's an
optimisation for when no --onto or --keep-base are specified but it
definitely can cause problems otherwise, as we've seen.

I think I would argue for the following in decreasing order of
preference:

	1. Make --no-reapply-cherry-picks the default in all cases.
	   (Those who need the optimisation can enable it manually and
	   we can add a configuration option for it.)

	2. Make --no-reapply-cherry-picks only active if no --onto or
	   --keep-base are given (--keep-base is a special case of --onto
	   so we only have to handle it in one place).

> Tangential question: in any case, would it make sense to still add the "dropped because 
> already upstream" commits to the todo list, in the case of an interactive rebase ? 
> (maybe commented out, or listed as 'drop' with some kind of comment saying those 
> are dropped because they appear textually upstream?)

That would make sense to me. I don't have a preference between either.

Thanks,

Denton

> Cheers,
> Philippe.
> P.S. I CC'd those who were involved with the 'keep-base' patch or the 'reapply-cherry-picks' patch.
