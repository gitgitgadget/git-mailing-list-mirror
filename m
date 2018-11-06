Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8335F1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 02:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeKFLog (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:44:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46523 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeKFLog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:44:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id 74-v6so11677005wrb.13
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 18:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0q3X795lcAfkGjmlhlL4CzIrF9EgZ+SH2zmqo8eqqjA=;
        b=kUzBFpO6NH2spoiOay0dvcxPfpHooIejNSf0D1GPM5cIvHRdXIvZyzN6O4a9q3yju/
         MTCt6b2T0rzodgkgTQjbcNMQMoTK/B2B5j0f6MssaZvfjc9SW3xU0ib11aU73stLZWky
         7J+PGUHtAJugW8oF8z29LsEM0SHg5dyowwL5nEOHDYz0bAUOo6jJjs98gBeO1q+g81zl
         DR53psa+Su5qxCmBe0hI59/af6EVwiW+gj4wZRdtuqwXpSrzOWrNCF1akYkqJHfZFfOS
         Iu3K/HPKDsZNTvt6jq3D5yDJ72bWcC0hmU8waE8/sGV/Uo5b90zj4aEsuxFbHxBHA0V3
         qsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0q3X795lcAfkGjmlhlL4CzIrF9EgZ+SH2zmqo8eqqjA=;
        b=NddC0Bkr8mixk1EFILPSJMEcT1ZPxcy/VvEozZxk1rPnGRjRqvf/xq63mP0Z2NPttt
         QrTV/QKolmUjQ9UxBh3LOHgqu3J11nBNERKdAhmgXcTe8v0LDoyOyS6VJxxrrcjBp8yh
         nf5lB9aWBxB29UCPMQXdBvrkWUa58M4V4Po3wT6ifqZn8JCWQVh4fXYeFGi/5MIptuoe
         oLqaACNb1tFUCssUnjUJRwliR+Utg3Fgf1vCjokIHqYxKNdiSSQeqoeXdW/uEVSE3TZ/
         GbCzSU6uAF2WjOP1WuScIt+9QtjUEUPVjwPJU5tOVjpVRgerXF1l23rGNSrU3CCsOPD6
         VtdA==
X-Gm-Message-State: AGRZ1gIjovKeGXQasm/sxPnWeC2KexqWMmEF/fNcVHl9IFNPpm07Asu+
        f5+wVWJBUlqvbI0ekMkxw5U=
X-Google-Smtp-Source: AJdET5canXMc5sKyqTwaXdlCbV9zDrevBBWCUT0wp8sGIq1UmriMSCLw5njrPRM+OJvaRR0C8Ws/XA==
X-Received: by 2002:a5d:4d4e:: with SMTP id a14-v6mr2068348wru.316.1541470906014;
        Mon, 05 Nov 2018 18:21:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y2-v6sm11307229wrh.53.2018.11.05.18.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 18:21:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 09/16] remote.c: turn some error() or die() to BUG()
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181105192059.20303-1-pclouds@gmail.com>
        <20181105192059.20303-10-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 11:21:44 +0900
In-Reply-To: <20181105192059.20303-10-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 5 Nov 2018 20:20:52 +0100")
Message-ID: <xmqqtvkveyiv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The first error, "internal error", is clearly a BUG(). The second two
> are meant to catch calls with invalid parameters and should never
> happen outside the test suite.

Sounds as if it would happen inside test suites.

I guess by "inside the test suite" you mean a test that links broken
callers to this code as if it is a piece of library function, but
"should never happen, even with invalid or malformed end-user
request" would convey the point better, as the normal part of
testing that is done by driing "git we just built from the command
line should not hit these.

The changes all look sensible.  Thanks.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  remote.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 81f4f01b00..257630ff21 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -620,7 +620,7 @@ static void handle_duplicate(struct ref *ref1, struct ref *ref2)
>  			 * FETCH_HEAD_IGNORE entries always appear at
>  			 * the end of the list.
>  			 */
> -			die(_("Internal error"));
> +			BUG("Internal error");
>  		}
>  	}
>  	free(ref2->peer_ref);
> @@ -707,7 +707,7 @@ static void query_refspecs_multiple(struct refspec *rs,
>  	int find_src = !query->src;
>  
>  	if (find_src && !query->dst)
> -		error("query_refspecs_multiple: need either src or dst");
> +		BUG("query_refspecs_multiple: need either src or dst");
>  
>  	for (i = 0; i < rs->nr; i++) {
>  		struct refspec_item *refspec = &rs->items[i];
> @@ -735,7 +735,7 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
>  	char **result = find_src ? &query->src : &query->dst;
>  
>  	if (find_src && !query->dst)
> -		return error("query_refspecs: need either src or dst");
> +		BUG("query_refspecs: need either src or dst");
>  
>  	for (i = 0; i < rs->nr; i++) {
>  		struct refspec_item *refspec = &rs->items[i];
