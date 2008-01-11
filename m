From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 19:29:07 +0100
Message-ID: <14E7B5D5-B1B8-4532-A471-106B14B912B8@zib.de>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org> <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de> <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org> <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de> <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDOd2-0000xT-Dj
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144AbYAKS2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757168AbYAKS2s
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:28:48 -0500
Received: from mailer.zib.de ([130.73.108.11]:48387 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934AbYAKS2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 13:28:47 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0BISCbS021894;
	Fri, 11 Jan 2008 19:28:17 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0BISB00016891
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Jan 2008 19:28:12 +0100 (MET)
In-Reply-To: <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70184>


On Jan 11, 2008, at 7:10 PM, Linus Torvalds wrote:

>
>
> On Fri, 11 Jan 2008, Steffen Prohaska wrote:
>>
>> Ah sorry, I misunderstood you in [1].  I thought your last point
>> "Mixed Windows usage" meant what I have in mind:  A user working
>> in a mixed Windows/Unix environment who creates a file using
>> Windows tools and commits it in the Unix environment.  In this
>> case the CRLF file will be transferred from Windows to Unix
>> without git being involved.  The right thing for git on Unix is
>> to remove CRLF during a commit but still write only LF during
>> check out.  So autocrlf=input is the right choice.
>
> Oh, ok, I didn't realize.
>
> But yes, if you use a network share across windows and Unixand  
> actually
> *share* the working tree over it, then yes, you'd want  
> "autocrlf=input" on
> the unix side.
>
> However, I think that falls under the "0.1%" case, not the "99.9%"  
> case.
>
> I realize that people probably do that more often with centralized
> systems, but with a distributed thing, it probably makes a *ton* more
> sense to have separate trees. But I could kind of see having a shared
> development directory and accessing it from different types of  
> machines
> too.

It just happens yesterday that I copied a file from Unix to Windows
(lucky I am ;) for a quite simple reason.  I fetched and merged and
realized that another developer forgot to check in a new file. He
had already left.  So I just looked into his workspace and copied
the file.  This has nothing to do with centralized system or not.
We're just working in a mixed OS environment with shared filesystems.

I didn't even think about the line endings in this situation because
everything just worked.  Actually I like the idea that I do not
need to think about the endings because git will care about them.
Actually many other tools work well with CRLF.  For example, vi
just displays [dos] in its status bar; but besides this everything
is just fine.


> I'd also bet that crlf behavior of git itself will be the *least*  
> of your
> problems in that situation. You'd have all the *other* tools to worry
> about, and would probably be very aware indeed of any CRLF issues.  
> So  at
> that point, the "automatic" or default behaviour is probably not a big
> deal, because everything _else_ you do likely needs special effort  
> too!

I don't think so.  In the setting I described above, the questions I  
receive
are not about the other tools but about git.  I already started to teach
everyone the new "autocrlf=input" policy to avoid these questions.  I  
don't
care that much about potential file corruption (though I'd feel more
comfortable if I knew git would have stronger guarantees).  During  
the next
checkout on Windows file corruption would happen anyway.

	Steffen
