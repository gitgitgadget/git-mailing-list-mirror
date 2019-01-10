Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2681F803
	for <e@80x24.org>; Thu, 10 Jan 2019 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfAJWTy (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 17:19:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33846 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfAJWTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 17:19:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so13208238wrw.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ghLqNZ1Kttr1rnBp1rWRtQDiSytPleTQdPwL1IjIaQY=;
        b=Z3is4g0Is1fetJEFC65UlRyfgcvpt0r0HagPoapx9eupEL4kUMxh/u2zZFRhtPBQYn
         SuVAv+geNAn5MTCf5J7QAYnUqutyiRH6TjlkbkvIgNoJOSj2EPDf3SemkS6+fiRa+n3k
         FkEv3wObG7LbqvRKVarU9ZKf/fUB9OiUNoSyVJpHRct95SPUAeMDjR3Joc2w75uJUTpH
         Ck15KwqEbxmPsp5AvAB1h2GBGKidBp6FTpgy0MY3uaxJFpW7mcxRbYwPdx0uyzzw1mER
         aCSXIycu3r9tU0z28XxWVw8lXmeNWR71LEKt/dHj9Ruq1+TAT7RLXQYS7TXC5mgn1P5X
         wBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ghLqNZ1Kttr1rnBp1rWRtQDiSytPleTQdPwL1IjIaQY=;
        b=kA4A3yhGL6tPO565Q8Mkjsxb9FnBenNR4X/aQxFKEBmjqFe9U2ueW5SaDNzM/b/qB2
         MiQxMVTM49GJxnxmNEOoSebRN04Q/Xp5mwF7Szp61lGib8N/wf4zwRmcaP8OFjEUOIDp
         vaimzE80q1PzpmwCtTkwUD2OWh7y5dW1coiWZEmH5KMZJZEeczA5d3FRbFHXr4tXvqDE
         agreRtwQOR4WWRW0TmetJPqFoz1WXirvCSk7nWp68RL9RrAA1MxCWL2ZSNZ19uSKfrRx
         JLOMB0Ykc3DpQOzisDQ/Htk1zf1kq1LFlBBOrdnhcs4OfJHixXti7PDMi37UzsPUBPt2
         bNNA==
X-Gm-Message-State: AJcUukdBcTf/fJTwK5yRMDeUcdS9Ptc1AtBqiL3Q2G1csAfk284L3K/h
        IU0nb2eV/jVYJKIqAG6fae5VFcI5
X-Google-Smtp-Source: ALg8bN7kdxcE/6F/jVtNQhWQLNwDLLVBKIEW0px4mHEO7JhDTj8rv312H5NxwEXwYn8fPMoKqQx4IA==
X-Received: by 2002:adf:91a3:: with SMTP id 32mr9941329wri.99.1547158792352;
        Thu, 10 Jan 2019 14:19:52 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j3sm16679731wmb.39.2019.01.10.14.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 14:19:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Make "git log --count" work like "git rev-list"
References: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
        <20190109195428.GA12645@sigill.intra.peff.net>
Date:   Thu, 10 Jan 2019 14:19:51 -0800
In-Reply-To: <20190109195428.GA12645@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 9 Jan 2019 14:54:28 -0500")
Message-ID: <xmqq5zuw17g8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But does this catch all of the limiting that git-log would do? I notice
> that it happens before the call to log_tree_diff(), which conditionally
> returns a "shown" flag. So you get weird results with some options. For
> example:
>
>   # works, because pathspec limiting happens early
>   git log --count builtin/log.c
>
>   # doesn't work, because --follow disables pruning
>   git log --follow --count builtin/log.c

Well, that's a bad one.

> I know "--follow" is a bit hacky in general, but I think there are other
> cases where log_tree_diff() may decide not to show a commit (maybe
> without --root, though I guess that's the default these days).
>
> I dunno. Certainly respecting "--count" even for the simple cases is an
> improvement over the status quo. Maybe it would be enough to give a
> warning in the manpage that it may not work with exotic options.

Hmph, perhaps.  I wonder if it is easy enough to redirect the entire
codeflow to that of rev-list when we see --count in cmd_log().

