Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DCB20248
	for <e@80x24.org>; Mon, 11 Mar 2019 06:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfCKGgg (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 02:36:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40803 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfCKGgf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 02:36:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id g20so3025727wmh.5
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 23:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7FJpEEpgQEAI7DNUN4oP/4OXf67rB6Pp/1Oxui/LRTM=;
        b=QGfpQDqZCzgvExpvWQ1PGy3jNl1eK3QreUvjeSdVTNbR/K+lO57lb/JWP8tmH52np9
         ZGhiEr8Vg6NWvg2RJ0ShxiSzChj+uNPQwU9wcZqG6OgOdOP0Sr1Hv1me6GwJplh21g1B
         fOnzzcqMhoNJVoNnbt9AsCKR0sYJc61YFs7AOC6dRtJogZ5uieQ14CyYnIigPkuPrw0N
         bXwLzfnUSP/x0NPIDQ9a7NgTbNIX0XBbkbidFxKbUQaildsI4p/+4zUoWrdWXlYF4Ms6
         3rcJoq0KKlcoURc0h0e9oPTsD+2yYl9M27P8fIhLxJeAIGFK16E8vU2fLkDm3Fk4lXTb
         yIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7FJpEEpgQEAI7DNUN4oP/4OXf67rB6Pp/1Oxui/LRTM=;
        b=HvK5cjGYpW4UC5e36R+QyEhaWIYFwNzDDpHsE8tXUO544GD4gELxYTqPv8fb5ghMiz
         R5c7b3nICeqvEvGJBu9Yr3f37PXzuQm5BhjzrRFPpYBUMLtonhLMIrSSNjF40LULD02e
         yV6oM3gNlxu51UBERf0BasRfO4nTdPAtx3J9SgmE5q0ZnZItiaoufi/qw/ObGTqmg4Zh
         LbvJ75Om3he0talMoiE5M0oI4RQ+u7NJS8flh0Xtu128cRWjB3LkbrqaQ+1FHLNSihVD
         QZPouequ4hw2LbpZ+AOz9Z3RObR0aFiVR5LdbFHjxsXswOvUQ/thJwui+rZhtd/SYTJA
         U4xg==
X-Gm-Message-State: APjAAAUzHcrHDe5F9Y6jJhBX/DoIi746TOIh5cRb/TsGBR26VWOep4Hg
        IQaLf2EM1yTUGRuZFwZs8c4=
X-Google-Smtp-Source: APXvYqwmhpOzSysqARPLq1PIaFkc5o/7M3zsQ9OYlMYhFFD9IguwZdVPihZxampeZ2cDDT42nQmAbA==
X-Received: by 2002:a7b:cf32:: with SMTP id m18mr15662722wmg.98.1552286192931;
        Sun, 10 Mar 2019 23:36:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c202sm11819810wme.38.2019.03.10.23.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:36:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        hi-angel@yandex.ru, peff@peff.net, ramsay@ramsayjones.plus.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v5 1/1] worktree add: sanitize worktree names
References: <20190305120834.7284-1-pclouds@gmail.com>
        <20190308092834.12549-1-pclouds@gmail.com>
        <20190308092834.12549-2-pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 15:36:32 +0900
In-Reply-To: <20190308092834.12549-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 8 Mar 2019 16:28:34 +0700")
Message-ID: <xmqqtvg9kjdb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Update 'worktree add' code to remove special characters to follow
> these rules. In the future the user will be able to specify the
> worktree name by themselves if they're not happy with this dumb
> character substitution.

This replaces both of the two patches in v4, and applies to a more
recent tip of 'master' (post 7d0c1f4556).

> diff --git a/refs.c b/refs.c
> index 142888a40a..e9f83018f0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -72,30 +72,57 @@ static unsigned char refname_disposition[256] = {
>   * - it ends with ".lock", or
>   * - it contains a "@{" portion
>   */

The comment above needs modernizing (see attached at the end).

>  		case 2:
> -			if (last == '.')
> -				return -1; /* Refname contains "..". */
> +			if (last == '.') { /* Refname contains "..". */
> +				if (sanitized)
> +					sanitized->len--; /* collapse ".." to single "." */

As Eric points out, this needs to be fixed.  

I'll use the strbuf_setlen() version suggested by Eric in the
meantime, but "sanitized->buf[sanitized->len-1] = '-'" as done to
everything else in the function may be a better idea, especially
since they'll be able to name the worktree themselves in the future
anyway.

> +
> +	if (refname[0] == '.') { /* Component starts with '.'. */
> +		if (sanitized)
> +			sanitized->buf[component_start] = '-';

... and a dot turns into a dash in some cases anyway.

> +		else
> +			return -1;
> +	}
>  	if (cp - refname >= LOCK_SUFFIX_LEN &&
> -	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
> -		return -1; /* Refname ends with ".lock". */
> +	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN)) {
> +		if (!sanitized)
> +			return -1;
> +		/* Refname ends with ".lock". */
> +		while (strbuf_strip_suffix(sanitized, LOCK_SUFFIX)) {
> +			/* try again in case we have .lock.lock */
> +		}

No need for {}; just have an empty statment

		while (...) 
			; /* try again ... */

This "strip all .lock repeatedly" made me stop and think a bit; this
will never make the component empty, as the only way for this loop
to make it empty is if we have a string that match "^\(.lock)\*$" in
it, but the first dot would have already been turned into a dash, so
we'll end up with "-lock", which is not empty.

> +	}
>  	return cp - refname;
>  }

See below for a possible further polishment.

 * The first hunk is not about this patch but a long-standing issue
   after the comment was given to this function for a single level
   (I do not know or care how it happened--perhaps we had a single
   function that verifies multiple levels which later was split into
   a caller that loops and this function that checks a single level,
   and the comment for the multi-level function was left stale).

 * check_refname_component() can now try to sanitize; document it.

 * The last hunk is from Eric's comment.

 refs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index e9f83018f0..3a1b2a8c3c 100644
--- a/refs.c
+++ b/refs.c
@@ -63,7 +63,7 @@ static unsigned char refname_disposition[256] = {
  * not legal.  It is legal if it is something reasonable to have under
  * ".git/refs/"; We do not like it if:
  *
- * - any path component of it begins with ".", or
+ * - it begins with ".", or
  * - it has double dots "..", or
  * - it has ASCII control characters, or
  * - it has ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
@@ -71,6 +71,10 @@ static unsigned char refname_disposition[256] = {
  * - it ends with a "/", or
  * - it ends with ".lock", or
  * - it contains a "@{" portion
+ *
+ * When sanitized is not NULL, instead of rejecting the input refname
+ * as an error, try to come up with a usable replacement for the input
+ * refname in it.
  */
 static int check_refname_component(const char *refname, int *flags,
 				   struct strbuf *sanitized)
@@ -95,7 +99,8 @@ static int check_refname_component(const char *refname, int *flags,
 		case 2:
 			if (last == '.') { /* Refname contains "..". */
 				if (sanitized)
-					sanitized->len--; /* collapse ".." to single "." */
+					/* collapse ".." to single "." */
+					strbuf_setlen(sanitized, sanitized->len - 1);
 				else
 					return -1;
 			}
