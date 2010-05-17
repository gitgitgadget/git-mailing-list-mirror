From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 7/7] Make --color-words work well with --graph.
Date: Mon, 17 May 2010 08:59:27 +0200
Message-ID: <201005170859.28022.trast@student.ethz.ch>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com> <1273921331-32702-7-git-send-email-struggleyb.nku@gmail.com> <1273921331-32702-8-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 08:59:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODuIb-0006tw-AF
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 08:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab0EQG7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 02:59:32 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:59021 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab0EQG7c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 02:59:32 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 08:59:32 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 08:59:28 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <1273921331-32702-8-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147213>

Bo Yang wrote:
> @@ -629,20 +640,39 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
>  	} else
>  		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
>  
> -	if (diff_words->current_plus != plus_begin)
> -		fwrite(diff_words->current_plus,
> -				plus_begin - diff_words->current_plus, 1,
> -				diff_words->file);
> -	if (minus_begin != minus_end)
> -		color_fwrite_lines(diff_words->file,
> +	if (diff_words->current_plus != plus_begin) {
> +		if ((diff_words->current_plus == diff_words->plus.text.ptr &&
> +			diff_words->last_minus == 0) ||
> +			(diff_words->current_plus > diff_words->plus.text.ptr &&
> +			*(diff_words->current_plus - 1) == '\n')) {
> +			fputs(line_prefix, diff_words->opt->file);
> +			print = 1;

Are these border checks needed/the best solution?  If so, please can
you put an explanation in the commit message?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
