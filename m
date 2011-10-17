From: Jeff King <peff@peff.net>
Subject: Re: regression in git-gui since 2c5c66b... Merge branch
 'jp/get-ref-dir-unsorted
Date: Mon, 17 Oct 2011 09:55:01 -0400
Message-ID: <20111017135501.GA4171@sigill.intra.peff.net>
References: <4E9B1E32.7030101@gmail.com>
 <7vfwispi8u.fsf@alter.siamese.dyndns.org>
 <4E9B8719.1090203@gmail.com>
 <4E9BA39B.709@alum.mit.edu>
 <4E9BFE66.5070906@gmail.com>
 <4E9C2F3C.7080405@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 17 15:55:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFnes-000773-9o
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 15:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756Ab1JQNzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 09:55:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33853
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203Ab1JQNzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 09:55:05 -0400
Received: (qmail 6853 invoked by uid 107); 17 Oct 2011 13:55:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Oct 2011 09:55:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Oct 2011 09:55:01 -0400
Content-Disposition: inline
In-Reply-To: <4E9C2F3C.7080405@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183793>

On Mon, Oct 17, 2011 at 03:35:56PM +0200, Michael Haggerty wrote:

> On 10/17/2011 12:07 PM, Mark Levedahl wrote:
> > Your modification of my script does not show the error for me, unless I
> > have *installed* a version of git with the failure: I suspect git-gui
> > invokes installed components, and not what is in the build directory, so
> > having a good version of git installed with the bad version in the build
> > directory does not show the error. And yes, I am quite sure that all of
> > the git commands I am running are from the one version.
> 
> Yes, you seem to be right.  Even if I set PATH to list my git build
> directory before the directory where it is installed, "git-gui"
> sometimes invokes git-rev-parse from the libexec path of the installed
> version.

If you are testing directly out of the build directory, you need to set
GIT_EXEC_PATH, too. The bin-wrappers/git script will do this for you
(and is what the test scripts use).

But note that there's a catch with git-gui, as its built version doesn't
live in the top-level. So running:

  bin-wrappers/git gui

will try to exec the git-gui directory. You can work around it with:

  bin-wrappers/git gui/git-gui

-Peff
