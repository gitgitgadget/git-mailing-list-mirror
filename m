From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] config: factor out config file stack management
Date: Tue, 12 Mar 2013 15:04:56 -0400
Message-ID: <20130312190456.GC17099@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165752.GB1136@sandbox-ub.fritz.box>
 <20130312105200.GC11340@sigill.intra.peff.net>
 <20130312154434.GB3021@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 20:05:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFUVs-0006au-94
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 20:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216Ab3CLTFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 15:05:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49985 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932746Ab3CLTE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 15:04:59 -0400
Received: (qmail 28994 invoked by uid 107); 12 Mar 2013 19:06:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 15:06:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 15:04:56 -0400
Content-Disposition: inline
In-Reply-To: <20130312154434.GB3021@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217980>

On Tue, Mar 12, 2013 at 04:44:35PM +0100, Heiko Voigt wrote:

> > Can we throw in a comment at the top here with the expected usage? In
> > particular, do_config_from is expecting the caller to have filled in
> > certain fields (at this point, top->f and top->name), but there is
> > nothing to make that clear.
> 
> Of course. Will do that in the next iteration. How about I squash this in:
> [...]
> +/* The fields data, name and the source specific callbacks of top need
> + * to be initialized before calling this function.
> + */
>  static int do_config_from_source(struct config_source *top, config_fn_t fn, voi

I think that is OK, but it may be even better to list the fields by
name. Also, our multi-line comment style is:

  /*
   * Multi-line comment.
   */


> I would add that to the third patch:
> 
> 	config: make parsing stack struct independent from actual data source
> 
> because that contains the final modification to config_file/config_source.

It does not matter to the end result, but I find it helps with reviewing
when the comment is added along with the function, and then expanded as
the function is changed. It helps to understand the effects of later
patches if they need to tweak comments.

I do not care that much in this instance, since we have already
discussed it, and I know what is going on, though.

-Peff
