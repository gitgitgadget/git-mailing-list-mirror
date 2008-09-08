From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [StGit PATCH] add option to import series directly from a tar
 archive
Date: Mon, 08 Sep 2008 13:11:37 -0500
Message-ID: <48C56AD9.6040007@gmail.com>
References: <48C34EC7.9040102@gmail.com> <20080908180317.GA6123@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KclEN-0003Vi-2y
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 20:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbYIHSLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 14:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbYIHSLp
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 14:11:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:49660 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbYIHSLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 14:11:44 -0400
Received: by wx-out-0506.google.com with SMTP id h27so236089wxd.4
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=qYmmYwx/2ym79jk7wpbyW3WBzcokFr4gLRLIK4P7iRY=;
        b=PyxxEmorQtNXg79RpQipnp9pP73mKtJ/4HVxItc7fzWTYUGT7YPnEynXUoceFaARKp
         mfOWpZvS9fyE1G5VqPxfxR0EZ2VTJDGVfVfSQkSl8x2831t4Zie11nYc84IMf1fouDpQ
         N7kBbKjRUA3CGvSjzlovZdyX2vaGOleUaPUIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=mUGqwk/bn43ook3LFdAmAAT3+ml8PXQYfVwkFhHaJmSJ/zFbA+YuvKoyWXoI1VVW/L
         AwR1CoQMyxdOc/UBpIUEnvZVBR/IeGj9eIg39manLbFYctugmvg9PiLoiR+55rlqI4Jq
         X2eS74d28SCyTbxxE3OpAcQIEEv5Qdn7V0XUg=
Received: by 10.100.94.14 with SMTP id r14mr1395138anb.88.1220897503495;
        Mon, 08 Sep 2008 11:11:43 -0700 (PDT)
Received: from ?172.16.16.136? ( [12.68.228.100])
        by mx.google.com with ESMTPS id c2sm7611405ana.10.2008.09.08.11.11.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 11:11:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080908180317.GA6123@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95283>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl Hasselstr=C3=B6m wrote:
> On 2008-09-06 22:47:19 -0500, Clark Williams wrote:
>=20
>> Attached is my first cut at adding the ability to import a patch
>> series by specifying the tarball.
>=20
> Thanks!
>=20
>> No Karl, I haven't developed a test for it (yet). I wanted to see
>> what you guys thought first :)
>=20
> I don't see a problem with it, and if you took the time to code it
> there is obviously at least one user (I have no idea how common patch
> series tarballs are). I do have some comments below, but nothing that
> would prevent you from writing a test or two right away. ;-)
>=20

Patch series tarballs are quite common from people who use quilt (e.g. =
many of the
kernel -rt series developers). My biggest problem (now that I can direc=
tly import
them) is to see if I can ease StGit's patch import rules a bit, since q=
uilt accepts
pretty much anything as long as there's a diff in there somewhere. I bo=
mb out
regularly importing the -rt series using StGit, because some people don=
't put
complete email addresses in their patches.

As to the test, I'll get right on that...:)

>> +           make_option('--tarfile',
>> +                       help =3D 'import a series from a tar archive=
',
>> +                       action =3D "store_true"),
>=20
> As I hint below, you might want to autodetect tarballs with --series
> instead, since a tarball is just a tarred series directory.

Yeah I thought about that, as well as auto-detecting it in the file cas=
e. I'll look
into that a bit more.

>=20
>> +        if n.startswith("../"):
>> +            raise CmdException, "Relative path found in %s" % tar
>=20
> I guess any occurrence of /../ in the middle of n should be caught as
> well? Or can't that happen?
>=20

Hence the "would you guys look at this?". Yeah, I need to detect sneaky=
 stuff like
that too.


> By the way, is the separator always '/' in tarfile? Or should you use
> os.sep? (There is also os.pardir which you could use instead of '..',
> but that might be overdoing it a little ...)

I doubt there are many Windows-generated tarballs out there (except for=
 the Cygwin
case; I believe they use '/'), but I shouldn't be so Unix-centric. I'll=
 work on
cleaning it up.

I did consider adding Zipfile support as well, but didn't get a very go=
od match-up
between tar functionality and zip functionality. Maybe later...

>=20
>> +        raise CmdException, "no series file found in %s" % tar
>=20
> Perhaps "no 'series' file ...", to make it clear what the name should
> be?
>=20

Yeah, that makes sense.

>> +    # unpack into a tmp dir
>> +    tmpdir =3D tempfile.mkdtemp('.stg')
>> +    t.extractall(tmpdir)
>> +
>> +    # apply the series
>> +    __import_series(os.path.join(tmpdir, seriesfile), options)
>=20
> Hmm. It seems like such a waste to go via the file system here, when
> tarfile has such nice file extraction methods.
>=20
> What you could do is something like this:
>=20
>   1. Make two small classes with the same interface, one backed by a
>      tarfile and one backed by a directory, that have two methods:
>      get_series() and get_file(filename). Both methods return
>      file-like objects (created by either open() or
>      tarfile.extractfile()).
>=20
>   2. Change __import_series() to use objects of this class rather tha=
n
>      a directory directly -- starting with creating an instance of on=
e
>      or the other depending on tarfile.is_tarfile(). This will involv=
e
>      teaching __import_file to accept a file-like object instead of
>      just a file name, but that's a one-liner.
>=20
>   3. Drop the --tarfile flag, since you've just taught the --series
>      flag to handle tarballs!
>=20
> That said, if you don't feel like doing it the hard way, I won't
> insist. The way you coded it is in no way bad (in particular, you
> chose the right function to create a temp dir).

I did consider pulling directly from the tarball. I'll look into it.

>=20
>> +    # cleanup the tmpdir
>> +    os.system('rm -rf %s' % tmpdir)
>=20
> Aaah! My eyes! My _eyes_!!!!!
>=20
> Seriously, though, you'd want to use something like shutil.rmtree
> here.
>=20

Man, I could not for the life of me remember which module had that in i=
t. To be fair
I wasn't up at work with my Python Essential Reference, which would hav=
e pointed me
directly at it, but I would have thought I could have gotten there thro=
ugh the Python
docs. Sigh...

You can dock my StGit pay for the visit to the eye doctor :)

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjFatgACgkQqA4JVb61b9fMRQCeLfK0zhPNEq3t5M4HW+vbRtaG
VhgAn0rtszqVLbd1bz12MS0b/3r0OkT2
=3Dgkf1
-----END PGP SIGNATURE-----
