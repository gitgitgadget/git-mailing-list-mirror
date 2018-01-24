Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AB91F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964978AbeAXSdW (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:33:22 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36554 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964850AbeAXSdV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:33:21 -0500
Received: by mail-pg0-f66.google.com with SMTP id k68so3298919pga.3
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5LfP4+1E+vJMYN5xVxp473K70MMVtUO7i4zM+L4Fku0=;
        b=Xm6LxJ6RN4o6GFBYZqa2Jm5wVlUoPY6nKa2yaFJMLg74N/phrEZk+Uwtfr5Z10xoC9
         LeeZ8p2+PuTaoclKdW1hkrNOdSMVOm4yaVVXZYzOJ60PDlzSUTDA7QW5P/nX1gZtsSc4
         iVMSQLYkVdWLjJ7x99coogqAP02l1C3horIZR4VLGWFAPFv6OcFJsUIXFQuGxNofGH3f
         y3z39ZbgVS1OukTeAZCp/q4plIDb+Ny9orWu0rNjs+zsocgRAL8WiWKcFbzQPIyCT1tq
         Y5aqmAqb1X9BDYlmZ2mbzrSma3B40Wmoppjsld7POZpgOyKbTJfTKGGNoVCC9sI12XcU
         Bq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5LfP4+1E+vJMYN5xVxp473K70MMVtUO7i4zM+L4Fku0=;
        b=mSvJXMRp2fJO6wmaG6gazj/GUuAeKGtqYpvu4JBe3TzM4u1pmqhjKRtRGajJCvu0R4
         Z1QmO6x740yhh8eHXiUiNpVRQtcoyLcVA7F+j53ou5ox1dmev8fs5tbq8/ch1A6BXqtn
         3WPc4pRH23d62Tr5H9C6OlxJPhgszg0EfYBDG2K21l9l846/jc9kQ51n56HrKaCdfYcx
         wmDc8tmHSb4pjxip1/FBu2APRTDDSloGUULGkAszUcbMer/xQk/ggHtxJx7BE9rkRZoO
         l/RmiFbHJpDT4XG9i92KoDcIrxPOW2/jDldTOgOaUGxfeL6cJQLphCl18hm54OOUE+Lc
         cdTg==
X-Gm-Message-State: AKwxytfg271XxGuFc5aHR9rozjRuRzPeAsuZEVWzToLHZOhCBdiDAIgp
        dcdR81SzO1Wm20DVD3Oo30Uorw0jlOg=
X-Google-Smtp-Source: AH8x227bP0wNFWZ2UWJk2GQlbkoObZtPd+rGX9rdSmJJl0o0CrPUHp+KnEiEvSy7iDhYY4BTchQKtw==
X-Received: by 2002:a17:902:7109:: with SMTP id a9-v6mr237286pll.294.1516818800378;
        Wed, 24 Jan 2018 10:33:20 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id y1sm1960574pge.78.2018.01.24.10.33.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 10:33:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] daemon: add --no-syslog to undo implicit --syslog
References: <20180122232304.4863-1-mail@lucaswerkmeister.de>
        <87shaxh2b9.fsf@evledraar.gmail.com>
        <xmqqh8rcig0x.fsf@gitster.mtv.corp.google.com>
        <18ef807d-a642-17b2-fc32-af0c3b963a71@lucaswerkmeister.de>
Date:   Wed, 24 Jan 2018 10:33:17 -0800
In-Reply-To: <18ef807d-a642-17b2-fc32-af0c3b963a71@lucaswerkmeister.de> (Lucas
        Werkmeister's message of "Tue, 23 Jan 2018 23:06:18 +0100")
Message-ID: <xmqqtvvbds42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lucas Werkmeister <mail@lucaswerkmeister.de> writes:

>> Moreover, --detach completely dissociates the process from the
>> original set of standard file descriptors by first closing them and
>> then connecting it to "/dev/null", so it will be nonsense to use this
>> new option with it.
>
> Ah, I wasn’t aware of that – so with --detach, --no-syslog would be
> better described as “disables all logging” rather than “log to stderr
> instead”. IMHO it would still make sense to have the --no-syslog option
> (then mainly for use with --inetd) as long as its interaction with
> --inetd is properly documented.

Because "--detach --no-syslog" is a roundabout way to ask for
sending the log to _nowhere_, I actually would say that "nonsense"
is a bit too strong a word for the combination of your thing with
"--detach".

It might make more sense to introduce a new "--send-log-to=<dest>"
option, where the destination can be one of: syslog, stderr, none.

The you can make the current "--syslog" option a synonym to
"--send-log-to=syslog".  The internal variable log_syslog would
probably become

	enum log_destination { 
		LOG_TO_NONE = -1,
		LOG_TO_STDERR = 0,
		LOG_TO_SYSLOG = 1,
	} log_destination;

and wherever the current code assigns 1 to log_syslog, you would be
setting it LOG_TO_SYSLOG.

Then those who want no log can express that wish in a more direct
way, i.e. "daemon --send-log-to=none", perhaps.

Such an approach leaves open room for future enhancement.  It is not
too far-fetched to imagine something like:

	git daemon --send-log-to=/var/log/git-daemon.log

by introducing the fourth value to "enum log_destination"; perhaps
the file is opened and connected to stderr to accept the logs,
combined with a new feature that tells the daemon to close and
reopen the log file when it receives a HUP or something like that.






