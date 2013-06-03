From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Mon, 3 Jun 2013 09:02:55 +0100
Message-ID: <CAJ-05NNgcj_pPer2Tw4HvKkVib7N1ZFo7rZOrR9z8NMV1WHQsQ@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
	<CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
	<87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
	<87y5av4jvj.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NN8cARpPTnsCfHt3kY6gTnhZ=Vq55EzqxWBV_3ju-oczQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 03 10:03:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjPjs-0005iI-GM
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 10:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab3FCIDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 04:03:20 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:40069 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab3FCIC4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jun 2013 04:02:56 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so6610658obb.28
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 01:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=5k0rBda4a8dMW/oVbpj3StoZx/ligoTVegGKnag7OSo=;
        b=DgzbA7cyleV6RVCi4aZy7DrVt44qWfosVzEb+70ENdfn5vtDozkNM62NDEoXuwWT/h
         d+bZwyGN91B5aHOyOvUSeLvo0EcRNOidtpaqWM2bald8Ye03uU8LhkpiKLgozSjSohyg
         J88Hf4k7pHFrFjHrmTJX+sV7tzcQHldz07ksIsFTHdHCrKULIGlwYTMXPcoMc7Fcb/wH
         xwDJilP9CI5WYjMktfyC9rhsX6bLS/trGqH7sWbaVe0TOSmavdLOUnIClcREb1A9Lec8
         Kj4NO7mfX4HawH81JKYaiilQjqH9BnBlPyce616frsv0Vyd9q5PrMMpy1GPG68+n5afn
         S13w==
X-Received: by 10.182.233.227 with SMTP id tz3mr9734994obc.23.1370246575799;
 Mon, 03 Jun 2013 01:02:55 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Mon, 3 Jun 2013 01:02:55 -0700 (PDT)
In-Reply-To: <CAJ-05NN8cARpPTnsCfHt3kY6gTnhZ=Vq55EzqxWBV_3ju-oczQ@mail.gmail.com>
X-Google-Sender-Auth: GQ470XvXXREcEEMSyNXUTjwnOno
X-Gm-Message-State: ALoCoQn64h2zQfGd8bFjkwEnzH2RODhipqi6+wNtXfNfadXktbe4ZKz/Ex6H+/hvKrPU3+DDMguB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226204>

On 31 May 2013 10:57, Alex Benn=C3=A9e <kernel-hacker@bennee.com> wrote=
:
> On 31 May 2013 09:46, Thomas Rast <trast@inf.ethz.ch> wrote:
>>
>> So that deleted all unannotated tags pointing at commits, and then i=
t
>> was fast.  Curious.
>>
>> However, if that turns out to be the culprit, it's not fixable
>> currently[1].  Having commits with insanely long messages is just, w=
ell,
>> insane.
>>
>>
>> [1]  unless we do a major rework of the loading infrastructure, so t=
hat
>> we can teach it to load only the beginning of a commit as long as we=
 are
>> only interested in parents and such
>
> I'll do a bit of scripting to dig into the nature of these
> uber-commits and try and work out how they cam about. I suspect they
> are simply start of branch states in our broken and disparate history=
=2E
>
> I'll get back to you once I've dug a little deeper.

So I wrote a little script [1] which I ran to remove all tags that did
not exist on any branches:

git-tag-cleaner.py -d no-branch

After a lot of churning:

17:26 ajb@sloy/x86_64 [work.git] >time /usr/bin/git --no-pager
describe --long --tags
ajb-build-test-5225-2-gdc0b771

real    0m0.799s
user    0m0.024s
sys     0m0.052s

So at least I can fix up my repo. All the big ones look at least as
though they were weird cvs2svn creations that exist to represent the
detached state of a strange CVS tag from the converted repository.
However it does raise one question.

Why is git attempting to parse a commit not on the DAG for the branch
I'm attempting to describe?

Anyway as I have a work around I'm going to do a slightly more
conservative clean of the repo with my script and move on.

[1] https://github.com/stsquad/git-tag-cleaner

--=20
Alex, homepage: http://www.bennee.com/~alex/
