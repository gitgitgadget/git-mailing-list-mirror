From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 19:49:24 +0200
Message-ID: <E1FwN7M-0007GI-Ng@moooo.ath.cx>
References: <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net> <E1Fw8hS-00023y-FY@moooo.ath.cx> <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net> <E1FwDiI-0007Xp-2s@moooo.ath.cx> <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net> <E1FwGgm-0006Nc-9a@moooo.ath.cx> <7vejx6k54p.fsf@assigned-by-dhcp.cox.net> <E1FwMPf-0005XA-N9@moooo.ath.cx> <7vpsgqimu7.fsf@assigned-by-dhcp.cox.net> <e83n97$973$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 19:49:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwN7V-0006Av-OB
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 19:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbWF3Rta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 13:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbWF3Rta
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 13:49:30 -0400
Received: from moooo.ath.cx ([85.116.203.178]:35725 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932963AbWF3Rta (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 13:49:30 -0400
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e83n97$973$1@sea.gmane.org>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23005>

Jakub Narebski wrote:
> I think --near _has_ to be non-symmetric binary operator, i.e. first
> argument specifies line to be found, second argument has to be in context
> for first line if it is found.
> 
> So the above expression would be written as:
> 
>   -e foo --near \( A --or B \)
Why is that?
-e foo --and --near \( -e A -- or -e B \)
would mean lines containing foo and either A or B in the context and
-e foo --or  --near \( -e A -- or -e B \)
would mean lines containing foo or having A or B in the context.

> BTW. we can make -e equivalent to --or, and empty (default) operator to
> --and, but of course you have to delimit expression from files, i.e. either
> 
>   git grep A B C D -- files
This is incompatible with the current implementation.
'git grep A B C D -- files' means A is the pattern, B, C, D are
revisions and files is the pathspec.

> or
> 
>   git grep -e \( A B C D \) files
> 
> which would be equivalent to
> 
>   git grep A --and B --and C --and D files
I think this could probably be used.  But I think having two different
implicit operators depending on the context is too confusing.
