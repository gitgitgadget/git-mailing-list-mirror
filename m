From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 14:44:42 -0700
Message-ID: <7voeby60fp.fsf@assigned-by-dhcp.cox.net>
References: <42703E79.8050808@zytor.com>
	<1114673723.12012.324.camel@baythorne.infradead.org>
	<20050428081005.GG8612@pasky.ji.cz>
	<1114676955.12012.346.camel@baythorne.infradead.org>
	<1114680199.12012.363.camel@baythorne.infradead.org>
	<Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
	<7v1x8u7g26.fsf@assigned-by-dhcp.cox.net>
	<1114723402.2734.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:40:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGj3-0005tY-Pb
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVD1Vor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVD1Vor
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:44:47 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20466 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262237AbVD1Vop (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:44:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428214444.IVMC7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 17:44:44 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114723402.2734.11.camel@localhost.localdomain> (David
 Woodhouse's message of "Thu, 28 Apr 2005 22:23:21 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DW" == David Woodhouse <dwmw2@infradead.org> writes:

DW> On Thu, 2005-04-28 at 14:21 -0700, Junio C Hamano wrote:
>> 2. Assuming that we do want to enforce that parent fields of a
>> commit object name valid commit objects, is it OK to also
>> require that the commit timestamp of a child object is not in
>> the future relative to any and all of its parent commit
>> objects

DW> No. Time is utterly meaningless -- it's perfectly normal for clocks to
DW> be out of sync. We really don't want to fall into the trap of assigning
DW> any meaning to the timestamp.

If that is really the case, shouldn't we do one of the
following:

 (1) Timestamp is meaningless.  Stop recording it in the commit
     objects.

 (2) Keep recording meaningless timestamp in the commit objects,
     because otherwise it would break backward compatibility.
     However, stop looking at timestamp in commit.c; especially
     pop_most-recent_commit() is meaningless hance what rev-list
     does.

 (3) Require the proper ordering in the timestamp as I
     suggested.  Users should take note and make corrective
     action if their clocks are _way_ out of sync.

I do not think we want to do either (1) or (2).

