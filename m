From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Fri, 25 Jul 2014 19:45:16 +0200
Message-ID: <vpqlhrh9vtf.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
	<vpqlhrjqmyw.fsf@anie.imag.fr>
	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>
	<53D15188.2010209@gmail.com> <vpqegxa386m.fsf@anie.imag.fr>
	<xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>
	<53D15EB4.1050303@gmail.com>
	<xmqqlhri8rdb.fsf@gitster.dls.corp.google.com>
	<53D17919.4020702@ramsay1.demon.co.uk> <53D1CBFA.3020107@gmail.com>
	<vpqlhriyll6.fsf@anie.imag.fr>
	<xmqqr41974cl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:45:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjYj-0002Co-6x
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934625AbaGYRp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:45:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51470 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933322AbaGYRp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:45:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PHjErC011407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 19:45:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PHjGL6022727;
	Fri, 25 Jul 2014 19:45:16 +0200
In-Reply-To: <xmqqr41974cl.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 25 Jul 2014 10:09:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 19:45:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PHjErC011407
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406915117.90872@NCALEX/nU+TylpneG3ksiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254241>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> On 7/25/2014 2:52 AM, Ramsay Jones wrote:
>>>> However, I think it you could create a list of <pointer to hash-table
>>>> entry, string-list index> pairs in the config_set and use that to do
>>>> the iteration. A bit ugly, but it should work.
>>>
>>> Thanks for the advice, that is exactly what I am doing.
>>
>> I'd just replace "list" with "array" and use
>> Documentation/technical/api-allocation-growing.txt.
>>
>> But I can't think of a better way.
>
> Presumably this array will reflect the order the source file told us
> about the keys and their values; I wonder if the <filename, lineno>
> information we already have can be used (or unified) with it?

I've thought about this too, and I think it would be really hard.

First, there are several files in the picture (eg. /etc/gitconfig,
~/.gitconfig and .git/config), and even included files hence it's not
even a lexical order (file, line).

Then, even if we had a way to order elements with (file, line),
iterating over the hashtable in this order wouldn't be easy (the naive
way, "get the smallest, get the second smallest, ..." would be O(n^2)).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
