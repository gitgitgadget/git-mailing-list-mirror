From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Wed, 19 Oct 2005 21:16:14 -0700
Message-ID: <7v8xwovn5d.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net>
	<7vwtk9vvhg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510200351260.26594@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0510200559540.3394@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 06:17:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESRqn-0000mE-Or
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 06:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbVJTEQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 00:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbVJTEQR
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 00:16:17 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:11213 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751730AbVJTEQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 00:16:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051020041559.UDXQ4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Oct 2005 00:15:59 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510200559540.3394@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 20 Oct 2005 06:08:48 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10341>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
>> > +		    ((o = parse_object(remote)) != NULL) &&
>> > +		    (o->flags & COMPLETE) &&
>
> I just realized that parse_object() always reads the file, then does a 
> lookup (which makes the above code work), and then parses the file. It 
> always does all of these steps, even if the object was already parsed. Any 
> reason for this?

You are right.  We should be using lookup_object() for this part
of the code.
