From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 19:43:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311938130.7301@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl>
 <20060130225107.GA3857@limbo.home> <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
 <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
 <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org> <7v64nzollt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 04:43:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F48tr-0004BJ-U3
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 04:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWBADnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 22:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWBADnR
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 22:43:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030226AbWBADnQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 22:43:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k113hCDZ025251
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 19:43:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k113hCUK016796;
	Tue, 31 Jan 2006 19:43:12 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64nzollt.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15381>



On Tue, 31 Jan 2006, Junio C Hamano wrote:
> 
> I think this should work fine as a mechanism, but I am a bit
> worried about the convenience and safety aspect.  It _might_
> make sense to do what RCS does; check out read-only copy by
> default and set the "assume unchanged" flag, to prevent people
> from accidentally modifying the working tree copy without
> telling the index about it.

Yes, I think the "assume unchanged" flag goes well together with making 
sure that the checked-out file is non-writable at the time.

Of course, any number of editors and other actions won't care: if you do 
anything like

	for i in *.c
	do
		sed 's/xyzzy/bas/g' < $i > $i.new
		mv $i.new $i
	done

you'll never have even noticed that the old file was marked read-only. So 
it's obviously not in any way any guarantee, but it probably makes sense 
as a crutch.

Your point that we discussed a similar flag for the "don't require a full 
checkout" is a good one: we should try to make sure that it works for both 
uses. Although maybe we decided for some reason that nobody cared about 
the non-checked-out case?

		Linus
