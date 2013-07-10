From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-http: use argv-array
Date: Tue, 9 Jul 2013 20:16:59 -0400
Message-ID: <20130710001659.GA11643@sigill.intra.peff.net>
References: <7vfvvoxqdw.fsf@alter.siamese.dyndns.org>
 <CAKPyHN0DG0c2vxWtybYtDmFKMo369PZcbqCfDJaXeiRV+PP8pQ@mail.gmail.com>
 <20130709063840.GA8015@sigill.intra.peff.net>
 <loom.20130710T002441-147@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Jul 10 02:17:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwi5m-00043y-4b
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 02:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab3GJARF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 20:17:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:43244 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753869Ab3GJARE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 20:17:04 -0400
Received: (qmail 25641 invoked by uid 102); 10 Jul 2013 00:18:19 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 19:18:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 20:16:59 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130710T002441-147@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230016>

On Tue, Jul 09, 2013 at 10:27:29PM +0000, Matt Kraai wrote:

> > Nice catch. We cannot use variadic macros, because we support pre-C99
> > compilers that do not have them. But the sentinel attribute is a good
> > idea. Here's a patch.
> 
> This attribute could also be used for
> builtin/revert.c:verify_opt_compatible,
> builtin/revert.c:verify_opt_mutually_compatible, exec_cmd.h:execl_git_cmd,
> and run-command.h:run_hook.

Thanks. I did a full grep of '\.\.\.' on the source, and found that we
have missed some cases for the "format" attribute, too.

This series fixes all of them in the main code base (not compat/ or
contrib/). But see the comments in patch 3, as I'm not sure that case is
worth doing.

  [1/3]: add missing "format" function attributes
  [2/3]: use "sentinel" function attribute for variadic lists
  [3/3]: wt-status: use "format" function attribute for status_printf

-Peff
