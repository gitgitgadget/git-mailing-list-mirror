From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 18:27:03 +0200
Organization: At home
Message-ID: <e2lijt$aco$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 25 18:27:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYQNk-0003VI-I1
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 18:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWDYQ1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 12:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWDYQ1R
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 12:27:17 -0400
Received: from main.gmane.org ([80.91.229.2]:61880 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751586AbWDYQ1Q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 12:27:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYQNQ-0003Q0-Um
	for git@vger.kernel.org; Tue, 25 Apr 2006 18:27:00 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 18:27:00 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 18:27:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19152>

Linus Torvalds wrote:

> On Tue, 25 Apr 2006, Linus Torvalds wrote:
>> 
>> I want the git objects to have clear and unambiguous semantics. I want
>> people to be able to explain exactly what the fields _mean_. No "this
>> random field could be used this random way" crud, please.
> 
> Btw, if the whole point is a "leave random porcelain a field that they can
> use any way they want", then I say "Hell NO!".

The generic commit links "related" which is fsck-able at least and "note"
which is not. It is idea somewhat on the level of providing _extended
attributes_ in VFS in Linux kernel, IMVHO.

"note" can be considere cruft, "related" is fsck-able and pull-able so has
meaning for core (even if not all "note" and/or "related" links have any
repercussion for merging for example).

So far there are following core git ideas of using this feature (akin to
using extended attributes for ACL, or SELinux properties):

1. "related" link "bind" for better support of subprojects. Useful if some
parts of project are developed independently (e.g. lm_sensors or ALSA was
in Linux kernel, xdiff for git, somelibrary or somemodule for someproject
etc.).
2. "note" link "cherrypicked" for cherry-picking, rebase etc., for example
to not apply the same commit twice. Useful in merging after cherry picking.

Additionally there are following less certain ideas

3. "prior" link in the sense of prior state of frequently rebased branch
like git's "pu" (case (1) in first post in this thread)
4. "depend" link for creating darc-esque dependency partial ordering of
commits (patches), for better merge perhaps
5. "note" link "rename" (or more generic "contents related") for remembering
renames/file moving, file splitting, contents moving and copying, including
correcting automatic "rename" detection at merge (i.e. remembering false
positives and false negatives). Useful in subsequent merges and information
commands (log, whatchanged, annotate/blame, diff).
6. "note" link "origin" to remember for where the commit was pulled.

Note that none of those are non-core Porcelain ideas.

-- 
Jakub Narebski
Warsaw, Poland
