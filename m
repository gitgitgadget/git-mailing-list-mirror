Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500C81F404
	for <e@80x24.org>; Mon, 13 Aug 2018 12:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeHMPE0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 11:04:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:44697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbeHMPE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 11:04:26 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGjL7-1fbfBq0mYr-00DWuT; Mon, 13
 Aug 2018 14:22:19 +0200
Date:   Mon, 13 Aug 2018 14:22:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 6/8] diff: use emit_line_0 once per line
In-Reply-To: <20180810223441.30428-7-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131418060.71@tvgsbejvaqbjf.bet>
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-7-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:naXDPPTbemeMzySTyUod3bG7lF8giz8DWJeXAS2D219XwCbaE5v
 /yV50uzetc/kg8+bC2xtzqmVs2OWBySBL9wmge9UmXLRalXSrII/9nNQZnlWj1uVP7qjqFw
 qT0MH3C7Uef/D/MfQHwdeha59ycw5D2dsc+Xp/VJbC5rzQwhjNS+mtOrG+oJkY50DL2ov6B
 QPoRIEvYxEcAStWf84Vig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y7FdGc3SC7o=:C4R0rmDDGvu0UvUbUtpu4W
 JX5AVeAW1usRv+Wk0OuD3Z4Dbsor9gtRWpquZdFs1TmTZNMDYEixf7RIwrzuhLe1NogKXMBIy
 h6nMNj4WFwbZSUdsh5uB5jlI+Qc0fKDHHEB/tI5eDISgoqjEVr2M9i3WB03fZPdnIBd4ROvQr
 MOAogt5lXc2oQ+CS0O/n2cfaIcNz+wD++Pn9uKZv/fAszs9lll5EBQ1B1EmrM5Ys1aD3IjMu8
 QgMFeJGUkeFN5wNW7p9zjTalyxCp71QPtC+phhSe1F7E/XnfRLVONxhuAY4oucqmoxCDYpdRE
 F36x0Yi6lGLahVBYoW4J3U/TVDcjoP+fo3uoS4x8vukNHBDPeSIuhQs/htS8k9Czyjj5PGzr1
 enodOgqcBL37ZB0wtt09wbBxOokInMMf2ogi2Uof4+YsMX8aBMduXyu3BXI7k20pFgq7tO8rO
 YZ7R7Pgiw/RGlfBsxj4MjkxCi7PIQLPprsgFvPINyMni+Isl4ke6ejIrWVbmh9YV/d3Bv06ND
 Zq9OWYxkqusp8qu9ICVb3sZ5rA9eRkXZ+iRGZHwnFBqkLNJ7xN3p04IZdHfBeTq/2OmV5rd4/
 9nsYDy1QvYulMYI08eMXlX2guXQ24VHWz2HNShDp/NvhA/ZPUua/Cj1IO5nZ5azGxsK1BVDdc
 OYN+0vYaHL5SPPiI7OtnJFwcUhJu1INMEpoGwSPD4g7uVgeJcqHIbP3mmi4/LxNVCe42x2P85
 uulcCglxvl2ohOryhSeoOo3Qd/NdYh/RHbvBFR1ChUwHqb7Rci5HF071UxsNUE1YTJwFyaXuM
 gc79R1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> All lines that use emit_line_0 multiple times per line, are combined
> into a single call to emit_line_0, making use of the 'set' argument.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 5eea5edca50..01095a59d3d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -629,10 +629,7 @@ static void emit_line_0(struct diff_options *o,
>  	int nofirst;
>  	FILE *file = o->file;
>  
> -	if (first)
> -		fputs(diff_line_prefix(o), file);
> -	else if (!len)
> -		return;
> +	fputs(diff_line_prefix(o), file);

How about separating this into its own "now that `first` is no longer
`NULL`, skip this" patch?

I found it a bit hard to review this diff, primarily because this hunk
would logically make more sense after the other hunks.


>  	if (len == 0) {
>  		has_trailing_newline = (first == '\n');
> @@ -652,13 +649,17 @@ static void emit_line_0(struct diff_options *o,
>  	if (len || !nofirst) {
>  		if (reverse && want_color(o->use_color))
>  			fputs(GIT_COLOR_REVERSE, file);
> -		if (set_sign && set_sign[0])
> -			fputs(set_sign, file);
> +		if (set_sign || set)
> +			fputs(set_sign ? set_sign : set, file);

Wait, what? Why is `set` all of a sudden also applying to `first`?

I would have expected `set_sign` to apply to `first`, and `set` to the
rest of the line.

>  		if (first && !nofirst)
>  			fputc(first, file);
> -		if (set)
> -			fputs(set, file);
> -		fwrite(line, len, 1, file);
> +		if (len) {
> +			if (set_sign && set && set != set_sign)
> +				fputs(reset, file);
> +			if (set)
> +				fputs(set, file);

That sounds as if `set == set_sign` would duplicate the `set`. How about
this instead?

			if (set && set != set_sign) {
				if (set_sign)
					fputs(reset, file);
				fputs(set, file);
			}

The rest looks good to me.

Thank you,
Dscho

> +			fwrite(line, len, 1, file);
> +		}
>  		fputs(reset, file);
>  	}
>  	if (has_trailing_carriage_return)
> @@ -1204,16 +1205,13 @@ static void emit_line_ws_markup(struct diff_options *o,
>  	if (!ws && !set_sign)
>  		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
>  	else if (!ws) {
> -		/* Emit just the prefix, then the rest. */
> -		emit_line_0(o, set_sign, NULL, !!set_sign, reset, sign, "", 0);
> -		emit_line_0(o, set, NULL, 0, reset, 0, line, len);
> +		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
>  	} else if (blank_at_eof)
>  		/* Blank line at EOF - paint '+' as well */
>  		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
>  	else {
>  		/* Emit just the prefix, then the rest. */
> -		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
> -			    sign, "", 0);
> +		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, "", 0);
>  		ws_check_emit(line, len, ws_rule,
>  			      o->file, set, reset, ws);
>  	}
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 
