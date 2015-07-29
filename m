From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Log messages beginning # and git rebase -i
Date: Wed, 29 Jul 2015 18:03:47 +0200
Message-ID: <vpqmvyfeysc.fsf@anie.imag.fr>
References: <loom.20150727T133256-715@post.gmane.org>
	<CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
	<loom.20150728T115023-269@post.gmane.org>
	<vpqsi88qp6q.fsf@anie.imag.fr>
	<xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com>
	<vpq3808p40o.fsf@anie.imag.fr>
	<CACsJy8ABsHBA1TubB+6fypT0LGQF_O+CmHPqL+C7nMVjjWy38w@mail.gmail.com>
	<vpq8u9zjgzl.fsf@anie.imag.fr>
	<xmqqvbd39cxj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Ed Avis <eda@waniasset.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:03:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTpl-0002Zh-5k
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 18:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbbG2QDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 12:03:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42490 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbbG2QDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 12:03:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TG3jvf013075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 18:03:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TG3lK0021183;
	Wed, 29 Jul 2015 18:03:47 +0200
In-Reply-To: <xmqqvbd39cxj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Jul 2015 08:54:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 Jul 2015 18:03:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TG3jvf013075
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438790625.78887@vIu0K5ddUPQXNlWZeBJ4kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274913>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Wed, Jul 29, 2015 at 12:48 AM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>>> If the user wants whatever she types in the resulting commit
>>>>> literally, there is the "--cleanup=<choice>" option, no?
>>>>
>>>> $ GIT_EDITOR=touch git commit --cleanup=verbatim
>>>> [detached HEAD 1b136a7] # Please enter the commit message for your
>>>> changes. Lines starting # with '#' will be kept; you may remove
>>>> them yourself if you want
>>>> to. # An empty message aborts the commit. # HEAD detached from
>>>> 5e70007 # Changes to be committed: # modified: foo.txt # # Changes
>>>> not staged for commit
>>>> : #     modified:   foo.txt # # Untracked files: #      last-synchro.txt #
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> You really don't want that in day-to-day use.
>
> I do not quite follow this example.
>
> The user said "I'll be responsible for cleaning up" by giving the
> option.  It is up to the user to use an editor that is something a
> bit more intelligent than "touch" to remove the instructional
> comments meant for humans after reading them.

Yes, --cleanup=verbatim does what it says it does. Now, my claim is that
it does not answer the use-case "I want an easy way to talk about # in a
commit message". First, you have to specify --cleanup=verbatim _before_
typing the message, hence before knowing that you may need a #.

Then, as you say, it is up to the user to remove things that Git has
added. Why would we ask the user to do this when we have a way to have
the tool do it?

>> 2) Modify Git to add scissors by default, and use --cleanup=scissors by
>>    default.
>
> I just did "$ git commit --amend --cleanup=scissors" (with and
> without --amend) and it seems to do exactly that ;-).

Ah, I did my test in the same repo I messed-up with --cleanup=verbatim.
It's better than I thought then. So a viable alternative to the
backslas-escaping would be to change commit.cleanup to scissors by
default.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
