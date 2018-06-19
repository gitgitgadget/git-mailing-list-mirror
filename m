Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57EE21F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966516AbeFSQtZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:49:25 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:53176 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966368AbeFSQtY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:49:24 -0400
Received: by mail-wm0-f51.google.com with SMTP id p126-v6so1508374wmb.2
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vE3/YBOsG9JsuRxet2fY4zr1DN/Wbib7m7igYU/LInQ=;
        b=pyTPigV1qQjuXxWGwPp2BclhpJrXRbbz31S+tGdGZfqCCKF30oJwJYORwmgw8veWiP
         PXUXw4imPMu73FC1ySh2KlndtSEGSMyaqAlyO4Z+6nKSXi+rz15J12rGwHtEF0II371T
         JyKY0Pg+evBw+Pfgc0ZhZ8+fYUXjr8HIQSJqRFGuVYrqhnBbP+OWCT5f7jGFE+S1/LK+
         r4j3jvdVe9QbFBPaNWJgktPOInNW+oumqjoFcV3tC2jfkGlAIMgIfE0Fo4PinphM62I/
         Np8BDIYn4Y4v+eDnADIy8EhLy7k5blO8nrzoI2qiOCRamXALVYYGvfN82Bm2BRBlEzm3
         9zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vE3/YBOsG9JsuRxet2fY4zr1DN/Wbib7m7igYU/LInQ=;
        b=IOi4Dmz7q+9w9r0J3BSB1liTCtLKZSl8EWCO7HYDoJbhM5kS943UqhIIgHm+2rnBw7
         VcxLZpyTwKbd0z4AAgohBgXnD97/Vwj9/gY5t/uGQXFe5/Ff2i5lbvfD3/0+4WdOi4f0
         ip6X1w9SCRxf6PowF8Vc8/fKAryAB3pKvPqrjLTrivuWdo0oc1UNg4nLsQKiyZYZbGJk
         ngtD4CZKfyhrsj1A8sEFTDXOVFJaHccuVnBd8Ma/+hNLyWTa4omZIJhLmOVuG1Wzx+mj
         GaL0xMgg0CL7J4UcYWswz6z9qSTutsm/SgxjG3rP1rFsQUDb5tg8X9xSgR1gAqD3HqnL
         MuEA==
X-Gm-Message-State: APt69E1BoQqtzbJIKKoT9m+DyGWqmy2FvQc/oTvvtaAwlYarS8cXtcq/
        umDHszjl6xYdI9oZspXvcQg=
X-Google-Smtp-Source: ADUXVKJvIfaaG2MRExB6SdDxNAfcrq56BzA8a59I3TwtUA7uRYKjOI2CO3pivrPLJed9RYNmrq99eg==
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr11740448wmh.116.1529426963007;
        Tue, 19 Jun 2018 09:49:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g16-v6sm71704wro.86.2018.06.19.09.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:49:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/7] grep.c: expose {,inverted} match column in match_line()
References: <cover.1529365072.git.me@ttaylorr.com>
        <d0a6b3ca2a8e67c6a5ed4d2c56c5121d4bc3554b.1529365072.git.me@ttaylorr.com>
Date:   Tue, 19 Jun 2018 09:49:21 -0700
In-Reply-To: <d0a6b3ca2a8e67c6a5ed4d2c56c5121d4bc3554b.1529365072.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 18 Jun 2018 18:43:08 -0500")
Message-ID: <xmqqwouuvi0e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>  	case GREP_NODE_NOT:
> -		h = !match_expr_eval(x->u.unary, bol, eol, ctx, 0);
> +		/*
> +		 * Upon visiting a GREP_NODE_NOT, imatch and match become
> +		 * swapped.
> +		 */
> +		h = !match_expr_eval(x->u.unary, bol, eol, ctx, icol, col, 0);

A minor nit, but the comment talks about something that are
different from the variable names; perhaps you called col/icol with
different names in an earlier incarnation of this patch?

