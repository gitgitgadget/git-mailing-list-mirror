Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC2B203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 16:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbcGUQ6i (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 12:58:38 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:32805 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbcGUQ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 12:58:36 -0400
Received: by mail-io0-f169.google.com with SMTP id 38so81773655iol.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2016 09:58:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZnYY01Ll485X5T26DVRMZ0SmL9gOtnGFG9JO9hyyrF0=;
        b=K/g1DUlMG3qvQjdKfsYvP+PtHyo5kf56znHYk59gesV3Q5i6cXV5vVBv66p0h1iqX6
         89wzaQN0pQnL2qpGGUAJl5wdBJUS6ej89II84UvAf8kLL7Po8HPQjGtdNBmDbiIATXni
         k8YiiFZBSM/gfO7GGT/rDhBnU/n3/hDbdu/dSppfhWY1dfwyjeu2vvzs9cgzbEs8pzTL
         BEKZOevkwQBYGg5jBGzDmyqA8zSI+BqflJupku/FVwAAZ5lj3OhBtnGqaBX/K+46AhyG
         e1tqoOTDEuPHzyD257PxWzFd5XGbMzJqdIJxXpeOoFpbIAPMVaKeZoxI4xnd+VxLOz4l
         lvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZnYY01Ll485X5T26DVRMZ0SmL9gOtnGFG9JO9hyyrF0=;
        b=Sx4mE93PFuST6J4WaTssRQDS5H6/uXLiYKPwyqMNGdF4GQBg2ohGoZGHpuBNEralr7
         3oH5Qc7T5KxvZlhCWANzEd3WSbYFIffPqbamK7rFiDjLvpy77axNnL4xa05LY3Ov31jA
         6aXPIAO+qMT5BgCjzRrjb1uF5ok9mBcthmNhVybZ6eCkHh78Kf5GtDO6djQby0XoHNnx
         F31P6kfvB4AxUII/L0rZD/EDm+RsgSxQqcxFLBm9vvc+Fd24rG6aVYLLS4uaxZL36KXs
         Q3/CvHw1LUrmpGCkBxdm26bGjPwo8u/PFK9YpdDNBBq5ws654YDvGxnrUlTEjEXILdzm
         z5Kg==
X-Gm-Message-State: ALyK8tKgoLL6eJuVqXfF9rt1ZFpi1wmdQqKapREL/0yPjXA2RUJhWuYAB1ARj22PUS71b2jeQhwibvfhSRYQL7gG
X-Received: by 10.107.131.38 with SMTP id f38mr53507486iod.173.1469120315714;
 Thu, 21 Jul 2016 09:58:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 21 Jul 2016 09:58:35 -0700 (PDT)
In-Reply-To: <20160721125837.3127-1-Matthieu.Moy@imag.fr>
References: <20160721125837.3127-1-Matthieu.Moy@imag.fr>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 21 Jul 2016 09:58:35 -0700
Message-ID: <CAGZ79kZ5So-tXRX60CTCxrsgW8Vv7QH5gXGDk89EP69Qk28Kcw@mail.gmail.com>
Subject: Re: [RFC/PATCH] status: suggest 'git merge --abort' when appropriate
To:	Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Thibault Durand <thibault.durand.28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 21, 2016 at 5:58 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> We already suggest 'git rebase --abort' during a conflicted rebase.
> Similarly, suggest 'git merge --abort' during conflict resolution on
> 'git merge'.

I think this is a good addition.

Thanks,
Stefan
