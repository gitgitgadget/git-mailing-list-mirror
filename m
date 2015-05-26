From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Pushing and pulling the result of `git replace` and objects/info/alternates
Date: Tue, 26 May 2015 16:10:11 +0200
Message-ID: <CACHsx4KzkiuRt4BrCPM4fQ-15K+f4q47AXuXFgZv7xxEB=WO6A@mail.gmail.com>
References: <CACHsx4Kz3_bMbKqd1O7-ZXLBUqJBs6hTsiRNAALNJhDV44v6Rw@mail.gmail.com>
	<CAP8UFD3G8_ChRX6HHtieFTksUJBiXu9FLNbewFQVj7qPyGh8EQ@mail.gmail.com>
	<5562F01D.8000601@gmail.com>
	<CAP8UFD20u1OG88bvDAW4vsh=yPihp3TMjc95wDuD=nnr8esBgw@mail.gmail.com>
	<CACHsx4LDrU7DET-QAMsZE9+-7BmVbu-T0zLf7Nm8E9qX518rGQ@mail.gmail.com>
	<CAP8UFD2ZYYkjFvZGF_ChQhjZRuCmBZ2qKvoLhAoDHYUJ5A07+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 26 16:10:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxFYj-0005SO-JT
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 16:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbbEZOKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 10:10:15 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35413 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbbEZOKN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 10:10:13 -0400
Received: by lbbuc2 with SMTP id uc2so71369835lbb.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=rUqncgRPVm1El++yZSFYdRPaT0GcSsdMUXpzzocB92U=;
        b=yzLNsKsjWnULWvvTvyfkODmAFPNHlb41gczUsy/sXrLYKTd5mtMzwpoyjqQWgs/JUz
         OdfAd4vG0RVtBWDmcbx/izTg6/TAnntMXFLrY14uHoh7zxKLruKfO73mAi29K9keqhgs
         ykLkg1s8PPx0OLIwAYeoDLJKYYZekD4DWN04dUP+JX3C6BYaZU0NPDKX2ojDGUFlO+dh
         HKJca34Jw8BROSO+vLDtTB4NuEl86W89zMKehLqU1orkTBC7TYqpif1+RRsuUdF9sxB5
         1W+vp5xSc44Bo5LTAn+H4PBwcFUamBCjntx45nulUiB9oORplMMI7lISkzVB4R8opFVi
         cg7g==
X-Received: by 10.112.83.135 with SMTP id q7mr23217295lby.13.1432649411882;
 Tue, 26 May 2015 07:10:11 -0700 (PDT)
Received: by 10.114.200.16 with HTTP; Tue, 26 May 2015 07:10:11 -0700 (PDT)
In-Reply-To: <CAP8UFD2ZYYkjFvZGF_ChQhjZRuCmBZ2qKvoLhAoDHYUJ5A07+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269940>

On Tue, May 26, 2015 at 12:39 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> First it looks like you sent the email to me only, so I am replying to you only.
> If this was a mistake, feel free to post this email to the Git mailing list.

Thanks, sorry for the mis-post.

>> 1) How would Alice push the content to a remote host so that Bob would
>> get that automatically?
>
> I am not sure what you want exactly, but let me try to answer anyway.
>
> Let's suppose that the content is in another submodule, let's call it
> subA, and let's call subB the submodule that should reference content
> in subA.

Yes, that's the scenario in my script.

> If subA has been pushed on the remote host, then Bob can clone subA
> first, and then clone subB using the --reference option to point to
> the content of subA.

Ah. Here's some confusion maybe.

Alice pushes subA and subB *and* the supermodule. In my script, these
were named calculator, compute and appsuite. The supermodule is the
entry point that everyone uses.

Bob clones the supermodule, appsuite, and expects that to 'just work'
regarding history.

So, I want to somehow specify the --reference in the .gitmodules of
the appsuite supermodule. Then when Bob runs git submodule update
--init, the right thing will be done.

>
> Please note that I don't know much about git submodules, as I try not
> to use them myself,

Me too :), but needs must.

> so I am not sure there is a way to make them do
> exactly what you want. Maybe you should look at the threads about
> submodules on the Git mailing list, see who are the people involved
> and send an email on the list with those people in CC and a subject
> related to submodules and with your specific questions about
> submodules in the content.

Ok, thanks. I think the solution of running a script after initial
clone/update is probably the most suitable for now anyway without
getting deeper into git.

> For example I don't know if there is a way to tell that subA should be
> cloned before subB or something like that.

Right. A step of performing actions like this would need to be done
after all fetches are done I guess.

>> 2) Can git submodules be configured to use particular options when
>> cloning particular repos? I see no relevant options in the
>>
>>  https://www.kernel.org/pub/software/scm/git/docs/gitmodules.html
>>
>> page.
>
> I don't know. Maybe it's possible to add a
> "submodule.<name>.cloneOptions" option to specify them. Or maybe it's
> possible to use the "submodule.<name>.update" config option with a
> specific command (see "custom command" in
> http://git-scm.com/docs/git-submodule) to do it.

Yes, actually the 'custom command' section there might be useful... I
might try it.

>>> You might also be able to clone using an option like "--config
>>> remote.origin.fetch = 'refs/replace/*:refs/replace/*'" to fetch the
>>> replace ref when cloning.
>>
>> Cool, but I guess the same second question applies here about whether
>> a submodule can be configured to fetch like that when the user does a
>> update --init ?
>
> Yeah, the same question applies.
>
>> Otherwise, I'm not sure what you are suggesting.
>
> I am not suggesting anything else.
>
>>>>>> echo "../../calculator/objects" >
>>>>>> ../.git/modules/compute/objects/info/alternates
>>>>>> git replace --graft HEAD $extraction_sha
>>>>> Maybe use the following instead of the above line:
>>>>>
>>>>> git fetch 'refs/replace/*:refs/replace/*'
>>>>
>>>> Thanks.
>>>>
>>>>>> # And now we see the history from the calculator repo. Great. But, it
>>>>>> required user action after the clone.
>>>>> Yeah, but if the 2 above commands are in a script maybe it's
>>>>> reasonable to ask the user to launch the script once after cloning.
>>>>
>>>> Would it be possible to do this in a hook in the 'integration repo'
>>>> which contains both submodules in the example I posted? Like a fetch
>>>> hook or something?
>>>
>>> It is possible to do whatever you want in a hook, but the question is
>>> why would you do it in a hook as it looks like it needs to be done
>>> only once?
>>>
>>> Or maybe I am missing something?
>>
>> The goal is to make it transparent to users, so that no one needs to
>> remember to 'do something once', but just gets a working checkout by
>> cloning the submodule in the plain, normal, 'what you learn on day
>> one' way. That is,
>>
>> git clone git://some/remote/appsuite appsuite-clone
>> cd appsuite-clone
>> git submodule update --init
>> cd compute
>> ls ../.git/modules/compute/objects/info
>> git log --oneline
>>
>> should show the history despite the split.
>
> Yeah, it would be nice if that would work, but, I am not sure it can
> work like that right now.
>
> And using hooks doesn't change anything as you have to setup those hooks anyway.
>
>>> So it looks like you might just need to clone with a few more options
>>> than usual.
>>>
>>> I haven't tested it so please tell me if it works :-)
>>
>> I changed the last 20 or so lines with one of your suggestions. I put
>> the initial revision and the update on a gist:
>>
>>  https://gist.github.com/steveire/a57bc48a460e11284d81/revisions
>>
>> The script I posted is easy to modify if you want to try something
>> out. I would be happy if you would try it out and see if you can make
>> your suggestion work.
>
> I tried it and it looks like it works for me as it works for you.
>
> There is:
>
>> git fetch origin 'refs/replace/*:refs/replace/*'
>> # Don't seem to need this? Why?
>> # Does the push of the replace refs copy them to the remote repo?
>> # How do I find out?
>> # echo "../../calculator/objects" > ../.git/modules/compute/objects/info/alternates
>
> The above comments probably mean that you didn't expect that fetching
> replace refs would also fetch the git objects (commits, trees, blobs,
> ...) pointed to by the replace refs. But that's what fetching does
> with any king of ref (branches, tags, notes and replace refs).

Actually, what I didn't expect is that

 # Push the replacement to the remote submodule clone
 git push origin 'refs/replace/*'

would push a copy of the content reachable by the 'refs/replace/*',
totally bypassing what I did with info/objects/alternates.

I updated the gist again with some output which I think shows that
that is happening.

 https://gist.github.com/steveire/a57bc48a460e11284d81/revisions

> Yes, this means that you need the commented "echo ..." line above,
> only if you don't want objects to be duplicated. But what you should
> really do in this case, is first use the "echo ..." line, and then
> fetch the replace refs.

Because the issue occurs with the push, I don't think this will help.

> If I have time, I will have a look at using the
> submodule.<name>.update option to see if it can help.

Thanks for your help so far!

Steve.
