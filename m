From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 01 Aug 2007 03:15:25 -0700
Message-ID: <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	<7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	<20070801092428.GB28106@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 01 12:15:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGBEp-0007kh-CN
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 12:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbXHAKP2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 06:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763220AbXHAKP1
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 06:15:27 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61868 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763563AbXHAKP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 06:15:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801101526.NJCZ1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Aug 2007 06:15:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WaFR1X0091kojtg0000000; Wed, 01 Aug 2007 06:15:26 -0400
In-Reply-To: <20070801092428.GB28106@thunk.org> (Theodore Tso's message of
	"Wed, 1 Aug 2007 05:24:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54425>

Theodore Tso <tytso@mit.edu> writes:

> On Tue, Jul 31, 2007 at 10:50:48PM -0700, Junio C Hamano wrote:
>> I would call aversion to -l a superstition, while aversion to -s
>> has a sound technical reasons.  The latter means you need to know
>> what you are doing --- namely, you are making the clone still
>> dependent on the original.
>
> So would you accept a patch which adds a git-config variable which
> specifies whether or not local clones should use hard links by default
> (defaulting to yes), and which adds a --no-hard-links option to
> git-clone to override the config option?

Are you suggesting to make -l the default for local, in other
words?  I personally do not make local clone often enough that I
am not disturbed having to type extra " -l" on the command line.

But giving a way to force "copy not hardlink" while still
avoiding "the same as the networked case by doing pack transfer"
overhead may be a good thing to do.

Perhaps if the destination is local,

         - if -s is given, just set up alternates, do nothing else;
         - by default, do "always copy never hardlink";
         - with -l, do "hardlink if possible";

Hmmmm...
