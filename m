From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 03:11:42 -0700
Message-ID: <20060515101142.GD6855@localdomain>
References: <1147660345772-git-send-email-normalperson@yhbt.net> <7vpsifx2b7.fsf@assigned-by-dhcp.cox.net> <20060515092704.GB6855@localdomain> <7vmzdjtya4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 15 12:12:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffa3I-0006Ee-3r
	for gcvg-git@gmane.org; Mon, 15 May 2006 12:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWEOKLp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 06:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWEOKLp
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 06:11:45 -0400
Received: from hand.yhbt.net ([66.150.188.102]:27555 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932332AbWEOKLo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 06:11:44 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6F1017DC005;
	Mon, 15 May 2006 03:11:42 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 May 2006 03:11:42 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzdjtya4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20044>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > I believe this is what Martin wanted.  I think it's a good idea since
> > sendmail binaries tend to be more flexible, but I'm ok with it either
> > way.
> 
> I am not opposed to have an option to run a local submission
> agent binary (I said I like that if(){}else{} there, didn't I?).
> The ability to do so is a good thing.  I am not however sure
> about changing the default when no option is specified on the
> command line.

By "I believe this is what Martin wanted", I meant changing the default to
sendmail: <46a038f90604271804j195d62f3x93ae816e809f4ffd@mail.gmail.com>

	> Oh, it should just work with sendmail if it's there and we don't
	> provide --smtp-server ;-)

> >> > +	if ($smtp_server =~ m#^/#) {
> >> 
> >> I like this if(){}else{} here, but have a feeling that the
> >> logging part should be placed outside it to be shared.
> >
> > Cleaned that up a bit, patch coming.  Also removed the Port: printout
> > completely, as it's rather redundant (see below).
> >
> >> While we are at it, we might want to enhance $smtp_server parsing
> >> to take host:port notation so that people can use message
> >> submission port 587/tcp (RFC 4409) instead.
> >
> > This already works, IO::Socket::INET (behind Net::SMTP) takes care of
> > it :)
> 
> Thanks.  Maybe the next option would be delivery to a file (or
> even SMTP batch)? ;-)

Sure :)  Authentication and SSL may be worth looking into, though.  I'm
pretty content these days with my autossh tunnel to my mail server,
though.

-- 
Eric Wong
