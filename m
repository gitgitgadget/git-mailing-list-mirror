From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/5] Fix compile errors with MSys2
Date: Thu, 14 Jan 2016 22:57:30 +0100
Message-ID: <569819CA.3040804@kdbg.org>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
 <cover.1452790142.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 22:57:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJpth-0003ev-7P
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 22:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbcANV5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 16:57:33 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:42633 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbcANV5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 16:57:32 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3phKHv13w2z5tlB;
	Thu, 14 Jan 2016 22:57:31 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id BABD151D6;
	Thu, 14 Jan 2016 22:57:30 +0100 (CET)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <cover.1452790142.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284097>

Am 14.01.2016 um 17:51 schrieb Johannes Schindelin:
> Git for Windows 2.x is based on MSys2, and its first official version
> was released already almost half a year ago, yet it is still impossible
> even to compile Git from the official, platform-independent Git source
> code.
>
> This patch series merely fixes the compile errors, and will be followed
> by other patch series that fix the compile warnings and test failures.
> The idea is to move all Windows-specific patches of Git for Windows'
> fork to upstream Git proper.
>
> Relative to v1, I only removed the guards about the "#undef
> ReadWriteBarrier".
>
> Johannes Schindelin (5):
>    config.mak.uname: support MSys2
>    config.mak.uname: supporting 64-bit MSys2
>    nedmalloc: allow compiling with MSys2's compiler
>    compat/mingw: support MSys2-based MinGW build
>    compat/winansi: support compiling with MSys2
>
>   compat/mingw.h              | 24 +++++++++++++++++++++++-
>   compat/nedmalloc/malloc.c.h |  4 ++++
>   compat/winansi.c            |  2 ++
>   config.mak.uname            | 31 ++++++++++++++++++++++++++++---
>   4 files changed, 57 insertions(+), 4 deletions(-)
>
> Interdiff vs v1:
>
>   diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
>   index 18634e3..bf70037 100644
>   --- a/compat/nedmalloc/malloc.c.h
>   +++ b/compat/nedmalloc/malloc.c.h
>   @@ -1385,9 +1385,7 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
>
>      /*** Atomic operations ***/
>      #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
>   -    #ifdef __MINGW64_VERSION_MAJOR
>   -      #undef _ReadWriteBarrier
>   -    #endif
>   +    #undef _ReadWriteBarrier
>        #define _ReadWriteBarrier() __sync_synchronize()
>      #else
>        static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)
>

It is very considerate of you to keep compatibility with the old MSYS 
build environment, which I'm still using. (The new Git for Windows build 
environment is already on my disk, but I haven't found time to get 
familiar with it.) So, it doesn't mean a whole lot, unfortunatley, when 
I report that I've tested v1, and that it passes the test suite, because 
I've exercised almost none of the new code.

-- Hannes
