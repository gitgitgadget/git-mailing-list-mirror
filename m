Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D831F404
	for <e@80x24.org>; Sat, 20 Jan 2018 01:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756103AbeATBCb (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 20:02:31 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34240 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756019AbeATBC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 20:02:29 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 58D961F404;
        Sat, 20 Jan 2018 01:02:29 +0000 (UTC)
Date:   Sat, 20 Jan 2018 01:02:28 +0000
From:   Eric Wong <e@80x24.org>
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] mru: Replace mru.[ch] with list.h implementation
Message-ID: <20180120010228.hhyvirqp44taf3cz@dcvr.yhbt.net>
References: <1516404987-3420-1-git-send-email-gs051095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516404987-3420-1-git-send-email-gs051095@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gargi Sharma <gs051095@gmail.com> wrote:
> --- a/list.h
> +++ b/list.h
> @@ -93,6 +93,13 @@ static inline void list_move(struct list_head *elem, struct list_head *head)
>  	list_add(elem, head);
>  }
>  
> +/* Move to the front of the list. */
> +static inline void list_move_to_front(struct list_head *elem, struct list_head *head)
> +{
> +	list_del(elem);
> +	list_add(elem, head);
> +}
> +

Since we already have list_move and it does the same thing,
I don't think we need a new function, here.

Hackers coming from other projects (glibc/urcu/Linux kernel)
might appreciate having fewer differences from what they're used
to.

Anyways thanks for working on this!
