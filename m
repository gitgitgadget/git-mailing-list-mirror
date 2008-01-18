From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 18:36:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181832180.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801181638500.5731@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-451027681-1200681408=:5731"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 19:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFw5j-0007RS-G8
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 19:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763151AbYARSg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 13:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761257AbYARSg4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 13:36:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:40614 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763151AbYARSgy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 13:36:54 -0500
Received: (qmail invoked by alias); 18 Jan 2008 18:36:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 18 Jan 2008 19:36:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188p/FbKMQ8P7B3WdueJio2atk6VlgQBVhLf6de8f
	2KFl8nib0IATRM
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0801181638500.5731@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71048>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-451027681-1200681408=:5731
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 18 Jan 2008, Johannes Schindelin wrote:

> >   $gmane/70407 <1200250979-19604-2-git-send-email-gb@gbarbier.org>
> 
> I first could not reproduce the breakage described in the commit message 
> (bad or no ref given on command line).
> 
> After playing around for a while, all of a sudden, I got a segmentation 
> fault:
> 
> Waiting for 
> http://dscho@127.0.0.1/test.git/objects/56/5e84516c1c6dca168be1715b45aeae70b24d13_36e8d912-4841-455a-bbd9-69e54d00db99
> Segmentation fault (core dumped)
> 
> Unfortunately, this is with _and_ without this patch.
>
> 
> In gdb, it looks like this:
> 
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread -1213430096 (LWP 31418)]
> check_locks () at http-push.c:637
> 637                     if (!lock->refreshing && time_remaining < 
> LOCK_REFRESH) {
> (gdb) p lock
> $1 = (struct remote_lock *) 0x20
> (gdb) bt
> #0  check_locks () at http-push.c:637
> #1  0x08053f8a in process_response (callback_data=0x80c4550)
>     at http-push.c:683
> #2  0x0804dbf4 in process_curl_messages () at http.c:539
> #3  0x0804dc46 in step_active_slots () at http.c:453
> #4  0x0804dccb in run_active_slot (slot=0x80c2388) at http.c:474
> #5  0x0804deaa in http_cleanup () at http.c:291
> #6  0x0805268f in main (argc=3, argv=Cannot access memory at address 0x4
> ) at http-push.c:2428
> 
> So it seems that there is more to fix.

The segmentation fault occurs due to check_locks() accessing the remote 
that was just free()d, due to the new change.

But now I cannot even reproduce the segmentation fault, it seems.  
Strange.  Very strange.

Grégoire, it would help tremendously if you could come up with a test 
case.  The description you gave did not lead to something reproducible 
here.

Ciao,
Dscho

---1463811741-451027681-1200681408=:5731--
