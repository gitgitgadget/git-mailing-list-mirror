From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Issue with compiling git 1.8.4 under uclibc with gcc 4.6.3
Date: Mon, 26 Aug 2013 23:07:50 +0200
Message-ID: <87fvtwi2jd.fsf@igel.home>
References: <521BB643.304@gmail.com> <20130826201804.GB13130@blizzard>
	<521BBA98.7010102@gmail.com> <20130826203154.GA21357@blizzard>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lance <lancethepants@gmail.com>, git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Mon Aug 26 23:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE411-0000ea-72
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 23:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab3HZVHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 17:07:54 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60955 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3HZVHy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 17:07:54 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cP5Qc2Nv6z4KK8y;
	Mon, 26 Aug 2013 23:07:52 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cP5Qc25dBzbbhR;
	Mon, 26 Aug 2013 23:07:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id RN-wKqOwEN4h; Mon, 26 Aug 2013 23:07:51 +0200 (CEST)
X-Auth-Info: 86I9s1h/jpjHE0fJy5D8+qOnDFzCzC564G5zDnQZ4Gc=
Received: from igel.home (ppp-88-217-105-56.dynamic.mnet-online.de [88.217.105.56])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 26 Aug 2013 23:07:51 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id EBC902C15D1; Mon, 26 Aug 2013 23:07:50 +0200 (CEST)
X-Yow: My haircut is totally traditional!
In-Reply-To: <20130826203154.GA21357@blizzard> (Lukas Fleischer's message of
	"Mon, 26 Aug 2013 22:31:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233030>

Lukas Fleischer <git@cryptocrack.de> writes:

> On Mon, Aug 26, 2013 at 02:29:12PM -0600, Lance wrote:
>> [...]
>> >>     CC config.o
>> >>config.c: In function 'get_next_char':
>> >>config.c:220:14: error: expected identifier before '(' token
>> >>config.c:220:14: error: expected statement before ')' token
>> >>config.c:220:14: error: expected statement before ')' token
>> >>config.c:224:11: error: expected identifier before '(' token
>> >Does changing line 220 of config.c to
>> >
>> >     int c = (cf->fgetc)(cf);
>> >
>> >fix it?
>> I also had to change line 224 to the following
>> 
>>                 c = (cf->fgetc)(cf);
>> 
>> Once both places were changes, it compiled successfully.
>
> Sounds like a parser bug to me.

No, it isn't.  fgetc may be a function-like macro that expands to an
arbitrary expression (same for ungetc or ftell, or any other indentifier
that matches a C library function, for that matter).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
