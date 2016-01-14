From: David Ware <davidw@realtimegenomics.com>
Subject: Re: [PATCH v5] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Fri, 15 Jan 2016 09:45:43 +1300
Message-ID: <CAET=KiWjVr5h8nfU2DfUHGvzc7Tq7LoDWym7zXPq1Nvf+xHCCg@mail.gmail.com>
References: <CAPig+cSfkz=SNOn+8yP-QN8gJ0ej1wo3HW+y3NO+QvUCOP=+8A@mail.gmail.com>
	<1449695853-24929-1-git-send-email-davidw@realtimegenomics.com>
	<87y4bunopj.fsf@waller.obbligato.org>
	<CAET=KiVY5g41YgCbGqDqUaDjrd-Do9jNf=1L6xbBPcUoGcM2Kg@mail.gmail.com>
	<87bn8o97mh.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:45:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJomD-0007QZ-5V
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 21:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbcANUpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 15:45:45 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33032 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbcANUpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 15:45:44 -0500
Received: by mail-vk0-f52.google.com with SMTP id i129so149421409vkb.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 12:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=si0zgWqq0O4W7j6oCaoQwOT1BH/pZXdpIXtOdR9qJ5M=;
        b=ov5StI8VtFHi4l0tp9bcocW82xc5swRSGsHoWHSFPMkufA1l2lFhPUFKmwK+dgD9kI
         jnC4wjajeCBJZJt0TSkt5RmOn3qtYp4paym3dPaPfWHVXYlLO2/XrJM3u/8RqrVu8Kf3
         5K0Ot9NA4drbcH3Sf75wfulls9y+NYrDwubb+gE4trAV/4B1YVT11GZd+yY3Lisf29/7
         JRD5JdmQZrz/+1NFoKda9Nu0qQf5RIu2SYVBgOSE7VFsM0yIkyL48aMl6kXhlN5Jq2tI
         UogA5gN7cYkMwGcP8LmxsWJhz2CYPGzcROKffqqgn5A3Nsw4QUGMarQxGAsfEOag95i1
         +NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=si0zgWqq0O4W7j6oCaoQwOT1BH/pZXdpIXtOdR9qJ5M=;
        b=XrVY3ZSCINz0qFh9LO02nwc+FM0FPuFUGGqQF9KHgCSZLQ1YUpuMa6VLvDUHMcW/11
         EEQaTfe/XbLya0nUNpKI0ewqSENkqU0lhXJOD/9jv//VE/aWbfpfo7Q8KNBDrMDs9/Vp
         2WGdPb0CzbG1db4yvYRe8BGZdNsxyCtmEP3XD5xYABSYlLBrz6Z8TwyNsyh3nM9efJ5/
         2MZulUV/Vq2I7cOshFI55CDymKc+iFJEio7OeNdMOhcGAeBT7FjHpB/JCg2FQckrr0lT
         F69j6GpJ9xEumvacjnZM5jCyiONMrJxngIYf1GC/j0NmMF2UvV26Mw1bBps3fyINrPgA
         6Oug==
X-Gm-Message-State: ALoCoQlfGqdIvqoKuRBtpkyZsio/E5w5SUryid/o1zFl9GKj537y45nisKnm68V7IkpGuPtnYCf9CtN0qWJyi1wPoOqQ79ZN3LQBMNlpGJ7l4QgAsf5yX1Y=
X-Received: by 10.31.157.204 with SMTP id g195mr4702778vke.79.1452804343455;
 Thu, 14 Jan 2016 12:45:43 -0800 (PST)
Received: by 10.31.161.206 with HTTP; Thu, 14 Jan 2016 12:45:43 -0800 (PST)
In-Reply-To: <87bn8o97mh.fsf@waller.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284089>

On Thu, Jan 14, 2016 at 4:12 PM, David A. Greene <greened@obbligato.org> wrote:
> David Ware <davidw@realtimegenomics.com> writes:
>> The commit was made against v2.6.3, when I try to apply the patch
>> against master it fails.
>
> Any ideas why?

"git am" (a command I have never used before) Fails like so

Applying: contrib/subtree: fix "subtree split" skipped-merge bug
error: patch failed: contrib/subtree/t/t7900-subtree.sh:468
error: contrib/subtree/t/t7900-subtree.sh: patch does not apply

It doesn't even put any files into a conflict state.
I guess it's because of the hefty test refactoring you mentioned.

>
>> However I can verify the test passes for me when applied against
>> v2.6.3, and it also passed if I merge my patched copy of v2.6.3 into
>> master.
>
> I don't think the subtree split code has changed at all in that period
> and the logs bear that out.  So there must be some change in
> v2.6.3..master that confounds your patch.
>
> Re-checking the patch submission guidelines, it looks like bugfixes
> should be based against maint.  I did that and the test still fails with
> your changes.  It seems like we ought to rebase to maint and continue
> our investigation there.
>

Hmm, the patch fails to apply for me there also. Same issue with
contrib/subtree/t/t7900-subtree.sh

I haven't worked with mailed patches at all before, so it is possible
I'm not using the correct workflow (I just saved the raw email I
received for the patch as txt and fed it to 'git am').
Cherrypicking the commit onto maint works fine though, and the test
passes for me in this situation.

>> The process I'm using to run the tests is a little strange though, it
>> seems I have to make git, then make contrib/subtree, then cp
>> git-subtree to the root before running the Makefile on the tests.  Let
>> me know if there's a less strange process for running the subtree
>> tests.
>
> I actually have an update that makes this easier but I haven't submitted
> it yet.  But yes, you've got the current process right.
>

That will be nice.

> Ok.  Your patch applied cleanly to maint and maint has the latest
> version of the test file.  It should be just a matter of following what
> the other tests do.  I'm more than happy to guide you through it.
>
>>>> +             git branch noop_branch &&
>>> [...]
>>>> +             git checkout noop_branch &&
>>>> +             echo moreText >anotherText.txt &&
>>>> +             git add . &&
>>>> +             git commit -m "irrelevant" &&
>>>
>>> This is unfortunate naming.  Why is the branch a no-op and why is the
>>> commit irrelevant?  Does the test test the same thing without them?  I
>>> not they should have different names.  If so, why are these needed in
>>> the test?
>>>

As noted above I can't get the patch to apply cleanly to maint for me,
but I suppose it doesn't matter since I'm about to mail in a new
version created against maint.
I've rewritten the test to use the repo/commit creation methods, and
renamed that branch. I've also added the comments you requested, and
changed the push to an ancestor check.
I'll be submitting the new version of the patch shortly.

Cheers,
Dave Ware
