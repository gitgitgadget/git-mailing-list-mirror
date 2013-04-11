From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9903: Don't fail when run from path accessed through
 symlink
Date: Thu, 11 Apr 2013 15:17:49 -0400
Message-ID: <20130411191749.GD3177@sigill.intra.peff.net>
References: <20130411185322.GF14619@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 21:18:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQN0d-0004so-J8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 21:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab3DKTR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 15:17:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40842 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab3DKTR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 15:17:57 -0400
Received: (qmail 18433 invoked by uid 107); 11 Apr 2013 19:19:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 15:19:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 15:17:49 -0400
Content-Disposition: inline
In-Reply-To: <20130411185322.GF14619@pvv.ntnu.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220918>

On Thu, Apr 11, 2013 at 08:53:22PM +0200, Torstein Hegge wrote:

> When the git directory is accessed through a symlink like
> 
>   ln -s /tmp/git /tmp/git-symlink
>   cd /tmp/git-symlink/t
>   make -C .. && ./t9903-bash-prompt.sh
> 
> $TRASH_DIRECTORY is /tmp/git-symlink/t/trash directory.t9903-bash-prompt
> and $(pwd -P) is /tmp/git/t/trash directory.t9903-bash-prompt.
> 
> When __gitdir looks up the path through 'git rev-parse --git-dir', it
> will return paths similar to $(pwd -P). This behavior is already tested in
> t9903 'gitdir - resulting path avoids symlinks'.

Thanks, this makes sense to me, and is the same solution used in other
scripts (e.g., t2300), so I don't think we have to worry about any
portability concerns with "pwd -P".

-Peff
