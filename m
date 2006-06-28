From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pre-commit hook: less easily-tripped conflict marker detection
Date: Tue, 27 Jun 2006 18:58:11 -0700
Message-ID: <7vhd2659e4.fsf@assigned-by-dhcp.cox.net>
References: <11513991771758-git-send-email-normalperson@yhbt.net>
	<7vodwe8qbc.fsf@assigned-by-dhcp.cox.net>
	<20060627223226.GA10178@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 03:58:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvPJs-0002Qe-43
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 03:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWF1B6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 21:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWF1B6O
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 21:58:14 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:31191 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932693AbWF1B6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 21:58:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628015812.UMPA18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 21:58:12 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22765>

Eric Wong <normalperson@yhbt.net> writes:

>> Hmm.  Undecided.
>
> At this point, I think this is probably the best change to make.  There
> are many things that a user could do that an automated checker could
> miss, and there are also many things that it could be overchecking for.

Agreed to the latter part of the last sentence.  Undecided about
the rest and the implementation.

>
> -	    if (/^(?:[<>=]){7}/) {
> +	    if (/^[<>]{7} / || /^={7}$/) {
>
> I would also make this change, because I'm pretty certain 7 characters
> (and one space for [<>]) is standard for merge(1).  We already rely on
> that for rerere.

One of the things we might want is to use diff3 instead of merge
but I presume the latter is a thin wrapper around the former so
that would be OK.  I am however not enthused about the @unresolved
array approach.
