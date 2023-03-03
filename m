Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BBAC7EE2D
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 17:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjCCRNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 12:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCCRNa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 12:13:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A53714999
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 09:13:29 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p6so3434683plf.0
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc+NEA6xxiXECeXvcL1Hwzb1ua6tPgmlb+iHpxPLfvg=;
        b=RSWbj1yGOEy/cSBm4fG23cXOqgC0xHn9Cv+8DuqnA3MB0uCB7l8bUlIU4P9mqd/9DC
         4DL0kItp1rZegJ89AQm9hxxU+VIYu8rISVU0pXyXxwR6+nGuNAQ8Z8UzXjPsL+lKKDlb
         Rirri9nw59qcMBWZr3Ki30AcIicB+fWx3WIsFy9nLUQtGbgG8DNbZho24cmHN5opfHwn
         kXF7WXGvgfxrfTZIwDzbqIFD6CYjJf7yn9WQFAMFKRevW7zagZZC+pPW3pZxlIr9mqmc
         3qpZNuBVBI3Y7TrwCyObimonrhlSouwW0iF7ZPEjYTjFyFGEdXYObxfmPjWNBIZdMJ2I
         ZjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yc+NEA6xxiXECeXvcL1Hwzb1ua6tPgmlb+iHpxPLfvg=;
        b=ZvCNhotdMKxfO0qxE2eEdue8C74o6Tci/YaffWO8qOY1WCG5FO9zRKc2e8+tRiK/DA
         Cn/iNgoSUroceig5Daa0/r6Cqfe0n9C5hcABQ4RsYvNWHVWhdfLs/g268nS9fJCN90rQ
         nXrGsIUrQg33fpSvnQxRQ0MCzFXB5SXMtyXSXy/PyPTu80uYxjA4AGdpFHNx+UOBA72b
         tQvP/acYjhY41S/Pa3hGxw9B8Xl9b14clxuaRdfjiJLkvEZbB1hturCkWk/wFZcz3zqu
         BGcyOdksK60qjRjQnBlJer7oNKFGU1mJyUxQHAgYnd/MgYNxtYk5vrB6TGVlIS52Xkua
         wqAQ==
X-Gm-Message-State: AO0yUKVry+pDPdIJ1Lzwy/OyEeH8RB23hv65QKmvSb3GKSWm4vRT7Hr4
        etZ8MFEXHohaKIVj5K2AL1eAet0pAHg=
X-Google-Smtp-Source: AK7set/QA82x63VJxl3k/KZtAzIGovx7+afbVuL+GRyi1e1eTCgREcFrP9OPAzdrAX4f3AOnTcp0rg==
X-Received: by 2002:a05:6a20:b903:b0:cd:3f69:e15 with SMTP id fe3-20020a056a20b90300b000cd3f690e15mr2355605pzb.11.1677863608834;
        Fri, 03 Mar 2023 09:13:28 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x20-20020a62fb14000000b005d6fcd8f9desm1919433pfm.94.2023.03.03.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:13:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     John Keeping <john@keeping.me.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: output header for empty commits
References: <20230303160301.3659328-1-john@keeping.me.uk>
Date:   Fri, 03 Mar 2023 09:13:27 -0800
In-Reply-To: <20230303160301.3659328-1-john@keeping.me.uk> (John Keeping's
        message of "Fri, 3 Mar 2023 16:03:01 +0000")
Message-ID: <xmqqwn3xg3m0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

> When formatting an empty commit, it is surprising that a totally empty
> file is generated.  Set the flag to always print the header, matching
> the behaviour of git-log.

Don't these empty files help send-email as safety against sending
them out?  Unless existing tools depend on the current behaviour in
such a way, I think this is quite a sensible change.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index f3313b8c58..ffc7c60680 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -59,6 +59,10 @@ test_expect_success setup '
>  	test_tick &&
>  	git commit -m "patchid 3" &&
>  
> +	git checkout -b empty main &&
> +	test_tick &&
> +	git commit --allow-empty -m "empty commit" &&
> +
>  	git checkout main
>  '
>  
> @@ -128,6 +132,12 @@ test_expect_success 'replay did not screw up the log message' '
>  	grep "^Side .* with .* backslash-n" actual
>  '
>  
> +test_expect_success 'format-patch empty commit' '
> +	git format-patch --stdout main..empty >empty &&
> +	grep "^From " empty >from &&
> +	test_line_count = 1 from
> +'
> +
>  test_expect_success 'extra headers' '
>  	git config format.headers "To: R E Cipient <rcipient@example.com>
>  " &&
