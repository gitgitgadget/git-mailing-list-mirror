Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22419202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 01:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755255AbdKOBiP (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 20:38:15 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:43603 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754031AbdKOBiO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 20:38:14 -0500
Received: by mail-pg0-f51.google.com with SMTP id s75so16816429pgs.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 17:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxj3QEuPKaWF9etACmFKUbdPArI3QuiKFOIa6iwwg7E=;
        b=DEnAtBKLASNb2m3uF+P/sgM8VQmheCY42sK9mEGr0JXEK2h5hCPoI2WKMAxKVNS4X6
         buCgvsLOnUW1MdW0d52cDpI3VJiAjdW1JN5Vvya3tDuVmiM4pndMTP7GVrfLjuBbEFtK
         DOAKGFTVzim0lzRSWDaD8g/Pl9AuMzWzx1PlvF6F98FztLfFG0HG58tQJ4moLqDal0oY
         hadPucNuRh7WE7oFlr5Rtl5IUv5B0XlsZtspxwPivoCst3JWxTw7c609wKB9isXJBGku
         Ny3RrMKMtLXUI9+8rmKiete0Kf9TgSftyUZeSsJfYuidjw/jyehdGU7m8BNUBkRmFpp4
         O13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxj3QEuPKaWF9etACmFKUbdPArI3QuiKFOIa6iwwg7E=;
        b=sbqhEsvNmdnbE6WyLRLZt07LA55y5MoboUkCm7QhuxDox1CzswlvpaG3JnbINI+18h
         G+gHKne9g6emFXexdZqcX4NO5bbvK5+rB++3XEFWM/7MZPPdjcw9E2pbYVH7zcIZSPTZ
         DTnNODrSDlEo7U1Zui3GHNikD3EBlTSuZXL3D7X3BzMh+qa6iFuu94ygZOyGEVJlZR4h
         1Aw6noaPcxflB8dV3T1VQeNxAq6wgST26D4ENLR/qMkuHHR9JKWJXvwxlElCq1RtabNa
         k+3dJvFHuXRx06Y+SwwYcArt5g4IdH8Ir/hlYJMn0ZMSpKVEcKa9vPAL8OCg8MzASs8U
         VI3g==
X-Gm-Message-State: AJaThX7JtQI1qToIap9p+Wl2u+d03TZnh6+hdex0Qd7HaF/baR6pZYJ6
        dVtAnxTsRx6FkezzOV5jTxpouw==
X-Google-Smtp-Source: AGs4zMZsvolpOrVKpM/WdyEyfklPHT5Xn3Q/HkLH3fj79RPKa8kjqIEceCChdpMe8l9I4QfmXgsVeg==
X-Received: by 10.98.144.129 with SMTP id q1mr15845674pfk.38.1510709893698;
        Tue, 14 Nov 2017 17:38:13 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:68e8:a345:46:2771])
        by smtp.gmail.com with ESMTPSA id d28sm5230560pfb.105.2017.11.14.17.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 17:38:12 -0800 (PST)
Date:   Tue, 14 Nov 2017 17:38:12 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCHv4 3/7] revision.h: introduce blob/tree walking in order
 of the commits
Message-Id: <20171114173812.9ac53b0cf0aa93db08d6559c@google.com>
In-Reply-To: <20171115003043.24080-4-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
        <20171115003043.24080-4-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Nov 2017 16:30:39 -0800
Stefan Beller <sbeller@google.com> wrote:

> The change in list-objects.c is rather minimal as we'll be re-using
> the infrastructure put in place of the revision walking machinery. For
> example one could expect that add_pending_tree is not called, but rather
> commit->tree is directly passed to the tree traversal function. This
> however requires a lot more code than just emptying the queue containing
> trees after each commit.

Ah, I see. You're calling add_pending_tree(), then
traverse_trees_and_blobs() will immediately flush the list of pending
trees.

I'm not sure that passing commit->tree directly to the tree traversal
function will require a lot more code, but even if it does, you should
at least add a NEEDSWORK - currently, flushing the list of pending trees
frees the array containing the list of pending trees, so each invocation
will need to reallocate a new array.
