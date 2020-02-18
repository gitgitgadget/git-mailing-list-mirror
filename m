Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AB6C34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 14:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3241208C4
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 14:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tA6RdyT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgBROmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:42:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33717 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgBROmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 09:42:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so23265405lji.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 06:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXgoDJwSgGwKCaharerZpC0EAOf1wS3/3lJdEw6emcI=;
        b=tA6RdyT8WBVKhG4D1NEZg5PKJsgesOnqYaphYdUrUfE5MUnESPziVx5ehutOOVJ1sT
         kRNpirGBAUMy5HJSfWS+HL2YlPevTo1kmd+k/i7vR0kQPJilA2faVGolWekxHRUo7PwX
         3w8K0xasyXY+s+w4ZLEdUylHcJfvbnSFKitpWPrFhG9w7Az+2F3hKOdCQOvXvct0W832
         wTUznp/fImALEmsmwzMSsbjBa7D2YuZHhD5fw1sWbe5HFqQNSA/RUW9EF1cxbxWk/O8h
         sA+MbYhaF+lhlJkn2mf1K4fLJJWdRZEyCas7ZfsmIWymNS0N27ekVaTvN3GfTXMQnnzK
         4Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXgoDJwSgGwKCaharerZpC0EAOf1wS3/3lJdEw6emcI=;
        b=ARl0XA0cNrsjWyOzBvEfgCja7R2Y+X9/znOnsF+3aU3qnfVSUwALcwY6xub9tpH7fF
         tBuaUfenE9kdVTeBrs8RpQ8cfVZfJGzHQiNCYQeHduaf5TRGLJB+D2rhumgsLxUp80lX
         AbaKwYzgqIq0L7nzYhylbIKSFm6NKTiXTd9CNwK0iENfay++ZMzRZz5QHTBT98T1cpWz
         ZCq8zB90k8+iB8XBmRss21bPJ263JVm71ggjpXP334+miTjW9axOhqEtSxqAkbprIvLd
         2wNYhqn5NG6ZkBObUWvVvyf6ODSvZCQSfku12nKxBMwidpZWWFxMH5/xtQax0y6VBKRs
         B0VA==
X-Gm-Message-State: APjAAAVRDX+Rc9UAQyPIyh0j+qkr+QQlRd4rKPTKkF4BDYbfgUvQJnT0
        7/8CFnzr1QsbDG92baWga1CRlSTDMAGfA6TLTZY=
X-Google-Smtp-Source: APXvYqyrJ/2qkPqhLrd0U6xj2vVLPWOI0PVvDEglG4K6sLpq2VLEd2WRz26OWD3Ldl5796JQGg3HzxqouUn0hSLw8qs=
X-Received: by 2002:a2e:860c:: with SMTP id a12mr13151512lji.146.1582036964237;
 Tue, 18 Feb 2020 06:42:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHk66fskrfcJ0YFDhfimVBTJZB4um7r=GdQuM8heJdZtF8D7UQ@mail.gmail.com>
In-Reply-To: <CAHk66fskrfcJ0YFDhfimVBTJZB4um7r=GdQuM8heJdZtF8D7UQ@mail.gmail.com>
From:   Robear Selwans <rwagih.rw@gmail.com>
Date:   Tue, 18 Feb 2020 16:42:34 +0200
Message-ID: <CALH1-Xp_3vSM71DbDNpDK5EHHzworcn_N3JzArwLvvCVTK2mTw@mail.gmail.com>
Subject: Re: [GSoC][RFC][PATCH 2/2] STRBUF_INIT_CONST: Adapting strbuf_* functions
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Pratik Karki <predatoramigo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All what you said makes a lot of sense. Thanks for the help.
