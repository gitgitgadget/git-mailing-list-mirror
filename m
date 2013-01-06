From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sat, 5 Jan 2013 23:22:25 -0500
Organization: PD Inc
Message-ID: <26EEC11FB94541828DC186379E8FFF82@black>
References: <2491041.bQ51Qu8HcA@thunderbird> <F09573B23A5F449BBB6364F4D84D077D@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 05:39:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tri1Z-0005LH-6j
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 05:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab3AFEje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 23:39:34 -0500
Received: from projects.pdinc.us ([67.90.184.26]:48049 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755292Ab3AFEjc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 23:39:32 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r064dRJl012359
	for <git@vger.kernel.org>; Sat, 5 Jan 2013 23:39:27 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <F09573B23A5F449BBB6364F4D84D077D@black>
Thread-Index: Ac3rvLEGg1ZKBSr1StegkwR+8mhHwgAAjpkgAAGC6oA=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212749>


> -----Original Message-----
> From: Jason Pyeron
> Sent: Saturday, January 05, 2013 22:38
> 
> 
> > Stephen & Linda Smith
> > Sent: Saturday, January 05, 2013 21:05
> > 
> >  Commit 9fca6cffc05321445b59c91e8f8d308f41588b53 message 
> states that  
> > the macro was being renamed for clarity. The patch also changes a 
> > define.
> 
> Was it the commit before 
> 9fca6cffc05321445b59c91e8f8d308f41588b53 that compiles or was 
> it 9fca6cffc05321445b59c91e8f8d308f41588b53 that compiled? I 
> am doing a cygwin update presently to look at it.
> 
> > 
> > This change causes the code to not compile on cygwin 1.7.14.
> > 
> >  I narrowed the problem to this patch by bisecting commits between 
> > v1.8.0 and
> > 1.8.1
> > 
> > Here is the error sequence:

Cannot reproduce on head and current cygwin, more details please.

> > 
> >     CC compat/cygwin.o
> > In file included from compat/../git-compat-util.h:90,
> >                  from compat/cygwin.c:9:
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:103:2: 
> > warning: #warning "fd_set and associated macros have been 
> > defined in sys/types.      
> > This may cause runtime problems with W32 sockets"
> > In file included from /usr/include/sys/socket.h:16,
> >                  from compat/../git-compat-util.h:131,
> >                  from compat/cygwin.c:9:
> > /usr/include/cygwin/socket.h:29: error: redefinition of `struct 
> > sockaddr'
> > /usr/include/cygwin/socket.h:41: error: redefinition of `struct 
> > sockaddr_storage'
> > In file included from /usr/include/sys/socket.h:16,
> >                  from compat/../git-compat-util.h:131,
> >                  from compat/cygwin.c:9:
> > /usr/include/cygwin/socket.h:59: error: redefinition of `struct 
> > linger'
> > In file included from compat/../git-compat-util.h:131,
> >                  from compat/cygwin.c:9:
> > /usr/include/sys/socket.h:30: error: conflicting types for 'accept'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:536: 
> > error: previous declaration of 'accept' was here
> > /usr/include/sys/socket.h:30: error: conflicting types for 'accept'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:536: 


jpyeron@porsche /projects/git/git
$ make && uname -a && git status && git log --oneline | head -n1
    GEN perl/PM.stamp
    SUBDIR gitweb
    SUBDIR ../
make[2]: `GIT-VERSION-FILE' is up to date.
    GEN git-instaweb
    BUILTIN all
    SUBDIR git-gui
    SUBDIR gitk-git
make[1]: Nothing to be done for `all'.
    SUBDIR perl
    SUBDIR git_remote_helpers
    SUBDIR templates
CYGWIN_NT-5.2-WOW64 porsche 1.7.17(0.262/5/3) 2012-10-19 14:39 i686 Cygwin
# On branch master
nothing to commit (working directory clean)
3e293fb Update draft release notes to 1.8.2



> > error: previous declaration of 'accept' was here
> > /usr/include/sys/socket.h:32: error: conflicting types for 'bind'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:537: 
> > error: previous declaration of 'bind' was here
> > /usr/include/sys/socket.h:32: error: conflicting types for 'bind'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:537: 
> > error: previous declaration of 'bind' was here
> > /usr/include/sys/socket.h:33: error: conflicting types for 'connect'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:539: 
> > error: previous declaration of 'connect' was here
> > /usr/include/sys/socket.h:33: error: conflicting types for 'connect'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:539: 
> > error: previous declaration of 'connect' was here
> > /usr/include/sys/socket.h:34: error: conflicting types for 
> > 'getpeername'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:541: 
> > error: previous declaration of 'getpeername' was here
> > /usr/include/sys/socket.h:34: error: conflicting types for 
> > 'getpeername'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:541: 
> > error: previous declaration of 'getpeername' was here
> > /usr/include/sys/socket.h:35: error: conflicting types for 
> > 'getsockname'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:542: 
> > error: previous declaration of 'getsockname' was here
> > /usr/include/sys/socket.h:35: error: conflicting types for 
> > 'getsockname'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:542: 
> > error: previous declaration of 'getsockname' was here
> > /usr/include/sys/socket.h:36: error: conflicting types for 'listen'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:546: 
> > error: previous declaration of 'listen' was here
> > /usr/include/sys/socket.h:36: error: conflicting types for 'listen'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:546: 
> > error: previous declaration of 'listen' was here
> > /usr/include/sys/socket.h:37: error: conflicting types for 'recv'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:547: 
> > error: previous declaration of 'recv' was here
> > /usr/include/sys/socket.h:37: error: conflicting types for 'recv'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:547: 
> > error: previous declaration of 'recv' was here
> > /usr/include/sys/socket.h:39: error: conflicting types for 
> 'recvfrom'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:548: 
> > error: previous declaration of 'recvfrom' was here
> > /usr/include/sys/socket.h:39: error: conflicting types for 
> 'recvfrom'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:548: 
> > error: previous declaration of 'recvfrom' was here
> > /usr/include/sys/socket.h:41: error: conflicting types for 'send'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:549: 
> > error: previous declaration of 'send' was here
> > /usr/include/sys/socket.h:41: error: conflicting types for 'send'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:549: 
> > error: previous declaration of 'send' was here
> > /usr/include/sys/socket.h:44: error: conflicting types for 'sendto'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:550: 
> > error: previous declaration of 'sendto' was here
> > /usr/include/sys/socket.h:44: error: conflicting types for 'sendto'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:550: 
> > error: previous declaration of 'sendto' was here
> > /usr/include/sys/socket.h:46: error: conflicting types for 
> > 'setsockopt'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:551: 
> > error: previous declaration of 'setsockopt' was here
> > /usr/include/sys/socket.h:46: error: conflicting types for 
> > 'setsockopt'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:551: 
> > error: previous declaration of 'setsockopt' was here
> > /usr/include/sys/socket.h:48: error: conflicting types for 
> > 'getsockopt'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:543: 
> > error: previous declaration of 'getsockopt' was here
> > /usr/include/sys/socket.h:48: error: conflicting types for 
> > 'getsockopt'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:543: 
> > error: previous declaration of 'getsockopt' was here
> > /usr/include/sys/socket.h:49: error: conflicting types for 
> 'shutdown'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:552: 
> > error: previous declaration of 'shutdown' was here
> > /usr/include/sys/socket.h:49: error: conflicting types for 
> 'shutdown'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:552: 
> > error: previous declaration of 'shutdown' was here
> > /usr/include/sys/socket.h:50: error: conflicting types for 'socket'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:553: 
> > error: previous declaration of 'socket' was here
> > /usr/include/sys/socket.h:50: error: conflicting types for 'socket'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:553: 
> > error: previous declaration of 'socket' was here
> > /usr/include/sys/socket.h:53: error: conflicting types for 
> > 'getservbyname'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:557: 
> > error: previous declaration of 'getservbyname' was here
> > /usr/include/sys/socket.h:53: error: conflicting types for 
> > 'getservbyname'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:557: 
> > error: previous declaration of 'getservbyname' was here In file 
> > included from compat/../git-compat-util.h:135,
> >                  from compat/cygwin.c:9:
> > /usr/include/sys/select.h:31: error: conflicting types for 'select'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:632: 
> > error: previous declaration of 'select' was here
> > /usr/include/sys/select.h:31: error: conflicting types for 'select'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:632: 
> > error: previous declaration of 'select' was here In file 
> included from 
> > /usr/include/netinet/in.h:14,
> >                  from compat/../git-compat-util.h:137,
> >                  from compat/cygwin.c:9:
> > /usr/include/cygwin/in.h:30: error: parse error before numeric 
> > constant
> > /usr/include/cygwin/in.h:35: error: parse error before numeric 
> > constant
> > /usr/include/cygwin/in.h:37: error: parse error before numeric 
> > constant
> > /usr/include/cygwin/in.h:76: error: parse error before numeric 
> > constant
> > /usr/include/cygwin/in.h:115: error: redefinition of 
> `struct in_addr'
> > /usr/include/cygwin/in.h:116: error: parse error before '.' token
> > /usr/include/cygwin/in.h:184: error: redefinition of `struct 
> > sockaddr_in'
> > In file included from /usr/include/cygwin/in.h:250,
> >                  from /usr/include/netinet/in.h:14,
> >                  from compat/../git-compat-util.h:137,
> >                  from compat/cygwin.c:9:
> > /usr/include/asm/byteorder.h:26: error: conflicting types 
> for 'ntohl'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:629: 
> > error: previous declaration of 'ntohl' was here
> > /usr/include/asm/byteorder.h:26: error: conflicting types 
> for 'ntohl'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:629: 
> > error: previous declaration of 'ntohl' was here
> > /usr/include/asm/byteorder.h:27: error: conflicting types 
> for 'ntohs'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:631: 
> > error: previous declaration of 'ntohs' was here
> > /usr/include/asm/byteorder.h:27: error: conflicting types 
> for 'ntohs'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:631: 
> > error: previous declaration of 'ntohs' was here
> > /usr/include/asm/byteorder.h:28: error: conflicting types 
> for 'htonl'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:628: 
> > error: previous declaration of 'htonl' was here
> > /usr/include/asm/byteorder.h:28: error: conflicting types 
> for 'htonl'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:628: 
> > error: previous declaration of 'htonl' was here
> > /usr/include/asm/byteorder.h:29: error: conflicting types 
> for 'htons'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:630: 
> > error: previous declaration of 'htons' was here
> > /usr/include/asm/byteorder.h:29: error: conflicting types 
> for 'htons'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:630: 
> > error: previous declaration of 'htons' was here In file 
> included from 
> > compat/../git-compat-util.h:139,
> >                  from compat/cygwin.c:9:
> > /usr/include/arpa/inet.h:22: error: conflicting types for 
> 'inet_addr'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:544: 
> > error: previous declaration of 'inet_addr' was here
> > /usr/include/arpa/inet.h:22: error: conflicting types for 
> 'inet_addr'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:544: 
> > error: previous declaration of 'inet_addr' was here
> > /usr/include/arpa/inet.h:28: error: conflicting types for 
> 'inet_ntoa'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:545: 
> > error: previous declaration of 'inet_ntoa' was here
> > /usr/include/arpa/inet.h:28: error: conflicting types for 
> 'inet_ntoa'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:545: 
> > error: previous declaration of 'inet_ntoa' was here In file 
> included 
> > from compat/../git-compat-util.h:140,
> >                  from compat/cygwin.c:9:
> > /usr/include/netdb.h:79: error: redefinition of `struct hostent'
> > /usr/include/netdb.h:93: error: redefinition of `struct netent'
> > /usr/include/netdb.h:100: error: redefinition of `struct servent'
> > /usr/include/netdb.h:108: error: redefinition of `struct protoent'
> > /usr/include/netdb.h:139: error: conflicting types for 
> > 'WSAGetLastError'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:594: 
> > error: previous declaration of 'WSAGetLastError' was here
> > /usr/include/netdb.h:139: error: conflicting types for 
> > 'WSAGetLastError'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:594: 
> > error: previous declaration of 'WSAGetLastError' was here
> > /usr/include/netdb.h:192: error: conflicting types for 
> 'gethostbyaddr'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:554: 
> > error: previous declaration of 'gethostbyaddr' was here
> > /usr/include/netdb.h:192: error: conflicting types for 
> 'gethostbyaddr'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:554: 
> > error: previous declaration of 'gethostbyaddr' was here
> > /usr/include/netdb.h:193: error: conflicting types for 
> 'gethostbyname'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:555: 
> > error: previous declaration of 'gethostbyname' was here
> > /usr/include/netdb.h:193: error: conflicting types for 
> 'gethostbyname'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:555: 
> > error: previous declaration of 'gethostbyname' was here
> > /usr/include/netdb.h:199: error: conflicting types for 
> > 'getprotobyname'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:559: 
> > error: previous declaration of 'getprotobyname' was here
> > /usr/include/netdb.h:199: error: conflicting types for 
> > 'getprotobyname'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:559: 
> > error: previous declaration of 'getprotobyname' was here
> > /usr/include/netdb.h:200: error: conflicting types for 
> > 'getprotobynumber'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:558: 
> > error: previous declaration of 'getprotobynumber' was here
> > /usr/include/netdb.h:200: error: conflicting types for 
> > 'getprotobynumber'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:558: 
> > error: previous declaration of 'getprotobynumber' was here
> > /usr/include/netdb.h:203: error: conflicting types for 
> 'getservbyport'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:556: 
> > error: previous declaration of 'getservbyport' was here
> > /usr/include/netdb.h:203: error: conflicting types for 
> 'getservbyport'
> > /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/w
> insock2.h:556: 
> > error: previous declaration of 'getservbyport' was here
> > Makefile:2384: recipe for target `compat/cygwin.o' failed
> > make: *** [compat/cygwin.o] Error 1
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> git" in the 
> > body of a message to majordomo@vger.kernel.org More 
> majordomo info at  
> > http://vger.kernel.org/majordomo-info.html
> > 

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
