From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase -i: several cleanups
Date: Tue, 26 Jun 2007 18:57:51 -0700
Message-ID: <7vodj2tazk.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706251856300.4059@racer.site>
	<7vk5tqurrw.fsf@assigned-by-dhcp.pobox.com>
	<Pine.LNX.4.64.0706270216070.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:00:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3MpW-0007Rm-3t
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760484AbXF0B5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760867AbXF0B5y
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:57:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51818 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760431AbXF0B5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:57:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627015751.RPZU1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 21:57:51 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GRxr1X00c1kojtg0000000; Tue, 26 Jun 2007 21:57:52 -0400
In-Reply-To: <Pine.LNX.4.64.0706270216070.4438@racer.site> (Johannes
	Schindelin's message of "Wed, 27 Jun 2007 02:17:08 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51003>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +die_abort () {
>> > +	rm -rf "$DOTEST" 2> /dev/null
>> > +	die "$1"
>> > +}
>> 
>> Why "2>/dev/null" here?
>
> Just to be sure. If it does not exist, it's no error. No sense alarming 
> the user.

Yeah, but isn't that exactly why you have "-f" there?  On the
other hand, if $DOTEST exists but for some reason couldn't be
removed, we probably would want to know about it.

    $ rm -fr no-such
    $ mkdir no-such
    $ echo >no-such/file
    $ rm -fr no-such
    $ mkdir no-such
    $ echo >no-such/file
    $ chmod a-w no-such
    $ rm -fr no-such
    rm: cannot remove `no-such/file': Permission denied
