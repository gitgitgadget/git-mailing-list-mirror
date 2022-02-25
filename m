Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977FC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 08:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiBYIIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 03:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiBYIIy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 03:08:54 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303EF6F4A6
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 00:08:22 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 132so3980820pga.5
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 00:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4iHYkC7Fo5GaH1f30T+jFie/cyJHy8YLLSav0/YV94=;
        b=LJ17qRApcks5a4m1PxAwPZUJ17fts+rI4yZ4mt+1xAa6dAVnfPJT1bBac1WrPHA53K
         x8mAsmpG7ahPg9iIvkw8EhJEMYbN2XostqkFn5CfWX9j8t3lKutpik6/Y4/6lLCAZvlZ
         upz3LPplSzjiLbZJIeRMFibcBwm+aGGwRPW/5WUafRZpZ7sOq2SpCZEGq4N9FP5LCmPC
         zNxtfJoSMycGI57iNm4Ta4a02DixY9ev18w1UTv9/I3Kr3H1jq62nnoBdQUee/ZC4ZpM
         zyXHXqjwp5kWIQuafWHlMHn+NKXj5u+OGpRzmKtKnTIPP8IFWJeDzqNxj6BTv0GjQ91A
         PEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4iHYkC7Fo5GaH1f30T+jFie/cyJHy8YLLSav0/YV94=;
        b=HL+JQCxFzSNKDzzceuDKrJYaxhw2LUTIiDF1yOT9S59lFUUFKmh1QXYM8eTkMdlrCL
         ZniljkPRvCeiIS1W0K+gqWM9ZAKtoNbMuQseSlT/hctHM4neGyRgreEgKyVYYkriqRiy
         wdgYQN/M/6UN1rL7c64vOaUOo4GHEkYOReRa3CfmJz8QEzEpYi2hMAnq0eE9GKawQs4o
         EKixm+6IRbQOOex4hU3WwEVRnrdoVsvggUncUVrX3KuyYCbEYrMuMXVunL2Awe+9WZd+
         XFsSxGTVz2rpY+I7Q50qFD37s5MNKNCAQlr9DUQgo+j4vpyS1FvUkI8y7UsOkLY/gsWe
         0CvQ==
X-Gm-Message-State: AOAM5335N3zq6ShKTtWD/c9pkE2WE1+VN9XSn2TzF4rhbC9Zs1lyB+rL
        SyzT5eM6onjN2/otZ9maIjY=
X-Google-Smtp-Source: ABdhPJzzRM9TtusBuQJhMpL87zzysC6QSYQo8WtEQuOTa2smveIG1vvQLgaxhIAlhFs6wTYByQVkEw==
X-Received: by 2002:a62:ee12:0:b0:4e1:2ec1:cba2 with SMTP id e18-20020a62ee12000000b004e12ec1cba2mr6557583pfi.71.1645776501518;
        Fri, 25 Feb 2022 00:08:21 -0800 (PST)
Received: from localhost.localdomain ([202.142.80.210])
        by smtp.gmail.com with ESMTPSA id z35-20020a631923000000b00373520fddd5sm1649877pgl.83.2022.02.25.00.08.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Feb 2022 00:08:20 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Fri, 25 Feb 2022 13:38:11 +0530
Message-Id: <20220225080811.8097-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqh78nh3sf.fsf@gitster.g>
References: <xmqqh78nh3sf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Style.
>
>	/*
>        * This is how our multi-line comments
>        * look like; with slash-asterisk that opens
>        * and asterisk-slash that closes one on their
>        * own lines.
>	 */
>
> Also avoid overly long lines.

Oh, sorry for that. I was in kind of a hurry ( today was
my semester exam), so I didn't look at the style guide.
Will fix it.

> These two calls to optbug() use xstrfmt() to grab allocated pieces
> of memory and pass it as a parameter to the function, which means
> the string is leaked without any chance to be freed.
>
> Do we care?
>
> >  		if (opts->argh &&
> >  		    strcspn(opts->argh, " _") != strlen(opts->argh))
> >  			err |= optbug(opts, "multi-word argh should use dash to separate words");
>
> The existing use of optbug() we see here does not share such a
> problem.

hmm, I wanted a formatting function to format (i.e. pass the
`opt->help` dynamically) the output string. The existing use of
`optbug()` that you specified has no `%s` formatter; it is a plain
string. That's why I used `xstrfmt()`. Moreover, it was in Ævar's
suggestion[1] -

> +		if (opts->help && ends_with(opts->help, "."))
> +			err |= optbug(opts, xstrfmt("argh should not end with a dot: %s", opts->help));

But I think, you're right. There is some memory leakage here.
Should I go with plain strings then? (i.e. "help should not end
with a dot" instead of `xstrfmt("help should not end with a dot:
%s", opts->help)`)

Thanks :)

[1] https://lore.kernel.org/git/220221.86tucsb4oy.gmgdl@evledraar.gmail.com/
