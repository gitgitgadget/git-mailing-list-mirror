Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3697C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJQNTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJQNTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:19:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E61FCEF
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:19:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so10426653pgb.4
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjU1uPdiCQBokVGkwRJY/1BO45ZVyHcQqFg1pUF8TaU=;
        b=U6RzEbL1cg3k92h8CBnWZwVCagnCYNMKx/6/Oe0Ag15juTRW33R2aCab1Zzaz2cn1h
         CF/V/Yn5Zq15uSzwgsyGX52HQPV+434++SPzH0ZgWmuq3VEk4h0XeIX7PV95O30A1ISC
         PrBrOmVUEXaL9MqhjyP8QZ/7o8KgjVCWNoq+xJqb9vhyvXC5Xl2jGOnhJjwC/YVtI43B
         IibcQfhi4ORO/kA5WzKzlkO2sWPo2LkVArYagWi0bf/YOrbhFUK/lZRbNXoPiZnfkRD8
         aewVne254pigHWzhsIEG7SS1R5AIx1EId2pBXWGWyWPLzg9e+m2nv6xkBzZxHctZkiHV
         U1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjU1uPdiCQBokVGkwRJY/1BO45ZVyHcQqFg1pUF8TaU=;
        b=EkDN9ekYmA9Eg+ppAqU+RISFNu8mPZBAKgP+u+c8W/B8cITs93EnUjGQ3Q1Yyv9uOJ
         QLw0qcVgyR4i8RKkv+TbbPM1zzQmZbheV+sUgBwH24wZlTeGEOq1SycEXjv1llCZrNK5
         wbPVqlLY2neY+BXbowouRWKXF6SquihHDh5dzhq/6951g6fCI/jJtbwST2uNBnkclgpN
         Jw9cG7DWq8Zjbik2Mxq4kXxkhi6eC9ApNbnmKYMuEXqaa/qqw092jlo/ezJvUFr/Tqw4
         mEK3YAuvfx+k+mTraJDwJDcpeQnn3OlJpdJieKanyy1pj4k+6ssw4Fpooo4WA+pzJvMd
         mBzA==
X-Gm-Message-State: ACrzQf0rI2s6LMgpgRyUXksFKYf3rnW2mg8mQYoFSN8xMF4QW+cNURbU
        3+hoy1j1xpl4+fiR0so0fHyJpwxnIcFRig==
X-Google-Smtp-Source: AMsMyM44WMrOhd8JbpfVG/H5y+rI84MHt0UFi7zKHSosrjMYOhZLl0vWkZdNUPKciY85jVujJA52Og==
X-Received: by 2002:a63:1165:0:b0:44d:e5ba:5603 with SMTP id 37-20020a631165000000b0044de5ba5603mr10633683pgr.68.1666012786406;
        Mon, 17 Oct 2022 06:19:46 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.55])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902c40700b001822121c45asm6760977plk.28.2022.10.17.06.19.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2022 06:19:45 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 1/2] notes.c: introduce "--no-blankline" option
Date:   Mon, 17 Oct 2022 21:19:39 +0800
Message-Id: <20221017131939.62888-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.0.rc0.2.gc581cb24b65.dirty
In-Reply-To: <xmqqsfjsi7eq.fsf@gitster.g>
References: <xmqqsfjsi7eq.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> --blank-line::
> --no-blank-line::
> 	Controls if a blank line to split paragraphs is inserted
>         when appending (the default is true).

Will fix, "OPT_BOOL" will automatically deal the "--no" prefix, nice design.

> Use
>
> 	int blankline = 1;
>
> to avoid double negative, which is confusing and error prone.

Perfectly reasonable opinion, will fix.

> 	OPT_BOOL(0, "blank-line", &blankline,
> 		 N_("insert paragraph break before appending to an existing note")),
> Then, the conditional would read more naturally without double
> negation.
>
> 		if (blank_line && d.buf.len && prev_buf && size)

Will apply.

> I do not know and I am not judging (yet) if the goal of the patch is
> sensible (in other words, if we should have such an option), but if
> we were to do so, I would expect the implementation to look more
> like what I outlined above.

In fact, as I was learning about this feature, I thought this parameter might be
helpful, so I tried to send this small patch and maybe  I can get some input.

Thank you so much for taking the time to review this patch.
