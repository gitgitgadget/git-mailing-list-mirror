Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F891F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeCMVfq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:35:46 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33528 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeCMVfp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:35:45 -0400
Received: by mail-pf0-f178.google.com with SMTP id q13so473104pff.0
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ldro6Tid40Qw7KJsYbVRjLmYZklLgfWvXSbwrJdYfOU=;
        b=cp+3soZhTJRCTe48vcHtW3qiDiT1j8kElZK00sE3kXWQ4Rd+ur1y5QHur0S2HxG+WA
         IqFfWSkWHqfyoUVHEIj6r2im5o5nl4i8eFOAQTgAtwWF9A0/xir13AXGRb/0dfRzu5HB
         BQUaRWImrmJHjayu9GZvqx8Oqrupw9VeR1VD4nkoAG/AKoUI3QaDeOf+u1jPkyU8xF/P
         hZ0n9ixtNyhas6TMgK2fyf+l/p5xsRw/flkIsiY77VIMLiNv9yRSNq/yn9vKjZqAC24N
         VDtqfOPXSA54Uk4+jfK2Pa9O9O/RCrWvmJ7xoywjFs8K176hH75XNPs96znpne1bRo1V
         GktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ldro6Tid40Qw7KJsYbVRjLmYZklLgfWvXSbwrJdYfOU=;
        b=boDY6EPRFdSA598KjMqv/zvK1bIsnE1BcvUPWjyYgYmReYThUwk7qD+pvIM5AGb2ha
         bVs0mor7nNyk8i4xXc63Qel4yF8SJoeaczG0y6LioO0HDpzTA4UicoY9+FOIygAz/h7y
         USyqATQqRcCgh2ebToFFKq1mctC4ipCSiLJvN33XuJoJvjvbBG0UCDTQLAzqhzRv84Y4
         IU0d0PxCEYjNxrct0QBqH4rpVPmPTwi1/m7Cz6kCAurxXrrxzIDEnHdhzl6i7FUb83jb
         wkWvcyX//Z+30x6dmxmc8EBG+ZXk1a1tRdjtoP+Yhbe3B7Jk2JaIVNqjsl/ofbi+LCHW
         H3QA==
X-Gm-Message-State: AElRT7EkauX4MDoCdnR98ttWlDPeh/SRiwnpa+0WX38C6FF1OhldxNOR
        LPAN9iWp7zLTLLOF+/BIstqI7g==
X-Google-Smtp-Source: AG47ELtBtKiXgWPq+4uvTBJQw4iaAO8rPtE1A9hquVJrMoaHVvW+qSHxWdmsvAL3FjvrbkUxQk6S4A==
X-Received: by 10.99.127.92 with SMTP id p28mr1677870pgn.305.1520976944875;
        Tue, 13 Mar 2018 14:35:44 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m3sm1369037pgd.3.2018.03.13.14.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 14:35:44 -0700 (PDT)
Date:   Tue, 13 Mar 2018 14:35:42 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 12/35] serve: introduce git-serve
Message-ID: <20180313213542.GE7638@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-13-bmwill@google.com>
 <xmqqzi3qb3if.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi3qb3if.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> > +static int is_command(const char *key, struct protocol_capability **command)
> > +{
> > +	const char *out;
> > +
> > +	if (skip_prefix(key, "command=", &out)) {
> > +		struct protocol_capability *cmd = get_capability(out);
> > +
> > +		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command)
> > +			die("invalid command '%s'", out);
> > +		if (*command)
> > +			die("command already requested");
> 
> Shouldn't these two checks that lead to die the other way around?
> When they give us "command=frotz" and we already have *command, it
> would be an error whether we understand 'frotz' or not.
> 
> Who are the target audience of these "die"?  Are they meant to be
> communicated back to the other side of the connection, or are they
> only to be sent to the "server log"?
> 
> The latter one may want to say what two conflicting commands are in
> the log message, perhaps?

Yeah I'll switch the order of these checks as well as print out the two
commands requested for better logging.

> 
> > +		*command = cmd;
> 

-- 
Brandon Williams
