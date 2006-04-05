From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] date parsing: be friendlier to our European friends.
Date: Wed, 05 Apr 2006 15:54:02 -0700
Message-ID: <7vhd57zl9x.fsf@assigned-by-dhcp.cox.net>
References: <7vodzg4l5n.fsf@assigned-by-dhcp.cox.net>
	<20060404231606.219a4cc5.akpm@osdl.org>
	<7virpo4jxf.fsf@assigned-by-dhcp.cox.net>
	<7vlkujzly0.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 06 00:54:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRGt8-00022L-QF
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 00:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWDEWyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 18:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWDEWyG
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 18:54:06 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:26518 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932115AbWDEWyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 18:54:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405225403.RVJV26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 18:54:03 -0400
To: git@vger.kernel.org
In-Reply-To: <7vlkujzly0.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 05 Apr 2006 15:39:35 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18458>

Junio C Hamano <junkio@cox.net> writes:

> This does three things, only applies to cases where the user
> manually tries to override the author/commit time by environment
> variables, with non-ISO, non-2822 format date-string:
>
>  - Refuses to use the interpretation to put the date in the
>    future; recent kernel history has a commit made with
>    10/03/2006 which is recorded as October 3rd.
>
>  - Adds '.' as the possible year-month-date separator.  We
>    learned from our European friends on the #git channel that
>    dd.mm.yyyy is the norm there.
>
>  - When the separator is '.', we prefer dd.mm.yyyy over
>    mm.dd.yyyy; otherwise mm/dd/yy[yy] takes precedence over
>    dd/mm/yy[yy].

Before the list gets useless comments, the code prefer to accept
more sensible and/or unambiguous forms, such as ISO or RFC2822.
The issue this addresses is what to do when we get other forms.
