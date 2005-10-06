From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Thu, 06 Oct 2005 11:07:11 -0600
Message-ID: <m1slvek20w.fsf@ebiederm.dsl.xmission.com>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
	<7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510050725510.31407@g5.osdl.org>
	<7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
	<m1mzln9zi1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
	<m1y8575i9y.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510060731560.31407@g5.osdl.org>
	<m1wtkqk89a.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510060756060.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 19:12:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENZEu-0006dk-Jk
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 19:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVJFRIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 13:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVJFRIn
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 13:08:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45962 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751152AbVJFRIm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 13:08:42 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j96H7CuY024388;
	Thu, 6 Oct 2005 11:07:12 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j96H7B90024387;
	Thu, 6 Oct 2005 11:07:11 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510060756060.31407@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 6 Oct 2005 07:59:36 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9775>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 6 Oct 2005, Eric W. Biederman wrote:
>> 
>> After thinking about it I don't think you need to look through the
>> history to use it for a merge3 operation.   As I recall merge3 only
>> looks at the base and the two derived versions of the file.  If we
>> have the sha1 of the original in the git repository I think all we
>> need to compute is the diff between that sha1 the current version
>> file.  And then apply the merge3 algorithm to combine the two sets of
>> changes.
>
> Ahh, that I can definitely agree with. In fact, it makes perfect sense.
>
> However, it assumes that everybody is a git user, which isn't actually 
> true. 

Agreed.  The question is the subset of everyone large enough to
make it a useful technique.  Given that a standalone diff utility can
be taught how to generate the extra information, and a standalone
patch could use it to verify you are at least patching the version
of the file the patch was intended for I suspect the subset of
everyone is large enough to be interesting.

> Also, I'm wondering whether the advantages outweigh the 
> disadvantages: it would make the diff uglier. We'd have to add that SHA1 
> there somewhere (either on the "diff" line itself, or as anothe rextended 
> git line like the "rename from/to" lines - a "original <sha1>" line).

I don't think an extra line in the header is going to be much of a problem.
Just more header noise.  

Eric
