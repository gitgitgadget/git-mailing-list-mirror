From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 13:57:59 -0700
Message-ID: <59946C4A-CFA4-430E-BF90-A90A445EAB9E@cs.indiana.edu>
References: <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828204418.GY10360@machine.or.cz>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeff King <peff@peff.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:01:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYocQ-0003Cz-HJ
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492AbYH1VAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757802AbYH1VAL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:00:11 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:53965 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756956AbYH1VAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:00:09 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SKw6XZ003506;
	Thu, 28 Aug 2008 16:58:07 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SKw03p008856
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 16:58:04 -0400
In-Reply-To: <20080828204418.GY10360@machine.or.cz>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94148>


On Aug 28, 2008, at 1:44 PM, Petr Baudis wrote:

> On Thu, Aug 28, 2008 at 01:23:50PM -0700, Perry Wagle wrote:
>>
>> On Aug 28, 2008, at 12:52 PM, Teemu Likonen wrote:
>>
>>> I have come to understand that "git " has quite long time been more
>>> robust and portable way of writing scripts. They work in both
>>> configurations so I'd definitely suggest doing "s/git-/git /g" for  
>>> every
>>> script. Of course in an interactive shell everyone can use  
>>> whatever they
>>> prefer and works at the moment.
>>
>> Sure.  Its an extra fork in git command intensive scripts (and git  
>> is racey
>> still maybe), but *shrug*.
>
> Do you have any details on the races in Git you know about?

Sorry, I should have just left that line out.  But I didn't, so:

Fall of 2007, I'd get spurious reports that the working dir was  
inconsistent when iterating through 612 commits in a script (I was  
converting from quilt/cvs to git) when it wasn't.  I got around most  
of this by sprinkling the script with git-status and git update-index  
--refresh.  My understanding was that it really was the one-second  
granularity of the timestamps on my file system doing it, so nothing  
for me to do at the time.

However, it was really bugging people, so I figured by this time  
someone had found a clever way to fix it, hence the "maybe".

I haven't tried it for a while.

> This does not mean an extra fork, only extra exec. In case of builtin
> commands (which is actually a large majority by now), not even that.

Yeah, I should have deleted that line. 8)


>> Even as of March 2008 (our last sync with git before the git  
>> scripting was
>> completed and we got on to other things), the sample scripts and  
>> gitweb
>> still used the git<DASH> form.  If this has been brewing for two  
>> years,
>> there shouldn't have been a git<DASH> form in the scripts in the  
>> standard
>> source *anywhere* for those two years.
>
> I agree that this is a problem. Even now, the documentation is using
> git- at plenty of places. Patches are welcome, I'm sure.

Heh.

-- Perry
