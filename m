From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] run_hook: use argv_array API
Date: Wed, 14 Sep 2011 14:56:58 -0400
Message-ID: <20110914185658.GA21352@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
 <20110913215824.GG24490@sigill.intra.peff.net>
 <7vty8ft0oc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:57:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3udu-0001pn-LL
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466Ab1INS5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:57:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49840
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932269Ab1INS5A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:57:00 -0400
Received: (qmail 13307 invoked by uid 107); 14 Sep 2011 18:57:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 14:57:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 14:56:58 -0400
Content-Disposition: inline
In-Reply-To: <7vty8ft0oc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181384>

On Wed, Sep 14, 2011 at 11:54:11AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -609,26 +610,23 @@ int finish_async(struct async *async)
> >  int run_hook(const char *index_file, const char *name, ...)
> >  {
> >  	struct child_process hook;
> > -	const char **argv = NULL, *env[2];
> > +	struct argv_array argv = ARGV_ARRAY_INIT;
> > +	const char *p, *env[2];
> 
> Given that in argv-array.h you define it as
> 
>     #define ARGV_ARRAY_INIT { empty_argv, 0, 0 };
> 
> the above will introduce decl-after-stmt.

Oops. Can you squash in removing the semicolon from the macro
definition?

-Peff
