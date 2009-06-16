From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 15:22:53 -0500
Message-ID: <ewZ5ok_uS4Wg9yUHVY7a_6-lG5HI1Uq4csZRDyqCMDgtwGkWzQVNCw@cipher.nrlssc.navy.mil>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <20090616171531.GA17538@coredump.intra.peff.net> <RFQLUdKWnVWgwwX0qsqUhC-pl9v39aFOKMpTbbABiCEXczTo26fVow@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, John Bito <jwbito@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 22:24:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGfCH-0006hR-24
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 22:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758629AbZFPUXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 16:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757731AbZFPUXA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 16:23:00 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42946 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbZFPUXA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 16:23:00 -0400
Received: by mail.nrlssc.navy.mil id n5GKMrJY010412; Tue, 16 Jun 2009 15:22:54 -0500
In-Reply-To: <RFQLUdKWnVWgwwX0qsqUhC-pl9v39aFOKMpTbbABiCEXczTo26fVow@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 16 Jun 2009 20:22:53.0747 (UTC) FILETIME=[3A630830:01C9EEC0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121711>

Brandon Casey wrote:
> Jeff King wrote:
>> On Tue, Jun 16, 2009 at 09:51:24AM -0700, Junio C Hamano wrote:
>>
>>>> I can reproduce the problem on Solaris 8 using git v1.6.3. It seems to
>>>> be caused by a horribly slow system regex implementation; it really
>>>> chokes on the regex we use to find the "funcname" line for java files.
>>> Hmm.  Is running under LC_ALL=C LANG=C _with_ the slow system regex help?
>> No, it remains extremely slow (it is possible that it _is_ faster,
>> though, but I never managed to run either case to completion; they are
>> both clearly orders of magnitude off of acceptable).
> 
> I haven't tried setting LC_ALL, LANG, but this Solaris regex is MANY orders
> of magnitude slower.  I've been running your example diff on the egit
> repository for 2 hours and it still hasn't finished.  The compat/regex
> version finished in 3 seconds.  Solaris 10 x86.

Ok, I don't think this call is going to finish.  'git diff v0.4.0' on
Solaris 10 x86 using the native regex library.  It has been running now
for over 4.5 hours.

If you're interested in a data point from another non-gnu regex library,
I ran the same test on a mips IRIX6.5.  It took 19.5 secs, and this is
not a young machine.  It takes 4 secs when diff.java.xfuncname is set
to 'foo'.

-brandon
