From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Fri, 18 Mar 2011 17:34:07 +0700
Message-ID: <AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
References: <1300359664-6230-1-git-send-email-cmn@elego.de> <1300371853-8965-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 11:40:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0X68-00005n-U1
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 11:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab1CRKj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 06:39:56 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60097 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab1CRKjy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 06:39:54 -0400
Received: by yxs7 with SMTP id 7so1505822yxs.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=L5mwbM8l6IT8cpKk0bSGrYyff3Irr6TdNef/B0hKCx0=;
        b=cCIe6jC8qANHH9hxxpMoSALMJL2C3zs0u5D+HQgIJuHt0yligsGq5zROgk/g8r7iN2
         PYlglzRjBhTnz1JBhVXbMPJAaFoS4E2VMP/K0w9nTz9t1U1yWwC3QT7JxUbvU8ZD0wBE
         qyNtdWhy5OPpZzbxfnxkw2+zVYM6gsnONveMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i4aERpKf+AOuck+uIl8y+HLPyo86+NcpdrimVVxtfI59yF6lGwytwMnjJrzNaF0jJZ
         2rqRBTz6sng6d1fYPryv+BtFKbI3H7xtkDbLxg+qCncuidrP3y2tUMaqrD6CQjuu2uxr
         IYLk/LvPlA7R8SiOj8LvH5fERuslNzz3LtPjw=
Received: by 10.150.169.3 with SMTP id r3mr1054408ybe.331.1300444477181; Fri,
 18 Mar 2011 03:34:37 -0700 (PDT)
Received: by 10.150.220.14 with HTTP; Fri, 18 Mar 2011 03:34:07 -0700 (PDT)
In-Reply-To: <1300371853-8965-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169309>

On Thu, Mar 17, 2011 at 9:24 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> - =C2=A0 =C2=A0 =C2=A0 static const char *system_wide;
> - =C2=A0 =C2=A0 =C2=A0 if (!system_wide)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system_wide =3D sy=
stem_path(ETC_GITATTRIBUTES);
> + =C2=A0 =C2=A0 =C2=A0 static char system_wide[PATH_MAX];

=2E..

> - =C2=A0 =C2=A0 =C2=A0 static const char *system_wide;
> - =C2=A0 =C2=A0 =C2=A0 if (!system_wide)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system_wide =3D sy=
stem_path(ETC_GITCONFIG);
> + =C2=A0 =C2=A0 =C2=A0 static char system_wide[PATH_MAX];

=2E..

> =C2=A0#ifdef RUNTIME_PREFIX
> - =C2=A0 =C2=A0 =C2=A0 static const char *prefix;
> + =C2=A0 =C2=A0 =C2=A0 static const char *prefix =3D NULL;
> =C2=A0#else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static const char *prefix =3D PREFIX;
> =C2=A0#endif
> - =C2=A0 =C2=A0 =C2=A0 struct strbuf d =3D STRBUF_INIT;
> + =C2=A0 =C2=A0 =C2=A0 static char buf[PATH_MAX];
> + =C2=A0 =C2=A0 =C2=A0 int ret;

It was pointed out elsewhere [1] that PATH_MAX only specifies max
length of a path element, not full path. I think we'd need to stay
away from preallocated PATH_MAX-sized arrays.

[1] http://mid.gmane.org/AANLkTikXvx7-Q8B_dqG5mMHGK_Rw-dFaeQdXi0zW98SD@=
mail.gmail.com
--=20
Duy
