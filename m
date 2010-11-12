From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: 'gettext -- "--cached cannot be used with --files"' does not work
Date: Fri, 12 Nov 2010 01:06:08 +0100
Message-ID: <AANLkTike11Hm2s6un37-jgT8rOyf=7k-Vw7M5vEs+9Vp@mail.gmail.com>
References: <20101112001037.6e0fef15@ivo.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <mkiedrowicz@ivo.pl>
X-From: git-owner@vger.kernel.org Fri Nov 12 01:06:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGh9q-0001qw-89
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 01:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303Ab0KLAGK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 19:06:10 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33204 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab0KLAGJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 19:06:09 -0500
Received: by fxm16 with SMTP id 16so1871675fxm.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 16:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rL3Q166Qny3C0awMjvvCL79qy9MmQOpRXbUaoXFyZ3w=;
        b=d6F8QES0QGaGYO6QU8gQahQVXBMSZnaJUQzDk/FUS1y4ue9b50yniuBvqQ8StzznDj
         3cMu/2rWES/84gZuZp11u/EiLqqW1BL+NtTRGGDjs7TPHJRrBamXGHIrge91hEj/RnYD
         mm9GpRM/+1KF7bHVxHBLWwTl5iYvHOrlkXwlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dOBg/SRHYS8xatWS1AAe6XQvgxUwNrU+Kh9oDqOkrH8AAE5B+12yjfAEBU5Ok/YWJe
         kj7r1gTIbkysa9AiNlWJAn2SK0NynxEQkSAyyWf4Dn6oI2Tot9OWlYyO+qapxTA4pyVh
         w1PmqZjDKwpT4QIbtffLtI++mMxeZc/5JLClA=
Received: by 10.223.83.138 with SMTP id f10mr821418fal.114.1289520368054; Thu,
 11 Nov 2010 16:06:08 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Thu, 11 Nov 2010 16:06:08 -0800 (PST)
In-Reply-To: <20101112001037.6e0fef15@ivo.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161310>

2010/11/12 Micha=C5=82 Kiedrowicz <mkiedrowicz@ivo.pl>:

> I just noticed that
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'gettext -- "--cached cannot be used with =
--files"'
>
> in git-submodule.sh generates
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#: git-submodule.sh:588
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msgid "--"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msgstr ""
>
> in *.po files. You can this e.g. in po/de.po.
>
> This is not what commit message says :)
>
> =C2=A0 =C2=A0gettextize: git-submodule "cached cannot be used" messag=
e
>
> =C2=A0 =C2=A0Gettextize the "--cached cannot be used with --files" me=
ssage. Since
> =C2=A0 =C2=A0this message starts with "--" we have to pass "--" as th=
e first
> =C2=A0 =C2=A0argument. This works with both GNU gettext 0.18.1 (as ex=
pected), and
> =C2=A0 =C2=A0the gettext(1) on Solaris 10.

Thanks for the report. I spotted this a while ago, meant to raise it
and put it on my TODO list.

Then I forgot about it :)

Anyway, the issue is with xgettext(1), not gettext itself. I.e. the
shellscript parser is broken.
