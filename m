From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv1bis 1/2] git apply: option to ignore whitespace 
	differences
Date: Thu, 2 Jul 2009 22:33:10 +0200
Message-ID: <cb7bb73a0907021333t6f377d61v1c1479c15b72c436@mail.gmail.com>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vvdmb6ium.fsf@alter.siamese.dyndns.org> <cb7bb73a0907021202ra322425pc64b54953f4f544d@mail.gmail.com> 
	<cb7bb73a0907021228q7e9d2791vafead8e0c5b06b79@mail.gmail.com> 
	<7vhbxu6f87.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 22:33:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMSyh-0002Mg-5i
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 22:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbZGBUdc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 16:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754557AbZGBUdb
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 16:33:31 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:44914 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbZGBUd2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 16:33:28 -0400
Received: by bwz25 with SMTP id 25so1470740bwz.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nT1E206rGL/axB2vKaP8USgkJkZ/7uGzizBn2/OfvA8=;
        b=UnvZ+odXsOtPA4wcGS7vacaOpUc7qMMttbF756k6GFh4qQ49vRdOhQ9oIo09qqIqn+
         IAvShKde1O1lLZBD4rG7GFaq2XfeUZ2b6H6cftZXFnIvJphvqOXuZQtIyLTlPwCDR0zw
         38QAopN5WOov3XfzI2YnF7sTtcIXsu665NaJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aDQueraTekOs1wYBlCtvhF+lk3WBZK1UIsWNPBtIKACmKNTkuqHnreLtIdmW9gOgey
         AQajo1VaPxIS5Oz/96yMI326Nmc7YLRiB/fQKIV1KVy5Ic0qgvexkrIFNYPWQupbZa9f
         U08EOFjhCGpQzjByLrkCGshZDvyU7Sa1q0ovU=
Received: by 10.204.103.145 with SMTP id k17mr442912bko.10.1246566810170; Thu, 
	02 Jul 2009 13:33:30 -0700 (PDT)
In-Reply-To: <7vhbxu6f87.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122669>

On Thu, Jul 2, 2009 at 9:45 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Sorry for repying to myself here, but I'm not convinced again. Or to
>> be more specific: I think this kind of refactoring is totally out of
>> the scope of this patch. So although I agree with you in priciple, i=
f
>> you don't mind I'll keep the first two patches simpler and less
>> invasive. I'll look into the refactoring as a third step.
>
> I am not interested in applying "this adds a broken ignore-whitespace
> option, but as long as you do not use it, it does not hurt the carefu=
lly
> crafted apply-with-context-whose-ws-breakage-was-fixed codepath."

Perfectly agreed. I'm not asking you to apply the patches as they are,
I sent them to the list for review, and CC'ed you since I couldn't
identify a git-apply maintainer.

>=A0For
> example, I am not convinced at all that your patch does not break the
> update_pre_post_images() nor do I know what text the final pre/postim=
age
> will happen to end up with. =A0In other words, I do not see a clear l=
ogic in
> the change.

As you yourself pointed out in the previous email, when ignoring
whitespace the code wouldn't hit the whitespace fix path at all.
Indeed, I've updated the patch to this effect right after reading your
previous email.

> Also about the broken "only prefix matches" loop, I do not understand=
 why
> you would want to consider this preimage from the patch
>
> =A0 =A0 =A0 =A0"this =A0has extra whitespace and other stuff\n"
>
> matches the target line
>
> =A0 =A0 =A0 =A0"this has extra whitespace\n"
>
> only because the prefix matches.

That's totally not what I meant. The other way around though, i.e. a pr=
eimage of
 =A0 =A0 =A0 =A0"this has extra whitespace  \n"
should match against
 =A0 =A0 =A0 =A0"this =A0has extra whitespace\nand other stuff\n"

And of course
 =A0 =A0 =A0 =A0"this has extra whitespace  \n"
should fail against
 =A0 =A0 =A0 =A0"this =A0has extra whitespace and other stuff\n"

Both cases behave correctly (I just extended the test to include this c=
ase, btw)

A more interesting question would be if a missing EOL at EOF should be
treated as whitespace difference or not.

> For that matter, I do not think I understand why the leading whitespa=
ces
> of s1 and s2 are skipped only when they both begin with a whitespace,
> either.

Oh, thanks, when first adapting Robert's patch I hadn't considered it
missed this case. I've updated the patch accordingly and added a test
case for it.

> I do not want to be looking at this series until it gets into a bit m=
ore
> reviewable shape, which I would expect to take at least a week if you=
 are
> not working on this full-time (and I presume nobody on the git list i=
s).

I do wonder what makes the patch 'unreviewable', since I assume that
doesn't mean just 'does not include the refactoring I requested'.

> Please do not Cc me in the meantime, but please do ask for help from =
other
> people interested in this topic on the list.

I thought it appropriate to cc you for this specific reply since I was
addressing the doubts you raised, but I will not include you in the
next resend of the series, as per your request. Thanks for your
patience anyway.

--=20
Giuseppe "Oblomov" Bilotta
