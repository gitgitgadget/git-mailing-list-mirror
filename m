Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6FF1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 19:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161146AbeCATGv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 14:06:51 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:46746 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161068AbeCATGs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 14:06:48 -0500
Received: by mail-wr0-f176.google.com with SMTP id m12so7687837wrm.13
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 11:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W89vyVzDvOVIM97X1j+tg9zEVo4nogcvTweeu0q9mI8=;
        b=fctEnX3kU90ixPPsJmOgx4zVvv+SWrsFZtM9CMqlhC32l496EAF+PCG5Z9QTBdN1ZI
         k7OFIjo41d9fLMklEFY6iDRyxJ/jT5sk+MuUyJqKpDPBbnlb26x9tLQWXTY/XBnAwyAq
         PPICG+BRXjxvj0+XsJQ8OIM5W7/PyGzsevTwKD7i29D6/5e4hOqlcdtt0SYjveyzrTLK
         SEu9ZQ2hBwM31aYxzuB/907OaMvZ1FyhTcAHPtB7qmO5Wy8kVUfEOuQna3xkuvIFwxJQ
         1gLtI7HoNaXfdOV9a8P2sBz1mm47qkDWg5P7qQ4hBmFqhX/N7jU/9cvFD+AW7O/udcbA
         t7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W89vyVzDvOVIM97X1j+tg9zEVo4nogcvTweeu0q9mI8=;
        b=aC4Jl6Ft/mWPH7vDZBV1SJueQDcTcAtgud+KgehCa5QMiXQQVQ5LrS0BbR+mKJCcEm
         ql2dfaM6z9iPzWYXc+T6dX4hjWwtG1B/L8GedWR6APIcpYiIcc6u9u0FWncPUbsIguX+
         yI72JFFNd9uHI0+B1WRSsHftqdwfIqdMK6rDf16G21NQoUOgkHj4yQBkRurZ6H3iUVsJ
         Ik7IMOlvW0p1j3q/F0sSBrhfSzk8haeue7qQ/pUHwplEmXaiou0ECymFJAhIkvJOtuUf
         LCgaKiJFjGDxvACpeCDBT8fTo6rpMyaQJ2IGB7gRVUKhdm3a+/cVAxp+SW7qT3Xl+/LH
         hqXw==
X-Gm-Message-State: APf1xPBFlIZAYCbk2oXk4tIqN8THWdgRfKD2FQrQ0KUdISYI8Faxy+yo
        WK6WvCmoTHUmbGI1gYdIbqk=
X-Google-Smtp-Source: AG47ELuFSLemEhYBDMRyHsMzKNf4syWTXbX4BWFo4oWN/zgMuk9n8DzcqJ+mZer1tpBaFPLMKB8AsQ==
X-Received: by 10.223.135.231 with SMTP id c36mr2912769wrc.36.1519931206596;
        Thu, 01 Mar 2018 11:06:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i44sm3403531wri.23.2018.03.01.11.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 11:06:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leah Neukirchen <leah@vuxu.org>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] color: respect the $NO_COLOR convention
References: <87zi3reoez.fsf@gmail.com>
        <xmqqefl3iuvx.fsf@gitster-ct.c.googlers.com> <87efl3emlm.fsf@vuxu.org>
Date:   Thu, 01 Mar 2018 11:06:45 -0800
In-Reply-To: <87efl3emlm.fsf@vuxu.org> (Leah Neukirchen's message of "Thu, 01
        Mar 2018 18:23:33 +0100")
Message-ID: <xmqq8tbbhayi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leah Neukirchen <leah@vuxu.org> writes:

> You are right in calling this out an emerging new thing, but the
> second list of that page proves that it will be useful to settle on a
> common configuration, and my hope is by getting a few popular projects
> on board, others will soon follow.  It certainly is easy to implement,
> and rather unintrusive.  Users which don't know about this feature are
> completely unaffected.

There certainly is chicken-and-egg problem there.  Even though I
personally prefer not to see overuse of colors, I am not sure if
we the Git community as a whole would want to be involved until it
gets mainstream.

>>>  	if (color_stdout_is_tty < 0)
>>>  		color_stdout_is_tty = isatty(1);
>>>  	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
>>
>> According to no-color.org's FAQ #2, NO_COLOR should affect only the
>> "default" behaviour, and should stay back if there is an explicit
>> end-user configuration (or command line override).  And this helper
>> function is called only from want_color() when their is no such
>> higher precedence setting, which is in line with the recommendation.
>>
>> Which is good.
>
> Yes, I took care of that.  Should this also be tested?  It doesn't
> quite fit into the setting of t4026-color.sh I think.

It probably fits much better in t7006, I would suspect.  Earlier,
setting color.ui to auto meant the output is colored when run under
test_terminal, but with this new environment set, the output will
have to be bland.
