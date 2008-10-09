From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: keeping remote branches in sync
Date: Thu, 9 Oct 2008 08:46:37 -0700
Message-ID: <20081009154637.GV8203@spearce.org>
References: <20081009141418.GF18241@morganstanley.com> <eaa105840810090743pba41a98ocdf79b7c06d76e9e@mail.gmail.com> <20081009151636.GT8203@spearce.org> <20081009153738.GJ18241@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Kevin Green <Kevin.T.Green@morganstanley.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 17:50:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knxk9-0000so-VI
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 17:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbYJIPqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 11:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754997AbYJIPqi
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 11:46:38 -0400
Received: from george.spearce.org ([209.20.77.23]:52669 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbYJIPqi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 11:46:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AE96038368; Thu,  9 Oct 2008 15:46:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081009153738.GJ18241@morganstanley.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97862>

Kevin Green <Kevin.T.Green@morganstanley.com> wrote:
> On 10/09/08 11:16:36, Shawn O. Pearce wrote:
> > I keep meaning to add "git remote prune" logic into "git fetch",
> > e.g. as a "git fetch --prune" option.  fetch has all of the data
> > it needs to implement the prune already in memory, it just doesn't
> > have the loop to do the prune cleanup.
> > 
> > Now that "git remote" is in C it should be easy to share the prune
> > code between them, and make this more automatic.
> 
> That would be great...  And a config option to have it done by default each
> time so '$ git-pull' will just do what we want for our origin remote?

Right.  I think most users would want to set that config option.
git-gui has a config option to enable this prune after fetch
behavior, but its basically just calling "git remote prune" when
fetch is done running.

I think can also work around it with an alias:

	git config --alias fp \
	'! git fetch "$0" "$@" && git remote prune "$0"'

Not bullet proof but it should do the prune for you after it does
the fetch, assuming you fetched from an existing remote and not a
random URL.

-- 
Shawn.
