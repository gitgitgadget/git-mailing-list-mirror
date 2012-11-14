From: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
Subject: RE: push branch descriptions
Date: Wed, 14 Nov 2012 17:21:03 +0000
Message-ID: <871B6C10EBEFE342A772D1159D13208537AABCCA@umechphj.easf.csd.disa.mil>
References: <CAB9Jk9ABenaj=R0a6OW2GCsin8PdDCW3ZbuQbu6G0jnGG3s+sA@mail.gmail.com>
	<7vr4nwb832.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BN6vTnpPa8rv1Yumn2Os=XU=tEn3=j2QJJK1GpajY=VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0041_01CDC262.37350EA0"
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYgeb-0007pE-5t
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 18:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423087Ab2KNRVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 12:21:18 -0500
Received: from edge-mech.mail.mil ([214.21.82.9]:5583 "EHLO edge-mech.mail.mil"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423073Ab2KNRVR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 12:21:17 -0500
Received: from UMECHPIA.easf.csd.disa.mil (214.21.83.149) by
 umechpid.easf.csd.disa.mil (214.21.82.9) with Microsoft SMTP Server (TLS) id
 14.2.309.2; Wed, 14 Nov 2012 17:21:03 +0000
Received: from UMECHPHJ.easf.csd.disa.mil ([169.254.5.252]) by
 UMECHPIA.easf.csd.disa.mil ([214.21.83.149]) with mapi id 14.02.0309.003;
 Wed, 14 Nov 2012 17:21:03 +0000
Thread-Topic: push branch descriptions
Thread-Index: AQHNwjiQYyg8sEltz0WxGzIecPmoPZfpW5iYgAAO5ICAAA05AA==
In-Reply-To: <CAB9Jk9BN6vTnpPa8rv1Yumn2Os=XU=tEn3=j2QJJK1GpajY=VQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [214.21.83.188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209731>

------=_NextPart_000_0041_01CDC262.37350EA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Angelo Borsotti
> Sent: Wednesday, November 14, 2012 9:51 AM
> 
> Hi Junio,
> 
> > It would conceptually be a lot cleaner to treat updating of remote
> > Ibranch description as a separate "repository management" class of
> > Ioperation, similar to setting the repository description stored in
> > I$GIT_DIR/description.
> 
> I agree, it should be a distinct operation. I was thinking that when
> you have a remote bare repository, the normal way of adding contents
> to it is to push to it, and thus also adding a description should be
> done with some sort of pushing. Creating branches is also normally
> done with a push (think how difficult it is to create a branch in a
> bare repository when the HEAD is not set ...).

Only if the push were to create the branch...


> On 14 November 2012 14:57, Junio C Hamano <gitster@pobox.com> wrote:
> > Angelo Borsotti <angelo.borsotti@gmail.com> writes:
> >
> >> currently, there is no means to push a branch description to a
> remote
> >> repository. It is possible to create a branch, but not to set its
> >> description.
> >
> > Correct.  You have to go to the remote repository and run "git
> > branch --edit-description" there; there is currently no way to do
> > this remotely, which may be an issue, but...
> >
> >> Would not be more correct to push also branch descriptions when
> >> branches are pushed?
> >
> > ... I do not think "git push" is the best place to do so, given the
> > inherently local nature of branches and branch descriptions.
> >
> > Imagine the project creates a branch "magic" to enhance its system
> > with magic words.  The description for the "magic" branch in the
> > project may say "support magic words" or something.
> >
> > You and your friend are tasked to add a handful of magic words,
> > e.g. "xyzzy", "frotz" and "nitfol".  You may start your work like so
> > on your "magic-xyzzy" branch:
> >
> >     $ git clone git://example.com/zork.git/
> >     $ git checkout -b magic-xyzzy -t origin/magic

And here the branch description should copy from origin/magic.

> >
> > And you say something like "add xyzzy magic" in its branch
> > description.
> >
> >     $ git branch --edit-description magic-xyzzy
> >

And now it is edited

> > After finishing your work, you may push it
> >
> >     $ git push origin magic-xyzzy:magic
> >
> > Should the description of the subtask "add xyzzy magic" overwrite
> > the purpose of the project wide "magic" branch "support magic words"?
> > Most likely not.

Never overwrite anything.

> >
> > The local nature of the description becomes even more clear if you
> > imagine the case where the push at the last stage gets rejected due
> > to non-fast-forward error (in other words, your friend has already
> > pushed her support of the "frotz" magic to the "magic" branch.
> >
> > In fact, you would normally not directly push your magic-xyzzy
> > branch to the magic branch, but you would do something like this
> > once you are done:
> >
> >     $ git checkout -b magic -t origin/magic
> >     $ git pull origin ;# to update with her work
> >     $ git merge magic-xyzzy
> >     $ git push origin magic
> >
> > And the last "merge" is where the description for your magic-xyzzy
> > is used to fill the commit log template for you to explain your
> > merge (that is, you are merging a branch whose description is "add
> > xyzzy magic").  There is no reason to propagate the description of
> > your magic-xyzzy topic to the description of shared magic branch
> > when you push, as this merge commit already records what the branch
> > that was merged was about.
> >
> > So you could modify "git push" to set the branch description when
> > you push to create a branch remotely, but in general, "git push"
> > should not be updating the branch description with the description
> > of your local branch.  This comes as a consequence of the fact that
> > the purpose of the branch in the remote central repository is, more
> > often than not, different from the purpose of the corresponding
> > branch in your repository.
> >

But pulling such into a new branch should copy the description (unless explicitly set)

> > It would conceptually be a lot cleaner to treat updating of remote
> > branch description as a separate "repository management" class of
> > operation, similar to setting the repository description stored in
> > $GIT_DIR/description.


------=_NextPart_000_0041_01CDC262.37350EA0
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
MjExMTQxNzE4NTVaMCMGCSqGSIb3DQEJBDEWBBSt3XcGM53A8RbDuWiM9tT8+fTzITBYBgkqhkiG
9w0BCQ8xSzBJMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0D
AgIBKDAHBgUrDgMCGjAKBggqhkiG9w0CBTBzBgkrBgEEAYI3EAQxZjBkMF0xCzAJBgNVBAYTAlVT
MRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgw
FgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzACAyLbETB1BgsqhkiG9w0BCRACCzFmoGQwXTELMAkGA1UE
BhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQ
S0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMAIDItsRMA0GCSqGSIb3DQEBAQUABIIBAJHcZ/58
tcpKezSo97BYEM0st1XgsdW4MFvdLPfleTeThjB2SxKjTO2fH5AFM0RkbzDP0rqyE8XMDVM43ALa
o9yvCcBsTmoFS3MC5qReeGvPnWe+wSbJUDeLlmi4wjF+Oxh49LGs7nKtwkjmJir0HJ5GudVMM9GD
/lcXphMdqtlgqC56rKJWK2vHssVctqmfD5Vcy6I2VOkHc2/0YDmhFC5bLauMWWYlVsDZoqI8GXoN
X21YCIp4Vn4mthBirRCmxgAbLGgySw9DhHv5qJfXYPwxmzbJS/NeRoS47KfUAY2zWxXHK6t0ofeg
fG4dUWdcOkLaoSFocwW8NfYciE1OuCkAAAAAAAA=

------=_NextPart_000_0041_01CDC262.37350EA0--
