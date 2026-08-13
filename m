Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC83E8354
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644625; cv=none; b=OWb74fesVDpB9AjVM7BsrT4wouwD//j0GTRLdzyyXQiq4luumLh2zsijXat3XRm00dNAfyL6WvOl1nemfXWH7qA8hI5PoryoPVSDmYwafLb8ThRocae0mmCc/yMdUyXVnor3feBIf63MUh6L+XpTXNTz7AS/DdQGu5W1m1ELmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644625; c=relaxed/simple;
	bh=E2rvnrLo8p+twMCRGANU1Sl4KVK0zQwFcB3r2A83oNY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rRnshPBQRR9yfCjHF8opRpB/xFJDLighfI6T3WnyX56o5qhg/EyepOAtygPzfqDmmTo1l91f7iy4ItWZDoDcqE6Aov57AqVTtjNaTqnIy3wR0BOgN9lYf3uYnYGV7MukCIelTzpQ3ggC31kJBQAow0sArtUfSftJQkQf7FkSDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vandenoever.info; spf=pass smtp.mailfrom=vandenoever.info; dkim=pass (2048-bit key) header.d=vandenoever.info header.i=@vandenoever.info header.b=RgSmiR/O; arc=none smtp.client-ip=185.233.34.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vandenoever.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vandenoever.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vandenoever.info header.i=@vandenoever.info header.b="RgSmiR/O"
Received: from smtp.freedom.nl (unknown [10.10.4.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4hLY9K62Sfz1yP2
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 18:02:29 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.107]) by freedom.nl (Postfix) with ESMTPSA id 4hLY9K1jyQz6f
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vandenoever.info;
	s=soverin; t=1786644149;
	bh=E2rvnrLo8p+twMCRGANU1Sl4KVK0zQwFcB3r2A83oNY=;
	h=Date:To:From:Subject:From;
	b=RgSmiR/O87P+hREq4j1Ybs5THNl7nJ3soImwbvkYXx/tng/9g/Q6ClVPAEv+A8+Yd
	 NA2zzVG/cTvWUII5bTfJvMQDjCasV1Qin3purG/zfnHD1HuvSaXEIH3gtenLYnvHGW
	 pnXeK756S2CrxN1L3iQsbOK981Hsd4uXgaOMJy4IVbWuUiHizgWoi3c5FDF8un3gJu
	 Ht5yhh9NZ6ZcV3JkkwvPjwVYrfo6WswQRBHUq1lsZ5Y2urbGjVobudejTh8QCvYppi
	 +oQ9amtSMTZ67KVwZiDk0Fa/9ucfuwo3W7AL/7hDhc8X56kY4Z58Lwjf/hCfXgy2V7
	 tkPnycoqk+tLA==
X-CM-Envelope: MS4xfGp3iHCUZKTcLgFl1c1GTGWapPRKNAelGaAZbfoaG0Yn//d1HPvYntr0lD09Tfm71rAc/UUgwbLqsN6eRtLGnvCOG157/omDH6ouuJDTaPz/JdtmBCxE i6KbwkxqBk+BIbueOHVgxZQJzu2a32D849anEjoUFAwpR+4vv6fI28u9bDrEzf2rhba2+IMUNsjUuA==
X-Soverin-Id: 019ffc4a-3308-7a42-8d5f-a4e4fd7d3375
Message-ID: <40429f46-ff82-4149-8204-2d4ab1925117@vandenoever.info>
Date: Thu, 13 Aug 2026 20:02:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: git@vger.kernel.org
From: Jos van den Oever <jos@vandenoever.info>
Subject: mtime is not restored after --autostash
Autocrypt: addr=jos@vandenoever.info; keydata=
 xsBNBFwQ4hwBCADFkEFg/qiZUFlB7uDcgukPQ0LqYK8JOTnlI6Uiao3SiJxWzXNrPCfMARMi
 TXCBQ14ia4ZOV4frnG0ADfuJVyyzmmxxa9uWDaubhjZsyS6pLY3odvrC91HsJLrPj6TUl0E4
 RnhaqySlsSbOKIutNVOXH83GP14fgE3Py+tRufBUYFW8sgAM9MmafXIwZ1/JmfEm5eGyzQoi
 V2UuJ4BikcF5e/F/TkNXu5/5RjHitXcXJk1i6IvKZU6xES9n+id43QruZUraL9XG1dQ5kdTD
 tQe2Cy0cz8MuD8t3J/ONFVAXm6sc9hk1mijBi2UubNNUcZ5rwNImMKpkqAIgWTfYXQsrABEB
 AAHNKEpvcyB2YW4gZGVuIE9ldmVyIDxqb3NAdmFuZGVub2V2ZXIuaW5mbz7CwI4EEwEIADgW
 IQTQx8CI7+m1GMK4OmI7b7WdyipIFQUCXBDiHAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRA7b7WdyipIFd0vB/4uHKQ+tiiiS/3Q7v5RPxg1dxGgSea9KQxkDaw/AfiwryLfw3Y4
 /L+ocCS+2po4qBHddf/6ZhWOSyBpE6dmxpF1hOOcnjPJzP026rpHw9lYL/GOmhd71jPMj7dx
 FLBeEkE5R6wv/UfLbYdaWLEL0tbVH8Z8zecNrdFRecHd03i3bgSNVVFdv0e5m1IoUY1rHc5Z
 lqDo0vCdefrwjoEDkqUCN+jr1YnQcma9u62hjIuGMbwgCBC8TU0XLTHZXh0F277C/Spq1OU2
 6h2Eqy7AS5/lf8ne543FbWW6nvWTJ7u03mjtpa3jrDm56kBJ+RedClhP+emlAy3mGn2J+/bu
 HinHzsBNBFwQ4hwBCACqpLhWPWHnC37/jIq0v0KvH5N5a7M4uxs2HgpjDmA8QyeolLHnsQ8H
 tY8fGAKSQwIMuqI85lwtbpdkAr/ueeEGmXMhJH4VPFkCJVgp0KNoqPq3sdO58eYUA61g2BTn
 mHe5EaagsVSs2WWwCxDOiojK+vlJHZQx8aHKvfPE5y63dwpjfJuN44o1jXnQTzbDsZGDmHmX
 lWLM2gUEdyZlpHq+AVvvn7EqF5N2l8G5c1qggRTWcuGPi5SlgkLTdRkrDP5riTb4yDRAo3F9
 oub1BcCOngsIthufVvbKo8PaTJBTSD/ORHwqzOSA+uUVPsG6rIe8PHUa/rFQN65vPThy8k35
 ABEBAAHCwHYEGAEIACAWIQTQx8CI7+m1GMK4OmI7b7WdyipIFQUCXBDiHAIbDAAKCRA7b7Wd
 yipIFWeDB/9gUU7SolA+0yTUJGS0edNkmOx52EtjL1q3sv6v+GBEqqqC2TZqoMMz4Ut2eC+V
 AUtvsFY0lCsie6s0pRzpmHbqB7Wr0m+EMRIvuVw+6UyUbd1H17N+SebMa5aOvQK5QwfgHW9d
 MW7WCHUGz9G63KtMemhOBYWtPS0ZN2pYhKIh6VvZ6BmSMxWlmD+pJceAMIZnDOsKgnIla1Y5
 q27HXNVbpXGL6ikVQD6uuVRx56n3B/0PKrpHWs3LuFpgdBC259DnxibUa4Z2WEyQYdYOzf9o
 rALtBeSB72Px5tgv/ZM9Ubva2up9N8cHZQnjk+8hge0GaFFNwqt7VytHXk+CRoUv
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5eU1HkqBQ7aiFvLccjqvB96Y"
X-Spampanel-Class: ham

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5eU1HkqBQ7aiFvLccjqvB96Y
Content-Type: multipart/mixed; boundary="------------AferoRmBY0RvQLPH7kIvJeDn";
 protected-headers="v1"; hp="clear"
Message-ID: <40429f46-ff82-4149-8204-2d4ab1925117@vandenoever.info>
Date: Thu, 13 Aug 2026 20:02:28 +0200
MIME-Version: 1.0
Content-Language: en-US
To: git@vger.kernel.org
From: Jos van den Oever <jos@vandenoever.info>
Subject: mtime is not restored after --autostash
Autocrypt: addr=jos@vandenoever.info; keydata=
 xsBNBFwQ4hwBCADFkEFg/qiZUFlB7uDcgukPQ0LqYK8JOTnlI6Uiao3SiJxWzXNrPCfMARMi
 TXCBQ14ia4ZOV4frnG0ADfuJVyyzmmxxa9uWDaubhjZsyS6pLY3odvrC91HsJLrPj6TUl0E4
 RnhaqySlsSbOKIutNVOXH83GP14fgE3Py+tRufBUYFW8sgAM9MmafXIwZ1/JmfEm5eGyzQoi
 V2UuJ4BikcF5e/F/TkNXu5/5RjHitXcXJk1i6IvKZU6xES9n+id43QruZUraL9XG1dQ5kdTD
 tQe2Cy0cz8MuD8t3J/ONFVAXm6sc9hk1mijBi2UubNNUcZ5rwNImMKpkqAIgWTfYXQsrABEB
 AAHNKEpvcyB2YW4gZGVuIE9ldmVyIDxqb3NAdmFuZGVub2V2ZXIuaW5mbz7CwI4EEwEIADgW
 IQTQx8CI7+m1GMK4OmI7b7WdyipIFQUCXBDiHAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRA7b7WdyipIFd0vB/4uHKQ+tiiiS/3Q7v5RPxg1dxGgSea9KQxkDaw/AfiwryLfw3Y4
 /L+ocCS+2po4qBHddf/6ZhWOSyBpE6dmxpF1hOOcnjPJzP026rpHw9lYL/GOmhd71jPMj7dx
 FLBeEkE5R6wv/UfLbYdaWLEL0tbVH8Z8zecNrdFRecHd03i3bgSNVVFdv0e5m1IoUY1rHc5Z
 lqDo0vCdefrwjoEDkqUCN+jr1YnQcma9u62hjIuGMbwgCBC8TU0XLTHZXh0F277C/Spq1OU2
 6h2Eqy7AS5/lf8ne543FbWW6nvWTJ7u03mjtpa3jrDm56kBJ+RedClhP+emlAy3mGn2J+/bu
 HinHzsBNBFwQ4hwBCACqpLhWPWHnC37/jIq0v0KvH5N5a7M4uxs2HgpjDmA8QyeolLHnsQ8H
 tY8fGAKSQwIMuqI85lwtbpdkAr/ueeEGmXMhJH4VPFkCJVgp0KNoqPq3sdO58eYUA61g2BTn
 mHe5EaagsVSs2WWwCxDOiojK+vlJHZQx8aHKvfPE5y63dwpjfJuN44o1jXnQTzbDsZGDmHmX
 lWLM2gUEdyZlpHq+AVvvn7EqF5N2l8G5c1qggRTWcuGPi5SlgkLTdRkrDP5riTb4yDRAo3F9
 oub1BcCOngsIthufVvbKo8PaTJBTSD/ORHwqzOSA+uUVPsG6rIe8PHUa/rFQN65vPThy8k35
 ABEBAAHCwHYEGAEIACAWIQTQx8CI7+m1GMK4OmI7b7WdyipIFQUCXBDiHAIbDAAKCRA7b7Wd
 yipIFWeDB/9gUU7SolA+0yTUJGS0edNkmOx52EtjL1q3sv6v+GBEqqqC2TZqoMMz4Ut2eC+V
 AUtvsFY0lCsie6s0pRzpmHbqB7Wr0m+EMRIvuVw+6UyUbd1H17N+SebMa5aOvQK5QwfgHW9d
 MW7WCHUGz9G63KtMemhOBYWtPS0ZN2pYhKIh6VvZ6BmSMxWlmD+pJceAMIZnDOsKgnIla1Y5
 q27HXNVbpXGL6ikVQD6uuVRx56n3B/0PKrpHWs3LuFpgdBC259DnxibUa4Z2WEyQYdYOzf9o
 rALtBeSB72Px5tgv/ZM9Ubva2up9N8cHZQnjk+8hge0GaFFNwqt7VytHXk+CRoUv

--------------AferoRmBY0RvQLPH7kIvJeDn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

RGVhciBnaXQgZGV2ZWxvcGVycywNCg0KV2hlbiBnaXQgcHVsbCwgbWVyZ2UsIGFuZCByZWJh
c2UgYXJlIHVzZWQgd2l0aCAtLWF1dG9zdGFzaCBhbmQgbW9kaWZ5IA0KdGhlIGN1cnJlbnQg
d29ya2luZyBkaXJlY3RvcnksIHRoZSBtdGltZSBvZiBmaWxlcyB0aGF0IGFyZSByZXN0b3Jl
ZCANCihzdGFzaCBhcHBseSkgYXJlIHNldCB0byB0aGUgY3VycmVudCB0aW1lLCBldmVuIHdo
ZW4gdGhlIGZpbGVzIGhhdmUgbm90IA0KY2hhbmdlZC4NCg0KSW4gbXkgdW5kZXJzdGFuZGlu
ZywgZ2l0IHVzdWFsbHkgZG9lcyBub3RoaW5nIHRvIHRoZSBtdGltZSBvZiBmaWxlcyBzbyAN
CnRoZWlyIG10aW1lIGlzIHNldCB0byB0aGUgY3VycmVudCB0aW1lIHdoZW4gdGhleSBhcmUg
d3JpdHRlbiBpbnN0ZWFkIG9mIA0KZS5nLiB0aGUgbXRpbWUgb2YgdGhlIGNvbW1pdCBkYXRl
IHRoYXQgaXMgY2hlY2tlZCBvdXQuIFRoaXMgZW5zdXJlcyB0aGF0IA0KYnVpbGQgc3lzdGVt
cyB3aWxsIHJ1biBhY3Rpb25zIGZvciB3aGljaCB0aGUgY2hhbmdlZCBmaWxlIGlzIGFuIGlu
cHV0Lg0KDQpXaGVuIHVzaW5nIC0tYXV0b3N0YXNoIHRoZXJlIGlzIHRoZSBvcHBvcnR1bml0
eSB0byByZXN0b3JlIHRoZSBtdGltZSANCnRoYXQgdGhlIGRpcnR5IGZpbGUgaGFkIGJlZm9y
ZSB0aGUgZ2l0IGNvbW1hbmQuIFRoaXMgY2FuIHNhdmUgYSBsb3Qgb2YgDQp3b3JrIGZvciB0
aGUgYnVpbGQgc3lzdGVtLg0KDQpUaGVyZSBpcyBhbm90aGVyIHVzZSBjYXNlIHdoZXJlIHJl
c3RvcmluZyB0aGUgbXRpbWUgaXMgdXNlZnVsOiB1c2luZyBnaXQgDQpmb3IgdW5hdHRlbmRl
ZCBzeW5jaW5nIG9mIGZpbGVzLiBBIHN5c3RlbSB0aGF0IGNoZWNrcyBpbiBmaWxlcyANCmF1
dG9tYXRpY2FsbHksIGFmdGVyIGEgY29vbGluZyBvZmYgcGVyaW9kLCBjb3VsZCB1c2UgdGhl
IG10aW1lIGFzIHRoZSANCmF1dGhvciBkYXRlIG9mIHRoZSBjb21taXQuIElmIC0tYXV0b3N0
YXNoIGNoYW5nZXMgdGhlIG10aW1lLCB0aGF0IGRhdGUgDQppcyB3cm9uZy4gU3VjaCBhIHN5
c3RlbSBjb3VsZCB3b3JrIGFyb3VuZCB0aGlzIGJ5IGtlZXBpbmcgdHJhY2sgb2YgdGhlIA0K
bXRpbWVzIG9mIGRpcnR5IGFuZCBuZXcgZmlsZXMgYW5kIHJlc3RvcmluZyB0aGVtIGl0c2Vs
ZiBpbnN0ZWFkIG9mIA0KcmVseWluZyBvbiAtLWF1dG9zdGFzaCB0byBkbyBzby4NCg0KQmVz
dCByZWdhcmRzLA0KSm9zIHZhbiBkZW4gT2V2ZXINCg0K

--------------AferoRmBY0RvQLPH7kIvJeDn--

--------------5eU1HkqBQ7aiFvLccjqvB96Y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE0MfAiO/ptRjCuDpiO2+1ncoqSBUFAmp+BrQACgkQO2+1ncoq
SBW9Mgf+IDPiVTaw9QMzQsbfxFWorOaR2jJIYxikoUvXBQNn98uwKgU482wk/UbV
i3M51w9/XZs3/qLhXxo4BSuihxBiuoG7hwA5FTigf+8oYx0ev4T2XysFuXm08Bub
OPa8u0MKPI29IWQ5hkD3Da5UevbBDZenqLE2f4FdufFf9H+UgkK+iJYtLEhEwKdX
HkOZTOHPviItdCofMc/u8GXPEXQYAXJlloHYzRCTO5SMiICz7Eye57q20BaKrHKs
R2rgwZGHwh46DKf9qmbT8oAm9NDgtbUPTDfYhYVgMWGb1u7ILIhfEMT4fix8CLjz
XiKSRe6cz3K2OSZqnRGXIsQM2mwqeQ==
=fREa
-----END PGP SIGNATURE-----

--------------5eU1HkqBQ7aiFvLccjqvB96Y--
