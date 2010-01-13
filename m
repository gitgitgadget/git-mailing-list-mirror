From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] strbuf: add strbuf_percentquote_buf
Date: Wed, 13 Jan 2010 14:56:35 -0500
Message-ID: <20100113195635.GA25265@coredump.intra.peff.net>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154153.GB24957@coredump.intra.peff.net>
 <7viqb6trwu.fsf@alter.siamese.dyndns.org>
 <20100113170636.GA21318@coredump.intra.peff.net>
 <7vwrzln5x5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:56:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9Km-0006Wa-EO
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab0AMT4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968Ab0AMT4r
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:56:47 -0500
Received: from peff.net ([208.65.91.99]:51454 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159Ab0AMT4q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:56:46 -0500
Received: (qmail 26334 invoked by uid 107); 13 Jan 2010 20:01:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 15:01:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 14:56:35 -0500
Content-Disposition: inline
In-Reply-To: <7vwrzln5x5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136868>

On Wed, Jan 13, 2010 at 11:47:18AM -0800, Junio C Hamano wrote:

> As I said, I don't think appending p-quoted version of itself to a string
> makes much sense, but I don't think in-place is too difficult.
> 
> 	strbuf_addbuf_pquote(*dst, *src)
>         {
> 		int len = src->len, i;
> 		for (i = 0; i < len; i++) {
> 			if (src->buf[i] == '%')
>                         	strbuf_addch(dst, '%');
> 			strbuf_addch(dst, src->buf[i]);

Oops, of course. I was still thinking of actually doing a single
in-place conversion, not appending in-place. Of course yours is right.
Can you mark up my patch instead of using the assert?

-Peff
