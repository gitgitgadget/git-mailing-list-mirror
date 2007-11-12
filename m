From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Simplify strchrnul() compat code
Date: Mon, 12 Nov 2007 11:07:33 +0100
Organization: At home
Message-ID: <fh98ku$da6$1@ger.gmane.org>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se> <47359C44.6090903@lsrfire.ath.cx> <4735BA79.5020102@op5.se> <7v6409f4eh.fsf@gitster.siamese.dyndns.org> <ee77f5c20711120103s478e26cdib85f38293423d90c@mail.gmail.com> <473818FA.1060400@viscovery.net> <ee77f5c20711120124m6281fddfs9403a46cf354b993@mail.gmail.com> <473821CE.8050907@viscovery.net> <ee77f5c20711120152i4955ed3bh484c9ac76a7f1f5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 11:07:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrWD0-0006U2-BF
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867AbXKLKHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756026AbXKLKHn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:07:43 -0500
Received: from main.gmane.org ([80.91.229.2]:51678 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806AbXKLKHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 05:07:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrWCb-0007uq-Rz
	for git@vger.kernel.org; Mon, 12 Nov 2007 10:07:33 +0000
Received: from abwz76.neoplus.adsl.tpnet.pl ([83.8.249.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 10:07:33 +0000
Received: from jnareb by abwz76.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 10:07:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwz76.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64590>

David Symonds wrote:
> On Nov 12, 2007 8:50 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:

>> -#if !defined(__GLIBC_PREREQ) && !__GLIBC_PREREQ(2, 1)
>> +#ifdef __GLIBC_PREREQ
>> +#if __GLIBC_PREREQ(2, 1)
>> +#define HAVE_STRCHRNUL
>> +#endif
>> +#endif
>> +
>> +#ifndef HAVE_STRCHRNUL
>>
>>   #define strchrnul gitstrchrnul
>>   static inline char *gitstrchrnul(const char *s, int c)
>>   {
> 
> Yep, that works just fine. Ack.

This version has also the following advantage that you can set
HAVE_STRCHRNULL if above test does not detect it in your library.

Althought you'd better write then:

+#if __GLIBC_PREREQ(2, 1) && !defined(HAVE_STRCHRNUL)

Ack.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
