From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to date 
	with -f
Date: Fri, 13 Feb 2009 07:51:17 +0100
Message-ID: <bd6139dc0902122251j24696806xb89de3e338d49cb@mail.gmail.com>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
	 <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0902121357l1eea7b8xe890513b756e97c2@mail.gmail.com>
	 <7viqnfi6la.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0902121524o776703bdw1bb199caecbc9c21@mail.gmail.com>
	 <7vhc2zglz4.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0902122202r25e2e320m19810097cbb54225@mail.gmail.com>
	 <7vd4dmg8k1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 07:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXruu-0003hl-MF
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 07:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbZBMGv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2009 01:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbZBMGvZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 01:51:25 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:48192 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbZBMGvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2009 01:51:24 -0500
Received: by bwz5 with SMTP id 5so1504889bwz.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 22:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=mn9VZBMTzRBxJcZql6pVNCAnX3I5LF8VWD+fgAEpeIQ=;
        b=tA5jNGyQCtSZii79zOamfAUZN675TLXW+AduZW2ezWgtpD8TnbD8kxtz7ewisa7/np
         DI4ohLhmjg6Et3Mjo5v14jJUBoJYby98a5kfC6+Ba8zf3PBs1Qm5dNaVZ2pQHOJ21/mN
         1+JKL7c/3g9ou3DPJuIh42PlAJ9wjFDSio8Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=D0HlLNa0+VrTYqVlzaFfKEBSjp1eGql3KJkKWgiwJ09GCjuXjZQ0X4Pov5y2GzPuAi
         KNygnupliV89liWbiEnvI5x0DubkQfu+UAwYuF7GNiV6evuI45kVuee3dvJ/4a5tUg2J
         Al6w7Gy6g+qpLvM5kXKua9DkFsxeOEjXZoiBE=
Received: by 10.86.60.14 with SMTP id i14mr88842fga.70.1234507877466; Thu, 12 
	Feb 2009 22:51:17 -0800 (PST)
In-Reply-To: <7vd4dmg8k1.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: ce5b986e56efaebb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109715>

On Fri, Feb 13, 2009 at 07:22, Junio C Hamano <gitster@pobox.com> wrote=
:
> I thought I left it up to you ;-).

Ah, I failed to notice that, my bad.

> I can not think of a practical purpose of "git rebase -f" without oth=
er
> options that actively modify the tree each commit records (e.g. the "=
fix
> whitespace" option), perhaps other than to pretend that you committed=
 them
> later than you actually did. =A0A patch that implements --force alone=
 is
> harder to justify, because it is unclear what good it does. =A0It is
> especially true if you make --whitespace=3Dfix imply that behaviour.

Agreed, thanks for the explanation.

> One more thing. =A0I kept saying "detect --whitespace=3Dfix (or its s=
ynonym
> strip)" because people can have "apply.whitespace =3D fix" in their
> configuration file for use with "git am", and countermand the
> configuration with "git rebase --whitespace=3Dwarn". =A0Such a usage =
should
> not imply --force.

Ok, so having 'apply.whitespace =3D fix' in your config _should_ imply
-f, and '--whitespace=3D[no]warn' as commandline option should not
affect '-f'. This does mean though that anyone with 'apply.whitespace
=3D fix' in their git config that does a rebase on an up-to-date branch
will automagically have the whitespace fixed. Then again, that
behavior is probably desired for those with 'apply.whitespace =3D fix'
set.

I'll look into making --whitespace=3Dfix/strip imply -f then, and this
time add some tests :).

--=20
Cheers,

Sverre Rabbelier
