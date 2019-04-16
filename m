Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B62720374
	for <e@80x24.org>; Tue, 16 Apr 2019 06:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfDPG0V (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 02:26:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35412 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDPG0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 02:26:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so11770393wmd.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V31a+t5AshnyTfckzGf3wllN8kDs5d7sbxNfXarAgWg=;
        b=kV89QoMPbS91raAGKEm/8hoh9j2/fyClo/lNWkj9Aan55HceU8OtofH6qd8MB/rtJU
         uT5ea324fiBGuyi0icxQx7Odp4YOW0dhFGWQZA+r0jn8zyM8LqFgSA+xOyuFnosMJ/aw
         UQpSeTXuR493iL4XedOTqgAmC0M70fNl47qhpGgGKKN9OtDMfUjNJ9G3e7gwVHpvaX5f
         czQJ0gk5xkGTPez0d6RFhF3yi1Vx6XJJTPgqOVV4f0QLiWY9wqPb6RD1qW6jAjQK/wb0
         HhJhOEVlLIBEOORpFxkBtYHuhyc/MujM5PhzUtvmEfLjP2XGiARWM4CgwduKpKsJIsrU
         gmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V31a+t5AshnyTfckzGf3wllN8kDs5d7sbxNfXarAgWg=;
        b=GlvSOpCKvInwjaGO72SoUeLjoWBwtOjti9MTnSpSWH/daKc8ZhdTZeMVhPbXWODDYA
         ShLl9z2EHzGkTx/TAy3dC1j44pYy68CiQpasrAF0KhJQcv0ZE2GTRPCMRDgw5krOGoyF
         8HQdptsoPTHqhFU2A3pCNvE4zI6aT+5iYcVhRER8f0OrYA5azv4/C8Azb2TuC2VXvbSr
         ri3UuZsw6U6KuzhJ2fWlr7iipTnhrKDHqlZQYVg0gvbgF1D8isTRzLkelQz+w5PpMAXk
         JUpc7CD5LL4O06vbAlhehLaNZarTAI9kHNGlYmFYz2DJHflO5QfuV3Ya3STV/Ih2PEjW
         uqkw==
X-Gm-Message-State: APjAAAWYwtxZ4tuvTCU83rohGsAaEyJVj6tNpxcjEMzkaPRwtIMcACXn
        jJ/OXwe9sEO7Uc+hmHlSRN4=
X-Google-Smtp-Source: APXvYqxb7+sAqu8WPIEIybgVIG0sbvGSlHPWjZT/IwXrcut5u5Yt4kwJUrDjSCypzDDfVCIHVARlKA==
X-Received: by 2002:a1c:6c09:: with SMTP id h9mr24779981wmc.130.1555395979027;
        Mon, 15 Apr 2019 23:26:19 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d3sm41698884wmf.46.2019.04.15.23.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 23:26:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 3/5] rebase: fast-forward --onto in more cases
References: <cover.1554500051.git.liu.denton@gmail.com>
        <cover.1555366891.git.liu.denton@gmail.com>
        <ec55da07191e7f0a1d31342053c1496405ba7d3a.1555366891.git.liu.denton@gmail.com>
Date:   Tue, 16 Apr 2019 15:26:17 +0900
In-Reply-To: <ec55da07191e7f0a1d31342053c1496405ba7d3a.1555366891.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 15 Apr 2019 15:29:24 -0700")
Message-ID: <xmqqo956pit2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Before, when we had the following graph,
>
> 	A---B---C (master)
> 	    \
> 	     D (side)

This is minor, but comparing the above with below

> 		    F---G topic
> 		   /
> 	  A---B---C---D---E master

you'll notice that branches growing downwards in your picture (this
applies also to an illustration in your tests) are off by one
column.
		  D
                 /
	A---B---C
                 \
                  E

> @@ -1682,13 +1699,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  
>  	/*
>  	 * Check if we are already based on onto with linear history,
> -	 * but this should be done only when upstream and onto are the same
> -	 * and if this is not an interactive rebase.
> +	 * but this should be done if this is not an interactive rebase.
>  	 */

Two issues.

 - One is shared with the original (i.e. not a problem with this
   patch), but what "this" refers to is not what has already been
   stated in the sentence.  We check, to see if we are in a
   situation where a specific optimization is possible.  But this
   (== optimization to fast-forward without actually replaying the
   commit's changes) should be done only under such and such
   condition.

 - The other is more grave. "should be done if this is not an
   interactive rebase" drops "only" from "only if" in the original,
   which changes the meaning of the sentence (it can be read as "we
   check if we can optimize, but the optimization should be done for
   rebase-i regardless of the result of that said check", which is
   not what you mean).

Perhaps

	Check if we are ..., in which case we could fast-forward
	without replacing the commits with new commits recreated by
	replaying their changes.  This optimization must not be done
	if this is an interactive rebase.

