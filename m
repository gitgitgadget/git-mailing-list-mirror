From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] setup_git_directory(): return to original cwd upon 
	reaching .git
Date: Sat, 24 Jul 2010 21:45:23 +1000
Message-ID: <AANLkTik44c_piRQopbK9utUS30E37LnjTMLs_Wp_8TV9@mail.gmail.com>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com> 
	<20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:45:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcdAt-0004mm-T7
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab0GXLpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 07:45:44 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45364 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0GXLpn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 07:45:43 -0400
Received: by pzk26 with SMTP id 26so451455pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=I0geIL5HAJYAl/4bb0pV9ktjb6juRvqZ8GV7QHOxg/8=;
        b=DfZZapr3VzzKANTerAh43VOLqhiOYt3/49pSHJk0eRlccSe1qN9KnuBQ7DwIl8znOG
         3t2OqBGvYl4OhqN+AQa36p6fKmmK/eaD8BOMr4yU22ReB2j3cH4f6uI4tHD2KNibNC6W
         uoQIjqPkI75f7RlbH9WbKz1kEg2JSeU7IVu2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sU5z1ybtfkHBURXbJ5TmoWDUbkI+cj5xawJybV32JIBGmilCRZrmg8SAWFLoXvKFpT
         GlsthPULYZ4klupQrFr0PThBovvGTFFCi7j/IKgjtRKG8TppUPwfar6+NoNqTL+vKSf5
         EYRUU2neP2DXbS+/WFBb3YC0QCYIcLDsriap0=
Received: by 10.142.237.12 with SMTP id k12mr5749840wfh.69.1279971943255; Sat, 
	24 Jul 2010 04:45:43 -0700 (PDT)
Received: by 10.142.98.1 with HTTP; Sat, 24 Jul 2010 04:45:23 -0700 (PDT)
In-Reply-To: <20100724111505.GC7150@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151621>

2010/7/24 Jonathan Nieder <jrnieder@gmail.com>:
> Hi Duy,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Prefix and cwd should be consistent.
>
> I agree with this, but it took me a while to figure out why your fix
> is safe. =C2=A0Here=E2=80=99s how I figured it out.
>
> Patch 1 cleans up the test script you added a test to. =C2=A0After cl=
eaning
> it up, it is clearer the test does not belong there.
>
> Patch 2 creates a proper home for the new test.

The test was originally to demostrate the breakage and apply was
chosen because it's the first command I found applicable. I doubt if
only "apply" (and index-pack) were affected.

But anyway, more tests can't harm git.

>
> Patches 3-7 split up setup_git_directory_gently() into small enough
> pieces that a person with a short attention span can read it now.
> No functional change intended.

Yeah. I tempted to clean up setup_*_gently too, by splitting the
discovery path ($GIT_DIR check, chdir up...) and the real setup (bunch
of global variables, prefix, check_format, set_git_dir) apart. The was
painful and did not improve readability as much. I gave up.

> Patch 8 is your fix. =C2=A0I removed the comment (which was just conf=
using
> me) and clarified the commit message to compensate

If that makes it easier to understand, I'm OK.

> Patch 9 is your patch to revert the other, now redundant fix, also
> with commit message tweaks.
>
> After this exercise, your patches still look good. :) =C2=A0Maybe the=
se
> by-products could be useful somehow.
>
> Thoughts (especially improvements) welcome.
--=20
Duy
