Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBB13D606
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743698; cv=none; b=QqR5XShFrxiWVaoOQTEwXTGKGWNuNJX5olbgEYA+IDsJV+K83+9aUGicGkyZmV36AUC2Idf4Aj0bGYzMyEzCxgUXOyNxcGkTVcoSAsuGBRyE5NlnLBE/jD7I83P04ztBP18VFNVPdYQ54vKkN5ZR2e9Y8s7ZYlO/87TkMBRptRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743698; c=relaxed/simple;
	bh=Vktcyf7dEu+WFhmfSfEa5qdk8wKKJd6WtNm46QJ4NwM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7213gNJOj8qDPi2hJz7BEI2EDowBgL+ca6bnpz1ByFfjJE+r4BvukPnDEd96CURrCmTb87eoFIkrIYDRqbgbKWd9M3zDAVexQBpIvkBveTpoij01y94/+3gLrlaN6IMCWqehA1JyNIR8BCad4I/IdVQH46aD6ASvazbfNutAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=ExJcbGCO; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="ExJcbGCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712743695; x=1713002895;
	bh=Vktcyf7dEu+WFhmfSfEa5qdk8wKKJd6WtNm46QJ4NwM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ExJcbGCOCj/B41RdivdPS65SgCa67s1JT+kI1/4PwR/qq4C5KRwoyg9I8bITfYqz7
	 lOvV/q9rmsJjEfZHEEfpzEi7ivHDHDBqMkhAck4dWG2TZdn3CuPXQe6AW+aDLFEivT
	 H9eof4OM4tf+NZorOGxyThgoIi8Pv2IHSPYxC/3o7qVEd9N+Ki8VHwmhgSBl5wIZFN
	 Uu1+cqpJQvv/leELEPZDTqp9JPJhA4rtt7Gm1ov6H3HzIqEV3/+unvk5LgNNEpHjBM
	 evm0q5nvmE7Sd4FZXzJ+y0B5BMjP51nguuCKzbYCcWxeUr2p7LrLO/YU0oKMxcsxnJ
	 fxKMxX7QIxRkg==
Date: Wed, 10 Apr 2024 10:07:13 +0000
To: Patrick Steinhardt <ps@pks.im>
From: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/8] fast-import: directly use strbufs for paths
Message-ID: <17089372-8AF1-49A5-A582-8153E87380AE@archibald.dev>
In-Reply-To: <ZhYxP42Br2h1mq5r@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <82a6f53c1326a420348eb70461f5929340a930d3.1711960552.git.thalia@archibald.dev> <ZhYxP42Br2h1mq5r@tanuki>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Apr 9, 2024, at 23:27, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Apr 01, 2024 at 09:03:06AM +0000, Thalia Archibald wrote:
>>=20
>> + parse_path_eol(&path, p
>> , "path");
>=20
> This looks weird. Did you manually edit the patch or is there some weird
> character in here that breaks diff generation?
>=20
>> + tree_content_get(&b-
>>> branch_tree, source.buf, &leaf, 1);
>=20
> Same here. Is your mail agent maybe wrapping lines?
>=20
>> - s
>> trbuf_reset(&uq);
>=20
> And here.
>=20
> Other than those formatting issues this patch looks fine to me.

I=E2=80=99m not able to reproduce these rewrapping issues anywhere I view t=
his email: in
my outbox, inbox, or the archive. I think it=E2=80=99s on your end.

https://lore.kernel.org/git/82a6f53c1326a420348eb70461f5929340a930d3.171196=
0552.git.thalia@archibald.dev/

Thalia
