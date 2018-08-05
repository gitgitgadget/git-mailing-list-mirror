Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E181F597
	for <e@80x24.org>; Sun,  5 Aug 2018 06:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbeHEIGq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 04:06:46 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35498 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeHEIGq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 04:06:46 -0400
Received: by mail-wr1-f52.google.com with SMTP id g1-v6so5710206wru.2
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 23:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TNbLMOP6oORWS0/wwuNKHc1aayHiklyBOGRdBpXiAbg=;
        b=X4gWkkGRD6L1M6q2Lcm8c0G7o4cD6k1wHCrZqf9ucrZbhS3iDkVJX+Wl5DYpzpW2Co
         oBiGCY6AsVWJH6TSxpA86zjYzco5KbUl+j2kNj96H25FU6uV7JcKr6yA6Ab3afnQTyyB
         r/gwnx9zdpE+b8ba7u+rcXK0V1ackSvmEMQZToxttA7/qj7de4sY9zAPAWdg2kTVU6G6
         B8N2jX0ze8awXTzQfVDxItr3JSkDReUTQVeEu16eCxlh+3L61xi1O8BviTufyfDDsbvK
         KwIIsSx7moZLidI7fn1p+UPZrE86r199p8+clmGjpMz50LKYDi6PJzdoFCQRKKCHdBzV
         C8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TNbLMOP6oORWS0/wwuNKHc1aayHiklyBOGRdBpXiAbg=;
        b=iRHqD5iE220n3KpZEl1u4yvqSOXA953mv4kGB9KaR4iiYsNV/xsz3fql3L7HeuOKYH
         OcXC2GYN8D/L0vhfP+g4OhnaZdFOqa9eqbP+Hvv+oY+21ON0WCcvmjviPkkKbyJO15e9
         DnPqNmv0sOl+vbax5uCBJq9brGxwKMMUQsxGuo9gBcs16WZLFU5WffDedRE+n9eU5U8W
         EJ2Hi0uWwfvst3YC8RFPHlOUfoM40z+A2bgsL9OnKv8WjEB0+TZlK4rr+fCKIL0dLveN
         pZ6wWHhl8sBpsrMFymw0GK3WlHls9OplOSQshcrdzjD7b6pa8Nys8im9oc3d3Ipo7ooM
         FJ8w==
X-Gm-Message-State: AOUpUlGBU6HwlMH7dpWlYq3ja3WZV+em2bpSwWtIFqfHbpdUMdRuqzFZ
        nBh8lUnhefu0XuMf86rzJd4=
X-Google-Smtp-Source: AAOMgpfxtlNPviz8ejwkM7wahQYYJ+7Yl0/mdBB1z1xnlec3XVTx/MmqB/m8p/6W3arOVOqOPW4tig==
X-Received: by 2002:adf:f210:: with SMTP id p16-v6mr6596752wro.184.1533449001105;
        Sat, 04 Aug 2018 23:03:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n7-v6sm7330461wmc.2.2018.08.04.23.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 23:03:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     William Chargin <wchargin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
References: <20180805022002.28907-1-wchargin@gmail.com>
        <20180805022002.28907-2-wchargin@gmail.com>
        <20180805041956.GI258270@aiede.svl.corp.google.com>
Date:   Sat, 04 Aug 2018 23:03:18 -0700
In-Reply-To: <20180805041956.GI258270@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Sat, 4 Aug 2018 21:19:56 -0700")
Message-ID: <xmqqftzts63d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> but $'' is too recent of a shell feature to count on (e.g., dash doesn't
> support it).  See t/t3600-rm.sh for an example of a portable way to do

Is that "too recent"?  I thought it was bashism, not even in POSIX,
but I may be mistaken.

Quite honestly, our tests are still run inside a sort-of controlled
environment, so if it _requires_ use of things we have avoided so
far, like "ls -A" and "xargs -0", in order to be resistant to
funnyly-named files like dot-LF-dot, I would say it is not worth
worrying about them--instead we can simply refrain from using such a
pathological name, can't we?

"ls -A" may be in POSIX, but our attitude generally is to avoid
saying things like "it is in POSIX so it's your platform's fault
that it is not yet supported".  We instead say "even it may be in
POSIX, in real life many people don't have it, so let's avoid it".
And "xargs -0" I do not think is.
