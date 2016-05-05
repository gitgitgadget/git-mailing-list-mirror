From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Thu, 5 May 2016 12:57:25 -0700
Message-ID: <CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
	<xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:57:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayPOt-0003uf-1m
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757389AbcEET51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:57:27 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36687 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734AbcEET50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:57:26 -0400
Received: by mail-ig0-f180.google.com with SMTP id u10so26390065igr.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=DOm9W0H3GcuoYrAm9ITclBoD7Xkrh44TaUABAULs/nw=;
        b=KLG7nPTUj9PbE8Nf3BDDeeVj0hL+bayBtHejJYXkhyzo1iDNgz4lL7jKZFZW5aMVjj
         Tfglcl1n/weBJK1YyQsj0gSjyvY02VtzMYCgXMiIE+CY5EiKl31N6Pi7QtnBJXKXC6IU
         EC0/2XjSeX1QvXBO20cLcbBHMGkrG1Wvwql5Mr6etVtlXvTQRZVr7mNEC25ZR8auI8mS
         IBgbK+FxSdsOfhRXjVE3p7Hb4k3tIAgA0Mvz1QWsKEAa+C7NL6nLRP9wbzVBtUTsdDLF
         cdj/Vl+oxmG0DKv3jTMZf8VEZI/yrLfMB1vCHizqTZdRGPZwQP4vVf3iR0NQWB2UFdPm
         s4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DOm9W0H3GcuoYrAm9ITclBoD7Xkrh44TaUABAULs/nw=;
        b=KtMdoV2JlT1+Jjj9b35l7OPZS/cXJr3R57N+ICaH7OCf6Mh1qTw6vpPy60oDBLl3+H
         6jN4LrfkfX2SmfyQkRnZlEBpeC1IJbgi2PwI39Gl44jqQrXKd75Q6Id9U8ofxuz99xRc
         P6tNwqul2agD/PdY5HADBm023+p3GFjv6KomBdj1UfxmHvqXqkhDq4S3sk8tYCIwsWVU
         GOoQnAQni7w9tSjqfhjOskGeqKqbRmmEizF9Rz7z2qaxCrKp+irBf5bBUWEishl87YbI
         Qdxv7Vd3pk9uehv3APeAFpSu/IE/3rikn1h/JMrafYtUICJCHx7uRX1w7kATHcBD9bdc
         +PRg==
X-Gm-Message-State: AOPr4FU3+X0BOfIO2QdGSRKMPEd1Z0B+yAMTDSsWDe6CsBNFEN6GqNKB4Hvg8y5BeR5B2wst6lgCPVwvr0+I/SGS
X-Received: by 10.50.170.68 with SMTP id ak4mr6006572igc.93.1462478245228;
 Thu, 05 May 2016 12:57:25 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 12:57:25 -0700 (PDT)
In-Reply-To: <CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293672>

Any thoughts on my thoughts below?

On Fri, Apr 29, 2016 at 12:17 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Apr 29, 2016 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> We do not need to do anything special to initialize the `submodule_groups`
>>> pointer as the diff options setup will fill in 0 by default.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>  diff.c | 3 +++
>>>  diff.h | 1 +
>>>  2 files changed, 4 insertions(+)
>>
>> Isn't this going in the opposite way from what you described in 0/15
>> with analogy to how "ignore" mechanism works?  Just like a path is
>> tracked once it is tracked, whether it matches an ignore pattern,
>> shouldn't we be getting a summary for a submodule for any submodule
>> once submodule/.git/HEAD is there (i.e. we can give a comparison),
>> whether it is specified by a separate mechanism that acts from
>> sideways (e.g. the "default group").
>
> That is why I started in 0/15 with
>> One pain point I am still aware of:
> as I did not do the right thing in these patches?
> These patches do however:
>
>>    git status
>>    git diff
>>    git submodule summary
>>    # show only changes to submodules which are in the default group.
>
> which seems to be the wrong thing then.
>
> So here is a thought experiment:
>
>     # get all submodules into the work tree
>     git submodule update --recursive --init
>
>     # The selected default group will not include all submodules
>     git config submodule.defaultGroup "*SomeLabel"
>
>     git status
>     # What do we expect now?
>     # either a "nothing to commit, working directory clean"
>     # or rather what was described in 0/15:
>
>         More than 2 submodules (123 actually) including
>             'path/foo'
>             'lib/baz'
>         are checked out, but not part of the default group.
>         You can add these submodules via
>             git config --add submodule.defaultGroup ./path/foo
>             git config --add submodule.defaultGroup ./lib/baz
>
> If we want to go with the second option, the design described in 0/15
> is broken. Going one step further:
>
>     # in all submodules including the excluded via groups,
>     # by resetting the groups for this command
>     git -c submodule.defaultGroup= submodule foreach git reset --hard HEAD^
>
>     git status
>     # Reporting the changes from submodules in the default Group is
> uncontroversial:
>     On branch master
>     Your branch is up-to-date with 'origin/master'.
>     Changes not staged for commit:
>       (use "git add <file>..." to update what will be committed)
>       (use "git checkout -- <file>..." to discard changes in working directory)
>
>         modified:   subA (new commits)
>         modified:   subB (new commits)
>
>     no changes added to commit (use "git add" and/or "git commit -a")
>
>     # But what about subC which is not in the default group? It was
> changed as well.
>     # one thing I could imagine, is similar to above:
>
>         More than 2 submodules (123 actually) including
>             modified:    'subC'  (new commits)
>             modified:   'lib/baz' (new commits)
>         are checked out, but not part of the default group.
>         You can add these submodules via
>             git config --add submodule.defaultGroup ./path/foo
>             git config --add submodule.defaultGroup ./lib/baz
>
>     # and the remaining 121 submodules are not reported in git status
>
>     git diff
>     # report them all below:
>     diff --git a/subA b/subA
>     index e4e79a2..6689f08 160000
>     --- a/subA
>     +++ b/subA
>     @@ -1 +1 @@
>     -Subproject commit e4e79a217576d24ef4d73b620766f62b155bcd98
>     +Subproject commit 6689f08735d08a057f8d6f91af98b04960afa517
>     ...
>      # goes on including 123 submodule not in the default group.
>
>
> In case we report these submodules which are checked out but not in
> the default group, we probably want to adapt "git submodule update" to
> un-checkout the work tree of the submodules in case they are clean.
>
> Thanks,
> Stefan
