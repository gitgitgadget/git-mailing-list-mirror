From: =?ISO-8859-15?Q?=22Jan_H=2E_Sch=F6nherr=22?= 
	<schnhrr@cs.tu-berlin.de>
Subject: Re: [PATCH 1/2] shortlog: Fix wrapping lines of wraplen (was broken
 since recent off-by-one fix)
Date: Tue, 11 Dec 2012 11:24:44 +0100
Message-ID: <50C709EC.50102@cs.tu-berlin.de>
References: <7v8v97efdv.fsf@alter.siamese.dyndns.org> <1355205562-23459-1-git-send-email-prohaska@zib.de> <1355205562-23459-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Dec 11 11:25:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiN1e-00080J-Kg
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 11:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab2LKKZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 05:25:04 -0500
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:61585 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab2LKKZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 05:25:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id C38DB9EBC
	for <git@vger.kernel.org>; Tue, 11 Dec 2012 11:25:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id 9hIxy+8ekZXO 14650-09;
	Tue, 11 Dec 2012 11:24:49 +0100 (CET) 13608
Received: from [130.149.91.59] (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Tue, 11 Dec 2012 11:24:49 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.10) Gecko/20121126 Thunderbird/10.0.10
In-Reply-To: <1355205562-23459-2-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211284>

Am 11.12.2012 06:59, schrieb Steffen Prohaska:
> A recent commit [1] fixed a off-by-one wrapping error.  As
> a side-effect, the conditional in add_wrapped_shortlog_msg() whether to
> append a newline needs to be removed.  add_wrapped_shortlog_msg() should
> always append a newline, which was the case before the off-by-one fix,
> because strbuf_add_wrapped_text() never returned a value of wraplen.

I agree with this explanation, although there exists a case where wraplen 
(or wraplen+1 after the off-by-one fix) is returned: This happens
when there is not a single space within the string and it has just the
correct length. But also in this case, the newline must be added to get
a correctly formatted output. So your patch is good as it is. :)

But I still wonder about the original motivation for the removed
conditional. It looks like, it wasn't even needed in the very first
version (3714e7c8)?! (And it wasn't present in the version on the mailing 
list: http://article.gmane.org/gmane.comp.version-control.git/35221)

Regards
Jan
