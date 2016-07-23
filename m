Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97888203E1
	for <e@80x24.org>; Sat, 23 Jul 2016 09:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbcGWJAk (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 05:00:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:55601 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbcGWJAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 05:00:39 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MCLQ1-1bZNEo3vM1-009CA0; Sat, 23 Jul 2016 11:00:28
 +0200
Date:	Sat, 23 Jul 2016 10:59:49 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Wong <e@80x24.org>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: escape "From " lines recognized by
 mailsplit
In-Reply-To: <20160722224739.GA22961@whir>
Message-ID: <alpine.DEB.2.20.1607231056150.14111@virtualbox>
References: <20160722224739.GA22961@whir>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3T4os1giPjk2LbaPcMiTLH+johtjDi7q7tK/CC4Z3bKczDlab5B
 Cv+jUxVrNRZFA7VaFa9+A1xVxJutsYAuA3eLzeV9wFeOXvD1WAhHT8tta5zrJWRZufdc3t1
 F8eEb9yEYnoa5BvZAe7KJORSsO8QwW5IjJdQjtRGGaVhQpZuhFbFUP9s4ZJv3UqGtLIBVr4
 ZnqE1R0wGqL11tYqnnh7A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:63qwnBoQhPk=:LxC+jPs71Lu1UGPVYbG9d+
 T6LlsXbvQJ/D84YqWOZLHT3fN0lcdU5T5+FP2tGa6HQ8NjvE7jP/YSm3R17CksXpPsPv1xdNH
 xYsG+R0ZVyZ4e2kPPlNMbEJhCLg7rtxr/uo5M1MqP7HwyafTtL8oztEUH+3r/m2I1kP5m5Ojx
 ifFGy+ljp451wWpKgKbv7RqlfXcx8vBrN74dQ/wesNzXrHIUHmAgUsLyEvoWDGIobQFfqkCXl
 ryrdBLDGXVSl16LSFeVTxVTghAvsh9Gr6g7ELOPQOQG9izt3PRbNK+0hIgG8514Z2nWeNbSn0
 BShy0+D90gRkVTKXbx41iV+IBCe9blxPqU2T3dVVzPqfCNUAFG+uvVs8IQGdTj1t6sEheOW5P
 L01fKllDZgMhuSNO2VHHrhduX+DzvlRnvfANfRg4lQyzcgk9PmVYXYh0EN46cBwO7WQLMnLqJ
 fd8YPtHr5T8y69rnDOT/wyIgUWcDiOZfxzl5BRJrvq3FIa6ow9lWvPJHV56mHhXy747EJzM8M
 ptyFHcx+vyeBY8QEN7Sn/QLmQrXaYwu16NJq8KO4rPdkOQsW5ZxYA/uG5LKUKFYeKNL0Du5sz
 S3jwq39IdBR1tndiRCiuw3BeP2o8aSvykXrHYOrP1v4gadQ402WsdrBSTA2VSDfcaUkuqJTmG
 mThJR/VGFrmFvPTSATfefTet8WYsnVNqzHsQth0uSDY3OB2E+VNKtbpFHnxZsOCkkiYdAzjZ5
 bJk/hywj6VvPuyNghfky2W1MuEg39rEF27oIc7q/uNEKIW0Guqzet0stIwYHZ9DgSTRZyGyzI
 fHBd1MP
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

I think that this change:

On Fri, 22 Jul 2016, Eric Wong wrote:

> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 3068168..bb8f9c9 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -8,41 +8,11 @@
>  #include "builtin.h"
>  #include "string-list.h"
>  #include "strbuf.h"
> +#include "mailinfo.h"
>  
>  static const char git_mailsplit_usage[] =
>  "git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
>  
> -static int is_from_line(const char *line, int len)
> -{
> -	const char *colon;
> -
> -	if (len < 20 || memcmp("From ", line, 5))
> -		return 0;
> -
> -	colon = line + len - 2;
> -	line += 5;
> -	for (;;) {
> -		if (colon < line)
> -			return 0;
> -		if (*--colon == ':')
> -			break;
> -	}
> -
> -	if (!isdigit(colon[-4]) ||
> -	    !isdigit(colon[-2]) ||
> -	    !isdigit(colon[-1]) ||
> -	    !isdigit(colon[ 1]) ||
> -	    !isdigit(colon[ 2]))
> -		return 0;
> -
> -	/* year */
> -	if (strtol(colon+3, NULL, 10) <= 90)
> -		return 0;
> -
> -	/* Ok, close enough */
> -	return 1;
> -}
> -
>  static struct strbuf buf = STRBUF_INIT;
>  static int keep_cr;
>  static int mboxrd;
> diff --git a/mailinfo.c b/mailinfo.c
> index 9f19ca1..0ebd953 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -1035,3 +1035,34 @@ void clear_mailinfo(struct mailinfo *mi)
>  
>  	strbuf_release(&mi->log_message);
>  }
> +
> +int is_from_line(const char *line, int len)
> +{
> +	const char *colon;
> +
> +	if (len < 20 || memcmp("From ", line, 5))
> +		return 0;
> +
> +	colon = line + len - 2;
> +	line += 5;
> +	for (;;) {
> +		if (colon < line)
> +			return 0;
> +		if (*--colon == ':')
> +			break;
> +	}
> +
> +	if (!isdigit(colon[-4]) ||
> +	    !isdigit(colon[-2]) ||
> +	    !isdigit(colon[-1]) ||
> +	    !isdigit(colon[ 1]) ||
> +	    !isdigit(colon[ 2]))
> +		return 0;
> +
> +	/* year */
> +	if (strtol(colon+3, NULL, 10) <= 90)
> +		return 0;
> +
> +	/* Ok, close enough */
> +	return 1;
> +}
> diff --git a/mailinfo.h b/mailinfo.h
> index 93776a7..c1430a0 100644
> --- a/mailinfo.h
> +++ b/mailinfo.h
> @@ -37,5 +37,6 @@ struct mailinfo {
>  extern void setup_mailinfo(struct mailinfo *);
>  extern int mailinfo(struct mailinfo *, const char *msg, const char *patch);
>  extern void clear_mailinfo(struct mailinfo *);
> +int is_from_line(const char *line, int len);
>  
>  #endif /* MAILINFO_H */

deserves to live in a separate patch... It would make the real change
stick out better.

Ciao,
Dscho
