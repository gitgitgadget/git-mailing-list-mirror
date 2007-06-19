From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT rebasing safeguard
Date: Wed, 20 Jun 2007 00:37:00 +0200
Message-ID: <20070619223700.GA7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth> <20070611003330.4736.69293.stgit@gandelf.nowhere.earth> <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com> <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net> <20070614213032.GR6992@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706191512l5f19b80v5b5be9151be13025@mail.gmail.com> <b0943d9e0706191518o6396a2c5u1fb4f0953dc85aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 00:37:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0mJv-0005aE-CJ
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 00:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbXFSWhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 18:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbXFSWhF
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 18:37:05 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:48001 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbXFSWhE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 18:37:04 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2A8C45A151;
	Wed, 20 Jun 2007 00:37:02 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 4F5AB1F150; Wed, 20 Jun 2007 00:37:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0706191518o6396a2c5u1fb4f0953dc85aa@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50517>

On Tue, Jun 19, 2007 at 11:18:56PM +0100, Catalin Marinas wrote:
> On 19/06/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> >On 14/06/07, Yann Dirson <ydirson@altern.org> wrote:
> >> When the parent branch is a rewinding one (eg. an stgit stack), then
> >> the old version of the patch will be turned to unreachable by
> >> pull/rebase, and we probably have even no way of telling stgit that it
> >> is indeed expected, since the parent stack is a local one.  My own
> >> workflow on StGIT is affected by the issue, since my "bugs" stack is
> >> forked off my "master" stack (but hopefully an hydra will help me ;).
> >
> >If I understand correctly, is this the case where you do a 'stg
> >commit'? This command is meant for branches that are never rebased
> >(i.e. my master stgit branch). For this branch one wouldn't have a
> >remote branch configured and hence git fetch shouldn't do anything.
> 
> I got confused - you were talking about 'stg rebase' rather than the
> 'pull' strategy. But the question remains - are you referring to the
> user running 'stg commit' and losing this commit after a rebase?

Not at all.  I'm talking about an stgit stack, whose base is the head
of another stack (eg. a "pu" branch).  When you want to rebase, the
old heads/pu is only reachable from your stack base.

Maybe we can use the parent's reflog, but I'm not sure it would cover
all cases, and a reflog can possibly be expired before the information
in there gets used.


> The rebase should be equivalent to a git-reset but with
> popping/pushing of the patches one the stack. Once committed, the
> patch is no longer managed by StGIT and therefore we shouldn't care.

That is another issue - and I rather believe we should not allow a
user to do that without --force, if what he committed will be
unreachable after rebasing.  If he intended to loose it, he would
usually rather have used "stg delete" than such a convoluted sequence
of actions :)

Best regards,
-- 
Yann.
