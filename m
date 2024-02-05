Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274A4CE0B
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707177378; cv=none; b=HYLl67YvtUuwGebKOqHlPASleSSYB+Robqc3OpMOfC7zFWmJ25YAI8b8D6d/VuqBD7gNVAht8qCR3NJjuxPQgxWrY4Nat0CBawUDMXkHcePfhCkaosOolOYsA6iSSzSpufUgurMvEM36KSKCIBjxfZxN4Xduw0diK14DI/jNR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707177378; c=relaxed/simple;
	bh=P9UBtGeMBwIIoNdBFkeOx0lgC86zCWrpRNCr+GzDvtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufHG1ID9KUvnEUYV6XsJ8h1FyUn9l9EH/zGL3IcbeYmMYP4I28qWu44w29DYEOpfs9IqzrjGsOPHl6ISgoit+5JEEOjIDcaElStYJs1LuhSX10K4n+ZoXqIpYTXqgP7918ZAD7Blx+AGBO6fcWW/UdMg+JO8ogPAvgtL3SdZRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4pjPgGs; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4pjPgGs"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2196dd318f5so1668383fac.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 15:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707177376; x=1707782176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTOEQ36suEcRHBdHHE73WndD2R/FSeXuXXP27BMyqQQ=;
        b=F4pjPgGsB6ifDyULrBioFcdrT9OeD7xQHz/A+BAticxwrsEkOPPpCBr/We3uFCmNhG
         z3A+2tvf208iCYoxdwtVdz7XWXoLuIiI0cEPZW6y9Y2ji5g3qh2wx5kgYpmIkISdqlHC
         S+fcwg5kswZfqz49iK2gkxVdTiMzHOt2EwpxxSDnC0jpapFMjUA3oW2OBT51d7TR6IE+
         kUU1hT2lt8NXz6atuFtXWoNq/DZKUTRFiJTwW9oZjeEeIHa4uhlewTpKHbxJZVhQwQuM
         5OHhyjNf+beyYbsoCHGtlKt3g+vF+fvizALHd3YGrXQVTSeVFLZ//sy8/Guf+Kv09VEg
         MVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707177376; x=1707782176;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTOEQ36suEcRHBdHHE73WndD2R/FSeXuXXP27BMyqQQ=;
        b=jFTK64SEjln+E798ap/Ygwqi5vPpj/qpM8N5oALgPwlPoX5R3wBqOQqrlKsZSjL8ME
         GFYHRIrAGJLoTJ2i0YxKGnxbnT5OOhZxO/qyFLzjmiwsc/qrgDLVAUvIN5c83Liy9NpH
         Ih55Ju+waZfaBftPHFQwxI6ioGatimJbh7eLJQjNNP6eyukjJktAF/gQfzGtzjnc3PH+
         p7jUsX41rXUe4hv+RrYIq3KkZnkx5fM/nbXrt+laZI4iEc3f7hMtvvwcrcnQOtfBzC+5
         /ekhOhej5AvyKcyLlUTNrM1GyGfnUuGAUmItb4qc5rNGPLjLeWppwqn/cXfer3WS4ZaT
         YfyA==
X-Gm-Message-State: AOJu0YzA9wbptPPa7SzAOJhDiSBDam4FJXp+8biu0v2qfUTM0Z2167+l
	EI+kIbhPDVzhmA1mkRhx3xXFWLpoVmx/LNDT2KrGV3pSyT/aezYs
X-Google-Smtp-Source: AGHT+IFLW9d03wTwuaNzZoB6ZDPgLpuitWO5IkiK8FciYUBD0blZ3QaB+hK6LFJNQ9lOlcGlDY4tSQ==
X-Received: by 2002:a05:6870:c8e:b0:218:daab:aabf with SMTP id mn14-20020a0568700c8e00b00218daabaabfmr874794oab.53.1707177376351;
        Mon, 05 Feb 2024 15:56:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCViRUS1fyWv5//gwWhfpHdioujXwqk4gO2OoK8AiEJIOAOmwu2ulY8A7iIn4LKVFwT2mNLdv3M3t2+wg5SFXahRhg2jcjEYHKVlM+4MJbOOvRIkP+95+d1VKUiY8WDSbppAe+k+NUhU
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id h4-20020a056830164400b006e1362f71b5sm151785otr.42.2024.02.05.15.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:56:16 -0800 (PST)
Date: Mon, 5 Feb 2024 17:56:11 -0600
From: jltobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Toon Claes <toon@iotcl.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2 4/5] reftable/writer: fix writing multi-level indices
Message-ID: <g5wshgzfv7x6om5zglsiv4bzsmhwcihwrqkmq4ebppiljqbreu@ml5eyr6zhkgu>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <cover.1706263918.git.ps@pks.im>
 <cover.1706773842.git.ps@pks.im>
 <89a88cf83eeb50542d3878c5c6e56e46f2bc3e73.1706773842.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89a88cf83eeb50542d3878c5c6e56e46f2bc3e73.1706773842.git.ps@pks.im>

On 24/02/01 08:52AM, Patrick Steinhardt wrote:
> When finishing a section we will potentially write an index that makes
> it more efficient to look up relevant blocks. The index records written
> will encode, for each block of the indexed section, what the offset of
> that block is as well as the last key of that block. Thus, the reader
> would iterate through the index records to find the first key larger or
> equal to the wanted key and then use the encoded offset to look up the
> desired block.
> 
> When there are a lot of blocks to index though we may end up writing
> multiple index blocks, too. To not require a linear search across all
> index blocks we instead end up writing a multi-level index. Instead of
> referring to the block we are after, an index record may point to
> another index block. The reader will then access the highest-level index
> and follow down the chain of index blocks until it hits the sought-after
> block.
> 
> It has been observed though that it is impossible to seek ref records of
> the last ref block when using a multi-level index. While the multi-level
> index exists and looks fine for most of the part, the highest-level
> index was missing an index record pointing to the last block of the next
> index. Thus, every additional level made more refs become unseekable at
> the end of the ref section.

Just to clarify, is only the highest-level index not recording the last
block when multi-level indexes are being used? Or are the indexes at all
levels leaving the last block unreachable?

> 
> The root cause is that we are not flushing the last block of the current
> level once done writing the level. Consequently, it wasn't recorded in
> the blocks that need to be indexed by the next-higher level and thus we
> forgot about it.
> 
> Fix this bug by flushing blocks after we have written all index records.

 -Justin
