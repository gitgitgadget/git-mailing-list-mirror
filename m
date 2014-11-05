From: Scott Schmit <i.grok@comcast.net>
Subject: Re: [PATCH v5] lockfile.c: store absolute path
Date: Tue, 4 Nov 2014 21:23:15 -0500
Message-ID: <20141105022315.GA28292@odin.ulthar.us>
References: <1414909477-20030-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="tThc/1wpZn/ma/RB"
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 05 03:31:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlqNk-0003xq-SC
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 03:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbaKECbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 21:31:31 -0500
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:45869 "EHLO
	resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751812AbaKECba (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Nov 2014 21:31:30 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Nov 2014 21:31:30 EST
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
	by resqmta-po-04v.sys.comcast.net with comcast
	id BePN1p0015E3ZMc01ePN1l; Wed, 05 Nov 2014 02:23:22 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by resomta-po-18v.sys.comcast.net with comcast
	id BePH1p00T2Ekl4801ePLj8; Wed, 05 Nov 2014 02:23:21 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.7/8.14.5) with ESMTP id sA52NHxE032563;
	Tue, 4 Nov 2014 21:23:17 -0500
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.7/8.14.7/Submit) id sA52NFYG032562;
	Tue, 4 Nov 2014 21:23:15 -0500
Mail-Followup-To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1414909477-20030-1-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1415154202;
	bh=ntvfONlQn9mAZpP09OzIv9qh4KMIjI94z76B4bditPA=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=lbXNs3cfnp0e+DAjahUqp29IivdccNamUGAC8IRwiaFkf+Q1KdussRqWPCP4+KKkA
	 RZNngTzEHththQW7eqhRFzHcLgu00qhoYlLbPq2f+fgbxJp2SY56x4knSWClloWofa
	 yBySWz8CjzGO0FyjJ+5d2LiwQ6axsbZ411VxmnLDb8OM64T+CIAZ/DfPyXSgapmQk5
	 EgKe7M4S1557Vw32tVjC2HewgLYayN1l+K9aVLxpMtSz+z1BvObSeb6t2TZieDZAVm
	 Mklql3M7Gb7HQVzuMuqwBFOVtlkUPLXFhJxV/8z+nZRqy2gksuwrPPHvNWeWG97pXr
	 Bh8D7XWvRwf7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2014 at 07:24:37AM +0100, Michael Haggerty wrote:
> Locked paths can be saved in a linked list so that if something wrong
> happens, *.lock are removed. For relative paths, this works fine if we
> keep cwd the same, which is true 99% of time except:
>=20
> - update-index and read-tree hold the lock on $GIT_DIR/index really
>   early, then later on may call setup_work_tree() to move cwd.
>=20
> - Suppose a lock is being held (e.g. by "git add") then somewhere
>   down the line, somebody calls real_path (e.g. "link_alt_odb_entry"),
>   which temporarily moves cwd away and back.
>=20
> During that time when cwd is moved (either permanently or temporarily)
> and we decide to die(), attempts to remove relative *.lock will fail,
> and the next operation will complain that some files are still locked.
>=20
> Avoid this case by turning relative paths to absolute before storing
> the path in "filename" field.

This might be a little pathological, but it seems like this scheme would
run into trouble if the entire repo is moved while the lock is held.

--tThc/1wpZn/ma/RB
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIPLwYJKoZIhvcNAQcCoIIPIDCCDxwCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
DGAwggY0MIIEHKADAgECAgEeMA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYD
VQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0
ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAe
Fw0wNzEwMjQyMTAxNTVaFw0xNzEwMjQyMTAxNTVaMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UE
ChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUg
U2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0
ZSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDHCYPMzi3YGrEp
pC4Tq5a+ijKDjKaIQZZVR63UbxIP6uq/I0fhCu+cQhoUfE6ERKKnu8zPf1Jwuk0tsvVCk6U9
b+0UjM0dLep3ZdE1gblK/1FwYT5Pipsu2yOMluLqwvsuz9/9f1+1PKHG/FaR/wpbfuIqu54q
zHDYeqiUfsYzoVflR80DAC7hmJ+SmZnNTWyUGHJbBpA8Q89lGxahNvuryGaC/o2/ceD2uYDX
9U8Eg5DpIpGQdcbQeGarV04WgAUjjXX5r/2dabmtxWMZwhZna//jdiSyrrSMTGKkDiXm6/3/
4ebfeZuCYKzN2P8O2F/Xe2AC/Y7zeEsnR7FOp+uXAgMBAAGjggGtMIIBqTAPBgNVHRMBAf8E
BTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUU3Ltkpzg2ssBXHx+ljVO8tS4UYIw
HwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUHAQEEWjBYMCcGCCsG
AQUFBzABhhtodHRwOi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUHMAKGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8v
d3d3LnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wu
Y29tL3Nmc2NhLmNybDCBgAYDVR0gBHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIB
FiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMA0GCSqGSIb3DQEBBQUAA4IC
AQAKgwh9eKssBly4Y4xerhy5I3dNoXHYfYa8PlVLL/qtXnkFgdtY1o95CfegFJTwqBBmf8py
TUnFsukDFUI22zF5bVHzuJ+GxhnSqN2sD1qetbYwBYK2iyYA5Pg7Er1A+hKMIzEzcduRkIMm
CeUTyMyikfbUFvIBivtvkR8ZFAk22BZy+pJfAoedO61HTz4qSfQoCRcLN5A0t4DkuVhTMXIz
uQ8CnykhExD6x4e6ebIbrjZLb7L+ocR0y4YjCl/Pd4MXU91y0vTipgr/O75CDUHDRHCCKBVm
z/Rzkc/b970MEeHt5LC3NiWTgBSvrLEuVzBKM586YoRD9Dy3OHQgWI270g+5MYA8GfgI/EPT
5G7xPbCDz+zjdH89PeR3U4So4lSXur6H6vp+m9TQXPF3a0LwZrp8MQ+Z77U1uL7TelWO5lAp
sbAonrqASfTpaprFVkL4nyGH+NHST2ZJPWIBk81i6Vw0ny0qZW2Niy/QvVNKbb43A43ny076
khXO7cNbBIRdJ/6qQNq9Bqb5C0Q5nEsFcj75oxQRqlKf6TcvGbjxkJh8BYtv9ePsXklAxtm8
J7GCUBthHSQgepbkOexhJ0wP8imUkyiPHQ0GvEnd83129fZjoEhdGwXV27ioRKbj/cIq7JRX
un0NbeY+UdMYu9jGfIpDLtUUGSgsg2zMGs5R4jCCBiQwggUMoAMCAQICAwo/3zANBgkqhkiG
9w0BAQsFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNV
BAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0
Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBMB4XDTE0MDYxNjAw
NDQ1NVoXDTE1MDYxNjE3MzYyNFowQDEbMBkGA1UEAwwSaS5ncm9rQGNvbWNhc3QubmV0MSEw
HwYJKoZIhvcNAQkBFhJpLmdyb2tAY29tY2FzdC5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC3HoziY3IySZbVkCfbjfgjTKO5CISA2+1GKzBNbzycTCXBWLnHvzrlFPlI
17z3noLux8ebSYz+TFiCUuVdwKkFOpN0WWxGzD6K/Hb0AJtKZp62YKtyRkCV51n5NrEepo28
hFkRhjgSkZA9t/4vtaWt0Ds8pIpUoQ1sNaUDWzjJ3UALl7m6b3XZmIouND+jq1AQv0ivMLuk
QNXO2a0KcuRVHDhAEdBvTi9LSePi8+Q8UWWBOeWmGhiKwL5X98Ne03GKxxQnLXDJbrX+cNcC
uaZIPdrmhbZCo+zegLfrApLRu9/6ox6/dnRsvmMpGcjNKLCgKoEh4cwyb+mhyzPXWlpXAgMB
AAGjggLYMIIC1DAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFKtASVM24m5BiMPABLNlKft1oxbCMB8GA1UdIwQYMBaA
FFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB0GA1UdEQQWMBSBEmkuZ3Jva0Bjb21jYXN0Lm5ldDCC
AUwGA1UdIASCAUMwggE/MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFy
dENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3
YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVt
ZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUg
aW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9i
bGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9j
cnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUFBzABhi1odHRwOi8vb2Nz
cC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYBBQUHMAKGNmh0dHA6
Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNhLmNydDAjBgNV
HRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQELBQADggEBALTg
t4rndUh0up2qJuskCTx4iRQd59+R0kOm7vJa94t+fSa8Wip4WeVOJZaHs1XIp17yoLTzcXN9
+L5lTC7HaHrBGOdB8su0muQyS///XwbDgn3/9+D0stPJZYLMrfRSm/FzQEk5j5McmODTCq8a
tQrlQilnBDcY00CYKBTKGAleOPjQ8yg/QVb/uqNuKE88+mfEdc6AKykYg7VXqxdL54ylqR3o
P8+PsP1YgCE2wqWWfGUp6hxIKa2XGtqVdHqL1yc5equX97TiUiIQ51j+nmU8tXTuR7OPRA1B
cHA+jx6rchpnZMEJn9DYPFOvkkC86mxOCax9r5HOtdidcw8uZSoxggKXMIICkwIBATCBlDCB
jDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3Vy
ZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNz
IDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMKP98wCQYFKw4DAhoFAKCB2DAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNDExMDUwMjIzMTVa
MCMGCSqGSIb3DQEJBDEWBBQytc4Dd5LCg83KaXhhkhkkBzhzVzB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAN
BgkqhkiG9w0BAQEFAASCAQBgDxa78UwUwf8DXCj9A2aRUm3OqaCJy4M9DCPYvxdfnYY4zQQr
jnEfsu25/pIP2Ehg3ewBDG3YQBW3dYA9AxhF+xqIBgUuQn5QtTTVEFYkKeLPw4sEyTtnntS8
XmaaEnsscO3QDx8/bEhas+dQOAnCumeLcDahI7UIm1KHHAhGftlezHpceBb4LAnDTYzdss09
lJWPINY1QRsdQWgGDBFU7wJr5RVSlELuwGTXomFhH39N5xRgPoXRPML/sz2HwI7z8U97Mf2/
dInZnGiCbCzKu6fww5/L1cpMhM4JzFw7LXecKacfLPFIMs+IT2i1f3vwUM0z1XxBYrYOESqV
hj0Z

--tThc/1wpZn/ma/RB--
