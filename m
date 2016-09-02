Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE8B1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 21:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbcIBVNf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 17:13:35 -0400
Received: from ikke.info ([178.21.113.177]:39192 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbcIBVNe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 17:13:34 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 496D94400B7; Fri,  2 Sep 2016 23:13:32 +0200 (CEST)
Date:   Fri, 2 Sep 2016 23:13:32 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/34] sequencer: support a new action: 'interactive
 rebase'
Message-ID: <20160902211332.GA28305@ikke.info>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <5ffec2e588a4edc4902e1ab3a2ec3a73a7c3625b.1472633606.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffec2e588a4edc4902e1ab3a2ec3a73a7c3625b.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 10:54:02AM +0200, Johannes Schindelin wrote:
> @@ -43,16 +51,20 @@ static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>  /* We will introduce the 'interactive rebase' mode later */
>  static inline int is_rebase_i(const struct replay_opts *opts)
>  {
> -	return 0;
> +	return opts->action == REPLAY_INTERACTIVE_REBASE;
>  }
>  
>  static const char *get_dir(const struct replay_opts *opts)
>  {
> +	if (is_rebase_i(opts))
> +		return rebase_path();
>  	return git_path_seq_dir();
>  }
>  
>  static const char *get_todo_path(const struct replay_opts *opts)
>  {
> +	if (is_rebase_i(opts))
> +		return rebase_path_todo();
>  	return git_path_todo_file();
>  }

This patch fails to apply for me because function is_rebase_i has never
been introduced before (no record of it anywhere). Currently, only
IS_REBASE_I macro is present.
