From: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 14:02:29 +0100
Message-ID: <submission.1M9Im6-0003Hs-40@mail.cs.st-andrews.ac.uk>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <4A1D2614.5060303@op5.se>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed May 27 15:05:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9IoX-0003R4-UV
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 15:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763781AbZE0NCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 09:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763763AbZE0NCb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 09:02:31 -0400
Received: from mail.cs.st-andrews.ac.uk ([138.251.206.35]:57900 "EHLO
	mail.cs.st-andrews.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763711AbZE0NC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 09:02:29 -0400
Received: by mail.cs.st-andrews.ac.uk with esmtpsa (authid caj) (TLSv1:AES128-SHA:128)
	(Exim 4.43)
	id 1M9Im6-0003Hs-40; Wed, 27 May 2009 14:02:30 +0100
In-Reply-To: <4A1D2614.5060303@op5.se>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120060>


On 27 May 2009, at 12:37, Andreas Ericsson wrote:

> Christopher Jefferson wrote:
>> I recently came across a very annoying problem, characterised by  
>> the following example:
>> On a recent ubuntu install:
>> dd if=/dev/zero of=file bs=1300k count=1k
>> git commit file -m "Add huge file"
>> The repository can be pulled and pushed successfully to other  
>> ubuntu installs, but on Mac OS X, 10.5.7 machine with 4GB ram git  
>> pull produces:
>> remote: Counting objects: 6, done.
>> remote: git(1533,0xb0081000) malloc: *** mmap(size=1363152896)  
>> failed (error code=12)
>> remote: *** error: can't allocate region
>> remote: *** set a breakpoint in malloc_error_break to debug
>> remote: git(1533,0xb0081000) malloc: *** mmap(size=1363152896)  
>> failed (error code=12)
>> remote: *** error: can't allocate region
>> remote: *** set a breakpoint in malloc_error_break to debug
>> remote: fatal: Out of memory, malloc failed
>> error: git upload-pack: git-pack-objects died with error.
>> fatal: git upload-pack: aborting due to possible repository  
>> corruption on the remote side.
>> remote: aborting due to possible repository corruption on the  
>> remote side.
>> fatal: protocol error: bad pack header
>> The problem appears to be the different maximum mmap sizes  
>> available on different OSes. Whic I don't really mind the maximum  
>> file size restriction git imposes, this restriction varying from OS  
>> to OS is very annoying, fixing this required rewriting history to  
>> remove the commit, which caused problems as the commit had already  
>> been pulled, and built on, by a number of developers.
>> If the requirement that all files can be mmapped cannot be easily  
>> removed, would be it perhaps be acceptable to impose a (soft?)  
>> 1GB(ish) file size limit?
>
> Most definitely not. Why should we limit a cross-platform system for
> the benefit of one particular developer's lacking hardware?

Out of curiosity, why do you say lacking hardware? I am running  
ubuntu, windows and Mac OS X on exactly the same machine, which is not  
running out of physical memory, never mind swap, when using git on any  
OS. The problem is purely a software (and OS) problem.


Chris
