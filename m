From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 18:45:19 -0400
Message-ID: <BAYC1-PASMTP124D39CDBCFC35738102D0AEA90@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	<BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
	<BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
	<e3p5om$djs$1@sea.gmane.org>
	<Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
	<BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
	<BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
	<7vu07y252m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, junkio@cox.net, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 00:50:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdb2H-00075G-QO
	for gcvg-git@gmane.org; Wed, 10 May 2006 00:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWEIWub (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 18:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWEIWub
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 18:50:31 -0400
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:7758 "EHLO
	BAYC1-PASMTP12.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751328AbWEIWua (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 18:50:30 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP12.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 May 2006 15:57:36 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 95F5D644C28;
	Tue,  9 May 2006 18:50:28 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060509184519.5a707231.seanlkml@sympatico.ca>
In-Reply-To: <7vu07y252m.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 May 2006 22:57:36.0968 (UTC) FILETIME=[F72DA480:01C673BB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 09 May 2006 15:42:25 -0700
Junio C Hamano <junkio@cox.net> wrote:

> sean <seanlkml@sympatico.ca> writes:
> 
> > The syntax is:
> >
> >   [<random string>]
> 
> Does this mean you can have anything other than LF and ']'?

Anything but LF; how's this for ugly:

    ["hello Worl\]d \\backslash]

> > Here's how your example would look in this style:
> >
> >   [email.torvalds@osdl.org]
> >         name = Linus Torvalds
> 
> How does a program (not a script, but git_config() users) get
> that value and parse it?  

The same way they do now.  For instance git-repo-config processes
the config file using the same get_config() + callback as usual.  The
only issue is that they should no longer cast everything to lower first.

Sean
