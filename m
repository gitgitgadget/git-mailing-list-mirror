From: Robin Moussu <robin.moussu@gmail.com>
Subject: [bug] first line truncated with `git log --oneline --decorate --graph`
Date: Thu, 16 Apr 2015 12:14:29 +0200
Message-ID: <552F8B85.2000908@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BvH350G5c62gW3gjrAnKeK3nspJuxiwAk"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 12:15:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YigpB-0006nk-2y
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 12:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbbDPKPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 06:15:05 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36615 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbbDPKPC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 06:15:02 -0400
Received: by wgsk9 with SMTP id k9so75167942wgs.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type;
        bh=RdscZFXhR5mu2ZLO/jZ5dPODOjvFiZ/rNXYLHHOiPPc=;
        b=gbfcvYO+ttnHVCOMdc5vKpu8C0CacxW4MSEV5jejzzZZqc+Ou2rwWzeOeRuWuk92U9
         trQpXTId0Mnm//BuvYDQELXBXjquXwFIFlO5h8UqzgEk6U6+y93DE8NI6BMTkSBbzIpd
         pLjecertakBCTdBQJYGkwV3klmVu8Jtl4IJ/R9gOtm8WvqDt2T/qiLlbNY30D8lJkBk7
         fIN8IeOujRoYvZI62DQ6VEMuvZdblpxktG3E1Xd0eGcifCTOPol1jjqnfhW/t6JdQ7Nl
         b/sEQgVcdhIUaVucNGi2PMBdMAfp5uZn+FqCdRU4nnaJ76fCRNJy9dGV/xiJu7xmT8gX
         nduQ==
X-Received: by 10.194.133.102 with SMTP id pb6mr33144034wjb.97.1429179301077;
        Thu, 16 Apr 2015 03:15:01 -0700 (PDT)
Received: from [192.168.1.11] (AOrleans-651-1-268-217.w92-160.abo.wanadoo.fr. [92.160.163.217])
        by mx.google.com with ESMTPSA id kr5sm9740096wjc.1.2015.04.16.03.15.00
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 03:15:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267275>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BvH350G5c62gW3gjrAnKeK3nspJuxiwAk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I have a bug using the following command:

    git log --oneline --decorate --graph

In short, the first line of the log is often truncated.


If the terminal is too small to display all the text (~100 columns, and t=
oo
much text to fit on the high of screen, in this example less than 4
lines), I
actually see:

If my history is:

*   4656b73 (HEAD, long_branch_name_and_long_commit_name) Merge commit
'f7f6e4736ad040a1238644a33b681a66c79fac0e' into HEAD
|\
| * f7f6e47 (master) Praesent et diam eget libero egestas mattis sit
amet vitae augue.
| * 8dccb9d Maecenas congue ligula ac quam viverra nec consectetur ante
hendrerit.
|/
* f7724a2 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec
a diam lectus.

If my screen is not high enough, I see:

1238644a33b681a66c79fac0e' into HEAD
|\=20
| * f7f6e47 (master) Praesent et diam eget libero egestas mattis sit
amet vitae augue.
| * 8dccb9d Maecenas congue ligula ac quam viverra nec consectetur ante
hendrerit.
# next message truncated, because the screen is too small

instead of:
*   4656b73 (HEAD, long_branch_name_and_long_commit_name) Merge commit
'f7f6e4736ad040a1238644a33b681a66c79fac0e' into HEAD
|\
| * f7f6e47 (master) Praesent et diam eget libero egestas mattis sit
amet vitae augue.
| * 8dccb9d Maecenas congue ligula ac quam viverra nec consectetur ante
hendrerit.
# next message truncated, because the screen is too small

As you can see, the first line is truncated.

If I use:
    git log --pretty=3Doneline --all --decorate --graph
instead of:
    git log --oneline --all --decorate --graph
the problem is the same (first line truncated).

I have see that bug using terminology or xterm, with bash (without
=2Ebashrc) or zsh
(lots of things in my .zshrc), and my desktop environment is
i3/archlinux/git
version 2.3.5 It is not a recent regression (if it is, I've learn git
one year
ago).

# How to reproduce

Open a small terminal windows (4*100)

    mkdir tmp
    cd tmp
    git init
    git commit --allow-empty -m 'Lorem ipsum dolor sit amet, consectetur
adipiscing elit. Donec a diam lectus.'
    git checkout -b long_branch_name_and_long_commit_name
    git commit --allow-empty -m 'Maecenas congue ligula ac quam viverra
nec consectetur ante hendrerit.'
    git commit --allow-empty -m 'Praesent et diam eget libero egestas
mattis sit amet vitae augue.'
    git checkout master
    git merge --no-ff long_branch_name_and_long_commit_name -m 'merge
with a long commit message'
    git checkout long_branch_name_and_long_commit_name
    git merge master
    git log --oneline  --decorate --graph

I hope it is clear. The English is not my mother tongue.
--
Robin Moussu
//


--BvH350G5c62gW3gjrAnKeK3nspJuxiwAk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVL4uGAAoJEGxGpQTg62H1QfsP/1IS6aW1fXT25ROVDN5ALlcH
Jyvi4eHcBCc1g0uTpJasm4jDfuhjbQvTBEEcrxc5FEyP/5mNJK95AsgNLXxNEve3
G5myNVZm5lbRUbUnuVSu1TJCB1hL7sd969fzWfePAKOPP54FzZ+4WpYj6ybq2rTx
DbuVHkur3iPKBEKHW+S/4kilzYexQkm/oiMZkeFi7AXUwqD7yxui1twBI0Oag8dJ
ixVzVMUoXLm3CDyEBNdJGpXGdFUUaP7CeD2V708edSEz4Z3o523HjSCoRvKxHKTm
9cYC1hbDuwimsKjA+HZk8TTH5YvA7txGvE2ZOcYkb4F/WJ39Ubp0wlQGeHKaLhwg
0xjwK9v0g7caHEW09emmiyMH09yQpmC6Aalb0/15Al/OKWvU5Fpzjw9XldliYf51
jyGr1fcB/+YOZnKgVMfifXKA1uUEFdOk2mGV478B2db1DZh4ugg6ScA2eMicJDxG
5rcRkZ3aWX5bJVlMRYyzZd/XIlGB79/SDjBjGYXLWmkYqqS4uRhvt7PFeNmkZYGL
l+P71tS4V+cAYoguHLikUn+AaXgoEVsTKCs2pvGxSKmw8wO6xDyse9Yx7uqVP19t
TKCk6XpaNzUoyUg/K8CTxuUWsk38fiFdERm7C0V325Q/E5rs/MB/72YGMOswUfVP
d/zwka4nqdXDlvyy0zUo
=5LL5
-----END PGP SIGNATURE-----

--BvH350G5c62gW3gjrAnKeK3nspJuxiwAk--
