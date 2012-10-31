From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse_dirstat_params(): use string_list to split
 comma-separated string
Date: Wed, 31 Oct 2012 10:06:36 -0400
Message-ID: <20121031140636.GA24291@sigill.intra.peff.net>
References: <1351443054-10472-1-git-send-email-mhagger@alum.mit.edu>
 <loom.20121030T193428-242@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:06:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTYwW-0003fA-Tn
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 15:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933314Ab2JaOGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 10:06:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45131 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933299Ab2JaOGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 10:06:40 -0400
Received: (qmail 14498 invoked by uid 107); 31 Oct 2012 14:07:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Oct 2012 10:07:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2012 10:06:36 -0400
Content-Disposition: inline
In-Reply-To: <loom.20121030T193428-242@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208820>

On Tue, Oct 30, 2012 at 06:43:51PM +0000, Matt Kraai wrote:

> Michael Haggerty <mhagger <at> alum.mit.edu> writes:
> ...
> > -static int parse_dirstat_params(struct diff_options *options, const char ...
> > +static int parse_dirstat_params(struct diff_options *options, const char ...
> >  				struct strbuf *errmsg)
> >  {
> > -	const char *p = params;
> > -	int p_len, ret = 0;
> > +	char *params_copy = xstrdup(params_string);
> > +	struct string_list params = STRING_LIST_INIT_NODUP;
> > +	int ret = 0;
> > +	int i;
> > 
> > -	while (*p) {
> > -		p_len = strchrnul(p, ',') - p;
> > -		if (!memcmp(p, "changes", p_len)) {
> > +	if (*params_copy)
> 
> params_copy is set to the value returned by xstrdup, which cannot be NULL.
> This check can be removed and if params_string can be NULL, it should be
> checked before being passed to xstrdup.

If you are referring to the last line, isn't it checking whether the
string is empty, not NULL?

-Peff
