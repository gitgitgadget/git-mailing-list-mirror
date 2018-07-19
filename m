Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05261F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeGSXNH (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 19:13:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36389 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbeGSXNG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 19:13:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so9524181wro.3
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ma5I17yeqabXbaDnWnTT/hLD45IPtWw4h8jWtB3vqHc=;
        b=CY1sVQRuhKy1BJRwB7usxWR2+00PQe/1LdW3O1mkKrGrgv+GGrci1HpB73SLYPy1rD
         UaC7IPr3NEQbMzQ2IpVpmttjyO54uuy++R5F0xQIs0r0XQbUbZthqBgA9Dat6MdPgE4z
         3YLjg7SzXjDDSiCoYGY1QE0aBWU8AEybhIE2vAqdVBFMQejzsIm4eNErt5QUoX73fq7D
         2n1q9ROQgziINQqt9C+g39Wd/iIibdviKlTy1HTJ0yoFrfiWcFfsakpYFpW/f8fM3teN
         UOWWc2pWyVUg2hX6RoGDgmGJ/6uiXnk+DqzTgwCIywCbkqiMtD+vVUJhnPnuov5w+O0A
         ILdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ma5I17yeqabXbaDnWnTT/hLD45IPtWw4h8jWtB3vqHc=;
        b=J3IgxomPJxvgsSqAsQMlhBpTsGOmJrKqGnUZs/7wjGO9Ea7twr+ffoHmF3kk6AoQIf
         WrcjN5YyQAAWfhzcYXkgJpqqq7zcQDJhJqDItEpd79+46VP2Rnu92VSZoOGH9ERgxKqV
         YNmSt16Qssfshr5HOWm/jjuQP8wD3Nf0L9wFGcxnoanoqmd01NTfCap7UBqXzbSjhzl0
         IxinC/ZnqtRNH4yjUu7/sZonRZyM9sXQYGpK0lqQDR9MECFQ8YojgJeAI6IKtHzWCkMo
         8opU+S2oCfLE68J6zBQqNM/IfFATLBW0j59PgPkl3k37fZz9bLPOweOmsBM5nqlySbfD
         zHLw==
X-Gm-Message-State: AOUpUlHO8CNMnr4kOVXwh4vsCYlrMZl5kRpHWzTb70aZDrwPDR4sFRTa
        2YfIJxmQ/Klo7nP7E5Ys3EE=
X-Google-Smtp-Source: AAOMgped4Svc/zdEy2UGYnNc2zsxUzGZqrs73+mkiqU3N1P4xF+0qD4iOnKY7Baxl0Hhwpw9gGdpHQ==
X-Received: by 2002:adf:ff49:: with SMTP id u9-v6mr9377249wrs.15.1532039277312;
        Thu, 19 Jul 2018 15:27:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a11-v6sm214144wrr.81.2018.07.19.15.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 15:27:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t/t5534: do not unset GIT_COMMITTER_EMAIL for other tests
References: <xmqqbmb4lbhh.fsf@gitster-ct.c.googlers.com>
        <20180719121409.6143-1-henning.schild@siemens.com>
        <20180719141545.48358a26@md1pvb1c.ad001.siemens.net>
Date:   Thu, 19 Jul 2018 15:27:56 -0700
In-Reply-To: <20180719141545.48358a26@md1pvb1c.ad001.siemens.net> (Henning
        Schild's message of "Thu, 19 Jul 2018 14:15:45 +0200")
Message-ID: <xmqqzhymdfo3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> Looking at "what is cooking" i assume i should not add/fold this to/in
> the serien anymore. So it comes as a separate patch on top.

Thanks.  I only said:

     I think this round is mostly ready, except for a minor nit in the
     last step.  I do not mind merging this to 'next' and leave fixing
     of the test to a later clean-up.

meaing that I _do not mind_ merging the slightly broken one to
'next' and fixing it with a follow-up (i.e. this patch), but fixing
with a replacement patch so that we pretend we never made a mistake
that needs fixing from the beginning is of course preferrable ;-)

Let's squash this patch into the last one in the series.
