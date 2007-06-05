From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 4/4] Add new --diff-opts/-O flag to diff- and status-related commands.
Date: Tue, 5 Jun 2007 08:47:30 +0200
Message-ID: <20070605064730.GG6962@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth> <20070531223438.6005.76115.stgit@gandelf.nowhere.earth> <b0943d9e0706041515l6114a015ye45d40478cc0e3ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 08:47:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvSpS-0005gk-O6
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 08:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbXFEGrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 02:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760978AbXFEGra
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 02:47:30 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:49008 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457AbXFEGra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 02:47:30 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 017EC5A246;
	Tue,  5 Jun 2007 08:47:29 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 8B2F31F01B; Tue,  5 Jun 2007 08:47:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0706041515l6114a015ye45d40478cc0e3ef@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49165>

On Mon, Jun 04, 2007 at 11:15:23PM +0100, Catalin Marinas wrote:
> On 31/05/07, Yann Dirson <ydirson@altern.org> wrote:
> >This new flag allows to pass arbitrary flags to the git-diff calls
> >underlying several StGIT commands.  It can be used to pass flags
> >affecting both diff- and status-generating commands (eg. -M or -C), or
> >flags only affecting diff-generating ones (eg. --color, --binary).
> >
> >It supercedes --binary for commands where it was allowed,
> >'-O --binary' is now available for the same functionality.
> 
> BTW, should we add --binary by default to export and mail? Do you see
> any problem with this?
> 
> Another idea would be to add support for a [stgit "options"] section
> with entries like "mail = -O --binary".

Right, but we have to think how flags in the config file interact with
flags on command line.

- does the command line shadow the config file completely (ie. "-O ''"
can be used for to not pass any flags), in which case, each time we
want a particular flag we need to pass all default ones again ?

- does the command line add to the flags specified from config file,
in which case we still need a way to override those ; I have 2 ideas
here: a flag that resets opts to '', or a flag to remove specific
flags (eg. if we have '--binary -w' in the config and we want
'--binary -C', we can say something like '-O -C --no-diff-opts -w').


Also useful would be to have different config defaults for the case
where we go through the pager, but then we may have to guess when the
pager will trigger (or maybe we can ask pydoc if the pager will
trigger ?).

Best regards,
-- 
Yann
