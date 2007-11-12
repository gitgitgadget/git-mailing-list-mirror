From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Simplify strchrnul() compat code
Date: Mon, 12 Nov 2007 10:12:26 +0100
Message-ID: <473818FA.1060400@viscovery.net>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>	 <47359C44.6090903@lsrfire.ath.cx> <4735BA79.5020102@op5.se>	 <7v6409f4eh.fsf@gitster.siamese.dyndns.org> <ee77f5c20711120103s478e26cdib85f38293423d90c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:12:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrVLa-0000Y1-Mr
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbXKLJMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 04:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbXKLJMb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:12:31 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60813 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbXKLJMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 04:12:30 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrVKm-0001NW-1c; Mon, 12 Nov 2007 10:11:56 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A033454D; Mon, 12 Nov 2007 10:12:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <ee77f5c20711120103s478e26cdib85f38293423d90c@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64580>

David Symonds schrieb:
> On Nov 11, 2007 9:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -183,7 +183,7 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
>>                  const void *needle, size_t needlelen);
>>  #endif
>>
>> -#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
>> +#if !defined(__GLIBC_PREREQ) && !__GLIBC_PREREQ(2, 1)
>>  #define strchrnul gitstrchrnul
>>  static inline char *gitstrchrnul(const char *s, int c)
>>  {
> 
> I just tested it on my machine (OS X Tiger) now that it's in 'next',
> and this breaks the build:
> 
>     CC git.o
> In file included from builtin.h:4,
>                  from git.c:1:
> git-compat-util.h:187:48: error: missing binary operator before token "("
> make: *** [git.o] Error 1
> 
> 
> I don't think I have __GLIBC_PREREQ defined anywhere I can find.

Turn the && in that line into || and it should work.

-- Hannes
