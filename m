From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] make_absolute_path(): Do not append redundant slash
Date: Thu, 11 Feb 2010 17:00:20 +0700
Message-ID: <fcaeb9bf1002110200l89f8285k8c27ff916e295ac9@mail.gmail.com>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com> 
	<201002092010.43910.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 11:00:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfVqq-0006kH-S8
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 11:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab0BKKAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 05:00:42 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:53041 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab0BKKAl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 05:00:41 -0500
Received: by pzk2 with SMTP id 2so386085pzk.21
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 02:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LET+TPURKxx88vxY0q0iDRWlznzTAYDgsS5myTf7yoo=;
        b=MnAJshfURVQG0b8JYaknpt7L0PLkCLTy94t4+ywuNyHgTs9IApQlujmkgRfLkC4Mei
         8fgs6f9eQolgZe2z0cR0IH8YN7TOVdh6UeX8UbvtbOcaWdedoxrfW1ee9AdEAPB0tVmO
         5AR6D1JsSq/6e1vgBrH6puNFIhbXHSpQt+F8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dydpwFioL8FT8/ZBzBjFrshZy40EBZtx5TpmDhslPIpa2KbAtiA8uMGyI/ppQeDFNk
         lmh/UrGlPorhnv2enl91il7B5zOM219M7Eivhh+VNCT3MJIvkkSb0LdeuV0KbzebHZ6Z
         YAJ/VH0lA9GcST4MbmRLxAjy/75xIphIf8qdk=
Received: by 10.114.68.9 with SMTP id q9mr1064935waa.20.1265882440099; Thu, 11 
	Feb 2010 02:00:40 -0800 (PST)
In-Reply-To: <201002092010.43910.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139579>

On Wed, Feb 10, 2010 at 2:10 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 9. Februar 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy wrote:
>> @@ -54,8 +54,9 @@ const char *make_absolute_path(const char *path)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (len + strlen(last_elem) + 2 > PATH_MAX)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die ("Too long path name: '%s/%s'",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 buf, last_elem);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 buf[len] =3D '/';
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strcpy(buf + len + 1, last_elem);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (*buf !=3D '/' || buf[1] !=3D '\0')
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[len++] =3D '/';
>
> Huh? You are adding a slash unless buf is exactly "/". That is, when =
buf
> is "/foo/" you still add a slash? That's not exactly avoiding redunda=
ncy.
> (Disclaimer: I didn't analyze the rest of the function whether my cla=
im is
> true.)

buf is set by getcwd() so it should never be "/foo/" but doing

if (len && buf[len-1] !=3D '/') buf[len++] =3D '/';

is probably clearer (and works on Windows too).
--=20
Duy
