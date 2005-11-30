From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 22:39:36 -0800
Message-ID: <7vwtiqzljr.fsf@assigned-by-dhcp.cox.net>
References: <20051130060906.13277.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, torvalds@osdl.org, git@vger.kernel.org,
	pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 07:54:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhLdR-0006qn-L9
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 07:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVK3Gjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 01:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVK3Gjj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 01:39:39 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49089 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751084AbVK3Gji (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 01:39:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130063907.LBGX3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 01:39:07 -0500
To: linux@horizon.com
In-Reply-To: <20051130060906.13277.qmail@science.horizon.com>
	(linux@horizon.com's message of "30 Nov 2005 01:09:06 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12989>

linux@horizon.com writes:

>> +-0 -1 -2::
>> +	When an unmerged entry is seen, diff against the base version,
>> +	the "first branch" or the "second branch" respectively.
>> +
>> +	The default is to diff against the first branch.
>> +
>
> Er... why are these flags zero-based?

Because -1 means "first branch" (usually "ours", aka HEAD), and
-2 means "second branch" ("theirs", aka MERGE_HEAD), and -0 is
for the base (aka merge base)?

But I think you are right.  The numeric parameters should match
stage number for consistency.

How about if I redo the patch to make diff-files accept -1/-2/-3
instead, and in addition accept "--base", "--ours", and
"--theirs" as synonyms?

Side note.  diff3 says MINE OLDER YOURS and the way to remember
the order is they are alphabetical.  We can say the same for
base, ours and theirs.
