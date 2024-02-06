Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4EE1373
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183795; cv=none; b=Hr13PnjCabUuIiOXp/YhHhpleXqJvyczEGoZFZL3DJOgSIw7Vy+RGvSOmEw9xd8bx/gmYkdPuPCKjAoQ0JUMkKQI7Ew+yQkQUQFZwwCIA/oMopuyzEECqMK1MtniZZWrZ/h6648bUScbS5cFf/bnrf5KeQ6iGfpo3bh1MPbCfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183795; c=relaxed/simple;
	bh=kQFhUuL/oW2iFOwFEc5ikLEHQPlGGYuXieNoM5lpYk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL/TaoTJ4ZslUbyfYQVR74EmhirtI9aTAdLJn1zpRO+Z6Sfl2g5UjYPCyb+18PqtRzuWWGk2/aPiAPjRWvpdHJLo2ouah4xUNJGyTUYt2OAa77gkiFPPjRLoSUwHa0PpMa4su/tCzcVFFMmZ6Mbc4pPeNG0LDb0I0N8eQ7DNHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu/7WfJe; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu/7WfJe"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e14bb3184bso191272a34.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 17:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707183792; x=1707788592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7wqzvJ2sogcGhvS7aZ8KDsPcxpJGUP2CdnQUTtqCAQ=;
        b=Fu/7WfJeDpFHH+0b7Vyd9NDPNiXWXsl0XiUbGTCAMPRc5cmjo50apFevIcNNMKTmkb
         nGaxvRIjixDANSukRlhjysef6y1zeJkf/oqWC+1Ria+6QjNzVPeJDQNk0PrL0sxw6AjO
         WG0cVvd8B1Z4Vsel7TR7CqSLwR0ukED+o+8yol7dEuFmQoP/3NpxuyDrrgNkLx0JZnYB
         d7gRPzKInwLe1tPlonsGLbh5U2nQbCcJz1+OeX0iEMH97q0XynBOvYSjQfZRHkq6z/ii
         mtEaEbZ97beLjnxZXahMOQuUfz4Byyn7HKwsqbRoM1rqojQljZVTVtS9+OYZom8miImX
         mbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707183792; x=1707788592;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7wqzvJ2sogcGhvS7aZ8KDsPcxpJGUP2CdnQUTtqCAQ=;
        b=A3SNfdAQsEuRc+vLAYSFvuZozFBTSG4EXkJ7mY/G1T/P4vtWdEIOzLP6aiGF9QiDDR
         3IODjI1d1fyJ7mtVcEet+eb+lXZCtvZGfaT+0B1egh12yFvsSYuaxHEhMu/BmLzYBR85
         8o4K+UfukRCpsJqrVsv9PJ53IXmhvyHJUz3n9DmyzK/DQL/PMEVq4AfWlYMEBo7ZFoFy
         W93xNarHXGmI3kblFeBC5iFBGT3gMO1YqXre/2wEUxK1YFygD86W30hlGAeW+z5mgVU3
         EMu8MSW0GPzk9v7kzoC+Blr7sTD8r7TZGy70Dv3/Cz2VxOSYF1xc3S0piO8mEEQge9hj
         5Nyw==
X-Gm-Message-State: AOJu0YxNz9YH/M9bJzCNT5fXjCPWh8ercQIMBqQTYhUjCZT8LQN3jWJz
	3d0TNRW7uzXaoLdViXmQx8JJyDabjEEeuKGAJfSpcg2Qc9jEILo4
X-Google-Smtp-Source: AGHT+IG53w4+E15tuJG5M3tfLLtfnAYypsvdCQzMOPJW1M7vFPNBnwRCx3uFgIc3SxMWh9qnmQip5A==
X-Received: by 2002:a05:6830:3111:b0:6e2:79e5:caf6 with SMTP id b17-20020a056830311100b006e279e5caf6mr1939597ots.5.1707183792549;
        Mon, 05 Feb 2024 17:43:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXOtH+nXFR1WBc7SdY3eIhDBX/XuW9WQ2W++12rhY8A7xQtoOoPP/7JlI2sGH0p1FAWUbutSlrKSRTepfwrP/DBg2RkKUfTlLV4jcTH2MA6EX/dV2PSN8l8iTSyzpVBZ1kwS9wYk+9K
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id u7-20020a056830118700b006e11c31fa06sm173565otq.36.2024.02.05.17.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 17:43:12 -0800 (PST)
Date: Mon, 5 Feb 2024 19:43:07 -0600
From: jltobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Toon Claes <toon@iotcl.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2 5/5] reftable: document reading and writing indices
Message-ID: <oslbbspnu4spohamhenhxyqv23fct7ltuqkdl67liw774opxwj@jjprhh7zy34o>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <cover.1706263918.git.ps@pks.im>
 <cover.1706773842.git.ps@pks.im>
 <c3492bbd42b9d2c17764208e814faccf395cb282.1706773842.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3492bbd42b9d2c17764208e814faccf395cb282.1706773842.git.ps@pks.im>

On 24/02/01 08:52AM, Patrick Steinhardt wrote:
> The way the index gets written and read is not trivial at all and
> requires the reader to piece together a bunch of parts to figure out how
> it works. Add some documentation to hopefully make this easier to
> understand for the next reader.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/reader.c | 27 +++++++++++++++++++++++++++
>  reftable/writer.c | 23 +++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 278f727a3d..6011d0aa04 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -508,11 +508,38 @@ static int reader_seek_indexed(struct reftable_reader *r,
>  	if (err < 0)
>  		goto done;
>  
> +	/*
> +	 * The index may consist of multiple levels, where each level may have
> +	 * multiple index blocks. We start by doing a linear search in the
> +	 * highest layer that identifies the relevant index block as well as
> +	 * the record inside that block that corresponds to our wanted key.
> +	 */
>  	err = reader_seek_linear(&index_iter, &want_index);
>  	if (err < 0)
>  		goto done;
>  
> +	/*
> +	 * Traverse down the levels until we find a non-index entry.
> +	 */
>  	while (1) {
> +		/*
> +		 * In case we seek a record that does not exist the index iter
> +		 * will tell us that the iterator is over. This works because
> +		 * the last index entry of the current level will contain the
> +		 * last key it knows about. So in case our seeked key is larger
> +		 * than the last indexed key we know that it won't exist.

The last block in the highest-level index section should end with the
record key of greatest value. Doesn't that mean the initial linear seek
should be sufficient to stop the iterator from continuing if the wanted
record key is of a greater value?

> +		 *
> +		 * There is one subtlety in the layout of the index section
> +		 * that makes this work as expected: the highest-level index is
> +		 * at end of the section and will point backwards and thus we

s/end/the end

> +		 * start reading from the end of the index section, not the
> +		 * beginning.
> +		 *
> +		 * If that wasn't the case and the order was reversed then the
> +		 * linear seek would seek into the lower levels and traverse
> +		 * all levels of the index only to find out that the key does
> +		 * not exist.
> +		 */
>  		err = table_iter_next(&index_iter, &index_result);
>  		table_iter_block_done(&index_iter);
>  		if (err != 0)

-Justin
