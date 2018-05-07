Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AC9200B9
	for <e@80x24.org>; Mon,  7 May 2018 14:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeEGOWk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 10:22:40 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:32992 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeEGOWj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 10:22:39 -0400
Received: by mail-wr0-f178.google.com with SMTP id o4-v6so28954283wrm.0
        for <git@vger.kernel.org>; Mon, 07 May 2018 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/iWvOo1GsAOvc0tyZrKxa+4W8G84QXBquwZCnbiLkAA=;
        b=Na5d/xVZ+QS+XiOED/bZqbTBeksCzp/S3yTI0rZGvBgzKn2npDQjyKiaYP950UOmI1
         ZMsm5iPIfmsEaLV+0y/Dv9+1NQMkiTvNLNv4jkiUpWbGQFdjVN/xukghSzEJmHMARaTR
         balHCwDBTWVOFAGgjCiN9XhhdQseSXPYiqBYaojgIN+A06jhtNDUsmsP61vhHJLMiLoH
         +zW/PAkRPptfS+btjslp1xoccYcBwxUCGM2ly9DQpOq6nDs8rPcwiP+JdDfrFMsu+4ei
         4sukiIqQTL2Taf96Yaodn4AAOpVZyat5NKvYrkf/7+D8KHhYsbqkSvAIZzjmcAeT1bMa
         ylSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/iWvOo1GsAOvc0tyZrKxa+4W8G84QXBquwZCnbiLkAA=;
        b=Z9OSgkMeNO9BZPlb2WII0yqqrTfnMXczbUYyUEz9EucpLrvudkUBzhIzQ/vdTBfbG1
         ejoH5MPtYI1nUwTjvT3VcQCYOqk7Hybythu+zSvpVIhfD45YatIFtNfdzm9I0AKji4Ct
         /BNURh3MBfxguWpmSCkCQQa8USekDSHKWq6l+MTnV9fx4ToE9SnJlzs3TwfLaoIkkIeO
         vmfd7VpSNxOfR5+rxHvxlU/PYjExOuoqHSCYROigYc2uUHaJApGZAyzeRBMTx4TOcasW
         mqLjeO/ORgqTL78wiW9FWgsUgwjLg/E6qG4jbh3BdS1Y/77Ca9O7dit1JWF8xLxaNmij
         AKcQ==
X-Gm-Message-State: ALQs6tCf+i6Atykdprup94HCbDnqwsIuNwUamaJkOgMvszWJxBzTKpTo
        r8189qAyAodcnMLXq53qaz8=
X-Google-Smtp-Source: AB8JxZo4zI3YXX/ksc3UMCsr9gseoAFTXE90m7E0Xn22Kl3vZwOxYRs7X1PHK1Oefduc0v9hjcJLKA==
X-Received: by 2002:adf:d1cc:: with SMTP id m12-v6mr21768104wri.214.1525702957863;
        Mon, 07 May 2018 07:22:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k30-v6sm41786516wrf.17.2018.05.07.07.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 07:22:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: introduce test_unset_prereq, for debugging
References: <20180507115950.3887-1-szeder.dev@gmail.com>
Date:   Mon, 07 May 2018 23:22:36 +0900
In-Reply-To: <20180507115950.3887-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 7 May 2018 13:59:50 +0200")
Message-ID: <xmqqfu33pmtv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> For convenience, the following two methods are now supported ways to
>> pretend that a prereq is not met:
>> 
>> 	test_set_prereq !GPG
>> 
>> and
>> 
>> 	test_unset_prereq GPG
>
> I'm not sure this is the right way to do this.
>
> I wanted to run the whole test suite with all GPG tests skipped the
> other day.  With this 'test_unset_prereq' I would have to modify all
> test scripts containing tests depending on the GPG prereq and add
> 'test_unset_prereq GPG', right?

Excellent point.  This won't cover that use case well.

That does not mean this change is useless.  If you are focusing on
developing a single test script, you can afford to tentatively add
these set/unset, just like you tentatively debug with echo's ;-)

But I find your SKIP_PREREQS an excellent idea.

It may want to be FORCE_PREREQS that lets you pretend a prereq is
not satisfied on your machine even when it actually is, and also
lets you pretend a prereq is satisfied on your machine even when it
is not.  SKIP_PREREQS would only do the first half, which would be
sufficient most of the time, though.

> I think we would be better served by an environment variable similar
> to $GIT_SKIP_TESTS, e.g. $GIT_SKIP_PREREQS, to list all the prereqs
> that should be skipped even if they were met.
