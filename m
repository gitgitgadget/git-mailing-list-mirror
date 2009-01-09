From: Jeff King <peff@peff.net>
Subject: Re: Funny: git -p submodule summary
Date: Fri, 9 Jan 2009 05:13:35 -0500
Message-ID: <20090109101335.GA4346@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090109083836.GB21389@coredump.intra.peff.net> <20090109092250.GA1809@coredump.intra.peff.net> <49672244.80200@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 11:15:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLEOM-0000e6-LX
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 11:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbZAIKNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 05:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbZAIKNi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 05:13:38 -0500
Received: from peff.net ([208.65.91.99]:54991 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423AbZAIKNh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 05:13:37 -0500
Received: (qmail 17905 invoked by uid 107); 9 Jan 2009 10:14:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 05:14:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 05:13:35 -0500
Content-Disposition: inline
In-Reply-To: <49672244.80200@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104998>

On Fri, Jan 09, 2009 at 11:09:08AM +0100, Johannes Sixt wrote:

> > Below is a patch that uses the three-process mechanism, and it fixes the
> > problem. _But_ it is not satisfactory for inclusion, because it won't
> > work on MINGW32. Since it is actually splitting git into two processes
> > (one to monitor the pager and one to actually run git), it uses fork.
> 
> We have start_async()/finish_async() to replace a fork() of the sort that
> we have here.

It looks like start_async is implemented using threads on Windows. Will
that survive an execvp call? Because we don't know at this point whether
we are going to actually run builtin code, or if we will exec an
external.

-Peff
