From: Kent Borg <kentborg@borg.org>
Subject: Re: git-p4
Date: Sun, 12 Sep 2010 13:59:21 -0400
Message-ID: <4C8D14F9.90705@borg.org>
References: <4C8A8CE8.90600@borg.org>	<20100910235323.773d2c5b@varda>	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>	<4C8CF231.6090403@borg.org> <AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?QWxlamFuZHJvIFJpdmVpcmEgRmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 19:59:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouqpv-0007pU-2V
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 19:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab0ILR7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 13:59:24 -0400
Received: from borg.org ([64.105.205.123]:43759 "EHLO borg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab0ILR7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 13:59:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: kentborg)
	by borg.org (Postfix) with ESMTP id E6FDD87805;
	Sun, 12 Sep 2010 13:59:22 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156041>

Tor Arvid Lund wrote:
> Ok, so if you call this on the cmd line, it should output sha1's on
> all commits that will be submitted (in reverse order) to p4. If it
> doesn't, this may well be a good place to dig for a solution.

It does output the commits it wants to submit.  In my broken case far
too many.

I created a simple working case to see what working looks like, and the
exact same command outputs just the one commit.  Looking more carefully
at my gitg pictures in the good and bad cases, I realize that I in the
broken case I probably don't have the graph I need.


Good case:

  (master)
   |
  (p4/HEAD)  (p4/master)
   |
  initial test import from existing depot


Bad case:

  (master)   trivial change I am trying to submit
   |
  (tmp)  commit with the "[git-p4: depot-paths = "//depot/[...blah
blah...]": change  = 160991]" string at the end of the description
   |
  Merge remote branch 'p4/master'
   | \
   |  (p4/HEAD)  (p4/master)  a commit that is real work
   |   |
   |   more real work
   |   |
   |   more real work
   |   |
   Merge remote branch 'p4/master'
   |  \|
   some commit in my thrashing about
   |   |
   |   more real work
   |   |
   .   .
   .   .
   .   .
   |   |
   |   initial import of no-history linux sources that I put in manually
via Perforce
   |
   .
   .
   .
   |
   Linux-2.6.12-rc2
 

I think my understanding of merges and rebases needs more depth...and I
think I have mangled branches.


I tried a checkout of master and a "git rebase remotes/p4/master" and
that produced thousands of conflicts.  Was that due to my initial Linux
sources put in on the Perforce side?


How do I untangle myself here?


I think I am about to be saved, thanks so much in advance for that!


-kb
