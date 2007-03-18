From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sun, 18 Mar 2007 05:30:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703180517360.24626@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172228220.18328@xanadu.home>
 <Pine.LNX.4.64.0703172013340.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810304-641417155-1174195801=:24626"
Cc: Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 06:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSny5-0004aD-7M
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 06:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXCRFaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 01:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbXCRFaH
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 01:30:07 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:55923 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751034AbXCRFaF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2007 01:30:05 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id A9941C61CF
	for <git@vger.kernel.org>; Sun, 18 Mar 2007 05:30:02 +0000 (GMT)
Received: (qmail 31277 invoked by uid 103); 18 Mar 2007 05:30:02 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2861. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.037143 secs); 18 Mar 2007 05:30:02 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 18 Mar 2007 05:30:01 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0703172013340.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42475>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810304-641417155-1174195801=:24626
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Sat, 17 Mar 2007, Linus Torvalds wrote:

> On Sat, 17 Mar 2007, Nicolas Pitre wrote:
>>
>> Sure.  But at this point the reference to compare GIT performance
>> against might be GIT itself.  And while 1 second is really nice in this
>> case, there are some repos where it could be (and has already been
>> reported to be) much more.
>
> I'd still like to see the KDE repo, that thing went quiet after it was
> supposed to hit sneaker-net..
>
> If it was 30 seconds before to do a "git log" for some individual file,
> after the recent optimizations it should hopefully be down to 10. And I
> agree that I might be more motivated to try to get it down further if I
> could just find a repository where it's that much.

In my test repository (which emulates a real repository in terms of 
approximate size in terms of commits, branches and tags) "git log f12000" 
takes about 15m (using 1.5.0.4).  After applying patches 1/2 and 2/2 on 
top of master I get ~3m50s.  With 3/2 as well it goes down a bit more to 
~3m20s.

I've attached the script that generated the repository in case you feel 
the urge to try some move time shaving exercises ... ;)

(This is a rather unrealistic repository consisting of a long series of 
commits of new binary files, but I don't have access to the repository 
that is being approximated until I get back to work on Monday ...)

-- 
Julian

  ---
That must be wonderful: I don't understand it at all.
 		-- Moliere
---1463810304-641417155-1174195801=:24626
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=mk_large_repo
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0703180530010.24626@beast.quantumfyre.co.uk>
Content-Description: mk_large_repo
Content-Disposition: attachment; filename=mk_large_repo

IyEvYmluL2Jhc2gNCg0KIyBuby4gb2YgY29tbWl0cyBicmFuY2hlcyBhbmQg
dGFncyB0byBtYWtlDQpjb21taXRzPTI1MDAwOw0KYnJhbmNoZXM9OTAwOw0K
dGFncz04MDAwOw0KDQojIGNyZWF0ZSBhIG5ldyBmaWxlIG9mIHRoaXMgc2l6
ZSAoa2IpIGZvciBlYWNoIGNvbW1pdA0KY29tbWl0X3NpemU9MTAyOw0KYnM9
MTAyNDsNCg0KbGFyZ2U9JDE7DQoNCigoYmcgPSAkY29tbWl0cyAvICRicmFu
Y2hlcykpOw0KKCh0ZyA9ICRjb21taXRzIC8gJHRhZ3MpKTsNCg0KZWNobyAi
Y3JlYXRpbmcgJGxhcmdlIjsNCm1rZGlyICRsYXJnZTsNCmNkICRsYXJnZTsN
Cg0KZ2l0IGluaXQtZGI7DQoNCmk9MA0Kd2hpbGUgWyAkaSAtbHQgJGNvbW1p
dHMgXTsgZG8NCiAgZGQgaWY9L2Rldi91cmFuZG9tIG9mPWYkaSBicz0ke2Jz
fSBjb3VudD0ke2NvbW1pdF9zaXplfSA+IC9kZXYvbnVsbCAyPiYxDQoNCiAg
Z2l0IGFkZCBmJGk7DQogIGdpdCBjb21taXQgLW0gImFkZCB0JGkiOw0KDQog
ICgoaWcgPSAkaSAlICR0ZykpOw0KICBpZiBbICRpZyAtZXEgMCBdOyB0aGVu
DQogICAgZ2l0IHRhZyB0JGk7DQogICAgZWNobyAtbiAidCI7DQogIGZpDQoN
CiAgKChpZyA9ICRpICUgJGJnKSk7DQogIGlmIFsgJGlnIC1lcSAwIF07IHRo
ZW4NCiAgICBnaXQgYnJhbmNoIGIkaTsNCiAgICBlY2hvIC1uICJiIjsNCiAg
ZmkNCg0KICBlY2hvIC1uICIkaSAiOw0KICAoKGkgPSAkaSArIDEpKQ0KZG9u
ZQ0KDQplY2hvOw0KZWNobyAiY29tcGxldGUuIjsNCg0K

---1463810304-641417155-1174195801=:24626--
