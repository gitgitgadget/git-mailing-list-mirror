From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Thu, 27 Jul 2006 09:54:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607270947540.4168@g5.osdl.org>
References: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com> 
 <1154018302.13273.0.camel@dv> <b8bf37780607270943w562ec21fuab0eb882b3ccffeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-181268218-1154018895=:4168"
Cc: Pavel Roskin <proski@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 18:55:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G698V-0007DD-2U
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 18:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWG0Qy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 12:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWG0Qy4
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 12:54:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55186 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751756AbWG0Qyz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 12:54:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6RGs5nW011665
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Jul 2006 09:54:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6RGs2Nc009145;
	Thu, 27 Jul 2006 09:54:04 -0700
To: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
In-Reply-To: <b8bf37780607270943w562ec21fuab0eb882b3ccffeb@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.0607270948180.4168@g5.osdl.org>
X-Spam-Status: No, hits=-0.578 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24303>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-181268218-1154018895=:4168
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0607270948181.4168@g5.osdl.org>



On Thu, 27 Jul 2006, André Goddard Rosa wrote:
> > 
> > Please try git 1.4.1.1, it fixes git-clone.
> 
> Thank you so much, Pavel!
> 
> Downloading it right now!

The problem is that at least the timeout-fix is a server-side thing, it 
won't fix the client. So if a server is running the broken 1.4.1 release, 
it will time out the clients after 10 minutes. It wasn't obvious breakage, 
because most people do smaller fetches, and never even got close to that 
timeout (most of my connections tend to be in the seconds ;).

I asked Kees to upgrade kernel.org, but he's apparently busy at OSCON this 
week, so I'm bcc'ing the other admins here to ask them to upgrade to 
1.4.1.1. That won't fix the montavista site, though.

That said, I don't think the timeout problem should have caused a _stall_ 
of the connection, it should have caused an early EOF and thus a unpack 
error. 

		Linus
--21872808-181268218-1154018895=:4168--
