From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 03/72] t/test-lib.sh: add always-set NO_GETTEXT_POISON prerequisite
Date: Sun, 20 Feb 2011 23:05:31 +0100
Message-ID: <AANLkTikJbwp+-=sgX2RLo-aXA_gmmO2gLsC=+MxEYxXg@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
	<1298143495-3681-4-git-send-email-avarab@gmail.com>
	<20110220021031.GB17305@elie>
	<AANLkTik9ieR=pWLQ9JEabNm2trSsyfFuYgfKMojnbzfb@mail.gmail.com>
	<20110220215533.GB32142@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 23:05:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrHPO-0006eu-3P
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 23:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab1BTWFd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 17:05:33 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35229 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab1BTWFc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 17:05:32 -0500
Received: by fxm17 with SMTP id 17so920845fxm.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 14:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Sogz4i8Ja+Bp1uz3KDsybIr9CE49G2pS1Lgq8gU8Wfo=;
        b=vqPjGhv7Ue7RBdKGI4fHvZJQzQazXZOw5Wtqb/mUqTPYfQp8BJXM/1cSYU4Q5YbohI
         gIEpSj4f4/Yv8MdqpBgmQ+bcqzW42Go/yI4oO9gwkU76Ym0OghXx+tL453ZojwpA+bjy
         Rbh4v45EiPue9syHgSmrZYKjuIr/iMSfzJmwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vjlVT8kfLuezhAVmGTK6yCIwt9gpRR62AF4tTfkczC941cH0FBIwzIjC561MDzMFF0
         Wh8YPEMrKy6PL2CBfbKZbQWjB9VX2o9f3qXMKxs2xh6Bv6CW0h2nVnXU1ZT0XGBVO5ER
         XvC5QbZRCacESmWGive8jR2yHNUO7drLfSSNQ=
Received: by 10.223.54.132 with SMTP id q4mr924914fag.117.1298239531354; Sun,
 20 Feb 2011 14:05:31 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Sun, 20 Feb 2011 14:05:31 -0800 (PST)
In-Reply-To: <20110220215533.GB32142@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167431>

On Sun, Feb 20, 2011 at 22:55, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> It's explicitly about tests that can't deal with poison, not
>> non-English. See this comment in patch =C2=A028/72:
>>
>> =C2=A0 =C2=A0 gettextize: git-commit "enter the commit message" mess=
age
>>
>> =C2=A0 =C2=A0 Gettextize the "# Please enter the commit message for =
your changes."
>> =C2=A0 =C2=A0 message. Several tests in t7500-commit.sh and t7502-co=
mmit.sh assume
>> =C2=A0 =C2=A0 that this message starts with a newline. Change the te=
sts to to skip
>> =C2=A0 =C2=A0 under GETTEXT_POISON=3DYesPlease.
>
> Shouldn't the functional part (the starting newline, opening # marks)
> be untranslatable then, to avoid making a trap for translators? =C2=A0=
Such
> a fix could happen at any time, and until then, we could skip those
> tests in the non-English case.

I'm aiming to make this as minimal as possible, so I'm not going to
change the code to start constructing string buffers where we
previously had literals in this iteration.

And the trap is minimimal, sinc msgfmt --check will warn if the
structure of the newlines in the translation is different.

> Since that codepath requires human intervention anyway (which is
> generally slow), I can't imagine doing that would hurt runtime
> performance enough to matter.
>
> But I do get your point --- perhaps in some other circumstance we hav=
e
> to rely on some intelligence by the translator for correct behavior.
> So maybe it means something along the lines of
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_set_prereq SANE_TRANSLATION

Well, the feature I have is to inject garbage into the gettext strings
in an effort to smoke out when I break the plumbing. So I think given
that functionality calling it NO_GETTEXT_POISON makes sense.

But I plan to add something to smoke other languages etc. later. Then
I might name that other prerequisite something else.
