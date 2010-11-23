From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: OK, how should I have done this...
Date: Mon, 22 Nov 2010 19:17:55 -0500
Message-ID: <AANLkTimek=PAMGz-aKrb=7QJGJYEjZ29Z8izrD1BCKDN@mail.gmail.com>
References: <AANLkTim0_J0i_a0o+z1oCC4mramfUxCGtCg_Y+ab+h+-@mail.gmail.com> <7vr5ecvr9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 01:18:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKgaU-0003Z3-9u
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 01:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480Ab0KWASR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 19:18:17 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52465 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177Ab0KWASQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Nov 2010 19:18:16 -0500
Received: by fxm13 with SMTP id 13so3240403fxm.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 16:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AUGi4aBknY5Sj0e61qhmQfyAP8GWaFi+tKWALlY0X6c=;
        b=sRENrvOPnBBA0yUCIaMXek0VsS+hhlW4XMFekEaTap6GR/tGQBoa++lP2RUlLm0FLC
         zTSCU/gzi95onB3CUZf/sJYnO9IUoAcQJMGFyy2yz6yTkR6WkeFgQkBRMR9aLleuYP11
         FgkbVLrlDYKHPVP8eobze5nV+nRluzf/EBumc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Icxsqi2KMk712nHtw9mbAbzGXzDml3wVzDbz831YaPeLcH/YrI5NaHepYTu3FSvREQ
         ilFOT3MDArRHFzTJ6i6Riq4hp2UFmFC9zc9SdEmDOw6i6t2sreCR8QMTQpQ41XGGX992
         ouZNe7tnl0DfCOUlNWiKrV+2ZaxptnGAeRzXU=
Received: by 10.223.87.2 with SMTP id u2mr407374fal.106.1290471495412; Mon, 22
 Nov 2010 16:18:15 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Mon, 22 Nov 2010 16:17:55 -0800 (PST)
In-Reply-To: <7vr5ecvr9p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161920>

On Mon, Nov 22, 2010 at 7:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Patrick Doyle <wpdster@gmail.com> writes:
>
>> But I _know_ that there must be a better way to do this. =A0What sho=
uld
>> I have done?
>
> Depends on how you wanted to fix your history (we already know from y=
our
> description what shape of tree you want to end up in).
>
> If you want to pretend that you were perfect and never made mistakes =
in
> these three files you had to fix later, then history surgery like wha=
t
> Matthieu suggested would be necessary (I won't repeat how).
>
> On the other hand, if you want to record what you did in the time ord=
er,
> then I would probably do this:
>
> =A0$ git checkout master ; test ;# broken
> =A0$ git checkout 5ccce3 ; test ;# ok
> =A0$ git checkout master -- file1 ; test ;# ok
> =A0$ git checkout master -- file2 ; test ;# ok
> =A0$ git checkout master -- blah/file7 ; test ;# broken
> =A0$ edit blah/file7 ; test ;# ok
> =A0$ git reset --soft master
> =A0$ git commit -a -m 'The change to file3 was borked on the other en=
v' -e
>
> and in this particular case, this would be what I would have done, as=
 a
> separate "fix-up" commit will give me a place to describe why a solut=
ion
> different from the initial attempt, which was Ok on the original mach=
ine,
> was necessary.

Thanks Junio, that's exactly what I was trying to do.  I keep getting
confused about checkout vs. reset.  Both affect the index and the
working copy.  Both manipulate the ref pointer.  I just can't keep
straight when I should use reset.  I understand using checkout to grab
a particular version of the repository.

But your recipe is what I wanted to do.  I just used "checkout"
instead of "reset --soft".

Thanks again.

--wpd
