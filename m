From: Max Kirillov <max@max630.net>
Subject: Re: A failing attempt to use Git in a centralized environment
Date: Fri, 2 May 2014 23:56:48 +0300
Message-ID: <20140502205648.GA5188@wheezy.local>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri May 02 22:57:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKW3-0000q8-EN
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbaEBU5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:57:03 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:32828
	"EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752193AbaEBU5C (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 16:57:02 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa12-03.prod.phx3.secureserver.net with 
	id x8wm1n00X3gsSd6018wsLr; Fri, 02 May 2014 13:57:00 -0700
Content-Disposition: inline
In-Reply-To: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247979>

Hi.

> Problem #6: push - reject - pull - push sequence sometimes transforms
> into a loop with several iterations and doesn't add happiness.

As far as I undestand, this is the most annoying thing. In
git (like other distributed systems), you cannot push your
changes unless you merge them with a very last version of
the whole repository.

I think the only good way to use git in a team with more
than a very few persons is to switch to pull-request based
workflow, which does not require users to update to push
their changes. Then their changes are merged to master
either by a human integrator or by a tool (gitorious,
github, stash, gerrit etc.).

I think it can be even as little as 'update' hook, thich is
triggered when user pushes to branch like 'inbox/bob' and
tries to merge the branch to master. The only issue I can
see with it is that does not provide a way to specify
meaningful merge message.

Btw, then the problem#2 is not a problem, because the merge
done by user does not yet produce the commit to be added to
master, but just prepares more recent version - to resolves
conflicts or check how the changes work against newer
codebase. One more merge is still performed by the server,
and parent order is correct:

master =====+===+======2
             \   \    /
your copy     +===1==+

-- 
Max
