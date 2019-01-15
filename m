Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2E81F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 14:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfAOODk (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 09:03:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:46928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729370AbfAOODi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 09:03:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A69AFAFA3
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:03:36 +0000 (UTC)
To:     git@vger.kernel.org
From:   Marketa Calabkova <mcalabkova@suse.cz>
Subject: Worktree creation race
Openpgp: preference=signencrypt
Autocrypt: addr=mcalabkova@suse.cz; keydata=
 mQENBFuJDK0BCAC7oCihZ+z6LUKGAMlrgytiGpOWS7J/SEejYnSXPQ4fZI65C1jHER04G19C
 l17cirTWKUXvv7I8GDyZfPSvDiU5neOuZCF+8dWuOwQjP6ddrUkTjrimBNTJQ+4p4sF7PQNy
 1EHafttHqqRO4JOfqZl2ux9e+w4iu3Yiy4N9cMNCcSLCWuU3HBl2qllGtPOK7aEEEpwwPK53
 P8Z5IT6DKjnYbxanJrZCowuNH/EBwgW8C6T5Crd4TYNESigOBcOXlRjn/r272TtKJyndF49C
 hvLIMIv/OUf7kaRPu97ZHVPFKQq5f9p3yPWXBE17Cjc8yZAw1Ralzxf6N4mQzFyVLc5VABEB
 AAG0Jk1hcmtldGEgQ2FsYWJrb3ZhIDxtY2FsYWJrb3ZhQHN1c2UuY3o+iQFTBBMBCAA+FiEE
 gfb7Iobbgba+AolQALUzKizvWXYFAluJDK8CGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQALUzKizvWXb9jgf46kmHK8mBJTL54AK7PBvqJO1O3l0WQKHI0k6DfPN0j5vs
 GK61wxvdZBMP3obLvoo5txRI1qMHxeviaNVm47Z14ZGPSKl+l0a+mMNZW/sCV5neCWl7auvl
 DvpZDpQoC96EbWgLqDUzK/eofs7uwAbz7dH1F2xiqVi8pbXFQErKubAq540Q2nbXyRc5cjOs
 /oTVnM8gcl7SGCHjTVkw/8emDZg2is8Nw3sQMHeQGWoonLiM7qkdnF8A0rtZ/jroj3LWb9mZ
 sLNXa3E/LcQ3mP81Z+chPa55WbTRnnNFXkAYeAFx7+4UDVstqbpSM01IPHLW3UTnTxMkGfUI
 PUJUtgBBuQENBFuJDK8BCADN/DCjbiiBWRrWo+kv5KeDrxXApq7eBhV0epYs0zDqZCJz1FuT
 viU4aoCqCQXU6go0Za8aJZwMN8RWz/35lyg/hxuziFyaQiw7a+W68dEKSbDaoHr8hpKPnI+6
 lhlwK87hv6zFpu+jGlTaxUMpwPdznq0vjLdkAxgKMasVvQslFn9ThsqY/z3DJqkwpR8aC9EI
 AZXZg5+2YXNUCCVQA88vHybl84LFD3Qgypz9wgnOuMsybyA9PYY5zl+Lz1B6w6UJBANXe6A9
 ebhre/9i7kDFmnGh9mfmmH/15lap9fdefAB9Wtndp0eYCI8pYyRYrtdk688GyLKY/Fv1JtSn
 ZEd/ABEBAAGJATwEGAEIACYWIQSB9vsihtuBtr4CiVAAtTMqLO9ZdgUCW4kMrwIbDAUJAeEz
 gAAKCRAAtTMqLO9ZdkhDB/9ImVmDa89VG47JxfPmsAu70tgYnOonFze7dn5tAEVhSuGrMOB5
 hrkoRcHCjawQmvG7BWkAGoXW2oOl4pp1uRVLOIHXruIKkgEN+nWvCr2Lvxc8Mwmj0B51nL1E
 Qkhu5jjJuIZ4+Kb/4nwxaqYfEDZwbe9QPmidGlkIqwsgEnBqB8L6sKH4XRJ7MTghsXZziZIr
 qq/vC4xBK98vbwLfz6QRcV1hWNbEX7d+7gkIot33LD1HCNaX07ZGPhu0S0T6PueDWiSdZlk6
 DOwOGtPShksjN/3YdmqUA7Wp+JUj1j+QHE6S9RrRUUlabUEuxok7YnA1XPAoDcekzE8n4mpZ lG8B
Message-ID: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz>
Date:   Tue, 15 Jan 2019 15:03:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sw4LWlGi8iPLd4wDvApzvbONSLsNGmAbg"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sw4LWlGi8iPLd4wDvApzvbONSLsNGmAbg
Content-Type: multipart/mixed; boundary="6bICJSe8fjw2GBjX109Bwk6SwijKNstf3";
 protected-headers="v1"
From: Marketa Calabkova <mcalabkova@suse.cz>
To: git@vger.kernel.org
Message-ID: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz>
Subject: Worktree creation race

--6bICJSe8fjw2GBjX109Bwk6SwijKNstf3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hello,

I am writing to report a bug. The original report is from my colleague, I=
 am also providing his suggestions.

There is insufficient locking for worktree addition. Adding worktree may =
fail.

The problem is that git reads the directory entries in $GIT_DIR/worktrees=
,=20
finds a worktree name that does not exist, tries to create it, and if an =

error is returned adding the worktree fails. When multiple git processes =

do this in parallel only one adds a worktree and the others fail. Git sho=
uld=20
reread the directory and find a new name that does not exist when creatin=
g=20
the worktree directory fails because another git process already created =
it.

I suppose adding PID in the tree name would mitigate the issue to the poi=
nt it will be very unlikely to encounter.

I need more than the tree in the temporary directory so using the tempora=
ry directory directly as a tree is out of question.

to test:

cd /dev/shm
mkdir gittest
cd gittest
git init gitrepo
cd gitrepo
git commit --allow-empty -m Empty
for n in $(seq 10000) ; do ( tmp=3D$(mktemp -d /dev/shm/gittest/test.XXXX=
XXXXXXX) ; mkdir $tmp/test ; git worktree add --detach $tmp/test ; ) & do=
ne

(you should see many messages like:=20
fatal: could not create directory of '.git/worktrees/test284': File exist=
s)

Greetings,
Marketa



--6bICJSe8fjw2GBjX109Bwk6SwijKNstf3--

--sw4LWlGi8iPLd4wDvApzvbONSLsNGmAbg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgfb7Iobbgba+AolQALUzKizvWXYFAlw96DgACgkQALUzKizv
WXY9/Af9HcjA1X5hvJMkWbP6/zsFgx9CMZIN6ybYI2m/trI/FcV01piYlmV60TQ2
ycQRhRgkl7d17OH08aN4LO0Nf9uNN3wpEaeRGzZCROc0pmxu+W5+ROryQtP5mbWI
njiMMil63VhiC3/5CYc3sue840wVtBjUsDby8nvWCXF3BKNc9JUXZfO/PgFAfUxe
H+fTVw2rQY42D12I7ryWWiacDbGsx5I7lLStXyEdDGK2m957XlIcH0mGDSx7+s8D
70Qg5TmgMFr38rMgJe9uDbaig0F5rxlJFqoCnpbMUdjaEH9vwUA1GjOeVvGFK7hP
Zcxfgt+X7k3GSCT5+eorag1XPGoAyw==
=lBxQ
-----END PGP SIGNATURE-----

--sw4LWlGi8iPLd4wDvApzvbONSLsNGmAbg--
