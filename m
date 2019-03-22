Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E58A20248
	for <e@80x24.org>; Fri, 22 Mar 2019 05:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfCVFCp (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 01:02:45 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40909 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCVFCp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 01:02:45 -0400
Received: by mail-wm1-f44.google.com with SMTP id u10so824448wmj.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 22:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sfHK88CI1lMMLhJHMq/4dzQDJsxEwLlo/naNuSyQSAQ=;
        b=TjOecHZfoKFhbz7kJZC+pmVtWENsC/RAD4jdHiyaKOyU830QbCjxpQVkwkEcI1Q85D
         EommeA9RQ+vO8hyYdP0ZUKVwpKKgEHxj3Jp0LjSy81ZiklylK2KdKAkPwWQf+FMmFfmd
         bGn5gDwHgraQPksZiOqEDKU9LnKHOYjijZLkiIZTdiwEr9fsfBvzWDz8prmxJ68h1arK
         nUfdB9GJIjT8D4taFvWdw2je0/1erw2++XN3eZJ5WPgurzjtQylN4EOcKLGHpqnXSvCk
         bkSoLsIMC9yTVz5i/xC/d5Pap/aTJfckWcFaegx4Hyuplj9Efh5en6tG/0t5+/5Wk3oL
         l2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sfHK88CI1lMMLhJHMq/4dzQDJsxEwLlo/naNuSyQSAQ=;
        b=MGfM0JlMLoKXkqNLyTvErSf6mClSsgpVyGet2k96fddN4SJnzAq9meMfrR+eHcbSvf
         kGKeSHlCV0SPglRfEXqBxhWP5cdrj1p0O5HKUKJduvn2jbeC9Bui3vq5lmwWR2m8HCno
         d0OHYJxPYDFLDkEhaoHBDMqPqe/t6Yk4/2Qa7zYshJzlzRFLMtwKS0womfDkYRrLQ0m2
         Q3WTei02PlSoDdpffmrOTf4gfTvFHI3zpTFKzN4Mq2af0T2VKz4B62HuV1j4k8K//Iyb
         BM9nWzBhTjKuxJiFrbb38q0Eo3PJnm4vkGZhFjVJMW887PRC3vOuqYfx/nJrTvpMP4/d
         0QgA==
X-Gm-Message-State: APjAAAUmOAhd9HV5SyAnCiJsG0KRIQ9YaMAgzhyH/tHDlv7D55zU2ocV
        u8zbQ8dOIk3lu1vtse/zBLQ=
X-Google-Smtp-Source: APXvYqw/tI2s+XftZUdRUoVlckeBuM1WQP3Cfur/+eQQlPO6VMuEDOA8F0IAVdzIC09MhnrgAO1iIw==
X-Received: by 2002:a1c:a3c4:: with SMTP id m187mr1651486wme.87.1553230963572;
        Thu, 21 Mar 2019 22:02:43 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v13sm5457381wmj.43.2019.03.21.22.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 22:02:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leszek Swirski <leszeks@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: git checkout @{u} breaks git branch if the upstream isn't a local branch
References: <CAGRskv__Qe-F-grBtq5v-uhHE+BQAcAcOQtX-GKB+MNOrxs0hQ@mail.gmail.com>
Date:   Fri, 22 Mar 2019 14:02:42 +0900
In-Reply-To: <CAGRskv__Qe-F-grBtq5v-uhHE+BQAcAcOQtX-GKB+MNOrxs0hQ@mail.gmail.com>
        (Leszek Swirski's message of "Thu, 21 Mar 2019 16:43:01 +0100")
Message-ID: <xmqq7ecrqz65.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leszek Swirski <leszeks@google.com> writes:

> I assume that either the reflog entry should be amended to print
> something more informative (moving from master to origin/master, or at
> least master@{u}, or the SHA...), or the reflog search in
> wt_status_get_detached_from should do something cleverer with relative
> refs.

Nicely analyzed. A record "moving to @{u}" in the reflog may not
leave sufficient information for a later operation to tell what
branch was refered to with the @{u} reference back when "checkout"
was run.  I suspect that checking out @{4}, @{1.day.ago}, etc. may
share the same issue.

"git checkout @{-1}" aka "git checkout -" may not have any problem
after such a checkout, as it only uses "moving from" side of the
reflog entry.

