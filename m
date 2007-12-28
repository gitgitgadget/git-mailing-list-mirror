From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc2
Date: Fri, 28 Dec 2007 16:16:26 +0100
Message-ID: <87sl1m6e9h.fsf@wine.dyndns.org>
References: <7v1w98lsg3.fsf@gitster.siamese.dyndns.org>
	<AAB76121-7F18-4506-809F-EFCAAD76F8BC@zib.de>
	<20071228150240.GC19928@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 16:17:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8GxN-00034E-MQ
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 16:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbXL1PQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 10:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbXL1PQl
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 10:16:41 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:36981 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbXL1PQk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 10:16:40 -0500
Received: from adsl-84-227-17-162.adslplus.ch ([84.227.17.162] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1J8Gwn-0001SN-UN; Fri, 28 Dec 2007 09:16:35 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id E9CB81E7146; Fri, 28 Dec 2007 16:16:26 +0100 (CET)
In-Reply-To: <20071228150240.GC19928@bit.office.eurotux.com> (Luciano Rocha's
	message of "Fri, 28 Dec 2007 15:02:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69286>

Luciano Rocha <luciano@eurotux.com> writes:

> On Fri, Dec 28, 2007 at 11:43:53AM +0100, Steffen Prohaska wrote:
>> 
>>  On Dec 27, 2007, at 4:36 AM, Junio C Hamano wrote:
>> 
>> > GIT 1.5.4-rc2 is available at the usual places:
>> 
>> 
>>  The msysgit installer is now available at
>> 
>>     http://code.google.com/p/msysgit/downloads
>> 
>
> Trying to install it in wine ends with:
>
> Runtime Error (at -1:0):
>
> Cannot Import dll:Kernel32.dll.
>
> That popup appears immediately after running wine
> Git-1.5.4-rc2-preview20071228.exe and the installation ends.

That's because it doesn't find CreateHardLinkA. The following Wine patch
should enable the installer to succeed.

diff --git a/dlls/kernel32/kernel32.spec b/dlls/kernel32/kernel32.spec
index 7bc5db3..5f6dea6 100644
--- a/dlls/kernel32/kernel32.spec
+++ b/dlls/kernel32/kernel32.spec
@@ -224,8 +224,8 @@
 @ stdcall CreateFileMappingA(long ptr long long long str)
 @ stdcall CreateFileMappingW(long ptr long long long wstr)
 @ stdcall CreateFileW(wstr long long ptr long long long)
-# @ stub CreateHardLinkA
-# @ stub CreateHardLinkW
+@ stub CreateHardLinkA
+@ stub CreateHardLinkW
 @ stdcall CreateIoCompletionPort(long long long long)
 @ stdcall CreateJobObjectA(ptr str)
 @ stdcall CreateJobObjectW(ptr wstr)

-- 
Alexandre Julliard
julliard@winehq.org
