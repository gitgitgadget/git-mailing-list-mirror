From: Luke Diamand <luke@diamand.org>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Tue, 17 May 2016 09:35:57 +0100
Message-ID: <CAE5ih79qUv237GXfW24HdJrx0WBiK4uvuWXe+d3v7NiOVtwHGQ@mail.gmail.com>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
	<20160513103621.GA12329@dcvr.yhbt.net>
	<xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
	<4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
	<xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>, Eric Wong <e@80x24.org>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 10:36:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2aU5-0008Fe-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 10:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbcEQIgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 04:36:04 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33421 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbcEQIf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 04:35:58 -0400
Received: by mail-oi0-f43.google.com with SMTP id v145so13968493oie.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=SM+OJXtb6EswMDpRZuLenwg9RserTPqBez8pbxLVq2w=;
        b=Jm0KyiMwEm6SxwhuutMnIEe/8EGbZV6vB3F1OfmvNFE1WI6chB9W+iYvcacJBF5fkN
         aXkWuvkP5veWfqZaDgO3feEM9Jjp7M4SyIMtUTGl6rHxZZlmbYIZ+WL396Hg5VFRJyVI
         jT+2+OcGAOZ975jvohF0w3UuF7UpDMzIHagLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=SM+OJXtb6EswMDpRZuLenwg9RserTPqBez8pbxLVq2w=;
        b=P9AjUHvGxfBO9zxZCwYjfPNF+48oHpoXqcI+sZ6xddLnQFgymFz085JU8RSovK5G2v
         FLco/rL0yJLyyHZSgEPgVKA7tpyKTtcoN3NvvPhJhw5rAgnnn/rzrTOk8ebUfGZFf6OF
         nM/926UMi5Pr2+KCJRgqSXqcvv1ncTxQkzunCZ2trROTqV5+CQuEzwU5vZUv4SoEfAR5
         ysPgdpK+g5qDvSXCfHijcBKEeoBfZBDecjjI9N9A0LXJRWVjkG3qpw69hPQQ2AZaLoa5
         paWTM9vLzykx9gSfagBn1VFEufQGLyja91S2GOcHaQJEhIt/aaFSoa+4AhMsW9YPrTmn
         gATQ==
X-Gm-Message-State: AOPr4FVka8vFOKjSPP2Q1TJ0XmhOUBvn2A1BJfcK8Ew2F81+VqDsx+vN33YhEMMriffLrhGJ8v2SbMQQybFn3g==
X-Received: by 10.157.33.130 with SMTP id s2mr21533otb.120.1463474157636; Tue,
 17 May 2016 01:35:57 -0700 (PDT)
Received: by 10.157.37.57 with HTTP; Tue, 17 May 2016 01:35:57 -0700 (PDT)
In-Reply-To: <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294860>

On 14 May 2016 at 19:15, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
>
>>> On 13 May 2016, at 18:37, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Are you saying that "git p4" itself breaks unless fast-import always
>>> writes a new (tiny) packfile?  That sounds quite broken, and setting
>>> unpacklimit to 0 does not sound like a sensible "fix".  Of course,
>>> if the test script is somehow looking at the number of packs or
>>> loose objects and declaring a failure, even when the resulting
>>> history in p4 and git are correct, then that is a different issue,
>>> and forcing to explode a tiny pack is a reasonable workaround.  I
>>> couldn't quite tell which the case is.
>>>
>>> Puzzled.  Please help.
>>
>> t9801 "import depot, branch detection" is the first test that fails
>> with a fast import error:
>> https://github.com/git/git/blob/78b384c29366e199741393e56030a8384110760d/t/t9801-git-p4-branch.sh#L110
>>
>> fast-import crash report:
>>     fast-import process: 77079
>>     parent process     : 77077
>>     at 2016-05-14 07:48:40 +0000
>>
>> fatal: offset beyond end of packfile (truncated pack?)
>
> Hmm, does that suggest Eric's "explode them into loose instead of
> keeping a small pack" insufficient?  It sounds like that somebody
> wanted to read some data back from its packfile without knowing that
> the updated code may make it available in a loose object form, which
> would mean that somebody needs to be told about what is going on,
> namely, these objects are not in a half-written pack but are found
> as loose objects.
>
>> The problem seems to be related to the git-p4 branch import.
>> I don't have time this weekend to look further into it, but
>> I will try next week.

The last thing that fast-import is sent before it crashes is this:

checkpoint
  progress checkpoint
  commit refs/remotes/p4/depot/branch2
  mark :6
  committer Dr. author <author@example.com> 1463212118 +0000
  data <<EOT
  from 1ab0d5b43b6070682f8bd6f3fd674d4fcddd9345

i.e. creating a new branch, referring to an existing object. Is it
possible that fast-import can't find 1ab0d... because of the reasons
given by Junio above? I don't know enough about fast-import tbh.

I will see if I can get fast-import to tell me a bit more about why
it's failing.

Luke
