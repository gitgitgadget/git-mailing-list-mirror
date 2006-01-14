From: Junio C Hamano <junkio@cox.net>
Subject: Re: My first git success [not quite]
Date: Sat, 14 Jan 2006 12:49:43 -0800
Message-ID: <7vbqyefsbc.fsf@assigned-by-dhcp.cox.net>
References: <dq8epd$k28$1@sea.gmane.org>
	<Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
	<dqb5vg$a09$1@sea.gmane.org>
	<Pine.LNX.4.64.0601141117120.13339@g5.osdl.org>
	<dqbnl1$3si$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 21:50:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExsLY-0001Mz-9S
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 21:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWANUtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWANUtr
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 15:49:47 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6604 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751108AbWANUtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 15:49:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060114204752.ZJRC17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 Jan 2006 15:47:52 -0500
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dqbnl1$3si$1@sea.gmane.org> (wa1ter@myrealbox.com's message of
	"Sat, 14 Jan 2006 12:41:04 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14685>

walt <wa1ter@myrealbox.com> writes:

> Linus Torvalds wrote:
> [...]
>> Now, what happens is that when you change branches with a dirty tree, the 
>> "git checkout" will do one of two things:
>> 
>>  - if the dirty files are _identical_ in both branches...
>
> I'm sorry to be quibbling over semantics, truly I am!  But here
> is my confusion:  if modified-but-uncommitted (hence dirty) files
> are not associated with *any* branch, then how could 'dirty' files
> be 'in' both branches (or 'in' any branch at all)?

"If the paths that you have dirty are the same in both
branches".

That is:

* "master" branch has Makefile file, as taken from git.git

* "my-work" branch was made out of "master" branch, but
  has not modified Makefile file.

	git-diff-tree master my-work Makefile

  would yield nothing.

* You are on "master" branch.  You have added a new target to
  your Makefile in the working tree and the path is dirty.

Then:

	git checkout my-work

would notice that the path "Makefile" are identical between two
branches "master" you are switching from and "my-work" you are
switching to.  The "Makefile" in your working tree does not
match either tree, but that difference is carried over while
switching branches.

As Linus mentioned, with '-m' flag to "git checkout", it can
merge your local modifications even when "master" and "my-work"
disagrees on "Makefile" in this example.

        
