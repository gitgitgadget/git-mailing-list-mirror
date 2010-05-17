From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 4/7] diff.c: Output the text graph padding before each diff line.
Date: Mon, 17 May 2010 08:52:31 +0200
Message-ID: <201005170852.31546.trast@student.ethz.ch>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com> <1273921331-32702-4-git-send-email-struggleyb.nku@gmail.com> <1273921331-32702-5-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 08:53:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODuCD-0004vR-Hw
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 08:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab0EQGw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 02:52:56 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:58872 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163Ab0EQGwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 02:52:55 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 08:52:56 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 08:52:33 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <1273921331-32702-5-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147210>

Bo Yang wrote:
> diff --git a/diff.c b/diff.c
> index 9bd9063..4a10d16 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -487,6 +487,13 @@ static void emit_rewrite_diff(const char *name_a,
>  	char *data_one, *data_two;
>  	size_t size_one, size_two;
>  	struct emit_callback ecbdata;
> +	char *line_prefix = "";
> +	struct strbuf *msgbuf;
> +
> +	if (o && o->output_prefix) {
> +		msgbuf = o->output_prefix(o->file, 0, o->output_prefix_data);
> +		line_prefix = msgbuf->buf;
> +	}

Umm.  This snippet of code means that the callback can't to much
except return or print a string depending on the value of the second
argument, doesn't it?

So why not either make it explicit and just put a char* field there,
or make a more generic callback that replaces write() (or so) and
gets a chance to mangle the output in any way it likes?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
