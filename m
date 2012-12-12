From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: (bug?) Inconsistent workdir file timestamps after initial clone.
Date: Wed, 12 Dec 2012 18:18:41 +0100
Message-ID: <50C8BC71.8030204@web.de>
References: <50C79D1F.1080709@xiplink.com> <7vy5h47003.fsf@alter.siamese.dyndns.org> <50C7AE84.2060400@xiplink.com> <7vr4mw6x3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:19:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TipxW-0008Eb-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413Ab2LLRSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 12:18:45 -0500
Received: from mout.web.de ([212.227.17.12]:52161 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847Ab2LLRSp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 12:18:45 -0500
Received: from admins-macbook.lan ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Lm4Z3-1T9mJk2ZOr-00a6cl; Wed, 12 Dec 2012 18:18:42
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vr4mw6x3p.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:ReTXKPwwJKcsRjCiaoguhPh0GH5Zlo/Uu9JwonThX0y
 l2cKClmnokw/xbzwjUtHh+AIOC2VbFG7lHLdhGSRrxX3apAU2Z
 XluIj8SmpOCPeMBGUh1MWObvSXPZYnwrsVJC/JA/w7bPk48pDd
 bV9Ru5Rhl/5pP3FQMTBfdMUW6g24+7xUXyZyw7LnfBGNb+gSwv
 /n1HHax5O/VxKfygBnVfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211367>


 
On 11.12.12 23:30, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> My point is that the initial checkout into an empty working directory should
>> create all files with the same timestamp.
>>
>> Or, to be a bit more precise, whenever git-checkout *creates* files in the
>> work dir, *all* the created files should have the *same* timestamp (i.e. the
>> current time measured at the start of the checkout's execution, not some
>> bizarro other time specified by some arcane heuristic).
> 
> My knee-jerk reaction is that it is insane to do so, but what other
> SCM does such a thing? Even "tar xf" wouldn't do that, I think.
> 


ClearCase is doing such a thing.

You need to check out a file to make it writable:
"cleartool checkout main.c"
[hack hack]
If you after some hacking don't like your changes at all,
you run 
"cleartool unco main.c" (Undo checkout)
(In git we just use "git checkout")

While in ClearCase the timestamp of your file jumps back to where
it was before the checkout, it gets the current timestamp in git.

One consequence is that ClearCase users may wish to use "ClearMake"
rather then make.

A better make (which records all timestamps somewhere) would be helpful.

>>> While not including files that can be rebuilt from the source may be
>>> the ideal solution, I've seen projects hide rules to rebuild such a
>>> "generated but needs special tools to build" and/or a "generated but
>>> normal developers do not have any business rebuilding" file (in your
>>> case, Makefile.in) in their Makefiles from the normal targets (like
>>> "make all") for this exact reason, when they choose to distribute
>>> such files by including in their commits.
>>
>> I prefer to use the third-party code as-is, without hacking it, to have
>> smooth upgrades in the future.
> 
> Then perhaps take the complaints to that third-party upstream, not
> here?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
