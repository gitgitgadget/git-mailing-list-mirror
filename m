From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] update-index: allow overwriting existing submodule index
 entries
Date: Mon, 11 Jun 2012 23:23:15 +0200
Message-ID: <4FD661C3.7000105@web.de>
References: <CAOkDyE9q1n=oLoEXXxurDjNM0B2+cZ9eoeGE57F9hEQUjK0hZg@mail.gmail.com> <20120609142658.GB16268@book.hvoigt.net> <7v3961ao1q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Adam Spiers <git@adamspiers.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeC5O-0006zd-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab2FKVX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:23:29 -0400
Received: from mout.web.de ([212.227.17.12]:62574 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab2FKVX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:23:26 -0400
Received: from [192.168.178.48] ([91.3.177.48]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MY6sm-1SQuOt1IPY-00VKUP; Mon, 11 Jun 2012 23:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7v3961ao1q.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:UBEnVX1Wp3KmTDlMkGylV09OCoBucETAiMkTj2SQDDg
 +3lM9Q0kIg8dD3F57MxrnzCh684NPUwt/rIWuzoc5OordAwN9E
 KEpcPgSCheE9KAggnFV3/EWVGrn0bwfHpv0UIGA/LnOMeC0Y5v
 TML2QpOBF2fF/ZRszGEZkpT11m9Q2jQXpMQmHGftu59sDmbrKx
 B4+jD2HkohYZ2MjnaBkgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199734>

Am 11.06.2012 17:03, schrieb Junio C Hamano:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
>> In commit e01105 Linus introduced gitlinks to update-index. He explains
>> that he thinks it is not the right thing to replace a gitlink with
>> something else.
>>
>> That commit is from the very first beginnings of submodule support.
>> Since then we have gotten a lot closer to being able to remove a
>> submodule without losing its history. This check prevents such a use
>> case, so I think this assumption has changed.
> 
> Yeah, I think we should remove it if only to make it consistent with
> "add" (if anything, the Porcelain level "add" should be the one that
> is more strict and the plumbing level should be able to let you
> shoot in the foot, not the other way around), but we need to make
> sure "closer to" becomes reality. Can we remove and the resurrect
> automatically when checking out a branch with a submodule when you
> are on a branch with a directory and vice versa?

Even while I suspect most of the time a submodule <=> directory
transition will occur (moving directory content into a submodule
or vice versa; and then there will be no replacement of a gitlink
with something else as only the files inside the directory will be
recorded) there is no reason why submodule <=> file or submodule
<=> link transitions shouldn't work just fine. So yes, we can ;-)
(See the recursive_submodule_checkout branch in my GitHub repo for
current state of affairs, even though not all transitions work yet
some do just fine)

If you want I can keep this patch in my GitHub repo until "closer
to" becomes reality. Me too thinks that plumbing should not enforce
this restriction, but I wouldn't mind to hold this patch back until
then.
