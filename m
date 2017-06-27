Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF8120401
	for <e@80x24.org>; Tue, 27 Jun 2017 21:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbdF0VjF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 17:39:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35452 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753671AbdF0VjE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 17:39:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so6266791pfs.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NjXJFbMJHgy9KvB7Jj8sW7Oyi6DHHpTb+0Ncbd0rxcg=;
        b=NWadhIaKFM7I2N9JJGOPzTxx6bG0k0R6kBBjTiMjdrbOoTwQ4fuJwh1GmzLCFXOc27
         5px0A09GPBbx6v/qPGjZmu+EIYFuC4AQp2FZswnmJTCfkvS0N3g7yLe8k/CTJuxvuSD9
         rPljLw0yxvBa031xdfILnECA4atDVE9pzDten1vNL5urGduPFK9poIVrI4Qtl53k9Vus
         xmABwYI2fbgzRG52maWrHE4XNh8/GzjaMVEFI8rTYwvPjdWyyxwGAplrST+xRGGb3rXZ
         iY17qSb65PbAYapt/1TduikpQOGYXboMl5+wLTUZd1CIozTP9qsSmYCOGrufUaTInQWB
         RZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NjXJFbMJHgy9KvB7Jj8sW7Oyi6DHHpTb+0Ncbd0rxcg=;
        b=I7YLMLy66Abk0BUx0iUA4JuNKllIzonT+JtbrRhqydhCMxVNCFuqhmLCIE21dLQ3y8
         lv11LcmqkP1dYktqkHsJ14hsggPsW06lIW2N7YrEM/KPYrqS5hDJ3upPVpC8acQqf5VB
         FFromrwNslULq2a0pYaYZiX0j1y7ieDBRq4MGGspjTqTEeFXHFbowdM40xR3BMvnl5I3
         YnlsdAoPe0ApHSssjvV3izVtagQGOJ2nQ27OVJKvYR2HGpLgHiUENabyO/LQnWnMGSwK
         XHMdpEd98CVMfpqTR068gdiZEewKh8FY1S8tIO2oDtwHKPj3QYSnDaN4kIwytg2RYj3h
         iRVw==
X-Gm-Message-State: AKS2vOwlMAwOW0JFot+F67PRH3UOUt3WTQwBiIKQvUgvT8Wl3tmoqqv1
        GqvOV7vQ+PUajg==
X-Received: by 10.84.228.207 with SMTP id y15mr7974195pli.13.1498599543249;
        Tue, 27 Jun 2017 14:39:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id b7sm353016pgr.11.2017.06.27.14.39.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 14:39:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
        <20170225101307.24067-2-vegard.nossum@oracle.com>
        <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de>
        <xmqqmvd7wgc7.fsf@gitster.mtv.corp.google.com>
        <f191e3a8-a55b-7030-ebbb-3f46c74fdc94@web.de>
        <xmqq1sujnu1g.fsf@gitster.mtv.corp.google.com>
        <05fe5800-ebc0-76d7-579d-77f64a851fc1@web.de>
        <5128cdf1-39fc-59ca-5640-801777bac2fa@web.de>
        <xmqqshil1ex1.fsf@gitster.mtv.corp.google.com>
        <1374711c-2cf5-ae8e-16e0-7c10be253a08@web.de>
Date:   Tue, 27 Jun 2017 14:39:01 -0700
In-Reply-To: <1374711c-2cf5-ae8e-16e0-7c10be253a08@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 27 Jun 2017 22:20:37 +0200")
Message-ID: <xmqqbmp9yutm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Hmm, pondering that, it seems I forgot to reset its value after each
> patch.  Or better just move it into struct patch, next to the extension
> bits:

Good catch.

> -- >8 --
> Subject: fixup! apply: check git diffs for mutually exclusive header lines
> ---
>  apply.c | 7 ++++---
>  apply.h | 1 -
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index db38bc3cdd..c442b89328 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -211,6 +211,7 @@ struct patch {
>  	unsigned ws_rule;
>  	int lines_added, lines_deleted;
>  	int score;
> +	int extension_linenr; /* first line specifying delete/new/rename/copy */
>  	unsigned int is_toplevel_relative:1;
>  	unsigned int inaccurate_eof:1;
>  	unsigned int is_binary:1;
> @@ -1325,9 +1326,9 @@ static int check_header_line(struct apply_state *state, struct patch *patch)
>  			 (patch->is_rename == 1) + (patch->is_copy == 1);
>  	if (extensions > 1)
>  		return error(_("inconsistent header lines %d and %d"),
> -			     state->extension_linenr, state->linenr);
> -	if (extensions && !state->extension_linenr)
> -		state->extension_linenr = state->linenr;
> +			     patch->extension_linenr, state->linenr);
> +	if (extensions && !patch->extension_linenr)
> +		patch->extension_linenr = state->linenr;
>  	return 0;
>  }
>  
> diff --git a/apply.h b/apply.h
> index b52078b486..b3d6783d55 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -79,7 +79,6 @@ struct apply_state {
>  
>  	/* Various "current state" */
>  	int linenr; /* current line number */
> -	int extension_linenr; /* first line specifying delete/new/rename/copy */
>  	struct string_list symlink_changes; /* we have to track symlinks */
>  
>  	/*
