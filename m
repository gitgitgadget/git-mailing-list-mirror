From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Git submodule first time update with proxy
Date: Sat, 24 Jan 2015 18:47:10 +1300
Message-ID: <CAFOYHZBqLPzE94sbb=RoD0yViqPhJ+DRnYJQ6o_2taF1DhhHhA@mail.gmail.com>
References: <CAHd499BEmV2zeosE9th59QTWPA0CPsU8eyHnONhsZqEb=bH+rA@mail.gmail.com>
	<CAFOYHZAiZkXqSkso+=Eh_THEkh+qi9k8xWsP0yt1dbw5ymwDDQ@mail.gmail.com>
	<CAHd499A+K=uh=wt4P_qy+8XOEttTziJEPvhE+=03oD_MRxna2Q@mail.gmail.com>
	<CAHd499B+ZAAYAtDdsX=v4H60dq3wuVgR0Hk7x6NRubMJ_Umjjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 06:47:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEtZ0-0008PS-Vh
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 06:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbbAXFrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2015 00:47:12 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:59913 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbbAXFrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2015 00:47:11 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so1839996pdj.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 21:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/0BdDEWP+yXQP8TK9WTf1a8NQmy4IYItmNOkvPkp5Xc=;
        b=rfYpn6zkV+3AMZKmFajAc1h6VTRw9kJgR/TwxS5Lc2GccIxxZoeWw+uP0xTcfN+wcB
         oZMx3K1Lx1vJdZGq3D4nR3jbjwK7EePgoKZjzqx7OH70kLjOZwDqWklT/OHCEtOKV6q+
         LkDcHBCvG22wc9Xnr1ej9JxC5HogoRqctkNF2VR51C/FQbgpKj3uL6ctM2vq6+dRb7u5
         eAH8iJtcJdFbNJfhdoVX76MYWEApctrGy0pnehdmi2KM0G1g8oaW0aTA8kgvKGW7BnbW
         5sMUofrLNP8426cpLNNg6+8aO9sXiUT+AkBTvaYEyJvNcI3fDARM/xoVbGFfKxach9zI
         5QOw==
X-Received: by 10.66.121.134 with SMTP id lk6mr12517887pab.71.1422078430314;
 Fri, 23 Jan 2015 21:47:10 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Fri, 23 Jan 2015 21:47:10 -0800 (PST)
In-Reply-To: <CAHd499B+ZAAYAtDdsX=v4H60dq3wuVgR0Hk7x6NRubMJ_Umjjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262990>

On Sat, Jan 24, 2015 at 5:45 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> On Fri, Jan 23, 2015 at 10:23 PM, Robert Dailey
> <rcdailey.lists@gmail.com> wrote:
>> On Fri, Jan 23, 2015 at 4:13 PM, Chris Packham <judge.packham@gmail.com> wrote:
>>> Hi,
>>>
>>> On Fri, Jan 23, 2015 at 3:50 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>>>> I have a submodule using HTTP URL. I do this:
>>>>
>>>> $ git submodule init MySubmodule
>>>> $ git submodule update MySubmodule
>>>>
>>>> The 2nd command fails because the HTTP URL cannot be resolved, this is
>>>> because it requires a proxy. I have "http.proxy" setup properly in the
>>>> .git/config of my parent git repository, so I was hoping the submodule
>>>> update function would have a way to specify it to inherit the proxy
>>>> value from the parent config.
>>>
>>> Your not the first to suggest it and you probably won't be the last.
>>> It is hard to decide _which_ config variables, if any, should
>>> propagate from the parent. What works for one use-case may not
>>> necessarily work for another.
>>>
>>>> How can I set up my submodule?
>>>
>>> Probably the easiest thing would be to make your http.proxy
>>> configuration global i.e.
>>>
>>>   $ git config --global http.proxy ....
>>>
>>> If you don't want to make it a global setting you can setup the
>>> submodule configuration after running init but before running update
>>> i.e.
>>>
>>>   $ git submodule init MySubmodule
>>>   $ (cd MySubmodule && git config http.proxy ...)
>>>   $ git submodule update MySubmodule
>>
>>  For some reason, the init call does not create the submodule
>> directory as you indicate. I also checked in .git/modules and it's not
>> there either.
>

OK I must be wrong about that. I was working from memory. Trying it
now I see the error in my thinking

  $ git submodule init bar
  Submodule 'bar' (bar.git) registered for path 'bar'

I thought this meant that bar/.git (and .git/modules/bar) had been
created but as you point out I was wrong.

> Correction:
>
> I have to deinit the submodule then init again, then the submodule dir
> is created (but empty).

That's the default state of an uninitialized submodule.

> When I run the git config command inside the
> submodule directory, it silently returns and does not indicate
> failure, however the final git submodule update command shows failure
> to access the remote and then subsequently the submodule empty
> directory is removed by Git.

So it looks like the only solution to your problem right now is to use
git config --global for your proxy configuration.
