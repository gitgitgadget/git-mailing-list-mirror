From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] msvc: Fix compilation error due to missing mktemp() declaration
Date: Thu, 30 Dec 2010 19:33:24 +0000
Message-ID: <4D1CDE84.7090402@ramsay1.demon.co.uk>
References: <4D139D91.8080503@ramsay1.demon.co.uk> <AANLkTineKS2e8PJs76PLZP4L4APwX2kAiFPg4pz3esae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 30 20:47:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYOSw-0006Bn-GK
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 20:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab0L3TrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 14:47:05 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:59097 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754941Ab0L3TrE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Dec 2010 14:47:04 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PYOSk-0005CS-ak; Thu, 30 Dec 2010 19:47:02 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTineKS2e8PJs76PLZP4L4APwX2kAiFPg4pz3esae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164361>

Erik Faye-Lund wrote:
> On Thu, Dec 23, 2010 at 8:05 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> Commit d1b6e6e (win32: use our own dirent.h, 2010-11-23) removed
>> the compat/vcbuild/include/dirent.h compatibility header file.
>> This file, among other things, included the <io.h> system header
>> file which provides the declaration of the mktemp() function.
>>
>> In order to fix the compilation error, we add an include directive
>> for <io.h> to the compat/vcbuild/include/unistd.h header. (The
>> MinGW build includes <io.h> from it's <unistd.h> header too.)
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
> 
> Thanks. But shouldn't this header be included in mingw.h (or perhaps
> msvc.h) because of _get_osfhandle and _commit?

Er... no. ;-)

All uses of _get_osfhandle() and _commit() on the msvc build (after this
patch) are within the scope of an appropriate declaration, so there is
no *need* to include <io.h> in either mingw.h or msvc.h.
[I'm confident the same is true of the MinGW build as well, but I didn't
have time to check before sending this mail...]

I suspect that you already know this and I'm just being dumb in missing
the import of your question... Perhaps you could clarify your concerns
regarding this patch?

ATB,
Ramsay Jones
