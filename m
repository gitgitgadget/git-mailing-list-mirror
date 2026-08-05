Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2963386C21
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940413; cv=none; b=BwtVnJ+Gcbv5zWyNuJevCwfw9Nuj5n8XjSwOpxlt4b/mShUBXqGxI9PiYQoRHM+N3URn/BrVXr4jLI5b0KE9GhTvjPu5U0RI2cSsarVBZymRnqi7LDtQNWfrZQIyFOJFAPoQ3HZRizauwLlIURwc1SGip+nrmb/ffbTkN8GCk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940413; c=relaxed/simple;
	bh=vkAXvtmojM2LgkGqkM2JaLhF7GFS4uYRiHqyERcXY4U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RSmkNvG2MjLGrVlaOzTN53RA16HiKwlepyMyL4Nn8FfroVn6P3Hh5Rdkjj1SnVMdNBy4n/1TcpkGowLeK5aAuk5NntKsTFlQ/+m1fSd2i93r0ouMrxlZle2R/vAxu55jXs5BXNfXozuhdXNiqtkfj6Rqd7fbq1YWYqU9+8D0gRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qxhTCn/K; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qxhTCn/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785940401; x=1786545201;
	i=johannes.schindelin@gmx.de;
	bh=Kz4USKGlUrchY8jny0SrFT8u1AHzePdesJj9qCNcRrE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qxhTCn/K2vELvTxl9SavwAtUdFHVae2k8e2+tQRGZjyvKr1FoOJUV9PY/xq5MXAX
	 fhzE6WvNxrTG812HsHl5C6/fhlqm1p7cCpfp9P2lLTTYLKEKQOFzjpVKfuha7OEN5
	 dCkOR5t6j6RseXDZ+XQZ/XugT75UUvLYFD1nFn4U05W9WrEUaPO45vCMAxsikh5OH
	 x+0il/q+jMy2TMjHtsbHZSTt6ilFcApq7Sv2I0TUPr+9SQmrWuUdpqJxZ3ZJIKOQ2
	 JDddSjER0uSaYuNgpY9Qoqc9vJ53CnazW8XNnMKBUSMMJcqwaz1VX5xFiyfvhgxMg
	 cbDaKaFvsQlkYO8sAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1x1Lxk1B37-00uPMb; Wed, 05
 Aug 2026 16:33:21 +0200
Date: Wed, 5 Aug 2026 16:33:20 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 09/11] bisect: check strbuf_getline_lf return when reading
 terms
In-Reply-To: <xmqqcxwii6wd.fsf@gitster.g>
Message-ID: <282a9a4e-46bc-a790-e801-970d3a52468b@gmx.de>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com> <17c382fdf46eada79ce03a7604dd7e0454d8bea4.1784069325.git.gitgitgadget@gmail.com> <xmqqh5m1qcfh.fsf@gitster.g> <xmqqcxwii6wd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:JMz9L3QykDx8v38uVzaXMryuzK4B3EFPkyWI45qK1SpNfncfSq6
 lHTDXlwO71lW767LzjoHtXvXe66O3oWueGTEbkCaf/lcPrKBauDiUajeuHyNOc1Eyzpr/0+
 qud1eoHp+CfxGNKuuTs/YyrQCJ7gDK35v7eN2WyNTZdcKWHNBpK0nMJMc8fYhSbu3iL51XT
 lkzsIMXQd8r67MjuSqTww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WYd0z/cbm5Q=;RK21iWb6GpkUyLwXE61qJo5Ivp6
 S6gshPVWKt5YIZJq/y+hOSQmgk9ZDN+CM9CpDjxGDq86WUd7rGrendGtNmAR+4O8Y++Zt1Ms0
 JsciG6oWxYTSYKIcdy/2c+ZklTn/cJsxqYELQtldaGe5Dj0Tz9QJKH++YpWOf2NWxBZKDWgMY
 N1e1iH1fNHImWDon51DQ9IKV8aSgFtaaLX3IpKHtuBXpiZy7CC+Ru9xr8kwwDpxnL6uGqIvu2
 /qBMqGh+b/UGOFzE6WEQtoLbmHCjneN67y3HsZRgXyW7ZbKGok1tTPooPrgBWPiQuMeAXdjek
 9x40arDDyO3xU71Z0dKeGK/RvubZHezbX6s3c+0bJClVV1HnorTomfZaMS324+WEzJ2EsGFEc
 dbl/8VjDHHZGvA+2Jc5cVub7GxrnDJWdVSzubkmVJ93eBFMl+Xc09dffyD4mVrHK4OZbkxgmo
 PGHosF9rmHk6YabaCr3AUxh36aIfndxA3qo4uVelvtM1Ef8mbjuG+jksdxYwgS1sGaz4pKfKW
 mnsSEayD0xJtPPJRcTzJD4osLHr/i/B6cIq2YnODeC0zG6DJdmk6fEAXPJPr1gGvJCB2srAgb
 m/ED4oViK/UKLinXkINj3+X1R3c48XAROQI2MeD2oNAXCVlBuis2/RZMSbr1tJ51x/Tdtv7/V
 WEYQmKII2yrwRT3/yT7R4bnXyEDyDkIhBK4/sYrx5snoI2MYrsBBsnoEVZmY315Y+agQ5mhw2
 nfrkbB28NGQttZlLxmG3BaUTjDS9L9nVxc/3TcxkvywKnZpxK2TsutBOXt/HHe+UTUfHhiiMJ
 Px+QpHuKm0SlTzEqb1mpBVLGyW6+rKtV53emBgov9juKAkf6S0BJVGjxD2r2N1Zb6V3Ab9U2Z
 3AC+pFS4ZgaFMgIL5+eb1ggTqdx3UitLARg96jdGgtngVMvISJRl3fj2ieYs0/gpWmYmltPBf
 eouJjZs2XKB8e9YjrinU9hBHl43NhbKKQyZR9DkCbYE4nqcK8l8y+wRG/lS9ILQqzvMJ0M5as
 YT3jdRZguaFnNGDwBXrOLjAJHm00d5GD40E31rSW+wRjNhwT5+KcGVFo3fgWYNpBo2nE/0i0A
 zdWtXAfMgEy4QbG7VhuI6FtGzRPJw9VUhYZ9mibspodaLDvKODJ8UjF1dnpEGT1lyyjntUjDL
 jFdf+zN88SDhFGBWBpSBRsgk+Ijh1itNnfrFAt6Br0MLK4VhAwFgku6ee3gL4bcjfNSlZ/kvt
 ZLVUMDzE4vGkMcBns20Qhxalg0gmKhX2809CQWRvR6bZVrVo3I/0ZfuPWEUEvbY+vozg4uNle
 zjEw0DgJcMbmxBun+nR1fsd+51MLVB4WjJycI3T75mMfGTtrpHxOhuKi0VPg3/WScK35Sh5y/
 r/KUclUw8NA9OZD74NptMGbUrj9oX5OEzMw79H/sOuGAM9J1xgMYPdLLQgIcbeekNZwVaG27W
 bhABxmJ3tpSxkS6bG8u550tS+QO7DeMmLAjpWlXR6lWKCllr7NdRlqhuYkMxwF/HPchN19mtN
 lmPQcNHpHhUn8l7IAbmM7EeNstEraznQGuAePm7ewcFWhiwwj/cIBs4DHObrltxMIAqJEWTvB
 dkJciWEHJRoqjCGAfr6BByPS6xZCfHHtseNDohxiX4tz4JJtabjX9htsRKCRxGIWtCNGj3Av7
 qrC8nB9hjpkeFoR9h6oB8KSVyOicdxcXMestPHxZh8c0lFc1h+7X2ErvACnLOl/GqLXgN8ujX
 86p3hRgQlxzWFHb+uLtAcJ59OYtBzvcnOR1m7Q+O/AQ5bj4PC3IMqfAI+C0Y0tpgd5iRAmrTX
 YBMhbDtDf+R/WLcZ2+JakvhGM4xU3jjLiWvzu3SAmV0qaNjaOc7PYPjazBNiK+gVpXyLRe4O5
 Tzdz26LV4o2TYcQVlH4g7ydMzXPUEd2DSCvyHudz2BsCMs0kbEtRqb6aZdNT8b3Kp1zSP24w4
 JTPB5KRQjsZjd4u3tHQZVoB2nYrj+e9/8fN9iX3RyEJ+/alHYdqrtTt8+JXLJ2DeI/9zmr4Et
 8X4Z0fl1oeyyFaUBH47UxUhU1Onx2i2F+LqKFOItUjT1WgSkJ70ReXoYFM1N+r3N1ChT3qAdm
 4QdowrHXc7q56c0tCSDNes9ilO7pqBGLg8UMuKrCOwJOsWh4e6IbxHsDO6chsjGvAouT7tkI+
 wjj0WzFlqWqClmcGgrBQUlltQ9rsUlc/vKPuWIzF+OK+W9V+/I8p0DIv+4VrAWqEFm/hEB14W
 /80CKrDbCeY1rUjllpSa419SwWha/RnYpnuNX5NQ6DxWmc0kRDNn8g3L2Cg19YYrszV/NzXZj
 h+6b8sMoae9MMDZMYc+Zz09Jp2AQE0rTXnme52N199g6E4E6Cp+8XQKwHUdhl7lgEl3i+U7WG
 TLEiTNNZ6/JPpUJzr2XLlKpU6c04O3TVQHyIdhUP0vHJ3umU7ayQrRi3xgpa9/lwfoktHOWXn
 dv3CacKYpjjDqHC4aSSYkGkith3+c5FXFi3TfS2QFXk29PYuQcm3T1LqaxkpVOtTZ/AOFHdm+
 E+w9Yl2oosRNP+e19T8gcygAqkatqZTWrEfs2m9O0epp2HO0JIWulWTb9pwcmtQAlRGOyNnhE
 92fxlb5BufL3EmiAZ4eL2eTrIXKVUvgNS1e1uAgZvmb02sPGoEk9n75ij6cgbmmImpDf31xkI
 I58Hm6MARuwFswzpeEF0L2RjBrP/oO5duHKfIR+NABZXAXQ9RGs5/jUwvfAhFgDg4x6YIjijK
 Tf+SwE+81N7KqADsiWU6OnXQ7GcPYwTBFCjZxXLx54urIjzDiFvWIWGCRGamAdCQNOstpWbL3
 stJYtPT0OnVrr89Zq5KfPhKJkrMDz45cJ5rrhG8YL33tS81gb+uCtmbnj+vNkT5RShR5i/7rx
 ZoQEVZTuABufYSq38W2GfVaj7VwcNj2pD5JpUzX6IUZB2vhKnpZdvnIq4SQXh+yVKgs0C6Z7H
 UfX/MDGYuIYUPt7cb0UDQdTOLyKHy0Jsr5N+RSJ3VL+tFT6aDxhqu8Vburb6zqZppdS8mo0dS
 VTSbl67fwsm00nD98+V07IN6ldlaUApDtMNcBVrLt74tTiwJcJdzlz41vZK3BXnlygtjOhj1I
 aJbXrYZBSSqzKGRBszewggXZ8ZzHeVjsZXQQ4QKdVlp70O6g+Oq/uUGqUnyuP/TYG7N0ywMec
 o6cK/Np5x9rl4oYRQnvWU8nuUj3aWrV3jqr8XWpwU82l/gZXWPTCIZ3Fmg3ZU+IZ4w2VcgU6t
 2Sjd0q5XozwNJ4tQHcdQIYQfJNgv8LIlIjVsCgDkqHezZdThOA/ZFwmepSH4PZotfZrEVBu5V
 S+0yzJb/GjAKLr+GYxPfo8pRgml/QjQD6IeP1f623Y3qwWcnr7d5+cVTGIl4dZ68Ds5lHMupE
 DJpW6kt0GANGkRb8kXVTl1IhMUbyLX4Fc3F7LNqfHzEOyJsE63+zjBHnsr1zDpxZy1aTgp/sg
 30teIwOC0IvLCSkWlEY3uw2pBGDeDzkZfYtvNgiJ2vAbPhSqC1Ykn3sIGX46SIljzfGsMY2WP
 s70BC29zW869837s0SSAFIYybypZmWIH7FG3QUweBHuAxx7r6GMX1RmRsOXuz3egq43r1koLS
 f2vfgy34bs5LPH10Y5YvSnFBXiQXKHsf15YjHV3h+8r/GwQ6FjDQ9um8bOcwHm0C9wYUv9p1/
 RcMnFvq440Mwyfk7yaO7TT9rqQHHKr+b9w1FR75ciJYYC3zI+6/Lar3r7mvsNvBiKO/R19n+U
 2HZTFc2bfFtE6wTZr0rCra78JslsJDcQjbF931s+Xmmr8fkYh5xqFiEUNFGu3sqn/7wBs6qYX
 KSQaruQ1yNEn8eUVGN8AH1k0B0oIXmP1lDnVk0/MmLGG2PlsXEECXfQ7wxYOROXQfxNZg9loW
 Iaaee1Hrnl6lsueJnWd85w8vzLPVd874GP4XmLmNdyJwE0vxq6PNSwTJv6NKs36q1iN205jjP
 enJiJ2a0qNBcq0CBFpnt9ZrBobP1cIO2IDPwfE9lnQtlqRfgfzTwxL7jCbcgdHk+8y0sk1/7R
 mBRp2x5heSycrZYylwT8zmZ0fQrO5GlSA2qrPtH9jz/cJSXaIun6O7YPVbKwAZM0HWZcX09O0
 8sTHgniU1bkkwTo05bOORx3nKd7yV6OBtoZ/UoDEBdc0OKmvy0kyVvJQncQEQ9G4TZTsSHhz3
 6NZaW4/hIdqFqU/ovZseBQHgwkoL0nQBEGvQqXVU+U55KCn+ST85WpzLr3+zO4kQzpG/ue+h+
 rPnRt87Ebtc0Fl5arR9RIJkBxv8/FYu5hWXg/FB3YykVAttXkwDo2TCMXPgdDSgIiHuxTeFaw
 OcKwfAJVUgstC6Ey6+SKR3mN/H9/lE0Y9BlaY2hlqwj7NG07KgJdE6uF+WfB/uU6uwiBzuuGn
 wtTwnJwU2ZMclqHYBRqmAmyJUp7HVSvnUEV+R+ph+0/AH28eD2PcX0fyNUNfiptrsnQyMTvl7
 o60egEyu+4c0quNAtVm7pbku4hty5gRqF0CQYOjLoPZjtYU0mD+UELvA5F17FtWI9qI2TRNbf
 zwnqc0xZD2Uh/INlsTXjAQj83HWABJ8YPqk+RHO2Zf0zcpm7aHn5hU9ax/DNPm8DZY8dG3mu7
 phYENNN9jeelNScPjFi8TOFQZtE7hG4DLuK84vgle7EXDr03fqI8oPao/V138UDiHA5P0X/hm
 lnR1byMrCalpw2UdbieoIVJeHky3li6TG/MiPrZ8CISBpMpGGiMsFEJxyxwlsfKnJ6VD43Wky
 jFKhQM2X0Mf6/APY6larrJ6e41h5uiLDaCAxM1KXwGTCwHybpOETGnTwUIt9Q5PUWemV0BrWb
 sXPI4wGt+2ynAfrNFWkSK0mbXdtCyMx4CcmNOwBeHG+H6LgipZhsyKSXtjz2Qe/b4OgdJy9AO
 hFVEZSIcH5QoQdxxFV6Q7MxLbP6Q9pXvn6pl8Ckoek2lMNdmDmp66KvdUMEBhcc7zkNZeAPRT
 +LTFZtNVU/40HS19Rq3H+uQLO6eoUodbAuo+oHsOeWNkVmw5aH4FuGk+8H7JGpoC020GZ9ZwM
 mEsGqueokXyTk7biCgxiPQwjGe6o4BykbzEJIUmNPhnYNeXvpaKl4k+ZoJbcVn0ful88Pbffu
 84zZqYDYMraMGOKoE2w+IDLRcZ6T5ZgovbGAElDsDjiEvbzV0fP9gppIxjXaoAsr4I7CcgsUH
 X/8fOnw4dfcEwUUF8QIXowS32wgvUsp9QqwYDwp7srM9lEtJ5fFDeCh+64NBdIHhH+o3Rle0y
 4CA3auCo/zAqbwY21qEXoNmuxFBAw1WJroMTD9P3Hf4Xw7mtQQ0krVSIMMJSAp5xazi5jXd1G
 B5t4JhNY6QONMEK45/OayRQyARiSORtyprJ7TGwXNtmEPuTNvC48if+W8jIzQIYzUuzvevX6C
 AGvjW9TgmAOk+Mhhnepb87Hjs3ZCNqAP+Ucfiiy1srdk7KXT/Oc9k2lPIDLbiEWh3/f86K3er
 isSoUwsD+uDUtM4A/ewLa87zBL6s8GYFi2oJgZAxGeDlxss2cLn2RH0jE4UaqhWgDwO+p3ZtM
 sVffRKUslCZwgRbSVxl6iISQBu+AkEf28r21Cq5X3lbrwFc600PsoruaYOcdKl478KDWiXar3
 4pwLa0WsOAj5PrFhSsFLebhr8yQj/mSww59Y3NiLRJS/cfl23pB+w8a/P0A0pR/BKtAnGGJ70
 UbB9Ke+7vpmE9BFF1YKA23IPNsKpi8D0ktwsJwBkJIW4yWxN1UqHyqttMEvB4AABHVIshofln
 6V1Vy4NTkjDIlfFgfhL4jzZeg44zSDjzMmURboDjLQwxZ6CtP1VJlLYb38XkgxsKmqCIxQ37m
 6X/UupqieDAAcS1vbK0NFX7MfW5oErTAf9tEO1Kfr6NXay1LLlaPPn5ppq3vCSAq3xqVbH50H
 TQVC9f/nRHmVt3OEfHePuperEteZ3SfZ59DVmzXVs3HaVgHAQpjHmRUrubOh+nVXbRzsLa9Zl
 BVARDWEcehqLS+IQ7y7+hozBHjcJt7BE9vInwYGDKRY3QCt5IPDo1G+TN6WiTngMoMWchhZIb
 8KAEiwlrbw0UKTcRtbq/lDZOikLa2BFsR+V5xnUMua5rJTQjX+RWZIUK5L/quQSD6bMV1qKAy
 t6YwzCayrZf8XNe0db8=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sun, 19 Jul 2026, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> > ...
> >> diff --git a/builtin/bisect.c b/builtin/bisect.c
> >> index 798e28f501..fe66d84382 100644
> >> --- a/builtin/bisect.c
> >> +++ b/builtin/bisect.c
> >> @@ -498,9 +498,15 @@ static int get_terms(struct bisect_terms *terms)
> >>  	}
> >> =20
> >>  	free_terms(terms);
> >> -	strbuf_getline_lf(&str, fp);
> >> +	if (strbuf_getline_lf(&str, fp) =3D=3D EOF) {
> >> +		res =3D -1;
> >> +		goto finish;
> >> +	}
> >>  	terms->term_bad =3D strbuf_detach(&str, NULL);
> >> -	strbuf_getline_lf(&str, fp);
> >> +	if (strbuf_getline_lf(&str, fp) =3D=3D EOF) {
> >> +		res =3D -1;
> >> +		goto finish;
> >> +	}
> >
> > We want to clean-up terms->term_bad when we fail to read the second
> > line after reading the first line successfully, no?
> >
> >>  	terms->term_good =3D strbuf_detach(&str, NULL);
> >> =20
> >>  finish:
>=20
> --- >8 ---
> Subject: [PATCH] fixup! bisect: check strbuf_getline_lf return when read=
ing
>  terms
>=20
> https://lore.kernel.org/git/xmqqh5m1qcfh.fsf@gitster.g/
>=20
> This fixes the immediate leak introduced by
>=20
> https://lore.kernel.org/git/17c382fdf46eada79ce03a7604dd7e0454d8bea4.178=
4069325.git.gitgitgadget@gmail.com/
>=20
> but many callers of get_terms() should all be fixed to check for
> return value.  If it fails to grab the replacement word for "bad",
> both terms->term_bad and terms->term_good are left NULL, since the
> function calls free_terms() early.
>=20
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index fe66d84382..69ab7ea248 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -505,6 +505,7 @@ static int get_terms(struct bisect_terms *terms)
>  	terms->term_bad =3D strbuf_detach(&str, NULL);
>  	if (strbuf_getline_lf(&str, fp) =3D=3D EOF) {
>  		res =3D -1;
> +		FREE_AND_NULL(terms->term_bad);

Good catch!

Thank you,
Johannes

>  		goto finish;
>  	}
>  	terms->term_good =3D strbuf_detach(&str, NULL);
>=20
