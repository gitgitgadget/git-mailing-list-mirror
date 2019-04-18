Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3FC520248
	for <e@80x24.org>; Thu, 18 Apr 2019 00:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfDRAsn (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 20:48:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39855 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDRAsm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 20:48:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so651783wrn.6
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 17:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y39DMgZwkeJNTQbnIoOJsz93z9B5Ag4yQjjMHU8RFQM=;
        b=AEVQOptpR5lpXL7JXTqU0XAEwRPHsgEGq3ErUC4+lnV//l0PwYa6W6t3fYT9pG03QR
         6bz+Il7z1kuddwQNmzjdSYYpaZl/A343uNVmeov/YkiigNC4QShSXdYob+6M5gNl+cMD
         UkWCtRY9BqDPY4XjeqdX0STlq6jRABU8dcY3qliX7L0BaHwDcsA5i25IJEfYD4aRtHKO
         LlMug8g5+bclZOU/ybUr1maVlGo6FCJ5Pd+Lc+GDCfv1dowVWdspHbcon4Yec0uhnY4C
         IdKh/P519fhuC/9sCxA71lZo1r0mZrkxdrQabnHYJ2kCHQ0E/zoP4WC1Q21ckkZBjgt2
         HLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y39DMgZwkeJNTQbnIoOJsz93z9B5Ag4yQjjMHU8RFQM=;
        b=kcF8IQTB2cs/JGwMX5WACFDNqTKtAMvi8BlETMJAAxSUROTpkopxbNlwD0XKd8SXxj
         6+ss3lr9WnbwgWOUckivQNeWaKWsxIunjpUbpMnphN6dYrVPgnaq9WQli33qe8rXTu/o
         HDUwTUSlrPF+zQ6lDIfyHv+dqI/nxnXZ2VK3V6Uk0pusTe9WXx3qRoygWQ3YSbw2pnpN
         0AwEICxZwtP2+CQbUl6G9dwZ/HoALJFGdfgvZBj5iEpMsGZfsMK42/8DNBIPh+HmP6Kd
         dOUnSOig4GCLTj76bpjexbdq2ZHRx3qL5AQjseiVXUf5g7KZsbL79xDJeNN1ibg2zUj/
         UUVA==
X-Gm-Message-State: APjAAAVjU6nZP9jzuwHPmgwnznmiChouqS7iAzUrVWetMz58LOIjpbvg
        iBFv4KR7iji603OAEno+7iM=
X-Google-Smtp-Source: APXvYqy2dt4V3DZya0eAmW8IR2cuPthfmzAkfoln2kws9M8HhFUcaIh8tcnA2RObjFtVo1Th8A13Qg==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr15542787wrx.115.1555548520588;
        Wed, 17 Apr 2019 17:48:40 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g132sm402351wme.3.2019.04.17.17.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:48:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] parse-options: don't emit "ambiguous option" for aliases
References: <20190325202329.26033-3-avarab@gmail.com>
        <20190417124438.8191-1-avarab@gmail.com>
        <CACsJy8D215hMvfCwz1G9mP2te-ZERVaMMRrnM=MK1_bc0oFsjw@mail.gmail.com>
Date:   Thu, 18 Apr 2019 09:48:39 +0900
In-Reply-To: <CACsJy8D215hMvfCwz1G9mP2te-ZERVaMMRrnM=MK1_bc0oFsjw@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 17 Apr 2019 23:04:59 +0700")
Message-ID: <xmqq4l6wjfyw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>         { OPTION_CALLBACK, 0, "recursive", &option_recurse_submodules,
>>           N_("pathspec"), N_("initialize submodules in the clone"),
>> -         PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, recurse_submodules_cb,
>> -         (intptr_t)"." },
>> +         PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE,
>
> What happens if someone adds --recursive-hard? --recursi then
> resolving to --recursive-hard sounds wrong.

That was exactly my initial reaction.  Or "recurse-submodules" gets
renamed away, and "recommend" gets added---now "--rec" is still not
ambiguous as "recursive" is marked not to participate in the
disambiguation (I think OPT_NOCOMPLETE should at least be renamed to
OPT_NO_DISAMBIGUATION or something---if we were to use it for the
purpose of marking an option as "not participating in
disambiguation", but I am fairly negative on the approach).

And my initial reaction was followed by "don't we want a more
explicit link only between recursive and recurse-submodules?",
which exactly matches what you said below ;-)

> But on the other hand I can see it's a bit more work to teach
> parse-options OPT_ALIAS to say "--recursive is just an alias of
> --recurse-submodules" and chances of --recursive-hard coming up are
> probably very low.

The "bit more work" is something that is worth doing in this case, I
think.

Thanks.
