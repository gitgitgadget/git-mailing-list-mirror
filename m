From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Wed, 26 Jun 2013 22:37:06 -0400
Message-ID: <51CBA552.80309@gmail.com>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C7A875.6020205@gmail.com> <7va9mf6txq.fsf@alter.siamese.dyndns.org> <51C9EE26.9010006@kdbg.org> <7vppv928jx.fsf@alter.siamese.dyndns.org> <51CAF863.4020803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	dpotapov@gmail.com, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 27 04:37:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us25F-0000Qk-6v
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 04:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab3F0ChK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 22:37:10 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:52834 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3F0ChJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 22:37:09 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so2120962qae.20
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 19:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3hSqkRItIQEVcIJZZBI5bMdbah4wnMQ2rq3KmTtqRcw=;
        b=t1Bn3x8ffQP+W+glblqo/vKUGFDmxZ41BgMVR3dpJVeI8awv0UMqC3YgEdy03ixA/T
         +Nr+O084QtAeWvoEhVINekEeL+i0xmYtDTUF0D4fJc3CLRGXpXf6ULRsFJAOVPiCXMYB
         aesxcNzfMf0B/65v9R1VOFHH3/SBDFqv3ce7fbLliqQAC+lxRb+gnYhdRSR1clNFlt6P
         hSSiSL1EUYPhIoIcs9V876NyoYqzgf5Z8uZOkP/SFZbmM9Z1R1PuZUghGd+CXD5naOzf
         M5KOn0TunMrxFuqdlP9ZzEvg+IMC491aHmys3bvEo0TxWe39ezrqs5UeRv3ZZqdeKKV6
         csdQ==
X-Received: by 10.224.136.193 with SMTP id s1mr9351255qat.15.1372300628624;
        Wed, 26 Jun 2013 19:37:08 -0700 (PDT)
Received: from mark-laptop.lan (pool-173-79-104-160.washdc.fios.verizon.net. [173.79.104.160])
        by mx.google.com with ESMTPSA id m2sm2283401qat.2.2013.06.26.19.37.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 26 Jun 2013 19:37:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
In-Reply-To: <51CAF863.4020803@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229082>

On 06/26/2013 10:19 AM, Torsten B=F6gershausen wrote:
> On 2013-06-25 23.18, Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Some context: This is about a patch by Ramsay that removes the
>>> "schizophrenic lstat" hack for Cygwin. Junio, can you please queue =
that
>>> patch in pu?
>> Sure.  Thanks.
> First of all,
> thanks for the work.
>
> Here some "benchmark" results,
> (The test run of the test suite did the same amout of time).
>
> But:
> git status -uno in real life takes double the time,
> git 1.8.3 compared against "pu with the vanilla l/stat"
>    =20
>      1 second ->  2 seconds on linux kernel
> 0.2 seconds -> 0.4 seconds on git.git
>
> Do we have any known problems with the current implementation ?
> Does speed matter ?
>
> One vote to keep the special cygwin functions.
> (And have a look how to improve the core.filemode)
>
> /Torsten
>
>
There have been threads on the cygwin mailing lists for at least a=20
decade looking to speed up cygwin's posix stat / lstat (and fork). If=20
improvement were merely difficult, it would have been done long ago. As=
=20
git cares about things like execute bits, file / repository permissions=
,=20
and soft links, whatever stat / lstat git uses needs to fully support=20
those under cygwin, either by using what cygwin provides or providing a=
=20
complete replacement. Note my other reply - with Ramsay's patch I can=20
complete the test suite (except for t0008.sh that has a known hang)=20
while without it I find the test suite randomly (unrepeatable) hangs in=
=20
many tests. So, this stat/lstat replacement is at least implicated in=20
current troubles.

Mark
