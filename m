From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 18/25] lockfile: avoid transitory invalid states
Date: Mon, 07 Apr 2014 15:12:49 +0200
Message-ID: <5342A451.5020905@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu> <1396827247-28465-19-git-send-email-mhagger@alum.mit.edu> <534242AC.7030908@viscovery.net> <53428846.7060104@alum.mit.edu> <5342962A.8020608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:13:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9MB-0000sL-50
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbaDGNMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:12:55 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43955 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755217AbaDGNMy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:12:54 -0400
X-AuditID: 12074413-f79076d000002d17-5d-5342a45554b3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.27.11543.554A2435; Mon,  7 Apr 2014 09:12:53 -0400 (EDT)
Received: from [192.168.69.148] (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DCobP020520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:12:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <5342962A.8020608@viscovery.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqBu6xCnYYN9ERYuuK91MFg29V5gt
	Vv6ssfjR0sNsceZNI6NFZ8dXRgc2j2e9exg9Ll5S9lj8wMvj8yY5j7v/dzJ53H62jSWALYrb
	JimxpCw4Mz1P3y6BO+PFvZWMBTPEKlo3HWJrYDwn2MXIwSEhYCKxcZdkFyMnkCkmceHeerYu
	Ri4OIYHLjBIrNhxihHDOMkkcPfObBaSKV0Bb4t+Os4wgNouAqsSbRQtZQWw2AV2JRT3NTCBD
	RQWCJP6cVYQoF5Q4OfMJWKuIgIbE7tO97CAzmQWuMEpsnPqdGaReWMBdYvt2qMUPGCWmbb4B
	1sAJNPPKkplMEIeKS/Q0BoGEmYHCP5pWskHY8hLb385hnsAoOAvJullIymYhKVvAyLyKUS4x
	pzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQTIyQShHcw7jopd4hRgINRiYd35SHHYCHW
	xLLiytxDjJIcTEqivFJznIKF+JLyUyozEosz4otKc1KLDzFKcDArifAadgHleFMSK6tSi/Jh
	UtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvP8WATUKFqWmp1akZeaUIKSZODhBhnNJ
	iRSn5qWkFiWWlmTEg+I3vhgYwSApHqC9GotB9hYXJOYCRSFaTzHqcmzYtqaRSYglLz8vVUqc
	9zvIDgGQoozSPLgVsLT3ilEc6GNhXkaQUTzAlAk36RXQEiaQ51zBlpQkIqSkGhjrln64rPvk
	60RNruWMc9656X+VPfz2eLql1cL71zjtefLk+6ae/2JfMDFzk5fkte0Jl2xfGlTm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245833>

On 04/07/2014 02:12 PM, Johannes Sixt wrote:
> Am 4/7/2014 13:13, schrieb Michael Haggerty:
>> On 04/07/2014 08:16 AM, Johannes Sixt wrote:
>>> Am 4/7/2014 1:34, schrieb Michael Haggerty:
>>>> So, instead of encoding part of the lock_file state in the filename
>>>> field, add a new bit "LOCK_FLAGS_LOCKFILE_ACTIVE" to flags, and use
>>>> this bit to distinguish between a lock_file object that is active
>>>> vs. one that is inactive.  Be careful to set this bit only when
>>>> filename really contains the name of a file that should be deleted on
>>>> cleanup.
>>>
>>> Since this flag is primarily for communication between the main code and a
>>> signal handler, the only safe way is to define the flag as volatile
>>> sig_atomic_t, not to make it a bit of a larger type!
>>
>> Thanks for the feedback.  You are obviously right, and I will fix it.
>>
>> But I have a feeling that this line of thought is going to lead to the
>> signal handler's not being able to do anything.  How far can we afford
>> to pursue strict correctness?  ...
>>
>> The signal handler currently reads
>>
>>     lock_file_list
>>     lock_file::next
>>     lock_file::fd
>>     lock_file::owner
>>     lock_file::filename
>>     *lock_file::filename
>>
>> and writes lock_file_list.  Among other things it calls close(),
>> unlink(), vsnprintf(), and fprintf() (the last two via warning()).
>>
>> But most of these actions are undefined under the C99 standard:
> 
> Good point. But not all is lost because some of the functions are
> well-defined under POSIX, particularly close() and unlink(). (*printf are
> not, though.)
> 
>> I don't have time to rewrite *all* of Git right now, so how can we get
>> reasonable safety and portability within a feasible amount of work?
> 
> It shouldn't be *that* bad. We can make all members volatile, except
> filename (because we wouldn't be able to strcpy(lk->filename, ...) without
> a type cast).
> 
> How far *do* you want to go? I'm certainly not opposed to field-test your
> current changeset (plus and adjustment to use sig_atomic_t) -- overall it
> is an improvement. And then we will see how it works.

For now I think I'd just like to get the biggest problems fixed without
making anything worse.  Given that there might be a GSoC student working
in this neighborhood, he/she might be able to take up the baton.

I changed the patch series to use a new "volatile sig_atomic_t active"
field rather than a bit in a "flags" field.  I'll wait a short time to
see if there is more feedback before pushing it to the list; meanwhile
you can find it here if you have time to look at it and/or test it:

    http://github.com/mhagger/git, branch "lock-correctness"

Michael


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
