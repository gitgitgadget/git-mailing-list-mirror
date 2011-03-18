From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 3/3 (alternate)] gitweb: Mark "atnight" author/committer
 times also for 'localtime'
Date: Fri, 18 Mar 2011 12:07:43 -0700
Message-ID: <AANLkTi=4wyph4fp7sbtw01+eb7FV=WVN4+dGcYiov35v@mail.gmail.com>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost>
	<64c70e95e767572e5be732dc7e17815b@localhost>
	<201103181846.04979.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 20:07:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0f1a-00045S-Ef
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 20:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600Ab1CRTHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 15:07:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50152 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab1CRTHo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 15:07:44 -0400
Received: by fxm17 with SMTP id 17so3994468fxm.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6Mm+IxqbSlvc2of1IKmbSHYAaQ2qtzD4p8akbDG0f1s=;
        b=FkdejDsO48rskAx9GEfz/vhYWh1ZcKwZThvXAbZtb1buiqiuSvql/LQxVCnbkLv1kB
         qIoBoKUNgPif6EhORZHMmmUbzL8bFU98+pobPMDZ0lu0g4LsFIijFgHGhiLjNaFwA+Ct
         H0fXWHyO0JPXTaVgDb7n891TviFL4dJtoSyME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jBsrtCtceq2ghayhAF+bRpRDbBJvBzNiWdM3kf7sSABaoES7w7aqliY+DvxFLFTcSS
         5PJUbTw+7/CAB9loPeoPgCqCByZZJqmafefZ3+cb6mt2IS7QCqY7z0D20GzNTuvUnU0x
         9ymryOaGR+r6aGli3E26/9IJinkZ/K/ua/CpI=
Received: by 10.223.143.5 with SMTP id s5mr1723985fau.60.1300475263255; Fri,
 18 Mar 2011 12:07:43 -0700 (PDT)
Received: by 10.223.61.83 with HTTP; Fri, 18 Mar 2011 12:07:43 -0700 (PDT)
In-Reply-To: <201103181846.04979.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169347>

On Fri, Mar 18, 2011 at 10:46 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> Kevin, how about something like this instead? =C2=A0This preserves _i=
ntent_
> for why there is local time beside GMT time when 'localtime' is disab=
led
> better, I think.

=46ine with me.  I had to dig around for a while before I could find an
"atnight" commit, so I don't think this is something that is likely to
occur often in my environment.  But I can see how it would be useful
to preserve the existing functionality.

I applied your patch and verified it in both localtime=3D0 and
localtime=3D1 cases.  So:

Tested-by: Kevin Cernekee <cernekee@gmail.com>

> Junio and Kevin, I am not sure if authorship should remain with Kevin=
,
> or should it revert to me; the solution is quite different.

I would suggest reverting it to you.

> @@ -4003,15 +4003,23 @@ sub git_print_authorship_rows {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my %wd =3D par=
se_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "<tr><td=
>$who</td><td>" .
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0format_search_author($co->{"${who}_name"}, $who,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esc_html($co->{"${who}_name"})) . " =
" .
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0esc_html($co->{"${who}_name"})) . " " .
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0format_search_author($co->{"${who}_email"}, $who,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esc_html("<" . $co->{"${who}_email"}=
 . ">")) .
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0esc_html("<" . $co->{"${who}_email"} . ">")) .

=46WIW, this does create a few >80 character lines.  But
CodingGuidelines doesn't say whether that limit applies to Perl
scripts or just C.
