From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Sat, 02 Mar 2013 09:44:39 +0100
Message-ID: <m28v66198o.fsf@igel.home>
References: <20130301222018.GA839@WST420>
	<7vwqtqeox7.fsf@alter.siamese.dyndns.org>
	<20130301225231.GB862@sigill.intra.peff.net>
	<20130301230508.GC862@sigill.intra.peff.net>
	<7vlia6em9x.fsf@alter.siamese.dyndns.org>
	<20130301233548.GA13422@sigill.intra.peff.net>
	<7v1ubyek9n.fsf@alter.siamese.dyndns.org>
	<20130302004120.GB14936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 02 09:45:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBi49-0005Q1-GV
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 09:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab3CBIor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 03:44:47 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41754 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab3CBIoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 03:44:46 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3ZJ1Jn2JmZz4KK6Q;
	Sat,  2 Mar 2013 09:44:41 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3ZJ1Jn28TQzbbhV;
	Sat,  2 Mar 2013 09:44:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id z9YjNkYf2sN8; Sat,  2 Mar 2013 09:44:40 +0100 (CET)
X-Auth-Info: DqxO8VdqT0fYh2faylolqKtrJ3ujf6ZsLyswI+/yTdk=
Received: from igel.home (ppp-88-217-125-229.dynamic.mnet-online.de [88.217.125.229])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  2 Mar 2013 09:44:40 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id D4485CA2B4; Sat,  2 Mar 2013 09:44:39 +0100 (CET)
X-Yow: TAILFINS!!  ...click...
In-Reply-To: <20130302004120.GB14936@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 1 Mar 2013 19:41:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217322>

Jeff King <peff@peff.net> writes:

>  static int maildir_filename_cmp(const char *a, const char *b)
>  {
> -	while (1) {
> +	while (*a && *b) {
>  		if (isdigit(*a) && isdigit(*b)) {
>  			long int na, nb;
>  			na = strtol(a, (char **)&a, 10);
> @@ -148,6 +148,7 @@ static int maildir_filename_cmp(const char *a, const char *b)
>  			b++;
>  		}
>  	}
> +	return *a - *b;

You should always cast to unsigned char when determining the order of
characters, to be consistent with strcmp/memcmp.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
