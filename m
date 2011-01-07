From: Andreas Stricker <astricker@futurelab.ch>
Subject: Re: weird github capitalization problem
Date: Fri, 07 Jan 2011 10:17:06 +0100
Organization: FutureLAB
Message-ID: <4D26DA12.50002@futurelab.ch>
References: <1294146242606-5888573.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms070507000905080800070704"
Cc: git@vger.kernel.org
To: bolfo <boflor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 11:15:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb9Ly-0001CW-FR
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 11:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382Ab1AGKPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 05:15:20 -0500
Received: from host-179.futurelab.ch ([62.2.169.179]:42056 "EHLO
	primus.futurelab.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab1AGKPT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 05:15:19 -0500
X-Greylist: delayed 3485 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jan 2011 05:15:19 EST
Received: from astricker.local (primus [127.0.0.1])
	(authenticated bits=0)
	by primus.futurelab.ch (8.13.8/8.13.8/fL-3.7) with ESMTP id p079H6Mj012800;
	Fri, 7 Jan 2011 10:17:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <1294146242606-5888573.post@n2.nabble.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164704>

This is a cryptographically signed message in MIME format.

--------------ms070507000905080800070704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 04.01.11 14:04, schrieb bolfo:
> I first installed everything on my laptop, coded some stuff and then pu=
shed
> to github. Apparently something went wrong because there was a new
> directory, while at first the directory was OurProjectsources, there no=
w was
> a new directory called OurProjectSources. Weird since my local director=
y has
> the s not capitalized.

> I work on a windows PC while the original author works on a Mac, could =
this
> be the problem?

Yes, Mac OSX HFS+ filesystem ignores the case by default (you'll need
to reformat to change this). So OurProjectSources and OurProjectsources
both refers to the same directory on Mac OS X. On Linux there are two
different directories

This frequently causes issues here too. An example:

me@mac:t $ git init r
Initialized empty Git repository in /private/tmp/t/r/.git/
me@mac:r (master) $ mkdir OurProjectsources
me@mac:r (master) $ touch OurProjectsources/a
me@mac:r (master) $ git add OurProjectsources/a
me@mac:r (master) $ git commit -m "initial import"
[master (root-commit) c2cb2f3] initial import
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 OurProjectsources/a
me@mac:r (master) $ mv OurProjectsources/ OurProjectSources
me@mac:r (master) $ touch OurProjectSources/b
me@mac:r (master) $ git add OurProjectSources/b
me@mac:r (master) $ git commit -m "added b"
[master 4de780c] added b
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 OurProjectSources/b
me@mac:r (master) $ git stat
# On branch master
nothing to commit (working directory clean)
me@mac:r (master) $ scp -r .git linux:t.git
me@mac:r (master) $ ssh linux

me@linux:~ $ git clone t.git/
Initialized empty Git repository in /home/me/t/.git/
me@linux:~ $ cd t
me@linux:~/t $ ls
OurProjectsources  OurProjectSources
me@linux:~/t $ find *
OurProjectsources
OurProjectsources/a
OurProjectSources
OurProjectSources/b

And there it is, our mess. The mac user accidentally created
two different directories but didn't see them.

~/Andy


--------------ms070507000905080800070704
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
0cz5EPcjMRFhHaOjmKjT/LXpFo24fcnGqRYtVE2EJ1GIbwzFGawfhTVgz/UdpwIoX9UlLAL/
MNXsoA0SJzGCA9MwggPPAgEBMIGVMIGOMQswCQYDVQQGEwJDSDEPMA0GA1UECBMGWnVyaWNo
MRMwEQYDVQQHEwpXaW50ZXJ0aHVyMRUwEwYDVQQKEwxmdXR1cmVMQUIgQUcxHDAaBgNVBAMT
E1NpZ25pbmcgRGVwYXJ0ZW1lbnQxJDAiBgkqhkiG9w0BCQEWFXN5c2FkbWluQGZ1dHVyZWxh
Yi5jaAICARIwCQYFKw4DAhoFAKCCAhIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMTEwMTA3MDkxNzA2WjAjBgkqhkiG9w0BCQQxFgQUPSHoeNxwIwZoCJoI
GG7TLqphHjIwXwYJKoZIhvcNAQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYI
KoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGm
BgkrBgEEAYI3EAQxgZgwgZUwgY4xCzAJBgNVBAYTAkNIMQ8wDQYDVQQIEwZadXJpY2gxEzAR
BgNVBAcTCldpbnRlcnRodXIxFTATBgNVBAoTDGZ1dHVyZUxBQiBBRzEcMBoGA1UEAxMTU2ln
bmluZyBEZXBhcnRlbWVudDEkMCIGCSqGSIb3DQEJARYVc3lzYWRtaW5AZnV0dXJlbGFiLmNo
AgIBEjCBqAYLKoZIhvcNAQkQAgsxgZiggZUwgY4xCzAJBgNVBAYTAkNIMQ8wDQYDVQQIEwZa
dXJpY2gxEzARBgNVBAcTCldpbnRlcnRodXIxFTATBgNVBAoTDGZ1dHVyZUxBQiBBRzEcMBoG
A1UEAxMTU2lnbmluZyBEZXBhcnRlbWVudDEkMCIGCSqGSIb3DQEJARYVc3lzYWRtaW5AZnV0
dXJlbGFiLmNoAgIBEjANBgkqhkiG9w0BAQEFAASCAQCUjz+O6UELSIaxoVF3nn2Xizx5IrRz
pKGRDGThBTJXTRFLxglw/FaOBMxUqJx5OJ1R4kzVmRouRJEzF/HznzZ4Te2qNxMz71cDFdEY
PYrZOzoLx4OJF3HUYttjzP//j6FGDq5zXeHTgS1/dEtZfsqC5ucWVeg1wxO9BK1ASTIswkf2
NmjFRfOS2AIkz76qBIA1XuI+ijmOW3S2AQVNZbIhAPfitJDgdx8Z5FyyHOCMAuUlAbZyo4rH
Ls0CNTrJGBn3Rb1XkRCUCzjUwChfG971bW1rDkBUKB6wFlgH2xVbVdgrY7GBF81XsYYIiHvF
/VdHSWXHGn1bOChX2h8JWQolAAAAAAAA
--------------ms070507000905080800070704--
