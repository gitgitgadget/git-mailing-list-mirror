Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D21F3D29
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281236; cv=none; b=ufAQbnuMOMNzeXZrlymE3QYhNVrkWAAGxKjk2MBVYmd0tKc3jQ0xcPwxrRCptj7z/jWqDFKxonwPkHbRhoCShAEvL+z0ecEIwkNQ0Ba+vnkYwEvltymoVFz6kc9NHKa5hY06MffrqQ++I5E2QD+TloTqRFUv2IFM2/hKg87TrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281236; c=relaxed/simple;
	bh=b4dwMNDh+kg4GD4yYCpF1ez0b/UrMv0v37Qh39TpOiM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GMWPxGhG5teto/injmutexuXVpZQ291kIzn2ndIbCqird4XmXEtEP0T2oX8OmxERdJkwWZZJnLEFejh41z37fq7eP0c/4ioOqMhXQjlFVQje9pwAeERYWJOfFHvQeeZr23zDhO/BDd2KfeEwCz4GdJyK6IjR9iJ+XGAdvikkg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=Bcu7pYgI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OdcQNBuZ; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="Bcu7pYgI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OdcQNBuZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 399451D409D8;
	Tue,  7 Jan 2025 15:20:30 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jan 2025 15:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736281230; x=1736284830; bh=55UMkHESkl
	wyAgnw0NZyU4sheub8itXKw3xVyoPzbM4=; b=Bcu7pYgIASKr9UNtCA+MQJAcgq
	8calZ88Ya+URDdbbZeoRaQIIKt9ClaFHtoIvd8+BUaC5TKZnr+rKTlxYOBDoZhz+
	UkxyedAqoco2bbVH1Eh+LnP1LIv00xeTRJd8Rd6u9/sGh8sW5KRxYubpBKzYVZC8
	lJgQF9CJoAqmga2EH+720W8lihGYUAD2pbdbcEpqhRf5VNf88z1WeNvLOOKXrzNq
	rDSf9B20l5qAMe56c4Uvy56NLFse9iu0kmb0Dqkcvl0XF9edKvMIq12qdwfTn2qM
	sXBJcEZe+Cy/lF0+ppyScjBgIkrOCQrtPNmYNZvJfyzjGqrfpbPUiEqEMEzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736281230; x=1736284830; bh=55UMkHESklwyAgnw0NZyU4sheub8itXKw3x
	VyoPzbM4=; b=OdcQNBuZ1tvPhz3FzVgvc4qwcLAOwzKqmc+BceN/nyucMPG1YKf
	KlP6ilHSeQTs+2eRI+bvRjrJ8p2zurCpZtjUNP3N1GnPn6eQYObls4J+b/VSLu0A
	iYz5XSoyLY4XNxUjQLIKEXEJVXds/Uo6nP+30GjFmkoqKpbi3YuQW1JtfEyzC8CV
	YUNn6gnqG/mz2RaxtevKa9eJGtzDNKH4qfvnF50t0Sti2NorZqTVeF1+TTav9J+x
	btxVnUbjOlQDfQcYLxSXPW3PyT1UXfOx6e0FUSACT2Y+jJQpT+p+YsYoCDG1hEIt
	QbG9hgeX/okX/CfDdXFBuod+Gfa0djSXVNA==
X-ME-Sender: <xms:jYx9Zyytt3db6h98eYeKV0rKbb8D1BHCJZH3WF-EdC4EvsQD5Ohisg>
    <xme:jYx9Z-RfUBOVaCkf_Jpac4XIEGXDCTlWRThIcU4xWCfIBYYkiuiSTLg5FtZSHVoyU
    I4j0-_yrTlk6rSGwf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggtg
    ffkffhvfevuffofhgjsehgtderreertdejnecuhfhrohhmpeforghtvmhjucevvghplhcu
    oehmtggvphhlsegtvghplhdrvghuqeenucggtffrrghtthgvrhhnpedvtdevffejgeehff
    dvudduffelvefhgefhudelffejtdekgfeuudevudelfeevudenucffohhmrghinheptggv
    phhlohhvihdrtgiinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhgtvghplhestggvphhlrdgvuhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jYx9Z0UE8ITaqDwCCaPMkWRqeedcdB7W_vyj5_210a0ztOsXanF1gA>
    <xmx:jYx9Z4g7h0gMNR6m_NjKOPe5HT-rkz1o9x5QkeYGh-qEJtm26WzxGw>
    <xmx:jYx9Z0BNtG7f7701tihV9fZcay7nwLAx6sWooWiTuBGZji0Ou8CQvA>
    <xmx:jYx9Z5IAE1jBP-Oniiyn-bqtxsA1RA6nkY5ZknFP-QZnQyZDReehmQ>
    <xmx:jYx9Z3MR6Go2wfWEex87nrqjxoLtd72gLF9FCH9ph2pat8YU1S2_kWMR>
Feedback-ID: i8c5e488c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3E699B00069; Tue,  7 Jan 2025 15:20:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1818fb6150fa4179bff11dc929ec68a722dbaa030281201945a194f7ac63;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 07 Jan 2025 21:20:28 +0100
Message-Id: <D6W4BSVAQ3VY.1GWVRAIDTBX3W@cepl.eu>
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] RFC: git-request-get maintainer receiving from
 git-request-pull
X-Mailer: aerc 0.18.2
References: <20250107185716.1562311-1-mcepl@cepl.eu>
 <xmqqcygys9e3.fsf@gitster.g>
In-Reply-To: <xmqqcygys9e3.fsf@gitster.g>

--1818fb6150fa4179bff11dc929ec68a722dbaa030281201945a194f7ac63
Content-Type: multipart/mixed;
 boundary=9a14944f76b850a4841d14d839e2be6d80a8453e52cece5afffe7eb7592e

--9a14944f76b850a4841d14d839e2be6d80a8453e52cece5afffe7eb7592e
Content-Type: multipart/alternative;
 boundary=d56279cddc23dc616d4f3318d6f38969a28a092f7e8ca79757f373946b66

--d56279cddc23dc616d4f3318d6f38969a28a092f7e8ca79757f373946b66
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Tue Jan 7, 2025 at 8:37 PM CET, Junio C Hamano wrote:
> There are a handful of scripts written in Perl still in our
> codebase; study the way how their sources are written (e.g., notice
> that they all end with ".perl") and are made into executables by
> Makefile rules, and mimick them.

OK, no shell scripts any more. Got it. I will have to rewrite the
thing, and I will eventually try again.

> Also send the e-mailed patch to yourself, and then run "git am" to
> make sure it applies cleanly.  It seems the patch is creating a new
> Makefile, but our project already has one, so I do not see how this
> patch would apply.

OK, no RFCs any more, just submission-ready contributions. Got it.

See you later!

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@en.osm.town
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
Opportunity is missed by most people because it is dressed in
overalls and looks like work.
  -- Thomas A. Edison


--d56279cddc23dc616d4f3318d6f38969a28a092f7e8ca79757f373946b66--

--9a14944f76b850a4841d14d839e2be6d80a8453e52cece5afffe7eb7592e
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
--9a14944f76b850a4841d14d839e2be6d80a8453e52cece5afffe7eb7592e--

--1818fb6150fa4179bff11dc929ec68a722dbaa030281201945a194f7ac63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGwEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZ32MjA4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErJ4vAJ4jbV8ZRYmOYbRri9G3p7hfaaov/ACeMwDdiFzj
Ow/HP+Z08bvuRY5JmiY=
=HQpb
-----END PGP SIGNATURE-----

--1818fb6150fa4179bff11dc929ec68a722dbaa030281201945a194f7ac63--
