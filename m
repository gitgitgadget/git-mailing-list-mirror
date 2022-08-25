Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEF7ECAA25
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 16:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiHYQJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiHYQI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 12:08:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646FAB8A6C
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:08:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g8so15023063plq.11
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc;
        bh=jFIBqWla9Hhynh/9ka/Aq7waYNRUvIQzh7JK9IDrusI=;
        b=XQBgcI+YwoZFWCS4kWtBqVtDP77/WF3Z8G93Sw9DA4viPAvqkcHc0E7GjWICTgZdKb
         k33EI2F+ygoHI9drUoNL+qmX8TTM6xr837k1Di3zjY/p9CDZqmJuysZ5L+IUoCgq3SHb
         XSIPVEATGC6qPsjBBjKwvD7pp5adTZnUFwUCnvX/HKHGYcesLz3g5tOAwOtM/rJAj0Ps
         neuKVDDlo2tO6biRzsNg8TxLWfdwXQ/64qYInW7LsvjZE1pZJt/q93cKWT/epn/nDHtM
         i21plhibvfTrfHi485h/UA4jHwiEgfW0K/Adb8Wg2g4hZZfJQz61BT4OMjlLO1L5wP9k
         TATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc;
        bh=jFIBqWla9Hhynh/9ka/Aq7waYNRUvIQzh7JK9IDrusI=;
        b=uZnfTjITgjuXEqNAZud/p3CcwLi5ypyRrcSk9k+TX37OLwTuBDTvoF5IBQuKKUbmcc
         KWe2Ral9yMDhZZYl5W7nKlU7rs15Wla9P1+VDSLkUGzhFIEOi8/NFnwzYNC5z60Wi8bv
         YodjPhjwYs9EqA0/XKcGvGtUTn0jmv4S5fk2mqac5Wt3+c+zxrktPeLJPGyP8LhZ50Nl
         Z2oz8njBI/dtXFyFgSvRP3PykDC5otRWx8vGEL/gjkLctj6+BNTY6PE94O/CMUG4H5ER
         PBVsDCdu1xeE/jXyQz8PpksqXwi53L/ka90Cgeot9c7GFDiRppWFikXU91GI6JJIAxW+
         MbZg==
X-Gm-Message-State: ACgBeo3EAMIOwe+s/3EfQtRul/pPN49ikHsTxsNKlcFsPfg0iUyHgXF6
        xJ1U5100F5tc47thujRwwnA=
X-Google-Smtp-Source: AA6agR5ZIqwB+PdN0DuEDzZnE/axkE3agoXyLB3QQzGWkkWYc72tnmjHALwRcgHV8u7Q3Su6v3zF/A==
X-Received: by 2002:a17:90a:e7cd:b0:1fb:6490:2d6a with SMTP id kb13-20020a17090ae7cd00b001fb64902d6amr14232908pjb.77.1661443737758;
        Thu, 25 Aug 2022 09:08:57 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001726b585d4bsm15189697plh.202.2022.08.25.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:08:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
        <xmqqwnax438x.fsf@gitster.g>
        <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
        <xmqqfshl3pbp.fsf@gitster.g>
        <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
Date:   Thu, 25 Aug 2022 09:08:57 -0700
In-Reply-To: <220825.86ilmg4mil.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 25 Aug 2022 12:47:53 +0200")
Message-ID: <xmqq1qt4486e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> What's happening here is that coccinelle can no longer properly parse
> the file after the UNUSED() macros were applied to refs.c.

Sigh.

> 	diff --git a/refs.c b/refs.c
> 	index 607694c2662..37e7d88920c 100644
> 	--- a/refs.c
> 	+++ b/refs.c
> 	@@ -442,7 +442,7 @@ struct warn_if_dangling_data {
> 	 };
> 	 
> 	 static int warn_if_dangling_symref(const char *refname,
> 	-				   const struct object_id *UNUSED(oid),
> 	+				   const struct object_id *oid UNUSED2,
> 	 				   int flags, void *cb_data)
> 	 {
> 	 	struct warn_if_dangling_data *d = cb_data;

This is almost "the most simple and stupid and nobody would get
confused" version, which I may actually be able to live with.

Unfortunately it will not get the "somebody by mistake uses 'oid'
and we can break the build no matter what compiler is used by them
before sending the patch out to the list".

Doing s/oid UNUSED2/oid_UNUSED/ without any __attribute__((unused))
would give that benefit to us, but that won't squelch compilation
with -Wunused which makes it a non-starter.
