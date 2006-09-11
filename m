From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 00:11:04 -0700
Message-ID: <7vr6yikhdj.fsf@assigned-by-dhcp.cox.net>
References: <20060908184215.31789.qmail@science.horizon.com>
	<9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
	<17668.2019.732961.855446@cargo.ozlabs.ibm.com>
	<20060911000306.GA28927@spearce.org>
	<7vfyezqlny.fsf@assigned-by-dhcp.cox.net> <ee2cms$o18$1@sea.gmane.org>
	<20060911024434.GA29368@spearce.org>
	<7vac57nfb5.fsf@assigned-by-dhcp.cox.net>
	<20060911060820.GB29368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 09:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMfwK-0006Qr-Af
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 09:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWIKHKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 03:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWIKHKe
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 03:10:34 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:7104 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750752AbWIKHKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 03:10:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911071032.DXL6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Mon, 11 Sep 2006 03:10:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LvAW1V00T1kojtg0000000
	Mon, 11 Sep 2006 03:10:34 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060911060820.GB29368@spearce.org> (Shawn Pearce's message of
	"Mon, 11 Sep 2006 02:08:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26841>

Shawn Pearce <spearce@spearce.org> writes:

> I think Linus was suggesting the same thing, just not nearly as
> obvious.  He also was looking for ways to not update it frequently.
> But I can't say I'm a fan of negative entries. :-)

I like Linus's suggestion quite a lot actually.  It would be a
nice little project that needs to touch reasonably well-isolated
area of the code, but I suspect it would need a bit more
exposure and familiarity to the existing code than somebody who
looks at the core code for the first time.

> But at this point I have more on my plate than I have time for.  :-)

You've done quite a lot of work on refs area yourself, so you
might want to give somebody else the chance to try first ;-).

> I've got to get that map window code merged against master or next
> (preference Junio?  next touches code I'm touching too but those
> aren't in master yet) for 32 bit offset.

As you know I've shelved the 64-bit offset stuff.  My preference
is to base it on 106d710b but basing it on 'next' would be fine.
Between 106d710b and next there is only one unrelated change to
sha1_file.c, which is the hexval[] change that is in 'master'.

I've sent out "What's in" tonight but forgot to talk about plans
for topics in "next", so here is an update.

 - These things are probably Ok, and after a bit more testing
   I'd like to push them out to 'master' by my Wednesday:

   - Andy Whitcroft's "send-pack to use git-rev-list --stdin"
   - "git apply" to apply binary without explicit --binary flag;
   - "git diff --binary" to do full-index only for binary patch;
   - "git unpack-objects -r", except it needs a better name
     (perhaps --recover).

 - And these by the end of week:

   - Jeff King's git-runstatus;
   - Frank and Rene's git-archive along with git-daemon change;

 - I am not _so_ comfortable with these quite yet, but plan to
   test it a bit more to gain confidence and decide when to push
   out to 'master' perhaps by the middle of the week:

   - pack-objects --unpacked=this-pack --unpacked=that-pack
   - pack-objects --stdin

> I also want to spend more time on the dictionary packing prototype to
> see if its worth spending even more time on.

So far I liked the per-object-type dictionary conjecture the
most, primarily because my gut feeling tells me that it would
involve the least amount of hassle in the interoperability area.

But honestly speaking I am not looking forward to a packfile
format update at this moment.  I'd like things to settle down a
bit now, after merging good bits from 'next' to 'master' and
declare 1.4.3 first, perhaps by the end of the month.
