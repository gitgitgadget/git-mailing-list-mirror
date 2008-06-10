From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 08:54:06 -0500
Message-ID: <484E877E.801@gmail.com>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 15:55:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K64JW-0006fP-Q4
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 15:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbYFJNyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbYFJNyL
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 09:54:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:41312 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbYFJNyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 09:54:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so904012rvb.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=7NW6dPaFw+VWmVKs241DfNZmhPPUVG5GuY+GEUrAHR0=;
        b=oZJc3SEeOArPrs4DdJe7kNAiaWUoaDXrvzBrrXJkMJV+UNJ6yZGv6aXJdbmNjqAZNt
         yPv4eN9eSQ4jW8w3bdCRWVefL7dMGKXxnd/W925XlddKC0qsuLsg4MGs55h15/IGLjz9
         QJH8EPX4glFWzp1tKoI/1fa5QYtLb/tKVH6Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=Vc99w2RVG1wh84dY6/imQIfYY7ddBPTCcOJU+qVjXIzIlezrZVfCCbjrhdlj+OKIAz
         hEz5R/psFPEHXnSFj/JroXzCFQllqmaaoNrjHROQCyh6g9CO9Ucw28x91B5srr8Plq3a
         zIryTXprA0W5QvBbPD1s9Xr0ofJ7KzA1O6+l8=
Received: by 10.141.194.11 with SMTP id w11mr2993294rvp.228.1213106049340;
        Tue, 10 Jun 2008 06:54:09 -0700 (PDT)
Received: from ?192.168.2.37? ( [74.239.78.188])
        by mx.google.com with ESMTPS id 5sm11534604ywl.4.2008.06.10.06.54.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 06:54:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
In-Reply-To: <20080610063328.GB26965@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84501>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl Hasselstr=C3=B6m wrote:
>> +        if filename.endswith(".gz"):
>> +            import gzip
>> +            f =3D gzip.open(filename)
>> +            pname =3D filename.replace(".gz", "")
>> +        elif filename.endswith(".bz2"):
>> +            import bz2
>> +            f =3D bz2.BZ2File(filename, 'r')
>> +            pname =3D filename.replace(".bz2", "")
>=20
> Some comments here:
>=20
>   * By my reading of the docs, the second argument to BZ2File default=
s
>     to 'r' anyway, so you could omit it.

Done.

>=20
>   * We try to use single quotes wherever possible (except when triple
>     quoting). You're using a mix ...

I normally use single quotes too, but I've been doing a bunch of C prog=
ramming
lately, so that's my excuse and I'm sticking with it. Replaced.

>=20
>   * .replace() will happily replace anywhere in the string. Please
>     consider using stgit.util.strip_suffix() instead.

Ah, didn't know about strip_suffix(). Done.

>=20
> And last but not least, it'd be terrific if you'd let me bully you
> into adding .gz and .bz2 test cases for t1800-import. :-)
>=20

I'll work on that. Can't do it right now, but I'll look at the test har=
ness and see
what it'll take.

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhOh34ACgkQqA4JVb61b9ea9gCgoV1MZbT2F62WEkduOfmkgdP3
BwIAnApT1o+VttF4VRHJj4DkPmi/HXfm
=3DUwho
-----END PGP SIGNATURE-----
