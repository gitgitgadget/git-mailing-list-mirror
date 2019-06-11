Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9DF71F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405753AbfFKXu6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:50:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55592 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405024AbfFKXu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 19:50:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so4643281wmj.5
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 16:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oQsY0FaHUq/zqh1u9yIpiBxKaQUpYWmbwD0+GiFV2O4=;
        b=GfaFF0u6pUd83LZpoLtl+wmIw/dRMTEp5KC4ygrxxHADUmfvHY5mRe3kl4WCJYR3Yg
         C9KYJdLGwdhO5fAf5fB7HRJCXp92bseYf3NPdg7UXFhLoDqhcm6/ORCjNr5gk2tJzyyP
         HhF6N6p5BLw76JN6+RCNOmuSwmuK4UqAaatM8ROEmFbxlbDnyLQUeRdbYyq/hccvvHc0
         jMHaVWzFxNKLJgzpT5V+U1lsgb2e/djbIJkXEjSLdXgC6/dPYIhC9qcb0K+rOEmiZnkW
         h4a/pdMw5wZ9zg7z9a+wI62rtxIMcE7NLQ8iD3MwxIYCfS+ugq2FSDjOR0KxMyNHXDtj
         ajAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oQsY0FaHUq/zqh1u9yIpiBxKaQUpYWmbwD0+GiFV2O4=;
        b=ATJwqNsYpMRpdPK2hQzgOhpsA2Zl7+Ujw5FqGcyDxtRB6nN7Un9m86NK68hHR062Rt
         TY68UDbBcegyud6Y1nJa0Phy5NdwTNXQEI1GQYc3yErpYpBbHnUENvyCmzqOJ+IzGUTc
         PsC6RX9uWevPwgZdsoQmj30vT35UTNTtNbJH2hGgo4iyuKfLKbkntqf/g8FSYS5zFW61
         QkjP3VJfZXS+eOL11zmpyvO6sZzehYOEgK2EolfBsdTVlmq9O10wcYu0/ldUA3MWnFT2
         c1qNr1g6bkwRMi3yckkAHRkCNx/25TNWXBmR/dSF78hH0DRA8SkFWwvAtkcKlalKZrIX
         /8dA==
X-Gm-Message-State: APjAAAWb1trlzWyep/f6K89vRhpdVNKzQlD7Q2fJepRUV5+nkrmqgOiH
        758Pa5RT8Ht1Lo3kApCQQJw=
X-Google-Smtp-Source: APXvYqyHYEnOVKY3ey3OoGQjqxODsYKuBRfrgnSz3PMPn6fFolhodtZbGwhduv/kiDYvSGyA8oxnRw==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr19113343wma.41.1560297055308;
        Tue, 11 Jun 2019 16:50:55 -0700 (PDT)
Received: from szeder.dev (x4db6e6c5.dyn.telefonica.de. [77.182.230.197])
        by smtp.gmail.com with ESMTPSA id f26sm3983141wmh.8.2019.06.11.16.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 16:50:54 -0700 (PDT)
Date:   Wed, 12 Jun 2019 01:50:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
Message-ID: <20190611235052.GH4012@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqqy327kfw1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy327kfw1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 01:48:14PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Make sure that the previously displayed "Rebasing (N/M)" line is
> > cleared by using the term_clear_line() helper function added in the
> > previous patch.
> >
> > A couple of other rebase commands print similar messages, e.g.
> > "Stopped at <abbrev-oid>... <subject>" for the 'edit' or 'break'
> > commands, or the "Successfully rebased and updated <full-ref>." at the
> > very end.  These are so long that they practically always overwrite
> > that "Rebasing (n/m)" progress line, but let's be prudent, and clear
> > the last line before printing these, too.
> > ...
> > Note that this patch doesn't completely eliminate the possibility of
> > similar garbled outputs, ...
> > too soon, and it would either flicker or be invisible.
> 
> The user of term_clear_line() in this patch always guard themselves
> behind "we do not do this if we are producing verbose output," but
> the proposed log message does not explain why they need to do so.

In verbose mode there is no progress output that is overwritten and
might need to be covered up.


