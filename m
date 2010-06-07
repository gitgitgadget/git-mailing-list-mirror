From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] Add memory pool library
Date: Mon, 7 Jun 2010 15:28:13 +0200
Message-ID: <AANLkTimzuJXjX4OJUkmQtLwjGDgHBaZUHSGA0xUUi6kY@mail.gmail.com>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com> 
	<1275658871-1473-2-git-send-email-artagnon@gmail.com> <20100604182928.GB20909@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 15:28:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLcNe-0007ka-9P
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 15:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343Ab0FGN2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 09:28:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52583 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab0FGN2f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 09:28:35 -0400
Received: by bwz11 with SMTP id 11so944161bwz.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eG7zi1vPQd8GwiaDu8LMcmxz0cqrg6+OdKlFmC/YL4Y=;
        b=OU4/DDYvoL2D7iwaqMsM+TWubaBkEz+KzzJ0Stz9UZIfm0w2lIqQMqdbLHbUECLBMq
         Jf41CtZBHP72uGmfemFOOlTYec5gka81yBZxoAPhj+gsSatlknS8uQtcOd64kVsf4/Kt
         2xmx71lYUjUxJw9TO/3M+YNeE36MHRnjzY3ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sTLx5aXgVIfo97FtY6ieOt6Bx/8KPLeECzaGk791jp0OFyock5uSDPEyRIfdyoDKHy
         UF8k2tqX4idQbT6vLopNXzqgtl/FTwrfujvhwzgiSa7VqNbQTTOUwMk4WQA1SeGQ2Wvh
         6rzWjoIFmqiPVtziz3MYCXutpWPienEgZ10nI=
Received: by 10.204.3.78 with SMTP id 14mr6742058bkm.212.1275917314102; Mon, 
	07 Jun 2010 06:28:34 -0700 (PDT)
Received: by 10.204.76.11 with HTTP; Mon, 7 Jun 2010 06:28:13 -0700 (PDT)
In-Reply-To: <20100604182928.GB20909@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148593>

Hi Jonathan,

Jonathan Nieder wrote:
> =C2=A0The memory pool library is distinguished from the existing spec=
ialized
> =C2=A0allocators in alloc.c by using a contiguous block for all alloc=
ations.
> =C2=A0This means that on one hand, long-lived pointers have to be wri=
tten as
> =C2=A0offsets, since the base address changes as the pool grows, but =
on the
> =C2=A0other hand, the entire pool can be easily written to the file s=
ystem.
> =C2=A0This allows the memory pool to persist between runs of an appli=
cation.
>
> =C2=A0For svn-fe, such a facility is useful because each svn revision=
 can
> =C2=A0copy trees and files from any previous revision. =C2=A0Therefor=
e the
> =C2=A0relevant information for all revisions has to persist somehow t=
o
> =C2=A0support incremental runs.
>
> =C2=A0The current implementation is backed by the file system using m=
map().
>
> Thanks for the explanations, David.

Thanks. Added to commit message: should be fine the next time I post th=
e series.

> Whitespace damaged.

=46ixed in b180ad7 (pushed few seconds ago).

> Probably an ignorant question, but why? =C2=A0I do not think the win3=
2 mmap
> emulation in git currently supports sysconf().

I'm not sure why the pool capacity should be dependent on the page size=
=2E

> =C2=A0 =C2=A0 =C2=A0 =C2=A0..._pool.file =3D open(..., O_RDWR);

=46ixed in b180ad7 (pushed few seconds ago).

> This is the first use of MAP_SHARED in git.  I wouldn=E2=80=99t be su=
rprised if
> the win32 mmap emulation does not support it.

You're right; I just checked. compat/mmap.c:7 clearly specifies that
only MAP_PRIVATE is supported.
	if (start !=3D NULL || !(flags & MAP_PRIVATE))
		die("Invalid usage of mmap when built with NO_MMAP");

What can we do about this? Should we attempt to implement MAP_SHARED?

> Necessary? =C2=A0(Maybe yes: we are about to truncate the file, so th=
e
> fsync() may be intended to force the data to be committed before
> the metadata.) =C2=A0Portable? =C2=A0(I suspect the fsync() should go=
 after
> the munmap().)

You want to flush changes *after* unmapping the pages of memory from
the file? I can't find any notes on portability relating to this- can
you clarify?

> Because of these portability concerns, I=E2=80=99d rather use the old=
 version
> until the incremental parser is ready.

Rolling back that many changes can be more painful than actually
fixing these few concerns (especially large number of change after
`dirents` was merged in). It means more delay in getting the exporter
merged.

-- Ram
