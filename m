Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372A823DD
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742036; cv=none; b=JJ5DfDg39RBeOh/U9Y/QzsMQ7+oJdyIlS3wIA42MvbVEmfa6DsC9IDo16aX4/3hPUbVHhsWQaayVbmVIY2RmoKDpBFtXAkp+Rw1I89fTiaCbEScxNvhd5av+UbokIaWm6be+rTb8bZRtmcDCvftGUrTl12j4KHrBuUUF2fZLTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742036; c=relaxed/simple;
	bh=E4hBFIP8fYnAOWrx/W8L5d8s2dCnig+S3tm1seZ0sXA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BxE/K/5Fk/ZsvcwwHT8RsDsAz/RJIY0XsKDPzF4qRW5zZgH5ufcDI1bZdHR+tDj2hpG9iH2IM3qbUiB8+2BXPMhUt00l+RzfsyUe6N8b8aitWlt0aIXCT7V+5eJOnsU6ylSelUXUNgEwTbqdb88jOTEc1c2/Ec2wRreW4dnaF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embecosm.com; spf=pass smtp.mailfrom=embecosm.com; dkim=pass (2048-bit key) header.d=embecosm.com header.i=@embecosm.com header.b=X+NONaMx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embecosm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embecosm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embecosm.com header.i=@embecosm.com header.b="X+NONaMx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso34293585e9.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google; t=1759742032; x=1760346832; darn=vger.kernel.org;
        h=in-reply-to:organization:autocrypt:from:reply-to:content-language
         :subject:references:cc:to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4hBFIP8fYnAOWrx/W8L5d8s2dCnig+S3tm1seZ0sXA=;
        b=X+NONaMxpLHaVqQgChMxXQUG4bdP6D0+Xsut4naNMn/9evR07wTAp9tQ4aEWsP02XE
         r67+1CWWwynOH+ahyZLYz2OiC2LqWtRe4CilExV4Wzxj2So89MIrBn2W+qGvhP+6V4zi
         AvsKmYO5XllJGDi0An9Y2fEFgnt+pzeFRstoo/N4es6/SgHbigdOJzfziYQLh8LgTwO1
         b206Rly3uVpgclIq/GLMcC2/4ErGD7tSihsK2JMUieStM3NeA0fFdejdlF37BkUsaMPd
         kD5BJtHAyhm0AfjXVsx71jBMcIRZDngXOXshC1EX8yZCExuIK+CVU8kI3DGqyaUvte4v
         f0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742032; x=1760346832;
        h=in-reply-to:organization:autocrypt:from:reply-to:content-language
         :subject:references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4hBFIP8fYnAOWrx/W8L5d8s2dCnig+S3tm1seZ0sXA=;
        b=blQY61qxqPzSRoiAQp4kbus/tQ7QfR7kfr20BpcqdP0obLEHPQIc4N2RznOSBB7C0C
         bxrxiMv78vDCUhu7/6+1yzSR6rCrT7OO0JxU01AnmuVXYxkyzg863BlsJFiDUffX8Bjo
         V53tb4xyo4QSdb2ItfzR2nIXjh3kRu+ARd0Saur2NSXkiVlh5zjzyFRN19WeHah4PUFr
         naOuRtkCAuq/oZScs4L6u+vYvMSM34qskE6WvqziIqqnegdoxQCGNaTcKOo59x+HegQS
         4h0+pb9zcvn0EQztEIRCLHTFlRzpoG3zm/Zk1kv29pXg4N4jYPt3ekbTTwOc+Ytxrdq7
         WS6A==
X-Forwarded-Encrypted: i=1; AJvYcCXVJCLor3vPUSIjMoGxFBRP2OKfG95i619wtP0r6s2uxC7W883MAvhP4ThN/h38amWlY9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWvXzbneMvswOrjiY+dGnyzlEHoxhH7nyLf/WgHrMVmjxQb71
	0F3x2fQoKbraWPBKh2jKMHK980ezW8fBq2BQTNehCpgOBuKcQh58EiRb07L4bRMu4/s=
X-Gm-Gg: ASbGnctk0yd7V1+FXX45mbS9ndr/lXgPqukDdw9yGl6VtHUcyb/PvW8tmN16rTpqIYO
	wpV2NrGtUuNC3ZmjtJMKXZ9oBPTpTayUxUBYKmhknDfUYTJqJw1ItR6s6pXLGOYwLGkOeO/+YdQ
	JLyVuzIzr/0WDDzlPHMGGCMN6h5Il9MTqkSzRrfGjLv4+NyPaq1jsQg8e0T3WbNICBmyHjrvuDq
	70xRn7E4DDr2oTF6Vo6IeUfKY0why0RqgQQTnGBbzRcQmFwW6LVsCoMsGH3VJ8OVntRMxPutjUr
	S771pZy2DhQQ1oTlAut59P+7iBLhUfU68FDu/VJsHG6Yn74utRpcZtMH6tYqLltEOyPkSz2igNP
	3nD3IqvXAZ5k2DIvqn5njHnju2kh7mXSctN4D3rPw9dMy8HLCNoALnQkm5/A+XIQay21+eoWyoi
	pfU/WwsjBc+iQ7pQwBdhVM17a3COHb2MYcmgx0gQ2vEjEOkw==
X-Google-Smtp-Source: AGHT+IH1m7jHs48lCSKYtf9I7dvZZhi3v286eKsjIKA+/8zMTRs6uPbS8QFpeG1B2irGFP4Q/gR5cQ==
X-Received: by 2002:a05:600c:4e47:b0:45d:f7df:2735 with SMTP id 5b1f17b1804b1-46e70cac322mr79152875e9.16.1759742032288;
        Mon, 06 Oct 2025 02:13:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1f0:96b0:2863:44c4:9edc:7fe6? ([2a01:e0a:1f0:96b0:2863:44c4:9edc:7fe6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723593d8sm163804345e9.11.2025.10.06.02.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:13:51 -0700 (PDT)
Message-ID: <9eea6006-1dfb-4822-adfc-3af1222b1e01@embecosm.com>
Date: Mon, 6 Oct 2025 11:13:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: e@80x24.org
Cc: Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org,
 collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org,
 ezekielnewren@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, newren@gmail.com,
 phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com, ps@pks.im,
 sam@gentoo.org, sandals@crustytoothpaste.net
References: <20251004010201.M85772@dcvr>
Subject: Re: what's missing from newer C? [was: [PATCH v5 0/9] Introduce Rust
 ....]
Content-Language: en-US
Reply-To: 20251004010201.M85772@dcvr
From: Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>
Autocrypt: addr=pierre-emmanuel.patry@embecosm.com; keydata=
 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
Organization: Embecosm
In-Reply-To: <20251004010201.M85772@dcvr>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RQ8ma2U3hEuLpstznCxK9DrO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RQ8ma2U3hEuLpstznCxK9DrO
Content-Type: multipart/mixed; boundary="------------iWnxa0INyU9badZk57qgCkOw";
 protected-headers="v1"
From: Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>
Reply-To: 20251004010201.M85772@dcvr
To: e@80x24.org
Cc: Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org,
 collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org,
 ezekielnewren@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, newren@gmail.com,
 phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com, ps@pks.im,
 sam@gentoo.org, sandals@crustytoothpaste.net
Message-ID: <9eea6006-1dfb-4822-adfc-3af1222b1e01@embecosm.com>
Subject: Re: what's missing from newer C? [was: [PATCH v5 0/9] Introduce Rust
 ....]
References: <20251004010201.M85772@dcvr>
In-Reply-To: <20251004010201.M85772@dcvr>

--------------iWnxa0INyU9badZk57qgCkOw
Content-Type: multipart/mixed; boundary="------------KmYuXDji0Paa6uhZgMv0MLrq"

--------------KmYuXDji0Paa6uhZgMv0MLrq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBBcyBJIHVuZGVyc3RhbmQgaXQsIHRoZSBib3Jyb3cgY2hlY2tlciBpcyBhIGJpZyBwYXJ0
IG9mIHRoZSBzbG93DQo+IGNvbXBpbGUgdGltZXMNCg0KIEZyb20gd2hhdCBjYW4gYmVlbiBv
YnNlcnZlZCBpbiBiZW5jaG1hcmtzIChwZXJmLnJ1c3QtbGFuZy5vcmcpIHRoZSANCmJvcnJv
dyBjaGVja2VyIGlzIG5vdCB0aGUgYmlnZ2VzdCBwYXJ0IG9mIHRoZSBzbG93IGNvbXBpbGUg
dGltZXMuIEl0IA0KY2VydGFpbmx5IGlzbid0IHRoZSBxdWlja2VzdCBvbmUgYnV0IEkgd291
bGRuJ3QgbWFrZSBpdCB0aGUgY3VscHJpdC4NCg0KPiBBcyBzb21lb25lIHdobydzIHdvcmtl
ZCBvbiBpbXBsZW1lbnRpbmcgYXN5bmMvZ3JlZW4gdGhyZWFkcyBmb3INCj4gYSBWTQ0KDQpZ
b3Ugc2VlbXMgdG8gYmUgbWl4aW5nIGFzeW5jIGFuZCBncmVlbiB0aHJlYWRzIHdpdGhpbiB0
aGUgc2FtZSBwb2ludC4gDQpHcmVlbiB0aHJlYWRzIHdlcmUgcmVtb3ZlZCBhbG1vc3QgdGVu
IHllYXJzIGFnbyBiZWZvcmUgcnVzdCAxLjAuIFlvdSBtYXkgDQpsZWFybiBtb3JlIGFib3V0
IHRoYXQgcmVtb3ZhbCBmcm9tIFJGQyAyMzAuDQoNCj4gIEl0J3MgbmV2ZXIgYmVlbiBhIGJp
ZyBwcm9ibGVtIHRvIG1lDQo+IHdpdGggUkNVIGFuZCBwcm9wZXIgdW5kZXJzdGFuZGluZyBv
ZiBQT1NJWCBzZW1hbnRpY3MuDQoNCkJ1dCBpdCBoYXMgYmVlbiBhIHByb2JsZW0gd2l0aCBs
ZXNzIGV4cGVyaWVuY2VkIHBlb3BsZSBhbmQgdGhhdCBraW5kIG9mIA0KcHJvYmxlbSBlYXNp
bHkgc2xpcCB0aHJvdWdoIGEgcmV2aWV3Lg0KDQo+IGl0IHNlZW1zIHRvIGJlIG1haW5seSBk
ZWFsaW5nIHdpdGggY29sb25zIHZzIHVuZGVyc2NvcmVzDQoNCkl0IGRvZXNuJ3QuIFRoaXMg
aXMgb25seSB0cnVlIHdoZW4gZGVhbGluZyBmcm9tIGEgQyBwZXJzcGVjdGl2ZSB3aGVyZSAN
CmV2ZXJ5dGhpbmcgY2FuIGJlIHNlZW4gZnJvbSBldmVyeXdoZXJlLiBIdWdlIGlkZW50aWZp
ZXJzIGFyZSBoYXJkZXIgdG8gDQpyZWFkLiBOYW1lc3BhY2VzIG9mZmVyIGNvbnRleHQgZGVw
ZW5kZW50IHNob3J0IGlkZW50aWZpZXJzIHRoYXQgd29uJ3QgDQpsZWFrIGluIHRoZSB3aG9s
ZSBUVS4NCg0KPiBBRkFJSywgUnVzdCBtb2R1bGVzICsgY3JhdGVzIGFyZSBjZW50cmFsbHkg
Y29udHJvbGxlZCBhbmQNCj4gcHVibGlzaGluZyByZXF1aXJlcyBhbiBhY2NvdW50IG9uIGEg
cHJvcHJpZXRhcnkgc2VydmljZSBvd25lZA0KPiBhbmQgb3BlcmF0ZWQgYnkgYSBjb252aWN0
ZWQgbW9ub3BvbGlzdC4NCg0KUHVibGlzaGluZyBvbiB0aGF0IHBsYXRmb3JtIGluZGVlZCBy
ZXF1aXJlcyBhbiBhY2NvdW50IG9uIEdpdEh1Yi4gSXQncyANCnByb2JhYmx5IHdvcnRoIG1l
bnRpb25pbmcgdGhleSdyZSB3aWxsaW5nIHRvIGNoYW5nZSBpdCBidXQgZG8gbm90IGhhdmUg
DQp0aGUgcmVzb3VyY2VzIG5vciB0aGUgYmFuZHdpZHRoIHRvIGRvIHNvLg0KDQpjcmF0ZXMu
aW8gaXMgbm90IGEgbWFuZGF0b3J5IHN0ZXAsIGl0J3MgdGhlIGRlZmF1bHQgYW5kIGVhc2ll
c3Qgd2F5IHRvIA0KcHVibGlzaCBvciByZXRyaWV2ZSBhIGRlcGVuZGVuY2llcyBqdXN0IGxp
a2UgY2FyZ28gaXMgd2l0aCBidWlsZGluZy4gDQpNb3JlIHNlcnZpY2VzIGxpa2UgdGhpcyBv
bmUgbWF5IGFwcGVhciBidXQgaXQgbG9va3MgdmVyeSBleHBlbnNpdmUgdG8gDQpydW4gYW5k
IG1haW50YWluLg0KDQoNClBpZXJyZS1FbW1hbnVlbA0KDQo=
--------------KmYuXDji0Paa6uhZgMv0MLrq
Content-Type: application/pgp-keys; name="OpenPGP_0xD006124B2A7AEA23.asc"
Content-Disposition: attachment; filename="OpenPGP_0xD006124B2A7AEA23.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DnfMQ
-----END PGP PUBLIC KEY BLOCK-----

--------------KmYuXDji0Paa6uhZgMv0MLrq--

--------------iWnxa0INyU9badZk57qgCkOw--

--------------RQ8ma2U3hEuLpstznCxK9DrO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEsfTv9vJGYEhA5qhK0AYSSyp66iMFAmjjiE4FAwAAAAAACgkQ0AYSSyp66iNR
QQv+N+xXHULTw4eI9FSls9a+poB2x5CaX+xtKx+pvNQewlVZp4EBVnVBZY1cS+Guxc3yyBwteBEd
dYz3KGvuTwchxSYYdAsiR9UzP87tRBGTY8WCWWx5k233ji1vJSLs9R2szRsSWq158YvK9SgDC4FS
wUpV9DoHbTbXLlYG3W7JE08x7m5v8cwSEvG0uPLFDUhiL77vT5AWbU1nMRtF0/yTeBqsUlKWzRmM
KPyy9TZODLMqtFOybsbLCPO4fD5CZ0yV3H9b77KhZCHRdxZtznNeBYhCBmLjANWqo1vLOnrNq64M
eufAXotNeXXYjbwtRehxZV9fsa2NKtPJW9IcJVBRYo0vSvkkxc3OZ3bwvaeLxMMReVCXz8zteXKF
XnHlAzEZLnZA4sXOF8Q8v/FTeHDO6odwi4jE8CBFMlCavmUEMH5V5XDy6o+YucCP75Qfz9WjBiBT
BVXTy7BbCfe7PPV8jkARB7NpKhlQwP7suTsMRJ/ar8s/5x2V8Cf97ID7jXod
=YDH3
-----END PGP SIGNATURE-----

--------------RQ8ma2U3hEuLpstznCxK9DrO--
