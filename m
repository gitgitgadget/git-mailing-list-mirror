From: Andrew Berry <andrewberry@sentex.net>
Subject: Re: Behaviour of git apply --directory
Date: Wed, 24 Aug 2011 10:26:21 -0400
Message-ID: <5FC87CBA-13C9-4FAD-80C1-66B3550C9EBB@sentex.net>
References: <E21BC0F8-2DF0-44AB-B18A-013451CDB670@sentex.net> <7vfwktwbbb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: multipart/signed; boundary="Apple-Mail=_D127D5E5-49D2-4669-A6DF-AD9B847F2F79"; protocol="application/pkcs7-signature"; micalg=sha1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 16:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwEPc-0001Te-RA
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 16:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab1HXO03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 10:26:29 -0400
Received: from esa-annu.mail.uoguelph.ca ([131.104.91.36]:5863 "EHLO
	esa-annu.mail.uoguelph.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab1HXO00 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 10:26:26 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAF0JVU6DaFvI/2dsb2JhbABCp3d3gUABAQQBdAUFCws0EgI7GgaIBLxthWpfBJMZkRc
X-IronPort-AV: E=Sophos;i="4.68,275,1312171200"; 
   d="p7s'?scan'208";a="132077894"
Received: from darling.cs.uoguelph.ca ([131.104.91.200])
  by esa-annu-pri.mail.uoguelph.ca with ESMTP; 24 Aug 2011 10:26:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by darling.cs.uoguelph.ca (Postfix) with ESMTP id 09D129AC053;
	Wed, 24 Aug 2011 10:26:25 -0400 (EDT)
X-Virus-Scanned: amavisd-new at darling.cs.uoguelph.ca
Received: from darling.cs.uoguelph.ca ([127.0.0.1])
	by localhost (darling.cs.uoguelph.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BT4QiJxdfrB9; Wed, 24 Aug 2011 10:26:24 -0400 (EDT)
Received: from blizzard.lan (64-7-151-206.border7-dynamic.dsl.sentex.ca [64.7.151.206])
	by darling.cs.uoguelph.ca (Postfix) with ESMTPSA id 5111B9AC0A7;
	Wed, 24 Aug 2011 10:26:23 -0400 (EDT)
In-Reply-To: <7vfwktwbbb.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180004>


--Apple-Mail=_D127D5E5-49D2-4669-A6DF-AD9B847F2F79
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Thanks for your detailed explanation.

On 2011-08-22, at 2:28 PM, Junio C Hamano wrote:

> Because the patch application in git is always relative to the top =
level
> of your working tree no matter where you are, this applies to the path =
you
> intended it to.

This is where I see the issue. For some reason when I specify =
--directory, I do have to be somewhere in the directory tree that the =
patch is going to be applied to. For example, in the following it works =
if my cwd is the repository root, or src, but not patches.

$ find . -not -path '*.git*'
.
./patches
./patches/LICENSE.patch
./src
./src/LICENSE.txt
$ git status
# On branch master
nothing to commit (working directory clean)
$ cat patches/LICENSE.patch=20
diff --git a/LICENSE.txt b/LICENSE.txt
index 2c095c8..64ee213 100644
--- a/LICENSE.txt
+++ b/LICENSE.txt
@@ -1,3 +1,4 @@
+GPL GPL GPL
 GNU GENERAL PUBLIC LICENSE
=20
               Version 2, June 1991
$ cd patches
$ git apply -v --directory=3Dsrc LICENSE.patch
$ git status
# On branch master
nothing to commit (working directory clean)
$ cd ..
$ git apply -v --directory=3Dsrc patches/LICENSE.patch
Checking patch src/LICENSE.txt...
Applied patch src/LICENSE.txt cleanly.
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working =
directory)
#
#	modified:   src/LICENSE.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git checkout src
$ cd src
$ git apply -v --directory=3Dsrc ../patches/LICENSE.patch
Checking patch src/LICENSE.txt...
Applied patch src/LICENSE.txt cleanly.
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working =
directory)
#
#	modified:   LICENSE.txt
#
no changes added to commit (use "git add" and/or "git commit -a")


--Apple-Mail=_D127D5E5-49D2-4669-A6DF-AD9B847F2F79
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFfjCCBXow
ggRioAMCAQICEBT0qYr1VI/FTG7wqf3ZkxkwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQD
Ey1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNMTAxMTI4
MDAwMDAwWhcNMTExMTI4MjM1OTU5WjAnMSUwIwYJKoZIhvcNAQkBFhZhbmRyZXdiZXJyeUBzZW50
ZXgubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA9j1PuPvpSbXhrKhKkA/R1hZf
V40ModE0yJZPR8P39DkEJrG3dogns4If+8GxhC0Vi5SZUGdwQbGr8RnOSZjV5858rxDZis0DQQY6
aKmqraNUXqQN0A8Xs1UThCwi9zEuQBnVfnDVuSyU1lxTZXB/TX7RfJGhNXDa4FcUDVAnf5v5UNWS
d3Q6NSR1mWpT7cDIH7lOG1C5XSNEZqZid3Pc5o3jFn3JyC/5VBwI8iAAdyelMHIuxbz2n42+HE/w
UIAt8CRe7dm/31cj/LwjhpPZrVan0NcJ90BS9uqxb4ZWYdV8FIRgP1HBhUATNxiT34fdwimsrson
vJzODftwzIXYTwIDAQABo4ICGDCCAhQwHwYDVR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4Ebn0w
HQYDVR0OBBYEFJ5deq0XiUTzA6eyF+08K9YTwuLhMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8E
AjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAw
RgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUu
Y29tb2RvLm5ldC9DUFMwgaUGA1UdHwSBnTCBmjBMoEqgSIZGaHR0cDovL2NybC5jb21vZG9jYS5j
b20vVVROLVVTRVJGaXJzdC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDBKoEigRoZE
aHR0cDovL2NybC5jb21vZG8ubmV0L1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0aGVudGljYXRpb25h
bmRFbWFpbC5jcmwwbAYIKwYBBQUHAQEEYDBeMDYGCCsGAQUFBzAChipodHRwOi8vY3J0LmNvbW9k
b2NhLmNvbS9VVE5BQUFDbGllbnRDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9k
b2NhLmNvbTAhBgNVHREEGjAYgRZhbmRyZXdiZXJyeUBzZW50ZXgubmV0MA0GCSqGSIb3DQEBBQUA
A4IBAQCqANyU48ZFPRkQ5HAh+gWHKFfTJvlKee7ogC4rGfqFKZjY1eo6btYSBiXFdunvq+ENSPH9
d6x9CqT99qoQkLT/xIbYwwE4LngUhmrIYfPESDyWTaaEdbi8H0sSAZGyx7rFHHhHAPlLCkBz/iUi
zRnuHPP2XohJV6SaS30Ofx8xurtVcMmXrFRy/lJZ7X6sMDd8VFZwRknDUCSRREZur/i8fSWuNHUu
YUgY6DGXdd/RlBqIlAXVA5DNMmJDIxsHghY8l1JeFAeTgr37fFWcBbOvfqxa7zjtDcj+CXho4CKV
tMCoAm1A0Hu6/Qg+fDPuRMlNI6qJDnwfhEwCb4h7uICKMYID/DCCA/gCAQEwgcMwga4xCzAJBgNV
BAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRo
ZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYw
NAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwCEBT0
qYr1VI/FTG7wqf3ZkxkwCQYFKw4DAhoFAKCCAg0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTEwODI0MTQyNjIxWjAjBgkqhkiG9w0BCQQxFgQUXPSjsG0QKhtq/fRJ
6v35gnBYJNMwgdQGCSsGAQQBgjcQBDGBxjCBwzCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVU
MRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3Jr
MSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmly
c3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbAIQFPSpivVUj8VMbvCp/dmTGTCB1gYL
KoZIhvcNAQkQAgsxgcaggcMwga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMO
U2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMY
aHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBB
dXRoZW50aWNhdGlvbiBhbmQgRW1haWwCEBT0qYr1VI/FTG7wqf3ZkxkwDQYJKoZIhvcNAQEBBQAE
ggEAZLqm+p/LhIlAL/H2zIRf3d9IKkh0V4/5QH8fbRurVMMAA8lvHEgbwsJzxr2mSQMWI/xMfoMB
pBZXoaKMcyi/rzr2N11Crwbtb0E1BFeC8VIwp6mDq75KyA1R/lXPLznJfEvSzQQY027x+OL0BY6p
VvYMHpsjU/ksFt6psdbeQk7UGHgqaE/n8oCjft1MsJyM+o9ErkNVdYPzHIYNon0UYvRLpsnBFg58
laq8ZrZe3cY+BBF2HKcok+SYDa+P7wnsqWF8WyIY4YN4S2jN4Th9oRqQJSK1iAWLRJzOUViKSTaY
3s+3UsMFnApXG1QQb4MnP3TVn0Zn/yya2Hgmmsd2pgAAAAAAAA==

--Apple-Mail=_D127D5E5-49D2-4669-A6DF-AD9B847F2F79--
