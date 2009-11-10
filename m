From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 4/4] Add explicit Cygwin check to guard WIN32 header
 inclusion
Date: Tue, 10 Nov 2009 18:48:12 +0000
Message-ID: <4AF9B56C.5000205@ramsay1.demon.co.uk>
References: <4AF5D6F8.40608@ramsay1.demon.co.uk> <4AF7C2C6.5070307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 10 20:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7wQH-0006ci-Te
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 20:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889AbZKJTaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 14:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757876AbZKJTaZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 14:30:25 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:46129 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757875AbZKJTaY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 14:30:24 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1N7wQ9-0006OL-WH; Tue, 10 Nov 2009 19:30:29 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4AF7C2C6.5070307@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132586>

Johannes Sixt wrote:
> Ramsay Jones schrieb:
>> Since commit 435bdf8c ("Make usage of windows.h lean and mean",
>> 16-9-2009), the amount of code potentially including the WIN32
>> API header files has greatly increased. In particular, the Cygwin
>> build is at greater risk of inadvertently including WIN32 code
>> within preprocessor sections protected by the WIN32 or _WIN32
>> macros.
> 
> Thanks, this makes the problem pretty clear that you want to solve.
> 

Hmm, OK. Note the "... potentially including ..." above.

>> The previous commit message, along with comments elsewhere, assert
>> that the WIN32 macro is not defined on Cygwin. Currently, this is
>> true for the cygwin build. However, the cygwin platform can be
>> used to develop WIN32 GUI, WIN32 console, and POSIX applications.
>> Indeed it is possible to create applications which use a mix of
>> the WIN32 API and POSIX code (eg git!).
> 
> In this paragraph, you are only saying that cygwin comes with headers and
> libraries that can be used to write code using the Windows API in addition
> to the POSIX headers and libraries. (I'm just asking, not complaining;
> perhaps this could be stated differently.)
> 

;-) The above paragraph, along with the one below, was once part of an even
larger paragraph which I had edited multiple times and, eventually, split
up. I had intended to delete the last two sentences from the above paragraph.
Whilst the content of those sentences is true, it is not necessary for them
to be there and, having been orphaned at the end of the paragraph, now sound
a bit odd.

If I were to create a version 4 of the patch, I would delete that text.

>> Unlike native WIN32 compilers, gcc on cygwin does not automatically
>> define the _WIN32 macro. However, as soon as you include the
>> <windows.h> header file, the _WIN32 and WIN32 macros are defined.
>>
>> In order to reduce the risk of problems in the future, we protect
>> the inclusion of the windows header with an explicit check for
>> __CYGWIN__. Also, we move the other use of the <windows.h> header
>> from compat/win32.h to compat/cygwin.c
> 
> But I sense a contradiction here. Above you are arguing that much more
> WIN32 code is included, but here you are saying that the explicit check
---------------^
potentially

> for __CYGWIN__ is just a safety measure to protect us from failures in
> future changes. Indeed, looking at the code it seems that this extra check
> is *currently* not necessary:

*correct*! I have not claimed otherwise.

[snipped other text I also agree with!]

> IOW, I disagree with your analysis that a lot of code suffers from
> windows.h pollution. What am I missing?

Hmm, I don't know; but the analysis that you claim for me, I don't
think is mine! :-D

Hmm, I don't have a great investment in this patch (it doesn't fix a bug
after all), so given that you don't see any merit in it, I'm more than
happy just to drop it! :-P

So, Junio, could you please drop this patch from the series.

Thanks!

ATB,
Ramsay Jones
