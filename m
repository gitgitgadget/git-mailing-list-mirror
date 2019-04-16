Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8861820248
	for <e@80x24.org>; Tue, 16 Apr 2019 04:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfDPEYw (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 00:24:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42824 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfDPEYw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 00:24:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so24864374wrx.9
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 21:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UXOioU2FwkRag5yDnsv0qvsudcaRW+KNUvrkoyNMqf8=;
        b=mUtU04w8NWpXHt7NHfwm10Wg99Yi8kaUl/UCGonWzuQ+T2fooOsTCQBv5Dk7mftMkx
         ropvnq8Ri3L1zEQdfhdOzGt62I1IVyKPjS5LXr95sC4hc2VkaszIlRyrq667QkgMcbgs
         DwxdctPJmLzNZIdXWNF5X1A1Xk8ZeNcz3AuP2oIlwThgCuS4DSz/ucG4JOitRVRXeQyZ
         xuElAFm6vLrMsDHsD7NrkN+niVoNez7p5A/VUtI1necyCpF8hxSc454mTcECUlieywog
         /rObhmO3qWbzQErlwqjfZGsAEr6BQKXuUJ+tcLWHdaArMbNCYkoMzzmEYtMHVf3QCOQ6
         qA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UXOioU2FwkRag5yDnsv0qvsudcaRW+KNUvrkoyNMqf8=;
        b=iLrNrE8j9ISEm3Aor4zYXOCUqGAIQBe7sD7LLj8JEC2VnrBA0ucpXheaxt+IacWKZc
         GbaPagJ/+pWs2Whn97Ik2yG16k3usw7ziWKgPKwsA0i0YUXUj/CStf0DMPiLC6W9A+jY
         8edjecpMQ8tuaf6I9Q1dr7dpG0cojZ3VUAWF8WUVdc6fwSN1QGxUrtId0w0uT8JKpW5j
         G9WTlv5wPpLSF6ryAxqsU91O1CJeSSRGvEtsXG1SbKPWGz4X7BQl2+65GIoalnSryLKb
         nTsDReD6LUNciuPuwKsc4+Yg1OqKLV8QmCr0+gJ9JWhpTVoz0HZdbeGVMIcOVwcQD94l
         1kvA==
X-Gm-Message-State: APjAAAUHxfYKWBW8MxcuZbV3nreUymdV5rUpSkfMeXqtKsyMpm7JZg4c
        0LW0oK2DAaGgzeXSPYh7bIg=
X-Google-Smtp-Source: APXvYqxzsvObUzd7IjCaIq0aLvxL62hSMzf7+iuWuX74x6Mmnj3+LM8EyR9UnRqkHUwvNh8jut82oA==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr52670048wrn.51.1555388690363;
        Mon, 15 Apr 2019 21:24:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 61sm170394283wre.50.2019.04.15.21.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 21:24:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Andreas Schwab'" <schwab@linux-m68k.org>,
        =?utf-8?Q?'SZEDER_G=C3=A1?= =?utf-8?Q?bor'?= 
        <szeder.dev@gmail.com>,
        =?utf-8?Q?'=C3=86var_Arnfj?= =?utf-8?Q?=C3=B6r=C3=B0_Bjarmason'?= 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "Bill Honaker" <bhonaker@xid.com>
Subject: Re: [BUG] GIT_SSH_COMMAND is not being decomposed
References: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com>
        <874l71fxmg.fsf@evledraar.gmail.com>
        <20190413214736.GD15936@szeder.dev>
        <004d01d4f3c0$3ff358d0$bfda0a70$@nexbridge.com>
        <87ef63ezt9.fsf@igel.home>
        <008101d4f3db$56c20410$04460c30$@nexbridge.com>
Date:   Tue, 16 Apr 2019 13:24:49 +0900
In-Reply-To: <008101d4f3db$56c20410$04460c30$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 15 Apr 2019 18:34:02 -0400")
Message-ID: <xmqqsguipofi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> As a suggestion, with people who know how to escape stuff properly
> (or not), perhaps we can select the alternate behaviour explicitly
> using a core.sshIgnoreEscape=true/false option. Thoughts on that?

The semantics of prepare_shell_cmd() is, regardless of any "funny
characters" on the command line, the spawned command MUST behave AS
IF it was run via the shell.  The strcspn() trick is there merely as
a low-level optimization so that we do not have to say

	sh -c a-single-token

which would be exactly the same as running

	a-single-token

The most typical use of that strcspn() trick is to ensure that

	GIT_SSH_COMMAND="the-command and its arguments"

would not attempt to run a command with a long and funny name
"the-command and its arguments" somewhere on the $PATH without any
parameter, and instead run

	sh -c "the-command and its arguments"

i.e. run the "the-command" with three parameters (and perhaps more
built-in parameters prepared by the caller in the ssh connection
codepath).
