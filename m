Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A77826A1B8
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892075; cv=none; b=NWUJ1RG8N2wUgM/bi8Aciw1r9u7tbMzHgLjTv+Dp9NCtqWNqAdPvkxzXU3yW8kI8TrSpAt+LeXyV4mUq7G/x86UJQWLlBfPtdJrD6tRtTuYHVfFUrbuAjcbb6hFmL/nF2AKHcPg6JU8GJfvATYf9ZTKQLD9hsUfaHRNo8GP8tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892075; c=relaxed/simple;
	bh=V6k3WPQypw7eX4FfpqJZTaxxHaHXt9GnwrwhF5she44=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=bpHjb/qPumGwrltSHGuiIyKr6AIVoqt4CeluKEZB78tjbup/9HuubUQVFej2RQfXuylfJ7dB8gDnwftVWxRmPOW6rm6kQiYGwTLhrgdgOVqevRJR+RYMvzdaO2t2Rwc04blTAMAyhcizQ94FpZsVAWtTkdOjjUa62UMeebNBgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=YTKgbCaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vD403Eov; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="YTKgbCaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vD403Eov"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EE1601380871;
	Tue, 18 Feb 2025 10:21:09 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-11.internal (MEProxy); Tue, 18 Feb 2025 10:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739892069; x=1739978469; bh=08IOtRVt+u
	2dOwrV1/inlhSoWHjh3MuQBqDMILgOpHM=; b=YTKgbCaOn1KuoGEsQE5o3LSX3P
	CxSeY5V43tdUrg2JrUXM50mGighXVNk+ge9UdC7VR5Zulgz682Ujm5O2h5O9TkGB
	d4xP47ExoE6dHp4o0Hq9tNSg+SeSyGorR5u/qbQ2dGoK6fJvH8Xd8oCUXXzB8ZWP
	PEHZot1PK54b/TpmKpor6hhn4wBAKGx44Nr0w6hwnrqLu146kxAS1v6xwQJeQlnn
	/2Y8JYhVWtX6SSXVqgaJjCAPbp3hnrXWsS3JzrY7qYNdH7Ie5KZGEQDNbqVPkJeH
	lXiiyi5ndJjFCAAa0HCMePcanDwPm4/5jCPbgMac8pIUktG0kmiOBFbMZ89w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739892069; x=1739978469; bh=08IOtRVt+u2dOwrV1/inlhSoWHjh3MuQBqD
	MILgOpHM=; b=vD403Eovi5BIwrJJwLQkGz10wjtYE1K4oaGUUAnObKFXOZMVE3N
	jQb343GrdRZlzF+Mlm2pX1xIsNvdgXCz51eiqRxW4BaxVCyydOP26b73ErRNCtnO
	sig6nA8N9xVmXuU569OfS3Z0zHUmPloL1voexmFhXKEH3JUZaam22HjaiF71JU8z
	Yl+2VUpLqlEYQdQL0xyvyKIdWQuLAu1HwSCKJTF0Mmbf3bD2UIKJYdLgMjzYx77/
	CbGGblZsRwuzi0RPquCWj2KHUgJQk7rmrH0E4V/PhD6avyW/HLsoe4WzzLbkxEwA
	ptpzH21VhK7vkaqwowzP6ArD59D9S2oDqlg==
X-ME-Sender: <xms:ZKW0Z5n5YmfvryPaebyK0YtKtk9E8bW95uW9B5nhoRpHGMTCYYGv7g>
    <xme:ZKW0Z03YZQAhlH7SE5XMdbLHMpLAcRh2euYLr6ZZzMDwc0wiEJE8jaHXiJX1u1OjP
    oSbAFIsG5zi606WoIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefogggtfffkvfevuffhofhfjgesghdtreerredt
    jeenucfhrhhomhepofgrthmvjhcuvegvphhluceomhgtvghplhestggvphhlrdgvuheqne
    cuggftrfgrthhtvghrnhepvdelvdeljeelledtieeifeffveeufedttdevudfhudegudef
    jeeutedvgfehiefhnecuffhomhgrihhnpegtvghplhhovhhirdgtiienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmtggvphhlsegtvghplhdr
    vghupdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:ZKW0Z_qeDtDxA1n8LAfmvIHQbCeiOxnEB8jgPD-lZPwIEsq05zB6RQ>
    <xmx:ZKW0Z5m4aViEUlkp1nhHP2Eo7NPLF05S_vBCWRcKNMgJSJR_1Xne3A>
    <xmx:ZKW0Z33TLLja9wnqqj5_70zrzuLm_IZtZCuoE_8VO5SNnj65VSe7Qw>
    <xmx:ZKW0Z4v2Oo8cWh74rBk3M3NpoFaObjadiWpHhlrzubv3VkvGe6_0WA>
    <xmx:ZaW0Zw_eu9-pxT-emVTgJjs60NOLh9Xk2c70TTbJf1YtzO5QNzkLuNUp>
Feedback-ID: i8c5e488c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D0377B00069; Tue, 18 Feb 2025 10:21:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e4f6d588f5ba050f8c1d0e5ab14eab3a523bdb1ea5f63c6882debcac61bc;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 18 Feb 2025 16:21:06 +0100
Message-Id: <D7VO9H4A9DMN.JK0CKJNDX3XZ@cepl.eu>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc(send-email): use correct name of the
 --signed-off-by-cc in git send-email doc
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
X-Mailer: aerc 0.20.1
References: <20250218085913.1381537-1-mcepl@cepl.eu>
 <Z7RtXXsDRxuEqCgC@pks.im>
In-Reply-To: <Z7RtXXsDRxuEqCgC@pks.im>

--e4f6d588f5ba050f8c1d0e5ab14eab3a523bdb1ea5f63c6882debcac61bc
Content-Type: multipart/mixed;
 boundary=878eea0737b522495a4f78980d47087427ab485ea9fadb0f88dc50a8a580

--878eea0737b522495a4f78980d47087427ab485ea9fadb0f88dc50a8a580
Content-Type: multipart/alternative;
 boundary=3e66d7a0a7741c5f5155cd148cec20f9b655ac9315395dc09468ea1cc7f7

--3e66d7a0a7741c5f5155cd148cec20f9b655ac9315395dc09468ea1cc7f7
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Tue Feb 18, 2025 at 12:25 PM CET, Patrick Steinhardt wrote:
> I know, we're quite pedantic about commit messages over here, but please
> bear with us :) How about this instead:

No, I don=E2=80=99t think you are and I don=E2=80=99t think I will. There a=
re no
rules, there are people who are in and can do whatever they want
to do and anybody who dares to contribute for the first time is
needlessly harrassed. See this:

mitmanek:git (git-send-email-manpage-fix) $ git log --oneline --follow Docu=
mentation/git-send-email.adoc |head
f18690968f doc(send-email): use correct name of the --signed-off-by-cc in g=
it send-email doc
1f010d6bdf doc: use .adoc extension for AsciiDoc files
7ffcbafbf3 send-email: document --mailmap and associated configuration
c038a6f1d7 send-email: teach git send-email option to translate aliases
0620ae0f5b doc: format alternatives in synopsis
82d75402d5 documentation: send-email: use camel case consistently
2162f9f6f8 doc: enforce dashes in placeholders
d05b08cd52 doc: switch links to https
3ec6167567 send-email: handle to/cc/bcc from --compose message
e0c7e2c326 doc/send-email: mention handling of "reply-to" with --compose
cf6cac2005 documentation: wording improvements
ba92106e93 send-email: add --header-cmd, --no-header-cmd options
839ebad442 send-email docs: Remove mention of discontinued gmail feature
ba4324c4e1 e-mail workflow: Message-ID is spelled with ID in both capital l=
etters
a2634646eb docs: git-send-email: difference between ssl and tls smtp-encryp=
tion
bac1d52cfe send-email docs: de-duplicate configuration sections
a2ce608244 send-email docs: add format-patch options
cd5b33fbdc git-send-email: add option to specify sendmail command
155067ab4f git-send-email.txt: mention less secure app access with Gmail
3abd4a67d9 Documentation: stylistically normalize references to Signed-off-=
by:
mitmanek:git (git-send-email-manpage-fix) $=20

This is not being pedantic about anything. And all that in the
email-driven project, where changing the patch before applying
is absolutely no problem whatsoever. And all that harassment for
three character change.

This harassment and complete NIH-syndrom ruling everything (git
is the only project I have met so far, which didn=E2=80=99t settle on
the vaguely K&R style for shell scripting, but why not to pester
newbies with need to have specific settings in everything just
for this one project, right?) leads me to abandoning this and
couple of other attempts to contribute. Of course, accepting
conventional commits (the only real standard in commit messages I
know about) is beneath your station in life.

Have a nice day,

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@en.osm.town
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
Afraid to die alone?
Become a bus driver.
  -- alleged easter egg in notepad++


--3e66d7a0a7741c5f5155cd148cec20f9b655ac9315395dc09468ea1cc7f7--

--878eea0737b522495a4f78980d47087427ab485ea9fadb0f88dc50a8a580
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=E09FEF25D96484AC.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUdpQkQyZzVUMFJCQUNaZG5H
LzlUNEpTMm1seHNIZUZiZXgxS1d3ZUtQdVlUcG5idThGZTdyTllNV1ovQUtjCjlWbStSdW9WRXJt
NEhHc2IwcEw1WlBubmNBK204MFc4RXpRbTJyczhQRDJtSE5zVWhET0duayswZm0rMjVXU1UKNllM
emQ4bHR0eFBpYTc1QTVPcUJFQW1KbHlKVVNtb1dLakFLL3ExVGo1SFczKy83WHFXWVlDSnpBd0Nn
alIyRAppcnc4UVA4R0NvVVVYeGVOcElPVHF6TUQvajY2VlRsbityeFlUMTJVNGp4TGxzT3M1WTBM
VlFmVWJwREZFWXk5Cm1rV1g4aU5UVVpzeCttNnVoeWxhbW0zRWtOL2RXMGIyc1E0RDNvY1pla3Jp
TFBEUi9YMFAxWFBVZGN5MjhhNm8KV1pvVkFLTjI2WCtQd3hTcTNKQ2lRRUpnUEplS3hpTGlFeGgz
bERpdE55QVMwV1VEL3hRT3FyeUVGYjlrc0d4TApSOVVDQS85V1VRTXdnUXZFVWh1VkI3cVNuUkVv
MytrczM0S2x0cDcxdVVqdU1qTGszeWtTcHR5bjhvVitYWmd4CnJ4UEFEK1dPSm41MXlGeGJvK09Q
TmRINndHMlphWEZqNDdyWDZHUTlXNndJN0swUWhkeVFUcHM4S05sc0p1RFEKcHo3WE1FOThvYjhT
c3pzdmtQUG0vZ1gwb1dkT0lxSGlwSG5NbEw2ODRqUkhDV0hWanJRZFRXRjBaV29nUTJWdwpiQ0E4
YldGMFpXcEFZMlZ3Ykc5MmFTNWplajZJWUFRVEVRSUFJQUllQVFJWGdBSVpBUVVDUlNvV0FnWUxD
UWdICkF3SUVGUUlJQXdRV0FnTUJBQW9KRU9DZjd5WFpaSVNzcjVzQW9JQXFzTmNzMVNsOWpybXF2
N3ZKekw0UUc2OFYKQUo5KzMwTm1CQ2xRd3BtcW5BMjZuQ2E0K1dTNWFiUWJUV0YwWldvZ1EyVndi
Q0E4WTJWd2JDNXRRRzVsZFM1bApaSFUraUdBRUV4RUNBQ0FDR3dNQ0hnRUNGNEFGQWtVcUZna0dD
d2tJQndNQ0JCVUNDQU1FRmdJREFRQUtDUkRnCm4rOGwyV1NFckFVTEFKb0M4eXJwdE9nb29KT3pM
em1MeERjMW16ZUdEQUNkRkJ3Wmx2RmNqMVQyZG1DUk5kbjUKY0VyUnlCZTBHMDFoZE1TYmFpQkRa
WEJzSUR4dFkyVndiRUJqWlhCc0xtVjFQb2hpQkJNUkFnQWlCUUpRaXhwdwpBaHNEQmdzSkNBY0RB
Z1lWQ0FJSkNnc0VGZ0lEQVFJZUFRSVhnQUFLQ1JEZ24rOGwyV1NFckJNWUFKOWVRRXBpCmJMNlZt
N3NVT2h1cHhEL1VzSGlXbFFDZEhZaStVTnB6QzFtS1l0RFNXYTFvY2ZPMVE3NjBIRTFoZEdWcUlF
TmwKY0d3Z1BHTmxjR3h0UUhObGVtNWhiUzVqZWo2SVlBUVRFUUlBSUFJYkF3SWVBUUlYZ0FVQ1JT
b1dDUVlMQ1FnSApBd0lFRlFJSUF3UVdBZ01CQUFvSkVPQ2Y3eVhaWklTc1AxNEFuaTZVODdoU1VY
RFUrM1pUYURSWEl3YXNUdHRsCkFKMFFXaGpTbWFKVGRra3BmcW1SQjliUmk5cEFRYlFmVFdGMHhK
dHFJRU5sY0d3Z1BHTmxjR3hBYzNWeVptSmwKYzNRdWJtVjBQb2hnQkJNUkFnQWdBaHNEQWg0QkFo
ZUFCUUpGS2hZSkJnc0pDQWNEQWdRVkFnZ0RCQllDQXdFQQpDZ2tRNEovdkpkbGtoS3dCQndDYkJP
b1RZNTJoWWVLbkt1VS91UmpPVHNVTWczSUFualRUclhZSEQ0OXh5THM4ClQvVnBzdWs2WlAvaHRD
Rk5ZWFJsYWlCRFpYQnNJRHh0WVhSbGFpNWpaWEJzUUdkdFlXbHNMbU52YlQ2SVlBUVQKRVFJQUlB
SWJBd0llQVFJWGdBVUNSU29XQ1FZTENRZ0hBd0lFRlFJSUF3UVdBZ01CQUFvSkVPQ2Y3eVhaWklT
cwpraTBBbjBHdzFNalpKQVR0VnExMVN1MG1qZDNyRFFDaEFKMGVlUEUwYW1Td1lWR1NwU05iMjY0
K1hqVW90clFzClRXRjBaV29nUTJWd2JDQW9VbVZrU0dGMElFTjZaV05vS1NBOGJXTmxjR3hBY21W
a2FHRjBMbU52YlQ2SVlBUVQKRVFJQUlBVUNSU3ljaXdJYkF3WUxDUWdIQXdJRUZRSUlBd1FXQWdN
QkFoNEJBaGVBQUFvSkVPQ2Y3eVhaWklTcwpieVFBbmlxdzFQWDI0QmxiQkQyMnpOcVl3emZJUERo
d0FKNG0vM3l0dUp6c2Z4ckVhYzF0U29FYjIrSDl2clE1ClRXRjBaV29nUTJWd2JDQThZMlZ3YkMx
YVR6UkdNRXR1YlVORVNHc3hkVTFLVTBKclVXMVJRSEIxWW14cFl5NW4KYldGdVpTNXZjbWMraUdB
RUV4RUNBQ0FDR3dNQ0hnRUNGNEFGQWtVcUZna0dDd2tJQndNQ0JCVUNDQU1FRmdJRApBUUFLQ1JE
Z24rOGwyV1NFckFuOUFKOWJPME5VcUxuTURUQ2NjaHRWeks2eUVPTGtDZ0NmWHdrdHkxdUVBelFJ
CjVrdDlHZWM4eVFweERsaTBHazFoZEdWcUlFTmxjR3dnUEcxalpYQnNRSE4xYzJVdVpHVStpR01F
RXhFQ0FDTUYKQWxyNjVDc0NHd01IQ3drSUJ3TUNBUVlWQ0FJSkNnc0VGZ0lEQVFJZUFRSVhnQUFL
Q1JEZ24rOGwyV1NFckhqTwpBSjQ3eUY5U1RYL0VzNHFzSlBqVzk2MUhlOUgzYmdDZEVzak9ndDdj
ekU4N0d5MEQxS1hXV05UZFR0VzBHMDFoCmRHVnFJRU5sY0d3Z1BHMWpaWEJzUUhOMWMyVXVZMjl0
UG9oakJCTVJBZ0FqQlFKYSt1US9BaHNEQndzSkNBY0QKQWdFR0ZRZ0NDUW9MQkJZQ0F3RUNIZ0VD
RjRBQUNna1E0Si92SmRsa2hLd3NRUUNkR21HWFc3M082UTNUQjBWMAp4UDl5THdNakR0RUFuaktX
RFc4UEtPOTBueDhJa1BvZHhyMW5DdkpidEJwTllYUmxhaUJEWlhCc0lEeHRZMlZ3CmJFQnpkWE5s
TG1ONlBvaGpCQk1SQWdBakJRSmErdVJQQWhzREJ3c0pDQWNEQWdFR0ZRZ0NDUW9MQkJZQ0F3RUMK
SGdFQ0Y0QUFDZ2tRNEovdkpkbGtoS3lLdFFDZEhEcG9sSGcvMXFEYXcvNENReVV6QWZOdkhrMEFu
aUVZTDZCRgpyZHlvbmhnUWYvWlh6WGpuS3pTZXVRRU5CRDJnNVVFUUJBQ2Z4b3oybm16R0p6NnVl
S0hrVGVYY1Fadks0V3pLClROL3VKSmhFbVN1UW1PS3ltYklrR0w2dkJRYitXNEt4dkxsMmxBYk5s
ZklnTEdETENzMVlBd2ZTcEo0dlM0bXQKbGlQZ0EyT3RaNWoxV1NPcXB4ZWRRUEdWYmE1Z1ZvN0hO
U09NVXRaS1R6N1ZzQ3ZSOTR2MDVjb21oTzFHb2s3NQpaeEh0WXlWSHVrNVY4d0FEQlFQL2Z0K1c0
RjB0Y2N3c2x6ejhPL2M5L01qOEtaRFltZk15TmI3aWVsVDJXZVEzCmlGRjlBeE1UNk92T3hBUWJE
SnZ1cmZLZVlseWRjWExzNmN5NGxLY2UxaEZhSjRpK01PRkxWVjFablpERENoUlAKcFE2S3JSQ0hM
YittTFkrU1lEMzdPN3Awc3BRQSs5Z3NFRS90bW4rNXNXN0xFOGhxU09vUFZkZjdZNXlVRGo2SQpS
Z1FZRVFJQUJnVUNQYURsUVFBS0NSRGduKzhsMldTRXJFVVNBSjQyVDFsLzJURnlrYlVMQnFxQXRu
YkM2a1IwCnd3Q2RFblJsQ0dsdm5PNzhSMEZnS1hsdDNSeXpHdUU9Cj1zeG9XCi0tLS0tRU5EIFBH
UCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
--878eea0737b522495a4f78980d47087427ab485ea9fadb0f88dc50a8a580--

--e4f6d588f5ba050f8c1d0e5ab14eab3a523bdb1ea5f63c6882debcac61bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGsEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZ7SlYg4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErP9sAJID/rzwUu0T8bGHIL7HeINEoVVsAJ4+h+XRHj8o
ZMW2dOMSUbXwvWBbnw==
=5eO8
-----END PGP SIGNATURE-----

--e4f6d588f5ba050f8c1d0e5ab14eab3a523bdb1ea5f63c6882debcac61bc--
