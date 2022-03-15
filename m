Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD6C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbiCOVf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiCOVf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:35:58 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348091FA4C
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:34:46 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id j5-20020a17090a318500b001c6564ef3baso352007pjb.8
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TB1M0N9fY76c20Aa+yhr0DvjRly4UaMSwrM/Z/+nBAs=;
        b=sGbeHAaRVRt3q18rea5GKetWSzpMA8m6Z3Ey4daZXKaRA9YeARw6cBDA3/QYaw9t32
         FCdt0Kja6Qb2drOa+SlvXkZ0hXliDnRvQZiLCMgXfavlAepBWvadIKhF+mrcRMZ7QbF4
         uQ1/FKE8ckMCtEBHg0PlUjxl7CVNnFNsHMEiOz7UZTBI/jXJv1h9o6GMM9qVZvguLrNq
         GNwiypdELmwVOuzeaQbNmmnsb6OXjlLc5vv0rlZJgA0oN1gF+HCFECqxOsQg+b50QHPq
         Xw21DROSk3pBdxsQgsoD9peXBOw6DwnHLOeOQO/d1EGethPmwK0lbUGH5Ekwb7TRMAm6
         xJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TB1M0N9fY76c20Aa+yhr0DvjRly4UaMSwrM/Z/+nBAs=;
        b=0E8JsCyxqrZixfiooXMQPfUdps/TuTERQIH4OHg89uzE+qwL9r3Yec1VJ63zQO4njx
         ee9Sjjo6XK6pwoa3Vvq0FZQB++5gH8TEXbuaavxJa4NwMmzjQYwvbXu+G+hSMbnOaqfH
         vDSpZio7V7SgjYRGqGEK3IMHvdkCLNZyQ/etVOexneyxE44zNhj0KIBw6S0cVnu+LEwt
         0KClxvG4vQnqSH7pSgW++5LF7SbV5eLWwKGSygx7JOYfvI8bM7c5z+ZfNmG47ozqaN4p
         PNoyiWSBFsOVUDzBRuYGUEOrZprk6MT5H871BXYrUt0V6RosluCCCSIF+c8fcCtudtFe
         hXbw==
X-Gm-Message-State: AOAM531rgYI1Hu/o2iFLZhpQSAwBXrTQdTJWQ5ejsUUgvvdfwu+2p243
        Hd9hs3Jjq/uWxzpAvjN4paeL9QhsNcJmhQ==
X-Google-Smtp-Source: ABdhPJyTyEhY0LMgTOjLt79nUciS9KPoEhD/ZpClHK+GBg4f60nHsYqvTthmlS7yKC+wh3Y/3houltd5eGMCdQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4a52:b0:1be:fb7c:9fef with SMTP
 id lb18-20020a17090b4a5200b001befb7c9fefmr6741420pjb.57.1647380085719; Tue,
 15 Mar 2022 14:34:45 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:34:43 -0700
In-Reply-To: <xmqq1qz3dnqu.fsf@gitster.g>
Message-Id: <kl6l8rtayk5o.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220312164803.57909-1-a97410985new@gmail.com> <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
 <d8783660-1487-1899-19bf-10654801ea0a@kdbg.org> <kl6lee33xd5d.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1qz3dnqu.fsf@gitster.g>
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        xing zhi jiang <a97410985new@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Interesting, I'll take note. I'm still personally not keen on supporting
>> CommonJS-only patterns when we are purportedly trying to show diffs for
>> JavaScript, but if we think this fits the style, I'm happy to oblige.
>
> The question is, with these patterns that are aware of CommonJS
> convention, would your bog-standard-and-boring vanilla JS code be
> detected incorrectly?  Becoming aware of popular conventions without
> hurting others would be a good thing.
>
> And the "popular conventions" does not have to be limited to
> CommonJS/Node.

From the perspective of "'exports' is a special name", yes, we could
detect vanilla JS code 'incorrectly' because, in vanilla JS, the names
'exports' or 'module.exports' are not special. So perhaps, one could
imagine a browser-side script that deals with "imports" and "exports" as
part of their business:

  const exports = {
    quantity: 1,
    type: 'boxes',
  };
  exports.getQuantity = () => {
    foo();
  };

This diff driver would mistakenly detect `exports.getQuantity = () =>
{`.

Although, the more I think about it, the spirit of this patch seems to
be "we want to show headers whenever we think we are in a function", so
we don't actually need to treat 'exports' or 'module.exports' specially
at all, e.g. this case should also pass our diff driver tests:

  const foo = {};
  foo.RIGHT = () => {

    ChangeMe();
  };

and if we do this, we will correctly handle 'exports' and
'module.exports' anyway by virtue of them being plain old JS objects.
