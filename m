Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BC41F453
	for <e@80x24.org>; Tue, 19 Feb 2019 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfBSTK2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 14:10:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33454 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfBSTK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 14:10:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so23292663wrw.0
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 11:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gcjNi8vn7I9/Q9JhugSQOkbCuKLazxDn2QEYayauaPs=;
        b=j4trVaPHSJfleaeMg86mXsgsjpZ5qu2hBaWMVDqm93JnU3hB1H64/34Lh0ESEjQ+oc
         DCJYoAZO0sKFGontBuEoZQgVGsunvoyLLGqfyQjT4WsHf3zq41t6SFRbKO9S+xdV1P/6
         d6IQwJROe1eGd8L53itbCfTha/7/pL/JQV1szMjLkgW8AyU+2m16LVD+DLopqhQDJQ7f
         CXagqpeJbW6nZ5tboTOY/nGMx/chCGdZZcqWjHImVKgPbarH2YEwQBwDl/6OyT4tOKzp
         pKNFMtqpYKnpuLkUpHVXpFHrX2EJj4+OMPtobYX3Z7DSGEjvZOuESCJH7u6tPQ2w5aKH
         N4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gcjNi8vn7I9/Q9JhugSQOkbCuKLazxDn2QEYayauaPs=;
        b=cCtfNpSJuGm1IGd55NNbB/mwQcZWP5KekWp3na3b4a59IY9vmSeU0nlNeJGf8HyKv8
         vZf1vWyp2aoNIekJ3/EArL7U8ZbiK5tksLn/rfIwoI5skoVVOlNAI7pmdQdzFWeS3hGW
         6cs6Q9Gw/xp7g3PEL1Aa+9fGzTe1y8yQVrK0pZHaYMCpQSLmDsIhnm/DH7z5HanbSFtu
         kR4XTrKEULTQKs6wnpV44dis97RQ/Rs1qZzkaCOneUAVLnoiY5Nh3bWNEdMBjfoRMQRR
         3lmVbi9wc8w0zhm+8gz81Hj+EhZ9iPM/Tn2meVAFIVyAUczIbi2ArAtlfc1Ij6wVeFny
         KOGA==
X-Gm-Message-State: AHQUAualoZGDBg7YQFpw+9HBaG1N8eyZwcfVf+B0D5dVDwB53yxbhOwK
        Ppvoldyljo+NPrGzGqBWmYE=
X-Google-Smtp-Source: AHgI3Ib4F0FzTqItZUrgyPMWKxu1gxzqc42NBvoZTXVUWoTW4T+SyJmXOexgv6XCAZE2cfmabVESEA==
X-Received: by 2002:adf:f60d:: with SMTP id t13mr21445467wrp.225.1550603425953;
        Tue, 19 Feb 2019 11:10:25 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p1sm9341112wrx.50.2019.02.19.11.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:10:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] checkout: add --cached option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-7-t.gummerer@gmail.com>
        <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
        <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
        <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
        <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
        <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
        <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
        <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 19 Feb 2019 11:10:24 -0800
In-Reply-To: <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 19 Feb 2019 11:02:59 -0800")
Message-ID: <xmqqo9771tnj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am getting the impression that to save typing, you would want to
> make "--index --worktree" the default (i.e. among the above, only
> --no-index and --no-worktree need to be spelled explicitly), but
> there is one glitch.  Updating from the index must be spelled
> explicitly with "--no-index --worktree".

And after getting reminded by Elijah, the default pair is
<--no-index, --worktree>.

> So perhaps the defaulting rule for the "--index" option must become
> a bit more tricky.  Perhaps the rules are:
>
>  * --worktree is the default; --no-worktree can be given from the
>    command line to countermand it, and --worktree can be given from
>    the command line to be more explicit.
>
>  * when --source <tree> is given from the command line, --index is
>    the default, and --no-index can be given to countermand it.

Correction.

    * when --source <tree> is given, --no-index is the default, but
      --index can be given to countermand it.

>
>  * when --source <tree> is not given from the command line,
>    --no-index is the only sensible choice.  It can be given from the
>    command line to be more explicit, but giving --index to
>    countermand the --no-index default would be an error, as updating
>    the index, whether the same update also goes to the working tree,
>    must come from a --source <tree>.

This is still correct.
