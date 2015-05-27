From: Jeff King <peff@peff.net>
Subject: Re: Staging commits with visual diff tools?
Date: Wed, 27 May 2015 03:28:26 -0400
Message-ID: <20150527072826.GC6898@peff.net>
References: <alpine.DEB.2.10.1505262147230.3709@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Lee <jjl@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVlW-00030u-OA
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 09:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbbE0H2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 03:28:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:36531 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752434AbbE0H22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 03:28:28 -0400
Received: (qmail 1767 invoked by uid 102); 27 May 2015 07:28:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:28:29 -0500
Received: (qmail 5255 invoked by uid 107); 27 May 2015 07:28:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 03:28:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 03:28:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1505262147230.3709@alice>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270034>

On Tue, May 26, 2015 at 09:50:49PM +0100, John Lee wrote:

> Does anybody have code to stage commits using a the visual diff/merge tools
> supported by git-difftool?  Is there support in git itself somewhere, even?
> 
> I'm looking for something functionally similar to git add -p
> 
> Looking at the git-difftool source I can see how to write a command to do
> it, but wanted to check if it had already been implemented.
> 
> Did I miss a way that already exists?

git-gui has a visual staging tool, and I think some other git interfaces
do, too (e.g., tig). But I don't think there is a way to interact with
an arbitrary 3rd-party diff tool. I would think doing so would depend on
the diff tool itself; what facility does it provide for picking lines
or a hunk out of a diff and communicating it back to git to stage?

If you are interested in looking further, see how the %patch_mode hash
is defined in git-add--interactive.perl. Specifically, note that "add
-p" is just one case: diff against the index and apply with "apply
--cached". But once you have a separate tool for picking hunks, you
should be able to drop in the different DIFF/APPLY pairs to implement
"checkout -p", etc.

-Peff
