From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Documentation: git-svn: fix spurious bolding that
	mangles the output
Date: Wed, 22 Apr 2009 11:15:16 -0400
Message-ID: <20090422151515.GA12370@coredump.intra.peff.net>
References: <1240411907-5002-1-git-send-email-wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 17:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LweC0-00057B-5s
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 17:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbZDVPPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 11:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbZDVPPU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 11:15:20 -0400
Received: from peff.net ([208.65.91.99]:51474 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbZDVPPT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 11:15:19 -0400
Received: (qmail 15987 invoked by uid 107); 22 Apr 2009 15:15:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 11:15:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 11:15:16 -0400
Content-Disposition: inline
In-Reply-To: <1240411907-5002-1-git-send-email-wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117204>

On Wed, Apr 22, 2009 at 08:51:46AM -0600, Wesley J. Landaker wrote:

> Without this fix, the output looks like:
> 
> "Keep in mind that the  (asterisk) wildcard of the local ref (right of
> the :) *must be the ..." -- with half the sentence spuriously bold.
> 
> This is probably working around an asciidoc bug, but it's better to fix
> this than to leave the documentation in an unreadable state.

I think it's a documentation bug; the asterisk is a special character,
so it is seeing the first one as the start of bold, instead of the one
on the left side of *must*.

>  Keep in mind that the '*' (asterisk) wildcard of the local ref
> -(right of the ':') *must* be the farthest right path component;
> +(right of the ':') must be the farthest right path component;

So the right fix is probably to quote the asterisk that is not part of
the bolding, like:

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 9229d45..3e22e40 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -693,7 +693,7 @@ listed below are allowed:
 	tags = tags/*/project-a:refs/remotes/project-a/tags/*
 ------------------------------------------------------------------------
 
-Keep in mind that the '*' (asterisk) wildcard of the local ref
+Keep in mind that the '\*' (asterisk) wildcard of the local ref
 (right of the ':') *must* be the farthest right path component;
 however the remote wildcard may be anywhere as long as it's own
 independent path component (surrounded by '/' or EOL).   This
