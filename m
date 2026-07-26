Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA35323416
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098062; cv=none; b=mrSgb3Gqndm24Es5UMeg1IJw3oovqdCa+SJuTlJYTufALJdd9Th3EfNVjbwPZalxfRQCgre27r0PJZRb6kpoNkYdpyEcS3yYdZsM1oKDUBIi5DhmQznEa23a1nLS2z30tpWoRBDxSY5rQ36ymvlToPWEG+Yz6fIolCsfQ2qgqzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098062; c=relaxed/simple;
	bh=veCqmctO5RZxiJ5ZyeeeAmIMkw6yvzNO+wZeGVLu1CU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tKkpjU+VEmGyXWrTEYhpDUDSaDfkQ+fKKYbPpuyysG1nf5R4EAuHpnJApuDZ+jji7+Koe3/gis1eCJJf0ukYwxwr31qiL2sY3ROXqBC2znO60BQuNEJxl6ToZCNl/V1D7hN1YV1go99BGlhz5KU/F8W9B9VrABs0p96Eg1m2Lbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LATC0TQ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NAnZwBhu; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LATC0TQ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NAnZwBhu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CC75EC0067;
	Sun, 26 Jul 2026 16:34:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 26 Jul 2026 16:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785098059; x=1785184459; bh=2P6JblfFyF
	Rb4p3MB32ZrXrnIzD6B7gj8eEGPxmtJ7A=; b=LATC0TQ9WnK2JBtTmfJvEyPXji
	HZl/BDOq/ykNMEhJzxSwU6CORPlTZXQNzXtIczxMSIjm3BiMay//LfWMOsfVKiag
	4ePZfVCM2/uDpQq8onYdAtD4lkUhCIbNH3eokshuu4IhoACHJjQ1U/CKwai+o5tu
	dipKzRiOD5EVIBpYTcn6Od5bG6FLKlI48+HI4rpldK586u9Mu8u66lby5oHrIUan
	gVqAlTV5dmV286ht6WdSqhNQonUVBCYRv69ZEIIAV4tD8Tx5bDR8/FNxb/ITKhim
	CkFtXgKNBQHvbU4aPlFT1XMc85KJUDei8BWaAdWYrqFlPZedsN88d6+pT2RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785098059; x=1785184459; bh=2P6JblfFyFRb4p3MB32ZrXrnIzD6B7gj8eE
	GPxmtJ7A=; b=NAnZwBhu+wwDDyhcLYVY+NeVkhEpO+Omua4Y2TiClxswAu+hqD0
	ForTKXeUlyw8497y4EYTBdF/h4wf6kQvWmB2n06sx/yWsTKLHIITGsgTRcFtgNNG
	GTzfYG8hLGLX/CxCaHPqRQmkS5yYSf432yf+K8DD1o49ih1/0EwcbbUe+5a0QgLS
	CS8pHHyra8ULF8FFHiwlP6wSoFcXDTvGRfsXoGIeIvGqD7s8FkdgdGDKe496lTKU
	srELum7jOcL9aVJAyFMAE4gMgpxujBAmvOTINLoYVmVxuxnoFNEuc3Zldz9n4VWN
	xS1/3MCSmrn4CMkevnWtK6Bk03UkWeKfuUQ==
X-ME-Sender: <xms:S29matwRv-0ei9E_lwvgHAiDa2q0hRktzJLlxd2mUjsbexTH_ekFVw>
    <xme:S29maks6CNVt9C1-eYxWkW7sDz9szXmDIe5dF3oKaT3Y48Cvp5qPHZSQ7ElnDSrhQ
    iKn2vOIjWl9xgY7HesH94Ix4OuVYHIFZAQ_J9_zQFqih12v_gcI6w>
X-ME-Received: <xmr:S29maks8ghQHQ-ws2uNzu98fp5sY6Zte-mkAkocLwH8Wb-gTrQ11DAYNTAR82oAXlSXZsn62sGG7e7AMiaEhraSmDsCKcZgL_Q>
X-ME-Proxy-Cause: dmFkZTEMdsLEokxA2QiKjd+AQ+GvpLe6moWwzZ3m1WWP2sGMRt18JPNPRl386m8wV9lQAN
    NhB8aMPEDLmvfNr84VQm1pVVqYat8XuZJ9pwYsOaTGWpC0NtgjJyW9bpuDXjXmxWYfjJ9E
    CO0dFY0cXH3FZ0uSc2oH/5kYaBRr56HSh0DsGLn8/y5HPt5GuNK19le/0kPbo6GscqvDri
    hSWDdJcVQpOk0sOBkGoDoOQmh2tAhTyRGBaxfJx+Y9qaXaYxdkNebD1OwiBbgyvdr+hDfs
    4XV0iREzj/lmelIhyO61a2LT3WooC8N6DnxOs4x2I5e5g86Afw0Bln88pqw07yUrSJqVaf
    OJxRJqw5PiSVQUMywDgaXeYhPBXCkO9Ir5zMQD0eu6V5O3blqr1UQjEncsgsGAy4jRqgys
    8VcXGnbE9gtZuE63+fiUeIhlbfIqoOBYagaPFWb6aCGLa5c7Wn9Sgxgb2AkqMRpXEr7pry
    9nWwPfUpz3a4jmIjx9oQVBVRyt2lxHhatCiYMlQrE8T3g+qXmDvkNb3rjO9AInEZC+k28A
    GkVe2ZerEJBdb4mvrD6oKT3bhERqsHYmp+4nX9KsyUFK9vsh5wtUJNsHpjafgwJlYk7ESY
    JumUeZKp2ECOscefw7B+d/KjRbgXRcGcCaotq8YIBcUp4bfqAJ2Hl1EUNIsw
X-ME-Proxy: <xmx:S29mapORjUW6rkd5Ungb06kd82mHcJ0My0s9WpbUyduKAHBiCZ_YRg>
    <xmx:S29mai2J9uX8vS3Wjg9q0hZpgt44vinvZ0s4RjaCkkENVzxBzGriYw>
    <xmx:S29malNXRO_hMhhjxrLavYL8qSn-Bifp4edAMfpeq23cep22AW3mIQ>
    <xmx:S29mai3K5C7LBiGAV7yiqmNiWmTE_sQCxU6X2Dm4juYH8fqL5P46ww>
    <xmx:S29mas2pXcf86yAX6P4NJE4wGsbcdS3p6gFMPzbh0SFh4KraeOhzcpRl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 16:34:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] odb/source: introduce function to map source type
 to name
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-4-3b3d265d979b@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 Jul 2026 05:48:43 +0200")
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
	<20260724-pks-odb-create-on-disk-v1-4-3b3d265d979b@pks.im>
Date: Sun, 26 Jul 2026 13:34:17 -0700
Message-ID: <xmqqfr15v6ba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a new function that maps an object source's type to a
> human-readable name. Use the function to provide better human-readable
> error messages for the downcasting functions.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.h    |  4 +++-
>  odb/source-inmemory.h |  4 +++-
>  odb/source-loose.h    |  4 +++-
>  odb/source-packed.h   |  4 +++-
>  odb/source.c          | 19 +++++++++++++++++++
>  odb/source.h          |  6 ++++++
>  6 files changed, 37 insertions(+), 4 deletions(-)

OK.

> +static const char * const odb_source_names_by_type[] = {
> +	[ODB_SOURCE_UNKNOWN] = "unknown",
> +	[ODB_SOURCE_FILES] = "files",
> +	[ODB_SOURCE_LOOSE] = "loose",
> +	[ODB_SOURCE_PACKED] = "packed",
> +	[ODB_SOURCE_INMEMORY] = "inmemory",
> +};

This is a trivially obvious implementation for mapping in either
direction.

'inmemory' should probably be spelled 'in-memory', though.

Thanks.

> +const char *odb_source_type_to_name(enum odb_source_type type)
> +{
> +	const char *name;
> +	if (type < 0 || type >= ARRAY_SIZE(odb_source_names_by_type))
> +		type = ODB_SOURCE_UNKNOWN;
> +	name = odb_source_names_by_type[type];
> +	if (!name)
> +		BUG("name missing in `odb_source_names_by_type` for '%d'", type);
> +	return name;
> +}
> +
>  struct odb_source *odb_source_new(struct object_database *odb,
>  				  const char *path,
>  				  bool local)
> diff --git a/odb/source.h b/odb/source.h
> index cd63dba91f..ab16d152f4 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -25,6 +25,12 @@ enum odb_source_type {
>  	ODB_SOURCE_INMEMORY,
>  };
>  
> +/*
> + * Convert between the enum and its name. Returns the equivalent of "unknown"
> + * for unknown types.
> + */
> +const char *odb_source_type_to_name(enum odb_source_type type);
> +
>  struct object_id;
>  struct odb_read_stream;
>  struct strvec;
