Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3151FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbdBHWIN (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 17:08:13 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35281 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdBHWHn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 17:07:43 -0500
Received: by mail-it0-f66.google.com with SMTP id 203so480901ith.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SW1cL1dK1+OpdkJsnICqCSyL9+73BQEE9fWe8fRjuuA=;
        b=sNapv+AEXLoIYYDLqkk+lMQfmoMb8lhz8hcjbVvJtkQ8nQyq7nPFFif6EQvnV/HzGY
         nIo1fJgNSJv5HQlZ3oozInQEZglagvOJya6DYSFjcyS8A0dZTAoYTi3gIXXvVM7WSUmL
         53mWddXvAgDj0P8vU134O3liGKPYk3aDE3j3BrWIUeOLfZUbcYzgbUVxN52VaKhOrpqs
         jZ7mQhYeT2yNEUqkEccKuawrMRds7Ox6hlnvHAK6eEsuhVhHiwE/+wSBph1BF06Got1e
         d89YN9YZqkcRTG0xg8v+V4tizzg2Gp22B8fsntgnBMtK5lJSa4PoXLpMLdPWE6hZ17Jy
         LNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SW1cL1dK1+OpdkJsnICqCSyL9+73BQEE9fWe8fRjuuA=;
        b=UiUn9F1s+plEJPaQB0MGdVyABPJnisD92zpSxnBzgHvt8Cb/jjPfwMUWEGTG/VqqJ3
         /UfqfM160cBm2uhFnwBoEEWNvbTPiSNPOSDuxRR9mgTdrYT26NfRhfi4NzgLugYxRXFg
         9VT55V1lAnjmruQIwCjhlGxLVQw5VwBuVwwGfFADm9+cEIpRH/wh5bxwCYk6J/vCZ31I
         he9r93/7HM1h/KsvRYDt24Mf/CqQ0VHgMdfY6Wv8LSvdapxKKPVlmht3d5KsmCNmlWOw
         PbYu1s5/EytBqIOnCE/40Ya3tTw0yRNQpGKB1428ZOdn9mrEwxa7b7QCXQh1NJPuq/pW
         HgpA==
X-Gm-Message-State: AIkVDXK5MGZAJHZjveJB08h5DUgb8iftJO9OfDW1y0fmO/U2Mhr1vfXbrLHvsQpwDaWrLw==
X-Received: by 10.99.124.10 with SMTP id x10mr29003772pgc.25.1486591178304;
        Wed, 08 Feb 2017 13:59:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id c11sm22757139pfe.68.2017.02.08.13.59.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 13:59:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] pathspec: don't error out on all-exclusionary pathspec patterns
References: <alpine.LFD.2.20.1702072113380.25002@i7.lan>
Date:   Wed, 08 Feb 2017 13:59:34 -0800
In-Reply-To: <alpine.LFD.2.20.1702072113380.25002@i7.lan> (Linus Torvalds's
        message of "Tue, 7 Feb 2017 21:14:40 -0800 (PST)")
Message-ID: <xmqqk290uywp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> @@ -546,10 +546,16 @@ void parse_pathspec(struct pathspec *pathspec,
>  		pathspec->magic |= item[i].magic;
>  	}
>  
> -	if (nr_exclude == n)
> -		die(_("There is nothing to exclude from by :(exclude) patterns.\n"
> -		      "Perhaps you forgot to add either ':/' or '.' ?"));
> -
> +	/*
> +	 * If everything is an exclude pattern, add one positive pattern
> +	 * that matches everyting. We allocated an extra one for this.
> +	 */
> +	if (nr_exclude == n) {
> +		if (!(flags & PATHSPEC_PREFER_CWD))
> +			prefixlen = 0;
> +		init_pathspec_item(item + n, 0, prefix, prefixlen, "");
> +		pathspec->nr++;
> +	}
>  
>  	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
>  		if (flags & PATHSPEC_KEEP_ORDER)

Thanks.  Even though the current code does not refer to the original
prefixlen after the added hunk, I'd prefer not to destroy it to
avoid future troubles, so I'll queue with a bit of tweak there,
perhaps like the attached.

Also this has an obvious fallout to the tests, whose (minimum) fix
is rather trivial.

Thanks.

 pathspec.c                  | 7 +++----
 t/t6132-pathspec-exclude.sh | 6 ++++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index d8f78088c8..b961f00c8c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -522,7 +522,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 
 	pathspec->nr = n;
-	ALLOC_ARRAY(pathspec->items, n+1);
+	ALLOC_ARRAY(pathspec->items, n + 1);
 	item = pathspec->items;
 	prefixlen = prefix ? strlen(prefix) : 0;
 
@@ -551,9 +551,8 @@ void parse_pathspec(struct pathspec *pathspec,
 	 * that matches everyting. We allocated an extra one for this.
 	 */
 	if (nr_exclude == n) {
-		if (!(flags & PATHSPEC_PREFER_CWD))
-			prefixlen = 0;
-		init_pathspec_item(item + n, 0, prefix, prefixlen, "");
+		int plen = (!(flags & PATHSPEC_PREFER_CWD)) ? 0 : prefixlen;
+		init_pathspec_item(item + n, 0, prefix, plen, "");
 		pathspec->nr++;
 	}
 
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index d51595cf6b..9dd5cde5fc 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -25,8 +25,10 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'exclude only should error out' '
-	test_must_fail git log --oneline --format=%s -- ":(exclude)sub"
+test_expect_success 'exclude only no longer errors out' '
+	git log --oneline --format=%s -- . ":(exclude)sub" >expect &&
+	git log --oneline --format=%s -- ":(exclude)sub" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 't_e_i() exclude sub' '
