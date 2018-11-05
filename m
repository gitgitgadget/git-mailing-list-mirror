Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13D01F453
	for <e@80x24.org>; Mon,  5 Nov 2018 07:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeKEQ0R (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:26:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38637 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbeKEQ0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:26:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so6906594wmh.3
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 23:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K/rt7OAKSaD47Uh9fIpA1f4xaTNN0p5B1ak7yQ8wXL8=;
        b=j/J2KRR6i8IwLF4AFJO2Tjre7nU3aWPYAVLpGjuVnWJc/E2V4zjdDdcf7WUcfWJSgg
         qieb7VzAuD2JLAA2is2/oYG9gai7nZAmsSODgI9NhYySS5tSA9t+uDZP+oLVHPg7SsT4
         h2CMkaDlcHZGLfP2GQePcAMtJ7I5Fv51T07GXp2nGBeHSR6+ACByyj8yhR+CROblofKu
         loXgoMSLfdt0ioY8chlOb/Qd8hOi6nkL89epphdOrGkUgvHwX0kuYapUtyCdpU0nkb6U
         rv96sbATv006e4DrGp058rF2KcHr69jevG3mkf8VWoQUUHrccnMgO4Xqk5GNgbQxZhBm
         GVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K/rt7OAKSaD47Uh9fIpA1f4xaTNN0p5B1ak7yQ8wXL8=;
        b=pxRSqDvFNJE858llKYjagrzxkE8nF/rR2IAjmqjzaj7qEIOmP7m9d0VNbC977dvHXR
         YuvrpLREb7XgxBuuM5FqnmmmSZHr8qy0ZcodLAM63K9qtwlQRvvL/s6nsgtjVmhy28zR
         XkkpHtCpC1OI1niew706ZlQzQswLxwTw48sCk1jugxXYVYxtwALwtyn4IKfbFqzZKb/b
         e0akA0nIVbaEgEyN+hm8tNEe5qnYQUk1FkQLxpqb00nm6TQLV55SzVI+JBu06AFSM6U7
         lHFBDuzuIsRTUAF6ZNZKQ7Yb3Vwwoke151A2U2kzd2VFJUyjdoKSWV6EztzOiFdmDtOX
         0kBA==
X-Gm-Message-State: AGRZ1gKdOLw953juZqLnW7ys/MlrgstVneU26FHuI3Djwq7cHkG1B52e
        ySzvDM1eiR+qVpTExjiBWaw=
X-Google-Smtp-Source: AJdET5f8adkFbWnI7ZD5rRa/UwA7bA8Bon5D2PCqhKB7n9VDYFQSE63YbTj29RKn8miDC/2iGIfI2A==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr5374978wma.9.1541401681417;
        Sun, 04 Nov 2018 23:08:01 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e10-v6sm26414935wrp.56.2018.11.04.23.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 23:08:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/13] apply: mark include/exclude options as NONEG
References: <20181105063718.GA24877@sigill.intra.peff.net>
        <20181105063819.GA25864@sigill.intra.peff.net>
Date:   Mon, 05 Nov 2018 16:07:59 +0900
In-Reply-To: <20181105063819.GA25864@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 5 Nov 2018 01:38:19 -0500")
Message-ID: <xmqqd0rkhui8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The options callback for "git apply --no-include" is not ready to handle
> the "unset" parameter, and as a result will segfault when it adds a NULL
> argument to the include list (likewise for "--no-exclude").
>
> In theory this might be used to clear the list, but since both
> "--include" and "--exclude" add to the same list, it's not immediately
> obvious what the semantics should be. Let's punt on that for now and
> just disallow the broken options.

Thanks.  I agree with the conclusion to leave it to later outside
this series to define what --no-(include|exclude) should do.

I suspect something along the lines of

    Each element on the single list is marked as either include or
    exclude, and "--no-include" would remove the accumulated
    "include" entries in the list without touching any "exclude"
    elements.

would be sufficiently clear and useful, perhaps.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  apply.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 073d5f0451..d1ca6addeb 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4939,10 +4939,10 @@ int apply_parse_options(int argc, const char **argv,
>  	struct option builtin_apply_options[] = {
>  		{ OPTION_CALLBACK, 0, "exclude", state, N_("path"),
>  			N_("don't apply changes matching the given path"),
> -			0, apply_option_parse_exclude },
> +			PARSE_OPT_NONEG, apply_option_parse_exclude },
>  		{ OPTION_CALLBACK, 0, "include", state, N_("path"),
>  			N_("apply changes matching the given path"),
> -			0, apply_option_parse_include },
> +			PARSE_OPT_NONEG, apply_option_parse_include },
>  		{ OPTION_CALLBACK, 'p', NULL, state, N_("num"),
>  			N_("remove <num> leading slashes from traditional diff paths"),
>  			0, apply_option_parse_p },
