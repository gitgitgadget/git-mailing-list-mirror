From: James <purpleidea@gmail.com>
Subject: [BUG] git stash doesn't use --index as default
Date: Fri, 11 Oct 2013 00:57:10 -0400
Message-ID: <1381467430.4130.38.camel@freed.purpleidea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-vFoi33qjRe3I9KKKrrLa"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 11 06:57:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUUmw-0002Cb-Sn
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 06:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab3JKE5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 00:57:14 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:61539 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab3JKE5M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 00:57:12 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so7350840iec.30
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 21:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:content-type:mime-version;
        bh=4zxYQEiANVUIcnlBLJtfOCum1sl2ahdWfrfcn9Fru54=;
        b=olssv5eTcQ59cLpya8GHkXGTQGrffYz3M4TpAZZJzdT62aDRm1vmFZZCwiuCHelt8S
         16W5GAw9jegsHQEN44WAu9IwfaQVryzITpd5yU3vhzpDhtLDUnMyawptSSEgAOs8RrIb
         S67aGuKJCoKOZuiLluGAtr2iEcBnmqHPQ5OylU052ZfUXGN8QdloQo5b1WEOQtLWqd7x
         WyE+8C90oXLBeLKCOoTgRgDej2rmIHRC/4h/MU1knbwdtnuXwPlV+yIcNCaqWpIoRLUH
         sGVzGKauXy6o7X39oGm4E8ccrHgFpEULrfcCLtohlZO6DxCqHxr7c5j6Tk/gdNmgIUiX
         K5dw==
X-Received: by 10.50.67.105 with SMTP id m9mr1321509igt.34.1381467431776;
        Thu, 10 Oct 2013 21:57:11 -0700 (PDT)
Received: from [192.168.101.101] ([199.180.99.42])
        by mx.google.com with ESMTPSA id x6sm1557506igb.3.2013.10.10.21.57.10
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 21:57:11 -0700 (PDT)
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235892>


--=-vFoi33qjRe3I9KKKrrLa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As discussed on #git irc:

git init
vim file1
vim file2
git add file1
git add file2
git commit -m 'foo'
vim file1
vim file2
vim file3
vim file4
git add -p file1 # add part of file1, use 'e' to change code too.
git add file2 # add all of file2
git add file3
git stash # do a stash

hack hack hack
git add, commit.

git stash apply
# whoa! all my changes to index are gone!

fail fail... :( sad sad.

git reset HEAD
git stash apply --index

# phew, there are my changes.
git stash apply --index # the --index should be the default!

# WORSE:
if you:
git stash pop
then DATA LOSS. (because you forgot the --index)

Made this super clear. #git agrees this is a bug, if only a UI default
bug. Pretty serious though.

Cheers,

James

PS: please cc me on replies, as I'm not subscribed to list.


--=-vFoi33qjRe3I9KKKrrLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAABAgAGBQJSV4UmAAoJEKDo88AkCQ1mi2MQAIgC+bki5QNuDVMZGsmJvVzN
BnY2ahEhvIsESRMkTBiszb+SUS33rqxorQeGrk2GUf7/+rlZpzlxfi5CHOjkZDMC
fkloQK4GOv6AvTJq/lYFGL2xrdEZ4F/YomvgI8RfXe+KzRDXcSObcDCF+ZMnKx12
67mgN6vi5OHoN1cDNGwKMme7EuuQ91Qb1rHfXbDxPz/3EBqXwswi3fxEcNjabqKa
UL0A+oKIUh/y/Hm117QSxeDILMcAXYGQMEjFDAXGflo0h0kK2cxk7kTtVGmXbY5k
W2R+C6jA82JglpIM5WLxj2RuxJ3+EI+DnSgBNIiR8N4w0dM8CkD0dfxuN8y8IUsQ
cdu2XuzjSpcrKqAVSams4mBKf3nBU49cU/BG0Mmp5mElh4xx+cMYFPLSJkiW7dgo
+eKkvg7tJDcchhCLsovI+h5Kh+7CAPdfCF/Sp3da7lfxglhml7x9JYO2+6i18KDr
Tg4IQp1bffhQ4S03lpwZaSS4Oy15JxDYo+T65DbZuDliH+Z/gkRqNAtMODpOeYjr
cI+xjjAdn832OXP0xvFEprkI2TOrpYTMWPendx3DhYheec67u5a6s5NxhLG0dlLG
lXYeRJjX9Y7dLmHLpKN+lRgFUJKnHCjMdGxVFfG/H+6cSp0TuwWDAbKM4HNqRNHw
MNFKUmgmpUrU+92/MhGK
=Kv1D
-----END PGP SIGNATURE-----

--=-vFoi33qjRe3I9KKKrrLa--
