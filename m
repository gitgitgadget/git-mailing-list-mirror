Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88B255F2C
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358857; cv=none; b=qwTDAjbRA+4QHdiazyrWEVJU3hW6id2lBeMdrgEzgNzWPyrw1K630IgpfIeLRGDEEhVMsCtXTep7s1QdYUIIo6jrIobj7Aq2rcxcO0aNhs1XMvKnLMYK2j6DF2/aBUq9zksaT3SqFUr1AG37ivSTJJ0GG72dU9ayz8xcxRahatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358857; c=relaxed/simple;
	bh=l21f824EsQgBxdc4ufoymCsm1NpWeC/m87dLwtq+BP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UgLfEplUE1pqQ76vBRSKd1dW1EZWviDmnIXXoNaoBnAwIfEich/SnBWoVADyT0FFSudWCm6aZpGvypiNGy40PCGh0BK+S7gMmhEHlb3TXsWK59XU8UP7FcKCF2B6XweB7ApRmpkjqgwYFLMxaAC+BNTeksuUOWTDSF+FZE5DhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B8GRtcQZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QErP8e4h; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B8GRtcQZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QErP8e4h"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D7D7EC00D0;
	Mon,  1 Jun 2026 20:07:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 01 Jun 2026 20:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780358854; x=1780445254; bh=DBQZHnn6gQ
	0rXVBhik8TBgPp3U99cmJ+ir5jXFRps0A=; b=B8GRtcQZNHSmPvTJ6Ij3A/1wlU
	XPNxoyNIjcI+GOPFd+4oPiUYqs7I++hkwy4LQQNfP6Fusn7VbQ6/4N6Zw6iZVgBA
	a67zq/1qJ0IBR5GQYeCNlumwUeOPlF4FipPhWGQpGZO4DBTYM7oiVbIIOYfKJHER
	DHvPsblU0Ujucd6+nIaKSlUDpmjKBA5v8jm1kKwcPU7UVam1xIQLhJWoPkXn1/uX
	C/DjYdf4amrDNWsgLvx0dKggOmzU6boLl/oazGKySa+Jz4ZS1Za+95gBTvEznMCu
	JUmcsa8/rCdzSO5DqvbxVac+4FxnOVw9uC8uy5/2ecfsnltRzWZucrL38W5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780358854; x=1780445254; bh=DBQZHnn6gQ0rXVBhik8TBgPp3U99cmJ+ir5
	jXFRps0A=; b=QErP8e4h5SYtDjAdP9hu4vsmqmGf8tbVrG6cRDf1Eoczliz5UfI
	6bLMEY2vCa3EWrUol5Fe/XF9poJMSEPesik3040EyJBYAY++5z/snNdrjMTSG3IG
	3mCmrgY38KnY8Vl37nxx2n+ywJR6EkPxVPbKNoh+5Co0ghkClXXUXo5MfAtnKgzD
	kSimGcKyRy8A5J4QsSxydZabeQNLDxOlNJGnEwNcsXCOzq/EZcNweDYE9xxyxPzn
	9AgrKZtczkaOcYBBC1EhOpUZfznUy1ROMBH1Qk4tIFnwsV76IO7AbE8J5KKLm3hv
	mf8/WmMXnw+3mKpmBrxw+DV0yxWPv5hjc7g==
X-ME-Sender: <xms:xR4eageGQHBStiSHDlXH7nLObAYuxtLYSO1zb6VN7bia65iA3n1ufg>
    <xme:xR4eahRWwPKg3HNCT9jqv0aQaM0VKCySQATOLrBslDxhOGnzrsPTxfmGDqOaELOqv
    cdjzNIOzKkMIATIiBtZK2tWrprTGUASKWvY1ulSfG1BSM_0uswj2A>
X-ME-Received: <xmr:xR4eantcN2994TXEpEzMh0EmwnlRVyQI9OZd6S-h5sdGlA_7Pe3JDLDZmNrf8hBlyJzd03kpQ8JioSvF_dbKqNagZrsQtJWN1xt6>
X-ME-Proxy-Cause: dmFkZTElEonLp5xZEbERKRWWBMwoMGGvMwOgcwx1K+DZi36GSTgkoK3KlUnZJjVeqAGxUI
    aJtitO0WnuZQHXSuPjjEIPomlaDi3O7CLC06WZSgrcTq9kUBxqRgkMEk9wX5FUc+9XI4XR
    SVuhaqUUDUb+JLSq3sT+52KG8kmV6nMvYHXePomcQy3U2JIgmMMVyKU6a9J5KER13YfYWC
    7+6OFOS6+0TmwQuBCiEcg1v0uqCQidgdOE4c7zlqdSX3KezKX1xydJzndSiA3H/Qrq5k+N
    AsEah7lOn2XWU61179ZiHxjCyTWySxJrunjJds2jsyP/V4pFwqXS4VVjuY9ZUuEwQwi6cJ
    fj+koQxh4XtmHZk4CvZDXPd9uHvsCH8ctFXHm3PtTbG1d+7lNVJVem7TxJaxhPPTclZGfx
    8me4FcRtZqlkohHoQHDE2W5uOCF37YokzbYqq0KwA3MSs/P2+/1r6Alq47qWk3KOPQWPcs
    DjrYRhuTW68cIiUfbHtMLYZy7zbqAEqDVIgnjtDFZT7UQnI8tH/TA65rXY5q/I6E0YoaQa
    eeAznkshf7Xj53mG8SRWKddz1epvKDxtMYcAyFsAXNJznc0Mu1QlaLFbRdID3eDfhoAB1I
    7AAZNtfhU25A7UCbLsp0rvxQETp2i+zNgcAEHXKnizTLwVcw0fIcc6yIbRrA
X-ME-Proxy: <xmx:xR4eaicA9ndcRat8r-6LsMZN3v7IZRytT_D_Obo-ztWBJrVvISNbAw>
    <xmx:xR4eahapEzbylI9MdKiCuQILJATm0g9u35NuafrOmDSttxA91Znqjw>
    <xmx:xR4eakbASIWSDjuKPlVQl1bRzB-OSDLVCN3Um7KjXoMn7-Q7yQW-OQ>
    <xmx:xR4eamISBJQ1_pZnHpED4L-IThb91tDAUES8hPoKagHV4zvjvJwvlg>
    <xmx:xh4eajsTXNPhRI5GWRPGNCdrkK4dSCdSnzzvlYdM4XIgvSfcKtf-RffR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 20:07:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v4 3/8] environment: move `zlib_compression_level` into
 `struct repo_config_values`
In-Reply-To: <20260601154211.82370-4-belkid98@gmail.com> (Olamide Caleb
	Bello's message of "Mon, 1 Jun 2026 16:42:06 +0100")
References: <20260423160832.114816-1-belkid98@gmail.com>
	<20260601154211.82370-1-belkid98@gmail.com>
	<20260601154211.82370-4-belkid98@gmail.com>
Date: Tue, 02 Jun 2026 09:07:32 +0900
Message-ID: <xmqqpl29ztx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> @@ -906,6 +906,7 @@ static int start_loose_object_common(struct odb_source *source,
>  	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
>  	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
>  	int fd;
> +	struct repo_config_values *cfg = repo_config_values(the_repository);

Would source->odb->repo have properly initialized repo_config_values
structure at this point?  Shouldn't we be using it for this call,
instead of the_repository?

>  	fd = create_tmpfile(source->odb->repo, tmp_file, filename);
>  	if (fd < 0) {
> @@ -921,7 +922,7 @@ static int start_loose_object_common(struct odb_source *source,
>  	}
>  
>  	/*  Setup zlib stream for compression */
> -	git_deflate_init(stream, zlib_compression_level);
> +	git_deflate_init(stream, cfg->zlib_compression_level);
>  	stream->next_out = buf;
>  	stream->avail_out = buflen;
>  	algo->init_fn(c);
