Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9FD6201A4
	for <e@80x24.org>; Mon, 15 May 2017 02:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdEOC2p (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 22:28:45 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35810 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdEOC2o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 22:28:44 -0400
Received: by mail-pg0-f42.google.com with SMTP id q125so33367096pgq.2
        for <git@vger.kernel.org>; Sun, 14 May 2017 19:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Ai7ddaP4SvBqaqOWFW3pwj2Byv+kmjpxRee6QI2X9U=;
        b=APUbDXxJrdIrAPUQUPiPO6nGvnqz8UTRoiiT2+WzwOek3793bdkvoZ9GueF3nsWrr2
         SBAnJngJyMbMFbZJrhPj0/hk1dFrwvXz5r4R+iW8kA1tHMi8sJGsezpkSWDbeqedGTc/
         KpIb/+8uVxGTEV9pmtxOVYOPJVd9eXhV0eetei0QrmBMEbvQ3JrtrS53LLkpHC9f3T3O
         VZouVqMCZTb/ir0HU5pIiY6dszAw5qK1zk3KsmOpOptp3b9pAmRghIIlE9lEDxMB4G/u
         pBdfLnDoU9DuFUbVGRr92ZVRABlOTKlfIUEb3ARj6ZL0LIWcQqqG7lwTPiX9wEr17MfK
         /uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2Ai7ddaP4SvBqaqOWFW3pwj2Byv+kmjpxRee6QI2X9U=;
        b=WhxeDCE+EsQbqkFvrnP7EQGWbJNLifV54mwYKweU2ZD20kCh3jqHGB5u7En4HmMeVE
         ezBU8/4rbyreyb8gwqpXvfBn/09vX3ach0dysO73DqfCOxvEdh8/3Zk7xZpKpquCleNI
         HSiNO7FSJiItiRXbSY1E2PJTwZrsKiK4kzmbkY+dODWB45NgPCtqBccaffuWJoFWZPiM
         LFBbUvlYrOE8eFpO45deSmg0l5nuwXeiM1kkuxxJONSaCeHYLpB9LTZim2l2Y9p0pT/S
         DAOQTLXC3rjKulNzgtnayCz4jk/3kxMEIp0zDm5ZUa8bp7fNCp9dl0kHpoVn8TGFKFXR
         3KPg==
X-Gm-Message-State: AODbwcBeRcDzD8oGq4acbImTHHpEI2Zc4oQQK5fa41fYnga9H+v03GSl
        cP5hs3519+DaHQ==
X-Received: by 10.99.116.7 with SMTP id p7mr3722760pgc.162.1494815323646;
        Sun, 14 May 2017 19:28:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id n65sm17260149pga.8.2017.05.14.19.28.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 19:28:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Josh Hagins <hagins.josh@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] usage.c: add BUG() function
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
        <20170513032850.zeru4cm2l7i23rkc@sigill.intra.peff.net>
        <20170513035503.cubqhzcvhifp54yg@sigill.intra.peff.net>
Date:   Mon, 15 May 2017 11:28:42 +0900
In-Reply-To: <20170513035503.cubqhzcvhifp54yg@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 12 May 2017 23:55:03 -0400")
Message-ID: <xmqq37c6yht1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, May 12, 2017 at 11:28:50PM -0400, Jeff King wrote:
>
>> +static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
>> +{
>> +	char prefix[256];
>> +
>> +	/* truncation via snprintf is OK here */
>> +	if (file)
>> +		snprintf(prefix, sizeof(prefix), "BUG: %s:%d: ", file, line);
>> +	else
>> +		snprintf(prefix, sizeof(prefix), "BUG: ");
>> +
>> +	vreportf(prefix, fmt, params);
>> +	abort();
>> +}
>
> I used vreportf() here to match die(). But the two things that function
> does are:
>
>   1. Respect error_handle. But after bw/forking-and-threading is merged,
>      nobody will ever set error_handle (and I just sent a patch to drop
>      it entirely).
>
>   2. Quotes non-printable characters. I don't know how useful this is.
>      Most of the assertion messages are pretty vanilla (because anything
>      that relies on user input probably should be a regular die, not an
>      assertion failure). But a few of them do actually print arbitrary
>      strings in a reasonable way (e.g., a BUG() which is handling user
>      string which was supposed to be vetted by an earlier function is
>      still a reasonable assertion, but it's useful to show the string).
>
> So an alternative would be just:
>
>   fprintf(stderr, "BUG: ");
>   if (file)
> 	fprintf(stderr, "%s:%d ", file, line);
>   vfprintf(stderr, fmt, params);
>   fputc('\n', stderr);
>
> which is perhaps a bit simpler (not much in lines of code, but there's
> no extra buffer to reason about). But given the discussion in (2) above,
> it's probably worth continuing to use vreportf.

Yeah, that does sound sensible.  Thanks.
