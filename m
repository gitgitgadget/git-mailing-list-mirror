From: Jeff King <peff@peff.net>
Subject: [nit] diff func headers ignore context
Date: Tue, 13 Sep 2011 18:04:21 -0400
Message-ID: <20110913220421.GA24549@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
 <20110913215824.GG24490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 00:04:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3b5g-00047F-MI
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 00:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923Ab1IMWEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 18:04:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38474
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834Ab1IMWEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 18:04:23 -0400
Received: (qmail 2211 invoked by uid 107); 13 Sep 2011 22:05:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 18:05:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 18:04:21 -0400
Content-Disposition: inline
In-Reply-To: <20110913215824.GG24490@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181315>

On Tue, Sep 13, 2011 at 05:58:25PM -0400, Jeff King wrote:

> @@ -609,26 +610,23 @@ int finish_async(struct async *async)
>  int run_hook(const char *index_file, const char *name, ...)
>  {
>  	struct child_process hook;
> -	const char **argv = NULL, *env[2];
> +	struct argv_array argv = ARGV_ARRAY_INIT;

I find this diff function header pretty confusing. Of course we're not
in finish_async, as you can see by the fact that the context contains
the start of run_hook.

I don't think this is something that can be solved with xfuncname
config; we would have to teach xdiff to look at context lines when
picking a header line.

Am I the only one who finds this confusing? Can anyone think of a reason
to keep showing finish_async in this example?

-Peff
