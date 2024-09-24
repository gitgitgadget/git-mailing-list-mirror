Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E673FE55
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188274; cv=none; b=ArQhxUXiFg1jZr66VxF1p4Os4/+FXkH/8We7uMevOuogm9T+r28GRSzI+vbdXYUQ9XDEcwofMD/83y4bwUNZw1HuHgHilprpooFbTLtPUqkFFQy8ysr9+5yhMkVmIIruHF63gpcOI+mnr2B0AYj8oNR9zbjpctVO+Wi5CYLkaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188274; c=relaxed/simple;
	bh=vnyhYNSYlfyXlRYSXSQqAsRU01Qdzy0qb9IWCJVJrqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZffLTLVp5J4NXidrvEh2bSZFLsMb/bvNNyn+MPu1twisCb6e+p++4qPVVmlhYn5s26WF9RgECp8fqR8dBkAwVVC71DIpqx5jwpM1GrcKwCoNb8YDDu+Wt6Q4YR8ZnOf/Wc0Rz7W3kH8r2b5t5dsr4gUn5sby/v3mdH6gKJQDZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwRuixHA; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwRuixHA"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7ac83a98e5eso468286685a.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727188271; x=1727793071; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnyhYNSYlfyXlRYSXSQqAsRU01Qdzy0qb9IWCJVJrqQ=;
        b=bwRuixHAjr5m9/0XmpJ40r0mf/i6HwR8mG4x8IGji7UusYiUyRHdLE31YQ1OELIMLi
         oKGeMFoSKLbRytau6BtEXy7JUtgBcZdk7HN/iUZtB+8rHn7dH+xu2CV0lHYxB6UADjdy
         x+hCHWUMrCCDnpvOj8wClWSY0tl6GaUOCXbeIFDJaVtvEyzS5htu/WlK1zimgT7pCckt
         V7i3yUmrKgKkg1/6m9kFdym4PtFByo9E91QtuPOHvPpzf9WV4+Ti4Sev3jlafIfQiNB+
         O7Zm/MvircrCfa+jdMl6f2voxQz6H8Q8CrhrC6W9riiXjTp1l/Fb1fHeKlt8x1DGYE0t
         FOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727188271; x=1727793071;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnyhYNSYlfyXlRYSXSQqAsRU01Qdzy0qb9IWCJVJrqQ=;
        b=syDCpnKBm9QSrUl3YRBuB/vaX9pI89rZii/G0yMK6nbvTojizKAt4JMKLkrbTm177G
         oK+e0+6xgPhgX0pHQyXBlsYD8Q470bmrjDpXH8bpMSO5zcN5ZlrpEjBysYOzR1imeM7W
         hY+dvIQalcaEhbpz4mvjKYZPjj/OhZHGxisoymHRFn4My7lWdlnloYtwTPgPUMPga5FS
         y+Rj6+mtlzbSTpECbmn92j9OTE2XVT3BSjWN9vlHR3zgY7FotV45dA7Z+rJTw865sPW7
         HwZ92vr4PpLfq00X8U1NWLnTYknYZ/jzBsnZntTsT+n+ozr/JGQ4ce+UJHk/80MrSElj
         /T1g==
X-Gm-Message-State: AOJu0YzZlATofEKIzvpXBfFoagK6aIZqh/KePFO63Op+GRQz8J3SA24m
	9K/wfB5EEsExzxwavoAqV+aLksPwJ85ftJSn4pVUXSHEUz05JneD
X-Google-Smtp-Source: AGHT+IHtWmyCdmNatzl39fPxBgs4m4aK6JU69JDt/TNFEKlMisjqxGp7roxsT5+ziHtR17E7pjNhQQ==
X-Received: by 2002:a05:620a:2904:b0:7a9:b250:d587 with SMTP id af79cd13be357-7acdcd5c2c6mr536931585a.7.1727188271214;
        Tue, 24 Sep 2024 07:31:11 -0700 (PDT)
Received: from ?IPV6:2603:6011:3f0:6f00::12ac? ([2603:6011:3f0:6f00::12ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5cdc70sm73191885a.90.2024.09.24.07.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:31:09 -0700 (PDT)
Message-ID: <b28b1256-01bc-46a3-8338-e47f2301eccf@gmail.com>
Date: Tue, 24 Sep 2024 10:31:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: Junio C Hamano <gitster@pobox.com>,
 Henrik Holst <henrik.holst@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g>
Content-Language: en-US
From: Eli Schwartz <eschwartz93@gmail.com>
Autocrypt: addr=eschwartz93@gmail.com; keydata=
 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
In-Reply-To: <xmqqldzsrhyp.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ko3jYA7h6adox686MSyPr0es"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ko3jYA7h6adox686MSyPr0es
Content-Type: multipart/mixed; boundary="------------oFgsZSLyeSuM14N2WRVnjWjx";
 protected-headers="v1"
From: Eli Schwartz <eschwartz93@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
 Henrik Holst <henrik.holst@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <b28b1256-01bc-46a3-8338-e47f2301eccf@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g>
In-Reply-To: <xmqqldzsrhyp.fsf@gitster.g>

--------------oFgsZSLyeSuM14N2WRVnjWjx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/15/24 12:37 PM, Junio C Hamano wrote:
> Looking at configure.ac, pkg-config is not used for any package.
> Specifically for curl, it seems that "curl-config --libs" is used.
>=20
> Presumably the reason behind the current behaviour is combination of
> (1) ./configure is an after-thought in the build infrastructure for
> this project, (2) pkg-config was not ubiquitous back when autoconf
> support was written for this project, and (3) nobody considered
> "upgrading" our use of "curl-config" and our manual detection of
> dependency detection for other libraries to just use "pkg-config".
>=20
> Patches welcome ;-)


As an aside: I am skeptical of this explanation.

pkg-config's first git commit in 2005 is an import of a 2001 commit from
another version control system (probably GNU Arch -- author "Arch
Librarian"). The changelog it includes starts a year earlier, in 2000.
Wikipedia agrees, claiming the initial release of pkg-config was in 2000
and citing gtk-devel mailing list discussions from June of that year.

git added a configure.ac script 6 years later. Curl itself had installed
a .pc file for 7 months at that time, and OpenSSL had installed one for
nearly 4 years.

But git's configure script looked -- and still looks -- for -lcurl only
to set NO_CURL for the Makefile. In 2018, ./configure started using
curl-config, in order to set CURL_LDFLAGS.

I suppose it was copied by rote from the Makefile, which has less
flexibility to try pkg-config and fall back to curl-config.

Part 1 of the explanation is valid: ./configure was an after-thought. :)


--=20
Eli Schwartz
Gentoo Developer and Meson Build maintainer

--------------oFgsZSLyeSuM14N2WRVnjWjx--

--------------ko3jYA7h6adox686MSyPr0es
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmbyzSxfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDYw
NDExMzA0QzA5RDM2NjI4MzQwRUVGRkNFQjE2N0VGQjU3MjJCRDYACgkQzrFn77Vy
K9atihAAiXXLfgMOa0za2PmcsNmlQK6nmr8UENsXGpqs8q1AYptNnMWMwRanhfiS
JBdNxAJiA0jKcDXxrgd4OcgjGGer6rK5Vkpn250pBSdMI1paG29hxGRGfcWE7Buk
pTcmPAI3DkY1fZ3oKQxAsAEbkTRLCJTxKoom3ep5gNo/DPPiAyhKkFqs9acQIFja
rpjHxMEuhIYcvfl8d1+aQ2Hi0jqdbAXy1aPSPaRCkvh59amaF/JvTsxdJjLScDT9
C6wjYGMR8gIhF9PgaBB4XKWBSM/l3LxHPRP1J6FuXEz0EdzEs0lBVtoz1Z+hfh1K
L0KB6DPJL9jyhtCGxXV+XmOAyeO4Y7Cri5Vr1luya2cXTUoj7/n/jRcMY6uQ80W4
4/pEk2U7nJUFjmNqQq8RMQ4JttmXNY8nduf/Xgs5sOujiFkatWy3+oam4zfgzlbv
EldS5jpFLNk6lySFvNe78JbnR2HCzLwTHYwqslwujNkxzIN0y6w3A9mtySHvsipD
QxLoc4XZqXoveiMwEpCKTFPsdRztvnufwgZ5jQ5i5v+k7x6pwjfp8qqsAveFxihO
Rl1aaQJRMDdCAc6X9xPXDqk8OVHRePx/clwpW9ky4o9lPZKRxmgtUs6p6Rvj3SA3
BSt0wlrDB1FuVW+bpOc8Ufkw6qXZWNwT6b339vykN46inkAoMfo=
=tLRL
-----END PGP SIGNATURE-----

--------------ko3jYA7h6adox686MSyPr0es--
