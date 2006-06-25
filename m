From: Junio C Hamano <junkio@cox.net>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sat, 24 Jun 2006 20:57:33 -0700
Message-ID: <7vfyhtopjm.fsf@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<20060625012435.GZ21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 05:57:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuLkg-00044P-8o
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 05:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWFYD5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 23:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWFYD5f
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 23:57:35 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14988 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751369AbWFYD5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 23:57:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625035734.RFC18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 23:57:34 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060625012435.GZ21864@pasky.or.cz> (Petr Baudis's message of
	"Sun, 25 Jun 2006 03:24:35 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22587>

Petr Baudis <pasky@suse.cz> writes:

>>  - RPM target -- we probably acquired a new build-dependency in
>>    which case the .spec file needs to be updated;
>
> Well, perl is currently not listed even as a runtime dependency,
> so does it really need to be listed as a build dependency?

Really?  I think rpmbuild is getting anything that matches "^use "
and listing the perl modules as dependencies.

>>  - Make sure Git.xs builds and installed result works fine on
>>    all platforms we care about, including Cygwin and other
>>    non-Linux boxes.
>
> Unfortunately I don't have access to a lot of those. :-(

I don't either.  That's why I would want to place something
low-impact on "next" to ask help from the users.

>> I'd even suggest we revert the changes to git-fmt-merge-msg to
>> keep it working for now, until the above worries are resolved.
>> Otherwise we cannot have it in "next" safely (and I REALLY _do_
>> want to have Git.pm infrastructure in "next" soonish).
>
> Yes, that sounds reasonable.
>
>> We can start using Git.xs and friends in some _new_ ancillary
>> programs, once we solve building and installing problems for
>> everybody.  That way it would help us gain portability and
>> confidence without disrupting existing users.
>
> Well, I don't think it's very likely that Git.pm per se would be buggy
> on a certain specific platform - it should either work as well as
> everywhere else or not build at all, in which case you have disrupted
> the existing users anyway. :-) (But without disrupting anyone we won't
> get any bugreports and never get it fixed.)
>
> Perhaps other converted perl scripts can linger at least on the pu
> branch?

My preference is to keep your other conversion in "later"
mailbox, not even in "pu", to keep them from distracting me.
I'd like to have something low-impact (e.g. "git-mv" which I do
not use and I do not think Linus uses) along with the perl/
directory and build procedure in "next" soonish to make sure at
least things build and correctly install for everybody
(compiling and linking alone would not count as "correctly
install" while we have something like INSTALLSITEARCH gotcha).
After we are reasonably confident about the whole .xs stuff we
can revert the revert of git-fmt-merge-msg.
