From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Sun, 27 Feb 2011 23:52:34 +0700
Message-ID: <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com> <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 17:53:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptjrs-0004EV-1q
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 17:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab1B0QxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 11:53:08 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54067 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab1B0QxG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 11:53:06 -0500
Received: by wyg36 with SMTP id 36so2984377wyg.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 08:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=2q6UG85OomA9MRKIEo8lRortZYVbEuk96NxCGw+Asj8=;
        b=LB2fV3kcEWZtNJQML1kMriU6rOuxoCR/m+y1trk4UK29w5v2i7F8n+lA7NYZ+qoKjD
         /Ai1zo+3MvCjv4sQ9BBYFHL4LOH30asQ8Rpqe5ZCzUUtvuzLwJNCZKvl6657UL5VOENa
         9poa81rCtx037tis85pwmdH6PQsyT7Dni5EX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rwdt/WFSTGOzdJyXTSCte/edlsh/ZNAcaG8Ie/lQz8qPGrWct7op6BXZv8x8vPqwkC
         egIQ/xGS6RfG3QrkXRXcBw2EdrW0HuWWyzlwMXRSAo6Zc4FwNS8q4Dz+eV9GYgpuQcD/
         RoRZSA3nUIjgLbYMiurFz/jyTQGS6oPoRwu0c=
Received: by 10.216.163.69 with SMTP id z47mr4070954wek.43.1298825584136; Sun,
 27 Feb 2011 08:53:04 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Sun, 27 Feb 2011 08:52:34 -0800 (PST)
In-Reply-To: <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168043>

On Sun, Feb 27, 2011 at 5:46 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Perhaps in this order:
>
> Step 1, as soon as possible:
>
> =C2=A0* Introduce "add.make_update_global" configuration variable, an=
d toggle
> =C2=A0 the above variable when it is explicitly given; also record th=
e fact
> =C2=A0 that you actually saw this variable in the config parser regar=
dless of
> =C2=A0 the value that is given;

Ermm.. compat.make_update_global, with the intent that the config will
be dropped in future (1.9.0 maybe)?

> =C2=A0* Document the configuration variable as a new feature, without
> =C2=A0 indicating that that will be the new default in the future, bu=
t
> =C2=A0 strongly recommending that existing scripts should be updated =
and new
> =C2=A0 scripts should be written the variable in mind---namely, their=
 use of
> =C2=A0 "add -u" should use "." if they are relying on the current "li=
mit to
> =C2=A0 cwd" behaviour.

There's a problem. I use git on many machines. Some will have this
config enabled, some will not (yet). Perhaps a third option, which
will print something when "git add -u" is issued as a reminder? I
don't know. What I need is to notice old behavior of "git add -u"
before it's too late.

> Step 4, 3 cycles after 1.8.0:
>
> =C2=A0* Drop the warning.

Step 5 (1.9.0 or later):

 * Drop compat.make_update_global.
--=20
Duy
