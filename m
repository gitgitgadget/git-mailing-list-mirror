Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780239B95D
	for <git@vger.kernel.org>; Tue, 12 May 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586979; cv=none; b=LvdRgsnc4N4w6Z7ms1NherqQk9YhrXjjuMjIpieWWsQj7u3yWTO/csgs099ysQo6kLBV1rtHvhvuuh4AF0Qg36Dj0u2ZgCoHqhepsJo3p2M/+eGrubuoE+SZvpPhbN9XsQfDFtqt5gWv9OX0rpyDw+jwvwym5Ud6z/b46mefzfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586979; c=relaxed/simple;
	bh=QFUMZw34KLs4AfeDmRdupyp9ffyMT0iLmKLKFKcVATI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AcQIzVIqnzVUagQIdO3/O729UHMEThY+Xs3vqIxgphG5nHzS39A8tpqYTT+VKt0X/G/DbHgmjSQCf81CDJIcdTS11yxkjJtAMbaCbBjtQbK4F2T40c7vc8PzgsWJ0hy1rtYQ3PqMz+EiS+uHZrtZsW34sNWqQJxp33GjMtJpe1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NgWz6QuG; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NgWz6QuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778586968; x=1779191768; i=l.s.r@web.de;
	bh=GYBCJ6ci5KHeWMAOHn6pfGfka4diwt8wjEZ2itcE2WM=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NgWz6QuGxYt16OidR3eg6WCQ6MuMpEb4wzmVOq8vjyOkC/J1M0Jap7g2Q8iQRIk4
	 FuvSPcWKFrHDnEB3n6rCjxNuE5tfPdkv/bUr+AMCMrvJ0KhWfslcgwkft53TQqVxU
	 Qh3+eAZ/faN4R+Ck7ae3YAMKUW6vGO2gCGgYHDqrbgBaJWDzbcBB+dPYpaxYsy3sH
	 d6J+jAOETChyR9KuRyI+em6K0ntNh4EV5276QXnGDKGU/Q+BWjmcdSJsV/liwAMp3
	 db8EMUzrCkguI5ZCAlYFL3P192GWp6GQ1Lq19ynd1y5w8hv7rTdtyg4WJsEj33/6t
	 NAKuT1Y6+LrkeGFjNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6b8m-1xTkDW1uD0-017piN for
 <git@vger.kernel.org>; Tue, 12 May 2026 13:56:08 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 0/4] strbuf: add and use strbuf_add_uint()
Date: Tue, 12 May 2026 13:55:59 +0200
Message-ID: <20260512115603.80780-1-l.s.r@web.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TeNO5quSXkJBZ8K3+8JRUh/2pSNAANWV6a9YNZiHNjuq7Asez28
 Q+tL4Euoz7ah7Fgp8gENE3njnmcJuFqYasuuRoGp8S3WUBdWk0m/OCOuVxH39kv3ajd5jhx
 4BJM/+PNyVoHLzVuVAX36sd4BwGm63LNOVR4kB3YJPfWD0F5uFE5KznDUTH8f2YNIB2Lfsu
 wDb6SethzTv7RNUvwMucg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lgwsQPyaKT8=;4KtBNYvmDrXHuuO3gmjf9LT6dTO
 C/bxIyTUGyE/4SLo5QWHvHsHkfPiTj0ovBe0DAh/1w+SENgLfx32QHNdYwx6gA+XwVjj7Szm8
 nJDyjbF7f13R+cy1nr5MJI7Ajt23GpnZPx5L1DfDosyHC5aN64uvtRj68FWG2svuaREvh6riF
 tmctdC0N7bfDiQ8l/OKkJ549DWtU7OE8J4iIX7nBtvp3roSSPGBND4FcxTGeWPnC2hffdWXoQ
 GQrf6bCrFVNcGBpl+3jZ/ey1rzOl1gGTBdj3LKpnpdQXGGJDguMveYTIj7C0BQOku+otAZpWX
 yM8eitNIel/ybXEunEHkzFoeE4AXn4W1l/bkJc6oE3WibCtjzwVBpsjcgIrTjvoowqg4ZMQwY
 5o9hzobnyCbArmZR5B9xvx7tvnf2WZXl/UMNUtwRWKbiVhRHACYEWWf9jArP9du3V3H6YRwPE
 8KUOumIe+Bg8Bba44LzjxQ3+yIyJmO1a2jwYCtK+oxG1DCvYeErwincSFDFzTrrmJGYuhwQPO
 jZFzB77MpONagkdog5W7qFoZp2U4OCB6p8uI8ZdXZ6rc/Ua+jIxQvurKu9hdtec2apN5ROKC4
 Drw/eEK4mHzF050HfZSSYfaRTWSLRhyfoCgSz0GOj4+STUjqNrs1pOI7629S1///CgY0UTllq
 XWiW67gy5S03yeZE7diCa5qxNd0ywfvCnty/NrpqRCnlWWHtpn4jv8VTsHz00YQqFkzXblhwB
 N9plONj3BZxNc9En8ubr8iA/+nSwskUJjAE03uJNWw3E9Eznw/WWITOe578LwRqD55pTiLZbV
 1egoLFfpiwgUG2s8StFEa4y0oFYgCppiNv5pR+WfKcqGVYnfsKjawUiBgkijYOnpcTtuW/XXb
 KXMSahMyPjQyci/w9VPXyeTOz8OS6fJx1BqHG44/zvkCq01ylGCLvlY9O0hHlczZ8lIlLJiRy
 YPC8MQm22vmoCh5Ox6jca8+/roPJeiyLJzileeHtmjTtZPuPGMyxnN2Vmj5SP4iwmt2voU096
 YQudmRB3K7DSfE0YmuWre4MAFmybUE1pMpF9Kmr9xlUCAJv9T6zcfPpmA3kmM4oiEWN+JtVaU
 IrxFSnoOoS2LYV8yJD5SksBz4nH5jaHUe/Ors5dSatYKkfRA4U44qgJieEnOsMiXJfvb1bBfS
 GqiYhmNyowCRdkyH9no0LR+aXBQHfk3uaLjqVXpE62Z17nmvOGFzVmvvxhnVyTSrSA9QWcVWx
 eYsJXL9DWBNDoBPBGg2bd147MQ7Hc4DuTQZiuWGERv0ZzjoHd4PVSWW0eGHjSX63zv6jmf/VE
 pxYfyledCqrLaQOXlD2VyonD8Ukjwdh5PJ3XdUlVw89r9fLz0qO4EnpWMzG45/hW8pgqfV6Pa
 OgQ0rp0dH0gN8LelSrhJC07wtqrii6V/1zggwTtcEYrDTXp1EgCake6h3TCJ/MehImnz2rSd5
 xcu6DeK8IOjD+Mpxdf0gZ3BFM9DWMscsVOc+/RLUnEZu97xhKm9V9a6I4LVnYH/7oV2fV7qna
 w7pfOyaDrQkRxh1UMqEYM7RGKEFP/2p5leX4zkW3GmN/9Xtmvn2n93CVNIVAhi+6F0K571Gof
 1I7ynoPZKY4HOXixYgahZXWDfdt4YxllKJ/+DB/cY0iezsDZJQFu9PShPcgu0M4FpoIylMxzA
 3wSUXrXkjbZuy9rakujzHGy2n+tzqDQ2idRwbfYhCcqwjtNEYT7z3eQvf8hTpCJnNRFlXJj32
 NqITQJUpvoLsGnyT3wkWF5cZkz6z3eFdaMXs5WIXCKh8MB5FS2SNyn0qjHG6JW7mFpDRI/g4m
 Ik+FY/ZXrFYpxPLVzHA9q1gLxhSeA0gg/qrgVxGjgNFq5HpUdrauggivpBdu76JjVBj75/Jba
 OX1l2SMidD648AQMAC4j4ai3b5G+5VtJYMRzTlTNmaa2QSkzDCgrUvMUuEMmzrI6fadB5Btr2
 9k4NQvHD9UI8UX5bUH9xA6cWTXNmxjrIgBr9DlsvxiMxpFAtuAXlv8l1iAJJcJj72fbc6vloX
 FPuvNEf9guM1SeG6RzCtnu/6UaFlZdmLj9WXAM9+F56xUYiELpOcnEPtmQYgMHdj93D5Pa3Vj
 uoYTo+Uqg9cQUbAdcohXy/TKsUqk2eD1Bp62CyHfzAzFTnAagVG8yVtb/BLEuzO6SOB8Szl8x
 Vy8ldnQBcbdB/SmL0zsbnbz3u6DJo2e8AU9kTJ9YwmW/cEFNML1IgrkTtsHiDC/MRcLXrvHlG
 WG6iviKLffNHnqzMqm6f8MfQJk5WbCrywCcH+J9TOTxLNoBGy1/YZVwCeGqJuIUQVzxKk59hc
 qgluVeYipkt04Zbm9zf+FYWpTIm167tcpPLSV/RIeESEu6HCtY0RYP/gZpCTC/SjZKO5Oq1O6
 jofrp0LZjyJOmESGNRNyeAxAZJ+qh1OtexyFsijpKmAFmsBxQOpyEGY2tBXp2USEWRJGyDA5R
 9XzzvNgC841UDezsKWXGNVqQwObLx9Wn3HY+ZGVXu3VDdvaNofZ2BvqMpgvVlGSvluZRQL67n
 dUvo1ZRKo9U7fZZQ7SpldKIf+Z/2GICMxBbhxa+t5+jwW3uM6PisMkgrGz9ZzX57tsv/HCT0n
 K24n4E8BgPQOfFdHZZT7srhQgkg23ItF2/MN4mf+GZM6iCPO/00yQUIXkR0rbZrks0oFfIolb
 fMVKfcy0u0UOSe70EgNRWh8Eo3SWYlMiKXi3fbBWzJ67NDwwnKcU/WyNhJazT7jFlps9AgUnJ
 TyzD2j/l73d/U4W1jEh7/IAk4L12dpazqtdGUtKySBUVCv9OTYHkYvMcGkBSbbFV66yI4GCb/
 ZRbeLEV5fDvtA8BQqDLsdwxQhqXb3EthECutkgalNtvOi/Y6f2l/vqtv9VhU2bQL8UaqVD2vG
 kHJABTaQ4d0rMpx+LSOzO7hCrK8AlkDDutvKVITC2UxPh+wow1n8vdcyOTRx1HQu9QnudFEQt
 kjWMTPAkWmXDVWsNWl//vwsLd667k8Sw6ZR0LEdXrxHHiyA1Cl1tZf0iWDoYlfXmdHr98uBxd
 G78p766wiRmhOAaU8oe4XFgKjQ84TOfvN+hrhAkI9n9pwGJR0SOhQ3KNOBTKMix7n/DYnqj+e
 0CvrdaPh0rjyXvKBvhtTpFo4EhNF1GqNV26H/TWQBRqHeTM1vaQqcsZeHEzLLtqG0BDXFvOp9
 Ti2rlBdxGpJMTy916ho/qm8Y3BtJXM0nd4U7nHWJ81yfJu+Qmn4mMlY6UKk8RquIdtw/nPkdg
 QwHYjUH9UBQQjes/krqEPElwviw2dAXYIh4eY4vhTGcWjnvykuFnVZQd5uTByfvtbCqSodgr3
 2q7wJrUjIs2M1sI+LGP3dHvlLzTZSv5ScKQWrS2vNuHQrGUXgu3y3kvRuS5XKcRCHD5ECL2OC
 fiJ7QPTmQm+e1kMXOvyo45qjCOAInL3PFmkJhLEENTjg6MFqPBbSHTptRUulKn2jaZegKFEzX
 FNTmDiAoqe9rNDDetyMTmMgPBo+7v4fmNvenlccNtyQpX+9jr60JWFk4kUYFzDt3VU9VHTe5M
 +Lje2jPGlu2NHa+KGy+D0MyXWz0sfo+KTvK6jS1QoB33QXm1StgTGP1UqGWw2qD+l+X8aVRUE
 uqEbKlSz6jm47PwkF9qB+qfsoHqwxMF3ENOGLMj+fmxoQBIAx4oDa28+rH5Ysm7/KWYXJDV3U
 3KzUoRwGgvCLqONQZItxFMWK88AhyPLKO6GrgxGk5ZRt9NXWZywiY5qxn6H70WtZCVbmez1Fj
 S2dgyfwmWe+bNUHJsMlo1+8mjKLwTxPgfNBz/J2CcOp0bb2EiCF2RphMWEeZISePTi25Na5w8
 HDq3HWV/svCOLhau4sQZKb0FXnrBku6E9w+CUwHPzWm3f27ajsNnfc+yomoKoCbw39G33Nd5q
 DAJz9tXxQCKy9eD/5ZrPC2heikO4npX85ynBb/vo2Ru5ZIkCsk2vxsdEMZrNOqX+zG4cXbjmM
 WB0q4Gh0bk3qvXcFp+WNk9OKslnLNh2McuJvaurI12hRRaSPhlQkQYpoWl8o11781VasB0/LD
 JJ/XRTcojTtl2AqtcUaA/FX0M4iMPj8wCEhtHwbSQ8PTAQt7HrwEVZN3PT9svR2KARhhciBmP
 h/AtXNp8O7ehpIsaKoOWLt9l535qj+1g2Sh9bgAoR6xyn08bMlgvojkwvuIYLTL6p3I3RMwYL
 YPDzy9Qp5jXnSla/N+ExaMIYXhu40RLoABU4vaKfLhhWHS2vuAKxewksIhvgLt0gCZPGzRpI7
 ISh8MlAB2fiwdNOhJeGIoF6Y2dOtILDIrgay4ki9ipurNeJ0xHjAGoCaa3X0V+2dpEa2OT5nE
 SJt2RIXhLJ9GQ1qQQBMeQRL3a4EZ4H0ilke84KYKm7tVNSe6nS5P0ECB2sqqPYnNkmwbuNBz3
 X4byiJ6Ktm95t9nLzcw2D8RomMRGM7TXPCmIsiKlFQoa4pzr4dLsPUJdp5ozWKERPGntk0IRR
 FL9wamaa/oZKoVo4Gg4uwBLZaRWjypMa7BWqwj8hg/uY2RfWFXOaiQ+R6/SnK5s0mN6HX5OLf
 wy37Ga7DvSooyR/1ZuIecMifCESZoGlTXqFjYoqyiQOlSMy4o42GB5H0umxWtnVIv6JYwby0R
 S25IqNDbipXFH8q85wzTkakfebsojADVGarKuYz28UEIbi2HlpNbMCpHtcTcrleI23exC6RWa
 jI67o35O+QQ+K86WrYz0H5AvOUMQyX0ik2bH8n7mJUCfJDykvKNGFbZYD9ls+Zu/buWTq8s/O
 g3xl3FMfNcPiM6WwTlglONL8LAmjR2VkVLWwnG+IcVEZUGxM3IMPuRhjd9CTyVvSz9C4HvMy1
 +Vs18K2JznX/9Ta7qCRQx+VZMP8wEbVM3ZecRBCiDiKJlv7SsgPCy0PggbDeDRhTHGl6gipn2
 MbK46QkVxkGYYDa9/8ljcMhf16MyEOQV99G0HkMNJqp21R0kvSJ6oP1MO9WUEbnPJNBtYMuJw
 rvAnPMyh94y8EQTQvaE/XVMN5ji4qPjunaAm81RIXxoNyW9wXEp6WP0109fyErzEOCenk9aRT
 1McXQ+XBtEIuduEX6pKYL9l716UOOwwVMkKwnamp7jLVhc8yfel1/pFXfAJyTgxWU2tNd4I8C
 0faZ+UMwbEWeWEc66LvWAicsHlfYNFSF+3KYkE3YvtjrqacxQV0WVgI7UO1cUym7cu/9Lberm
 yzPSrK9ytct6TuUaPRCcUK/hI5FS3xHKMw4wn2k+uKsXVC3b0FImpXsbUlK8orsAyk5BWlKHj
 1DoLk5GGaGEQ7LSgx0rWtZUD0hcQ6vu04EWxyHr09gc7u7UpzkAOR7VTfk6rVe3PxvfLC+omX
 Xhyq/lNX4iLVy7/oDnQ+BJ0+Gt+TzXGSICMAXk2bHC8/ckPr63F2v3ldXzlb7fZyNpncdjZ8h
 F81nk2UT5asWM2gSRhFf6kfPa9k0sWexSY3CLSlAp0wYg=

Add a function that does the same as strbuf_addf(sb, "%"PRIuMAX, value),
only faster, and use it to speed up bulk reporting of size values a bit.

  strbuf: add strbuf_add_uint()
  cat-file: use strbuf_add_uint()
  ls-files: use strbuf_add_uint()
  ls-tree: use strbuf_add_uint()

 builtin/cat-file.c |  4 ++--
 builtin/ls-files.c | 15 +++++++++------
 builtin/ls-tree.c  | 15 +++++++++------
 strbuf.c           | 12 ++++++++++++
 strbuf.h           |  6 ++++++
 5 files changed, 38 insertions(+), 14 deletions(-)

=2D-=20
2.54.0

