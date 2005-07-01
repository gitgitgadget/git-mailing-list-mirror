From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Tags
Date: Fri, 01 Jul 2005 07:56:06 -0600
Message-ID: <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
	<Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
	<42C454B2.6090307@zytor.com>
	<Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>
	<42C462CD.9010909@zytor.com>
	<Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>
	<42C46B86.8070006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 15:52:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoLuJ-0001ug-Ow
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 15:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbVGAN5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 09:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbVGAN5e
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 09:57:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15524 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263344AbVGAN5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 09:57:15 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j61DuAdi026295;
	Fri, 1 Jul 2005 07:56:10 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j61Du6FM026294;
	Fri, 1 Jul 2005 07:56:06 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C46B86.8070006@zytor.com> (H. Peter Anvin's message of "Thu,
 30 Jun 2005 15:00:38 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> In the end, it might be that the right thing to do for git on kernel.org is to
> have a single, unified object store which isn't accessible by anything other
> than git-specific protocols.  There would have to be some way of dealing with,
> for example, conflicting tags that apply to different repositories, though.

As far as I can tell public distributed tags are not that hard and if
you are going to be synching them it is probably worth working on.

The basic idea is that instead of having one global tag of
'linux-2.6.13-rc1' you have a global tag of
'torvalds@osdl.org/linux-2.6.13-rc1'.

The important part is that the tag namespace is made hierarchical
with at least 2 levels.  Where the top level is a globally
unique tag owner id and the bottom level is the actual tag.  This
prevents collisions when merging trees because two peoples
tags are never in the same namespace, as least when
people are not actively hostile :)

Still being a complete git dummy I think the trivial mapping is
to put tags in:
.git/refs/tags/user@domain/tag
and then have a symlink at:
.git/TAGS 
that points to your default directory of tags.

Eric
