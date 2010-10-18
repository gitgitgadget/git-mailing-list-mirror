From: =?UTF-8?B?UmFmYcOrbCBDYXJyw6k=?= <rafael.carre@gmail.com>
Subject: [CRASH] git segfaults on invalid binary diff
Date: Mon, 18 Oct 2010 18:06:32 +0200
Message-ID: <20101018180632.7eb40628@wai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/eZ2zGUCKnFliLiE73W30B=M"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 18 18:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7sEX-0007rH-8o
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 18:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab0JRQGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 12:06:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62827 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab0JRQGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 12:06:38 -0400
Received: by wyb28 with SMTP id 28so1430530wyb.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type;
        bh=p0mdyaoWzwEXKeMJs5wm6wS9VnGQNsPHeGqZ8nwNV50=;
        b=CtBkAQuT7ePXHBobGd5iGfCwxafGncHW5TLHkaFQAUUZrFEqUv5CVtTnUZgJd26wFs
         NDetMnMeUrfF3qfzBlWGHTMMzgxcAszKUTfGETF1R0TQfijjIBHDgA5omtQLGvDa7Oj5
         NEEOU4L2O1l3QfVtlce7IXf9fCZr5Q7Qi0TnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type;
        b=Nuyj9ECazC1KqsXKuX+TVtVFHL01xLAtcuHuIOB2uEs2RmXjXzCUEwbtUT4j9D2xhn
         t/50oW69v+lHi9UzH0TVufjbpsPWIlGcX+jNCRwq2TdBfT5PvulUbOXg4LwTTRqMfygW
         tVohTeQt6sii4m09/zmrzrisFl95oc3yeWIt8=
Received: by 10.227.32.147 with SMTP id c19mr4825812wbd.43.1287417996761;
        Mon, 18 Oct 2010 09:06:36 -0700 (PDT)
Received: from wai (212.131.193-77.rev.gaoland.net [77.193.131.212])
        by mx.google.com with ESMTPS id b30sm10931939wbb.22.2010.10.18.09.06.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 09:06:36 -0700 (PDT)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159260>

--Sig_/eZ2zGUCKnFliLiE73W30B=M
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed git crashed on a patch generated with:
git show --full-index --pretty=3Demail <commit>

(I had forgotten --binary)

% git --version
git version 1.7.3.1.120.g38a18
% mkdir test
% cd test
% git init
Initialized empty Git repository in /home/fun/test/.git/
% git am ~/bad.diff
Applying: foo bar
Segmentation fault (core dumped)
Patch failed at 0001 foo bar
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
% cat ~/bad.diff
=46rom 2e888fde246ecb0d346ecc02e7df0c82724f02b9 Mon Sep 17 00:00:00 2001
From: John Doe <john.doe@example.org>
Date: Mon, 4 Feb 2008 01:17:33 +0000
Subject: [PATCH] foo
     bar


diff --git a/axvlc.tlb b/axvlc.tlb
new file mode 100644
index 0000000000000000000000000000000000000000..a61182de2f3eb2dc2fc13a08b44=
8b79ae56f1967
Binary files /dev/null and b/axvlc.tlb differ
% gdb git core
GNU gdb (GDB) 7.2-ubuntu
Copyright (C) 2010 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /home/fun/.local/git/bin/git...done.
[New Thread 24102]

warning: Can't read pathname for load map: Erreur d'entr=C3=A9e/sortie.
Reading symbols from /lib/libz.so.1...(no debugging symbols found)...done.
Loaded symbols for /lib/libz.so.1
Reading symbols from /lib/libpthread.so.0...Reading symbols from /usr/lib/d=
ebug/lib/libpthread-2.12.1.so...done.
done.
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libc.so.6...Reading symbols from /usr/lib/debug/l=
ib/libc-2.12.1.so...done.
done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib64/ld-linux-x86-64.so.2...Reading symbols from /us=
r/lib/debug/lib/ld-2.12.1.so...done.
done.
Loaded symbols for /lib64/ld-linux-x86-64.so.2
Core was generated by `git apply --index /home/fun/test/.git/rebase-apply/p=
atch'.
Program terminated with signal 11, Segmentation fault.
#0  0x000000000040c49e in apply_binary_fragment (img=3D0x7fff47152cd0,=20
    patch=3D0x16ef2a0) at builtin/apply.c:2657
2657		switch (fragment->binary_patch_method) {
(gdb) bt
#0  0x000000000040c49e in apply_binary_fragment (img=3D0x7fff47152cd0,=20
    patch=3D0x16ef2a0) at builtin/apply.c:2657
#1  0x000000000040c7ef in apply_binary (img=3D0x7fff47152cd0, patch=3D0x16e=
f2a0)
    at builtin/apply.c:2739
#2  0x000000000040c92f in apply_fragments (img=3D0x7fff47152cd0, patch=3D0x=
16ef2a0)
    at builtin/apply.c:2761
#3  0x000000000040cdc5 in apply_data (patch=3D0x16ef2a0, st=3D0x7fff47152d6=
0,=20
    ce=3D0x0) at builtin/apply.c:2908
#4  0x000000000040d64a in check_patch (patch=3D0x16ef2a0) at builtin/apply.=
c:3098
#5  0x000000000040d6d7 in check_patch_list (patch=3D0x16ef2a0)
    at builtin/apply.c:3113
#6  0x000000000040ef6d in apply_patch (fd=3D3,=20
    filename=3D0x7fff471549e7 "/home/fun/test/.git/rebase-apply/patch",=20
    options=3D0) at builtin/apply.c:3683
#7  0x000000000040faee in cmd_apply (argc=3D1, argv=3D0x7fff471538a0, prefi=
x_=3D0x0)
    at builtin/apply.c:3897
#8  0x00000000004048c5 in run_builtin (p=3D0x766688, argc=3D3, argv=3D0x7ff=
f471538a0)
    at git.c:275
#9  0x0000000000404a60 in handle_internal_command (argc=3D3, argv=3D0x7fff4=
71538a0)
    at git.c:431
#10 0x0000000000404b5a in run_argv (argcp=3D0x7fff4715378c, argv=3D0x7fff47=
153780)
    at git.c:475
#11 0x0000000000404ce2 in main (argc=3D3, argv=3D0x7fff471538a0) at git.c:5=
48
(gdb) frame 0
#0  0x000000000040c49e in apply_binary_fragment (img=3D0x7fff47152cd0,=20
    patch=3D0x16ef2a0) at builtin/apply.c:2657
2657		switch (fragment->binary_patch_method) {
(gdb) print *patch
$1 =3D {new_name =3D 0x16ec0e0 "axvlc.tlb", old_name =3D 0x0,=20
  def_name =3D 0x16ec0e0 "axvlc.tlb", old_mode =3D 0, new_mode =3D 33188,=20
  is_new =3D 1, is_delete =3D 0, rejected =3D 1, ws_rule =3D 19, deflate_or=
iglen =3D 0,=20
  lines_added =3D 0, lines_deleted =3D 0, score =3D 0, is_toplevel_relative=
 =3D 1,=20
  inaccurate_eof =3D 0, is_binary =3D 1, is_copy =3D 0, is_rename =3D 0, re=
count =3D 0,=20
  fragments =3D 0x0, result =3D 0x0, resultsize =3D 0,=20
  old_sha1_prefix =3D '0' <se r\377\377\377\377\377=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD\000\000\000\377\377\377\377\377=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD,=20
  new_sha1_prefix =3D "a61182de2f3eb2dc2fc13a08b448b79ae56f1967", next =3D =
0x0}
(gdb)=20


--=20
=E2=9C=8D Rafa=C3=ABl Carr=C3=A9 =E2=98=BA

--Sig_/eZ2zGUCKnFliLiE73W30B=M
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky8cIgACgkQYWCeGMCv8Q/t5ACglsTVPFCgxNZy/EozMMgZzs1C
y7AAoKFPjpRYSmT8YQvyCwrFgzvPIrPK
=uwpL
-----END PGP SIGNATURE-----

--Sig_/eZ2zGUCKnFliLiE73W30B=M--
