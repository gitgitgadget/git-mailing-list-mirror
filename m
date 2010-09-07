From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 20/20] gettextize: git-am printf(1) message to eval_gettext
Date: Tue, 7 Sep 2010 14:10:50 -0600
Message-ID: <AANLkTim_ovWkPPepB7xRez5DTmJRTrFoZWG+Nx0_O=oL@mail.gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
	<1283878224-20202-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 22:11:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot4VO-0004eO-4h
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 22:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214Ab0IGUKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 16:10:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51805 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114Ab0IGUKv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 16:10:51 -0400
Received: by iwn5 with SMTP id 5so5569554iwn.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BrYQL5UXfu/7MuyqzfMZPm27gj+28UPyYoPUWX0lEmU=;
        b=VLsjITSErhQ/YqDDrnahRHwVUosonZQ0OIRnOAtPzYqRp1z+E3zNWjxN35Ly2ZciyE
         cHnEqEjIzW0pjChSu097N4RGTHZkhQY2UE4RcOtU2gQgp0kbdCg5/G+fIzY0ww/gWN3B
         eV5PlrQ3OBxPjuK173hnFYpxQ8LfUjyoNPars=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EG3yWyKfPeWiJeiG8r/uhwsLjYcT8kE1HFLQ8GPsUyhIccaLrNrRIbSHZUolhwVEYi
         d1ccxDKtmBagTOacpselW1yDuBSOMIDnRCqUYzfXbFZD4S4Cz7ttUgZXTgH9ePTyv5lO
         x4GBFH+coWVegxngy+/aQx80a7izxYzQqxHok=
Received: by 10.231.159.204 with SMTP id k12mr8519261ibx.42.1283890250365;
 Tue, 07 Sep 2010 13:10:50 -0700 (PDT)
Received: by 10.231.14.76 with HTTP; Tue, 7 Sep 2010 13:10:50 -0700 (PDT)
In-Reply-To: <1283878224-20202-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155738>

Hi,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +++ b/git-am.sh
> @@ -778,7 +778,7 @@ did you forget to use 'git add'?"; echo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test $apply_status !=3D 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf 'Patch fail=
ed at %s %s\n' "$msgnum" "$FIRSTLINE"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "$(eval_gette=
xt "Patch failed at \$msgnum \$FIRSTLINE")"

Probably I am missing something silly, but why not just:

        eval_gettext 'Patch failed at $msgnum $FIRSTLINE\n'

? I ask because it is nice to be able to avoid "echo" with arbitrary
data: special characters (e.g. \) can make for portability hassles.

Jonathan
