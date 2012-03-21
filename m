From: Ralf Nyren <ralf.nyren@ericsson.com>
Subject: Strange effect merging empty file
Date: Wed, 21 Mar 2012 11:28:12 +0100
Organization: Ericsson AB
Message-ID: <4F69AD3C.4070203@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms050101070605060909090307"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 11:28:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAImB-0005fA-GQ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 11:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757753Ab2CUK2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 06:28:14 -0400
Received: from mailgw9.se.ericsson.net ([193.180.251.57]:49233 "EHLO
	mailgw9.se.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714Ab2CUK2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 06:28:13 -0400
X-AuditID: c1b4fb39-b7bf2ae0000069a1-59-4f69ad3b0ee4
Received: from esessmw0237.eemea.ericsson.se (Unknown_Domain [153.88.253.124])
	by mailgw9.se.ericsson.net (Symantec Mail Security) with SMTP id 97.F8.27041.B3DA96F4; Wed, 21 Mar 2012 11:28:11 +0100 (CET)
Received: from [132.196.140.41] (153.88.115.8) by
 esessmw0237.eemea.ericsson.se (153.88.115.91) with Microsoft SMTP Server id
 8.3.213.0; Wed, 21 Mar 2012 11:28:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193563>

--------------ms050101070605060909090307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

I found a "strange effect" when merging from a branch containing a=20
change of a previously empty file. The change is added to another empty=20
file in the current branch by the merge.

I guess git sees it as a renamed file which is logical from a=20
content-perspective.

Not sure what to do with this, I would not say it is a bug really...

Reproduce as follows (should be cut-n-paste friendly):

# Start with a new repository
git init
echo 'Readme file' > README
git add README
git commit -m 'Initial commit'

# Setup the branch to be merged
git checkout -b import
touch empty.txt
echo hello world > hello.txt
git add empty.txt hello.txt
git commit -m 'Import 1.0'
git tag IMPORT_1.0
echo This file is no longer empty > empty.txt
git commit -m 'Import 1.1' empty.txt
git tag IMPORT_1.1

# Setup master branch
git checkout master
mkdir static
touch static/.gitignore
git add static/.gitignore
git commit -m 'Static web content'

# Merge import 1.0 and remove the empty file
git merge IMPORT_1.0
git rm empty.txt
git commit -m 'Remove empty file' empty.txt

# Merge import 1.1 and watch empty.txt contents show up in .gitignore
git merge IMPORT_1.1
cat static/.gitignore

regards, Ralf


--------------ms050101070605060909090307
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIM5jCC
BCcwggMPoAMCAQICEQD6KyCm2pUxckZKPFdfyWuqMA0GCSqGSIb3DQEBBQUAMDkxETAPBgNV
BAoMCEVyaWNzc29uMSQwIgYDVQQDDBtFcmljc3NvbiBOTCBJbmRpdmlkdWFsIENBMDIwHhcN
MTIwMjIzMDgzMTQxWhcNMTIwNjI5MjMwMDAwWjBiMREwDwYDVQQKDAhFcmljc3NvbjETMBEG
A1UEAwwKUmFsZiBOeXJlbjEQMA4GA1UEBRMHZXJhbG55cjEmMCQGCSqGSIb3DQEJARYXcmFs
Zi5ueXJlbkBlcmljc3Nvbi5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAJamrc7D
bAh9TWuEwuQT3otFsybBgivvAKmPJKSXi1jdTVrf4Ydjp5MFnE7h5ELuT7DWaVhffyDSWZt/
b54U0Mm53sa1N/CZmOtmr482o5o5/3JXnCvWMdmjbsKRhrqXy+2A98SFuy8FvkCr3v210dqf
frtNywyM033p1H7J9F3hAgMBAAGjggGDMIIBfzCBwAYDVR0fBIG4MIG1MIGyoIGvoIGshjdo
dHRwOi8vY3JsLnRydXN0LnRlbGlhLmNvbS9Fcmljc3Nvbk5MSW5kaXZpZHVhbENBMDIuY3Js
hnFsZGFwOi8vbGRhcC50cnVzdC50ZWxpYS5jb20vY249RXJpY3Nzb24lMjBOTCUyMEluZGl2
aWR1YWwlMjBDQTAyLG89RXJpY3Nzb24/Y2VydGlmaWNhdGVyZXZvY2F0aW9ubGlzdDtiaW5h
cnk/YmFzZTAiBgNVHREEGzAZgRdyYWxmLm55cmVuQGVyaWNzc29uLmNvbTBGBgNVHSAEPzA9
MDsGBiqFcGsBATAxMC8GCCsGAQUFBwIBFiNodHRwOi8vd3d3LmVyaWNzc29uLmNvbS9sZWdh
bC5zaHRtbDAdBgNVHQ4EFgQUvoBhASINOX1/sVOIeZSuoEQ+6ggwHwYDVR0jBBgwFoAUNZK6
n3bMBP7vlu3NPuATV8Y08YowDgYDVR0PAQH/BAQDAgWgMA0GCSqGSIb3DQEBBQUAA4IBAQBl
Kz95NKK59h6bCuTbwhxdOdFgQzrYf4vZAE5AjB/SVNn7mdBHeRiEj85tpOHFMoBC0RQKxs67
Ks1/wSvJWPr6FB3o0B7oj+3jMxW8LqOHkbGDaqD31nHMMVHthAS1eS4+NfDPOOeQlwMiUjEQ
S2FaBl/MBGY5q2jJaGzDfto5ToKi1yDbLMu0Se5dqcwbEuBveIGJu+cZLrrBwGqoW63DtiQq
W5cnQ8Dw74HraAaRlbOP9owIxntOUbdrOGNMR3+yn8oJKRkUdjypq9K1emAPYFxj5FDdWrB9
EWvbzk8ENriqwGaHZsjDJyDWIaUS/SyMjNEIfZVBQATV0PSik1O/MIIERjCCAy6gAwIBAgIR
AOL/HIWhumdOEpo9vPPMONwwDQYJKoZIhvcNAQEFBQAwRDEaMBgGA1UECgwRVGVsaWFTb25l
cmEgR3JvdXAxJjAkBgNVBAMMHVRlbGlhU29uZXJhIFB1YmxpYyBSb290IENBIHYxMB4XDTA2
MTAwNjEwMTMxM1oXDTE2MTAwMjA1MDIyMlowOTERMA8GA1UECgwIRXJpY3Nzb24xJDAiBgNV
BAMMG0VyaWNzc29uIE5MIEluZGl2aWR1YWwgQ0EwMjCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALzhUjEmNEZ4p6HFDxn9S7efLnpCcy8/4CDL1qkdowkYVzkrufCFxSIIg8g2
ofKrvyfhd5HXc/eIqc7Kl603/jJqb9NLtFVz16IWU2VtChEIEQfE0OWUZW85VymqaBD4NwQc
qXSBtQhnoDMTsaDKw+DBWxBFOyW/zPovLAIe42whFRTLFnYKCERf8U3lhBzVAH3zW8/C3K/4
3shOsNQs6y35xy3RhBI4huJ4IJ6WlLvItf3ip/yimH3sUxOCQZszzfpmfabxZ8cneUOciEKN
inZFca8J8V/tmzi2KecqKN7K3ssFJ6FNOO+v989GRWV8CvYif9+UoGo9x+x8FteUptsCAwEA
AaOCATwwggE4MBIGA1UdEwEB/wQIMAYBAf8CAQAwRgYDVR0gBD8wPTA7BgcqhXAjAgEBMDAw
LgYIKwYBBQUHAgEWImh0dHBzOi8vcmVwb3NpdG9yeS50cnVzdC50ZWxpYS5jb20wgYkGA1Ud
HwSBgTB/MH2ge6B5hndsZGFwOi8vbGRhcC50cnVzdC50ZWxpYS5jb20vY249VGVsaWFTb25l
cmElMjBQdWJsaWMlMjBSb290JTIwQ0ElMjB2MSxvPVRlbGlhU29uZXJhJTIwR3JvdXA/YXV0
aG9yaXR5cmV2b2NhdGlvbmxpc3Q/YmFzZTAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFDWS
up92zAT+75btzT7gE1fGNPGKMB8GA1UdIwQYMBaAFEXb8I+4GmKhqCMbY4g4o9vgGmLxMA0G
CSqGSIb3DQEBBQUAA4IBAQAmfI+BPhI0283GRPc7HPsy6h1IG+6iHmP1RjNyod7YT5jhrXER
PzO74/chsALqSjj+VwV9KgJCQ55FS911AOJY71zNQjf+zGBz5jF3skuY/OQNkwiBQrMKjDhN
QbtOLhAoML3OzWkpb4mUaJoPdEZB6EzNg2lEdgQssH6rPHQxoOv4kFArskAHP2xNBZS6f1an
LpvIbFmAEUSTr44DwpJ3G6VtGNcVioiw1AiEM3lISIXmhLsWylxDUwntDNyKLjwtFDtOAP2y
IB2RekhsuTdJ7QMYQAVqaGDgAQvZr4JZp2jmUu95Y1D+cCMT7wOY7SDpjgIzCR//m7xdo4ox
bYamMIIEbTCCA1WgAwIBAgIRAJywjASay5cieGNithuGWj0wDQYJKoZIhvcNAQEFBQAwOjEZ
MBcGA1UEChMQUlNBIFNlY3VyaXR5IEluYzEdMBsGA1UECxMUUlNBIFNlY3VyaXR5IDIwNDgg
VjMwHhcNMDYxMDMxMjA0MjI3WhcNMTYxMTAxMTU0MjI1WjBEMRowGAYDVQQKDBFUZWxpYVNv
bmVyYSBHcm91cDEmMCQGA1UEAwwdVGVsaWFTb25lcmEgUHVibGljIFJvb3QgQ0EgdjEwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKTxADapCAq3mplX4R4gNt+WZe5QKGnaVE
QSyY7lICKF5DuVdWPMLHDjzhw5IzDd860ZZx/0VrhGB3DmP4SDIWCKo2PxvY5NckdBWPWp/T
2uaQdOAwgqHpN0pe1X7/jel59WsWYXKGg/81Wth73ZK/geE7Gz9Pvj1LU6N4YhLMgooxKnCS
+ZjB5icWAg+Qd1QpQhF46H1ibp6LsBWDp56MPpg8F5X6y7MGVcKYLdnLOPs84uxRW9qs1kBo
pzQBj6s5SyVh8A+j5liDBjghXYpw/+paGEdqHPeSFYxZKeJatmjEKLYlxcZWRKf436KvQA9j
BhMEmytMNbGicR1mRH6tAgMBAAGjggFiMIIBXjAfBgNVHSMEGDAWgBQHw1EwpKrpRa41JPr/
JCwz0LGdjDAdBgNVHQ4EFgQURdvwj7gaYqGoIxtjiDij2+AaYvEwEgYDVR0TAQH/BAgwBgEB
/wIBBDCBhQYDVR0gBH4wfDA9BgkqhkiG9w0FBgEwMDAuBggrBgEFBQcCARYiaHR0cHM6Ly9y
ZXBvc2l0b3J5LnRydXN0LnRlbGlhLmNvbTA7BgcqhXAjAgEBMDAwLgYIKwYBBQUHAgEWImh0
dHBzOi8vcmVwb3NpdG9yeS50cnVzdC50ZWxpYS5jb20wcAYDVR0fBGkwZzBloGOgYYZfaHR0
cDovL3d3dy5yc2FzZWN1cml0eS5jb20vcHJvZHVjdHMva2Vvbi9yZXBvc2l0b3J5L2NlcnRp
ZmljYXRlX3N0YXR1cy9SU0FfU2VjdXJpdHlfMjA0OF92My5DUkwwDgYDVR0PAQH/BAQDAgEG
MA0GCSqGSIb3DQEBBQUAA4IBAQAEXpos2CnIm7/872ytSrEHWZgvhOUEkUm25PWf/XkWko41
TaL9vIS1S6AdWChNqWmnYiS7GfaIiDM9s1D6K7hidWBDOm46bNdM3ZwhMyDCfkDJSgeJ0w+7
YmjvChu7gWqDZCsbtZ5gA1ixCTdDnuZB67JGSPGW6r73coraDP8diOpiQouMvM6bKuTPBH/1
poLccsUxsKgrQ23JC9LWCRb8cYHkZjXFH1K44TsIl5Lne2oT0JI3pwdA2v6jO4p/OLHntP+n
pjwPbedMPUZkDYCkd3LSxj8c3JTxtA8SlPCtIHE1hh65xihg1JRIliSphrqr9kbfwHdeVxPd
OI5GtDYPMYICdjCCAnICAQEwTjA5MREwDwYDVQQKDAhFcmljc3NvbjEkMCIGA1UEAwwbRXJp
Y3Nzb24gTkwgSW5kaXZpZHVhbCBDQTAyAhEA+isgptqVMXJGSjxXX8lrqjAJBgUrDgMCGgUA
oIIBfjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjAzMjEx
MDI4MTJaMCMGCSqGSIb3DQEJBDEWBBTJr/91h10hsL/gNDIqsVQfJvhlNjBdBgkrBgEEAYI3
EAQxUDBOMDkxETAPBgNVBAoMCEVyaWNzc29uMSQwIgYDVQQDDBtFcmljc3NvbiBOTCBJbmRp
dmlkdWFsIENBMDICEQD6KyCm2pUxckZKPFdfyWuqMF8GCSqGSIb3DQEJDzFSMFAwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUr
DgMCBzANBggqhkiG9w0DAgIBKDBfBgsqhkiG9w0BCRACCzFQoE4wOTERMA8GA1UECgwIRXJp
Y3Nzb24xJDAiBgNVBAMMG0VyaWNzc29uIE5MIEluZGl2aWR1YWwgQ0EwMgIRAPorIKbalTFy
Rko8V1/Ja6owDQYJKoZIhvcNAQEBBQAEgYBlYAoXs+lHQSqtYIJIQ5Upv8pFfniiJRmH2eLL
VIItTs57nsnsV434boVkSAjfwtfGVsnfBr0xfc/bnZ66viDylHUY2xwugT3RYufkPeXZMpw+
wZI2OUESUj1Ifi8Oo4drFhfLXUODTIK9KhwTJNIGclSA6nmc+ggIIun2aLL+GwAAAAAAAA==
--------------ms050101070605060909090307--
