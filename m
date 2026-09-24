Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DD41D204
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276380; cv=none; b=PzW8qTQZkXTQtupRHVoiW+bsHhhdKig7WEAfc92ymigYiJW7jIC48vVd0qb86pRiwKZ9cIcSv+whWB35sf+55dfYulnpvqW7uPfsm+joj6LWhh2oONZEI5sPqbFo5JFvwAFkRMcCcwH+woZX2kLScay5LF//91J3e3RCYIFvGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276380; c=relaxed/simple;
	bh=ycsRP+0HCLDDOxKJk+VXbbAHRmrht7cpybj1PwZFCMM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lgLJwM39NA9mJ1lanx+2LL5Itx7Ct9wHyN89SfRUis70IgJeQg9cySS9BTOzmqg0ApllUDV/Qbposf9f3kj1tTVERWhUN3voBEceiFfGneDp+7Y7AFh316paLQKwf4RgdA6RP3E9MjXbm0/NzH7bJ397mAweR1hY+2/R7F7cz0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZYbbCIB3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZYbbCIB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790276364; x=1790881164;
	i=johannes.schindelin@gmx.de;
	bh=ycsRP+0HCLDDOxKJk+VXbbAHRmrht7cpybj1PwZFCMM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZYbbCIB3WJCY9CboNLM7MFIFtkDVULB5oC+gbj5//xA3tu/BTNV/GKSJV5+9Qe6J
	 lTwWh73K4fxq6Kbl5HU6kjd0lDv0dgav7HFUOQNVQcbsTj4wDc0Gq2fjuydh7m7TB
	 mUOCMHiZ7FKylAQ1H+ca2/nDK4s7I9XFz+MVOxfpZKAZGQe8BrrH0LnAXy45JNFx5
	 LTmVk4WBlx7toQJcEHjNqrc5jbFisaeMTeCucYvwMk2nbf7iTEO2XxAVR32K4YqM7
	 qnhH5MHIgimF2eWMbWw9nZEUSNQh4e0S2Aso/q7OwYnsuEfVhP+U8Yu1S9GWtO8iq
	 CmAP9ZtCgI+X2rvSIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1wym3Q3892-00AspT; Thu, 24
 Sep 2026 20:59:24 +0200
Date: Thu, 24 Sep 2026 20:59:24 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] ci: work around Debian 12's HTTP/2 authentication
 failures
In-Reply-To: <20260923192514.GA43344@coredump.intra.peff.net>
Message-ID: <e94a9d4f-567e-83a0-e12a-908082365e77@gmx.de>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com> <20260923164700.GA28538@coredump.intra.peff.net> <20260923165348.GA29229@coredump.intra.peff.net> <20260923165922.GB29229@coredump.intra.peff.net> <xmqqwlsbc2ge.fsf@gitster.g>
 <20260923192514.GA43344@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:OaoiW7/Yiei4Ezenk+xPJt2Opns1TO8FB0Fr/gVcvKaihxfQkO2
 7qn38qjZ7zjz23Hj6COe+ETv6IH9beGXlpwtoInHUxU0IXTuBPQ/lpmmMyti+piesq+eVXj
 lLet+nGTzsKJv86gMQ8mASMwAtdwr+QJITdv/Ve5c0SwSnfealHZBA9KXDLyzUjP90JIQJI
 75LN21Tcno4vyHUC/xLgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E0uh+c6JbRI=;xjXmNz2nWtn3II0EwIYDdgfeLDi
 6NWhhtQjzvKZBdAKgzG66GMidBxznaHKdCUojJN0eaMsWw+qFTPOQPmQlSEDiu/x23P2Mo44O
 9kp8kcdBqsm2nsZYZPg+xVqxjE+evGH2ps6MGP6Sd0z0WcVis58vYKaglcGU6KSqCNllLCZW4
 HY4/oISnG83MhTpZVwufaVPzyfhRC+06xLUAg+Dnqkk8xZnPo9lpd9/1xxhuXfgP3hNfa8vbC
 ILg+b9RslWgSYA6XYsHTgru9Dhs1GGkSkgHX0qbjYkGQ98tMCK+p50XJPPWBaFQlImjMEoIVR
 d6V/PRKNq0FJQrY1woYT8xUNSwPbk8xqsW7Y9Ynrbl0/Qq7mnY8VHCXUFjup4+s2/2yJg3B9P
 GA596C0gfiVWxu8y1D6ePfXZr0wuurGv0yR1b0RJToldPCls5+FQpzat9YTKGWJC/PEjR6iD6
 TjbORQ+e0o5qJ5kvWUibBqlLRVdgg9hSHqg4lFpDxq0biaFaIibsz+ZOm1vgTAJtcdTJiX6bq
 TVzj+zxfDx0ZxKBgkYkFl3J4t3nB9vQlSN9uZF47HnzGaR1T+wphy4V7aO5bbvXZTZ39y7Avr
 zJW8m50sSLuvKmhyLQ3alW9+X8Se8S813dzoN/xZxq8ovK//+mCYUxNXuCIrIvGhQb7aAzFcA
 /5RoffbYJ2ppIBn50/CqSTMZMh7Kvg0oYvCsKQ4IahZAkUf04pqXdGzoPJh6F3fyHuAAi5ZD+
 57De1khcWP9zJaCY6oss+s5ms08txqQTq2AArZQtzGpd7uEy6RnDOt1IPXYdTWXwhqGBxacj4
 wFTVzsz42I3MfPNSnSyNyp9RRRzXH/3oINNhgr4yHKxgbYeWQ0FAboWbU5dq0tDa89W7H2d45
 X8nWEQwBO+Ogi0VNab726JlJQF88BgvBkC4CBYA0A+QEU0O10NB/j+VMHfo+4vqdVb1PqtZBY
 Mr5ouIKgwdf4JmpnA/4QQKeuGHY9W33S0UJWoZXNY/Zori07X94XurmUtkj5+vF8MfaVmvbwp
 hgYtjVbuVirXzV5FUwtEWQJSexLmhIElplssS07IePe8k76FIqO+3Y/uBcV4c1pvgiIgJXjTY
 3KLZB1a6WLS8l8e5N8mMd3gpIhYreDmAqIJswhtljOfMX1WuQUTOg3gk52BDqZyskXIf4HAgC
 6ZmBSvVN2Bgb38dVCgcVazn75rEIu847jnZRhcrfsILmGxJ5UuuJPppclGAqir82w99XlDraH
 U+b0V73S9dfXIhFegfwDp56TZxi8ZLtxuUwbgTJ7fAgyV67Gn+S0qzsl7bjaZgwhsLsNyQJHu
 HN4Rh07sZauS7YHQGXZa9okaL+20YOQ+ACgo/NKbZbgzMxusOyG4nK6BNIiDblxNRJ6udzFEh
 WmnA/ar0mvv86L+ljt3niU9VrzhCcuagtHAdiR1NC5gHpbURs8fW9w/T2+KJsBUbPMZu2SWWD
 pjVJQ8vC6NBn2qcl+wrlU5SfCtbqk5xUEyf1Ct8HuevjssEcRX4SvQb1Ufe1vKPHaWntfm34d
 IR9y9x152mjWaLs/qDgKCXQx0B1iJbw+ermE2lQqWeGHgW98BAtyI9yiW5LPNdn/EDX0qfCWf
 6eQFtF73vILhuVUr7W3ENye8+f/gJI1teYRNehS2zppbSIQ1jjWjcSS/EAl78rgoh3IEP0Vu1
 ho+VhoPCJb1Is/7vPDusNoamn7MCtwyTQnwWJ/M2wJOLuqKWOkJicHwQqSBWsRPedRBrexR0g
 cA2LROxKhpriuFrMI38GMNfYQUrxLLKQixZnas/f5l7acal2NgE5RAwdyreEuU+fEQHQJGtUa
 pTssF/u4/hzmWHhKE0a5Fcyupgpaz/uad1DgFMKf9fp2Z+sNJ1d3PgXN8vQ6QLPZVobi5w5ic
 2eO3W2p5xqZefV3HLjmirVPPFzk74XYMWHUUfzzFXgqVkgsL9iKEl+EWmsM5qlVYdw+lhaCnN
 0a8KybbnGywAIcDi5sy8UojnN98kbYMcIFBu7kGuupzzRISvmkUJSK2KTNqp2Kir3FrNSNvg8
 1WkLziTdekFCdLR/azwlFOnGgR5sjX3/FYP5l3SJsGE+q1WmgWNl7ngkGQERkgcZajcva0J+p
 l5qI7r1uJiyfrupQVi0arfty6KMbDv+l4WMU0LDwaxwqYNmZP+HYxo1LDu1JoKMR1DHvRxVI1
 ulVARQWZVsgNYcrNqjzL/CEDz49vutlFD/VbRccosNw4S8dySqqY/haQSe2eg12S6NLX9dSLO
 spMpaqNF1pc7m0lz+MjZwHFuWsXQwQkJufCDGBTEtXN5VWeCRA+0s3Uq0U2Zmy4ZMDK8wglSs
 zqBn4xSgyZj9FmmYIdtnXwpgoHNfwpL12gCzga1eUC02TPuVEgcosUba36UIfcDkWSbIrH9SF
 FVwrKeOj86GSCR0yjPgCxXbojKqFxTKWAZdgzd+ARB2OFnQIQR0JaNtGDAUi4GxPUTC/ohxuD
 gWhQ+Qrdy5Ct3oNJjsXPRHGA9f7NbYtC07rwBKGAMi8EaiEBNznVlBwGAaT/6v5mN4ER7jpay
 2ZnL7kXWJlHrUD84zFwKgQpt9qUA2HI8+bwZ2PhTHw+oKZH6Eujjf/1YSgwDgXmTHZIwc8fFL
 Ak/1079ZcEIhxF/tOVyqJe+SiPcpZ3v/rZokh62dpBddWs7o2a06DGFEnczbQd04cOlqi1JrO
 IcvrAFXAuNQEI1L76NdE92SG9tw12okHpn1bhohfE7AUHTdtrSqKkSuFl2xXShaIZq8r0G4ko
 RjYcrBcjOBv1PTcOIRnCynDOdpJyWp5etYYj5CDUqvIJPxjZ1WNjzupzQwAMDOPk9HfVM90g6
 535I8eLlBwevnqQ8cvHynR/2U88tXVFRV/RnTw6K8LokeppxOTl1jvz5Z3duqJqwu5e0b1aZY
 U+m4D1E1dOZIpoLoGiPFiyNCIkisN80UyCFF/AKkYTugktONkib8FwSs6GeDewSMAOwEX7Bjb
 gNuXEDRXhTKuujNkKced+JQcSB3Tn9M0XoKje2UuQicqFz86pwgPwl50ndY6/IvE3fi5SIAIS
 8kTE1802AMuh7kgSIIUv7Ni4HhtYyhx8b5onsJk0Hqdo4ZvverYJIgNhVUrA8zCR8AbDMuZWc
 Okioi1W1WQF8hED3TA8byQFLL62/GCn7gKjaiGrS/AG81d8gVrT0W2dvp3FbD3Je0MlBvC6Rb
 WCIJ+gcH6cyPFJF3C8iIWvGZ5nMqxWjq4Rqgg/4vKlDbjretqmMU5HeiM/ukQHG2StcpvmBWB
 yPcA8FA2zbk2E0womO1dPe5hviPV4jugVfO8N808mtZf931PNC62nb6H8uNcZQzjRrINTC7oX
 +ZITIkaEcRdUvQ9gSfqwPWLhDYVtjEMArrO03sDT+owApRBb6+vmqAanqI1tuA4SsgivG5pD8
 DVouulLa+7jKwYXPN8Q3faV5f42qSwJr4EC92Gv7+GssnW1VlJvUFy1RyIOkpEDfynU+o2GmK
 uCGwRUHrKwyQIBbzsLOzo32/t/RaZT3AN7z2GHTgJ+x0+0mWIrp7Jjsg0HBxddIs2AB1oYgw0
 Q8ljO2dFfaJGKBZLrPmIawE+DmDBmtegSeQ8d8v5Um1pb8mpSniAptmxRDo3j7awPP2TbTs/t
 xwQ9dEuLkJo0irTNkDMeMd2kjyGUWHLBzZ1N2dvtFTWqxvH0d9hAc7m4K57xg55gfUKHf/DnZ
 x9rMICrDAQD0fUFWS+3lpng0eTnb9Ia9q2GDSJ707yXskVmpeZ8IZ9OrszynbjqZrpB5NZg1J
 8veZrTK2sg43lO/sFYx4iujjWqKmY9Ba227/OqAtWGp1jLnmtTBNnX58sC3ftkR9W/psmpiEz
 DisjejoIuJxkqK/6B5DBxdx/4POiqkibHaD/c49ggJOzmVgaicweR2r47oNUU8q1xvuSd6HXn
 1q8C2bG+uuNflXtEeqTZ3FsAzkZ7ueKPztOSVc0DJizR/GvagYkufZf3IK47KG2PP8dNT+nM5
 b3RIV1vzcbF7m6w5nZ285foOVKyssyCMxOeImvkEVzII7Zf1WUvfWDnaRwxUjHian1qTE2j6E
 Ve2Zp++k1a0nMwZlYxdjG4qHrqqqVO1dVAhUOh7XLziokH6KRzQkkeL5gBmSZk1kjDfzm3djD
 rWsQmhi5kosqt1N9nn/9+MTSA8tSOq8eDYVd1466yuBTtN+Ub6YezGeM5ZI8WzPBigbVr/mVj
 oZsDESqODMK9zAKhox8xT3O5gL+smOa9EES0w14LhpN1VqAMh5KlU0FEOJxUwFftFNxIQUy5i
 8WQ0wjzgRPdkdh6Iz1USFYZmUvXS25jJnaJo2tpeIJhA+89BcyMK5lXXvVbQc5YtIwqSd2R1D
 oNeHdG7R0mUWY4wIVg0JzVdvExh27ZwSYBwFrfT4cXgcOg5xcIepP77k7TUH3uACENWkLAeFj
 x63a/ZwlZu58GDP1rnXSyJszQ2bDgyS0U8NHtM5lBBsbgBRVzeBLrctt/jOhIci8a1lJfBRH3
 KLbYbwS6hKP8fndMO+yNHT5z2eBztGMLI1JJMzPBeiTIlc8hZAadeVQ13sngUs/91oM0QISlO
 53MKXW3qDSfIJ5d4jJlLGARiVp8d/Lk2kxzeclY6Xs4eIxdQ27ULVQx+A/L/mcRHFjkPBSBUx
 Z1u/Yu26O0jkOphzQEXlv34DIbpMkOCDJ+jEMaaQqXNwvz4yAVyes9fWf42Ey2K3St95Ai0pe
 hqU/866PEGXJ59bg/abAKJKz0fpAIuCQsqXqadzc1IU0zuSAPF8YeUK7ykp3L/3BOckTdFukV
 xmG9CFfCQw/U5/53d5Uf7cKFS7KajhXhUr105GQimW6cj9SKm7nxFrGEvwgh4PRUqVwEl1qxi
 A7kNhgUHjbNye7c6AdDko0mAiH4cS0byHwVJAoqfOBZaYr8HEYT1xSbM+vSaFXyTHa+7YP4L2
 TBsiIvmb4w0ffZFNKQM1OO89ObLMcihTAOh8AvEIxt4uxZH5nMtaQWQUw82n8N6YOr8AMCGTy
 NFo/Dv0jy19ppxAggO2boHJZf7ECo9Lvm2BgqTj5red8N4O2iLekTe9DRFHE2T18jGg8d+RWN
 tBJtZ8RVVCuS6vcoRnpVivMDl48nvBOmk+hCQIiVJdMX1ZpB6/p9WEx63JrbAcg3Ng2Hn4e71
 3ZLsN3G2jajfITW7ZaseuQWj6TEYb3tO3nEC6yxPgwlm+NQg2Ausyw3Nn5gbFo+HaCx77TkBA
 jKqIYX7etMpqPfPSwvJn+y1tv9qo7H9vXq48O86SRYhbrTvM8dsi/YQJLcAoSbAeAMBjsYV7X
 NawT82VXR3OaRJKZElTK6/D0yQuB2VyELwaItGStabUqUXkzbempjbTXvSyshxd4+E+jMDvrU
 5nom9Ef7YynvB6mQR1io7Tz4tSMpJI2uvXAspTq573hgKDnzuX8lWqQykaOsw/2QeqyRm2OKQ
 7E5gJOpQpjFqQ7yQCxZt62DrFulk9FviYDvJXMPAoE5vFnGdhLV8PjvRXExxmIGyZShHlkCs1
 A+Qehhvh/vj8zITofTyfFc/Cy/ZmQnNeC61LoONzC4wrq4zS+QdzXsZvXcA28x/x04cLd4LiH
 HdTYpvg8Z3XZ82+pzvl7GlRB6XyXvCs5yYFnHAN0txuAKYezwCVAFBSy9xk/MRB6zwUGk0yWv
 Q4+PM0an9ezMg0q80GWGaz8L+Yz8Ltav7B3sdX/tRugp69Pqmw1w+7iolSpbBwPECiLiueAiE
 Y2A7jLuwPyQLXO+adLl733qQmrbVApViMxafHZzKOafoh+kDlsh0rkVBqa+Pg13cSJ9q3tHRe
 VOUL66axtwqN23AyancuKLJ96Johm9/pmSJbTqyHzUNBC54abVR8xfwTzsWgsIM3pdiwsVkBM
 TAKyNYZnPsiMmsMOnn/A6AvJFOrOSd7rNraOrsEPtkoJh7007L+Ejpo1wte6fxj85IVyqa3sU
 C6nQer+phjURxEHobtPHM8RtF6KWWhVHasQj3n9ErsUmBO7oQHxlnaS6RGPhe5jgG9osUzrZx
 2pAJswKmbODgB6tXok2UpM8ywJvshBo3B3QNRpK8M4YfwIGsjZXniGAAekUsxTGAKlC1DEIWy
 WX0DvtLEsOwuOGfBfpxdYLmGVO93r1k0osDJ9Wz/O6nUVHgEqRVXgKj1jI6Bjgq6tmYABZpfQ
 Ob1egEmEhy9/tr9Wznr2OTiZXSzhRWA6nQPA8peN4i4EMBVahlWbbI/nyaUVAKGZZUBOxc+7d
 +aX/hL75EEo//8D4IvZ0j1jJ3vpKWy8Gtu2bGy70KEnTF8z7MZ92IUc4R9mtIPHz9Wu05iG44
 ZPZfwaupQ9MPZhCvEx/AoXTRdJHzEdtPYq6HiB82i0Dp+j1RuCG8ko8TGw1j4sYEOCBYxtYqk
 06+u/VlQrzFyKzZxLdRsc/HTxn9jnrElJRcBkEgZ4KyaAVhe5d1FO7WptV5x8jcO3BcdiXOT/
 MmPG
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Wed, 23 Sep 2026, Jeff King wrote:

> On Wed, Sep 23, 2026 at 10:17:05AM -0700, Junio C Hamano wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > > +# Curl 7.88.1 can fail to retry authentication after an early HTTP/=
2
> > > +# response. This was fixed in curl 8.3.0; see
> > > +# https://github.com/curl/curl/pull/11756. The first affected versi=
on is
> > > +# unknown, so conservatively assume that versions from 7.88.1 up to=
 (but
> > > +# not including) 8.3.0 are broken.
> >=20
> > Just nitpicking the wording, but if the first affected version is
> > truly unknown, assuming that versions from 7.88.1 up is *not* a
> > conservative thing to do at all, is it?
> >=20
> > If 7.88.1 is from an irrelevantly ancient past, I would say that we
> > should just skip anything older than 8.3.0, but 7.88.1 is from early
> > 2023 and we cannot do such a simplification.
>=20
> It depends on what bad outcome we are being conservative against. If the
> bad outcome is skipping the test on a version for which we could
> reliably use it, then it is conservative to only select known-bad
> versions. If the bad outcome is somebody running the test and seeing a
> flaky fail, then yes, the more conservative thing would be extending to
> skip older unknown versions (potentially up to "forever").
>=20
> I think you could argue either way (and I am OK with either, or even
> just matching 7.88.1).

I had GPT-6 dig deeper into the issue, since you're right: This should not
be a CI/Debian-only gate, at the same time I didn't know what was the
first version with the bug, so I suspected the version range to be subtly
inaccurate. Turns out that the bug appeared first in cURL v7.88.0. So I
adjusted your version range in preparation for the next patch iteration.

Thank you!
Johannes
