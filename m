Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4546DC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DE022795
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgLNQ0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440140AbgLNQZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:25:50 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC03EC0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:25:09 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id d8so16265969otq.6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MN//4iw2w+zAXaazTEORVnZVTck7Ap4r3jUyrmAu3xY=;
        b=e5IfGpJk3JozPXQ/J5h3J9+cqn8tVd0b7EsYBVl28MNCXLakkA4VaqpfkbP88GL50K
         2IoMl4u1Mmaz7iALik/qep12Npf0e2sPpOqqTn2q1ed5kGJOiQAkhoOrk3BfRxQ+6lM4
         Yl/a775lhgmlC2y9XW63tSZTg4ZhHSOlmvMMh6WXbWNIPTqqV7RIOOg3BwlZhTvJghan
         GPKxiY9IgyZXmQq6wCbByEvhzJj7LXAXr6VoRbqM4Wl8QGL3GZqkll1gyQppFKn+dUJG
         9Ts9kfqdpzsCMi9GbAZWK1s3CQYc2YsjXYcRf68O0yg1UAyKLSa6ttzf326EWmP6gGk/
         5P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MN//4iw2w+zAXaazTEORVnZVTck7Ap4r3jUyrmAu3xY=;
        b=Ea6pSYx/AUbPXWhmrhtWG3y2gK27x2e94yKadTab2g7rVK5kCQQeIUOZ82CVvTJbnw
         VZoP0eLsitPsovoQQGF0+DkMgHZ5OvHCSYACPFSVmn71qb1+KdsramD6RCsSA4XYadZR
         EAYWawUykihiBaVxY8/bsFWHSzMfU3+UB8TO0FTN8iOgpB5cBiOy8gqe9IbQOWK7g1p7
         pxmiGsqtEamkRIVI7EQ1A+ZfkWKLJX5zQ0phi9OyT35yX7HaSa0XfVd3kslPpW62ZhAa
         +oukhkErrKZRi/1pFFW8a6pPAONn/rMIhHAsJzPyeEIttAmA7rf+kpOrhIw5BC83PXcG
         U+SQ==
X-Gm-Message-State: AOAM532JO2srBwGM7RhuqUpFyAZs5DIhpHBg3MdIxD+jZB4d/bJPFFcx
        S+5IxyDEvAQ9SvgE5zEp7UOheHTLgtKWrWnZ5ks=
X-Google-Smtp-Source: ABdhPJzKsXrgDlawIYy1C5d5mZ6TtnjTVDDcso2MvG5nLArPgFA+x+ZMPhrHcd2kXXEZ5yBOtvp4JXhhjj9B/yBjDwQ=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr20098169oth.316.1607963109010;
 Mon, 14 Dec 2020 08:25:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
 <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com> <5fd77584dda74_d1ec120827@natae.notmuch>
In-Reply-To: <5fd77584dda74_d1ec120827@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Dec 2020 08:24:58 -0800
Message-ID: <CABPp-BFkXcxMR=2kh6mBR5ymy2s5-Gdngw182SUs5EweZdj-fw@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] fundamentals of merge-ort implementation
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 14, 2020 at 6:24 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren via GitGitGadget wrote:
> > This is actually v5 of this series, and is being sent due to review comments
> > from a different series, namely en/merge-ort-3[1].
> >
> > I have rerolls of en/merge-ort-2 and en/merge-ort-3 already prepared, but
> > since gitgitgadget will not allow me to send a series dependent on a
> > not-published-by-Junio series, I cannot yet send them. You will need to
> > temporarily drop them, and I'll resend after you publish the updated version
> > of this series. I do not like this solution, and I was tempted to just push
> > the updates into en/merge-ort-3, but since this series was still hanging in
> > 'seen' awaiting feedback and a lot of the suggestions were for things from
> > this series, I decided to go this route anyway...
>
> You could send it the old-fashioned way.

As mentioned in the first line of the message, I already did the first
two rounds that way.  There are sometimes reasons to use send-email,
but gitgitgadget comes with really nice cross-platform testing so I do
tend to prefer it.  Also, mix-and-matching between send-email and
gitgitgadget causes some confusion on which-number-in-the-series-is-it
counts (as noted above), so I tend to avoid it.
