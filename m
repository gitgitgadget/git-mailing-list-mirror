Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CEEC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhK2WsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbhK2Wra (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:47:30 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C59C0D8C92
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:53:05 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s18-20020a63ff52000000b00320f169c0aaso8891533pgk.18
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=88NqiTU/RF1aSNHHtoNPksuYeZSYdAMvgATMS0X5ing=;
        b=s5NYaHSkWjLYlk9pAMUi3s94QiqwMJnaeP6VqVXma08wxXrnpnKUX7ZtlARoFoJIpv
         bvfzZpP+4dDEDUOo4GHwUiFhd/o5CJCbeNhpNJ6SKtWK9tIsESHK0M1yvPSDXacylRw9
         eNLtTu/Aq+4y1vu1jP1K425PAMti5xzSd02Bo9XwpzY3Z9n4FDVv10XmjC6pbvXqvMnF
         yk9jV4T8UbX9quJLrRX27RX2Wl12m3IQK6jHgy/EeFgmZvhNcWTC/Q4s/zuDQepwH2/A
         zBShyo32ueMQxituQ7BoNyGTtpw8EzFJhxblxLQyWBbPfSBWoO4DqOgIR1NfSiG0VVM6
         UrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=88NqiTU/RF1aSNHHtoNPksuYeZSYdAMvgATMS0X5ing=;
        b=SI6nJDxolxFTJO0aGHUCT2GcNvZyeBuAJtlIa6BQF2y868ORyWdCALfNpAxNwB7csS
         Z+cF/KVm/tDpRgvEgWqzezPAseJ9rbCt99IQELDRhl88cDduN8PfBp5sN+16YHRpyfox
         IN0Ux9wUe8miNPt+wTyCbyiebCXCWtx/VixOX9s+eBL/mKdV/zNcqgqOKp6vD+snx/l7
         YzyM6kSRslNjAEE6UdreVS7fPwtOh7ahjnUaU5xzrAajeUAlJEDOeZP/sk0Q2y0pKUOb
         WmIAkC5wmGD6nxu87bRG0j1p0UBakrFjDIfSvK5Vlj9D1ZGOwuX0XS7RKXvp3FrquJgC
         SReQ==
X-Gm-Message-State: AOAM530q6f02KhA/yg1wOTI4e3HBBM4scIdnvS6RgkHbN8M/L9HgkobA
        dh5Bej0tY6+t16MjBtxygLf/d989WD4zjZylhRfZ
X-Google-Smtp-Source: ABdhPJxymN/Fc/8c0lYUTzTXav7Hm++wAeymoXuHvQ30ey2pa+Xoh17oWcHiNpPQXswljQO0Y8dwNEMSSTviEl5OF8vR
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr14676pjf.1.1638208384940; Mon, 29 Nov 2021 09:53:04 -0800 (PST)
Date:   Mon, 29 Nov 2021 09:53:00 -0800
In-Reply-To: <kl6lilwjre3m.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211129175300.371981-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6lilwjre3m.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: Re: [PATCH v3 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com, peff@peff.net, avarab@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > +`hasremoteurl`::
> > +	The data that follows the keyword `hasremoteurl:` is taken to
> > +	be a pattern with standard globbing wildcards and two
> > +	additional ones, `**/` and `/**`, that can match multiple
> > +	components. The rest of the config files will be scanned for
> > +	remote URLs, and then if there at least one remote URL that
> 
>   if there {is,exists}* at least one remote URL that

Ah, good catch.

> > +	matches this pattern, the include condition is met.
> > ++
> > +Files included by this option (directly or indirectly) are not allowed
> > +to contain remote URLs.
> 
> As Jeff mentioned earlier in this thread, this "last-config-wins" is a
> pretty big exception to the existing semantics, as
> Documentation/config.txt reads:
> 
>   The contents of the included file are inserted immediately, as if they
>   had been found at the location of the include directive.
> 
> At minimum, I think we should call out this exception in
> Documentation/config.txt and the commit message, but calling out *just*
> hasremoteurl makes this exception seem like a strange anomaly at first
> glance, even though we actually have a good idea of when and why we are
> doing this (which is that it simplifies includes that rely on config
> values).

I've switched it to expand-in-place semantics. The scanning for remote
URLs does not mean that those configs are applied before the include.
I'll add a note to the documentation about that, but if you can think of
a better way to explain that, that would be great.

The patch includes a test "includeIf.hasremoteurl respects
last-config-wins". Take a look and see if it matches your expected
behavior, and let me know if it could be clearer.

> I was a big fan of your includeIfDeferred proposal, and I still think
> that it's easier for users to understand if we explicitly require
> "includeIfDeferred" instead of counting on them to remember when
> "includeIf" behaves as it always did vs this new 'deferred' behavior.
> That said, I doubt most users actually rely on the inclusion order, and 
> I am ok with this approach as long as we document the different
> inclusion order.

The user still needs to know that config variables in the future can
affect the behavior of the include, but perhaps that will be easier than
remembering that certain configs are deferred.

> It's not clear to me whether we are forbidding the remote urls correctly
> when uncondition_remote_url is false. I would be convinced if we had
> tests that convered this behavior, but I did not find any such test
> cases.

[snip]

> As mentioned above, I would have expected to find test cases that test
> whether or not we forbid the remote urls correctly, but the tests are
> pretty clear.

Ah yes, I should include a test for this. I'll include it in the next
reroll.
