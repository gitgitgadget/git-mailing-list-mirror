From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Fri, 28 Oct 2005 19:49:18 -0700
Message-ID: <7vslul2g29.fsf@assigned-by-dhcp.cox.net>
References: <1130434230.19641.21.camel@dv>
	<7vslum3l2w.fsf@assigned-by-dhcp.cox.net>
	<1130463389.2186.14.camel@dv>
	<7v4q72xavz.fsf@assigned-by-dhcp.cox.net>
	<1130539503.10531.43.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 04:50:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVgmb-0005gS-Ba
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 04:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVJ2CtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 22:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVJ2CtW
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 22:49:22 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:238 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751104AbVJ2CtW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 22:49:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029024837.QGGT11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Oct 2005 22:48:37 -0400
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10781>

Pavel Roskin <proski@gnu.org> writes:

>>     git-rev-list ^$old_head $new_head |
>>     git-diff-tree -p -m --stdin --with-commit-ids |
>>     git-patch-id
>
> Sounds good.  Perhaps the commit IDs should have a prefix identifying
> them.

I do not think git-diff-tree -p output can have 40-byte
hexadecimal at the beginning of the output anywhere other than
commit object names; why clutter output?

> Another approach would be to use something slightly more elaborate than
> a pipe.  If I understand correctly, the commit ID would be already known
> from the git-rev-list output.  Passing commit IDs through patch-id
> without actually doing anything with them seems non-elegant.

Sorry you lost me.  I am not sure what you mean by "without
actually doing anything" part.  The input to patch-id command in
the above pipe is (commit-object-name patch)*.  The command
reads such a stream, and transforms it to a (patch-id
commit-object-name)* stream.  In other words, the input
identifies each patch with a commit-object-name, and the command
condenses each patch to a patch-id, and spits them out, labelled
with commit-object-name.
