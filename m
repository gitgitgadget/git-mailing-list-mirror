From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] rebase: Squelch the "fatal: Not an error." message
Date: Fri, 26 Mar 2010 17:08:20 -0700
Message-ID: <46BEF37C-3E3F-4490-9CE6-C0109438C181@sb.org>
References: <C07F26A5-6BAD-433D-B1FF-A08DC8E0EA74@sb.org> <7vy6helwbq.fsf@alter.siamese.dyndns.org> <F8E395F5-C248-4A95-B2EF-A36E941FFDCF@sb.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: multipart/signed; boundary=Apple-Mail-2--716474990; protocol="application/pkcs7-signature"; micalg=sha1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 01:08:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvJZm-0004CF-Gi
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 01:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab0C0AIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 20:08:23 -0400
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:54317 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751161Ab0C0AIW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 20:08:22 -0400
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id DC5831857E2;
	Fri, 26 Mar 2010 17:08:21 -0700 (PDT)
In-Reply-To: <F8E395F5-C248-4A95-B2EF-A36E941FFDCF@sb.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143305>


--Apple-Mail-2--716474990
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 26, 2010, at 4:31 PM, Kevin Ballard wrote:

> On Mar 26, 2010, at 12:25 PM, Junio C Hamano wrote:
>=20
>> Hmm, since "git format-patch HEAD" simply exits with success, I am
>> inclined to think that we should fix "format-patch HEAD..HEAD" to do =
the
>> same instead.  I didn't check how involved such a change might be,
>> though.
>=20
> Actually it doesn't. The line `git format-patch =
--ignore-if-in-upstream HEAD` gives the same error (the flag seems to be =
necessary to get the error in the first place). In any case, I'll see if =
I can't figure out why it's giving that error.

Hmm, it seems like the easiest fix is just to comment out the following =
block in log.c (in get_patch_ids, line 645 on current next):

	if ((flags1 & UNINTERESTING) =3D=3D (flags2 & UNINTERESTING))
		die("Not a range.");

Without that line, `git format-patch --ignore-if-in-upstream HEAD` =
returns the expected empty output. I also ran the complete test suite =
(excluding SVN tests) and there were no breakages. However I don't =
understand the purpose behind that assertion in the first place (as I am =
not familiar with the workings of rev_info or patch_ids) so I don't know =
if this change is really appropriate (though I would assume that if it =
wasn't, a test somewhere would break).

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com




--Apple-Mail-2--716474990
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEEBvNCHopKrFMn5Q80vZpuswDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA5MDUwNzA1MDYyNloXDTEwMDUwNzA1MDYy
NlowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAKOBiOuMZxNp5ygOJZo2JaBVm5auXMJJmdmTeaSSA8BhvZ98mXzXnaNrXOYSeZHo
hkv4o5bM6LX3Ck38OmsgCcQMIfH4Kt39BvDokfA9ECq1J3HRNKuQ6ZSgZPaRWEy7TUeSHTx1ljxY
tzUt8uAwSsOKiHgLIDi+vtLK0KjGXH1sJP6ajvlrkxQ3bbcmaDXTkpvUl5NEAKv+yK4+KqwTgtwV
6ee2X4jjLjIgn/5Mm6pssaWuZtuEGRdQGkLcFVy+Wgo+5hpHf8fMXOSWsSp3/af6eSieL39M2Tit
E1vTuYRpYjpL0Aevubmm6wens4OTOYKILOTBJDYNfF4HmkK9sMsCAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAC6/X6Dgj4qoU
XSEZ1LmYkPgSLbRqIIRIgzTy52EnXL8ZQDVntI39lnn0VU8rnDY3sol9wr3feAG62AEa3LyTUxI0
6bWEiNMhPWRHnRoCqiV3F0FqqD8bZJ4J8TgJkRH6IL3MDMUSdGEEzef5KwdGt7ERv/Vk0LBc1ayb
y4FA1O4wggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEEBvNCHopKrFMn5Q80vZ
puswCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMTAwMzI3MDAwODIxWjAjBgkqhkiG9w0BCQQxFgQUhr8ZEO3eXbZgigdsGl05SWb6llAwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhBAbzQh6KSqxTJ+UPNL2abrMIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhBAbzQh6KSqxTJ+UPNL2abrMA0GCSqGSIb3DQEBAQUA
BIIBAKC0sHf/3+31plVJX2zDQXOzfmcoB1XqIB0O+RT7OBJ4W/dH8ZjvjvMhEeFFqN3CX0+AWrYi
iAYihoP+cJVJAxJgdvCqJRhZYwtAFePHj7zyH21k5juAZwbGMZy7C5mfaYFZ5ZpqRVscQBSwBbgR
FKdKKQaG7gDPBYvMF1MBr6cBtaPbY7MNOxKPV2QEX2nq9oEgCeFDbl2DGe3vUCtBuhnb6M0zCr0j
GxvTzs0Sbrtd0Qlg12BbUgWa+1tGrwnnkwHsOTIt7gTZDn9tJNrwFCQH6u/zrejSJzoZScayq6ux
0QK6F97MhGW4oOCNTRiLJQQKYfpwfdhJALY0CGc3NtkAAAAAAAA=

--Apple-Mail-2--716474990--
