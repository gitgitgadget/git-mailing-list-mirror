From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [StGit PATCH] compressed import v3
Date: Sat, 14 Jun 2008 10:49:03 -0500
Message-ID: <4853E86F.1050504@gmail.com>
References: <48519602.2090103@gmail.com> <20080613051127.GA24245@diana.vm.bytemark.co.uk> <485289FD.50808@gmail.com> <20080614102646.GD14282@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 17:50:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Y1d-0007zU-O3
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 17:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbYFNPtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 11:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYFNPtX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 11:49:23 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:14704 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbYFNPtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 11:49:22 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2753850ywe.1
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=vZIN+/Icrc7Pr6240k0vkapyTTf/+3AGJtNOLIObyBc=;
        b=biFTQGG+s6xyQuq2Aabk2e6ogcC/mASQq2uSUFWCPbJgI4otSiv2VJ5algVGS2+yx9
         j7dxu4gPvK9vaEGQNMwpczCBJ2QBi1FVuXjbTvrvBA4bAdN53DYOMHG2dRK/ER5rEe5/
         +zfbEQ4QU2HhmwhE927NEXUpzKGa4dXYRfx+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=ayi6loD1qNWerktnc8m9LLYY0gpv5R1GJc2fMIrbxwt3wS7XM3P38l+NzcIqnvcw6R
         f45xU0ZVmezEvX//NLHokfiGUYw7n8YIYDUl/TJfs24VkAPN27W6njr/B7NJcaQgj42C
         1r8JoB3iuN7k88kyZbvBlHgULYgVrcCfTrB+w=
Received: by 10.151.145.17 with SMTP id x17mr3455729ybn.220.1213458561832;
        Sat, 14 Jun 2008 08:49:21 -0700 (PDT)
Received: from ?172.31.0.50? ( [66.32.50.27])
        by mx.google.com with ESMTPS id k8sm10756362qba.5.2008.06.14.08.49.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 08:49:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
In-Reply-To: <20080614102646.GD14282@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85020>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl Hasselstr=C3=B6m wrote:
> On 2008-06-13 09:53:49 -0500, Clark Williams wrote:
>=20
>> I'm interested to hear how you'd condense the code in
>> __gethandleandname().
>=20
> Like this, for example:
>=20
>     import bz2, gzip
>     for copen, ext in [(gzip.open, '.gz'), (bz2.BZ2File, '.bz2')]:
>         try:
>             f =3D copen(filename)
>             f.read(1)
>             f.seek(0)
>             return (f, __mkpatchname(filename, ext))
>         except IOError, e:
>             pass
>=20
> If you don't mind, I'll just fix that up directly in your patch. (I
> also took the liberty to rename the function to __get_handle_and_name=
,
> since that's more consistent with other functions in that file.)
>=20

Ah, that's very nice. Your changes work for me.

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhT6G8ACgkQqA4JVb61b9cCeQCfedD0BjOeRa3sbGvkRNe2BPMq
6roAoJE7klMbgymRCJ3B+pEjzgnTWO2l
=3DuZ+n
-----END PGP SIGNATURE-----
