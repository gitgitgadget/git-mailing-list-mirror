From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: done feature in remote-helpers (was Re: [PATCH 2/2] Add a remote
 helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 14:58:38 +0200
Message-ID: <CAGdFq_hFPBeogpX0Qp8Knfssw8QzV+GwCAyH+zZhM2iEJfFYMw@mail.gmail.com>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr> <7v4o14dppz.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
 <7v4o1092hn.fsf@alter.siamese.dyndns.org> <CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
 <vpq1uw13hx3.fsf_-_@bauges.imag.fr> <CAGdFq_jyVK3_THYXzCOLDpNww0Npn2qzZ1qv-BMuLbg1vgVjZw@mail.gmail.com>
 <vpqk49tviza.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 31 14:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QykO4-00088b-6Z
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 14:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449Ab1HaM7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 08:59:19 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:43604 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab1HaM7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2011 08:59:18 -0400
Received: by pzk37 with SMTP id 37so1286816pzk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GqrxSwJUB6CBRoLTUctoKqo6rZRshxp6XY/feXVa1QI=;
        b=EeOW0ZFzWvG0/GbTr6M0E2SNkve9KufEYEnPAddGQfyT3O/yDEAY0l1yOTlaFCU6vu
         WzaOZcrFLyWSO1VgDBIoNefPPWexS13DH+ZFUmaC9Kt0DtMpvxQt93Sml6ml33G0iUes
         DkmUWYRIH1CZvc815Pz1IuFBX++KhnSy+fe3o=
Received: by 10.68.30.201 with SMTP id u9mr453814pbh.361.1314795558067; Wed,
 31 Aug 2011 05:59:18 -0700 (PDT)
Received: by 10.68.55.7 with HTTP; Wed, 31 Aug 2011 05:58:38 -0700 (PDT)
In-Reply-To: <vpqk49tviza.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180466>

Heya,

On Wed, Aug 31, 2011 at 14:55, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Err, no, it isn't. From git-remote-testgit.py:
>
> def do_import(repo, args):
> [...]
> =C2=A0 =C2=A0while True:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0line =3D sys.stdin.readline()
> [...]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# strip of leading 'import '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ref =3D line[7:].strip()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0refs.append(ref)
>
> =C2=A0 =C2=A0repo =3D update_local_repo(repo)
> =C2=A0 =C2=A0repo.exporter.export_repo(repo.gitdir, refs)
>
> =C2=A0 =C2=A0print "done"
>
> What it does is that it reads multiple "import" commands, and process
> them all at once, with a single "print done" at the end. Actually,
> testgit would die("Expected import line.") if Git sent another comman=
d
> after "import".

Ah, see, this is why in my original version the syntax was:

import
refs/heads/master
refs/heads/next
\n

Instead of the current:

import refs/heads/master
import refs/heads/next
\n

You can have multiple imports in the current system, you just need to
remember to add the trailing newline.

import refs/heads/master
\n
import refs/heads/next
\n

In the above case you'll have to have two done commands.

--=20
Cheers,

Sverre Rabbelier
