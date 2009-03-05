From: Jeff King <peff@peff.net>
Subject: Re: bug in checkout/status ?
Date: Thu, 5 Mar 2009 16:07:57 -0500
Message-ID: <20090305210757.GA20157@coredump.intra.peff.net>
References: <20090305204801.GA16213@spearce.org> <20090305205126.GA19800@coredump.intra.peff.net> <20090305205313.GB16213@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 22:09:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKow-000755-Tp
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 22:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbZCEVIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 16:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbZCEVIF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 16:08:05 -0500
Received: from peff.net ([208.65.91.99]:36823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbZCEVIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 16:08:04 -0500
Received: (qmail 3264 invoked by uid 107); 5 Mar 2009 21:08:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 16:08:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 16:07:57 -0500
Content-Disposition: inline
In-Reply-To: <20090305205313.GB16213@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112345>

On Thu, Mar 05, 2009 at 12:53:13PM -0800, Shawn O. Pearce wrote:

> > Hmm. I get the same behavior here. I notice there is a "libelf" subtree
> > before "libelf-po"; maybe it's a sorting bug? I'll try to investigate
> > more.
> 
> Yup, that must be it.
> 
> JGit created the resulting tree during a merge.
> 
> It sorted "libelf/" before "libelf-po/".  Wrong.  Bad JGit.  Bad!

OK. I was just sort of guessing based on the similarity of the names and
the fact that sorting is confusing (as evidenced by the fact that I had
no idea if it was wrong or not). But that is definitely it:

  $ git clone git://android.git.kernel.org/platform/external/elfutils std_git
  $ cd std_git
  $ git ls-tree HEAD >jgit
  $ git commit -a -m 'git tree'
  $ git ls-tree HEAD >git
  $ diff -u jgit git

reveal(ed) the difference. But it looks like you have already re-pushed
a fixed version.

-Peff
