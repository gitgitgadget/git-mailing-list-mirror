Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22CC1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeIEA6U (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:58:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51946 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEA6U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:58:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so5762638wma.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zP3IM4j2CsEzP5gCJuZE6VhFKruz+s65gN7vleXIzNA=;
        b=BrNF3e833b6LlNzidHAi/UPl3hDr04X858zwIBFu9HFMitR4QC6AzVkx0HLwO1u/VR
         R3Siu33n8A0KH+IT8fKvVWZYfQTqdKaA/qO/aUf5hqlZfErQcPDT0QdPVLMQ0hKnsI9w
         Ch41E7+UNIczs8mYpB8ejL2wJGeIEVzXItes9piBCECP1/+Q1nIA+H+Mw4NEAKjkGzm7
         xQc1ZPtNIsrtSotnu+dOG6Wi8q3A/LCTqNtV5h2hNZrj6h4OHhG0A32AdIw+YwdbBc4D
         +9gP7Qod/NxKu2kkYu4nFmjYpPMxfgJJXVACAzLfuiP7dxwH/Z5AnrOVbRq06ypGbMya
         DL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zP3IM4j2CsEzP5gCJuZE6VhFKruz+s65gN7vleXIzNA=;
        b=T+cwY1Mrlb8Uqxm55yMmfCAzb+49RtcHrvb496OAU9AmOwYKOC4r7SKYcwuemsS7Vj
         1ONHK0iO7MUSh+chpjM1k6pbK4EIHx89oITZrk2L4QSOT/RbOc/OnLG7JTRrZwN3RHuS
         UkruRPWiK5rfwFqXrV+71QstNzc9bvLJgGLj0dSQD8TVwpJoXDNO6Tu0It3xsXBe2hgl
         cc3vN4eydHzQwpTd++K3wXMo+2888oOzD45cC83VxnJrC1xSQ3cZPbuKAGtUWnvb/0/S
         zh28JyADrJAmAl4AHXOcEF2bQBSE8w4LdO84eSGBQaaMkyOAKwIgEa0qBqM/Z6wzzW5y
         ERkA==
X-Gm-Message-State: APzg51CmwMp8eKlvwq3KBdgn/ooxk7Y7LCJppzQIr3HF2o3ulB/MQF9k
        j+bE83ELePkSLVuk81wzXsk=
X-Google-Smtp-Source: ANB0VdYaUUuvxqDF2Djah+QGKgjzNBLNh0Yigo12X1EAZWI/Zdo1d4uM6dcWXWBsf0YYJFaKY5Fvww==
X-Received: by 2002:a1c:3bd4:: with SMTP id i203-v6mr8744532wma.73.1536093093033;
        Tue, 04 Sep 2018 13:31:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g2-v6sm47293068wrd.71.2018.09.04.13.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 13:31:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     sbeller@google.com, git@vger.kernel.org, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v7 5/7] revision: mark non-user-given objects instead
References: <cover.1533854545.git.matvore@google.com>
        <cover.1536081438.git.matvore@google.com>
        <6ada2b97faba0ed8012ecd00477eac4e33eeb76f.1536081438.git.matvore@google.com>
Date:   Tue, 04 Sep 2018 13:31:31 -0700
In-Reply-To: <6ada2b97faba0ed8012ecd00477eac4e33eeb76f.1536081438.git.matvore@google.com>
        (Matthew DeVore's message of "Tue, 4 Sep 2018 11:05:48 -0700")
Message-ID: <xmqq5zzl80nw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> diff --git a/revision.h b/revision.h
> index 5118aaaa9..2d381e636 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -8,7 +8,11 @@
>  #include "diff.h"
>  #include "commit-slab-decl.h"
>  
> -/* Remember to update object flag allocation in object.h */
> +/* Remember to update object flag allocation in object.h
> + * NEEDSWORK: NOT_USER_GIVEN doesn't apply to commits because we only support
> + * filtering trees and blobs, but it may be useful to support filtering commits
> + * in the future.
> + */

Just a minor style nit, but our multi-line comment begins with the
opening "/*" (and closing "*/", too, but you got that right) on its
own line, i.e.

	/*
	 * Remember to update ...

> -#define USER_GIVEN	(1u<<25) /* given directly by the user */
> +#define NOT_USER_GIVEN	(1u<<25) /* tree or blob not given directly by user */

Is "given directly by user" equivalent to "given on the command
line"?  Do objects given via "--stdin" count the same way?  How abot
those given via "--branches" or "A^@"?  Does "not given directly by
user" mean roughly the same thing as "discovered by traversal"?

Not a suggestion to change anything in this patch, but if you can
come up with a better phrase that helps new readers' understanding
so that they do not have to ask a question like this, that would be
great.

Thanks.

