From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 11:02:21 +0200
Message-ID: <op.utjx17xn1e62zd@merlin.emma.line.org>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de>
 <7vws8te2ht.fsf@alter.siamese.dyndns.org> <4A02A008.30800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 11:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1zUv-0005Mn-Oh
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 11:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbZEGJC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 05:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbZEGJCZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 05:02:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:36819 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751570AbZEGJCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 05:02:24 -0400
Received: (qmail invoked by alias); 07 May 2009 09:02:23 -0000
Received: from g226231102.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.226.231.102]
  by mail.gmx.net (mp070) with SMTP; 07 May 2009 11:02:23 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+t80dPSputT7ix2xZmLkaK5gV1txGiNf3BqlKxeW
	NFNAbUnvKO+wt9
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id CF46E949A7;
	Thu,  7 May 2009 11:02:21 +0200 (CEST)
In-Reply-To: <4A02A008.30800@viscovery.net>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118451>

Am 07.05.2009, 10:47 Uhr, schrieb Johannes Sixt <j.sixt@viscovery.net>:

> Junio C Hamano schrieb:
>> Matthias Andree <matthias.andree@gmx.de> writes:
>>
>>> Problem: when git is installed into /usr/local/bin, running 'sudo make
>>> install' won't find git in $PATH (because sudo strips PATH, for  
>>> instance
>>> on openSUSE 11.1, and doesn't include /usr/local/whatever).
>>
>> That sounds like a bug/misfeature in sudo (which I do not use) to me.
>
> sudo resets the environment, in particular also PATH. Why would this be  
> a bug?
>
> Current distros set env_reset in /etc/soduers for a reason. Not that I
> know the reason in detail, but I won't claim that I'm more clever with
> regards to security issues than distro packagers; so I trust that if they
> do it, then it makes sense.

comments in my suoders file:

| ...
| # Prevent environment variables from influencing programs in an
| # unexpected or harmful way (CVE-2005-2959, CVE-2005-4158, CVE-2006-0151)
| Defaults always_set_home
| Defaults env_reset
| ...

I don't bother, this is a convenience-and-usability feature. It has always  
irritated me why "make && sudo make install" would build twice.

Let's fix this for good unless someone can show that this is harmful. (OK,  
the $(prefix)/bin/git part might grab an old version, but we may want to  
use that for bootstrapping, and it should usually be good enough.)

-- 
Matthias Andree
