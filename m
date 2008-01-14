From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Don't display crlf warning twice
Date: Mon, 14 Jan 2008 07:53:13 +0100
Message-ID: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de>
References: <1200241847776-git-send-email-prohaska@zib.de> <1200267979-17683-1-git-send-email-dpotapov@gmail.com> <B4297A2E-9F8F-4167-AB48-10AC1FB4E1D5@zib.de> <20080114064036.GX2963@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEJBk-0004MZ-UB
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 07:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYANGwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 01:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbYANGwX
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 01:52:23 -0500
Received: from mailer.zib.de ([130.73.108.11]:34367 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006AbYANGwV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 01:52:21 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0E6qDtm003153;
	Mon, 14 Jan 2008 07:52:13 +0100 (CET)
Received: from [192.168.178.21] (brln-4db9373f.pool.einsundeins.de [77.185.55.63])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0E6q8wc006476
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 14 Jan 2008 07:52:08 +0100 (MET)
In-Reply-To: <20080114064036.GX2963@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70444>


On Jan 14, 2008, at 7:40 AM, Dmitry Potapov wrote:

> On Mon, Jan 14, 2008 at 07:17:26AM +0100, Steffen Prohaska wrote:
>>
>> Your traces reveal that it is a racy condition that can trigger
>> the double warnings.
>
> It is not a racy condition. It is just another branch in the
> code, which happens when an existing file is modified. Your
> tests always added a new file, so they could not reproduce
> the problem.
>
>>
>> Do you have a test case that reliably triggers the second call to
>> convert_to_git()?
>
> ===========================================
> git config core.autocrlf input
>
> echo Hello > foo
> git add foo
> git commit -m 'add foo'
>
> echo Hello >> foo
> unix2dos foo
> # This should trigger double crlf warning
> git add foo
> ===========================================

Yes, this reproduces the problem.

Thanks,
Steffen
