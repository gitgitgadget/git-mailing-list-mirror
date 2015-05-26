From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Pushing and pulling the result of `git replace` and objects/info/alternates
Date: Tue, 26 May 2015 17:14:47 +0200
Message-ID: <CAP8UFD2cXZEebVdhG3wJvwGXV3wcO8HQ74zH-v2VwA5Ebge9AQ@mail.gmail.com>
References: <CACHsx4Kz3_bMbKqd1O7-ZXLBUqJBs6hTsiRNAALNJhDV44v6Rw@mail.gmail.com>
	<CAP8UFD3G8_ChRX6HHtieFTksUJBiXu9FLNbewFQVj7qPyGh8EQ@mail.gmail.com>
	<5562F01D.8000601@gmail.com>
	<CAP8UFD20u1OG88bvDAW4vsh=yPihp3TMjc95wDuD=nnr8esBgw@mail.gmail.com>
	<CACHsx4LDrU7DET-QAMsZE9+-7BmVbu-T0zLf7Nm8E9qX518rGQ@mail.gmail.com>
	<CAP8UFD2ZYYkjFvZGF_ChQhjZRuCmBZ2qKvoLhAoDHYUJ5A07+A@mail.gmail.com>
	<CACHsx4KzkiuRt4BrCPM4fQ-15K+f4q47AXuXFgZv7xxEB=WO6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 17:14:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxGZC-0005Ct-Gc
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 17:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbbEZPOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 11:14:50 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36845 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbEZPOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 11:14:48 -0400
Received: by wgbgq6 with SMTP id gq6so100290910wgb.3
        for <git@vger.kernel.org>; Tue, 26 May 2015 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H/7m4P2bJcipU9V90Mn0/ITWnKwtOaPKoaS7XVlfeG8=;
        b=RKQ8GuurEYzOkB5OjiGgBmyDh5LGa1qQYTVLj2o4rGmYYTxpWvMnYK3Lx7f3M0Pax5
         yWhTWjzCHmnG3cRqi3PFxujHkuAT/FaLIH3u92v8NqB7bQARfpKgTf3C3vvJRTAT3vFx
         r5ZY+fl+LZ5jcVpA2qWL7aBsM2q/scqaFZamV+BCJYk4IBcRU9otU6tl+n8w9QtUyDW1
         MW7i9xpPYKGtMDWcVeY77/xwLslOwcbFo60jZkGD9D5+SpCRKy7VcZrD5aSlkbvVtECa
         AvIHo5DoEQTx9XTBUw8cxWsNfF+2196dEOWZNu7DEkwd16eTrYwKjJXqWanVjl2ChCJ7
         kZhw==
X-Received: by 10.180.95.10 with SMTP id dg10mr42338394wib.41.1432653287442;
 Tue, 26 May 2015 08:14:47 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 26 May 2015 08:14:47 -0700 (PDT)
In-Reply-To: <CACHsx4KzkiuRt4BrCPM4fQ-15K+f4q47AXuXFgZv7xxEB=WO6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269945>

On Tue, May 26, 2015 at 4:10 PM, Stephen Kelly <steveire@gmail.com> wrote:
> On Tue, May 26, 2015 at 12:39 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>
>>> 1) How would Alice push the content to a remote host so that Bob would
>>> get that automatically?
>>
>> I am not sure what you want exactly, but let me try to answer anyway.
>>
>> Let's suppose that the content is in another submodule, let's call it
>> subA, and let's call subB the submodule that should reference content
>> in subA.
>
> Yes, that's the scenario in my script.
>
>> If subA has been pushed on the remote host, then Bob can clone subA
>> first, and then clone subB using the --reference option to point to
>> the content of subA.
>
> Ah. Here's some confusion maybe.
>
> Alice pushes subA and subB *and* the supermodule. In my script, these
> were named calculator, compute and appsuite. The supermodule is the
> entry point that everyone uses.
>
> Bob clones the supermodule, appsuite, and expects that to 'just work'
> regarding history.
>
> So, I want to somehow specify the --reference in the .gitmodules of
> the appsuite supermodule. Then when Bob runs git submodule update
> --init, the right thing will be done.

Yeah I understand and I am trying to help you do something like that,
though I can only talk about some of the steps involved, and this may
or may not help you find a complete solution that is good enough for
your needs.

>> Please note that I don't know much about git submodules, as I try not
>> to use them myself,
>
> Me too :), but needs must.
>
>> so I am not sure there is a way to make them do
>> exactly what you want. Maybe you should look at the threads about
>> submodules on the Git mailing list, see who are the people involved
>> and send an email on the list with those people in CC and a subject
>> related to submodules and with your specific questions about
>> submodules in the content.
>
> Ok, thanks. I think the solution of running a script after initial
> clone/update is probably the most suitable for now anyway without
> getting deeper into git.

Yeah, the user might just run a script instead of "git submodule update --init".
This way it doesn't increase the number of steps that have to be performed.

>> For example I don't know if there is a way to tell that subA should be
>> cloned before subB or something like that.
>
> Right. A step of performing actions like this would need to be done
> after all fetches are done I guess.
>
>>> 2) Can git submodules be configured to use particular options when
>>> cloning particular repos? I see no relevant options in the
>>>
>>>  https://www.kernel.org/pub/software/scm/git/docs/gitmodules.html
>>>
>>> page.
>>
>> I don't know. Maybe it's possible to add a
>> "submodule.<name>.cloneOptions" option to specify them. Or maybe it's
>> possible to use the "submodule.<name>.update" config option with a
>> specific command (see "custom command" in
>> http://git-scm.com/docs/git-submodule) to do it.
>
> Yes, actually the 'custom command' section there might be useful... I
> might try it.

Great, tell us what you come up with.

>>>> So it looks like you might just need to clone with a few more options
>>>> than usual.
>>>>
>>>> I haven't tested it so please tell me if it works :-)
>>>
>>> I changed the last 20 or so lines with one of your suggestions. I put
>>> the initial revision and the update on a gist:
>>>
>>>  https://gist.github.com/steveire/a57bc48a460e11284d81/revisions
>>>
>>> The script I posted is easy to modify if you want to try something
>>> out. I would be happy if you would try it out and see if you can make
>>> your suggestion work.
>>
>> I tried it and it looks like it works for me as it works for you.
>>
>> There is:
>>
>>> git fetch origin 'refs/replace/*:refs/replace/*'
>>> # Don't seem to need this? Why?
>>> # Does the push of the replace refs copy them to the remote repo?
>>> # How do I find out?
>>> # echo "../../calculator/objects" > ../.git/modules/compute/objects/info/alternates
>>
>> The above comments probably mean that you didn't expect that fetching
>> replace refs would also fetch the git objects (commits, trees, blobs,
>> ...) pointed to by the replace refs. But that's what fetching does
>> with any king of ref (branches, tags, notes and replace refs).
>
> Actually, what I didn't expect is that
>
>  # Push the replacement to the remote submodule clone
>  git push origin 'refs/replace/*'
>
> would push a copy of the content reachable by the 'refs/replace/*',
> totally bypassing what I did with info/objects/alternates.

Well if you had also setup info/objects/alternates on the server, it
would have been used there.

When pushing refs, as well as when fetching refs, Git sends the
objects pointed to by the refs that are transfered, if those objects
are not already available, so that the result is in a consistent
state. So if you setup info/objects/alternates on the server before
pushing, the server will see the objects as already available in the
alternates repo, and they will not be sent to the server.

> I updated the gist again with some output which I think shows that
> that is happening.
>
>  https://gist.github.com/steveire/a57bc48a460e11284d81/revisions
>
>> Yes, this means that you need the commented "echo ..." line above,
>> only if you don't want objects to be duplicated. But what you should
>> really do in this case, is first use the "echo ..." line, and then
>> fetch the replace refs.
>
> Because the issue occurs with the push, I don't think this will help.

This will help on the client, as the client will already have the
objects when fetching.

Best,
Christian.
