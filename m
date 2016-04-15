From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" v2 1/2] xdiff: add
 recs_match helper function
Date: Fri, 15 Apr 2016 18:46:15 -0400
Message-ID: <20160415224615.GA32306@sigill.intra.peff.net>
References: <20160415215622.6040-1-jacob.e.keller@intel.com>
 <20160415215622.6040-2-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:46:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCVX-0006Mf-Nu
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbcDOWqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:46:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:50526 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752573AbcDOWqS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:46:18 -0400
Received: (qmail 15253 invoked by uid 102); 15 Apr 2016 22:46:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 18:46:17 -0400
Received: (qmail 16363 invoked by uid 107); 15 Apr 2016 22:46:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 18:46:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2016 18:46:15 -0400
Content-Disposition: inline
In-Reply-To: <20160415215622.6040-2-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291686>

On Fri, Apr 15, 2016 at 02:56:21PM -0700, Jacob Keller wrote:

> @@ -470,8 +477,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  			 * the line next of the current change group, shift forward
>  			 * the group.
>  			 */
> -			while (ix < nrec && recs[ixs]->ha == recs[ix]->ha &&
> -			       xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size, recs[ix]->ptr, recs[ix]->size, flags)) {
> +			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
> +				emptylines += is_emptyline(recs[ix]->ptr);
> +

I have not looked closely at your patches yet, but is this hunk right?
The is_emptyline stuff doesn't come in until patch 2.

-Peff
