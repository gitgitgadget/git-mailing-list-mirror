Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2FFD1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 20:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfAOUtv (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 15:49:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56170 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfAOUtv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 15:49:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so4709376wmc.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8+6039HLBUUzTGcYhRXE6Pf3xG394P2OQEWbA1vELcc=;
        b=maqOYrwwr+HMFJVKOaajGsUWJuMfI3QBjzIuWad5fl8XVYJxGL4w0FC1QOEQYDZx/j
         UoGTUSOyUCcXTFnXJ9Euxu54f86V+j8aFbdBdxNjWmyoQnQMCclhyJjx2wENl8oLrkQa
         rQmXtGh1WDY+Man7Y/MKbMcJMjfsWgzSi4endviYORU9WKKd5IHlrntNk9ysVUvAEGvr
         NiiD21kfQLYNCGhgONphkBtCchaBTa1l/VjktZidCp1k9hVXh2xPalJsNeuehkCKf9lw
         WOe1/T98+bgdqrBtGGgacsTjEH2KvUzQjnGoDHv4dmI4m7LNhcYeVskktH+xnGzjyw1m
         qNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8+6039HLBUUzTGcYhRXE6Pf3xG394P2OQEWbA1vELcc=;
        b=Jqqm+sggxO3qWKrOYvdOAoVTWTPeUI4Yhu2izxeKcT4kIZIr056J1XHWxtcu4RXaC+
         GBgtadqziiXhMvjiE588RlhQxPa8QVCnQPx9g5bInKtZ1bWl1nGC+43QOocQlMB5zRrz
         kR7zCU4hauXQTGtphgab5pXg/Z29ZdCmG7b0yCxv+jUNYPu0zfpO6ypEz6e2SkK7ttpd
         Q0fshr+q3fuk3b7YMm9ub5FaAlghVQGVK7q/2/95IlAytRfGkrGe8Gnn0LEHOsEgb/m8
         2+Nhgw3zzr/JEN6BpC0goDIJ5ZOqMhbNpHwlbFpwh6x0ycGgaAg5gSl49iYuQd3YcYJu
         /IXA==
X-Gm-Message-State: AJcUukfN1/EoDppm1kSvTJ8ZFohfIBbad/AkGvZm7aa0qjkpOV+wIWEN
        2GrYVcLdfq+lxDtbKYF6VPM=
X-Google-Smtp-Source: ALg8bN6TPYKoQ2IEcCyAZNAhaZbIpQAPdzLrWBBEXMBu8DE69EpEy4s3NAlN9K0KO6atPz/DsOXEcA==
X-Received: by 2002:a1c:2b01:: with SMTP id r1mr4689701wmr.7.1547585389427;
        Tue, 15 Jan 2019 12:49:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w6sm31982337wme.46.2019.01.15.12.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:49:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] getenv() timing fixes
References: <20190111221414.GA31335@sigill.intra.peff.net>
        <87va2u3yeu.fsf@evledraar.gmail.com>
        <CAGZ79kZrcC=SBrBR_4JDWu4Odgz-Uf7LrusiKNe6tgs02JeAMA@mail.gmail.com>
        <20190115191359.GC4886@sigill.intra.peff.net>
        <xmqqy37lra1j.fsf@gitster-ct.c.googlers.com>
        <20190115194142.GG4886@sigill.intra.peff.net>
        <20190115194726.GA5818@sigill.intra.peff.net>
Date:   Tue, 15 Jan 2019 12:49:48 -0800
In-Reply-To: <20190115194726.GA5818@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 15 Jan 2019 14:47:26 -0500")
Message-ID: <xmqqef9dr6hf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So actually, that's pretty easy to do without writing much code at all.
> Something like:
>
>   #define xgetenv(name) strintern(getenv(name))
>
> It means we're effectively storing the environment twice in the worst
> case, but that's probably not a big deal. Unless we have a loop which
> does repeated setenv()/getenv() calls, the strintern hashmap can't grow
> without bound.

Makes sense.



 hashmap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hashmap.h b/hashmap.h
index d375d9cce7..cff77f9890 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -432,6 +432,8 @@ static inline void hashmap_enable_item_counting(struct hashmap *map)
 extern const void *memintern(const void *data, size_t len);
 static inline const char *strintern(const char *string)
 {
+	if (!string)
+		return string;
 	return memintern(string, strlen(string));
 }
 
