Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AADA11F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbdB0WEs (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:04:48 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36691 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdB0WEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:04:05 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so15497531wmd.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aGlWZxgkRysBfvPTHj3I9pwFhvT6I2sg7sS5IpOyKHA=;
        b=FNG1h7sHqBSg6vOcmBhtoceUu5r88E4odgFdlZqGOBcFFd6QVExplJBz1RHdslCDGt
         1Xoi7Mwk99OLtZYpNCP6CQ8BWuAYjHuypf765XweZSKkhjr0rsV7JhITm0o4Ek5ExSxp
         K6JhQiPaL5Fd3iEKNJzhczA3/05SxvxvroSSEJsBbeyafORKrGyNWTKri1mT/eCZhWFr
         R3pYV+jgmWHsU9rSoCIk/3I5SuFZaVyUKc9dRHluhj8zULhIT4faL0cqLbAxDzOFTLny
         GxbV4o9gJP7eN/+fm7vYolaP8+L/an8Saz/l5Sqypk6/fGnpG91siZ2HJSGcxTuvZFBi
         TJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aGlWZxgkRysBfvPTHj3I9pwFhvT6I2sg7sS5IpOyKHA=;
        b=Xm8qPZtAtWeygUKKMqR20ObhpNvtcCnLDuUIpSKfCk29F+3FJKtbONZBAWGy5rpjR8
         Vd6Zo47uJcaALUtSTOmjHTVeriuYf+dr8+nYlh6vVx17smA2GViqnk35lC1eQVmMMf+i
         lIWctbccysHOmcGfJWNVtnYuySExi+xw3H/Njg8P2y9kwlLghtU6OMNAjNdNRlvhTiqL
         HtOwmmrOi5trZI5cO3g4RaYDq+gCGg2Pf4ty/NRmzLb2FgdZn2WG5KSv/EUfynLgE7bZ
         Sl7yaKGqxf6x1vlPS+9ZcrJVQpFE+DVzZxmO+Z2eh7IToUYq05LEZO95/kDm24OFNbhD
         A6Ew==
X-Gm-Message-State: AMke39nozr6rO+r3edqFI7EvT+ZGxEm6IqmDkHHnUrGl5Vzne9038jixjQNJEnyCRGLvQw==
X-Received: by 10.28.102.86 with SMTP id a83mr5387738wmc.76.1488232587513;
        Mon, 27 Feb 2017 13:56:27 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id v18sm11090415wrc.41.2017.02.27.13.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Feb 2017 13:56:26 -0800 (PST)
Date:   Mon, 27 Feb 2017 21:56:27 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 4/6] stash: teach 'push' (and 'create_stash') to honor
 pathspec
Message-ID: <20170227215627.GB17065@hank>
References: <20170219110313.24070-1-t.gummerer@gmail.com>
 <20170225213306.2410-1-t.gummerer@gmail.com>
 <20170225213306.2410-5-t.gummerer@gmail.com>
 <xmqq60jvwewc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60jvwewc.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
> 
> This silent "exit 1" made me scratch my head, but --error-unmatch
> would have already given an error message, like
> 
>     error: pathspec 'no such' did not match any file(s) known to git.
>     Did you forget to 'git add'?
> 
> so that would be OK.

Yeah exactly, the plan was to let --error-unmatch print the error
message, as it's better at giving a good error message than we could
easily do here I think.

Maybe this deserves a comment so others won't have the same doubts
about this line?
