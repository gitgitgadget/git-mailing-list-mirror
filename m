Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1301F404
	for <e@80x24.org>; Mon, 13 Aug 2018 12:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeHMPIj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 11:08:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:37693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbeHMPIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 11:08:39 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ls8Qd-1g1b8T0qL9-013uog; Mon, 13
 Aug 2018 14:26:30 +0200
Date:   Mon, 13 Aug 2018 14:26:36 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 7/8] diff.c: compute reverse locally in emit_line_0
In-Reply-To: <20180810223441.30428-8-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131422580.71@tvgsbejvaqbjf.bet>
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-8-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jLEflznLURcyhaJvORYfyVyTw84C6cRo09wuh1oj9ritZltJio/
 me9mQcE2T09NYd0A5bajmq+tVqeC6IiGvEdBYEcOn0C+WK6WwK+DCOqtf0OmoIrtD5AKfxy
 NNGgtqEsKcEH2a+I0ScXqVLP1nTcN2RO3C4KlOlhshCppk267qBw6JdGb9mEP6HJpM4L8wU
 OlMCmiEEwCoNR8Oqt76gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KAuZqlweAbg=:dTrInGToYuN6js0NMvbwDL
 YmnD1nIXAFA9w9jn720JIh+2bRIvoFL5waQhMTfcm/IPsDT8VYI32ivWVnY+qjJqIzHtxRy+6
 4YcnETRIJwZN6VnKqePHEL5I+ynuIl1H37WWR4Y1WubqMhLY4GcUkgGhfqx09F8lOSBOyXEVZ
 YF8oVIdteiNCuy86fOPTczPVOYvwgF64ixHWyHXkNTOcXbUCX/SquzrYsUyLekvRuD1RIgn0r
 9SB2Z4f/Pl1wXWZ4Q2kCJ5wc253Hzlbxi6C7KxNTINsdPVJT36veaAb1mZpG9Ux4ljGlwXxhC
 1rOBR3XZAd8dJ/J8wbKDRW7jWPLS0GDIQHO+hGTcSepRAThP3GDsHHRYmw5TWErvSv3rTX+9b
 Y/F4BSL2dfVaVq0vKVwRAg36saQUJxXc5FmVqAAKpl7eDxsn/UbnfNAWqYDsjjZ+VzUNbhEjN
 VmolH3F0p/+bHwZkzCjdbK+SjknluXA1jG0SPbB2InRd7UUMzgNKIduZiynwg5CNETT7liJSw
 Yd4XKSz9Xeb0k1n5jUFMtcXPOU83Y4GBFrzImAvmY6UCbev3eQDAh9A9T8S8JEFwfHyiQ1nrS
 B0Eh/1r0G3bmeqp618ikfK9eD3p1UFSBP0UG+leejT6HSYlGN50ylef9mJJRSQuVEQRQ7x4eH
 PCsn7Nsooh3n2IMowXRJBwgQ7ikI7RbzZH6134bm6oqRm4dBJ9VA0/3sjMuSOAeq6uxrT/HRd
 f/4g5NOOHD/C9PaqO8sRome8qjh8A8IxLDhKIg7qsh0dxDWnMGTRQd/0qmIXSRqkEoP5kX3Kj
 XU3tu4W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Fri, 10 Aug 2018, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Well, my rationale for having the explicit `reverse` parameter is: this
code is complex enough, introducing some magic "this and that implies
this" makes it much harder to understand.

So I am not at all sure that this is a good thing.

> ---
>  diff.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 01095a59d3d..e50cd312755 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -622,11 +622,12 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>  }
>  
>  static void emit_line_0(struct diff_options *o,
> -			const char *set_sign, const char *set, unsigned reverse, const char *reset,
> +			const char *set_sign, const char *set, const char *reset,
>  			int first, const char *line, int len)
>  {
>  	int has_trailing_newline, has_trailing_carriage_return;
>  	int nofirst;
> +	int reverse = !!set && !!set_sign;

In contrast to, say, Javascript which has this nice feature that you can
write `set || set_sign` to mean `set ? set : set_sign`, I am fairly
certain that `set && set_sign` already evaluates to `0` or `1`. No need
for all those exclamation marks!!!!

:-)

But as I said: I think it is a bit too magic for my liking to say "if
the diff marker color is specified as well as the color for the rest of
the line, then the diff marker will be reversed". That's just making the
code hard to understand, i.e. less readable rather than more.

Ciao,
Dscho

>  	FILE *file = o->file;
>  
>  	fputs(diff_line_prefix(o), file);
> @@ -671,7 +672,7 @@ static void emit_line_0(struct diff_options *o,
>  static void emit_line(struct diff_options *o, const char *set, const char *reset,
>  		      const char *line, int len)
>  {
> -	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
> +	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
>  }
>  
>  enum diff_symbol {
> @@ -1203,15 +1204,15 @@ static void emit_line_ws_markup(struct diff_options *o,
>  	}
>  
>  	if (!ws && !set_sign)
> -		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
> +		emit_line_0(o, set, NULL, reset, sign, line, len);
>  	else if (!ws) {
> -		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
> +		emit_line_0(o, set_sign, set, reset, sign, line, len);
>  	} else if (blank_at_eof)
>  		/* Blank line at EOF - paint '+' as well */
> -		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
> +		emit_line_0(o, ws, NULL, reset, sign, line, len);
>  	else {
>  		/* Emit just the prefix, then the rest. */
> -		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, "", 0);
> +		emit_line_0(o, set_sign, set, reset, sign, "", 0);
>  		ws_check_emit(line, len, ws_rule,
>  			      o->file, set, reset, ws);
>  	}
> @@ -1234,7 +1235,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  		context = diff_get_color_opt(o, DIFF_CONTEXT);
>  		reset = diff_get_color_opt(o, DIFF_RESET);
>  		putc('\n', o->file);
> -		emit_line_0(o, context, NULL, 0, reset, '\\',
> +		emit_line_0(o, context, NULL, reset, '\\',
>  			    nneof, strlen(nneof));
>  		break;
>  	case DIFF_SYMBOL_SUBMODULE_HEADER:
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 
