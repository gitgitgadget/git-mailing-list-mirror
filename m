Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60591F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeDECq3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:46:29 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:41008 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeDECq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:46:29 -0400
Received: by mail-pl0-f51.google.com with SMTP id bj1-v6so14655822plb.8
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PtA9CZTkOfYSrRPzGU7z0PrFcINDnL5USWbVRQxl0hQ=;
        b=fAxe9AEfs86003OQW6BslQvStEHCD/eWz2aOHSAqvmVfvV+HawrnOUKoEeTKkfBRD+
         1Ui/0hpZy++HjWjqXK4hvZLe1uIsNxVrlFX3CEDZ+YPQdkCG3ocLy/Clb5zSfUxtU7oE
         PRb8TGuNmrlkgD36c05LmrGEEg4ytnTRU9Duc5mQ8z2rTAnemYKE2mrHMz1WLZeGdMLl
         E5iNFpyUPIjBU5eLsr/Q9MZC8f5i0P1OAiudv1j/RGExiPh7tVLMLusG9P+Rz7gn6s0H
         OODj7OSd6yZRJ+HfFhjzIUX2UNzrwpkZz/FPQ/IHjC/pbCCpq7QFt5N1+50IaUJtQW0R
         BPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PtA9CZTkOfYSrRPzGU7z0PrFcINDnL5USWbVRQxl0hQ=;
        b=IwJw52PRfXdx4y7tjpkB8yMU5ywO/DeB6ghGcLp1eJgzMlv19ml4zwQiwty/7m5/FT
         0K3w/SM+8waq3xRiQ81eDfRbn8DF19s1dMvPWMwsg4RH7rejHD+Cjg4tS2Th/S7LmOKC
         gkhL4kRSquZCejJCcEoQklgFEeQ6+1Ks6dl1/TAvzZ6wWt2Bqa4MGMybYDbRsqigvBcN
         uWP0BNWr+c4gqsGuAQ9CBAZC1XLEy2y26rLpfhbBurwmQoYeivzYfH3hGo2G+MTrBBcg
         FNWqK5x+B9TnEPm0D5tCuMt/ihApDDmNCx5HeN3qerMb11jcXAXAFiolrRNEULyu2Maq
         XOaA==
X-Gm-Message-State: AElRT7FVd/GjHRSJ+QGQhzj3CxNDpvjOksO3/pN7DwgSXoU185KqXoQR
        RhUA6sCyHVpNgAQmV6vIx9bPrQ==
X-Google-Smtp-Source: AIpwx490TK8B49MXxpYatXerhxl9BtgslDAdg6fIvSQ73yIzVOaKRWv+UiWbnJAtMQaIojH0+igblA==
X-Received: by 10.99.115.69 with SMTP id d5mr13632717pgn.289.1522896388309;
        Wed, 04 Apr 2018 19:46:28 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id p8sm11200230pgf.75.2018.04.04.19.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:46:27 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:46:26 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] builtin/config: introduce `--default`
Message-ID: <20180405024626.GB31883@syl.local>
References: <20180324005556.8145-1-me@ttaylorr.com>
 <20180329011634.68582-1-me@ttaylorr.com>
 <20180329011634.68582-2-me@ttaylorr.com>
 <CAPig+cSk_H-Dh585JsynNfp1GSuXSkKay0Vo3Jhda6-vPdi6Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSk_H-Dh585JsynNfp1GSuXSkKay0Vo3Jhda6-vPdi6Uw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 04:23:56PM -0400, Eric Sunshine wrote:
> On Wed, Mar 28, 2018 at 9:16 PM, Taylor Blau <me@ttaylorr.com> wrote:
> > This commit (and those following it in this series) aim to eventually
> > replace `--get-color` with a consistent alternative. By introducing
> > `--default`, we allow the `--get-color` action to be promoted to a
> > `--color` type specifier, retaining the "fallback" behavior via the
> > `--default` flag introduced in this commit.
>
> I'm confused. The cover letter said that this iteration no longer
> introduces a --color option (favoring instead --type=color), but this
> commit message still talks about --color. Did you mean
> s/--color/--type=color/ ?

My mistake; I think I rebased this series off of the "--type=" series
and forgot to amend this change. I have updated this and the below in
the subsequent re-roll.

> > For example, we aim to replace:
> >
> >   $ git config --get-color slot [default] [...]
> >
> > with:
> >
> >   $ git config --default default --color slot [...]
>
> Ditto: s/--color/--type=color/

Ack.

> > Values filled by `--default` behave exactly as if they were present in
> > the affected configuration file; they will be parsed by type specifiers
> > without the knowledge that they are not themselves present in the
> > configuration.
> >
> > Specifically, this means that the following will work:
> >
> >   $ git config --int --default 1M does.not.exist
> >   1048576
> >
> > In subsequent commits, we will offer `--color`, which (in conjunction
> > with `--default`) will be sufficient to replace `--get-color`.
>
> Ditto: s/--color/--type=color/

Ack.

Thanks,
Taylor
