Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B157F1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 22:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932607AbeCMW1B (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 18:27:01 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:37686 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbeCMW07 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 18:26:59 -0400
Received: by mail-wr0-f178.google.com with SMTP id z12so2526071wrg.4
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SLOHbRoy11KMtyIlr2+2mYW7l7PlgWlhwvLLgOaq7qI=;
        b=WIYsLXkcCLhWa8i4zEgzPYygI/tTuvuyFeCPH1brbnnVtgEsLdW9RmMsUCqbpRsRE9
         1TemBr8PdVm48EId/WY8oVWhwyNPT1fU8wnUB8gphLeBK8Jjzu/ttVCTbhfZrRFJsayu
         dRVI8B6zpcxapYZZ8YISuoaW56U9LSXAX1J0dp2TiyLcSKsa1q7V4b/7FDUoFKERZxqU
         W8W+qCFPI/vaOLx+P3zLVyUK23yT5d+poomIbo6KA5tSOBfIapWpVw9WmOot9nCpT3QE
         RAUgSnXXo3Cglu33qx2R/UKiETAhPKueKHgk8vj0GFz2bOnfxQL3320cVCm8+u08l5Rx
         CzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SLOHbRoy11KMtyIlr2+2mYW7l7PlgWlhwvLLgOaq7qI=;
        b=gTT5LY4I/AabQXQQy1Ubuya0YHT6E7+bnEw2sHX4Ql/91fqAHGT5SgqRcOCvhlv4oG
         6JDyGuEo6SjcfELV+RK3psIXGoD60PYzBbE3R2Ts5Fyw4l0GiwBW4bJCl+Vfh0R7fn5H
         RSu1K8smXEW1/nhGqt7XFnZqSxbtnLo3ycj2M6laW8ehj3l3RV7TUEAoQAKXk9OIEKOV
         S6Tl5ULXzVkcNSZql2PGKUmXkUC/0UCYmjk9UDZMFOmdMAEpQFhPCwXIXlWa7ONdV477
         7G+zJ2+gCQVT5LbAujK7JEnECZA2/YGWQJB3ZAe7Uh2qBUjVLe8rYSaRGHuwCncN8eMv
         rjgA==
X-Gm-Message-State: AElRT7GYue4ko9NJMVZbgf++7vXV2hiSvPp5x8xsotkOJS3r380Kcv7I
        DNk5xbxA5Ougu9d0o4QhB3w=
X-Google-Smtp-Source: AG47ELtPhZNGUn4P+/Nf7PM+jUkfDtqpE4xkQLbDPS7eU8+nabEfoZhD/bQDmPGTCfAiYjLfLNrM7w==
X-Received: by 10.223.177.132 with SMTP id q4mr1875918wra.27.1520980017772;
        Tue, 13 Mar 2018 15:26:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 59sm1388984wro.57.2018.03.13.15.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 15:26:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Opinions on changing add/add conflict resolution?
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
        <20180312184734.GA58506@aiede.svl.corp.google.com>
        <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
        <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
        <CABPp-BF-LnGPx6vKzCNaFNi_fkxK-CpenatOVa2fvJRZHd0hZw@mail.gmail.com>
Date:   Tue, 13 Mar 2018 15:26:56 -0700
In-Reply-To: <CABPp-BF-LnGPx6vKzCNaFNi_fkxK-CpenatOVa2fvJRZHd0hZw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 13 Mar 2018 11:21:37 -0700")
Message-ID: <xmqqbmfr1uj3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Cool, thanks for the context.  I'm happy to go down this path, but
> there is one question I'd like your opinion on: what if the
> intermediate content merges have conflicts themselves?  If that
> question isn't clear, let me be more precise...

I think you answered this yourself after (re)discovering the virtual
ancestor merge in the recursive strategy, and no longer need my
input here ;-)

