Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A312055E
	for <e@80x24.org>; Sat, 28 Oct 2017 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdJ1RPm (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 13:15:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:49462 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbdJ1RPl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 13:15:41 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZU7V-1dsKla3eJh-00LBpK; Sat, 28
 Oct 2017 19:15:39 +0200
Date:   Sat, 28 Oct 2017 19:15:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] list-objects.c: factor out
 traverse_trees_and_blobs
In-Reply-To: <20171028004506.10253-1-sbeller@google.com>
Message-ID: <alpine.DEB.2.21.1.1710281913060.6482@virtualbox>
References: <20171028004419.10139-1-sbeller@google.com> <20171028004506.10253-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WAbxK8JvkQmEWNjMiMw5Gnp/scE4frMT7uTxEZ4Dccoc80s/D4i
 W0LtxXMYRKTWNrt0sbe/LfEfgEQg0p7ODmO43cny20XvJb5Vc86+z9zXiEuPDOO/aYernzt
 kZiJI0rqyDlT9gO8kBAErQQvHtrxVMzSMIQVt1MYXKxBSYeMM/pSyyavWGJWtVx/kquZy/b
 TWrtSCyIXWyt4t60UNVfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BGjhSbBqF+w=:1vEXPCiNQFXNC3pH2f+TpM
 PqyzDcBPhF51xJFGX+lA2VzFN2wWlAzQKqxJn8KPFb3TrJI/SqZXXfo0irQTR5MinxCsll2WG
 fFKIk7BAo68PxIgZLB2nu0fOpjkGXqZxtxK7d4M8bfxH8LteN0XtAYPhfDdpHVnITr1PMLa+/
 cu5/usZ2cpKJImYgpr31N0+GKKXHWqXCmz5YcoZLQmoeHyZyD6BtPfdoE6Vn4eBpE20TAG/PK
 9KS6oOonfBnvfj2AHggm337eQVUOezceOr1b1T0+gxhtv60XgTXx5cIJ56vJzf+bM/KMsMjRe
 voPaJqIgIhf5VKQa9XgBheevEOepJ23LWNT9ex2Qvw1AcomoG/Jg3dvAlJaKSTc4DsWTFRV6l
 VZz16WMGevlEBehpRYGtPbT2bbTIjQTHuAUBTlLmsClPJUzl+ij5lr/DKrT9xDA03RF057hm+
 AMp3fAhByrVHTq/VmoANjn3XWWruykyyMywBcnBA16grCkRunmwMz4nJ7ySJQjmSHHFxf4zKj
 D0ksh4hBkJIhi0Wb9fnIv/Q8eTRSg6AsLenp2C51O0f90+/OZap+at4OXH7Bg3ajsoi6agz1J
 dwbg/XvKfXkX5TklpwOqphKy5mTw0no+sYEyqGqblFEvMO2oQ9zLDLs/NlZECChOtIgCNqZu5
 NXAoTdkrma00NcvYe2Uii80Jad3QjECyVrO6rym5vKk8tu8SH77dbpcoZDqKArFSSh25M9RCj
 tUCuR1n/WjLbvDgKeC5tj1aUr8d1uDrqzuMQGg4dHxSCi1Zv9nz5j7ntJZ8T2y9Qkapb0C7P0
 S+B7rAPk7r8E545+5slHv9iHK/y5VsVI3BToCsQsGodjIQlZCAZsHVwFrQIhgAQAx4zKbFI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

[I was intrigued enough by your work to postpone to later this coming week
reading the What's cooking email in favor of reviewing your patch series.]

On Fri, 27 Oct 2017, Stefan Beller wrote:

> With traverse_trees_and_blobs factored out of the main traverse function,
> the next patch can introduce an in-order revision walking with ease.

Makes sense.

> diff --git a/list-objects.c b/list-objects.c
> index b3931fa434..0ee0551604 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -183,25 +183,13 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
>  	add_pending_object(revs, &tree->object, "");
>  }
>  
> -void traverse_commit_list(struct rev_info *revs,
> -			  show_commit_fn show_commit,
> -			  show_object_fn show_object,
> -			  void *data)
> +static void traverse_trees_and_blobs(struct rev_info *revs,
> +				     struct strbuf *base,

In the context of one function, it was obvious what `base` meant. Maybe we
can call it `base_path` now?

Thanks,
Dscho
