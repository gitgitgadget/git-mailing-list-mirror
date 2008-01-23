From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 19:38:04 -0500
Message-ID: <E6F76F93-24C9-4D10-813C-770A9C3A9828@sb.org>
References: <alpine.LFD.1.00.0!801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-48--596814464; micalg=sha1; protocol="application/pkcs7-signature"
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jan 23 01:38:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHTdY-0005g1-Tf
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 01:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYAWAiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 19:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYAWAiJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 19:38:09 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:55240 "EHLO
	randymail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751736AbYAWAiI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 19:38:08 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a10.g.dreamhost.com (Postfix) with ESMTP id 08CC710F8E7;
	Tue, 22 Jan 2008 16:38:05 -0800 (PST)
In-Reply-To: <20080123000841.GA22704@mit.edu>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71481>


--Apple-Mail-48--596814464
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 22, 2008, at 7:08 PM, Theodore Tso wrote:

> On Tue, Jan 22, 2008 at 08:34:27AM -0500, Theodore Tso wrote:
>> 	* Documenting HFS+'s current pseudo-normalization algorithm.
>> 	  It's not enough to say that you need to decompose all
>> 	  Unicode characters, since you've claimed that HFS+ doesn't
>> 	  decompose Unicode characters after some magic date,
>> 	  presumably roughly 9 years ago.
>
> I did some research on this point, since if we really are going to be
> compatible with MacOS X's crappy HFS+ system, we need to know what the
> decomposition algorithm actually is.  Turns out, there are *two* of
> them.  Kevin didn't know what he was talking about.  In fact,
> different versions of Mac OS X use different normalization algorithms.
>
> Mac OS X 8.1 through 10.2.x used decompositions based on Unicode 2.1.
> Mac OS X 10.3 and later use decompositions based on Unicode 3.2.[1]
>
> As I correctly predicted, Apple is changing their normalization
> algorithm in different versions of Mac OS X.  It is not static, which
> meands there will be compatibility problems when moving hard drives
> between Mac OS X versions.  I don't know if they try to fix this in
> their fsck or not, when upgrading from 10.2 to 10.3, but if not,
> certain files could disappear as part of the Mac OS X upgrade.  Fun
> fun fun.
>
> And clearly Kevin didn't read the tech note very carefully, since it
> clearly admits why they did it.  The Mac OS X developers were being
> cheasy with how they implemented their HFS B-tree algorithms, and took
> the cheap, easy way out.  So yeah, "crappy" is the only word that can
> be used for what Mac OS X perpetuated on the world.  Because of that,
> a quick Google search shows it causes problems all over the stack, for
> many different programs beyond just git, including limewire and
> gnutella[2][3], Slim[4], and no doubt others.
>
> [1] =
http://developer.apple.com/technotes/tn/tn1150.html#UnicodeSubtleties
> [2] =
http://lists.limewire.org/pipermail/gui-dev/2003-January/001110.html
> [3] =
http://osdir.com/ml/network.gnutella.limewire.core.devel/2003-01/msg00000.=
html
> [4] http://forums.slimdevices.com/showthread.php?t=3D40582
>
> In any case, it seems pretty clear that by now everyone except Kevin
> has realized that HFS+ is crappy and causes Internet-wide
> interoperability problems.  So I'll justify sending this note by
> pointing out the specific table of Mac OS's filesystem corruption
> algorithm can be found here:
>
> 	  http://developer.apple.com/technotes/tn/tn1150table.html
>
> I'd also recommend that the Mac OS X code try to either figure out
> whether it is running on an HFS+ partition, or let the HFS+ workaround
> code be something that can be controlled via .git/config.  It
> shouldn't be on unconditionally even on a Mac OS X system, since if
> the git repository is on a ZFS or NFS filesystem, there's no reason to
> pay the overhead of working around the HFS+ bugs.

I just finished talking to one of the HFS+ developers, so I suspect I =20=

know a lot more on this subject now than you do. Here's some of the =20
relevant information:

* Any new characters added to Unicode will only have one form =20
(decomposed), so HFS+ will always accept new characters as they will =20
be NFD. The only exception is case-sensitivity, as the case-folding =20
tables in HFS+ are static, so new characters with case variants will =20
be treated in a case-sensitive manner. However, as they are already =20
decomposed, the NFD algorithm will not change their encoding. This =20
means that no, there are zero problems moving HFS+ drives between =20
versions of OS X.

* At the time HFS+ was developed, there was no one common standard for =20=

normalization. The HFS+ developers picked NFD because they thought it =20=

was "a more flexible, future-looking form", but Microsoft ended up =20
picking the opposite just a short time later. Interestingly, NFC is a =20=

weird hybrid form which only has composed forms for pre-existing =20
characters, and decomposed forms for all new characters (as they only =20=

have one form). So in a sense NFD is more sane then NFC.

* The core issue here, which is why you think HFS+ is so stupid, is =20
that you guys see no problem with having 2 files "M=E4rchen" (NFC) and =20=

"M=E4rchen" (NFD), whereas the HFS+ developers don't consider it =20
acceptable to have 2 visually identical names as independent files. =20
Unfortunately, the only way to do this matching is to store the =20
normalized form in the filesystem, because it would be a performance =20
nightmare to try and do this matching any other way. The HFS+ =20
developers considered it an acceptable trade-off, and as an =20
application developer I tend to agree with them.

As I have stated in the past, this isn't a case of HFS+ being stupid =20
and causing problems, it's a case of HFS+ being *different* and =20
causing problems. But this difference is just as much your fault as it =20=

is HFS+'s fault.

* For detecting case-sensitive filesystems you can use pathconf(2): =20
_PC_CASE_SENSITIVE (if unsupported, you can assume the filesystem is =20
case-sensitive). There is also the getattrlist(2) attribute: =20
VOL_CAP_FMT_CASE_SENSITIVE.

There appears to be no API for determining if normalization will be =20
applied. However, any filesystem that uses UTF-8 explicitly as storage =20=

(unlike the Linux filesystems, which you claim use UTF-8 but is =20
obviously you really use nothing at all) is pretty much guaranteed to =20=

have to normalize or it will have abysmal performance.

I must say it is shocking that someone as smart as you is still more =20
interested in finding ways to prove me wrong then to actually address =20=

the problem. It's obvious that the only research you did was intended =20=

to find ways to call me stupid.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-48--596814464
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
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
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTIzMDAzODA1WjAjBgkqhkiG9w0BCQQxFgQUccU2+7CGrX4Kk83Yc6GcobjxfY4wgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAA0x1j1nTBVnGGYVjUaA6yXL+q32keF03FXEx2hOgoJV0xV/WD2A/Ir/Ardzm35Q9KDMUBr6
tRRBoPUInuBFPaWfdnU0RmNPwi93Ik2ALcBwna3xkaRs4FGAsv1nwZRQgnsLBQR09shDqPW78dN2
KFuTXr5yirj3y6H+2oZMQk4VDK0vlOjj45dOSv6w1fPHsRow04WTFTBdyKTgpBl4x7jMYb1adeT3
jCME5Ns4EInB36Q5xvUvX5VWZONzJTYb61ZDvAP2997mmiHTe44Nh9DMTULIOJBPx7Efjk46riL3
MuK5ay7Cn2r4Nc5zdRq+FGHut2pdA1HyWy2cO6VcWpkAAAAAAAA=

--Apple-Mail-48--596814464--
