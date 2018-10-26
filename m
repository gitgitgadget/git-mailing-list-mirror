Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007D31F453
	for <e@80x24.org>; Fri, 26 Oct 2018 00:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbeJZI4i (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:56:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56023 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZI4i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:56:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id s10-v6so3176961wmc.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=G7jhJDWbDIyTeXT/lDQSnPHJEZxyJpGb9ZMtrsYZFuU=;
        b=P58codipxkVDfSLsMh+T9Yy+PwFTHjfHT9Osg+7nB5LvTw4KLi8mLLlCuBK2S22EAe
         k7VCHp7H38JwJCxDrJwBG3hEUCJoxTaGlY1BB7yje9+N8MY062SLBbNrDaEIpWysCRG2
         7OXI3rYIqmBmK1LsiUO/+FdWtavHQ5llG4lfBxEZCapHcZ5kK73PEFpwYwrjvzchmnk7
         gkUtBrec1zJjqD4lsXxUjwAgHIrXg5waPzkxWNVHU9PTsYyufSEw0WqU8IoDJuEW8HAs
         dfx1BPAY1vV0u0d0LfAZTxzO0042qx7H/4+p/4O81YYXygVQ/ttVnuGlrJ5qiWmWW0SJ
         +faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=G7jhJDWbDIyTeXT/lDQSnPHJEZxyJpGb9ZMtrsYZFuU=;
        b=Ec4WAmHNxEZNK66jsohSkILUeoWiAN3ZBD8iCblkRUSkBaA7x6TU6HteAXQcchahlJ
         IrLsJUGkMc8I/tDG0K/Tj2C67uCrmX9CC/p7ZjQz4Nb0fjEVyvFUWSY3tQa86A+FA55W
         O2C2MDJ06x0+GfFtzTrTU9shckOQtNC03EgNsBI3Yrh/VH9KdEDMAoCKiNW8QIl89KdM
         h/hcKVfFnUa+RTFaibIYgR6HH3lLoyB3EQ0LNb3e8rCDa8Jjfwkc8B9FB7OdtLhCinKc
         jWRwZ0f8N6PvjOo9e4cD0v81oaPVfD/c5tui/tJ++nwmS17OWPhjMhYigYp6ta/HN6zQ
         e+zQ==
X-Gm-Message-State: AGRZ1gLPPlXkXchqFFgh19qO0OnSg7nRTxNm29yQ8dTHS56xdArgyIy9
        gJS0Lrm54cNpmNZ9bOoO5Lo=
X-Google-Smtp-Source: AJdET5deOkeP7ZVS75tv1NWUcpBqzbyqMupun/PbwP9YCofscZUvWtypBNhC2gNSsMafvhObS1Df7Q==
X-Received: by 2002:a1c:5d8c:: with SMTP id r134-v6mr3452281wmb.147.1540513309982;
        Thu, 25 Oct 2018 17:21:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j6-v6sm5941000wru.20.2018.10.25.17.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 17:21:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jansen\, Geert" <gerardu@amazon.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
Date:   Fri, 26 Oct 2018 09:21:48 +0900
In-Reply-To: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com> (Geert Jansen's
        message of "Thu, 25 Oct 2018 18:38:09 +0000")
Message-ID: <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jansen, Geert" <gerardu@amazon.com> writes:

> The index-pack command determines if a sha1 collision test is needed by
> checking the existence of a loose object with the given hash. In my tests, I
> can improve performance of “git clone” on Amazon EFS by 8x when used with a
> non-default mount option (lookupcache=pos) that's required for a Gitlab HA
> setup. My assumption is that this check is unnecessary when cloning into a new
> repository because the repository will be empty.

My knee-jerk reaction is that your insight that we can skip the "dup
check" when starting from emptiness is probably correct, but your
use of .cloning flag as an approximation of "are we starting from
emptiness?" is probably wrong, at least for two reasons.

 - "git clone --reference=..." does not strictly start from
   emptiness, and would still have to make sure that incoming pack
   does not try to inject an object with different contents but with
   the same name.

 - "git init && git fetch ..." starts from emptiness and would want
   to benefit from the same optimization as you are implementing
   here.

As to the implementation, I think the patch adjusts the right "if()"
condition to skip the collision test here.

> -	if (startup_info->have_repository) {
> +	if (startup_info->have_repository && !cloning) {
>  		read_lock();
>  		collision_test_needed =
>  			has_sha1_file_with_flags(oid->hash, OBJECT_INFO_QUICK);

I just do not think !cloning is quite correct.

Thanks.
