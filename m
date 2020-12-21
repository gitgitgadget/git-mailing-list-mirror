Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E5C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 23:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375A622B2D
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 23:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgLUXvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 18:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgLUXvx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 18:51:53 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002AAC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 15:51:12 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id j21so2590418oou.11
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=600/KOGdO3BNjrv/KY+EUZSrY40tBprrJLbiQokMtWg=;
        b=rqomvDyLxUQSzQrHbX7Ln2E5ZonWapW+2ahP0TjKdrjr4CuaAN6DFanH1rHHeXoC2J
         /PYkfA7AvXJJcs3VGmC70VHjuOjxMD4SA7ci2FXdUeq348EaXQJGa0vZ8eShWkG2/4oJ
         N0xr0RDrxS6Xe4Dpv9/wGWsjAKbPbrvmuZFF9MfCUEw7l4RAdvoMDFIO0hf5DlM0HRaU
         wSTguy7PBKvRL2IrQPRkJCSPWf99im17rCL/o6O5/cN4RNiN5cykgqCWT/Y8CQerNKMy
         HHJneRiNpLtu2C81Wdc8S+oMCJ8UHjLD8I8M/8veX4NcIMWqNjcD1Ql0oIOjtm8gA8Q7
         x5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=600/KOGdO3BNjrv/KY+EUZSrY40tBprrJLbiQokMtWg=;
        b=OUPDQZFZK5CJTJnxFEuDP1p8CrqclV2GAvLISBMNYitVxL2dom2M4e1+xbB0h06cEQ
         cgjH1GAFrpFH5Z7YvSPoReGRMIlH1m1pCruRpUEzHGhv3GKr2UEMIOrxGSPX6XfxmDC7
         U7xZSoNjIHOZy+2/dM7jRdI28YcTthBjYRFwfLRwuZ4vMHqpWkFKPz97oO9bVjyMbOww
         EIUE/8mRjqfrnOtO2J8Bp597UTzyNyaB/P2af8KZmwtj3ck/tgayalkDBK6FM70hqnHd
         9O0rslcAMT3NzayFkdgAA9Q69kELmoq05o7uttc59gft/o2wIcWn1srZoZvPHg9iG28w
         MAYA==
X-Gm-Message-State: AOAM531fIwbMw0oufYNJXoK9TcgtXV92VXYiSHxBm1ZE/ZjT3GAVuu45
        1id20G7nlw0WSmxgKTW4MlE=
X-Google-Smtp-Source: ABdhPJwU+KMVQzEQqqpVekfeHcWUNv+9HRgCsU8m9GC5d2sbENJuhtjNdZFjSbvKNt4WPyhHz5d6rQ==
X-Received: by 2002:a4a:e606:: with SMTP id f6mr5100120oot.4.1608594672450;
        Mon, 21 Dec 2020 15:51:12 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v13sm4005353ook.13.2020.12.21.15.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 15:51:11 -0800 (PST)
Date:   Mon, 21 Dec 2020 17:51:10 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe134eeaec71_11498208f9@natae.notmuch>
In-Reply-To: <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
References: <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
Subject: Code of conduct violation?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> Just a heads-up that Felipe has a history on this list of creating
> long, never-ending, pointless rant threads so sometimes the best
> course of action is to ignore him.

I think this can be considered a personal attack, which goes against the
code of conduct.

The code of conduct suggests behavior like:

 * Being respectful of differing viewpoints and experiences
 * Showing empathy towards other community members

It seems to me the above comment is an example of the opposite.

If you feel that my feedback is pointless, then don't engage with it.
There's no need to put aggravating labels, especially on a public
setting. Even if most people agree with you.

I tolerate your opinion, but it's just that; an opinion.

I think you should treat it as such (an opinion), and not blatantly
disregard the viewpoints of people you disagree with, and worse;
publicly suggest others do the same.

The Git project engages in outreach programs precisely to increase the
diversity of the project, and this interest should not exclude diversity
of thought. Seems counterproductive to allow these kinds of attacks
against a minority opinion. It is in fact the minority opinion that
needs protection, the majority opinion can defend itself.

Cheers.

-- 
Felipe Contreras
