Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77A00201A7
	for <e@80x24.org>; Fri, 12 May 2017 21:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758484AbdELV0N (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 17:26:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36763 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758370AbdELV0M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 17:26:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so7155572pfb.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IciS19sp3svI3TN16y7hDybL6O8wUaCP6Ehvpodbn5o=;
        b=g7uAYYJc/YhK6jD0aw7Bg/xzeUeDHkZE2eDoqbsPmoAuBFJwN9rhlthpcZgjXS4DBc
         6dXGDWekqvxa0ZCQIZheSyfvhdWx9HWrNtT1Vk8lq4fObkjyKEW+xrFY9Sbl4zs8P1RL
         je8iNdCstGmHPYKB0/CSklHx4qSfRr7UvSyPR/7/Vnn+qpIygvbg4/0MqJhO8hTU8bhO
         pDN3C6gSX9rrg60yG/8wawutQpUZhd16ZAh+l0hAQf9IjvSOFUCWZvrU75wEoz+NNQOi
         i3SCbc6GZrIyHo2hUA/xaAL34DMzI4irl/+BQVDYnd9Jr3twEQ/hnznsxl8CQzo1J4GC
         Ui8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IciS19sp3svI3TN16y7hDybL6O8wUaCP6Ehvpodbn5o=;
        b=ndI6gWBLM5E7E9v2eG5pKbCNS0HSRhnbUqvc7VfLN5yjjFWx9Y8BhDoogYhVFOCs5T
         pOz4YEQ9bNqCrqLHnNsBYC9bI5smA0RkEQC0+umPX3vLSbq98s6OG4kqwEnhEbcfEyUP
         WVMZ8Nl3FaWIDCfuS6bIkxcIj6J9YFbIn/uLSzXMbFOuXBEE1alhncQaBP7WHDQMOy8f
         lTkwMHhl04qR2pq0bEv28yOt4ClI3JKne+6yDeD1E7Uhoy/oyc3+KsOzfHcGv+zBjTsu
         EAlxpAKC5wtRV+FdSaE1fxJkn8wiw6iGjiwmxfrcukwjX4ZGjCGj82mSYOUb/JE5cqIG
         OQpA==
X-Gm-Message-State: AODbwcCBO3to1BfXjm12N7oDjyaG+dJccHH5XWeVJCN4zMrskf0PB2X6
        BEm+RZtOzt98OQ==
X-Received: by 10.98.55.7 with SMTP id e7mr6721094pfa.233.1494624371500;
        Fri, 12 May 2017 14:26:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id 20sm9142122pfq.42.2017.05.12.14.26.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 14:26:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] compat/regex: fix compilation on Windows
References: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
        <xmqqd1be98kk.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705121219150.146734@virtualbox>
Date:   Sat, 13 May 2017 06:26:09 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705121219150.146734@virtualbox> (Johannes
        Schindelin's message of "Fri, 12 May 2017 12:25:44 +0200 (CEST)")
Message-ID: <xmqqy3u14vim.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'd place a bet on this part of compat/mingw.h for GCC builds:
>
> 	#ifdef __MINGW64_VERSION_MAJOR
> 	#include <stdint.h>
> 	#include <wchar.h>
> 	typedef _sigset_t sigset_t;
> 	#endif
>
> and on this part of git-compat-util.h for MSVC builds:
>
> 	#ifndef NO_INTTYPES_H
> 	#include <inttypes.h>
> 	#else
> 	#include <stdint.h>
> 	#endif

Yeah, but I had an impression that git-compat-util.h was not in use
to build compat/regex/regex.o (regex.c #include's regcomp.c which is
a rather unusual arragement), and that was why I am wondering.

> For the record, it seems that our current version of compat/regex/regex.c
> has this:
>
> 	/* On some systems, limits.h sets RE_DUP_MAX to a lower value than
> 	   GNU regex allows.  Include it before <regex.h>, which correctly
> 	   #undefs RE_DUP_MAX and sets it to the right value.  */
> 	#include <limits.h>
> 	#include <stdint.h>
>
> while the one in `pu` lacks the last line. That may be the reason why
> things compiled neatly before, and stopped working for you now.

Yes, that explains how the old one worked and the new one didn't
without dropping "#ifdef HAVE_STDINT_H".

Thanks.
