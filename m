Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D93EB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 20:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjFTUcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTUcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 16:32:08 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C9D91
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 13:32:07 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5538f216c7aso1380579a12.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687293127; x=1689885127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKNov0gWmOyN2GhW/W4ovoFIiQk09CwqIjF3GkWT+n0=;
        b=54I7v0lMtAq10nu986YkyiLUtQRpqwWAh2DlUcsriGVhI5Qr4yY25owMdZxPL73OIv
         +GRW4BQMbEt4F5oqtW2r/5TrKqFLb0sZKFFjvvN24i4baTEvXbVMqM2YBGZU/jLNbBS5
         41cKLQ5ODut2BbFi5BWpaT0Lq5ByNCmUYk0UeDzEj7s+FhKbD+5cqVk1EX0MtE8KT0dr
         lBWAR0eDL88S9AlyX8vaRUYwWI8AUZHm9E5neSQ+7tEbzjZju8Auw3ASgU72l/sxgFH6
         l/Q1T+5eCXX0Cm0qWeWTcHr/+zVIQ6on87NwR06WotYLEganThdeQR8vWBKAvPN5pvZG
         nauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293127; x=1689885127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKNov0gWmOyN2GhW/W4ovoFIiQk09CwqIjF3GkWT+n0=;
        b=QEnXrv66MvExeaMkoIgWTJvXsGm8Dou+Adfbv7e/ano1EVwE/pZInVH7vbebwqn4e8
         VMRmWRCVtQLZfVY95HoKP1Uy9Gm/K101q5YKUoYfvrSCjqXrH9ZGW5gMm5ry1pkuU5Ed
         cMDpUmLfpAEb6wEQfi705jCqFaPpX8DmK9N5I7T+D70QVt7FppDo9peU3YrE/myRe7P2
         AP4tgC9o6JGyk5RMkQaVVmtTTUWQ1K0lxVOsCcXW5y0FmM36zM8gpNq4TIwEA6aJjNKb
         t9GrqlQh5+FOlAeuyVsKOdBJ1MHIw62Cbuy/VNjpk10R/mNudMWJqq/mr/VuBeCl9V+2
         PBIA==
X-Gm-Message-State: AC+VfDxDUUNXK8083d17jX/SM+VvhNsM5H6/0WYIsvxUn3mQlTPCUxy7
        cQIA9krnP75VYfq4rANXkf/a5uV8cUq16g==
X-Google-Smtp-Source: ACHHUZ7RZbN6cXOLw796Ko+odFV3xS+QBKixKgjG21qCxTkX2hS4l/0VFzgiPtEJr5mqITmmG5iopTeuTeck2Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:4c0c:0:b0:553:b2a0:4ddd with SMTP id
 z12-20020a634c0c000000b00553b2a04dddmr1148873pga.2.1687293127042; Tue, 20 Jun
 2023 13:32:07 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:31:57 -0700
In-Reply-To: <20230617051559.GD562686@coredump.intra.peff.net>
Mime-Version: 1.0
References: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230617044232.GC562686@coredump.intra.peff.net> <20230617051559.GD562686@coredump.intra.peff.net>
Message-ID: <kl6l8rcdswn6.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] http: handle both "h2" and "h2h3" in curl info lines
From:   Glen Choo <chooglen@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When redacting auth tokens in trace output from curl, we look for http/2
> headers of the form "h2h3 [header: value]". This comes from b637a41ebe
> (http: redact curl h2h3 headers in info, 2022-11-11).
>
> But the "h2h3" prefix changed to just "h2" in curl's fc2f1e547 (http2:
> support HTTP/2 to forward proxies, non-tunneling, 2023-04-14). That's in
> released version curl 8.1.0; linking against that version means we'll
> fail to correctly redact the trace. Our t5559.17 notices and fails.
>
> We can fix this by matching either prefix, which should handle both old
> and new versions.

Thanks! This patch looks good to me.

I think the approach of matching both patterns literally is better than
trying to catch both `h2h3` and `h2` with a single pattern. Yes, it's
more readable, but it'll also extend better to future changes in curl -
we have no control over what curl might choose to log in the future,
which could be something completely unmatchable.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index bb58bb3e6a..b71bb1e3ad 100644
> --- a/http.c
> +++ b/http.c
> @@ -746,7 +746,8 @@ static void redact_sensitive_info_header(struct strbuf *header)
>  	 *   h2h3 [<header-name>: <header-val>]
>  	 */
>  	if (trace_curl_redact &&
> -	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
> +	    (skip_iprefix(header->buf, "h2h3 [", &sensitive_header) ||
> +	     skip_iprefix(header->buf, "h2 [", &sensitive_header))) {
>  		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
>  			/* redaction ate our closing bracket */
>  			strbuf_addch(header, ']');
> -- 
> 2.41.0.402.g53108db102

