From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Re: Updating a submodule with a compatible version from another
 submodule version using the parent meta-repository
Date: Wed, 26 Jan 2011 14:48:14 -0500
Message-ID: <AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
	<AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
	<4D407099.4010805@web.de>
	<AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
	<4D407875.7080607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 26 20:48:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiBLt-0001Fa-5U
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 20:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab1AZTsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 14:48:17 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37451 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab1AZTsP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 14:48:15 -0500
Received: by wyb28 with SMTP id 28so1303248wyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 11:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vWJeq4HlN2fHYfJL/ChQxNjB4fITqBEGhvZ6rlhtLBE=;
        b=sv9jDCSe058HVrAQfhrivNDYi+0XqdI7la9a/KhpRyyksKbzhjmcvCw3YNebhndoa3
         pQfO9AbWrvwZ0vnT3Uuql5QgZDsj/bI20C+O5GXWJG1eNPM7HMzxc8RYPxIPB5q51V+H
         BopD7Fl77WpEHtRxft4D1Uv0ArKrbsiWFqekM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=toQug4HuJwa2tusNxgze3N+rC9uyM4tJ748powOp9UBvvIIyAcGZ0spbJ1RC01ePXp
         EajOvidluP6jLPbnvsiEz1iFJuJW/qEt2V7IEB2wF6gXzxDYQ6b1u48AQp0TEZZghqvn
         Ni//oxraYG0n9Gj7RL8AOtckZatTbfXQv/oyg=
Received: by 10.227.166.194 with SMTP id n2mr1715502wby.172.1296071294263;
 Wed, 26 Jan 2011 11:48:14 -0800 (PST)
Received: by 10.227.146.83 with HTTP; Wed, 26 Jan 2011 11:48:14 -0800 (PST)
In-Reply-To: <4D407875.7080607@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165534>

> Am 26.01.2011 20:10, schrieb Julian Ibarz:
>> On Wed, Jan 26, 2011 at 2:06 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Am 26.01.2011 19:32, schrieb Julian Ibarz:
>>>> I am using git submodule in one of my professional projects and I am
>>>> facing an issue when I am using git bisect in one of the submodules.
>>>>
>>>> Basically I have a meta repository which I will call A and two
>>>> submodules B and C. Sometimes I use git bisect in B but it is
>>>> dependent on C so when I go back too much in the history of B, C needs
>>>> to change its version to a compatible one. Doing this manually is
>>>> really time consuming for me and I guess a lot of people have this
>>>> issue so I was a little bit surprise to not find easily anything on
>>>> the net that permits to do this automatically.
>>>
>>> What about bisecting in A (doing "git submodule update" after every
>>> step) to bisect to a smaller range of commits in B (which are then
>>> not dependent on your submodule C anymore and can be bisected inside
>>> B)? This of course assumes A properly records the dependencies
>>> between B and C.
>>
>> Yes but actually my real use case that made me write this mail was
>> more I have a feature done in an old branch and to try it I never to
>> revert back to this version. In this case, I have to find out the
>> corresponding good version in A and C. In this case I cannot start
>> like what you propose in A to find out the good version in B and C, I
>> already know the version I want in B.
>
> Hmm, looks like I lost you here ... you want to bisect in B although
> you know what commit you want there? Care to explain a bit more?

In B I have a feature to integrate in master branch. This feature is
in branch old_feature. But this branch is really old. To try this
feature I need to rebuild it at this version. To make the build
success I need also to revert back the submodule C because B is
dependent on it. But finding the good version of C that match
old_feature version is a pain... Is it clear?

>>>> Is there anything existing to do that and I just didn't find it yet?
>>>> If not I think I might have an implementation idea I would like to try
>>>> out.
>>>
>>> The call to "git submodule update" after each bisect step in the
>>> superproject will be obsolete as soon as the recursive checkout
>>> I am currently working on is done, but that is not here yet.
>>
>> Can you be more detailed about your recursive checkout feature? Is it
>> what I proposed?
>
> I don't think so, that will just get rid of the extra call to "git
> submodule update" when bisecting in A.

Basically my feature would work like this:

in B:
git submodule checkout some_version

This will checkout B but also change A and C so that it is compatible
with some_version of B. Basically it will find the commit in A that
has the closest parent commit of some_version in B. When this is done
it just does git submodule udate on other submodules.

I see in gitk that there is a feature that has a common implementation
for what I want to do:

For every commits you can see Follows and Precedes which lists the
closest label before this release and after. What I need is the same
thing: instead of finding a closest labeled commit, I need to find a
closest commit referenced by A that precedes current HEAD of B. When
this is done I know which commit A has to be and then just have to
call git submodule update in A (update every other submodules except
for B).

Julian
