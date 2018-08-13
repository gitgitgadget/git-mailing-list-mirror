Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473201F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeHMOY2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:24:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:56537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbeHMOY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:24:27 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNO33-1fmiPE0xsP-006yt2; Mon, 13
 Aug 2018 13:42:29 +0200
Date:   Mon, 13 Aug 2018 13:42:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/4] diff.c: emit_line_0 to take string instead of first
 sign
In-Reply-To: <20180810224923.143625-2-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131340420.71@tvgsbejvaqbjf.bet>
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-2-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j58ixkf0x6iwrqd6tytJmvXwc6UUEK2wQN+elKq7xAikgEOiDoE
 ubeueyaWWAeKb/moThfrMucIvRfsxTdFRFqnEnZc8jJ2YGH4wArv4mOBOMQBwVDpqeNWEps
 caWufJbQSSFd5oObmjAuPyzkyUCs/ucDz7ko4KEEJItCvLWE4SRRKfuPP7i16xxtzRq8oUA
 7k1coTBlsdq6a62k66qRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1ZZl5yCf7CU=:0BzdbwvMVq23M2sWk2vU6n
 ouPdXpr/eJWjnShq9iKLdLIuZFejpYPb6hgHlkzj3Qu5BPbmCEvq9fp4RTtjaJS0uPaLTAPRY
 3tapQE4x3VXDtMTmoXzYnpX7VAExAaU2ixNYx740CiZbZCRik/DG1jKBKlGxYiqZhA3FA5/1y
 8IyQKkSCSfwFF6GHimYDnxZbBTQzGj8B/4CnOvbGKySlAotXSbvyJN0N7Aoe/Jbek4Gou4yZl
 w33mVQ7eVp0ep0+klEuiHCFVF5I61tMiN0eq67f7i0N/8jcPkz6mqrK0ktOPqatXi1h5bOQhB
 Wq9JgxEfDQYCEXZLXPIV4PSsErI+YI0kfIXHZ4052j284MCIUd1nmmsG7AgdGMPQYnW6C6zYS
 FiFAzxfRCxUEkpdjoQgkcLlI78jmcBIvuj1AikaNMyx31X/+ogBjyEymYz8ZldVjD3FPV2Wwk
 wT42qtHg/zCJAJNp7HMsVUiNSh2HW6ZOEfppI3DlPalyiUi/n3GNwsY5nN8XeTQeW7wpyVQ5i
 sVsN9eh1MfRbj+bktxJ8CUC/Y4W7mX6WVW7qKBN9coaMUEuOnoIXwxsucC5xiAAsLT6BPU8cX
 wnoU4/Y1zdjNXIikCgReVz2+yy1Gw0hdhk6RCtXMfG2nOaTDIWutANKULw5UENkNKl2qQVGcn
 cCmQJf/etWmS3kzykZFQR/G2nLGvY0cRHoXKrX93jfmzmq1vpAMKiT2QC3rkhL9WNB9uoxpOm
 uACHxOKLxH1FcHGluX3h6f0qqSBu41gt5oapyg6iGFyxrcNBO7clQseFJJsp3ZLojAnplbuaZ
 aCGQr9M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> By providing a string as the first part of the emission we can extend
> it later more easily.

Thank you for working on this!

> While at it, document emit_line_0.
> 
> [...]
>  
> +/*
> + * Emits
> + * <set_sign> <first> <reset> <set> <second> <reset> LF
> + * if they are present. 'first' is a NULL terminated string,
> + * 'second' is a buffer of length 'len'.
> + */

That does not make it clear what the role of `first` or `second` is. Could
you clarify that?

(TBH I am not so sure myself what roles they serve. Previously, it was
kind of obvious to me that `first` tried to specify the diff marker, if
any. But now...?)

The rest looks good to me.

Thanks,
Dscho

>  static void emit_line_0(struct diff_options *o,
>  			const char *set_sign, const char *set, const char *reset,
> -			int first, const char *line, int len)
> +			const char *first, const char *second, int len)
>  {
>  	int has_trailing_newline, has_trailing_carriage_return;
>  	int reverse = !!set && !!set_sign;
> @@ -633,11 +639,11 @@ static void emit_line_0(struct diff_options *o,
>  
>  	fputs(diff_line_prefix(o), file);
>  
> -	has_trailing_newline = (len > 0 && line[len-1] == '\n');
> +	has_trailing_newline = (len > 0 && second[len-1] == '\n');
>  	if (has_trailing_newline)
>  		len--;
>  
> -	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
> +	has_trailing_carriage_return = (len > 0 && second[len-1] == '\r');
>  	if (has_trailing_carriage_return)
>  		len--;
>  
> @@ -655,7 +661,7 @@ static void emit_line_0(struct diff_options *o,
>  	}
>  
>  	if (first)
> -		fputc(first, file);
> +		fputs(first, file);
>  
>  	if (!len)
>  		goto end_of_line;
> @@ -666,7 +672,7 @@ static void emit_line_0(struct diff_options *o,
>  		fputs(set, file);
>  		needs_reset = 1;
>  	}
> -	fwrite(line, len, 1, file);
> +	fwrite(second, len, 1, file);
>  	needs_reset |= len > 0;
>  
>  end_of_line:
> @@ -681,7 +687,7 @@ static void emit_line_0(struct diff_options *o,
>  static void emit_line(struct diff_options *o, const char *set, const char *reset,
>  		      const char *line, int len)
>  {
> -	emit_line_0(o, set, NULL, reset, 0, line, len);
> +	emit_line_0(o, set, NULL, reset, NULL, line, len);
>  }
>  
>  enum diff_symbol {
> @@ -1201,7 +1207,7 @@ static void dim_moved_lines(struct diff_options *o)
>  static void emit_line_ws_markup(struct diff_options *o,
>  				const char *set_sign, const char *set,
>  				const char *reset,
> -				char sign, const char *line, int len,
> +				const char *sign, const char *line, int len,
>  				unsigned ws_rule, int blank_at_eof)
>  {
>  	const char *ws = NULL;
> @@ -1244,7 +1250,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  		context = diff_get_color_opt(o, DIFF_CONTEXT);
>  		reset = diff_get_color_opt(o, DIFF_RESET);
>  		putc('\n', o->file);
> -		emit_line_0(o, context, NULL, reset, '\\',
> +		emit_line_0(o, context, NULL, reset, "\\",
>  			    nneof, strlen(nneof));
>  		break;
>  	case DIFF_SYMBOL_SUBMODULE_HEADER:
> @@ -1282,7 +1288,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			else if (c == '-')
>  				set = diff_get_color_opt(o, DIFF_FILE_OLD);
>  		}
> -		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
> +		emit_line_ws_markup(o, set_sign, set, reset, " ", line, len,
>  				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
>  		break;
>  	case DIFF_SYMBOL_PLUS:
> @@ -1325,7 +1331,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
>  			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
>  		}
> -		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
> +		emit_line_ws_markup(o, set_sign, set, reset, "+", line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>  				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
>  		break;
> @@ -1368,7 +1374,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			else
>  				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
>  		}
> -		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
> +		emit_line_ws_markup(o, set_sign, set, reset, "-", line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
>  		break;
>  	case DIFF_SYMBOL_WORDS_PORCELAIN:
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 
