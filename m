From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: send-pack: limit on negative references
Date: Tue, 05 Sep 2006 22:32:01 +0100
Message-ID: <44FDECD1.2090909@shadowen.org>
References: <44FD714F.9040003@shadowen.org> <7vwt8igu4u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 23:32:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKiWy-0003TU-Pc
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 23:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWIEVc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 17:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWIEVc0
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 17:32:26 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:27919 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751422AbWIEVcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 17:32:25 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GKiWX-0004Fy-D7; Tue, 05 Sep 2006 22:32:01 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt8igu4u.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26489>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> I've been having trouble with git push apparently resending the entire
>> commit trace for the branch each and every time I push; even with short
>> branch names.  This seems to be related to the changes made to handle
>> the case where the remote end has a large number of branches (>900).
> 
> I think the right fix is to do one or both of the following, and
> lift that 900 cut-off entirely.
> 
> One is to teach rev-list to read the information it is taking
> from the command line instead from its standard input.
> 
> Another is to teach pack-object the same trick on top of my
> patch last night.  This has an added benefit that we save one
> pipe+fork+exec there.
> 
> These are essentially suggestions from Linus made twice
> separately in the past, so they must be on the right track ;-).
> 
> If nobody does, I would do it myself, but the list is welcome to
> beat me to it.  Especially, the former (giving --stdin option to
> rev-list) should be trivial.

Ok, I'll have a go at this one.  As you say it looks pretty simple to
reuse the command line revision parser on an incoming stream.

-apw
