From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/2] MSVC: Do not close stdout to prevent a crash
Date: Sun, 20 Nov 2011 10:05:53 +0100
Message-ID: <m2k46vcgem.fsf@igel.home>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org>
	<m2sjlkcgyl.fsf@igel.home> <7v39dkj5ad.fsf@alter.siamese.dyndns.org>
	<m2obw7dg1e.fsf@igel.home> <7vpqgniid5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 20 10:06:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RS3MV-0004wd-Vw
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 10:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1KTJGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 04:06:06 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:60499 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab1KTJGB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 04:06:01 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 0EF47188A176;
	Sun, 20 Nov 2011 10:08:34 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 7F8AC1C00089;
	Sun, 20 Nov 2011 10:05:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id UawWU3Ss3huL; Sun, 20 Nov 2011 10:05:54 +0100 (CET)
Received: from igel.home (ppp-93-104-159-141.dynamic.mnet-online.de [93.104.159.141])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 20 Nov 2011 10:05:54 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 90E43CA29C; Sun, 20 Nov 2011 10:05:53 +0100 (CET)
X-Yow: Why was I BORN?
In-Reply-To: <7vpqgniid5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 19 Nov 2011 19:27:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185718>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> We have relied on fstat(-1, &st) to correctly error out, and if MSVC build
>>> crashes, it is a bug in its fstat() emulation, I would think.
>>
>> fileno(stdout) is alread wrong if stdout was closed.
>
> The "-1" in my message comes from here:
>
>     DESCRIPTION
>
>     The fileno() function shall return the integer file descriptor
>     associated with the stream pointed to by stream.

After fclose(stdout) the stream does not exist any more.  Thus the use
of fileno(stdout) is undefined, in fact *any* use of stdout is undefined
afterwards.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
