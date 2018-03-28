Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880311F404
	for <e@80x24.org>; Wed, 28 Mar 2018 01:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeC1BWX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 21:22:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37786 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752861AbeC1BWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 21:22:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id r131so2060295wmb.2
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hOu7+qLo8EmaCp4ulzo0Uus9orLZNU3GYTL8D0g6FK0=;
        b=c3tesnIrgT1BdVPnFvErowynBtyqyaA76HdlaYSOz6mOQDTdmqkADjxCULiLyGy8aY
         rqxEYgNZOne7mJr7mFJQ/AJkyMh7G+GIZJwXaFgvEXxWF7T5vkTD/RB/2cS2+lMMv8G2
         yMU9dU3T7UtYl7jSP76nb9f6kcTS6LHCQ608GWIFyI8+lUETVaGkiCB0+32Ongn1I6Rq
         /hiFq1/cspSGNVEZbTAq1ckTmebEwaUCvvELfp30Zru95n4oqQafIHb4LELmkQ31H9e2
         7/C4vTJ7jkLAXzFAXMrA8XtacpKkjL1Mmuf42L70pkhG95UOcI6FeqOV7Tmk3zillUUl
         bSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hOu7+qLo8EmaCp4ulzo0Uus9orLZNU3GYTL8D0g6FK0=;
        b=tkntsu/qnxeQuHOhp9flej793OllqHrWWo/E0eHtShfHFZYf+U+MfEYdnpultRyLp+
         BWVJB1dc0ImPL6hB84lYdauIeS4EBL8rmopGs299DyZpKB1EibOqlAUHT48WOthdjjwO
         123ajsN9KNVwO4KA+z979eidJAEdOSupJMzh9Ykxwj4UJAGHBivIvgz/vPNoZQDH6wA/
         XATwOLPeWJLmp6dlobdaFOOl9slQvw1d/gptf+Ri0UQkaqaGS/yLpv3yrgiuq3O/kU4c
         +W2ChBVuMhXN4odm33jwFRtktPwD33D4xMSNu0K9HDJdOP5YWCOtQsqVdLqUJ8NSV89/
         EjxA==
X-Gm-Message-State: AElRT7G4pzPhGYchgqz8CGNXecl6F083x9wUwsdZX2Y6MsmUe3Zh0cIn
        PSQqnCAVOwfSMt4jpBP55aQ=
X-Google-Smtp-Source: AIpwx4+ofKxcDohjlL2ZY+BJMnejKEHJiQB+hl+db6q4wK7KrM+XTQgvvB4iW2/qBp/S23d/i50Ugg==
X-Received: by 10.28.105.92 with SMTP id e89mr990403wmc.146.1522200134974;
        Tue, 27 Mar 2018 18:22:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k10sm3944836wmb.26.2018.03.27.18.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 18:22:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, peff@peff.net,
        l.s.r@web.de, wink@saville.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON format
References: <20180326143136.47116-1-git@jeffhostetler.com>
        <20180326143136.47116-2-git@jeffhostetler.com>
        <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
        <ad15ccab-088d-b827-a9fa-c83d397c3479@ramsayjones.plus.com>
Date:   Tue, 27 Mar 2018 18:22:12 -0700
In-Reply-To: <ad15ccab-088d-b827-a9fa-c83d397c3479@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 27 Mar 2018 16:45:17 +0100")
Message-ID: <xmqq8tad9epn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> BTW, I forgot to mention that you had some whitespace problems
> with this patch, viz:
>
>   $ git log --oneline -1 --check master-json
>   ab643d838 (master-json) json_writer: new routines to create data in JSON format
>   t/helper/test-json-writer.c:280: trailing whitespace.
>   + */ 
>   t/t0019-json-writer.sh:179: indent with spaces.
>   +        "g": 0,
>   t/t0019-json-writer.sh:180: indent with spaces.
>   +        "h": 1
>   $ 

Yes, and the here-doc that shows expected output looked somewhat
old-fashioned without using <<- indent.

Writing it in a way like this might be a reasonable workaround for
"indent with spaces", which is only about the leading blank used to
indent the line:

<--HT-->sed -e "s/^\|//" <<-\EOF
<--HT-->|  ...
<--HT-->|        "g": 0,
<--HT-->|        "h": 0,
<--HT-->|  ...
<--HT-->EOF

That is, (1) Use the same number of HT as the line that begins the
here-doc to indent the expected output; (2) but explicitly mark the
left-most column with '|' or something; and then (3) write 8 or more
spaces liberally as needed to reproduce the expected output.

I called it a "workaround", as another possibility is to loosen the
whitespace rule in t/.gitattributes; we _could_ declare that indent
with spaces is OK in these scripts as they contain many expected
output examples in here-doc form.

The trailing whitespace after closing C-comment is simply a style
violation that is not excuable (I think I've dealt with it when I
queued the patch); it should just be fixed.

Thanks.
