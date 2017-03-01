Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4C22027B
	for <e@80x24.org>; Wed,  1 Mar 2017 22:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbdCAW67 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:58:59 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34201 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbdCAW6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:58:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id m70so9704972wma.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 14:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4zQf5xrwOTmGSpCxEXwweE/FgFvlyt/T4S+mVC9EqxY=;
        b=q5PDwBig1qNFQX/3cwNDdhfR76JwWFsL1DZYEl4hrcq8AOEL8dSRdWo7OCeNziD6Ll
         ztXlKPiIgWuUXm3aL66oq3eYiM+P3IQfY2NxogxRPpEfIW8ONnxvwHyvNcIXRbj7qy/K
         nprtzgboZxSaCkW91Pael6XpzKr8PnBEbWouXyyPlm4vcsOImqnfRAmqsl+2ajDtBe4+
         8KOvzOO7DmOUwfGXXUEDw78WIPBY4fTN7TRJgs3vlA5dOgNegm8At9Mk0QB4OmEQEEMp
         uXXZwFJiWjtIa8uZBYIAoTbG2NgxDSHd+QRIKvVvUWSJ79GAhXOf/0p8pa6vAclFi4z7
         049w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4zQf5xrwOTmGSpCxEXwweE/FgFvlyt/T4S+mVC9EqxY=;
        b=WrdTAJYEwkQZaMdoxaQwHmw4dyA3G9qoIJjFWq8ZFHiFzgvdoIA9qSKXDsapKSu+Og
         7hag8XaYQUscKpCuqEI5+95r7MNs9xaNPDmxUdUohNj0oB6CoWkDINkWZ4ov968jAwEx
         WMWFPJBxOcezspuo0J69DotZUOv4dEZJamIXQ8VpIQziY/XuNL4oCLL1t3WZihuJ83YF
         3u4neFR8BzE6adaAIaOdc4X8GWOudn4bxW7uu5fBqbYYBJiuad7z4sgLw+LiU8Oz+wK5
         qRK+CtOojZZT7hzoES3+wJe2CLM0TFXAeTtsXspdUdvtbzvRghVSHUVaheyBUWuCofkV
         7DwA==
X-Gm-Message-State: AMke39lujopP/87y6OKB86/o+VdLm48USZVsSOuOvB0pAfxpGOqV7sXYzxyUnNPYaRrK2Q==
X-Received: by 10.28.31.130 with SMTP id f124mr5021747wmf.130.1488405478159;
        Wed, 01 Mar 2017 13:57:58 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id n13sm8204324wra.17.2017.03.01.13.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Mar 2017 13:57:57 -0800 (PST)
Date:   Wed, 1 Mar 2017 21:57:59 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 4/6] stash: teach 'push' (and 'create_stash') to honor
 pathspec
Message-ID: <20170301215759.GA11067@hank>
References: <20170225213306.2410-1-t.gummerer@gmail.com>
 <20170228203340.18723-1-t.gummerer@gmail.com>
 <20170228203340.18723-5-t.gummerer@gmail.com>
 <xmqqo9xmhshd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9xmhshd.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/28, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +			git reset ${GIT_QUIET:+-q} -- "$@"
> > +			git ls-files -z --modified -- "$@" |
> > +			git checkout-index -z --force --stdin
> > +			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")
> 
> I think you forgot to remove this line, whose correction was added
> as two lines immediately before it.  I'll remove it while queuing.

Yes, sorry.  What you queued looks good to me, thanks!

> > +			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
> 
> Thanks.
