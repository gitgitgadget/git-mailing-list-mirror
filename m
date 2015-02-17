From: Fairuzan Roslan <fairuzan.roslan@gmail.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Wed, 18 Feb 2015 00:58:25 +0800
Message-ID: <CA0F915F-74B1-4292-AFB8-D1A4C76C0137@gmail.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com> <vpqtwyl90mx.fsf@anie.imag.fr> <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com> <vpqiof14qu8.fsf@anie.imag.fr> <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com> <vpqr3tozzs5.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: multipart/signed; boundary="Apple-Mail=_0B00C4FE-9220-47A1-95E3-6ACAAAC9F841"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: gitster@pobox.com, git@vger.kernel.org, tboegi@web.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:58:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlTq-0002ep-HI
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 17:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbbBQQ6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 11:58:34 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36659 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbBQQ6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 11:58:32 -0500
Received: by pabkq14 with SMTP id kq14so7603468pab.3
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 08:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=2xmMViYGA4EH1l990CCjr51ku6H+Xnks0js+62qZJx8=;
        b=We6l+FDAZlvZIBNXRIddf9Opuz/PO/gIfg8B+1iQAibyHbY4pTnKlWfJsANg/HYxdj
         8FToFUkB/ZMheHc5rzz8tL0uLYkTa+yh9nq/p9Cen/TOs19wlvx84bgAINDWXj3MFB/W
         c1p5Of4eqil5CO/vvD5K3jrFRDscCxxBxjPioTF9ctn+f2lLrwSDBgJcRs9GyXFgY/UJ
         uzK3mb0giwc55ckRQ7wwACVFrzWREfYwbVdE4CSHbREOT5KuaOGBW7/CUmS2oxrljn71
         uZuIrcYr96dlK2BBcbtZfcfpTxp8PAfvkMhj8iDIyLTMZyQrsWhXi66hVpXyryvFHbHY
         WSlQ==
X-Received: by 10.70.124.202 with SMTP id mk10mr40728691pdb.159.1424192311244;
        Tue, 17 Feb 2015 08:58:31 -0800 (PST)
Received: from ?IPv6:2001:e68:5422:4c50:9d82:230d:f357:e77e? ([2001:e68:5422:4c50:9d82:230d:f357:e77e])
        by mx.google.com with ESMTPSA id cz1sm18204831pdb.32.2015.02.17.08.58.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Feb 2015 08:58:29 -0800 (PST)
X-Pgp-Agent: GPGMail 2.5b5
In-Reply-To: <vpqr3tozzs5.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263954>


--Apple-Mail=_0B00C4FE-9220-47A1-95E3-6ACAAAC9F841
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 17, 2015, at 4:51 PM, Matthieu Moy =
<Matthieu.Moy@grenoble-inp.fr> wrote:
>=20
> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>=20
>> $ git clone https://github.com/robbyrussell/oh-my-zsh.git
>> Cloning into 'oh-my-zsh'...
>> remote: Counting objects: 11830, done.
>> remote: Total 11830 (delta 0), reused 0 (delta 0)
>> Receiving objects: 100% (11830/11830), 2.12 MiB | 481.00 KiB/s, done.
>> Resolving deltas: 100% (6510/6510), done.
>> warning: unable to unlink =
/Volumes/installer/oh-my-zsh/.git/objects/pack/tmp_pack_zjPxuc: =
Operation not permitted
>=20
> This should be fixable from Git itself, by replacing the calls to
> "unlink" with something like
>=20
> int unlink_or_chmod(...) {
> 	if (unlink(...)) {
> 		chmod(...); // give user write permission
> 		return unlink(...);
> 	}
> }
>=20
> This does not add extra cost in the normal case, and would fix this
> particular issue for afp shares. So, I think that would fix the =
biggest
> problem for afp-share users without disturbing others. It seems
> reasonable to me to do that unconditionnally.
>=20
>> $ rm -rf oh-my-zsh/.git/objects/pack/tmp_*
>> rm: oh-my-zsh/.git/objects/pack/tmp_idx_oUN1sb: Operation not =
permitted
>> rm: oh-my-zsh/.git/objects/pack/tmp_pack_zjPxuc: Operation not =
permitted
>=20
> What happens if you do "rm -fr oh-my-zsh/.git/objects/pack/" (i.e.
> remove the directory, not the files)?
>=20
> If you can still remove the directory, then I'd say the solution above
> could be sufficient: the user isn't supposed to interfer with the
> content of .git/objects other than by using Git, and if he or she =
does,
> then asking a chmod prior to an rm seems reasonable.
>=20
> If you can't, then it's another problematic use-case (basically, you
> can't just "rm -fr" a whole clone), and then it deserves at least an
> opt-in configuration to get writable pack files.
>=20
> (Unfortunately, I suspect we're in the later case)
>=20
>> If you insist on setting the tmp idx & pack file permission to 0444 =
at
>> least give it a u+w permission whenever you try to unlink and rename
>> it so it won=E2=80=99t fail.
>=20
> Yes. In case you hadn't guessed, this is precisely what I had in mind
> when I asked "Is it a problem when using Git [...] or when trying to
> remove files outside Git?".
>=20
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Yes. It=E2=80=99s a problem when using Git where it fails to unlink and =
rename the tmp idx and pack files.
The reason I tries to rm -rf the tmp_idx_XXXXXX and tmp_pack_XXXXXX is =
to proof a point why Git fails

Perhaps my explanation wasn=E2=80=99t clear enough. Maybe it=E2=80=99s =
hard for you to understand without having to test it yourself on a AFP =
filesystem.

Let me explain why AFP filesystem is more strict and different from your =
typical filesystem like ext4,hfs+,etc.

$ mkdir testdir; chmod 0755 testdir; touch testdir/testfile; chmod 0444 =
testdir/testfile; ls -la testdir
total 0
drwxr-xr-x  1 user  staff  264 Feb 18 00:26 .
drwx------  1 user  staff  264 Feb 18 00:26 ..
-r--r--r--  1 user  staff    0 Feb 18 00:26 testfile

$ rm -rf testdir
rm: testdir/testfile: Operation not permitted
rm: testdir: Directory not empty

$ chmod +w testdir/testfile; ls -la testdir
total 0
drwxr-xr-x  1 riaf  staff  264 Feb 18 00:26 .
drwx------  1 riaf  staff  264 Feb 18 00:26 ..
-rw-r=E2=80=94r--  1 riaf  staff    0 Feb 18 00:26 testfile

$ rm -rf testdir <=E2=80=94=E2=80=94 No error message

This show that you cannot delete a directory or a file without a write =
permission in AFP filesystem.

The problem with Git failing is not because its inability to delete a =
directory but its inability to unlink and rename tmp_idx_XXXXXX and =
tmp_pack_XXXXXX because those files were set to 0444 by odb_mkstemp.
Try google for =E2=80=9CGit AFP=E2=80=9D and you will see a lot people =
are facing with the same problem.

Regarding your suggestion, yes I think it would work but you have to =
take care (chmod) every calls that rename or unlink or delete files with =
0444 permission.

Regards,
Fairuzan



--Apple-Mail=_0B00C4FE-9220-47A1-95E3-6ACAAAC9F841
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJU43MxAAoJEKrU1IvC77KV9uQIAJboCQnn6U58BjzubENsj5tp
cR0Of+uTLMSLV685VJPZbJykTBV2jNCSREpiuZfdyxsz1vNPe/grrygGU2gh9qj7
0KACtjiHX5mtFUT1ucZAHmVkvYdpBqMv3keqCU2t3dsTOAlR8T4y8TK8fDeSin9y
wOqtuleHaqdcGG0AWJ2BdibwiOxCSZ60067btqALTPvETQNHBJ86RA4oXfRGWctl
JQyx2DjwWX0+3iXnW/KUGO4wHjRKgFRCcY1jDKO1f8ZucgCS+cXCxE3Q+bYK58Bi
GLBL1n4P9rMnwdmo2hVa4433xRpqGxM0cG8Rns9HMcfXfjc8iUCdM0RdQM1oVsM=
=vtF3
-----END PGP SIGNATURE-----

--Apple-Mail=_0B00C4FE-9220-47A1-95E3-6ACAAAC9F841--
