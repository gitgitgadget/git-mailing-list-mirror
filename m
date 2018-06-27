Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084171F516
	for <e@80x24.org>; Wed, 27 Jun 2018 21:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeF0VLR (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 17:11:17 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35891 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeF0VLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 17:11:16 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so3363119wrm.3
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PE97a9NI8kTk+GuhwUYtrGeHKcbpK500MpqAUbcAncc=;
        b=Ee/d2tlZIvVlOGgI4OQfa69LvVeLwpoIT7G7gEYgc2O546wvV7I5moZ2eBmPWJl7E8
         bRQZvlsL3RyK/cHM41pJjnE/RuOehJXdrJBQ7ey/ePmi+6dP8qduaAuLFmTS/00NdNnB
         jXff/Dlrz0c1FyXYSAqwj7KIpMAxcEkZlI6EI0plAc6T+vR+xMwbjW4k8R2jLODFrA9L
         16wTl1IHAEf7lD+NDGQYnl1lmYyYYOtldLjdjAO/WRlGKrs95eyYUrfFOjStbA0JwTWS
         FGHSpGBtRYUOmxlYqGlH28Pf0GYZ0NgEMIDNPhyFaeSYK19nPutFh3U9YVvws2JRM01A
         R7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PE97a9NI8kTk+GuhwUYtrGeHKcbpK500MpqAUbcAncc=;
        b=TuzdPPbj98x0485tUFRYEsLwRX4qfthRt1QvkevoMo8AXfiiegkO17oCKacAsHOG3m
         /3TyLoay8tlt6pfa/nlWm8JXqJGyZbnPxC3vhdIz8RXHn2lSOmuN5nOT0fu6nOwnHtug
         BSDSvn7U9GjWkd/tejJTgTjqAh7MfyyZk8OgntZLXjPq0up2zH9dgEfJDX+9ZUNK86Ft
         CzPH/fFSMsutmlhp54aQaE2y7rtuLAUoxgoS89bmrlET+3nzASqnG7p3cZxX6PpDg35R
         lvDdRjrctn87Vq1/6ObKm35HobP6EyCxkFuYoFHvgI7JDFioMTNEKkpXTggaDtZVQ4kJ
         2BCQ==
X-Gm-Message-State: APt69E1UR8mfpJGOhLw30AHkdZruD26Md5OVC292w2hU5Q5nsR7wolx+
        KcXCXJm1NONMc3hfGGCZWI4=
X-Google-Smtp-Source: AAOMgpf9OYYdLnENNQizOxv/TQlejvkd1lbU86JRDmfEXQxoTg2OBXA7qtP098WOAQBr96B3fbL7nA==
X-Received: by 2002:adf:ae8b:: with SMTP id y11-v6mr6829777wrc.234.1530133875013;
        Wed, 27 Jun 2018 14:11:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u6-v6sm6078129wrm.60.2018.06.27.14.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 14:11:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/2] grep.c: teach 'git grep --only-matching'
References: <cover.1529961706.git.me@ttaylorr.com>
        <f156bd7c897359926ec407e805ecb0630a8b12da.1529961706.git.me@ttaylorr.com>
        <xmqqsh58gp3p.fsf@gitster-ct.c.googlers.com>
        <20180627171657.GA26628@syl.attlocal.net>
Date:   Wed, 27 Jun 2018 14:11:13 -0700
In-Reply-To: <20180627171657.GA26628@syl.attlocal.net> (Taylor Blau's message
        of "Wed, 27 Jun 2018 12:16:57 -0500")
Message-ID: <xmqq6024djf2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> Just initializing match_color where it is defined at the beginning of
>> show_line() should be sufficient, I think.
>
> I think that we could also use the following, and leave the `if
> (opt->color)` conditional where it is:
>
> diff --git a/grep.c b/grep.c
> index 48cca6723e..b985fb3ee0 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1448,7 +1448,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
>  		      const char *name, unsigned lno, ssize_t cno, char sign)
>  {
>  	int rest = eol - bol;
> -	const char *match_color, *line_color = NULL;
> +	const char *match_color = NULL, *line_color = NULL;
>
>  	if (opt->file_break && opt->last_shown == 0) {
>  		if (opt->show_hunk_mark)

You say "we could also", but the above is exactly what I suggested,
so we seem to be on the same page, which is good ;-)

