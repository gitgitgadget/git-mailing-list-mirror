From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Mon, 11 Jul 2011 23:27:06 +0530
Message-ID: <CALkWK0msdBdXX4oMkd+WAMR8PXTRT3ivjMrf3ZAMfBrsLoM=dQ@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com> <20110711171713.GA5963@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 19:57:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgKjg-0005IY-SV
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 19:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758406Ab1GKR53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jul 2011 13:57:29 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63070 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758400Ab1GKR51 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2011 13:57:27 -0400
Received: by wwe5 with SMTP id 5so4167302wwe.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NNrdROuVRh9VWyPk2vQ7UZwnM55d79bAQndrf9yIIg4=;
        b=UaIAlRiKRTVFoHLICTzFqXGIRuzjR1hhQv/zXTtxxrRUqjg/BJpeJOd4dGT4msj/Wr
         VOnDHF0kjTSlTa6jU4XVA3vf/+f4TDrtc1wZfl/2L7WcsBHwxMy5W0hs/Btdm0nBHysI
         fcLSSJA1U/dyYKmYVvLIbR1jTRsXjD+/4jZtw=
Received: by 10.216.137.92 with SMTP id x70mr2200475wei.62.1310407046179; Mon,
 11 Jul 2011 10:57:26 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Mon, 11 Jul 2011 10:57:06 -0700 (PDT)
In-Reply-To: <20110711171713.GA5963@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176883>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> I'm excited to announce the first iteration of a fresh series
> =C2=A0- has the result of applying each patch in the new iteration be=
en
> =C2=A0 tested (for example by rebasing interactively with "exec make =
test"
> =C2=A0 after each "pick" line)?

Tests are still running.  I'll let you know the results in the morning.

> =C2=A0- what changed since last time, for each patch? =C2=A0(For the =
future, the
> =C2=A0 space under the "---" is generally a good place to put that
> =C2=A0 information.)

Will comment a little more on this in the morning.  The main focus of
this series is to showcase the new option parser, and show how it fits
into the rest of the series.

> =C2=A0- what proposed changes did not make it in, for each patch? =C2=
=A0If any,
> =C2=A0 did they not fit well with the design, or was it more a matter=
 of
> =C2=A0 "sure, that would be nice, but let's get this in first"?

A combination of both.  More on this later.

>> I would have liked to reuse the gitconfig parser as-is for the opts
>> parsing, but it's too tangled up in config.c. =C2=A0I think it's saf=
e to
>> say that the opts file format deviates only slightly from the
>> gitconfig format, and I'm quite happy with the end result.
>
> To be precise, the format used includes
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strategy-option =3D patience | renormalize
>
> to represent the effect of "-Xpatience -Xrenormalize". =C2=A0My only =
worry
> about that is that the "|" can sound like "or", which would seem
> strange to a user that does not necessarily develop software (so is
> not thinking about bitfields). =C2=A0The format used in config files =
puts
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strategy-option =3D patience
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strategy-option =3D renormalize
>
> as separate lines.

Okay, I can change to that if it's desirable.  My rationale for using
"|" is that lines like "key =3D value1" and "key =3D value2" tend to lo=
ok
odd -- it's like I'm reassigning the key a different value.

>> 4. New tests and documentation. =C2=A0There's really no end to this
>
> Once each new feature has been documented and each new feature or
> fixed bug has an associated test, you've reached the end of this.

It depends on how rigorously you want to document and test things, no?
 For example, I haven't documented the formats of the configuration
files anywhere but in the commit messages.  Something in
Documentation/technical would be nice, but I think we should wait
until the format evolves a bit.  Since I haven't exposed anything like
a "--interactive" functionality, the user will never see it and we can
change it as and when we like.

Also, for things like the option parser, how far do you want to go
with testing? How many kinds of malformed instruction sheets do you
want to test with?  I'll include some more basic tests soon, but I
don't think we should go too deep, due to time constraints.

As you can see, I've included basic usage documentation.  Do let me
know what else is required right now.

> My main worry is still the commit messages. =C2=A0They don't need to =
be
> elaborate but they should explain the purpose and effect of each
> patch. =C2=A0Part of the reason I care is that it makes the life of f=
uture
> readers using "git log -S" or "git bisect" before changing that code
> much easier. =C2=A0Think of them like a special kind of comments that=
 don't
> interfere with reading the code straight through.
>
> The main reason I care is that that information makes the code itself
> easier to review.

I completely agree.  We should not compromise on commit messages --
they can't be fixed later.

> I don't know how to move forward on that. =C2=A0I can explain what's
> missing in each message, but I get the impression that you already
> understand that and there's something else (e.g., time) preventing
> them from getting fixed. =C2=A0I could rewrite each commit message, b=
ut I
> am likely to miss things and come up with something that sounds
> vaguely plausible but doesn't accurately explain the intent. =C2=A0Wh=
at do
> you suggest?

I have updated many of the commit messages.  Do let me know what's
missing where.  As usual, you can leave quick comments on IRC -- I'll
check the logs in the morning.

Thanks!

-- Ram
