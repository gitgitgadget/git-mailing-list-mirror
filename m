Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED9211A24
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675692; cv=none; b=DfYozBh14P42vkhgaxAqtFche8H9SJ9nlFjKJUqXxRv6DChK+mhYR+wJq//EASXH2PCxSKossohc3vAPu2PHZVVqkwBXhcN6XGBBqypYShff8HQmaz/cwuxRZBnsjTT3cfs8hhN2Vp1NL+9/OC7Gf+iifEnfj8V/aO3/94rBJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675692; c=relaxed/simple;
	bh=HQQO/EakaDDF8urWuXlHspRCQL2fV2dqUL1OG67QRkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TVdGxr6cDq4vNCFm88Jj9hvEvENwlLP7jV1WW2wk7Pfth3Xfp6sb1C0xVKb7HIFPdLgC68zfP/ihKAKNKyaZoDB8Oyk2ctX8k+4yUvFCM9J9jM+9ewTnNtqCbuSuUrO5LBSec0LmjxFGQsTzc3GJkKrp5+Xxtgm2lHiu9LoBdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CQLcSxxZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZU6pOngk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CQLcSxxZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZU6pOngk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7896F254010D;
	Tue,  4 Feb 2025 08:28:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 04 Feb 2025 08:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738675689; x=1738762089; bh=Ow8FJXszCZ
	h9XVQeyQZVkFx4PArxb4OJ9Tk+yeLJGRc=; b=CQLcSxxZEYDdG/M57rmUcIHtvB
	pZxv9Yb0n0oq6wYazVdNWhv7kTD0Wg7oObZdMBNXjFpxPnT5NYlEF6fQE3H6V3UA
	2EdYb0BCVN0Tal8haET70J1ftX9+JpWC2m9IU9i0gsFBrkF+VsI8oWlxyFe0Bfb6
	rmOiJL/IflpK2HxiJ81sewHeNfyejGE3lGF3/pvvC8K3jwbahQ3tzQxoRVLkOViU
	Rjko72RuZJUE6ymf8QuQGL8Dy286zrdua8m+ExnmbQA9duYlV08zI32FBlkONE5n
	qBlpMW5Qtf7SrP7QiMcbN+7C3KyxP1qdSJmlbPORr5fzfI9N2tYg3OdCzldQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738675689; x=1738762089; bh=Ow8FJXszCZh9XVQeyQZVkFx4PArxb4OJ9Tk
	+yeLJGRc=; b=ZU6pOngkg3pGVKgtsZ5JEPTWFQ5tfVhhyN9VlUIsK1EYCetxqnt
	a2WdB82eOuNO23uA26ezVstWM5CkIgOehOwRAfHY4sBDPZm2u+CNtZVAjyRnPvf8
	MTnFgqR9uWE57PVcvRP+3/h6FmT1YHegZVkVVo7T4/ExYtTbOvP0XdnwGCHVYbEy
	/aMbvHxVct1eLvheAugJa/NUUwRRh/vhgyBvZ0fiyREZ5VvsDm+0z9D3lECVDxYV
	+ZM8xf27O275evMVcV5Bdy/KCiWTw8UFBhkoh9jDfPDHcAX6JL2oTfRyMLn6v5Oe
	+L/d87FG7XwJpXKvEBjrzPWA6qBIPdusuGw==
X-ME-Sender: <xms:6RWiZ9NRsb23Tfyuk2Wn4A8eSTOJm6lVe__xnKb7jBaIdKsy38JErA>
    <xme:6RWiZ_-EfcStKzFGxj7BgyoUYzeA2HCSlUgp0Pu_ZOb88z_QlOHYBFXoosDlRJm4J
    vIWhA0wuYeE1ZX5mA>
X-ME-Received: <xmr:6RWiZ8QSYyNiozlI6LM8Ooi5vHgKe8aRl0E7ocKO6OFMljhZZTXH-9zpBFI6u8OnDaefATb1QiBJjG1bv0WA4qsGgIPCRHHd6Qg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepke
    ejjefgiedtieekteeijeffiedvudefieffheevkefglefhuedvveetgeffgeelnecuffho
    mhgrihhnpeguvggsihgrnhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:6RWiZ5uBnp1iEmUxMEemD9DIRHhwFW3sgewJ0Q6FlWqgosvUhCgmSw>
    <xmx:6RWiZ1c1FqbasvJXfcvgXXvtXtyjH_3dATync_jwUNZGBKrqfk6hfw>
    <xmx:6RWiZ118e8ooHSmJi9Fjab3EgVzJEsD_Ox3HrnOeXoHenCIjcdrFlA>
    <xmx:6RWiZx8TqeYLeSJYeWcBFr4vma310ZVzd599lfy96r5P6Hf7rn9CMQ>
    <xmx:6RWiZ54wQm5La6Tc7R7VBmmJ35Va8aIkwU8ewH5pKf0YH45be96nvfAI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 08:28:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] thunderbird-patch-inline: avoid bashism
In-Reply-To: <20250204014652.3509928-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 4 Feb 2025 01:46:52 +0000")
References: <20250204014652.3509928-1-sandals@crustytoothpaste.net>
Date: Tue, 04 Feb 2025 05:28:07 -0800
Message-ID: <xmqqed0dx2jc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The use of "echo -e" is not portable and not specified by POSIX.  dash
> does not support any options except "-n", and so this script will not
> work on operating systems which use that as /bin/sh.
>
> Fortunately, the solution is easy: switch to printf(1), which is
> specified by POSIX and allows the escape sequences we want to use.  This
> will allow the script to work with any POSIX shell.

Makes sense.  Will queue.  Thanks.

>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  contrib/thunderbird-patch-inline/appp.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I noticed this in Debian bug 772238[0], while looking for any bug
> reports that I might be able to fix.  It was reported in 2014 and has
> gone unfixed since then, so possibly this script is seeing relatively
> little use on Debian and Ubuntu.
>
> I have not CC'd any of the authors because nobody's touched this in over
> 9 years and none of those people are still active.
>
> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=772238
>
> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
> index 1053872eea..c55c2caa41 100755
> --- a/contrib/thunderbird-patch-inline/appp.sh
> +++ b/contrib/thunderbird-patch-inline/appp.sh
> @@ -31,7 +31,7 @@ BODY=$(sed -e "1,/${SEP}/d" $1)
>  CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
>  DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
>  
> -CCS=$(echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
> +CCS=$(printf '%s\n%s' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
>  	-e 's/^Signed-off-by: \(.*\)/\1,/gp')
>  
>  echo "$SUBJECT" > $1
