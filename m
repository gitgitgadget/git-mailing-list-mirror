From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] Makefile: add option to disable automatic dependency generation
Date: Fri, 18 Nov 2011 17:07:44 +0700
Message-ID: <CACsJy8AY9bFR_DXnOhbfMGFBD4Ep6OmKF4EiCgUdNiZi-rjMLA@mail.gmail.com>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net> <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <20111118045742.GA25145@elie.hsd1.il.comcast.net> <7vty62klg9.fsf@alter.siamese.dyndns.org>
 <20111118095820.GF25145@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 11:08:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRLMu-0007vZ-28
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 11:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565Ab1KRKIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Nov 2011 05:08:18 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53273 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462Ab1KRKIQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2011 05:08:16 -0500
Received: by bke11 with SMTP id 11so3211245bke.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9XNbyweV6Hql/p92lf0Ho5DWCiICwS0k63+WBlh1/c0=;
        b=l8J8rOUdlkHWk7DqMW138HDLZJVJNEgPhee5G5SQtK/u2mlB2o3/hai1uFoyuvheRM
         Zn0ynlpyfp3mUwhop/wY/lyPYVkVLu86bwIGiRFcwDIfJ6kQZFUzRlnvWtVrWGTsSXyd
         320Eeu6RtY+mXQXWZvg6hEeIRcChkAXK1f2Fo=
Received: by 10.204.10.81 with SMTP id o17mr2605784bko.65.1321610895292; Fri,
 18 Nov 2011 02:08:15 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Fri, 18 Nov 2011 02:07:44 -0800 (PST)
In-Reply-To: <20111118095820.GF25145@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185646>

On Fri, Nov 18, 2011 at 4:58 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Now that the COMPUTE_HEADER_DEPENDENCIES feature is turned on
> automatically for compilers that support it (see v1.7.8-rc0~142^2~1,
> 2011-08-18), there is no easy way to force it off. =C2=A0For example,
> setting COMPUTE_HEADER_DEPENDENCIES to the empty string in config.mak
> just tells the makefile to treat it as undefined and run a test
> command to see if the -MMD option is supported.
>
> So allow setting COMPUTE_HEADER_DEPENDENCIES=3Dno to explicitly force
> the feature off. =C2=A0The new semantics:
>
> =C2=A0- "yes" means to explicitly enable the feature
> =C2=A0- "no" means to disable it
> =C2=A0- "auto" means to autodetect
>
> The default is still "auto". =C2=A0Any value other than these three w=
ill
> cause the build to error out with a descriptive message so typos and
> stale settings in config.mak don't result in mysterious behavior.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Makefile:1278: *** please set COMPUTE_HEAD=
ER_DEPENDENCIES to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0yes, no, or auto (not "1"). =C2=A0Stop.
>
> So now when someone using a compiler without -MMD support reports
> trouble building git, you can reproduce it by running "make
> COMPUTE_HEADER_DEPENDENCIES=3Dno".
>
> Suggested-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
> Improved-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Tested-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
--=20
Duy
