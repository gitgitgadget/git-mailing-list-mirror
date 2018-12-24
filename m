Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9EE20A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 08:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeLXIG7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 03:06:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42557 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeLXIG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 03:06:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so9770205lja.9
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 00:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MBNcO7Lz0Zq+kXrlYciISudO+SboRPJInpPrIk/2nSA=;
        b=YlD+kEiXkWW5o0xm1SIlT0uaYPnM6vvrcyUIVNrqwtvqXQ20AUWH3j26p5BGryONRJ
         TujP3fGY4Gte9h1ednwEWZqZur4c027tqq7jbCzJnK6wYBqwV8iog+iz+bpqZ37bo+AV
         L+flHMyht0DAKxhHSuYLvzHOlfW/Al+wRtnoBjEGy2njH7S5ng6SGmnjipbvC7NAVDEo
         S0VZBWUBMeI1knYNxBNDETDwAe5IrKCTGWa3XGlvA7DaZKoMC20cKjo2WyNbumsU3Hew
         J9N5HmbsjZxadrFf2smo4ZXx9wFtJk8KGYTHay1FOfQ+b7wu6ABULYI+cb38ft6cXubv
         k9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MBNcO7Lz0Zq+kXrlYciISudO+SboRPJInpPrIk/2nSA=;
        b=ZvFLX6O9xButSMwXuyXezDU9ODG0EU7/scYxIMV2H+gfQQU/3PFQWAlHjFeos0H+ju
         RbpSGvPFnp+JYLaUNK7BQ3cZVRuf+Z1/GKvz/DVswcpmd14nC291T1wlNykNRVYwbSF4
         m+Beh9qqv0LE21ek0U+extAag6pna8F/1M7KPJQoohABf8wb2hCtCQ0ffet+kIxm1D1T
         1PmaDaob58loTKizkKHzUBQjOOlFfjeleio0QvkYYN0vKswhbDzgFBEHlfHRT9MpV8aB
         pkMOliME3+0lRtakcqPdWV/ITqO2LV4fAQBsSenZ9U6rQ80Y8/EgzOUprtGgxDLYwwss
         tHQg==
X-Gm-Message-State: AJcUukeIh3g58pfeFMXF6l/XrUL3kNsutPLCGaQcjhyAW+l+X8ebD5fm
        hyXhUasecF/vt4JffLsgKAU=
X-Google-Smtp-Source: ALg8bN5OjJizSvtOs9NBwcnbimD2yDBeTNfDoEwub1TZYzP6H0kQKt5MfbsE/aRlH5/s89GAki0W7w==
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr7125361lje.105.1545638815762;
        Mon, 24 Dec 2018 00:06:55 -0800 (PST)
Received: from duynguyen.home (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id d24-v6sm6266896ljg.2.2018.12.24.00.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 00:06:54 -0800 (PST)
Date:   Mon, 24 Dec 2018 09:06:51 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stan Hu <stanhu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] sha1-name.c: Fix handling of revisions that contain
 paths with brackets
Message-ID: <20181224080651.GA12708@duynguyen.home>
References: <20181223233736.10306-1-stanhu@gmail.com>
 <20181223234058.5834-1-stanhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223234058.5834-1-stanhu@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 23, 2018 at 11:40:59PM +0000, Stan Hu wrote:
> Previously, calling ls-tree with a revision such as
> `master^{tree}:foo/{{path}}` would show the root tree instead of the
> correct tree pointed by foo/{{path}}. If a colon is present in the revision
> name, peel_onion() should assume that the presence of a bracket
> at the end of the string belongs to the filename.
> 
> Signed-off-by: Stan Hu <stanhu@gmail.com>
> ---
>  sha1-name.c               | 14 +++++++++++++-
>  t/t3104-ls-tree-braces.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100755 t/t3104-ls-tree-braces.sh
> 
> diff --git a/sha1-name.c b/sha1-name.c
> index faa60f69e3..588b7a53cc 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1001,9 +1001,21 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
>  	 * "ref^{commit}".  "commit^{tree}" could be used to find the
>  	 * top-level tree of the given commit.
>  	 */
> -	if (len < 4 || name[len-1] != '}')
> +	if (len < 4)
>  		return -1;
>  
> +	/* Check for names in ref:path format in case the path includes
> +	 * brackets (e.g. ref^{type}:foo/{{bar}}).
> +	 */
> +	for (sp = name; sp < name + len; sp++) {
> +		if (*sp == ':')
> +			return -1;
> +	}
> +
> +	if (name[len-1] != '}') {
> +		return -1;
> +	}

Instead of replacing one loose check (find '}' at the end) with
another one, how about tighten the parsing? peel_onion() is supposed
to consume all "len" characters or none so checking something like
this may be better.

Note that it also shows another corner case we need to be careful
about: master^{/regex} syntax _can_ contain colons in regex. I suppose
doing strchr to find the closing '}' here is better than what I did
below.

--8<--
diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..c9e26206ce 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -989,7 +989,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 		      unsigned lookup_flags)
 {
 	struct object_id outer;
-	const char *sp;
+	const char *sp, *end;
 	unsigned int expected_type = 0;
 	struct object *o;
 
@@ -1013,21 +1013,26 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 		return -1;
 
 	sp++; /* beginning of type name, or closing brace for empty */
-	if (starts_with(sp, "commit}"))
+	if (skip_prefix(sp, "commit}", &end))
 		expected_type = OBJ_COMMIT;
-	else if (starts_with(sp, "tag}"))
+	else if (skip_prefix(sp, "tag}", &end))
 		expected_type = OBJ_TAG;
-	else if (starts_with(sp, "tree}"))
+	else if (skip_prefix(sp, "tree}", &end))
 		expected_type = OBJ_TREE;
-	else if (starts_with(sp, "blob}"))
+	else if (skip_prefix(sp, "blob}", &end))
 		expected_type = OBJ_BLOB;
-	else if (starts_with(sp, "object}"))
+	else if (skip_prefix(sp, "object}", &end))
 		expected_type = OBJ_ANY;
-	else if (sp[0] == '}')
+	else if (sp[0] == '}') {
 		expected_type = OBJ_NONE;
-	else if (sp[0] == '/')
+		end = sp + 1;
+	} else if (sp[0] == '/') {
 		expected_type = OBJ_COMMIT;
-	else
+		end = name + len;
+	} else
+		return -1;
+
+	if (end != name + len)
 		return -1;
 
 	lookup_flags &= ~GET_OID_DISAMBIGUATORS;
--8<--

--
Duy
