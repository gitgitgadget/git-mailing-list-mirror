From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Thu, 12 Jul 2012 16:33:39 -0400
Message-ID: <20120712203339.GB13544@sigill.intra.peff.net>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
 <7vhatcc1ql.fsf@alter.siamese.dyndns.org>
 <4FFF1821.7030705@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 22:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpQ58-0000jQ-DE
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 22:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758533Ab2GLUdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 16:33:43 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:58176
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756001Ab2GLUdl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 16:33:41 -0400
Received: (qmail 24741 invoked by uid 107); 12 Jul 2012 20:33:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jul 2012 16:33:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 16:33:39 -0400
Content-Disposition: inline
In-Reply-To: <4FFF1821.7030705@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201379>

On Thu, Jul 12, 2012 at 02:32:01PM -0400, Paul Gortmaker wrote:

> In case it helps any, a brief summary of my workflow is this:
> 
> git am /tmp/mbox
> <some random fail halfway in the queue>
> patch -p1 --dry-run < .git/rebase-apply/patch
> # gauge status.  Is patch really invalid, or already applied?
> # already applied; "git am --skip"
> # no, if valid, but with minor issues, apply what we can.
> patch -p1 < .git/rebase-apply/patch
> # manually deal with rejects (typically with wiggle)
> git add any_new_files
> git add -u
> git am -r

This does not in any way address your patch, but you may find it
helpful. My usual next step after "git am" fails is to run "git am -3"
and have it do a 3-way merge. This can sometimes resolve issues
entirely, and when conflicts remain, they are placed in the file with
the usual conflict markers (and the conflicted files are marked in the
index, so you can even use "git mergetool" to help you run an external
tool like xxdiff).

-Peff
