From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCHv2] Add a remote helper to interact with mediawiki, pull &
 clone handled
Date: Tue, 7 Jun 2011 11:16:30 +0100
Message-ID: <BANLkTik--BAqZxCYQ-ApUn2yKmcr_-hubg@mail.gmail.com>
References: <1307440754-3697-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?Q?Sylvain_Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 12:16:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTtL9-0007vF-Fh
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 12:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab1FGKQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 06:16:46 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33859 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab1FGKQp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 06:16:45 -0400
Received: by qyg14 with SMTP id 14so2406475qyg.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WP3hIkhtgqw0L5/Q4i2ms460dLXiU3L23/ZcUkScqXk=;
        b=EHQZ2zl4AY997LcJnaW4WPVrAwbEN+Gks/4DlbFqGVQIlmKC5neuURhdEp4M3r2pKj
         ZhNArbwaDva/1rjUolZSzD94mya742Bd7MCQxT/tWb0tDW202aH47SELQgEVsDzxcl8Q
         IpIKkhhHy2wjTBxwX7j3ghXzew+Mh19WV+hRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=BLyd/oGO2iqhqFoYSfjZuGiGR0g9EwrxYKJVZqYHPCscz/AFZCzjDwYAOlHO/SNJit
         ro+zJIy0ACkpvKPrG5k7NFOTquNGBKaMi057iFxq5UsyPodnISrPN/cVkPhac1U+WcFs
         fzCM+5wGwQiuA1THJp60EXNbpCyIbJcB+09FI=
Received: by 10.229.77.166 with SMTP id g38mr4421016qck.60.1307441805080; Tue,
 07 Jun 2011 03:16:45 -0700 (PDT)
Received: by 10.229.189.12 with HTTP; Tue, 7 Jun 2011 03:16:30 -0700 (PDT)
In-Reply-To: <1307440754-3697-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
X-Google-Sender-Auth: YhneetGWnxk34OtRxEetwzyCikI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175191>

Hi,

On 7 June 2011 10:59, Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr> w=
rote:
> + =C2=A0 =C2=A0 =C2=A0 @cmd =3D split(/ /,$entry);

Hmm.  What guarantees can you make about the scalar value of @cmd here
once the split has happened?  Do you not care, or do you have a
hard-limit for split to use?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 print STDERR "Unknown capability. Aborting...\n";

warn()?

> + =C2=A0 =C2=A0 =C2=A0 print STDOUT "refspec refs/heads/*:refs/mediaw=
iki/$remotename/*\n";
> + =C2=A0 =C2=A0 =C2=A0 print STDOUT "import\n";
> + =C2=A0 =C2=A0 =C2=A0 print STDOUT "list\n";
> + =C2=A0 =C2=A0 =C2=A0 print STDOUT "option\n";
> + =C2=A0 =C2=A0 =C2=A0 print STDOUT "push\n";
> + =C2=A0 =C2=A0 =C2=A0 print STDOUT "\n";

These explicit calls to "STDOUT" here -- why?  It's redundant typing
and unsightly, and certainly not very perl-y.  Is there some reason
why you're using this style?

> + =C2=A0 =C2=A0 =C2=A0 print STDOUT "? refs/heads/master\n";
> + =C2=A0 =C2=A0 =C2=A0 print STDOUT '@'."refs/heads/master HEAD\n";
> + =C2=A0 =C2=A0 =C2=A0 print STDOUT "\n";

Hmm.  Why not just:

print STDOUT '@'."refs/heads/master HEAD\n\n";

There's certainly a large number of perl-specific clean-ups I'd be
inclined to do -- and if I get time later, I might show you how.  But
don't let this necessarily put off this patch for inclusion or
anything like that.

-- Thomas Adam
