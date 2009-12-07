From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH] Allow --quiet option to git remote, particularly for `git remote update`
Date: Mon, 07 Dec 2009 02:23:13 -0500
Message-ID: <1260169742-sup-9991@utwig>
References: <1260057623-28960-1-git-send-email-alex@chmrr.net> <7vd42soo2p.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 08:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHXwH-0001Gc-9B
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 08:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003AbZLGHXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 02:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757980AbZLGHXI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 02:23:08 -0500
Received: from chmrr.net ([209.67.253.66]:40175 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757667AbZLGHXH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 02:23:07 -0500
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1NHXw9-0000nw-19; Mon, 07 Dec 2009 02:23:13 -0500
In-reply-to: <7vd42soo2p.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134718>

At Sat Dec 05 21:04:14 -0500 2009, Junio C Hamano wrote:
> Alex Vandiver <alex@chmrr.net> writes:
> > ...
> >      "git remote prune [-n | --dry-run] <name>",
> > -    "git remote [-v | --verbose] update [-p | --prune] [group | remote]",
> > +    "git remote [-v | --verbose] [-q | --quiet] update [-p | --prune] [group]",

Hm, I hadn't noticed that I'd changed "[group | remote]" to "[group]".
I think this is due to a mismerge on my part -- apologies.  As another
data point, `git fetch` describes this as "[<repository> | <group>]".

> Three issues to consider:
> 
>  - shouldn't we use the same typography, i.e. <group>?
> 
>  - should we say <name> _if_ we are not going to say <group>|<remote>?
> 
>  - should we keep it as <group>|<remote> to make it clear that only this
>    subcommand allows the group nickname?
> 
> The first two are easy and I expect the answers to be both yes.  The third
> one needs some studying and further thought.
> 
>  - is "remote update" the only one that takes group nickname?

My quick skim of the code says "yes" -- the other commands only deal
with single remotes at a time, and prune is oblivious to groups.

>  - should "remote update" the only one? e.g. does "remote prune" also
>    take group? if not, shouldn't it?

Properly, it "ought" to, though I don't see much utility over `git
remote fetch --prune groupname`.  Probably at the same time, the
parallel pruning codepaths in builtin-fetch.c:prune_refs() and
builtin-remote.c:prune_remote() should be unified.
 - Alex
-- 
Networking -- only one letter away from not working
