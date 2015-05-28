From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/2] for-each-ref: re-structure code for moving to 'ref-filter'
Date: Thu, 28 May 2015 13:26:54 +0200
Message-ID: <vpq1ti1vt6p.fsf@anie.imag.fr>
References: <556317F8.2070609@gmail.com>
	<1432557943-25337-1-git-send-email-karthik.188@gmail.com>
	<xmqqegm4bmtg.fsf@gitster.dls.corp.google.com>
	<vpqpp5nfiea.fsf@anie.imag.fr> <5566BEF2.2000301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 13:27:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxvxu-0002JB-U5
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 13:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbbE1L1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 07:27:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53634 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824AbbE1L1E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 07:27:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SBQr8c007897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 13:26:53 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SBQsbv007470;
	Thu, 28 May 2015 13:26:54 +0200
In-Reply-To: <5566BEF2.2000301@gmail.com> (Karthik Nayak's message of "Thu, 28
	May 2015 12:38:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 13:26:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SBQr8c007897
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433417214.69188@BXfdkcYYnmRmQ9+dvDKa/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270137>

Karthik Nayak <karthik.188@gmail.com> writes:

> On 05/26/2015 09:19 PM, Matthieu Moy wrote:
>> Seconded. Some reasons/guide to split:
>>
>> * Split trivial and non-trivial stuff. I can quickly review a
>>    "rename-only" patch even if it's a bit long (essentially, I'll check
>>    that you did find-and-replace properly), but reviewing a mix of
>>    renames and actual code change is hard.
>>
>> * Split controversial and non-controversial stuff. For example, you
>>    changed the ordering of fields in a struct. Perhaps it was not a good
>>    idea. Perhaps it was a good idea, but then you want this reordering to
>>    be alone in its patch so that you can explain why it's a good idea in
>>    the commit message (you'll see me use the word "why" a lot when
>>    talking about commit messages; not a coincidence).
>
> Since one of the patches is to restructure and rename 'for-each-ref', I thought
> It would be ideal to introduce the data structures within that patch, What do you
> think?

I don't have a universal answer: in general I prefer (let's say "this
list prefers") splitting as much as possible. It may make sense to group
"add data structure X" with "use data-structure X" to make sure that
functions you introduce have a caller.

What's clear is that your PATCH 1/2 is not split enough. Just go through
it, you'll see code movement (a pain to review in patch format),
straigthforward renamings (easy to review as-is, but disturbs the
reviewer when mixed with something else) and actual new code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
