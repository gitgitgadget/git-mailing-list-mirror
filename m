Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C865E1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935934AbeF2QuS (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:50:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40488 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932428AbeF2QuR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:50:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so2742766wma.5
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ce8SYnm41yd2/adW+0RM+JLEdtPu9+K/BSaHLGXTsOA=;
        b=YfN6swZaeBYpGxJB5SdQ7548e/h76PELqMDOx58LGT42lmvdrYVX+jasUcXZdebVEL
         AXDV5mlwCnuDtHFd1dEwRp/pb+mkFIgOzqiAGF5FBtJQERTAgqU61b/pQ0kjDhVa889O
         KfwQ+PmvZG0WHeVF+oEEB4cIBS/ie4sA4+rU9VhnirriqmtYJZ7lK8ceIzrjb0QV22oH
         AUsS3ButNUBDrzvr0Z0Dg/ZtKA4FQozms1awHV6wCaeP0ScjZXpF0h3iee0Z2Aqn3nTa
         WW1yGKx3YMvFj4EUxBscMBHuFpepzyxBy+NkYDY2dJSe1rWqZKU3RQnAOeya9iJW873d
         Kk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ce8SYnm41yd2/adW+0RM+JLEdtPu9+K/BSaHLGXTsOA=;
        b=oDODnkXKVh3xuvMnvCQRwuAyg6kx39LLUSQEIVaPmfN+MPNacyAw+bbpKrFXDAY3aL
         PCUZCeV+sPxMN+9oeDmb9p9vJoQxOTSWUCarGfVt65fntRl6dte1wL+dN1oOWq92uzNn
         tFzxoS0Bbxe4U1dd1cQAlyRtJL0eyr/C7k/qFwgB+nyD6BBB+sjhYG6ALybzueKK+xnD
         xEMGgYF/w3rKe6WR36BZFphFl/8bbLXsVJaawidj5l/U2DdL8uGK5xkbwZ8Ic3GxCKW7
         oMpPXtS3OywNhKLPZspL5o2Nv52HvooPsNW3zUCcNjGg+3tKvZndsWjHlBQcDfO6n7NM
         M7mw==
X-Gm-Message-State: APt69E3i6szxCYWhfKEjHDn0EWwaeHVafFJou1qT0nULbvj9nGy5R+sJ
        yFCBOCWYxZAPFyv7mkP/2g4=
X-Google-Smtp-Source: AAOMgpf3zozgPkVh+NBh4qyVk839/p34dhOIbuRFfgT2o/LUNZ3C5ePQIsvhpouZw58gHFJgIGokSw==
X-Received: by 2002:a1c:5b0d:: with SMTP id p13-v6mr2353255wmb.53.1530291016190;
        Fri, 29 Jun 2018 09:50:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 127-v6sm2805754wmd.18.2018.06.29.09.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 09:50:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 2/3] rebase -i: rewrite setup_reflog_action() in C
References: <20180625134419.18435-1-alban.gruin@gmail.com>
        <20180629151435.31868-1-alban.gruin@gmail.com>
        <20180629151435.31868-3-alban.gruin@gmail.com>
Date:   Fri, 29 Jun 2018 09:50:14 -0700
In-Reply-To: <20180629151435.31868-3-alban.gruin@gmail.com> (Alban Gruin's
        message of "Fri, 29 Jun 2018 17:14:34 +0200")
Message-ID: <xmqqvaa1v8op.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> +	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
>  	init_basic_state
>  
>  	init_revisions_and_shortrevisions
> diff --git a/sequencer.c b/sequencer.c
> index d9545b366..dd0cf3cb5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3134,6 +3134,37 @@ static const char *reflog_message(struct replay_opts *opts,
>  	return buf.buf;
>  }
> ...
> +int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit,
> +				 int verbose)
> +{
> +	const char *action;
> +
> +	if (commit && *commit) {

The sloppyness of this callee is forced by the sloppy caller, which
does not check if "$switch_to" has any value before calling "prepare
branch to be rebased" function.  A less sloppy caller would check to
see if we have the optional "before doing anything, check out this
branch, as it is the branch we are trying to rebase" argument, and
refrain from calling this function, so there is no need for this "if
commit is given and is not an empty string" check.

And hopefully, when GSoC is over, the caller, that is still in shell
at this step, would also be rewritten in C and by that time the
caller will become less sloppy, removing the need for this check.

Hence, I think the reason why the check is still here, and our
desire to eventually remove the check, should be documented with an
in-code comment around here (the usual "NEEDSWORK:" comment is
fine).

