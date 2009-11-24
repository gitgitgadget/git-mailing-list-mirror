From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Tue, 24 Nov 2009 19:28:09 +0200
Message-ID: <94a0d4530911240928w4f97cfa7of86b0d8676eb59db@mail.gmail.com>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
	 <20091121193600.GA3296@coredump.intra.peff.net>
	 <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
	 <94a0d4530911220437l5386b36ds4ef06dc66cc11bcc@mail.gmail.com>
	 <7v7htice04.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 18:28:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCzBa-0007K0-36
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 18:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933498AbZKXR2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933481AbZKXR2E
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 12:28:04 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:50384 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933457AbZKXR2E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 12:28:04 -0500
Received: by iwn1 with SMTP id 1so636281iwn.33
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4cQXc71JiVAxbxJ+gEkRWgmpl4LNBqerV544tp4bECY=;
        b=Mvq+M+MO5/MNtg+OIVzKYtw4qPpt3hLDPEtwGUHWfiOwcyKE+Cp87YM2nqWM0ji6H1
         8tbfnrrTcXvIGD8T+d6jM2WPvT5Y4yMHspwKv+7RXFErESsMd10b7Na3t/ShiGC7jxo3
         DxBgzc9ByhlHxnOk/18c3cI/6t1+6vZMuKfJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c0frYyCvSoGHnEwKlKKB9lpJe1QlaPAYaaWbulXUcQwishbZUsCDWFZ8Dmeucr8BPR
         l4V84cgrou44sbPA7efudp+hiIP4rMEYVLmig2UHrbQbK42mVZwz/shI0UQ+9jI1uXko
         4Y9g2XTvY7B0gi/GkxWAdfJAN1e00sSBD9/1g=
Received: by 10.231.158.205 with SMTP id g13mr337448ibx.30.1259083689203; Tue, 
	24 Nov 2009 09:28:09 -0800 (PST)
In-Reply-To: <7v7htice04.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133584>

On Mon, Nov 23, 2009 at 1:54 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> a) --add-envelope: add the sender envelope, by default it would be t=
he
>> 'from' address, but could be overridden by --envelope-sender.
>
> I do not think the latter half of this description makes much sense, =
as
> the existing --envelope-sender=3D<this-address> alone already says "a=
dd this
> envelope sender".

--envelope-sender=3Dfoo@bar.com would imply --add-envelope.

> It is unfortunate that we cannot sanely have an option that takes an
> optional string argument from the command line. =C2=A0Ideally, if we =
can
> specify --envelope-sender without any argument, we could make it to m=
ean
> "pretend as if the 'from' address is given to this option", but that =
would
> make the command line pasing ambiguous, so we would need an extra opt=
ion
> like this one. =C2=A0"--envelope-sender=3Dfrom" might be a more intui=
tive way to
> say this, though.

I agree, but --envelope-sender=3Dfrom looks a bit strange to me.

>> b) --envelope-sender=3D"" or "auto": this would require minimal chan=
ges
>> but looks a bita strange.
>
> An explicit empty string does look very strange, but I do not think a
> magic word like "auto" (or "from") that cannot sanely be your envelop=
e
> sender address is a bad idea.

I think "auto" is the least worst option right now.

>> Any thoughts?
>
> It is much easier to work on the configuration front, by the way, and=
 I
> expect people who regularly interact with multiple projects to apprec=
iate
> this feature would configure their send-email once and forget about i=
t, so
> the command line clunkiness might not be such a big issue.
>
> A user who works with more than one projects with different identity =
known
> to each project would use $HOME/.gitconfig and send-email configurati=
on
> identity feature to set "sendemail.<identity>.from" and friends in th=
ere,
> while setting sendemail.identity configuration in .git/config for eac=
h
> project, so being able to say "use whatever 'from' as the envelope se=
nder"
> once in $HOME/.gitconfig would be convenient.
>
> So I could have in $HOME/.gitconfig:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[sendemail]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0; used as a bo=
olean to say "use from"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0envelopesender
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[sendemail.git]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =3D Junio=
 C Hamano <gitster@pobox.com>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to =3D git mai=
ling list <git@vger.kernel.org>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[sendemail.frotz]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =3D Junio=
 C Hamano <frotzster@example.xz>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to =3D frotz m=
ailing list <frotz@example.xz>
>
> and then in my {git,frotz}.git/.git/config would have
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[sendemail] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [sendemail]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0identity =3D g=
it =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0identi=
ty =3D frotz
>
> respectively. =C2=A0Without your patch, in $HOME/.gitconfig, I wouldn=
't have
> the global sendemail.envelopesender but have separate individual
> configuration variables sendemail.{git,frotz}.envelopesender defined.

I also thought about having an identity (profile) for sendmail; it
would be very useful to specify the smtp server, aliases file, and
from address that multiple repositories can share and can be easily
changed (working for my company vs working for myself).

However, even in this case I would like to have a global option to add
the sender automatically from the 'from' address.

--=20
=46elipe Contreras
