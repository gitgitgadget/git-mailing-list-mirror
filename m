From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: [PATCH 1/2] MSVC: Do not close stdout to prevent
 a crash
Date: Sun, 20 Nov 2011 10:27:26 +0100
Message-ID: <4EC8C7FE.5050903@kdbg.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org> <m2sjlkcgyl.fsf@igel.home> <7v39dkj5ad.fsf@alter.siamese.dyndns.org> <m2obw7dg1e.fsf@igel.home> <7vpqgniid5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 20 10:27:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RS3gV-00017B-Vk
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 10:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab1KTJ1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 04:27:31 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:23238 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751818Ab1KTJ1a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 04:27:30 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 612F510013;
	Sun, 20 Nov 2011 10:26:49 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BC79219F390;
	Sun, 20 Nov 2011 10:27:26 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vpqgniid5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185719>

Am 20.11.2011 04:27, schrieb Junio C Hamano:
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
> 
>     RETURN VALUE
> 
>     Upon successful completion, fileno() shall return the integer value of
>     the file descriptor associated with stream. Otherwise, the value -1
>     shall be returned and errno set to indicate the error.

But in the description of fclose() there is also:

  After the call to fclose(), any use of stream results in undefined
  behavior.

And we do call fclose(stdout) in cmd_format_patch.

-- Hannes
