From: Sven Strickroth <sven@cs-ware.de>
Subject: Re: [PATCH 1/5] msvc: Fix compilation errors caused by poll.h emulation
Date: Thu, 09 May 2013 23:12:28 +0200
Message-ID: <518C113C.3080106@cs-ware.de>
References: <510AB7D3.7010407@ramsay1.demon.co.uk> <518AFEFC.8010904@cs-ware.de> <518C0890.9050508@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 23:12:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaY8g-0001oU-FB
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 23:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab3EIVMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 17:12:30 -0400
Received: from srv1.79p.de ([213.239.234.118]:39333 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab3EIVM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 17:12:29 -0400
Received: from [139.174.6.11] (vpn11.rz.tu-clausthal.de [139.174.6.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 37008441028;
	Thu,  9 May 2013 23:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2013; t=1368133948;
	bh=+0A9t0QjKlY3BtZee7bUGBCGBwWF8UIzZKp+UtrAmOg=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=kiJR8uzJ0DHOi0MLwA0x0lgWUvFdb3cjSjMXWe5tWR21QINO9kybmjKmdQ5+C8PDl
	 y1gJ/r4sIA2bQ5CJXHHOcfeUr6zAzakOkfWNIOxHq+Htj35H6Rc1cullNCClH45M20
	 QXcHlJ4z+y/V/Z1O+tSzw0ws5k9buagwxggwr2cw=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <518C0890.9050508@ramsay1.demon.co.uk>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223783>

Am 09.05.2013 22:35 schrieb Ramsay Jones:
> Note that '-Icompat/poll' is passed on the command-line (it is split at -Icomp
> above), which comes from:
> 
>     ramsay (tmp) ms $ git grep -n 'compat/poll'
>     Makefile:647:LIB_H += compat/poll/poll.h
>     Makefile:1235:  COMPAT_CFLAGS += -DNO_POLL -Icompat/poll
>     Makefile:1236:  COMPAT_OBJS += compat/poll/poll.o
>     ramsay (tmp) ms $
> 
> I have a patch which allows me to generate the preprocessed output file
> and, after running it on git.c (=> git.i), I can see that msvc reads the
> compat/poll/poll.h file. (from line 128 of git-compat-util.h).
> 
> Are you using a MSVC "project" file? If so, is it equivalent to the Makefile?
> Has the "#include" behaviour changed between MSVC 2008 -> MSVC 2012?

Thank you for your explanation. The problem for me was, that
_WIN32_WINNT was set to 0x0600 and thus winsck2.h was also declaring pollfd.

Building libgit works now.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
