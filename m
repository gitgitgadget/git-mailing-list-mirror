From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [GUILT] handle branches with slashes in guilt-graph
Date: Tue, 18 Oct 2011 21:56:41 +0200
Message-ID: <m2mxcydqfa.fsf@igel.home>
References: <4E9D57BB.2030707@opera.com> <m2r52adu65.fsf@igel.home>
	<7v39eqglle.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Per Cederqvist <cederp@opera.com>,
	Jeff Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org,
	ceder@lysator.liu.se
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 21:56:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGFmO-0002li-Q2
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 21:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781Ab1JRT4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 15:56:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:33911 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab1JRT4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 15:56:47 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id E7F9B1C1D9F0;
	Tue, 18 Oct 2011 21:56:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 619301C001A6;
	Tue, 18 Oct 2011 21:56:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id eykl2bRG2acS; Tue, 18 Oct 2011 21:56:42 +0200 (CEST)
Received: from igel.home (ppp-88-217-108-0.dynamic.mnet-online.de [88.217.108.0])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 18 Oct 2011 21:56:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id CDA3BCA29C; Tue, 18 Oct 2011 21:56:41 +0200 (CEST)
X-Yow: ..  my NOSE is NUMB!
In-Reply-To: <7v39eqglle.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 18 Oct 2011 12:12:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183901>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Per Cederqvist <cederp@opera.com> writes:
>>
>>> Avoid sed errors when the branch name contains a slash.
>>>
>>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>>>
>>> --- /usr/bin/guilt-graph~	2011-01-25 20:15:50.000000000 +0100
>>> +++ /usr/bin/guilt-graph	2011-10-18 12:30:31.000000000 +0200
>>> @@ -37,9 +37,10 @@ disp "digraph G {"
>>>
>>>  current="$top"
>>>
>>> +safebranch=`echo "$branch"|sed 's%/%\\\\/%g'`
>>>  while [ "$current" != "$base" ]; do
>>>  	pname=`git show-ref | sed -n -e "
>>> -/^$current refs\/patches\/$branch/ {
>>> +/^$current refs\/patches\/$safebranch/ {
>>
>> Alternatively, you could change the delimiter to `,':
>>
>>   \,^$current refs/patches/$branch, {
>
> Isn't a comma still valid character in a branch name?

I suggested the comma because it is already used by the next sed
command, so that won't be a regression.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
