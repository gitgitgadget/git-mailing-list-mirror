Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6429D27A
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938747; cv=none; b=DSHCm1+PBLoitLxiHMedkjiS9/mwJon7CqJwGEWUBNKzl8KNP6vIZfKLrrDfKxwwiW2gTkDyTK1NZ5qM23pPXhtC53h9X/L9KfxNixr54lB/3n47qT9vphbOQc9XAco2eADoQnPCRRQ0DHGvMS6ygga92cefNrfCunZr82Kp5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938747; c=relaxed/simple;
	bh=7PGaw4y0v3YkRJ1Ir1kUvFgG8/+G2BcL31hGpPas4Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di4aciLJ0NW3cnSgEze8OmSihkSdTLj1yisFxv2yPpAsxFDkkHS36SaAzi9+MjfbVbJxae+/Uy6vLcaGwFu3i5lOYINEkoZfw2YAI5fSeSxkmwCaYi7vahSE5v39RK6auZzBn02/F/lOb5JzQOukwN6XV3ZtUlqMP3PZFampJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM6BavqB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM6BavqB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27c369f8986so74023475ad.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938745; x=1760543545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SU4dxUdBeT8MSm8YSxuFL19/x2ImhldCY/5Ix6B1eLY=;
        b=MM6BavqBSZDN+ncYH3PKebBPUirXZWR6KpvNTz4Zba0jQI43w5zdLU+WAEsAjIrSva
         gjL3ocwCJB804ZLt+1xAjH8jmJtDEhUtH7tu1zQK05zF+PvRpILngces+uxF2kNDWYSy
         G+rOpWJn18mEgHB+KeeNgd5dbq8VY4zYmg7VukechKpTz/be9AovnILzdK6/1G7Bg3Av
         ywNrYm388qw5aq8EutiQerTmqTDIgqvf6dRclA/NSPBrpK9bdkWYi1M7btcI7aw/LGGF
         6x6D+nRvfR4P9yNdPYMQ7yhMcgkO9cNB7PPnn8M3BJ0qk+jFCug90FbBl2QPPdgdssBM
         I1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938745; x=1760543545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU4dxUdBeT8MSm8YSxuFL19/x2ImhldCY/5Ix6B1eLY=;
        b=wUT+8U88Etm5/+joObRzw4ZntsCxyTpd19PcI5N8cBXYeDO3EVT6Ztx3914Ch554sd
         v1M1ILivaBhJi7h6jeYv/gfv7BYUKGJ4B56XDr4rS4PLTw5gfumvJtG1oFy7kO1gJw5o
         yjrLhJ9pZbChsruMWc/WwL+TqjlQX5yHvFhjx+7z+DJ97BQOkF2gtl+FnBYLmdLB6zpm
         VIhonMVMN0l7z1gpGcZRlnd5zWyhKMs7zDQjze2wLP/0dDqOKOF+Yo8JbelVUH4d7HQP
         xAhyMX9qXkuW11mJuKC3hKKq3Lmuc4jAKztgKEy/Qr/Nm3J37tmrA3xPAeLTWaV17pVv
         l0fg==
X-Gm-Message-State: AOJu0Yy4HYzVExqEKBGMFIVCYDGMPxYkAf78RmjZ1UInpUD7H+Kn0ChH
	Xg6A3UrQvQClbBk2zZd6Sbv+xHB9DrSj0hgA/TxHF3WBNLeHO1xW7pgRF6WvXg==
X-Gm-Gg: ASbGncvKS6jNlOaGkGQPnTHnQrG5r715ERO40Y5t+DXGttaelws6jYzk4RiOKWpqGlb
	1u2Xvs0jLC2kGo7ZRKQqldpnmA78grw902nua4IntDT2nWr8lyKxtP8eBu5Dk3XIgqmoRG3IkLr
	bw/lNDvvqIDoarNZMuK/5LBxQzbg8sOQCMSTlWGtp2+Hb6ChEH3qWsqfvoAGjhUHXyGo871Of+u
	LYUi4L0CGkPOZ3pp/a7rNyeCPdRX5yiwVyFmzKe2WugSobDAyvmr2Y3kIOsExTWcLw9v8W2yAPZ
	Kl4UhRlPdRlkobLkn7teNUcQsWsFzUM+GXcnqNBPgu/GKqXS2PWAI+nBM2tced3sfE4PdMoIqEh
	t/0iDHSZWTW9NGpxMTaN0G21iYmjh3ONlaTkhpUKM9g==
X-Google-Smtp-Source: AGHT+IHLplwYthtx5dH3A+AAguMdH40eP06fXr7D2gvoICd8L1LGN1ukjE/4j9YUdMZHR9Lp5OeQww==
X-Received: by 2002:a17:902:f607:b0:25c:7434:1c03 with SMTP id d9443c01a7336-290273568e4mr49490605ad.10.1759938744516;
        Wed, 08 Oct 2025 08:52:24 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6099f3b9c6sm18473110a12.23.2025.10.08.08.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:52:23 -0700 (PDT)
Date: Wed, 8 Oct 2025 23:52:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/13] refs: introduce wrapper struct for `each_ref_fn`
Message-ID: <aOaIuji6EDFi-Yg5@ArchLinux>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-1-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-1-916cc7c6886b@pks.im>

On Tue, Oct 07, 2025 at 12:58:38PM +0200, Patrick Steinhardt wrote:
> diff --git a/refs.h b/refs.h
> index 4e6bd63aa86..2b24a3d9974 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -355,14 +355,32 @@ struct ref_transaction;
>   */
>  #define REF_BAD_NAME 0x08
>  
> +/* A reference passed to `for_each_ref()`-style callbacks. */
> +struct reference {
> +	/* The fully-qualified name of the reference. */
> +	const char *name;
> +
> +	/* The target of a symbolic ref. `NULL` for direct references. */
> +	const char *target;
> +

I have a question here, why do we name this `target` instead of
`referent`? Oh, I somehow know your motivation as we already create a
structure `struct reference`, it is redudant that we use `referent` as
the name.

> +	/*
> +	 * The object ID of a reference. Either the direct object ID or the
> +	 * resolved object ID in the case of a symbolic ref. May be the zero
> +	 * object ID in case the symbolic ref cannot be resolved.
> +	 */
> +	const struct object_id *oid;
> +
> +	/* A bitfield of `REF_` flags. */
> +	int flags;
> +};
> +

Thanks,
Jialuo
