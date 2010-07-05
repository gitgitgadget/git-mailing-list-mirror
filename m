From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: help moving boost.org to git
Date: Tue, 6 Jul 2010 00:04:43 +0200
Message-ID: <20100705220443.GA23727@pvv.org>
References: <4C31E944.30801@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Niebler <eric@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 00:04:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVtmU-0006D4-Lr
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 00:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab0GEWEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 18:04:46 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:48344 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab0GEWEp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 18:04:45 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OVtmN-0001f0-GF; Tue, 06 Jul 2010 00:04:43 +0200
Content-Disposition: inline
In-Reply-To: <4C31E944.30801@boostpro.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150299>

On Mon, Jul 05, 2010 at 10:16:36AM -0400, Eric Niebler wrote:
> I have a question about the best approach to take for refactoring a
> large svn project into git. The project, boost.org, is a collection of
> C++ libraries (>100) that are mostly independent. (There may be
> cross-library dependencies, but we plan to handle that at a higher
> level.) After the move to git, we'd like each library to be in its own
> git repository. Boost can then be a stitching-together of these, using
> submodules or something (opinions welcome). It's an old project with
> lots of history that we don't want to lose. The naive approach of simply
> forking into N repositories for the N libraries and deleting the
> unwanted files in each is unworkable because we'll end up with all the
> history duplicated everywhere ... >100 repositories, each larger than 100Mb.

If the libraries are not independent (i.e. some commits are across
multiple libraries), submodules will give you some interesting
challenges to put it mildly.

The current boost 1.43 is 29344 files, is this all there is? This
should fit eaily into a single repository. The Linux kernel is much
larger, and that is sort of the canonical single repo git project. I
_strongly_ recommend that you go for a single repo if you can make it
work.

If you manage to create a single git repo with the history you want,
it is trivial to split out separate repositories of subdirectories
later (and those repos will then be comparatively small). git subtree
allegedly automates this process more or less (I have not used it, but
have heard good things about it). What about having a single "master
repository", and then using subtree to create single-library repos for
the library developers if they want a smaller repo to play around in?

> So,, what are the options? Can I somehow delete from each repository the
> history that is irrelevant? Is these some feature of git I don't know
> about that can solve this problem for us?

How do you define "irrelevant"? Do you only require enough history for
git annotate/blame to give correct results?  Or does this only refer
to multiple repositories sharing the same ancient history?

> At boost, We've already discussed a few possible approaches. Feel free
> to comment and/or criticize any of the solutions suggested here:
> 
>   http://github.com/ryppl/ryppl/issues#issue/4

It is unclear from the discussion if you will change to git, or use
git in addition to svn? This will have some impact on how to go about
this.

- Finn Arne
