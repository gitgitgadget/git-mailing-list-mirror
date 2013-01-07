From: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
Subject: RE: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Mon, 7 Jan 2013 09:10:57 +0000
Message-ID: <871B6C10EBEFE342A772D1159D1320853A011C4D@umechphj.easf.csd.disa.mil>
References: <2491041.bQ51Qu8HcA@thunderbird>
 <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black>
 <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin>
 <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin>
 <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin>
 <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com>
 <FBDECCA565D94DF9838DD81FE2E2543A@black>
 <7v1udxladc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0004_01CDEC8C.76CE71B0"
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	"Stephen & Linda Smith" <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 10:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts8jG-0000sr-HA
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 10:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab3AGJKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 04:10:23 -0500
Received: from edge-mech.mail.mil ([214.21.82.9]:56177 "EHLO
	edge-mech.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab3AGJKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 04:10:20 -0500
Received: from UMECHPHT.easf.csd.disa.mil (214.21.83.145) by
 umechpid.easf.csd.disa.mil (214.21.82.9) with Microsoft SMTP Server (TLS) id
 14.2.309.2; Mon, 7 Jan 2013 09:10:58 +0000
Received: from UMECHPHJ.easf.csd.disa.mil ([169.254.5.12]) by
 UMECHPHT.easf.csd.disa.mil ([214.21.83.145]) with mapi id 14.02.0309.003;
 Mon, 7 Jan 2013 09:10:57 +0000
Thread-Topic: Version 1.8.1 does not compile on Cygwin 1.7.14
Thread-Index: AQHN676Hrnp69eooZUuDXCf3iuDpPJg71HsAgAACaYCAAA8WgIAAI/GAgAACwYCAAARygIAAHtGAgAAF4ICAAIJsJ4AAJ0EAgAB7HwCAAB+ZroAAF1TA
In-Reply-To: <7v1udxladc.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [214.21.83.188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212888>

------=_NextPart_000_0004_01CDEC8C.76CE71B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Junio C Hamano
> Sent: Monday, January 07, 2013 2:29 AM
>=20
> Jason Pyeron writes:
>=20
> [administrivia: please never cull CC list when you respond to a
> message on this list without a good reason]

Apologies, I just have 4 copies of every message and was trying to save =
other that pain.

>=20
> >> circumvent the Cygwin API (and by extension, Cygwin project goals).
> >>
> >> So, perhaps a better path forward is to disable / remove the
> >> above code by default. (Those wanting a native Win32 git
> >> should just use the native
> >> Win32 git).
> >
> > Or a make option...
>=20
> It already is a runtime option, isn't it?
>=20
> I do not have much stake in this personally, but IIRC, the (l)stat
> workaround was back then found to make Cygwin version from "unusably
> slow" to "slow but torelable", as our POSIX-y codebase assumes that
> lstat is fairly efficient, which Cygwin cannot satisify because it

Is there already a set of test cases I can run to validate that this is =
still true?

> has call many win32 calls to collect bits that we do not even look
> at, in order to give faithful emulation.  It does place extra
> maintenance burden (e.g. conditional compilation depending on the
> header file the particular version of Cygwin installation the user
> has at hand) on us, but as long as it works, the ugly hack is fairly

There seems to be only 2 valid use cases here, with regards to cygwin.

1. Do it the normal posix way, and don=92t hack it up.
2. For speed reasons, merge in native windows/non-posix functions.

I would not care about the user's cygwin version because the cygwin =
supporters won't either. In both cases assume the latest cygwin =
libraries. If there is a specific user with a use case for an older =
version of cygwin libraries then we can cross that bridge when (if) we =
arrive at it.

> isolated and I do not see a reason to unconditionally rip it out,
> especially if the reasoning behind such move is on "All programs
> that run in Cygwin environment has to be POSIX only and must not use
> Win32 API directly, even in a controlled way."

I presently do not care if it stays or goes. But if someone were to =
bring this to the cygwin mailing list it would be a headache to deal =
with the "hacked" way. They would likely be more receptive to increasing =
the efficiency of the lstat than other approaches.

>=20
> It is a completely different matter if the direct win32 calls we
> make, bypassing (l)stat emulation, somehow change the internal state
> of win32 resources Cygwin controls and violates the invariants
> Cygwin API implemenation expects, breaking later calls to it.  I
> do not know that is the case here, but I doubt it.

I agree, it is not going to break anything here. Those libraries are =
just a way of presenting the Windows API without using Microsoft files =
and making it easier to wrap the POSIX apis to it.=20


------=_NextPart_000_0004_01CDEC8C.76CE71B0
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
GDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AOYpItQUJtGYGlJexYSDc37BYLOz0JS+/RyUVb/2hCybycB0c+/MwpnymcltyhTTdP++EPL3Lb/L
uwaj7phQQWUB4VcstsvkyhysflI0DrGOByY+MjWvo2EKxeUIthJ5jFTBeunxUB9dgzpnMLMp2x06
TDkhUNgYLI0Gde5jcnhorWKcdaSUBtMyaxKvBgcpvhOgwKfwJU+3/h+3V+AYEo0hahW5WlT7d2XY
TD/1ujzAN+EGfsK+niOMKNGa18ZnONdzyb0HHYVv1ZUKmtzaOk4o8KXrCd/l2wvNR6+KzbtvlEDj
WZxQn8kOqXECudzpaYA6iTtFBSIYBYS1EvA8wIECAwEAAaOCAhwwggIYMA4GA1UdDwEB/wQEAwIB
hjAfBgNVHSMEGDAWgBRJdLsMXrp6/gJU73ugxpXGCYBwljAdBgNVHQ4EFgQUNWFmKAm8ViVbi8y/
gV5hLDA50yEwEgYDVR0TAQH/BAgwBgEB/wIBADAMBgNVHSQEBTADgAEAMGYGA1UdIARfMF0wCwYJ
YIZIAWUCAQsFMAsGCWCGSAFlAgELCTALBglghkgBZQIBCxEwCwYJYIZIAWUCAQsSMAsGCWCGSAFl
AgELEzAMBgpghkgBZQMCAQMaMAwGCmCGSAFlAwIBAxswNwYDVR0fBDAwLjAsoCqgKIYmaHR0cDov
L2NybC5kaXNhLm1pbC9jcmwvRE9EUk9PVENBMi5jcmwwggEBBggrBgEFBQcBAQSB9DCB8TA6Bggr
BgEFBQcwAoYuaHR0cDovL2NybC5kaXNhLm1pbC9pc3N1ZWR0by9ET0RST09UQ0EyX0lULnA3YzAg
BggrBgEFBQcwAYYUaHR0cDovL29jc3AuZGlzYS5taWwwgZAGCCsGAQUFBzAChoGDbGRhcDovL2Ny
bC5nZHMuZGlzYS5taWwvY24lM2REb0QlMjBSb290JTIwQ0ElMjAyJTJjb3UlM2RQS0klMmNvdSUz
ZERvRCUyY28lM2RVLlMuJTIwR292ZXJubWVudCUyY2MlM2RVUz9jcm9zc0NlcnRpZmljYXRlUGFp
cjtiaW5hcnkwDQYJKoZIhvcNAQEFBQADggEBAAqIVhylVyZaYst10N2GxVLiL/O8EWQ/jC8+EfyY
YEDygA0ogppo/uBISyfTOgp7lfYDDIEUkUI6YGziK1Mt7N8RrvVUF/AB+ZcHp5urC9usl4kJxu/5
BzQWAKh+EVOefC+hOKKZeTk0QW59uFgwVoie5KpkRdmgRGI6t+Ux05GA8RsQsmdw1VurWbRaSBZC
xAJM2mxoylAdMb43mcfPU8xCKVbDnRfKA+cQWvE5PBzM+xuXCibzMd/gq1wknZ7eOH0CUWdG+ZNw
he0KVcL0wWhanwjJHXubdtxU7zmMGOUMRO73BrIf9cvmDr3Uof/U+ZEHIlJ5t8D97LL4hfRE+1wx
ggMyMIIDLgIBATBkMF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAK
BgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzACAyLbDjAJ
BgUrDgMCGgUAoIIBozAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0x
MzAxMDcwOTA3MDlaMCMGCSqGSIb3DQEJBDEWBBQFolq0T2fX3ZxPcKHOLy6UH3OeQjBYBgkqhkiG
9w0BCQ8xSzBJMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0D
AgIBKDAHBgUrDgMCGjAKBggqhkiG9w0CBTBzBgkrBgEEAYI3EAQxZjBkMF0xCzAJBgNVBAYTAlVT
MRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgw
FgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzACAyLbETB1BgsqhkiG9w0BCRACCzFmoGQwXTELMAkGA1UE
BhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQ
S0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMAIDItsRMA0GCSqGSIb3DQEBAQUABIIBAAQyKf5p
m2roTHbGAiADJivegI6ZteawgFqUf7OIg1DafQJ7PCvrPGVXdyxJD9RCK8zgK8rZFMyn1mhPRXXO
kbp9kbEh0HGm0xUOx/briY756OWAlWIPjTa0mpxv+YoNMzhKnsi/hjdLwZxIkKYB+G1gPZQD2zd4
H9QdIj9yX4092+OHu8cJvuM2f2ABI3oK1ZGASNmYSh8Ezm+z1qOakerlCtXL/2zqkH2//56xky51
8K1a9sCidg/rSF0cryrQ4y8g+3h+Ha1nKv8S9G9ppPalJ+Ig407vDAvdH18Qwln8zYPZ3DcR9Vpp
Gf2sRfN4NdsB5AXyynqug/F4VYXHaCUAAAAAAAA=

------=_NextPart_000_0004_01CDEC8C.76CE71B0--
