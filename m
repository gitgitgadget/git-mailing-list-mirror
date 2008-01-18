From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 18:28:03 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181638500.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1669967163-1200679158=:5731"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 19:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFvxK-0003Wu-5b
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 19:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760520AbYARS2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 13:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760566AbYARS2L
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 13:28:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:57465 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760520AbYARS2K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 13:28:10 -0500
Received: (qmail invoked by alias); 18 Jan 2008 18:28:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 18 Jan 2008 19:28:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gzQMh98RgvcfVoWmy5vNmTKgESARgdxLfHXVk7g
	xiXb5l1RwOmB2y
X-X-Sender: gene099@racer.site
In-Reply-To: <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
Content-ID: <alpine.LSU.1.00.0801181820460.5731@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71046>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1669967163-1200679158=:5731
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LSU.1.00.0801181820461.5731@racer.site>

Hi,

On Fri, 18 Jan 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Currently the ones I looked at and consider possible 1.5.4 material 
> > are http-push fixes from Grégoire Barbier and parse_commit_buffer() 
> > tightening from Martin Koegler.
> 
> It seems that for the past few days, people were having too much fun 
> bashing how broken MacOS X is, and the real work has stalled in the 
> meantime.  Well, not really stalled but they certainly made the patches 
> and discussions harder to find in the list archive.
> 
> [...]
>
> But there are still unapplied patches that deserve attention. The one 
> that I am most worried about is Grégoire Barbier's http-push changes:
> 
>   $gmane/70406 <1200250979-19604-1-git-send-email-gb@gbarbier.org>

This patch makes http-push Warn if URL does not end if "/", but it would 
be even better to just handle it... we know exactly that HTTP URLs _must_ 
end in a slash.

It gives a better warning if the URL cannot be accessed, alright.  But I 
hate the fact that it introduces yet another function which does a bunch 
of curl_easy_setopt()s only to start an active slot and check for errors.

Currently, I am not familiar enough with http-push.c to suggest a proper 
alternative, but I suspect that the return values of the _existing_ calls 
to curl should know precisely why the requests failed, and _this_ should 
be reported.

>   $gmane/70407 <1200250979-19604-2-git-send-email-gb@gbarbier.org>

I first could not reproduce the breakage described in the commit message 
(bad or no ref given on command line).

After playing around for a while, all of a sudden, I got a segmentation 
fault:

Waiting for 
http://dscho@127.0.0.1/test.git/objects/56/5e84516c1c6dca168be1715b45aeae70b24d13_36e8d912-4841-455a-bbd9-69e54d00db99
Segmentation fault (core dumped)

Unfortunately, this is with _and_ without this patch.

In gdb, it looks like this:

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread -1213430096 (LWP 31418)]
check_locks () at http-push.c:637
637                     if (!lock->refreshing && time_remaining < 
LOCK_REFRESH) {
(gdb) p lock
$1 = (struct remote_lock *) 0x20
(gdb) bt
#0  check_locks () at http-push.c:637
#1  0x08053f8a in process_response (callback_data=0x80c4550)
    at http-push.c:683
#2  0x0804dbf4 in process_curl_messages () at http.c:539
#3  0x0804dc46 in step_active_slots () at http.c:453
#4  0x0804dccb in run_active_slot (slot=0x80c2388) at http.c:474
#5  0x0804deaa in http_cleanup () at http.c:291
#6  0x0805268f in main (argc=3, argv=Cannot access memory at address 0x4
) at http-push.c:2428

So it seems that there is more to fix.

>   $gmane/70405 <1200250979-19604-3-git-send-email-gb@gbarbier.org>

This makes sense.  I only tried to compile http-push once without 
CURL_MULTI, and gave up (I think I even sent out a patch disabling 
CURL_MULTI for curl versions lacking a certain symbol).

Ciao,
Dscho

---1463811741-1669967163-1200679158=:5731--
