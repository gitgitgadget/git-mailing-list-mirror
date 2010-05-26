From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: installation issue when building with NO_CURL=YesPlease
Date: Wed, 26 May 2010 20:27:26 +0200
Message-ID: <4BFD680E.8000603@dirk.my1.cc>
References: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com> <AANLkTimsGdv-La_poLpdrvuGChD6_sAD77fcjqKn5PAd@mail.gmail.com> <8E0CE121-DB2F-4017-AB46-282562B072FB@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Paul Walker <PWalker752@aol.com>
X-From: git-owner@vger.kernel.org Wed May 26 20:33:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHLQL-00084n-SO
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 20:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328Ab0EZSdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 14:33:35 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:35012 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757638Ab0EZSdd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 14:33:33 -0400
Received: from [84.176.97.116] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1OHLKA-0001KN-D2; Wed, 26 May 2010 20:27:26 +0200
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <8E0CE121-DB2F-4017-AB46-282562B072FB@aol.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147817>

Am 26.05.2010 16:15 schrieb Paul Walker:
> 
> On 26 May 2010, at 14:58, Ramkumar Ramachandra wrote:
> 
>> Hi,
>>
>>> As I could not find any bug reporting information on the wiki I 
>>> thought I
>>> would mention this here, please let me know if there is a better 
>>> forum for
>>> bug reports.
>>
>> Bugs are usually reported on this mailing list.
>>
>>>  I believe the latest git release (1.7.1.) has an installation
>>> bug when building with "NO_CURL=YesPlease".  Looking at the Makefile 
>>> line
>>> 1999 it reads
>>>
>>> for p in $(REMOTE_CURL_ALIASES); do
>>>
>>> which results in "/bin/sh: syntax error at line 1 : `;' unexpected" as
>>> REMOTE_CURL_ALIASES is empty.
>>
>> I can't reproduce this. How exactly are you building? I'm using
>> $ NO_CURL=YesPlease make
>> ... and it builds fine for me.
>>
>> -- Ram
> 
> I used:
> 
> gmake prefix=<path> NO_CURL=YesPlease NO_PYTHON=YesPlease all
> 
> which works fine, followed by
> 
> gmake prefix=<path> NO_CURL=YesPlease NO_PYTHON=YesPlease install
> 
> which reported the above error
> 

I had a similar problem when "make install"ing under AIX. Not with 
NO_CURL but with some other NO_* option. I forgot which.
This yealded to an empty $(REMOTE_***_ALIASES) macro 
(REMOTE_CURL_ALIASES in your case) which my AIX shell cannot handle.

It reads "for p in; do" which makes it unhappy. I solved my problem with 
  the SHELL_PATH environment variable (look at the first few lines in 
the Makefile).

$ SHELL_PATH=/bin/bash NO_SOMETHING=YesPlease make install

then worked fine for me.

HTH,
     Dirk
