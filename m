Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990132D5A19
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098901; cv=none; b=YWyIzUIypl3ZKj7HmZuAZH36mkswtXX3xuhSvm9plXc9V59A1gs7l9j7OcnMtIFEzAIzQN4xjMxJcA9/ewQAXXn3oh9rVoOSl/dYc6UUDZqQPfD6YICl2c1qlVkOUqkeCysTxyMaxkdBMTxboOAOVwkcWeI2yJWkzaHN460R2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098901; c=relaxed/simple;
	bh=50ay35MupTmzHDOO52bG0se2d4KCbtk4FY/wBvPTQFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twSWWjL4DhX6mNr/H9xNsc3q4oK/8Q8tEFSPPm/0okNaJH6LZlMBLbdgAXEYxLADB6V6I7i0lYAYztFa663UGtn1P3jv62bcPSdQJ40F659u1OnTNrX1YVP3+jU+POsCrMJr+WmfYDbz4SJvcnyQ93Gslslyh/pZb34UZvt8XpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Ma5sJGxQ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Ma5sJGxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774098892; x=1774703692; i=l.s.r@web.de;
	bh=28XcQZT+N/+DTPUILHebxrCshqkqBH8VlKXgm9+W4k0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ma5sJGxQzJAqDdLZpOvnYfZti/FqnCA49Z/igp2la68nCeeNGbpRuaG01JurVF4k
	 QCd0S8NNffwn3Leuozlwillhwu4PSjxhhtpW66eeMhE6CIpBdS8AHusfEtphys9KG
	 V7jfHZXOb1SdtXSJptBPUu89VNrKneI5zXTaHMp/tb/fGn7yeTM1oLbwLLogEZFs9
	 1jE7pDJdQXj6q3eCgje2wD95tNcAczMuJWRyiCFru8ic5zReEr9MMaTzHH1lPf+qN
	 bSGeFxNk9QbqtyH49XPaSvuE1JwM/8iJQi+zIXu89c/22oaSDFLZzRbf4KtINolRQ
	 UaJqCgYdMsZiuTACEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YJB-1vxaNR1gd7-00H3Y4; Sat, 21
 Mar 2026 14:14:52 +0100
Message-ID: <bed43331-ad9d-437c-a56a-94a50877f719@web.de>
Date: Sat, 21 Mar 2026 14:14:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq341wnvbk.fsf@gitster.g> <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
 <xmqqcy0zgtmu.fsf@gitster.g> <20260320041803.GA18125@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260320041803.GA18125@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DXzHmecJVQT4FwIxkjlT65p/I/1I9//edI+stqXaaAzHlA7HwDM
 /+wR1zNtC2gDlNa7hKXO9ZZ/gG5EXPJJlkgMFGcZFa9Goz5ytmh/aeKPlj/ame6AxhW+J16
 x3hAJ0vXn7VZJFkvv7Sf9uIIT/ze6oCzmPyy8PtruBi/oBDGU2yIAh76S9vhPRAYxcPiRhR
 zo2A07B6yntes0BQVog7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qEfruDfwMf0=;Sb8WM+/nHRTCnM3GBkXhR3Gxx6e
 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

On 3/20/26 5:18 AM, Jeff King wrote:
>=20
>           ssize_t r;
>  =20
>           if (feof(fp))
>                   return EOF;
>  =20
>           strbuf_reset(sb);
>  =20
>           /* Translate slopbuf to NULL, as we cannot call realloc on it =
*/
>           if (!sb->alloc)
>                   sb->buf =3D NULL;
>           errno =3D 0;
>=20
> I think the strbuf_reset() could go away even without any other changes.
> We always adjust sb->len in the end to match what happened with
> getdelim(), so there is no point in doing it up front.

Yes.  Same with the EOF check; getdelim(3) is (must be) prepared to handle
that for us.  An early return at the end of the file avoids the translate
effort once per file, but adds the cost of checking for each line.

Ren=C3=A9

