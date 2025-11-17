Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74530AD02
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763418976; cv=none; b=WCLs55Wmfb+Gqnz4tB/G58P74B1hs2TD8Ij6Sf7nnAWqy7oyZShWhiAFtUVltDs8aM34JQa/YQwRJSfnjB/8fS95Httnur35bDM9LlKmVLcVqZ451VdV/ekP9OYDcGscrAsbRZq38d4v2+EkQpEhQNbaHXM8eLnZx2V09v93I7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763418976; c=relaxed/simple;
	bh=rn4zNhtW/oAqNMcnU6/WoyZchDx8ygqvdNc32k7vIWI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HS+GGDOYwbntGgcbJDGIgz+Tu8K1QMCiPWheKjB7UzD1H438PuZOxyb1CgNb4AaXBhLm0c+Fl/xbeyaP8RIfcw6exHtus8Je+aiWySo5mLjzSLpu/PSuCSKTChmMxXWIxZj+kQscqsrefBbpPU6P+ltWazw1f2VrwR3F05MGXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=e7TH/VZN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="e7TH/VZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763418967; x=1764023767;
	i=johannes.schindelin@gmx.de;
	bh=rn4zNhtW/oAqNMcnU6/WoyZchDx8ygqvdNc32k7vIWI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e7TH/VZNuZ+cqOcl7i6Q9qTN3tUrwAPJwyI/JvQALpDwZYCNlMdFf799DCCIOvWu
	 UUSB9IxiTcS/FyutxZn73f9eQMyIkhvqVGHTwDFLuffNg9qGvLqKfpO1F52WyrcZZ
	 f1SwG43dEDiTs5t/rN+42iknwteShJIM42xwIln6GQ2XH8her+MWIJZjuFl2TK/7I
	 vGy/mqM4yHSehNFN08nD3HZtEg9LrO140saWklzm7l7fEIRSTWpQltzCDKOULAm3v
	 3OXrJa7uQBn+QGe9AH7WRCWlQCk2HNd+J5+DmBZ5GlOp8CuWKdahs8yVKo6BgeV/O
	 LIRn6bbw2FXytySoeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.224]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1vyqQq0xmh-00kU2r; Mon, 17
 Nov 2025 23:36:07 +0100
Date: Mon, 17 Nov 2025 23:36:06 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
cc: Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
    Ben Knoble <ben.knoble@gmail.com>, 
    =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
    Jason Cho <jason11choca@proton.me>, 
    "Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
In-Reply-To: <CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R4oO1m2xA@mail.gmail.com>
Message-ID: <8cc4ca72-c87a-acc1-e200-53be14d649f8@gmx.de>
References: <aNuy1aab954D3rJ1@kitsune.suse.cz> <E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com> <xmqq3482312r.fsf@gitster.g> <875xcyfk3k.fsf@osv.gnss.ru> <xmqqa52a1h6x.fsf@gitster.g> <CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R4oO1m2xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XCAubzqcelF2R7SVoas/a5+3vPTCei9LVEUoAORK+XmrR4PAuYI
 Ssbti0hNhUOr/ijHjjix7LtcHaNhjmZ4PZZeUYjCgUlcqKZE4QZVBH+39mAKKWKJ26wnAlP
 dc4hPut4ZUmo+Lh6iIeu4yQR7HLUssD2AEbSJUtb3GTjIQWPpTWcg/1SQ/IljH1uUkYjTYL
 Cw6EF+F8QoctDXknVOFVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U7mCDzOsJ7o=;+z8B+iUNPOygvKLQ69Q2XNCwmOk
 Lq0WD+F2iTyyFgnVgPAzUIHyZR82UHU9u6KwnatmOOSiSxXmnJRKH/d8odWZvle/1nCCTbIx4
 BGyHr8tcxFv6eDLYGqEuI1nWsg+tl7i3aKQg0JfITn229f1Uh3zwp1O4d5IhcN4Z9ulDc8f6w
 pl/u1ObPcwXVM182wB7ntg6oPwXVz+GVmr50wD6vlNXyaMpCDLGZt46Z2JkPbH5aFeat3tmDf
 ANDY/+L355bKkPzaG5zKxMywHTsZfKrzVI6+5wFJAZWKUlHjpZ7GUq8pPuxVC2vNkOA8BAZJ0
 6k/wVA+bMSmLCJrDs8g4gV1MFd3/WeDHW56JGqMLDl6m9cg66dBQ9aV05nS55HT2mvJiIyYUc
 z1KQdv29u7Co3c83VRrRYUtvpB2OCCwsB0wKpYm6HbMrq7/EYIyXQlhhtMDAYzubJVWVXUOP/
 9VKPVHWxbPbx8J4Yfw2pJPe6kgpgljNn7bUWncJxKi7SfNaC6N4bPP+xmZut59uPPHyXTn9rQ
 ygb8xq40f/3ANOTq3ZgtWV4bqt465L/ETQRnRw5V90hVzKwkYKzFEJ1v7vjZZaByXmTIsS8DU
 cZPUBEO69BVVsyzd+lkKimbLArlc/lsPy17ua1qrZaSUlAgNk70CP5Pts7xCCMU3n6PYJUwSV
 Mo4DwDmIUK5J7aYttB5aZaBjyiyn5c/1dts16SI0JLkFWNi2/1UdBmcvmoang93qkb4mwUV3z
 7A1DdKeNVZzCKXJBj+bGl1GuYNVAlrqgdQBauLuFx6mrvxkpA5nuZSntJq+JdpObyPqoh+W1l
 SvINPXMMspzjdACg6mVFeeRwJCbBScsX3zSZ1Ou3NXlEMSzTaZgld0o2ymGcGD/n4afSTVgmY
 pLQ7+tyMrrV1YJRoNbzaJvHJC0q7JSWF9lifOyxbhVwRRSm3zuUDptTddf5gqePQRLGNHDd1Y
 Sp+s/33aA8VFbEGEsJgRXGfZ/GHDD1MUKT6LMBT6S9XijcAe0J6WjoybWNT17UYca3KKtRCK7
 adY/BoJhXbLgkaURiGV60qpQX+gTREXa97ob0Jk0WDmodYuylK8Z1mtmU7YNsH01Fg96n2nPQ
 xgy4BlhhL6l7WHWGL2qt/3JbNYGga7PI109qv+KxzmIyBRIeM0SSZs80E1UazezGZCRvGJ5YI
 DSGU4E2mfgXfYRqe/BMHfOTokITfdUZ/F6SM9lxYp9lsLZUslwcEhlTIt0IrrvJFA1T8Jopvy
 y11rinfbhYi0lsCrdClM4jjqOZOFFbjdmVuJxztW1ELp0KF4Gr/TJ96LWk+3MU06KhXCb5qRN
 SeagMyNzN0YW/DGx/XlAmBGvEJNqb06SFQK/m5aW3Lmntph3VmYrVEpdKChXEvsABYnMzb3gt
 56i+Q9YsFyN8VQE7usrZFXYyLXB0Gzb390XpZjD8Fm33a2JEL+OXr3lFLOnZCR5CCmcI9P3LY
 LhDIRC63NymjQFEdNWaGxLw5OX5VIZaB8ZP+93DrG5s+CKU+/90uqTBEKEtfJeDedFTmZNnEZ
 GndMvfzhL1b6xm0e1mJI8zdG5fEEfOG/tNqkYcdaZRbW61Ka3mMyTJi5h2uCOO3BSDtMZho/b
 lL1aSUZj6tBxVczDZyBZfbfgj4K7D2GsoJkggy/1LOp2n9g3hVpm3Is+eqLVnklcif8g+BllX
 k84Ro8SXGTpVM9eE1IQXbD/fKiHwQos/Cp1kupVzUNGqf/e5TnS/1srgRd0sQfc16XrcSr+oZ
 6OE0vLUkA0KrMAbE8Ij7Q5aEg21/aLxujJHaZaoL0SeYS3wpb17iFILeqH32iNfUcPMu4F+v5
 2bBss0XSY8gpocY487oHbVK50zwBdigm+6rR/ZKSAh0ZzbdIoGO//lS9xVAXeSGKxYKBi997k
 k3HcOy1+tT/QlYNoxnzLpRDRQznRzOb8XlzvsneYEwH5ROx5k+SYKHIwhEJAUyHiDBeq+id+T
 UfnhXJFlADXad5b9aKrQ8RN6wHFvcI8M5LHInpaP5YP46wXkKpNdFW95S8ESlEkZaD0AjoAtC
 yBXekJK+NH3iEPJtOzmoId83YrCHY/2jqi5BiFZwg7eVPiiJ9TTDlqXfLQRhEu+UAO5o2u2FT
 9UoYFmccLmYI/wKehWIyAAYroXiuX4R4hSfT6yP7U3kUNVGU3YERH2nT4gnIif/2oQOcsahnK
 Koj+bp/91A70w1jeJhd0h1Pv0UsYvVbZk00sszGiOckMnJBnb5X9IM55Nk7mYW7I9o4a3P/GE
 h6l5tmKho7hicIW7aOhqSb+jrq7/5O2XY4YzuZRxP0xyvDTkKW0ptwSVgponZydqdWv0vZvaR
 st2QyYJIg/7Q1K6QMxWFfpZGEU2SVdTNjqjnco7C9QUHhTG25lSG2Yt2bAY+30lGDNYxvIz3W
 dVG9jgtDAZY2m5gjNGn/4I5vKmOVxH2hQnkLYDAVrXXwy+/QUX1U7rmFU3BRP/m+awrj8/RVS
 6HTBiCoA/mGzuBbzpzXm42eTnzKG+njfFhKcRZmjJmKOYc4uqmMUEcJQpw08a03e7F/A0c4yR
 EhGuFPDdnXgPsqOewg4OyGI1YYeymZVFVkJyA9GlBh8vfBzDvbil4ApeEWNqgWQKRtT3skcqf
 kHCJ5HHcmFKwGzCiBeqYueOTkTpz84oUYgz9i1BP+fjbyTtWIZwmyV0sdVBxT79tEtWIIRB/m
 +CA1h8ZTooL7dfTcSivjU8S0d3bYICeTJVvL9gr+RtRjrrPF7Bd0glll3uN7+9Ij4tLtDIimN
 FxxcW7ACv/rLRgnEtOWmnKfO9oNQojdWJnRyrj77sxkl2AR5mrH9wSXw4yAEx+b1OQuVGYcbS
 94Hco/zbpyjzJbGLmsevx0v7KQ2Almd7KZCmaYNl93TReh4I/Co5ySJSh872KcuLJVXZlvSYb
 ccRqXxTRmzR52cewkMFZfF2nHt3l81TuQRudZUOHzvslGdfxGNluOCLBXMP9RzL1ZwbBmlN/b
 BWdH1UQlExSHkRyJSqxa29PeXseBo/YrJOMuOjc7PCTIfWI5ZVFJj1I2CuQDtUwRg+bZwcVDH
 pmxvxw/cAN4G5Yd4H7LWZW3g5PskQqfOr2WRA7IXLqw/9UgWvCtyALSaybZO/Y9vIq7gsDQqu
 aDYsxeanHTT+xhIF+poUbGM5ol6EhYF2CbSzmyc2H21kC7Y7jlgFZmMPdDUlVFXh8a+GfeTt5
 HfAj0F8MXuYlx7Us3YAV7zEjGaXWrPtjPY1yd2jxpSL0VumTLkLc9fbbicxwiC4M8EvBgjGbO
 CAsvvEsBy084ZKpvReqGX/DzaTnRA8f+2lQ6e+nqbdRXQIvdrXQQ8Te3UDt4GDLZuzYFh9BfH
 P/Zhte8dXLmCa0o/LDtVF/Em7kJY+K/qhXY5B+SuUiPEVUnPQqJdk+a4C3oJEhqeO7k+1WNra
 jZwMT2eFuhXQ66Z23FOhjK0d2OuSYD5Vs6l3krOTmnuvANKC+DWCW/WzVpING504ChbuNb9PH
 x7ic5aUvkYdqP+k4BoO5YPjyBohI6yb92YRgKZeNwXGpLpFTzmKo+2I1gcFZXG/uerynaapK8
 XZiAjt/NQDxwIQrWLoEl7H53+iaZKRt+7xkC9t5HDAR/j+lD2mcT97HQhE82a7Ww0v5falRfJ
 RlDUJgzGWOnUfv8qmqEg70fBZ9bbL8Se92VjNGFiV94qNutRIrnTT3JKa+l3CLtbUXb/RtWvh
 grooQ4CaHsDw4WpgyLvJOdILe+nLDtzPQ3qzKSyGFowmR3880K4ewXSsAjtmeVdWfg/MR3kRU
 F+hDtI54ythOIxXpwOrfNVkTkOeMxjhSFc1fAwwG6WLwhR1Lb06lo1Tn2VjHkwTnoQ0RlWBmL
 OzZraWqrOaTFsvG3qXfvLZsW+GVzwNjJEsxDg3mBjYLRVgjXlYd/44tnJNqkWkGyKDZpWhoFw
 7RPzmss33x7ZnbUbScyXK7wYS7iUlfdhbx2rdui8JQ5S1JfCPIvSLFSQF2LFjpxOSpD8c+swf
 B0V450EHpGDNAY0tFWoEvIZSGhnEESM6mb3oKgMEThYeAk1uX6EGaPuRXcRVMYFkE6i45ptjC
 xR8p7kzOXa9lKD415Zn0SIJ5NvNrjzJx9dBfSLGjP/ibg/Xoq2cWU7708pv+I2b6pchhhr+Ax
 IrOQINt0RbIYvUgL0U+0Nd5DAOe15P19VnVzXgGw77Qr60EZMwQWb1Sw1oQyUQ3/YCpx5Qmjv
 GJeJ0f1tyx/9WS+URzVxb7igWvFFESsrFqQ9n7fsoZrBtJAu8KvtvFXaojD3ycO2US7+ykbb2
 xYAZ+bhDx32CR0XHZ4vC+cy6ZeJF+Zsn8OoFDJ8SPOG7aA3h0hqbu1wHob1Q8LKggMm4e+rJ9
 KR7ILet77ly1SUnqf6NgpaT/jBuSVLoTjMuYVgW8tAGzKnFZj3S7LsUS5EYD5mo3z3/pnGcxY
 hDbf59hpeyKct65sv5X09lW++z54CsMrfcuKf+mgPGk2fSJO71GX9cSnFsxlo4uK2OS1rClrq
 OxNl4CP3r6IRphx50EaEM/izWMmBTgFZ1Gp5CS58wSetB/4vGKDUr/vnGnwh85UbXTHogU4JF
 h9fc337VgzzPikfNXzGn3sLAnalY3dRhwAeSa45agLuDU6WnvpS7Oy2PRHBvIfd2FKU8lhCdM
 rhOfSoMdtURHz0BqOQhx9Co1W1YxXFkHGd8jiBz7sMeZa3KOL2814/0wbCM+u9SI3TBOBN0bw
 H3fSR87M1EO9GrBxqNY9Ix4EUk5dl1UFI+82wfceQnStti9MyLa+K+qTqZWuvoK94tcwo2sOH
 YJaGeyLvHuIsa0zBvnJOFdfZyTklUTlAS5ritl5QTnn0ebLGNvLBrjD6Bm5T/Z+mndJCbNJfL
 l6sIDTPWaCGmXhQ++0tAg4ASkGz7GMsFitJMiQeUZZhtLKw/hd8d7uRN8bNVmNHz4ih91FSsU
 v6+Ri4xkJMLvU7OCJ2ckxJABscMnL2ZTfkR0IZ6gDqJlI+kJ2qHoOYmxprPdH/x3FBjoWZXht
 MBd41TeYOHuVsApsOg5v/ZOgtIDHyG0yb+tKjySjLVmcBrDBJjqpIKREZQ5/CwG6xkiJECFFX
 oFZo6D91VC7ZIUf1WbxiK3M9u0Sr4+8/FloAkf1TqJCqKyS
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Wed, 1 Oct 2025, Eric Sunshine wrote:

> [...] There are plenty of people who already locate worktrees as
> subdirectories of the main worktree[*] and do so without problem, and
> for whom it is a preferred workflow, so I don't see why we would want to
> penalize them by warning against doing so, especially since there is no
> technical reason to avoid the practice (i.e. Git handles it just fine).
> [...]
>
> FOOTNOTES
>=20
> [*]: There have been numerous emails on the list showing that placing
> worktrees as subdirectories of the main worktree is common enough
> practice. And, as far as "experienced users" are concerned (not just
> novices picking up the practice from blogs or tutorials), I recall an
> email discussion in which Dscho has said that he locates worktrees as
> subdirectories of the main worktree, as well. I, too, have done so on
> occasion.

And indeed I do, and continue to do so because the counter arguments in
that email discussion looked quite weak to me.

In the one instance where I heeded that well-meant advice to create
worktrees outside of my main worktree, I lost work when I had cleaned up
that main worktree after verifying with `git status` that there was no
unfinished business to take care of before deleting the repository.
Because that secondary worktree (which did contain unfinished business,
including a carefully crafted series of commits) was now obviously no
longer a worktree but only a tree without a working `.git`.

Ciao,
Johannes
