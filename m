From: Jeremy Scott <jeremy@great-scotts.org>
Subject: Re: files deleted with no record?
Date: Fri, 27 Jun 2014 06:57:48 +1000
Message-ID: <CAFDwLfwdcka25o0S_-ekb+AAFRVDADeiZD1f5kXJczqei=e3eg@mail.gmail.com>
References: <CAFDwLfyXrUZUUuaciAjamn-cXJ6mAv_D41zLwT4AZE=cmAX7rg@mail.gmail.com>
	<CABURp0p6amKmhMhOUzdKy0a8TY7bmPoSLM0sUnZfGErhyfLsEQ@mail.gmail.com>
	<7298A047128B405F94F5E73903089107@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 22:57:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Gjx-00028a-Os
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 22:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbaFZU5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 16:57:50 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:55866 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaFZU5t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 16:57:49 -0400
Received: by mail-qc0-f177.google.com with SMTP id r5so3631375qcx.22
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1CfgJDEocC/JhtUX8Shh2ZyrCFesPJaMpCBcm4Z9fhE=;
        b=BmjQub4suzr88sZu4j32LZRdmStDr8tQw11dCFHsWlB8ZErrdpOu7wz8rXpm0aKxLT
         prSDIgHHLcTsAxsvBifF8abN473uC4NThAADVfeHMrus07hZAu65uPI1AC3lcNHJm0eJ
         C8MM9ssyqx7pvo0NOLyh4YA3JcdOhoO9G0avTLokCPVB/xVbrtQxzLI47wRhxlzx1Gy4
         8K2TI6iiyCtZKjX5vds8vFutykHzc4zE444RJZtj7xSQ4LW8/rN5VEp48REPbguwIG8w
         pWCGYWAhK0XnF2Br54nQMAzJISNYdjG5CaKEvpLRG7I1+oD7pXAf48esL5EVIPBPpqAk
         vt/w==
X-Received: by 10.229.117.136 with SMTP id r8mr26044525qcq.17.1403816268980;
 Thu, 26 Jun 2014 13:57:48 -0700 (PDT)
Received: by 10.140.34.146 with HTTP; Thu, 26 Jun 2014 13:57:48 -0700 (PDT)
In-Reply-To: <7298A047128B405F94F5E73903089107@PhilipOakley>
X-Google-Sender-Auth: _oIkzlSSvjnG9nd__Qo2kYC_s2I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252525>

Hi. Thanks for getting back to me.

here is a screenshot from source tree to visualise the scenario:

https://drive.google.com/file/d/0B-Wn7DfHsuhyTEVkRHAzeGVZelpMWjFxZW1kbVBKVlNab3pR/edit?usp=sharing

I will attempt a script to reproduce this later today.

Thanks

On Fri, Jun 27, 2014 at 5:53 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Phil Hord" <phil.hord@gmail.com>
>
>> On Mon, Jun 23, 2014 at 9:15 PM, Jeremy Scott <jeremy@great-scotts.org>
>> wrote:
>>>
>>> I just encountered a situation where a merge was made, with no
>>> apparent changes in files (ie no log), but the result was that some
>>> files were deleted.
>>>
>>> person A adds some files
>>> person B adds some files from the same point
>>
>>
>> You mean from the same point in history, right?  Not files with the
>> same filename or path?
>>
>>> person B commits and pushes.
>>> person A commits -- now merge is required
>>> a few more commits on top of person B's commit
>>
>>
>> I don't understand this step.  Who adds a few more commits on top of B and
>> why?
>>
>>> person A merges - this removes the files that B added. There is no log
>>> of the files being deleted
>
>
> A similar issue, by reference, just came up on the [git-users] list. The
> reference was:
> 1. http://randyfay.com/content/avoiding-git-disasters-gory-story
>
> In that case the problem was a mixture of tools and  misunderstandings.
>
> It may not be the same as your case, but could give insights into what's
> happening between different developers.
>
> Which Tools are You, person A and Person B using, with --version?
>
>>
>> This sounds like an "evil merge" (see man gitglossary, and google),
>> but it's not clear to me how you arrived here.
>>
>> When I tried to reproduce your issue with this script, it did not
>> remove any files unexpectedly:
>> ------------------->8-----------------------
>> #!/bin/sh
>>
>> set -e
>> mkdir foo && cd foo && git init
>> echo foo > foo && git add foo && git commit -mfoo
>>
>> git checkout -b PersonA master
>> echo bar > bar && git add bar
>> git commit -m"PersonA: bar"
>>
>> git checkout -b PersonB master
>> echo baz > baz && git add baz
>> git commit -m"PersonB: baz"
>>
>> echo foo-conflict >> foo && git add foo
>> git commit -m"PersonB: foo"
>>
>> git checkout PersonA
>> echo foo-different >> foo && git add foo
>> git commit -m"PersonA: foo (conflicts with PersonB)"
>>
>> git log --oneline --all --stat
>>
>> if ! git merge PersonB ; then
>>  git checkout PersonA foo
>>  git commit --no-edit
>> fi
>> git log --oneline --graph --stat
>> ------------------->8-----------------------
>>
>> A sneaky issue with merges is that they do not have a clear way to
>> show patch information -- the diff between the commit and its ancestor
>> -- because they have multiple ancestors.  You can show diffs for a
>> merge relative to each of its parents, but it is not usually done for
>> you automatically.  This is why making changes in a merge which are
>> not actually required for the merge is bad ("evil").
>>
>>> Clearly this is possible - was this a user error?
>>
>>
>> Probably, but we'd need to see how the user got there.
>> --
>
> Philip
