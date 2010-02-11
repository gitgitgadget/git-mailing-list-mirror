From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] rev-parse: make --git-dir return /.git instead of 
	//.git
Date: Thu, 11 Feb 2010 17:07:22 +0700
Message-ID: <fcaeb9bf1002110207i54366c2doa5ca951d2e87876d@mail.gmail.com>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com> 
	<1265734950-15145-2-git-send-email-pclouds@gmail.com> <201002092018.55951.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 11:07:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfVxc-0002ui-Jb
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 11:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab0BKKHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 05:07:43 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:33076 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab0BKKHm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 05:07:42 -0500
Received: by pzk2 with SMTP id 2so393056pzk.21
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 02:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EpMatj5dMfHF7xXQF12e+AoK9AihfsbxRi8WZLt0gbo=;
        b=h3PQfVTdFmEOUUtJ13q/9dPAJNRTqKSASWI0jTIJGpGDjBnxjo15ualxlK5w4iQmtW
         xrlrOgOZy3GHu3xH6Ww7zbIQhFAohQLg59fccaw8dzQpXPoz4cJMPCeYpe9gfvpvT+BP
         ZmLkBi8hpAl3m2XR4BaJw8fCWhUkAUuEkOarU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YWWtntMiE0l95q9suARYdqsz1PApcymOk12dmcEEvlgwjW59q7XywNWUku06qcE+O8
         VnGUI/9OKnlMEq3yGWe+wgwBzRyKAVmkGoGe2MUxSEHJOtqHMqgQJZHReG0MJfCtAOQb
         7at0jn4sfisCfDvnUY44gOOpE/IsU9mwbUMWI=
Received: by 10.115.3.1 with SMTP id f1mr1011289wai.179.1265882862136; Thu, 11 
	Feb 2010 02:07:42 -0800 (PST)
In-Reply-To: <201002092018.55951.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139581>

On Wed, Feb 10, 2010 at 2:18 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 9. Februar 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy wrote:
>> @@ -647,7 +647,7 @@ int cmd_rev_parse(int argc, const char **argv, c=
onst
>> char *prefix) }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!getcwd(cwd, PATH_MAX))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_err=
no("unable to get current working directory");
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("%s/.git\n", cwd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("%s%s.git\n", cwd, *cwd =3D=3D '=
/' && cwd[1] =3D=3D '\0' ? "" : "/");
>
> On Windows, when you are in the root of a drive, then cwd is "C:/", i=
=2Ee. there
> is a trailing slash just as in the Unix root directory. But you do no=
t take
> care of this situation. That is, you would print "C://".
>
> How about:
>
> static inline int is_root_path(const char *path)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (has_dos_drive_prefix(path))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path +=3D 2;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (is_dir_sep(*path))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return !*path;
> }
>
> and use it though-out your series?
>
> (Simplify the loop to 'return is_dir_sep(*path) && !path[1];' if you =
can
> assume that paths are nomalized.)

And return the length of root_path, so that I can use this function in
in setup_git_directory_gently() too. Yeah.
--=20
Duy
