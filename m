Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030D11F804
	for <e@80x24.org>; Fri, 28 Dec 2018 23:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeL1X0D (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 18:26:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38982 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeL1X0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 18:26:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so22142630wra.6
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 15:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CgLJ/4Ohr0T283riqV7pcIPO0Ly0gOOyeM8PQMh7SDY=;
        b=KEM009LsRd6DHuZIcAzo3FV4s+mHzCMIVxj7ei+g7gmBzsWex9FwMfF/iyJPmMwAU1
         k6tYQ8CUfFlScoagT5JprtbrefwEcgTWETlbZpMhz1mrI3ldIzAUCYNp3BY5nqVLvnUQ
         cynSLsvdnZbE5/HuJ+kWaRziugVqpbu8g8XJB0pPHauYKD7fO4EP2o/6KuKukk4QyIpp
         PcysH9caBBaPrmtR/Aeey+1GIDikGzgNz55n6sPktxHQ9VZcoeZLiKpfpnAYxUHSnd09
         GYj+DK3EI8jHGc2ZTaPwftKEufL/5yawh2VdX19P03BXCnRX1usCDXmqbddZlMaue7jy
         zOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CgLJ/4Ohr0T283riqV7pcIPO0Ly0gOOyeM8PQMh7SDY=;
        b=cEXkwAIW9GT/8DoYrcsKrXc0NNEbWfccrNTYQAL9JZ6kl0fGhaIbU5k09uQn8JLDGd
         UuuDSebiHoOtvOWViG8SAplbOom/jL9sY+9MTU4pS2b1Dnupq/nYj19QY67NLWVWinpb
         EucM+hB6Mg3N7gc37GmaYjMETGscf5odVaxaTONKiT5zZZQNaE8fg6xiGl4GomfBu9fq
         1JMW5zpyIhxSIi+K2RY82kLBZhWyaRes4J58DeWDYeDYiEMPy8h+DzvZ64D7fGaUZwKN
         PhQoSA6Mu/ahMNmDKvFeNtf62Jlzvhjp1H7612SKySlhAPVUCepccK+bEUgEOUwbfIJj
         upTw==
X-Gm-Message-State: AJcUukezvViU/O3aBTidlzmrRsnUB/UMlvb7eBgVfmecvC8taQt0mpcD
        35vjulQ4FdLjAXiTeG4hK0U6bnMt
X-Google-Smtp-Source: ALg8bN7Z8KLD2DO6azl5F61mhcyhnI7mwMLgQKplP6j3eiiz93hrX5OqMoc5XDFWzGLb2ubNHzUFZQ==
X-Received: by 2002:adf:c108:: with SMTP id r8mr27649030wre.233.1546039559768;
        Fri, 28 Dec 2018 15:25:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p6sm42018805wrx.50.2018.12.28.15.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 15:25:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chayoung You <yousbe@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: escape metacharacters when completing paths
References: <20181226160835.66342-1-yousbe@gmail.com>
Date:   Fri, 28 Dec 2018 15:25:58 -0800
In-Reply-To: <20181226160835.66342-1-yousbe@gmail.com> (Chayoung You's message
        of "Thu, 27 Dec 2018 01:08:35 +0900")
Message-ID: <xmqqefa1kzcp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chayoung You <yousbe@gmail.com> writes:

> Subject: Re: [PATCH] completion: escape metacharacters when completing paths

I am not a zsh user, but from the patch text I am getting the
impression that this patch is only about zsh.  If so, please help
readers of "git shortlog" by saying so in the title.

	Subject: zsh: complete unquoted paths with spaces correctly

or something like that, perhaps?

> Let's say there is a file named 'foo bar.txt' in repository, but it's
> not yet added to the repository. Then the following command triggers a
> completion:
>
>   git add fo<Tab>
>   git add 'fo<Tab>
>   git add "fo<Tab>
>
> The completion results in bash:
>
>   git add foo\ bar.txt
>   git add 'foo bar.txt'
>   git add "foo bar.txt"
>
> While them in zsh:
>
>   git add foo bar.txt
>   git add 'foo bar.txt'
>   git add "foo bar.txt"

You leave it unsaid what you think is wrong, and what you think
should be the right output, before saying "cause of this is...".

I do not think it is given that "git add fo<TAB>" should be
completed to "git add foo\ bar.txt".  It would also be OK if the
completion produced "git add 'foo bar.txt'", for example.  So what
your ideal output is is rather important, and by doing that you end
up with saying what problem you have with the current output is.

So, say something here, perhaps like...

	The first one, where the pathname is not enclosed in quotes,
	should escape the SP with a backslash, just like bash
	completion does.

