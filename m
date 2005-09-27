From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Support for partial HTTP transfers
Date: Tue, 27 Sep 2005 15:24:20 -0700
Message-ID: <7vfyrqywrv.fsf@assigned-by-dhcp.cox.net>
References: <20050926175204.GC9410@reactrix.com>
	<7vd5mvedcs.fsf@assigned-by-dhcp.cox.net>
	<20050927000931.GA15615@reactrix.com>
	<7vfyrr3vwp.fsf@assigned-by-dhcp.cox.net>
	<20050927153636.GA1377@reactrix.com>
	<7v1x3a309u.fsf@assigned-by-dhcp.cox.net>
	<20050927171912.GC1377@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 00:25:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKNsB-0003qr-Dw
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 00:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVI0WYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 18:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVI0WYY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 18:24:24 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29909 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751102AbVI0WYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 18:24:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927222420.PMCI9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 18:24:20 -0400
To: Nick Hengeveld <nickh@reactrix.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9419>

Nick Hengeveld <nickh@reactrix.com> writes:

> On Tue, Sep 27, 2005 at 10:09:49AM -0700, Junio C Hamano wrote:
>
>> True.  What I meant by "interesting" is that two is reading from
>> what one is writing.
>
> Excellent point.  Given the potential for problems related to this
> issue or to compressed representation, would it make sense to enable
> partial transfers via a command-line option and leave the feature
> disabled by default?

Here is what I think.  Multiple transfers at the same time, if
it becomes problem in pratcice, should be prevented at the upper
layer anyway, so this "interesting" problem is a moot point.  So
I'd say let's not worry about that.

Doing partial transfer support for packs and indices would be
more useful addition to your code than dealing with the above --
packs are much bigger than individual objects and would get much
bigger benefit from restartable download.

Different compressed representation is just a theoretical
curiosity and we do not know if it is a problem in practice.  As
long as you can detect the situation and die, it would be OK, I
think. 

 
