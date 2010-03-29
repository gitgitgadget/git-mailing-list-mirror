From: Eric Raymond <esr@thyrsus.com>
Subject: Re: Three issues from a Subversion-to-git migration
Date: Mon, 29 Mar 2010 14:01:58 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100329180158.GB12922@thyrsus.com>
References: <20100326120906.F03BB20CD21@snark.thyrsus.com>
 <201003291100.13043.trast@student.ethz.ch>
 <20100329091056.GC10538@thyrsus.com>
 <4BB0CDEC.8000708@gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 20:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwJHr-00060Q-MF
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 20:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab0C2SB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 14:01:59 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:55906
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030Ab0C2SB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 14:01:59 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 4B03D20CBA3; Mon, 29 Mar 2010 14:01:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4BB0CDEC.8000708@gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143504>

Gabriel Filion <lelutin@gmail.com>:
> > 1. Turn unmodified tag directories into git tags
> > 2. Turn odified tags into branches.
> > 3. Recognize when a formerly unmodified tag has been modified, remove
> >    the git tag, and turn it into a branch.
> 
> The 3rd point seems a bit weird to me.. users don't expect tags to
> disappear magically. Especially if it's done during a fetch while working.

A reasonable objection.
 
> Here's how I would change the scenario:
> 
> 1. For each creation of a sub-directory in SVN's tag directory, create a
> git tag on the revision that was referenced by the directory copy in SVN.
> 2. If (and only if) there are later modifications in the tag directory,
> create a branch starting from that tag.
> 
> This way, the tag would be there but a branch would hold modifications
> based on code at this point, if there is any.

That would work for me.
 
> The problem with my scenario, though is that it doesn't take care of tag
> creation + modification in the same commit (yuukkkk, but it's possible
> that it exists somewhere). If it could be possible to verify if
> modifications were made during the tag creation, then we could make the
> case hit both points.

Doesn't seem like that should be difficult.

> The other big "thing" is that it expects a certain correct separation
> into different directories (e.g. trunk/ tags/ branches/ ), which SVN
> doesn't enforce.

Are you suggesting that branch directory copies should be handled with
the same rule? I think I could live with that.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
