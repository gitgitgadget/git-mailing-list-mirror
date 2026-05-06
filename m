Received: from mailgw02.zimbra-vnc.de (mailgw02.zimbra-vnc.de [148.251.102.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB14329E44
	for <git@vger.kernel.org>; Wed,  6 May 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.102.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070748; cv=none; b=Wgw+a9+U5VAOIwJWzwjq4Us5Rue76zVZCdqIjhzxwn3C5HDMayA3M4b0Ad5Zy7HS4sNPMZcgJGLPofCKmHq7H1NNyjOqzzN37Z4Fv443ejD8JY1YohN22ZCRzHnMQLwQZFvJ8/27OA7zgUvdQL4UTUZGAvdp+S3vxyrhBdkxBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070748; c=relaxed/simple;
	bh=vEGLlo/p4SkSmfSJt4OW6GWaiXemOsov3yCYrMzOyJI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cIjm9623fXIE8hGkx5r9rjTQyTF/dbxPotp1xioR8p7N3D/LdSEeBImWLk/1WGNgY46mtEZHfDpbk+ch9GSPx26Swc0tGLLY91pEwFGN775XdgP1TX3VPVqT/7sJP85SM9PU1l/bigl0Z4g9wXgDV1RfWusLyGMIcTDOHKYxcsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tngtech.com; spf=pass smtp.mailfrom=tngtech.com; dkim=pass (2048-bit key) header.d=tngtech.com header.i=@tngtech.com header.b=KktkYwNf; arc=none smtp.client-ip=148.251.102.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tngtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tngtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tngtech.com header.i=@tngtech.com header.b="KktkYwNf"
Received: from zmproxy.tng.vnc.biz (zimbra-vnc.tngtech.com [35.234.71.156])
	by mailgw02.zimbra-vnc.de (Postfix) with ESMTPS id D0671200C5
	for <git@vger.kernel.org>; Wed,  6 May 2026 14:26:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmproxy.tng.vnc.biz (Postfix) with ESMTP id 9925B1FB1A6
	for <git@vger.kernel.org>; Wed,  6 May 2026 14:26:58 +0200 (CEST)
Received: from zmproxy.tng.vnc.biz ([127.0.0.1])
 by localhost (zmproxy.tng.vnc.biz [127.0.0.1]) (amavis, port 10032)
 with ESMTP id z_s5TzXCbToV for <git@vger.kernel.org>;
 Wed,  6 May 2026 14:26:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmproxy.tng.vnc.biz (Postfix) with ESMTP id 05F301FB1A8
	for <git@vger.kernel.org>; Wed,  6 May 2026 14:26:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmproxy.tng.vnc.biz 05F301FB1A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tngtech.com;
	s=B14491C6-869D-11EB-BB6C-8DD33D883B31; t=1778070418;
	bh=vEGLlo/p4SkSmfSJt4OW6GWaiXemOsov3yCYrMzOyJI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=KktkYwNfh2tPMx0PfkE6TrvY/onQN4JGwK4XqlJwz6Yi4yG4X53opPHi/o99IyqI4
	 LVpStHXaexQK2z+hzvcz1Piec2cz9u8S8CJIzy5Nz/3uYSKKX/Gg+njUrBB6ejK+go
	 LStbngmU+xxlnvyQxTr6xp7N5ELzpbkuEDKtlv7UaAA78NqPRWGOzZxrmR0H/jq/qt
	 wvOIaI9KKknjJfcbqKJ7tuuhAfcF3kI9HynrXYygvFmwW8tLxP+Em68N+ewLOFQ2Rf
	 h9SbYyo9mE8RwKKfXFmUt2JjIeM8mXLphvWsQ+40/4D5kKPN4mB8/84f3v5SU2UgpJ
	 jlvLOYLhTxvYQ==
X-Virus-Scanned: amavis at zmproxy.tng.vnc.biz
Received: from zmproxy.tng.vnc.biz ([127.0.0.1])
 by localhost (zmproxy.tng.vnc.biz [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vP6YDlosDkDb for <git@vger.kernel.org>;
 Wed,  6 May 2026 14:26:57 +0200 (CEST)
Received: from [10.16.210.86] (unknown [193.30.133.7])
	by zmproxy.tng.vnc.biz (Postfix) with ESMTPSA id C86871FB016
	for <git@vger.kernel.org>; Wed,  6 May 2026 14:26:57 +0200 (CEST)
Message-ID: <b46cbce8-d2bb-46d2-bdd3-545422813d6b@tngtech.com>
Date: Wed, 6 May 2026 14:26:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Sven Weiland <sven.weiland@tngtech.com>
Subject: git reflog expire output inconsistency
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tMwYIrUvTZhQh631S2jGilKk"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tMwYIrUvTZhQh631S2jGilKk
Content-Type: multipart/mixed; boundary="------------vX26O9B7yyWmWA6VlJH48yA5";
 protected-headers="v1"
From: Sven Weiland <sven.weiland@tngtech.com>
To: git@vger.kernel.org
Message-ID: <b46cbce8-d2bb-46d2-bdd3-545422813d6b@tngtech.com>
Subject: git reflog expire output inconsistency

--------------vX26O9B7yyWmWA6VlJH48yA5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgbm90aWNlZCBhIHNtYWxsIGluY29uc2lzdGVuY3kgaW4gdGhlIG91dHB1dCBv
ZiB0aGUgZ2l0IHJlZmxvZyBleHBpcmUgDQpjb21tYW5kLg0KDQoNClRoYW5rIHlvdSBmb3Ig
ZmlsbGluZyBvdXQgYSBHaXQgYnVnIHJlcG9ydCENClBsZWFzZSBhbnN3ZXIgdGhlIGZvbGxv
d2luZyBxdWVzdGlvbnMgdG8gaGVscCB1cyB1bmRlcnN0YW5kIHlvdXIgaXNzdWUuDQoNCldo
YXQgZGlkIHlvdSBkbyBiZWZvcmUgdGhlIGJ1ZyBoYXBwZW5lZD8gKFN0ZXBzIHRvIHJlcHJv
ZHVjZSB5b3VyIGlzc3VlKQ0KDQoJMS4gRmlsbCByZWZsb2cgSEVBRCB3aXRoIHNvbWV0aGlu
Zw0KCTIuIGdpdCByZWZsb2cgZXhwaXJlIC0tdmVyYm9zZSAtLWV4cGlyZT1ub3cgLS1kcnkt
cnVuIEhFQUQNCg0KV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBi
ZWhhdmlvcikNCg0KCXdvdWxkIHBydW5lIGNoZWNrb3V0OiA8c29tZXRoaW5nPg0KDQpXaGF0
IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpDQoNCglwcnVuZSBjaGVja291
dDogPHNvbWV0aGluZz4NCg0KV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4
cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPw0KDQoJSXQgb21pdHRlZCAid291
bGQgIi4NCg0KQW55dGhpbmcgZWxzZSB5b3Ugd2FudCB0byBhZGQ6DQoNCglJdCdzIGp1c3Qg
YSBsb2dnaW5nIHRoaW5nIHRoZSBiZWhhdmlvciBpcyBhcyBleHBlY3RlZCBmcm9tIHRoZSBk
cnktcnVuLg0KDQpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9mIHRoZSBidWcgcmVwb3J0IGJl
bG93Lg0KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRvIHNoYXJl
Lg0KDQoNCltTeXN0ZW0gSW5mb10NCmdpdCB2ZXJzaW9uOg0KZ2l0IHZlcnNpb24gMi41NC4w
DQpjcHU6IHg4Nl82NA0Kbm8gY29tbWl0IGFzc29jaWF0ZWQgd2l0aCB0aGlzIGJ1aWxkDQpz
aXplb2YtbG9uZzogOA0Kc2l6ZW9mLXNpemVfdDogOA0Kc2hlbGwtcGF0aDogL2Jpbi9zaA0K
cnVzdDogZGlzYWJsZWQNCmdldHRleHQ6IGVuYWJsZWQNCmxpYmN1cmw6IDguNS4wDQp6bGli
OiAxLjMNClNIQS0xOiBTSEExX0RDDQpTSEEtMjU2OiBTSEEyNTZfQkxLDQpkZWZhdWx0LXJl
Zi1mb3JtYXQ6IGZpbGVzDQpkZWZhdWx0LWhhc2g6IHNoYTENCnVuYW1lOiBMaW51eCA2LjE3
LjAtMTAxNy1vZW0gIzE3LVVidW50dSBTTVAgUFJFRU1QVF9EWU5BTUlDIEZyaSBNYXIgMjcg
DQoxMzo0ODowMyBVVEMgMjAyNiB4ODZfNjQNCmNvbXBpbGVyIGluZm86IGdudWM6IDEzLjMN
CmxpYmMgaW5mbzogZ2xpYmM6IDIuMzkNCiRTSEVMTCAodHlwaWNhbGx5LCBpbnRlcmFjdGl2
ZSBzaGVsbCk6IC91c3IvYmluL3pzaA0KDQoNCltFbmFibGVkIEhvb2tzXQ0KDQo=

--------------vX26O9B7yyWmWA6VlJH48yA5--

--------------tMwYIrUvTZhQh631S2jGilKk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEErnh3SCJFVwW5alt8MzANZZ37INUFAmn7M5EFAwAAAAAACgkQMzANZZ37INWZ
+w//Wo7W/oX034nwYeoHUgxx/aiKXIdwuMn6zhrIucQycXI7HJlWq7MIEyugUEN+Gn4CTzxEergX
e0wsw0Qw7T08NRZjWLM4x5iAcgV5mM+5HgwDlVZhpLyRFAr0POAGvvzVSTfMlCInpgaEQ073O8ph
MbwPscDXjnpBOgbWw+8uln7NWcUtkfzKyk+Eb9EYe9MCcTll/JD/3+GDRqHOKGVPcsYc0JFPYXCB
Rcze3wJSPDqVT0aP96gg6zjzIXKingDOqMySl9dq2t+gz736AC+2dgmtZgKRk7WIZZ6f0S4mx8eV
lqCCK16repFwT6dlXESMvo6tfldSK3MMA54aHCT0iCfXSTjiAoaF5M3MGy7m7pryPAIn6IY5iy/y
yger8Ilso/oSDEGiZ6lPqkTFG19Loj6q87OziQ67AisGmuackpGOxmOFi/l8ztEkSCOrZtBZrma9
PF0en+JyLy2q6zJCCs44qiecMmo4AD4mbQfmHYkZjmzW0p8ogCFQDUAjzeiRyP82UiIkzFw7dxbv
SxD4K0glC4ip48kqXMDVhMRljVGJRj/U0QAsG66I7GEUrxoUx2iN/NRy+Gmdr7vPyTl05BYmr4rP
bTeZNuGLHqOJy15qkT571vlobcuZVr26xzHqFoTkaqprMA1wSwDUFQSTsZcnYpTxH9MAncMTgmf6
0WU=
=B2GO
-----END PGP SIGNATURE-----

--------------tMwYIrUvTZhQh631S2jGilKk--
