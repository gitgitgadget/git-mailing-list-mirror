From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Wed, 29 May 2013 06:56:54 -0500
Message-ID: <CAMP44s2de-kNnxQvLNE5QrDFYMX=Omyu61+J=Dbxp0of3iYGxg@mail.gmail.com>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
	<1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
	<7vobbv119k.fsf@alter.siamese.dyndns.org>
	<87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
	<51a56bef1b9c2_807b33e1899991@nysa.mail>
	<877giixl4c.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s3vkJCr2f2zsZU++j4Wqxuefmpt8BQ9dJoP=JtTB=rgkQ@mail.gmail.com>
	<87y5ayqivi.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s2aAvzeTtHb=rVP1TrCMcQjyqN6O7n1DYZLx0uJrm1j+w@mail.gmail.com>
	<874ndmqate.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 29 13:57:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhf02-0003LR-32
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965615Ab3E2L46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:56:58 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:58845 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965418Ab3E2L45 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:56:57 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so8834360lbi.4
        for <git@vger.kernel.org>; Wed, 29 May 2013 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VXz+/U8iJqkfs4rzPbYPDGky6/P+6GBB35vMdhbhLWo=;
        b=SfW2T7xu9+u+v/U2SCppJsl9aP3ZQ9uPqGHCvWCYG4XHEfsCTuWa+Q6NJUyXw/rJHK
         z44hIpy4hRuC+r+4CyEegMrpQ1Ddd5kmc4Z3e22qeSVEODqe+lNLy8XGQpqxq3wLwEwu
         JzregzDWPy6BIUpet/QdI6C7Vl63TwTPMDstNAmWmHveQG0OjOk+XSSFgAv88Mt6DLI+
         zl8DPuFHWPmCeAv6g35Yz1TnCttLhatYZ2aBeSlz3KqMxMMfs64taxFrnnXeiQPjRL2N
         d9M3Ne/daoBSwAxC+n8IZBnasOqV3e7QlSeEXtGUo9UBcvdOIZd1z0dpslDOVXXZIXq/
         2j3w==
X-Received: by 10.112.88.166 with SMTP id bh6mr1454196lbb.47.1369828614271;
 Wed, 29 May 2013 04:56:54 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 04:56:54 -0700 (PDT)
In-Reply-To: <874ndmqate.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225794>

On Wed, May 29, 2013 at 6:34 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, May 29, 2013 at 3:40 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> On Wed, May 29, 2013 at 3:09 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>>> Feel free to implement that. I'm just interested in 'git cherry-pick' being
>>>>>> usable for 'git rebase' purposes.
>>>>>
>>>>> Which would have been obvious to all but the most casual readers, eh?
>>>>
>>>> My motivations are irrelevant, the patch is good as it is.
>>>
>>> You fooled both Junio (AFAICT anyway) and me, who both reviewed the
>>> patch under the assumption that it implements note copying *along the
>>> lines of existing note copying*.  This proved to be a wrong, and
>>> time-wasting, assumption.
>>
>> Whatever arbitrary rules you are talking about, they are not codified in tests.
>
> Tests or code don't have a thing to do with it.  This is about how you
> are presenting your changes to the rest of the git community.  As
> evidenced above, said presentation is not clear enough to communicate
> your goals to at least two experienced git developers (if I may say so
> myself).  How are we supposed to review a change if it is not even clear
> what goal it satisfies?

My goals are irrelevant. This patch is good.

It implements a missing feature, if you don't like how it is implemented it:

a) Implement the code in the note framework that does it properly so
other people can just call that.

b) Implement the tests for other commands that check that the behavior
you talk about does happen indeed.

c) Implement it yourself

This has nothing to do with the way I presented the patch. I presented
the patch as I thought it was; implementing the note copying as it was
intended. Now you came along and say I wasted your time because I
didn't say I implemented it wrongly, and you assume bad faith and what
not.

This wouldn't have happened because you didn't do a) or b). I realized
that by replacing 'am' with 'cherry-pick' in 'git rebase'  the notes
were not copied, according to the testing framework, so I implemented
that, and the tests pass. Now you come along and say it should
implemented some note.rewrite.command stuff, but the tests didn't
check for that, so how was I supposed to know?

And then you have the audacity to claim that *I*, the one who just
wrote a bunch of code to implement a missing feature, is wasting
*your* time, you, the one who is simply replying to an email and
shooting from the hip.

> Again: I'll be happy to review your proposed changes if and when you
> resend the series with commit messages.

I won't, I'll keep working on my actual objective.

Plus, this patch does have a commit message, and the commit message
says *EXACTLY* what the patch is doing: add support to copy notes.

If *you* are interested in certain behavior, why don't you lift a
finger and do something to make sure that such behavior is easy to
implement and the test framework actually checks for that?

-- 
Felipe Contreras
