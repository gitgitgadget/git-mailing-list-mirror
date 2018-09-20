Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643EA1F454
	for <e@80x24.org>; Thu, 20 Sep 2018 14:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbeITUWS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 16:22:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45129 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeITUWR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 16:22:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so9645530wrb.12
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mgt5yCpm3E7agmOdq5JoRueN5FSl1L6/mYIH9CEOJt4=;
        b=mGmPU/2gHWXRSQeItVuWv5/9Djh4fi3kGNwYmYjHjV3RkjwwvvMCoRltIfef6LW93u
         bI7AXp6rE5goABBFR0fjVZzl2WznDPO6Sp+CLxaV8OWgH6cTZ9Rl49TqitL/JqI93k7j
         K6xNU49wK5f0Lr+Z50OBKIOt8jyLlKXkrosadI5btLjhxVOcoggiMmA4613zsfZlgARF
         8ZvPKsKyWxnXbj0xJR0ARTC7e0AchC0vyKrEWyds7O9o/70Wf4X0/nQ0KGGakUEl2o+6
         4VS44x3RB5bycOP5FSudCUrdTvZnYL4eaDZ6eDFuhtA1P1G/08PCcEcXm+FQ8leq6jQm
         3CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mgt5yCpm3E7agmOdq5JoRueN5FSl1L6/mYIH9CEOJt4=;
        b=OcoD2hY6JJ55JrXggD19mARibqrcFVxSXJ8SrZ6KBlItD7GLtivvTgQkjEtcCw1RS7
         ZP+xmw67SYJgz8DnskPZ6sXmYtrrs2rR3gpZ/Ddpb65wQWptGmVD1MnX66yO7a1hr8B2
         X1QVPBmgr4MYhDiyJHiqC8TDK/qHtrbYyZopB+mVEkcQwvIGDa5/Ii+GmW7Jf5ttS6yA
         c6OIbovegVOrllTbTgK1N0CFaiCDc56UH8YMAH2E+Otys3zKQ1o28bxDEddLMNnAeZMu
         TeHwc4xW8e9iF38rSP2HANGULf9ja0YqtXyeIt0ZuoUzVhNjmGy88KtmW/eaTNfPOWhk
         hOfw==
X-Gm-Message-State: APzg51C0WI2jbZZlPrntD8v3cDHLXmPzYk4PMsuzcGdsFDUKjoMjb1HB
        WkbT46iSyLYeB3AFcPj5igQ2gqRk
X-Google-Smtp-Source: ANB0VdYkKC1u2UNt3TSBRK9xN3sa8qhLPvpjbnmnTYLh4AvW0c6wU0RBO5fJAsPfhGawMyCcoMcoTw==
X-Received: by 2002:adf:d245:: with SMTP id o5-v6mr34385182wri.91.1537454308514;
        Thu, 20 Sep 2018 07:38:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x24-v6sm38675318wrd.13.2018.09.20.07.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 07:38:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     KES <kes-kes@yandex.ru>
Cc:     git <git@vger.kernel.org>
Subject: Re: Work is not replayed on top while: git pull -v --rebase
References: <6160201537441514@iva5-cb9df376e345.qloud-c.yandex.net>
Date:   Thu, 20 Sep 2018 07:38:27 -0700
In-Reply-To: <6160201537441514@iva5-cb9df376e345.qloud-c.yandex.net> (KES's
        message of "Thu, 20 Sep 2018 14:05:14 +0300")
Message-ID: <xmqq36u42pzw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

KES <kes-kes@yandex.ru> writes:

> PS. for `git push --force` there is alternative: --force-with-lease
> Is there something similar to --force-with-lease but for `git pull -v --rebase`?

Curious.

For "push", you are competing with the other pushers who want to
update the repository over there, and there is need for the
force-with-lease=<it must be this verison> safety, but what is the
reason why you need to take a lease on your local side while doing
a "pull"?

