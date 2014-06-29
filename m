From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Sun, 29 Jun 2014 16:20:22 -0400
Organization: PD Inc
Message-ID: <35E240FD8DD74A2F9B80FFCBD818A122@black>
References: <CABURp0rFCxxpiQhRYXmN5eBnKhyyOeuFSTj0V1tGZJSNea5iEA@mail.gmail.com> <66A60DA77398CD439FA676CEF593977D52477A@exchange.1.internal.pdinc.us> <CEAC9BE9F83B4CD0AFD73BBAC8A54232@black> <CABURp0okCDbwLOL3Osj2WtfQ_Qj3v=1FrAV28gJjPy1yzQU7Vg@mail.gmail.com> <CABURp0qZVMGMQ8X4P0P1OGF9gNqu__=Uk+Lr7GyBbscm5wL1=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="----=_NextPart_000_01F6_01CF93B6.04F798A0";
	micalg=SHA1;
	protocol="application/x-pkcs7-signature"
Cc: "'Phil Hord'" <phil.hord@gmail.com>
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:20:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1LaP-0007y4-G1
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 22:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbaF2UUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 16:20:25 -0400
Received: from mail.pdinc.us ([67.90.184.27]:60732 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398AbaF2UUY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 16:20:24 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5TKKM8u010179;
	Sun, 29 Jun 2014 16:20:22 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac+T1h3XsdlT8evfT3qEp0G4wAWB9AAAOTSw
In-Reply-To: <CABURp0qZVMGMQ8X4P0P1OGF9gNqu__=Uk+Lr7GyBbscm5wL1=w@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252646>

This is a multi-part message in MIME format.

------=_NextPart_000_01F6_01CF93B6.04F798A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Phil Hord 
> Sent: Sunday, June 29, 2014 16:09
> 
> On Sun, Jun 29, 2014 at 11:31 AM, Phil Hord 
> <phil.hord@gmail.com> wrote:
> > On Fri, Jun 27, 2014 at 8:42 PM, Jason Pyeron 
> <jpyeron@pdinc.us> wrote:
> >> Sorry for the http://pastebin.com/1R68v6jt (changes the merge to
> >> 1ca13ed2271d60ba93d40bcc8db17ced8545f172, and manually 
> reconciles the merge),
> >> but it was too long to be readable in the email.
> 
> Ok, I think I understand the issue you are trying to solve now.
> 
> Git (rather famously[1]) does not record renames or copies.  It is
> expected instead that renames and copies will be detected when it is
> important after the fact. This allows us to ignore rename detection
> and resolution when creating project history; in the future, better
> rename/copy detection will "just work" on existing repositories and
> the repos themselves will not need to be adjusted.

Looking at http://pastebin.com/1R68v6jt , I have a work around.

In summary, 7.git cherry-pick -x HEAD..rebranding , then

git merge $(echo 'Merge of 1ca13ed2271d60ba93d40bcc8db17ced8545f172 branch -
rebranding' |\
    git commit-tree -p HEAD -p rebranding \
         $(git cat-file -p HEAD | grep ^tree | sed -e 's/^tree //') )

Now it is perfect in the blame and log --graph.

> 
> What you are encountering now seems to be a shortcoming of Git's
> current rename/copy detection.  But you are trying to overcome today's
> shortcoming by adjusting your project history to accommodate it.
> Instead you should just do the merge like you normally would without
> regard to how 'git blame' shows the result.
> 
> Maybe there is a bug here still, but it is probably in git-blame.
> 
> [1] 
> https://git.wiki.kernel.org/index.php/GitFaq#Why_does_Git_not_
> .22track.22_renames.3F
> 
--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

------=_NextPart_000_01F6_01CF93B6.04F798A0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIWpTCCBDow
ggMioAMCAQICAQUwDQYJKoZIhvcNAQEFBQAwTTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4g
R292ZXJubWVudDEMMAoGA1UECxMDRUNBMRYwFAYDVQQDEw1FQ0EgUm9vdCBDQSAyMB4XDTA4MDQw
NDE0MjQ0OVoXDTI4MDMzMDE0MjQ0OVowTTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292
ZXJubWVudDEMMAoGA1UECxMDRUNBMRYwFAYDVQQDEw1FQ0EgUm9vdCBDQSAyMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs5DYHu+a7W5HsUZhRo2jVgicSjLHRfLSpKRmvn49l4Dv6ddr
6eDAO43i+BL6EzWkzVqGi7DQLzSM9wXth2+nMBfQFsZYRr2V+VYaiNROHn5YHxuicxWdXosGJBN2
PJ9gYq2wtfTgJMFT99kcNx3mPPD60/H5oZjxN4XYzwJg8KA4lEtRKAnCF/xApGF5DrSMGyCCYvXk
mtYpijb6H4HAoRExS/5W/di/UZMnWdr1gz5EpN/VIGfrnwCn+94xtmMxHD33HGwJjX/0upyofB8B
xoBtAQHYN6j+LX0rwsvW6Zy6lI12Ft7MgXUEe0F3FWUVyawAtr/rHNy5jWQt/zXbxQIDAQABo4IB
IzCCAR8wHQYDVR0OBBYEFO3kh9AnxFDmhDr3zPfrOkn8Uk4hMA4GA1UdDwEB/wQEAwIBhjAPBgNV
HRMBAf8EBTADAQH/MIHcBggrBgEFBQcBCwSBzzCBzDBDBggrBgEFBQcwBYY3aHR0cDovL2NybC5n
ZHMuZGlzYS5taWwvZ2V0SXNzdWVkQnk/RUNBJTIwUm9vdCUyMENBJTIwMjCBhAYIKwYBBQUHMAWG
eGxkYXA6Ly9jcmwuZ2RzLmRpc2EubWlsL2NuJTNkRUNBJTIwUm9vdCUyMENBJTIwMiUyY291JTNk
RUNBJTJjbyUzZFUuUy4lMjBHb3Zlcm5tZW50JTJjYyUzZFVTP2Nyb3NzQ2VydGlmaWNhdGVQYWly
O2JpbmFyeTANBgkqhkiG9w0BAQUFAAOCAQEASswb54WIkyPZub7PuvE1lMFLPBNwXYMuTn7BVg8t
wX4fDend/gKZfGDjhqq5hiPDF37HEQ/j0EJWoxzzcI+xiJG1vA6JJWbIP182Kg4+tmdAjD1A36di
4DgY+iRtLSPTwLh0XpVEVHohlw9azcP8lT0iIhXdGGBdhTepTfeB/L1KpliMT7/HZaH/4tM0SBoX
ATLyhPPeBbJkSZg3zSH1qIFbZMXafFiwYWEfrcCt7TS2lKvHnOxllymFlJQzxDUkiz3N/Dcqu/qk
thuQ8pVXF0jg76mdrQDisWTZZ3kRg7ma6AsyNs4gZ+N6bUvqXlPlLzBB3fjlVJ2p12nGddlFRzCC
BXAwggRYoAMCAQICAQ4wDQYJKoZIhvcNAQEFBQAwTTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1Uu
Uy4gR292ZXJubWVudDEMMAoGA1UECxMDRUNBMRYwFAYDVQQDEw1FQ0EgUm9vdCBDQSAyMB4XDTEx
MDYwMTEzNDEzMFoXDTE3MDUzMDEzNDEzMFowcDELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4g
R292ZXJubWVudDEMMAoGA1UECxMDRUNBMSIwIAYDVQQLExlDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
aWVzMRUwEwYDVQQDEwxPUkMgRUNBIEhXIDQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDge/Z9Vb4GLw94fCmCkOc2BJGg5Qv2UyNGoaNifHPne2x/YJaNF/rUNaSZql/Dc5TV4YdDtNIj
ZXDRTL1zjrozbZRCpZzh00mowhitYrdl4OdVFbLRNbQtm+hab0VWeEe/Jvlth9GPmEaAHcbLIF1q
x/1bcXjEp8BE84p+WoxXniVZf3RBlv0FOt48pIxwbb3pOmITd1US5sPiRoQ7KTjVJ/eV68tftNHa
/kLuUy+KjbQoNtGng71BClqBaU3YhXP1Sfe/Spu0iOnH7/hQ4OE/WC2bbl50Xrm+VTmfhMFyxxxb
dspGN86k6YQmiSAqjq0wYWaxdRRIsnt7T49UHr9VAgMBAAGjggI2MIICMjASBgNVHRMBAf8ECDAG
AQH/AgEAMA4GA1UdDwEB/wQEAwIBhjAdBgNVHQ4EFgQUW1TB31t33S3052BtEbiayFwM5+kwHwYD
VR0jBBgwFoAU7eSH0CfEUOaEOvfM9+s6SfxSTiEwMwYDVR0gBCwwKjAMBgpghkgBZQMCAQwBMAwG
CmCGSAFlAwIBDAIwDAYKYIZIAWUDAgEMAzCBwAYDVR0fBIG4MIG1MCygKqAohiZodHRwOi8vY3Js
LmRpc2EubWlsL2NybC9FQ0FST09UQ0EyLmNybDCBhKCBgaB/hn1sZGFwOi8vY3JsLmdkcy5kaXNh
Lm1pbC9jbiUzZEVDQSUyMFJvb3QlMjBDQSUyMDIlMmNvdSUzZEVDQSUyY28lM2RVLlMuJTIwR292
ZXJubWVudCUyY2MlM2RVUz9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0O2JpbmFyeTCB0wYIKwYB
BQUHAQEEgcYwgcMwOgYIKwYBBQUHMAKGLmh0dHA6Ly9jcmwuZGlzYS5taWwvaXNzdWVkdG8vRUNB
Uk9PVENBMl9JVC5wN2MwgYQGCCsGAQUFBzAChnhsZGFwOi8vY3JsLmdkcy5kaXNhLm1pbC9jbiUz
ZEVDQSUyMFJvb3QlMjBDQSUyMDIlMmNvdSUzZEVDQSUyY28lM2RVLlMuJTIwR292ZXJubWVudCUy
Y2MlM2RVUz9jcm9zc0NlcnRpZmljYXRlUGFpcjtiaW5hcnkwDQYJKoZIhvcNAQEFBQADggEBAAgE
rwyRj0AJ3jSCiUPgB2NyvxQhKhjfcNXSZWCQB7Fm7Dz+Z7NwNmDtCUTzr1jjLWF+raQe/2wRqVqH
RRIP/43fg4Y4DczjW9l2AghSJwssI0mw+VvHKwMSfffRV5VkUUaLHjlzBMFKm+U6I8IYfXRDlivp
b4jDOsjVO4MbEE4A6qT+4xQkyKvu5bJhNOUMhmZH+6WfLKS+q4ZDQH8RUYPNFxB6MS5sQFPP+d7w
og8grAsJD3s3SZAImKWWOaYJK8975BjMGK/LWLAnsFAneKTCH15EfEHsKNyK+lhMATH0BugSey8e
OipODRXrXfNpQcBpNoxTgn9sR0pYBffWXiMwggZQMIIFOKADAgECAgJgijANBgkqhkiG9w0BAQUF
ADBwMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0Ex
IjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMxFTATBgNVBAMTDE9SQyBFQ0EgSFcg
NDAeFw0xNDAzMjExNDQ5NTVaFw0xNTAzMjExNDQ5NTVaMIGDMQswCQYDVQQGEwJVUzEYMBYGA1UE
ChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0ExDDAKBgNVBAsTA09SQzEPMA0GA1UECxMG
UEQgSW5jMS0wKwYDVQQDEyRQeWVyb24uSmFzb24uSi5PUkMxMDAwMDQwMDA5LkVuY3J5cHQwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCHVGq6phwNUEI94zOPAen5rvUdObUTzuwHMwEw
L9wmvWktZ0Zj8ONcWrYLfr+H9YSEf3H0rKbJinu8YXqP0KwKZPm7+5zMqfHW3nE95IyKSYaq9YiM
Fi1VBKijmxEdO5NZCpFANtCaa0GUI78GI6PrBK9Q2qTTSU281cmr4TXSBfg+D6c9Af+ZPCsqJnEi
nv75M4ujeYkgF5Q+yFY6xCfPWlOPSjkpCyFuDqLG7G8mI4BHTuCiPNazURh7uQVidqrm6lZgco+M
QifyvEw2FMKKI59YYTMuukwCmZXZHY7xgUsx1zY3UofZ7G75xCSIa+KIg3WiTwF4ZDlvkGbzJxgn
AgMBAAGjggLeMIIC2jAfBgNVHSMEGDAWgBRbVMHfW3fdLfTnYG0RuJrIXAzn6TAdBgNVHQ4EFgQU
o/cER+2FSXj3xSAACMzkFCxkMLYwggEjBggrBgEFBQcBAQSCARUwggERMB4GCCsGAQUFBzABhhJo
dHRwOi8vZXZhLm9yYy5jb20wMgYIKwYBBQUHMAKGJmh0dHA6Ly9lY2Eub3JjLmNvbS9jYUNlcnRz
L0VDQS1IVzQucDdjMIG6BggrBgEFBQcwAoaBrWxkYXA6Ly9lY2EtZHMub3JjLmNvbS9jbiUzZE9S
QyUyMEVDQSUyMEhXJTIwNCUyY291JTNkQ2VydGlmaWNhdGlvbiUyMEF1dGhvcml0aWVzJTJjb3Ul
M2RFQ0ElMmNvJTNkVS5TLiUyMEdvdmVybm1lbnQlMmNjJTNkVVM/Y0FDZXJ0aWZpY2F0ZTtiaW5h
cnksY3Jvc3NDZXJ0aWZpY2F0ZVBhaXI7YmluYXJ5MA4GA1UdDwEB/wQEAwIFIDAbBgNVHREEFDAS
gRBqcHllcm9uQHBkaW5jLnVzMDMGA1UdIAQsMCowDAYKYIZIAWUDAgEMATAMBgpghkgBZQMCAQwC
MAwGCmCGSAFlAwIBDAMwgfEGA1UdHwSB6TCB5jAroCmgJ4YlaHR0cDovL2VjYS5vcmMuY29tL0NS
THMvT1JDRUNBSFc0LmNybDCBtqCBs6CBsIaBrWxkYXA6Ly9lY2EtZHMub3JjLmNvbTozODkvY24l
M0RPUkMlMjBFQ0ElMjBIVyUyMDQlMkMlMjBvdSUzRENlcnRpZmljYXRpb24lMjBBdXRob3JpdGll
cyUyQyUyMG91JTNERUNBJTJDJTIwbyUzRFUuUy4lMjBHb3Zlcm5tZW50JTJDJTIwYyUzRFVTP2Nl
cnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q7YmluYXJ5MBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMC
VVMwDQYJKoZIhvcNAQEFBQADggEBAMHBMK1AgK67iB22i3RXU9GmWaWr3EN57rSCDL+KqBvkZqBm
K6NpnB+ka3kfhnv6KQCno2cQlup6miwd43td7J/WVTYxQCHhBWpf163SIl50ZvbtmNU/eFkhEu+Q
x+NQ6U8vf8Tur6RXheMlBW34FwJ3VrxpuF1vPg9ntUGfNl36sgcbNjc7rL/t8EhgXGVyKRQI4X4D
ZBw+txM425OFoY2RRkuf1rB8EMA1HPUsAMRt5rSgLLplt2mrbrMaiG7cO0SFQjgAGOgb2ZXrX/Mp
POu4R78vjhQacrzXSoAHoMG72QJ9C1Kn9FyhjYhDzSIsffQF48QRq1bciseiOBeSnh8wggabMIIF
g6ADAgECAgJgiTANBgkqhkiG9w0BAQUFADBwMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBH
b3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRp
ZXMxFTATBgNVBAMTDE9SQyBFQ0EgSFcgNDAeFw0xNDAzMjExNDQ4NDVaFw0xNTAzMjExNDQ4NDVa
MH4xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0VDQTEM
MAoGA1UECxMDT1JDMQ8wDQYDVQQLEwZQRCBJbmMxKDAmBgNVBAMTH1B5ZXJvbi5KYXNvbi5KLk9S
QzEwMDAwNDAwMDkuSUQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCIL0F8IDr6w0UP
8SQyeCpzFSQCTX+1oekpZImxMYChSJaRY5NQUlRHh9gnTM1r49repFVI+HFOJogavB0zUS3TVXp0
r23kwgHWAjiiyagdwsfEgWObIx4FLUaVOYNYO777kxk/Nydo7S1+4qrV0DFpLuQC1Gsh9F4s8+9F
dUNjkLXjf04fBufMz3ks+O271KnbZKtdmroWtzUxO2w8B90JCQJQbOAwtiyXC6KTCf5QcucHUX04
fyBbKJxItSF13MAIxViGzK+/eWYdajW5Ni6EQ10LpOgJwCzYCCZONrPbFJ+EklJCF3DwzlnMoID9
zYFwVqSExIFV6uUlZ/xAOiaNAgMBAAGjggMvMIIDKzAfBgNVHSMEGDAWgBRbVMHfW3fdLfTnYG0R
uJrIXAzn6TAdBgNVHQ4EFgQUnGL5UXepgybvXuqzlqGkL1YvyH4wggEjBggrBgEFBQcBAQSCARUw
ggERMB4GCCsGAQUFBzABhhJodHRwOi8vZXZhLm9yYy5jb20wMgYIKwYBBQUHMAKGJmh0dHA6Ly9l
Y2Eub3JjLmNvbS9jYUNlcnRzL0VDQS1IVzQucDdjMIG6BggrBgEFBQcwAoaBrWxkYXA6Ly9lY2Et
ZHMub3JjLmNvbS9jbiUzZE9SQyUyMEVDQSUyMEhXJTIwNCUyY291JTNkQ2VydGlmaWNhdGlvbiUy
MEF1dGhvcml0aWVzJTJjb3UlM2RFQ0ElMmNvJTNkVS5TLiUyMEdvdmVybm1lbnQlMmNjJTNkVVM/
Y0FDZXJ0aWZpY2F0ZTtiaW5hcnksY3Jvc3NDZXJ0aWZpY2F0ZVBhaXI7YmluYXJ5MA4GA1UdDwEB
/wQEAwIGwDApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIwQQYDVR0R
BDowOIEQanB5ZXJvbkBwZGluYy51c6AkBgorBgEEAYI3FAIDoBYMFE9SQzEwMDAwNDAwMDlARE9E
RUNBMDMGA1UdIAQsMCowDAYKYIZIAWUDAgEMATAMBgpghkgBZQMCAQwCMAwGCmCGSAFlAwIBDAMw
gfEGA1UdHwSB6TCB5jAroCmgJ4YlaHR0cDovL2VjYS5vcmMuY29tL0NSTHMvT1JDRUNBSFc0LmNy
bDCBtqCBs6CBsIaBrWxkYXA6Ly9lY2EtZHMub3JjLmNvbTozODkvY24lM0RPUkMlMjBFQ0ElMjBI
VyUyMDQlMkMlMjBvdSUzRENlcnRpZmljYXRpb24lMjBBdXRob3JpdGllcyUyQyUyMG91JTNERUNB
JTJDJTIwbyUzRFUuUy4lMjBHb3Zlcm5tZW50JTJDJTIwYyUzRFVTP2NlcnRpZmljYXRlUmV2b2Nh
dGlvbkxpc3Q7YmluYXJ5MBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwDQYJKoZIhvcNAQEF
BQADggEBAIdJ0/H8HR4YWUR+61QOVO7TZEcQ42QYzLU6910C8voTytaHKu1SWNMbsBaw/mmYK/ez
+mFuXO39eRUYmSoaZk9KmvTG4kALL21ETRdAIUmgLl039qDP3ASLyPHa9KLleJCmxNpK6QnRhvqp
MItvJX9Ly8nUdRTs9fiy5am4+Zh0lNaQNeelW70pEEWPbR1EXyD/vfueIccOic/A9NrGf7P1MjgF
qAhUbPuTwD5DiCcxItvi6uiIx3ykyM45TzEZSKZSWMwxMY3UGno4oEEtiJSEOhWYAj6hypGgm8xE
wAb/AGWgDYwdRl5zQm6v+f4OdLm85iX3oaztaaj+IKarJIcxggN5MIIDdQIBATB2MHAxCzAJBgNV
BAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0VDQTEiMCAGA1UECxMZ
Q2VydGlmaWNhdGlvbiBBdXRob3JpdGllczEVMBMGA1UEAxMMT1JDIEVDQSBIVyA0AgJgiTAJBgUr
DgMCGgUAoIIB2DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNDA2
MjkyMDIwMTlaMCMGCSqGSIb3DQEJBDEWBBRRttAQR4B8Be8l8r5PayYM7QfR1TBnBgkqhkiG9w0B
CQ8xWjBYMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMC
BzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjAKBggqhkiG9w0CBTCBhQYJKwYBBAGCNxAEMXgwdjBw
MQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0ExIjAg
BgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMxFTATBgNVBAMTDE9SQyBFQ0EgSFcgNAIC
YIowgYcGCyqGSIb3DQEJEAILMXigdjBwMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zl
cm5tZW50MQwwCgYDVQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMx
FTATBgNVBAMTDE9SQyBFQ0EgSFcgNAICYIowDQYJKoZIhvcNAQEBBQAEggEALc+D6X1YRm4dQjuH
1ed99B2hHBqMTQzI27B5L7uhNTgzHhvlk+uEwJqKBNGbg07cgZLQ9elhxHrrNk0LXiQ2Rg8hwLIE
1/2PYnzBqtqFo0avioy7RhHXbaWqZs9DNkw/puvh67fck2Vv7QQhlZ+ih6k2TQS+JB1yP0o5ATu8
cDBH+ObrgxvNt6Atfb0l02ZLiHh+rMC4KMJkbbdcZNC4rqAjJkNjaBkiUmKuKafcAcz+58TFHgo2
f4yVVRuWJH5qHRhOqekVJQcpT6KitLUlPPJwn5QI7y2Yh23KgyOEPab6PhxbRPucybkv8TQgLwbi
vbhCfof445vIAVvEWFH7wgAAAAAAAA==

------=_NextPart_000_01F6_01CF93B6.04F798A0--
