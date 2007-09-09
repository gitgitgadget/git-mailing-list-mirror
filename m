From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sun, 09 Sep 2007 02:25:35 +0200
Message-ID: <46E33D7F.6040501@op5.se>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <fbr2iv$ugg$1@sea.gmane.org> <46E11CE1.4030209@op5.se> <fbs8es$1cd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUION-0003wm-K3
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:43 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAdp-0004hi-BK
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:27:09 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAdj-0006Os-TI
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbXIIAZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbXIIAZl
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:25:41 -0400
Received: from mail.op5.se ([193.201.96.20]:43633 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbXIIAZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:25:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4B897194428;
	Sun,  9 Sep 2007 02:25:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzdwKywveJQz; Sun,  9 Sep 2007 02:25:37 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id C9D03194390;
	Sun,  9 Sep 2007 02:25:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <fbs8es$1cd$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.7, required=12.0, autolearn=disabled, AWL=0.300,UIO_VGER=-3)
X-UiO-Scanned: 7555C4C95E045E95C649CDCC8F79ABFAED0F8DD4
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -26 maxlevel 200 minaction 2 bait 0 mail/h: 19 total 517805 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58158>

Walter Bright wrote:
> Andreas Ericsson wrote:
>> Walter Bright wrote:
>>> 1) You wind up having to implement the complex, dirty details of 
>>> things yourself. The consequences of this are:
>>>
>>>    a) you pick a simpler algorithm (which is likely less efficient - 
>>> I run across bubble sorts all the time in code)
>>>
>>>    b) once you implement, tune, and squeeze all the bugs out of those 
>>> complex, dirty details, you're reluctant to change it. You're 
>>> reluctant to try a different algorithm to see if it's faster. I've 
>>> seen this effect a lot in my own code. (I translated a large body of 
>>> my own C++ code that I'd spent months tuning to D, and quickly 
>>> managed to get significantly more speed out of it, because it was 
>>> much simpler to try out different algorithms/data structures.)
>>>
>>
>> I haven't seen this in the development of git, although to be fair, you
>> didn't mention the number of developers that were simultaneously working
>> on your project.
> 
> On my project, one. But I've seen this problem repeatedly in other 
> projects that had multiple developers. For example, I used to use 
> version 1 of an assembler. It was itself written entirely in assembler. 
> It ran *incredibly* slowly on large asm files. But it was written in 
> assembler, which is very fast, so how could that be?
> 
> Turns out, the symbol table used internally was a linear one. A linear 
> symbol table is easy to implement, but doesn't scale well at all. A 
> linear symbol table was implemented because it was just harder to do 
> more advanced symbol table algorithms in assembler. In this case, a 
> higher level language re-implementation made the assembler much faster, 
> even though that implementation was SLOWER in every detail. It was 
> faster overall, because it was easier to develop faster algorithms.
> 

Well, when the ease-of-coding vs the exec-speed of D vs C is that of
C vs asm, C will be dead fairly soon. However, since C is so ingrained
in every language designer's head, I find that unlikely to happen any
time soon.

> 
>> Opensource projects with many contributors (git, linux) work differently,
>> since one or a few among the plethora of authors will almost always be
>> a true expert at the problem being solved.
> 
> That is a nice advantage. I don't think many projects can rely on having 
> the best in the business working on them, though <g>.
> 

True that. I know a fair few projects that could have done with borrowing
one or two proper gurus, but even opensource programmers are selfish in
that we usually only work for something that benefits ourselves.

> 
>> The point is that, given enough developers, *someone* is bound to
>> find an algorithm that works so well that it's no longer worth
>> investing time to even discuss if anything else would work better,
>> either because it moves the performance bottleneck to somewhere else
>> (where further speedups would no longer produce humanly measurable
>> improvements), or because the action seems instantanous to the user
>> (further improvements simply aren't worth it, because no valuable
>> resource will be saved from it).
> 
> Sure, but I suggest that few projects reach this maxima.

True again, but given what I said above holds, it would be madness to
move from the lingua franca of oss hacking to a less common one, as it
would mean fewer eyes on the code.

> Case in point: 
> ld, the gnu linker. It's terribly slow. To see how slow it is, compare 
> it to optlink (the 15 years old one that comes with D for Windows). So I 
> don't believe there is anything inherent about linking that should make 
> ld so slow. There's some huge leverage possible in speeding up ld 
> (spreading out that saved time among all the gnu developers).
> 
> So while git may have reached a maxima in performance, I don't think 
> this principle is applicable in general, even for very widely used open 
> source projects that would profit greatly from improved performance.
> 

Interesting. I recently did a spot of work comparing various string-hashing
algorithms. Perhaps I should head over to the ld camp and see if I can help.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
