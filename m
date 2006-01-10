From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 21:15:36 +0100
Message-ID: <20060110201536.GA3155@steel.home>
References: <1136849678.11717.514.camel@brick.watson.ibm.com> <1136849810.11717.518.camel@brick.watson.ibm.com> <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net> <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se> <1136910406.11717.579.camel@brick.watson.ibm.com> <43C4075E.4070407@op5.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Ostrowski <mostrows@watson.ibm.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 21:15:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwPuM-0006LK-Ik
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 21:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWAJUPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 15:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWAJUPv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 15:15:51 -0500
Received: from devrace.com ([198.63.210.113]:43791 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932555AbWAJUPv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 15:15:51 -0500
Received: from tigra.home (p54A06FF2.dip.t-dialin.net [84.160.111.242])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0AKFc32021226;
	Tue, 10 Jan 2006 14:15:39 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EwPu5-0005Om-00; Tue, 10 Jan 2006 21:15:37 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EwPu4-00052J-Tz; Tue, 10 Jan 2006 21:15:36 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43C4075E.4070407@op5.se>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14445>

Andreas Ericsson, Tue, Jan 10, 2006 20:13:34 +0100:
> >My shell's rc-file doesn't get invoked when using ssh as a transport;
> >that's part of the problem.
> 
> It does for me and everybody else. $HOME/.bashrc is read even for 
> non-interactive shells. ...

Not really:

$ man bash

       When bash is started non-interactively, to  run  a  shell  script,  for
       example, it looks for the variable BASH_ENV in the environment, expands
       its value if it appears there, and uses the expanded value as the  name
       of  a  file to read and execute.  Bash behaves as if the following com-
       mand were executed:
              if [ -n "$BASH_ENV" ]; then . "$BASH_ENV"; fi
       but the value of the PATH variable is not used to search for  the  file
       name.

$ ssh host2 strace -e open bash -c :
open("/etc/ld.so.cache", O_RDONLY)      = 3
open("/lib/libncurses.so.5", O_RDONLY)  = 3
open("/lib/tls/libdl.so.2", O_RDONLY)   = 3
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
open("/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = -1 ENXIO (No such device or address)
open("/etc/mtab", O_RDONLY)             = 3
open("/proc/meminfo", O_RDONLY)         = 3
open("/proc/sys/kernel/ngroups_max", O_RDONLY) = 3
