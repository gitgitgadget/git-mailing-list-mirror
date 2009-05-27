From: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 15:09:47 +0100
Message-ID: <submission.1M9JpE-0005AW-92@mail.cs.st-andrews.ac.uk>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <C933C1BA-0170-4469-8099-2C0E95C61D24@dbservice.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Wed May 27 16:09:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9JpN-0002kh-Df
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 16:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759467AbZE0OJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 10:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758727AbZE0OJr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 10:09:47 -0400
Received: from mail.cs.st-andrews.ac.uk ([138.251.206.35]:33863 "EHLO
	mail.cs.st-andrews.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264AbZE0OJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 10:09:47 -0400
Received: by mail.cs.st-andrews.ac.uk with esmtpsa (authid caj) (TLSv1:AES128-SHA:128)
	(Exim 4.43)
	id 1M9JpE-0005AW-92; Wed, 27 May 2009 15:09:48 +0100
In-Reply-To: <C933C1BA-0170-4469-8099-2C0E95C61D24@dbservice.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120068>


On 27 May 2009, at 15:01, Tomas Carnecky wrote:

>>
>> The problem appears to be the different maximum mmap sizes  
>> available on different OSes. Whic I don't really mind the maximum  
>> file size restriction git imposes, this restriction varying from OS  
>> to OS is very annoying, fixing this required rewriting history to  
>> remove the commit, which caused problems as the commit had already  
>> been pulled, and built on, by a number of developers.
>>
>> If the requirement that all files can be mmapped cannot be easily  
>> removed, would be it perhaps be acceptable to impose a (soft?)  
>> 1GB(ish) file size limit? I suggest 1GB as all the OSes I can get  
>> hold of easily (freeBSD, windows, Mac OS X, linux) support a mmap  
>> of size > 1GB.
>
> I think this is a limitation of a 32bit build of git. I just tried  
> with a 64bit build and it added the file just fine. The compiler on  
> MacOSX (gcc) produces 32bit builds by default, even if the system  
> supports 64bit executables. But gcc on 64bit Linux (at least the  
> installations I have at home) produces a 64bit executables by  
> default. Solaris/OpenSolaris behaves like MacOSX, no idea about *BSD  
> or Windows. Maybe this is why git works on Linux but not MacOSX even  
> on the same hardware.
> Btw, I built git with: make install prefix=... CC="gcc -m64", no  
> modifications needed (MacOSX 10.5.7).

The git installs I am using are all 32bit, this machine doesn't have a  
64bit processor (it is one of the few macs released without one). It's  
nice to know long term this problem will go away, that all suggests  
introducing some limit is not approriate, as while 32bit users have  
some arbitary limit above which they cannot go, I am sure all 64-bit  
OSes will manage to easily mmap any file. Of course warning such users  
they are producing packs that are not going to work on 32bit compiles  
of git isn't a stupid idea.

Chris
