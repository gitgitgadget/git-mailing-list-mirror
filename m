From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: [PATCH] Implement safe_strncpy() as strlcpy() and use it more. [Take 2]
Date: Sun, 11 Jun 2006 12:33:32 +0000
Organization: Berlin University of Technology
Message-ID: <20060611123332.GA3832@robert.daprodeges.fqdn.th-h.de>
References: <20060611120328.GC10430@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Sun Jun 11 14:33:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpP8Y-00075P-Bg
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 14:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWFKMdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFKMdo
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 08:33:44 -0400
Received: from mail.gmx.de ([213.165.64.21]:49584 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751261AbWFKMdo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 08:33:44 -0400
Received: (qmail invoked by alias); 11 Jun 2006 12:33:42 -0000
Received: from cable-62-117-25-83.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.25.83]
  by mail.gmx.net (mp022) with SMTP; 11 Jun 2006 14:33:42 +0200
X-Authenticated: #1642131
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.fqdn.th-h.de [192.168.0.113])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 97F9E21184
	for <git@vger.kernel.org>; Sun, 11 Jun 2006 12:33:41 +0000 (UTC)
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.fqdn.th-h.de [192.168.0.113])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by robert.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 23EAE3405F
	for <git@vger.kernel.org>; Sun, 11 Jun 2006 12:33:34 +0000 (UTC)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060611120328.GC10430@bohr.gbar.dtu.dk>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: robert (FreeBSD 6.1-STABLE i386)
User-Agent: Mutt/1.5.11-pdmef-2006-06-08
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21654>

Hi,

* Peter Eriksen [06-06-11 14:03:28 +0200] wrote:

>-char *safe_strncpy(char *dest, const char *src, size_t n)
>+size_t safe_strncpy(char *dest, const char *src, size_t size)
> {
>-	strncpy(dest, src, n);
>-	dest[n - 1] = '\0';
>+	size_t ret = strlen(src);

At least FreeBSD's strlen() requires a non-NULL argument, i.e. with 
src==NULL, this will segfault.

If you can ensure that src!=NULL, then it's okay, but the safe_ prefix 
implies something different.

   bye, Rocco
-- 
:wq!
