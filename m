Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276311F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbeGJTW1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 15:22:27 -0400
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:51857
        "EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732337AbeGJTW1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Jul 2018 15:22:27 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id cyCvfHy0AZinvcyD1fCbGY; Tue, 10 Jul 2018 12:22:01 -0700
Date:   Tue, 10 Jul 2018 22:21:53 +0300
From:   Max Kirillov <max@max630.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: do not fail reset because of unmerged
 skipped entry
Message-ID: <20180710192153.GA2050@jessie.local>
References: <20180615044251.10597-1-max@max630.net>
 <20180616051444.GA29754@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616051444.GA29754@duynguyen.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfMzaLToaI54DBr5R1DwjAAepOKo4LerIHUZ1fbeNJ4Ncb7itdcDhpKXfTexDG5TIZDm4OX4IoeSLp9JL53YG1D7EH02023bX3Pgi808VH+xu3hHccaFZ
 t4G+kMvwrATwZmKtvmBIAaioRhp7dHOh+Ftrp2zViRETbRvkvNQeR/liZKSitBbVgIXz4Lh4Rn65K9B1q9MCk/FWRVkftEcm3Sp4f2MDt/xc8FqzPTuepi1K
 tfu7QtmwaNk2Yx+OT0D2/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 16, 2018 at 07:14:44AM +0200, Duy Nguyen wrote:
> -- 8< --
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3a85a02a77..eb544ee1b3 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1246,7 +1246,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
>  		if (select_flag && !(ce->ce_flags & select_flag))
>  			continue;
>  
> -		if (!ce_stage(ce))
> +		if (!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED))
>  			ce->ce_flags |= skip_wt_flag;
>  		else
>  			ce->ce_flags &= ~skip_wt_flag;
> -- 8< --

I tried your fix and it is working. I put it instead of my original fix. Would you sign it off?
