From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 6/7] Register a callback for graph output.
Date: Mon, 17 May 2010 08:57:47 +0200
Message-ID: <201005170857.47545.trast@student.ethz.ch>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com> <1273921331-32702-6-git-send-email-struggleyb.nku@gmail.com> <1273921331-32702-7-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 08:58:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODuGy-0006UO-4t
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 08:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab0EQG5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 02:57:50 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:42263 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250Ab0EQG5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 02:57:50 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 08:57:49 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 08:57:48 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <1273921331-32702-7-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147212>

Bo Yang wrote:
> +static struct strbuf *diff_output_prefix_callback(FILE *file, int print, void *data)
> +{
> +	struct git_graph *graph = data;
> +	static struct strbuf msgbuf = STRBUF_INIT;
> +
> +	assert(graph);
> +
> +	strbuf_reset(&msgbuf);
> +	graph_padding_line(graph, &msgbuf);
> +	if (print) {
> +		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
> +	}
> +	return &msgbuf;
> +}
> +

Ok, this partially answers my last mail and means that a simple string
would be too tedious, so a callback is needed.

It leaks the 'msgbuf' in the 'printing' case though.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
