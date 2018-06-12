Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C6A1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754136AbeFLTQH (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 15:16:07 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37311 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754060AbeFLTQG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 15:16:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id d8-v6so99559wro.4
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 12:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X+qrDWwkft6TALlLE9D6xGmze/apZ8Wp4hfjK4lFFSs=;
        b=NE1N17H/TcMthzBQYh4rteJt5FDez/ZIYT0dCu+2dPA3FOIRPP6AWrYrBXNqUcOpn6
         6eSwwILEBjBjliM0282sd5f28uHvbOWybq6Nc6cfNTZjiNSOTreDwBCUU5jhIniCG5jo
         AnWykM2IyVAyjKVWPhhJeK8EVXGYaIPlqK78fVieoPqutT7BFkHxvjAWy7d1CyVu4/lb
         0m9gNe063lJx8o1GNIuGHQk4i2XELZIC/f71MJMIV3WGY4LTQbJIknb5cwa7ewXKc7Fi
         F1nZ7Xab9RO8pM4SEi5C8il7VaUeAlkUKi6mcjqH31njCnzyuCeyI8MewOclm/PNfnQG
         cAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=X+qrDWwkft6TALlLE9D6xGmze/apZ8Wp4hfjK4lFFSs=;
        b=N4n8L8rnOwUkLtLyCJrm4y67P8XF0pDmzlPkb2+VCn02pCIM93eU7iWQFAASTCVCGs
         ge7rhUJ0HdTfE7e04bZnaJdwolHYi0lRa5XbIweqVrFmcvS+JxMA8oiWqr/rCYE2gYQq
         Twrrq5ihSDkCJj+fFCnRchvOwpMaw5qF7n4vN1XQaPofddV+9GnRD35YvG4z3u+4Wzt8
         YIL2WoZdBniy+wv7DORqvj5Oza5PKH8u3UpPx8ldGWLRkHjbF9RMIkO2zJSqhj3wHroY
         8h+EWv3UjAZ9f//XnlHYq2Zy6aPZDUdvvPyYirSyGQ4DnvPVJOjv6ZCAafPHW120y8vR
         zIDw==
X-Gm-Message-State: APt69E0VpfNb1ZklbH9F6bR8777T5wCseOZD7b+IPILArAuZ2GgIshFE
        yM0loXxoDOZBBVQf/H/6pdY=
X-Google-Smtp-Source: ADUXVKJPvgk676vEK4gQjXDTeQFKo+EDRBr7RuHWUM+Kpj6WKJFuHYN0rBHqxTfZIt0k3SR4omUopQ==
X-Received: by 2002:adf:d192:: with SMTP id h18-v6mr1489102wri.198.1528830964802;
        Tue, 12 Jun 2018 12:16:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o12-v6sm1658167wrf.30.2018.06.12.12.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:16:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 19/20] abbrev: support relative abbrev values
References: <20180608224136.20220-1-avarab@gmail.com>
        <20180608224136.20220-20-avarab@gmail.com>
Date:   Tue, 12 Jun 2018 12:16:03 -0700
In-Reply-To: <20180608224136.20220-20-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 8 Jun 2018 22:41:35 +0000")
Message-ID: <xmqqvaan95os.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change the core.abbrev config variable and the corresponding --abbrev
> command-line option to support relative values such as +1 or -1.
>
> Before Linus's e6c587c733 ("abbrev: auto size the default
> abbreviation", 2016-09-30) git would default to abbreviating object
> names to 7-hexdigits, and only picking longer SHA-1s as needed if that
> was ambiguous.
>
> That change instead set the default length as a function of the
> estimated current count of objects:
>
>     Based on the expectation that we would see collision in a
>     repository with 2^(2N) objects when using object names shortened
>     to first N bits, use sufficient number of hexdigits to cover the
>     number of objects in the repository.  Each hexdigit (4-bits) we
>     add to the shortened name allows us to have four times (2-bits) as
>     many objects in the repository.
>
> By supporting relative values for core.abbrev we can allow users to
> consistently opt-in for either a higher or lower probability of
> collision, without needing to hardcode a given numeric value like
> "10", which would be overkill on some repositories, and far to small
> on others.

Nicely explained and calculated ;-)

>  test_expect_success 'describe core.abbrev=[-+]1 and --abbrev=[-+]1' '
> -	test_must_fail git -c core.abbrev=+1 describe | sed_g_tr_d_n >describe &&
> -	test_must_fail git -c core.abbrev=-1 describe | sed_g_tr_d_n >describe &&
> +	git -c core.abbrev=-1 describe | sed_g_tr_d_n >describe &&
> +	test_byte_count = 6 describe &&
> +
> +	git -c core.abbrev=+1 describe | sed_g_tr_d_n >describe &&
> +	test_byte_count = 8 describe &&

Even though I see the point of supporting absurdly small absolute
values like 4, I do not quite see the point of supporting negative
relative values here.  What's the expected use case?

>  	git log --abbrev=+1 --pretty=format:%h -1 | tr_d_n >log &&
> -	test_byte_count = 4 log &&
> +	test_byte_count = 8 log &&

This, together with many many others in the rest of the patch, is
cute but confusing in that the diff shows change from 4 to 8 due to
the redefinition of what abbrev=+1 means.  I have a feeling that it
may not be worth doing it "right", but if we were doing it "right",
we would probably have done it in multiple steps:

    - the earlier patches in this series that demonstrates
      --abbrev=+1 is --abbrev=1 and core.abbrev=+1 is an error.

    - ensure --abbrev=+1 is rejected as syntax error just like
      core.abbrev=+1 was, without introducing relative values

    - introduce relative value.

That way, the last step (which corresponds to this patch) would show
change from "log --abbrev=+1" failing due to syntax error to showing
abbreviated value that is slightly longer than the default.

But a I said, it may not be worth doing so.  "Is it worth supporting
negative relative length?" still stands, though.
