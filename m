From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: Re: [PATCH 3/3] fetch --all/--multiple: keep all the fetched branch 
	information
Date: Wed, 24 Feb 2010 23:28:23 +0300
Message-ID: <63cde7731002241228g5ef3154fw5b0c2858cbc168f@mail.gmail.com>
References: <1267035726-2815-1-git-send-email-gitster@pobox.com>
	 <1267035726-2815-2-git-send-email-gitster@pobox.com>
	 <7vpr3uqwya.fsf_-_@alter.siamese.dyndns.org>
	 <63cde7731002241154o40ad7e6eh26f20017f7854fc3@mail.gmail.com>
	 <7vy6iil81k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkNqQ-0000aq-P1
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 21:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab0BXU2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 15:28:25 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:50476 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757453Ab0BXU2Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 15:28:25 -0500
Received: by wwf26 with SMTP id 26so1502770wwf.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 12:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e7Tr1mUDpo+lvTDoS0xc7fqkIqSNsvGy74gKDORP09o=;
        b=KMdtgWyi0GW0h1LquaDuN3LsJ003mA+mDhCi0Cpy9XCiaRNoQBRt1yMtcHhRHdw1Eh
         ibo7UzyyHKkTH39bdv9JuB0svSAJxJIN6Juz4H8hPkTQVhjyfmb4saZicEN9uojAO5F6
         iZNGDThedyM9prVPFlBFaVSk069SBwckctuKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fYD7Y5L4qXgbM0U8GQK6DlAQ9EwaBqf1nYU7XrBM4aMK6uVWHSGwGA//7Kz+LDrlXi
         AMOzWTNUoh65iBPpD6v0WfF78sG7TjC5J9RtoKJ8lq/U4SqhRMKtNNtCnDK6zH4LEeAu
         NidM3bogJP5AsczEzrKM+v6qgJwpMcrFAiQYw=
Received: by 10.216.88.206 with SMTP id a56mr195281wef.64.1267043303776; Wed, 
	24 Feb 2010 12:28:23 -0800 (PST)
In-Reply-To: <7vy6iil81k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140985>

Well, these patches solve the problem.
Thanks for your work!

On Wed, Feb 24, 2010 at 10:59 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Michael Lukashov <michael.lukashov@gmail.com> writes:
>
>> Patch 3 does not apply correctly:
>
> It probably has a trivial confict, because there is an added test to =
the
> second patch since I sent it out. =C2=A0Please add this after applyin=
g [2/3].
>
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index c18d829..84059d8 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -51,4 +51,25 @@ test_expect_success 'git pull -q -v' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -s err)
> =C2=A0'
>
> +test_expect_success 'git pull --force' '
> + =C2=A0 =C2=A0 =C2=A0 mkdir clonedoldstyle &&
> + =C2=A0 =C2=A0 =C2=A0 (cd clonedoldstyle && git init &&
> + =C2=A0 =C2=A0 =C2=A0 cat >>.git/config <<-\EOF &&
> + =C2=A0 =C2=A0 =C2=A0 [remote "one"]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D ../parent
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch =3D refs/hea=
ds/master:refs/heads/mirror
> + =C2=A0 =C2=A0 =C2=A0 [remote "two"]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D ../parent
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch =3D refs/hea=
ds/master:refs/heads/origin
> + =C2=A0 =C2=A0 =C2=A0 [branch "master"]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remote =3D two
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 merge =3D refs/hea=
ds/master
> + =C2=A0 =C2=A0 =C2=A0 EOF
> + =C2=A0 =C2=A0 =C2=A0 git pull two &&
> + =C2=A0 =C2=A0 =C2=A0 test_commit A &&
> + =C2=A0 =C2=A0 =C2=A0 git branch -f origin &&
> + =C2=A0 =C2=A0 =C2=A0 git pull --all --force
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> =C2=A0test_done
>
