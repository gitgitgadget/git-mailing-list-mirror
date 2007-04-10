From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 13:56:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101338060.6730@woody.linux-foundation.org>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
 <20070410132011.GH5436@spearce.org> <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 06:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbNOY-0006w0-CF
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 22:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030660AbXDJU4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 16:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933145AbXDJU4v
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 16:56:51 -0400
Received: from smtp.osdl.org ([65.172.181.24]:45080 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932234AbXDJU4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 16:56:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AKudVZ011184
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 13:56:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AKubP1017130;
	Tue, 10 Apr 2007 13:56:38 -0700
In-Reply-To: <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44179>



On Tue, 10 Apr 2007, Junio C Hamano wrote:
> 
> One thing that people need to be careful about is which SMTP
> server they use.

ABSOLUTELY!

There are a ton of spam blockers that simply *refuse* to accept email from 
people who just randomly send to port 25. 

For example, I will personally never see email that comes directly to my 
email address though an open mail relay *or* from something that appears 
to be just a random botnet PC (I forget the exact rule, since I'm hapily 
ignorant of MIS, but I think it boils down to requiring a good reverse DNS 
lookup).

That's getting much more common. Most spam is done through botnets, and 
they still try to do the direct-to-port-25 thing, exactly because if you 
go through a *real* SMTP host, your ISP will generally shut you down 
pretty quickly if you're spamming.

So special spammers with their own machines will work with ISP's that 
don't care (they make money off the spammers), but botnets depend on 
cracked Windows machines, and those often have ISP's that *do* care, 
because they get complaints and it costs them money if they don't.

> I had an impression (I do not use send-email myself) that it defaulted 
> to local MTA, so the mail trail would look like your local MTA receives 
> from the MUA (which is send-email), which forwards it to whereever 
> destination (or intermediaries).

A lot of people configure their MUA to send specially, and never even 
configure their MTA at all apart from whatever default configuration it 
has.

For example, I may have sendmail installed on my machine, but its only 
purpose in life is to do *local* email delivery (using fetchmail -> 
sendmail). It wouldn't know how to send an email outside of the machine.

Instead, my MUA is configured to do this:

	# List of SMTP servers for sending mail. If blank: Unix Pine uses sendmail.
	smtp-server=localhost:10025

where localhost port 10025 is just a ssh tunnel to inside the osdl 
network. If I tried to send email any other way, people would often not 
accept it, because various SMTP servers will simply *refuse* to forward 
emails that claim to be coming from a point that isn't somethign that they 
actually *receive* email for.

And I don't think my setup is at all unusual. I may be unusual in my 
choice of MUA, but most MUA's will have configuration for where to send 
the mail, and I think very few people actually configure sendmail to do it 
right.

So no, I don't think people should assume that "sendmail" magically knows 
how to send emails other than to the local machine (ie use it to send 
problem reports to "root", or let fetchmail deliver to it for local 
emails, but that's about it)

			Linus
