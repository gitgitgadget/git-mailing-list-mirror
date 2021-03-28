Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72EBC433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2E061974
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhC1PpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1Poh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 11:44:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F1CC061756
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:44:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v11so10351885wro.7
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W64/mvjYDMt9w8ibHVBRLBa6MsuFGIs5O9DqgP3ulRs=;
        b=ovgMn9/Y6Kup7PD46ykFgJT220AYFVRtzHcPQLUMHTxrqAMZI+rflLDaMcOF8V1MW7
         9ISznpuir8Rp43m+btom1WVGawFsxNneOnLrISsUDt63OdEQxiHLQKtvaWMoRyPYjObS
         D5Yyu9H8DbS1l0Tj6Dm2YcK/AlL1eKN65l+X1vspVKjelBjlQNzxrLN8An4EfHoLDmb2
         fWDFFdryzc0D0QqTZ71JRRS6ntER3y3XxWcs1oJvt854QBI5zCUQiikoP3xBY+hcW0Fw
         5WNjol/Qa4SqJjYoe/nuEqNQSAVsY9HAnCDkCEOSqMTE8BtKCJvL/FZdF6i1r5VZv5sm
         Ufgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W64/mvjYDMt9w8ibHVBRLBa6MsuFGIs5O9DqgP3ulRs=;
        b=L877KnuxSCt9eKacxi+seF+8Ctf3+eNpBO3MO1R7O9WTR7EaZBDNCdsXdJo+mCgn++
         VPq30HC8W5OFt0RU/7V8AIBa4bC9LPrPafQFpeQYdm+e7bSwjWuXeKHwbMuBKl3X8CvI
         qdscqFhnDC33e7ojpoAkZA+EGWuex4LJhWYUS6xHqI5YlIQc/2osaYlgOFaYRYG+Oyns
         J8r7/Cvla6kMNpS+hoTmGEXO9NIT42kexyVvUH4tEB8mnhofo3xGsVpV1beGCNfQfQIR
         9tqpQI19l1t4kofE3UNfId9o/WF1OPD4pEytrjyJX1MLm9ljtaO/bjTzVNwZay2lD59+
         6D8g==
X-Gm-Message-State: AOAM530FQLUtrLhRd6YrQbRBa6LvyDfOAXuPYExcrHbzksECI4lwI+i2
        fNWrZLjfWp8hFsaFe8w++E40cwemu6zZ6oTJj6Q=
X-Google-Smtp-Source: ABdhPJwaoIOyqgVwhnwJf6HWBOh7KJqBWQf+GfNHWCUk5qz6KtjaypXeJFGY6psI1CRtv68KCk264w==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr24527167wrr.425.1616946275149;
        Sun, 28 Mar 2021 08:44:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a302:a800:1d6d:c581:cf0b:2ca7])
        by smtp.googlemail.com with ESMTPSA id q19sm20238688wmc.44.2021.03.28.08.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 08:44:34 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     git@vger.kernel.org
Cc:     stdedos+git@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        peff@peff.net
Subject: Re: [RFC PATCH v1 1/2] pathspec: warn: long and short forms are incompatible
Date:   Sun, 28 Mar 2021 18:44:32 +0300
Message-Id: <20210328154432.23434-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <xmqqa6qoqw9n.fsf@gitster.g>
References: <xmqqa6qoqw9n.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jeff King <peff@peff.net> writes:
>
> > It also feels like any checks like this should be relying on the
> > existing pathspec-magic parser a bit more. I don't know the pathspec
> > code that well, but surely at some point it has a notion of which parts
> > are magic flags (e.g., after parse_element_magic in init_pathspec_item).
>
> Absolutely.  parse_element_magic() decides, by looking at the
> character after the initial ':', the we are looking at the longhand
> form when magic sequence is introduced by ":(".

Absolutely from me too! I would want to re-use more of the existing code.
In response to that, patch
https://lore.kernel.org/git/20210328152629.16486-1-133706+stdedos@users.noreply.github.com/
clearly shows that it is possible to re-use the de-facto long form magic parsing
code to attempt to parse the string that continues as a long form magic.

This could theoretically pave the road for mixed short/long form parsing
(in that order), if would be so desired.

However, as probably suspected, it suffers from one big problem:
	if (ARRAY_SIZE(pathspec_magic) <= i)
		die(_("Invalid pathspec magic '%.*s' in '%s'"),
		    (int) len, pos, elem);

which is an unconditional `exit(128)`.

I don't know if it's possible to rescue (or redirect) that `die` call.
In any case, considering that, this again deviates from the
"small informative" change this commit was supposed to be.

Having said that, I have cooked a working patch with the proposed code.
