From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 25 May 2006 14:04:09 -0700
Message-ID: <7virntsto6.fsf@assigned-by-dhcp.cox.net>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
	<7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
	<m1y7wpde1w.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 23:04:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjN0C-000385-Hp
	for gcvg-git@gmane.org; Thu, 25 May 2006 23:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWEYVEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWEYVEM
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 17:04:12 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:34787 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751253AbWEYVEK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 17:04:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525210410.TNXD15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 17:04:10 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1y7wpde1w.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Thu, 25 May 2006 14:50:35 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20765>

ebiederm@xmission.com (Eric W. Biederman) writes:

> - I don't know which branch I need to fetch.

As you say yourself Andrew marks which one he fetched from, so
this is a non-issue.

> - Fetching a branch that I just want a subset of is wasteful.

Generally this is true, but in practice and especially for this
particular application I do not think so.  After all Andrew
pulled from the tip and got that tip, and IIUYC you are trying
to follow what Andrew did, so you'd be better doing this soon
after Andrew annouces the series, so your subset would be a
close to 100% subset.  Otherwise you would have different
problem anyway -- the tree owner after seeing -mm tree has his
series may rewind and rebuild the branch in preparation of
feeding him with the next time around.

> - It feels really weird when everything else allows me to use sha1s
>   for git-fetch to deny them.

That is a real argument and I am not opposed to change
fetch-pack to ask for an arbitrary SHA1 the caller obtained out
of band.

> Then there is the big hole in my plan to get better changelog information
> that it appears that after Andrew pulls a branch he resolves some
> merge conflicts.  If that is right I need to figure out how to address
> that before I can improve git-quiltimport.sh.

The last time I talked with Andrew, he is not doing a merge nor
resolving merge conflicts.  He treats git primarily as a
patchbomb distribution mechanism, and works on (a rough
equivalent of) the output of format-patch from merge base
between his base tree and individual subsystem tree.  After that
things are normal quilt workflow outside git, whatever it is.
