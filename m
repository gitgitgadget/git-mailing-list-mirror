From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH RFC] git describe without refs distinguishes dirty
	working tree
Date: Fri, 16 Oct 2009 15:37:42 -0700
Message-ID: <20091016223742.GV10505@spearce.org>
References: <dffdbd190910160812h6d6a876el8261a622b5439b30@mail.gmail.com> <20091016173902.GT10505@spearce.org> <7veip3t6rm.fsf@alter.siamese.dyndns.org> <dffdbd190910161452o4ac0b426i7c48649eafa0d53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jean Privat <jean@pryen.org>
X-From: git-owner@vger.kernel.org Sat Oct 17 00:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyvQj-00064p-H5
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 00:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbZJPWhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 18:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbZJPWhi
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 18:37:38 -0400
Received: from george.spearce.org ([209.20.77.23]:37472 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZJPWhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 18:37:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 62E94381FE; Fri, 16 Oct 2009 22:37:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <dffdbd190910161452o4ac0b426i7c48649eafa0d53@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130532>

Jean Privat <jean@pryen.org> wrote:
> > I still haven't heard anything that helps me to decide which way the
> > default should be.  The only concrete thing I have heard against the
> > change of the default is that it will break existing setup, but I haven't
> > heard anything concrete for the change yet.
...
> Then, I realized that for some other git commands that can work both
> on the working tree and on an arbitrary commit reference, the default
> was to work on the working tree and require an explicit HEAD to work
> on the HEAD commit. Thus it makes sense to me that "git describe"
> alone should describe the working tree and that "git describe HEAD"
> should describe the HEAD commit.

Yup.  That's my take on it too.  This default of "no argument means
describe the working tree" matches with tools like `git diff`,
`git checkout`, `git status`, `git blame` with no revision arguments.

We are being blasted by users for being inconsistent in our UI in too
many places.  Here's yet another.  We need to start standardizing
on a more consistent UI model.  If that model means we need to
use a "--worktree" flag to mean "against the working tree" then
we should start doing that also to `git status`, `git checkout`,
`git blame`, and `git diff`.

>  $ git describe --dirty v1.2.1
> should it show an error, output "v1.2.1" anyway, or output
> "v1.2.1-dirty" if the working tree is different from v1.2.1 ?

IMHO, that should be a fatal usage error, if we go that approach.
I would also argue `git describe --dirty HEAD` is equally fatal.

-- 
Shawn.
