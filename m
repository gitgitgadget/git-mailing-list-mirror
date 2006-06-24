From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] git-commit: filter out log message lines only when editor was run.
Date: Sat, 24 Jun 2006 11:42:18 +0200
Message-ID: <20060624094217.GB7851@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 19:58:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuCOc-0005Kj-8e
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWFXR6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWFXR6K
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:58:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37793 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750994AbWFXR6K (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 13:58:10 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9F26B9A492;
	Sat, 24 Jun 2006 19:58:08 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fu4eg-0003jd-Gk; Sat, 24 Jun 2006 11:42:18 +0200
To: junkio@cox.net, mcostalba@gmail.com
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22535>

Junio wrote:
> I agree with this in principle but we would need to make sure
> that our own scripts do not expect that the message is cleaned
> up when feeding a commit log message via stdin, -m or -F, and if
> they do fix them before applying this patch.

The only tools in git.git I could identify as using git-commit rather
than commit-tree are:

git-revert.sh: OK
git-rebase.sh: only uses -C

cogito, stgit, and pg also use commit-tree.  Only qgit seems to be
using git-commit, and probably makes use of this (mis)feature.

I guess the easiest way to get the 1.4.0 behaviour is to change
git-commit calls to "git-commit -e" with EDITOR=true in the
environment.  I'm not sure it would be worth adding a new flag to
switch on/off log stripping.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
