Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB819328638
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667472; cv=none; b=OIfWTy+cfrK+peAvD79vUVdqr463ZY8sFU4EE7FIUEegI5gLe4c6F3vCpgHMBqCxI1B+fjqWmgwXRot56c11Hqh3FnB2I+hS/4hOMHPl2fzkBb5QuMGUcNcveujLF9b6wl/ffvnK8XlwpzkkmOEokB3Ojh5ztu7LQbsUJiFVO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667472; c=relaxed/simple;
	bh=Jq6yJkzUakrIO9YbtBjlYbf/oziQvJnOjx6x2xlD/N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDToVqWqCrjpZyHfiHpI0oIERxyr0gzeSzDDpARIF7gfEJFaFp3LNp7uUvCFFoYgDt8w71KgsQj0SSyLfWrJ9SM7K1hnkfcgpe4yGmHLEQWAxpVZ9k4M2/JPCQIaOEAl3r6ylr/wEJjWnmQojlE3pCJ5cOMf/AU6WABy4spjQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1XD6GTf; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1XD6GTf"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-45f004e7d71so3844747b6e.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 12:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770667471; x=1771272271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1Xn+QUDfbhqS6l98lPU9CDQ0xwYzW7D1JTU7HHphZA=;
        b=N1XD6GTfl3/8gQ8NE1tRKbLaMt/C2AE7YYuk6H378+hEHAWdFk0qwsPYQh1ypgNI1C
         a+Tx1emxbp3c5ldDjohAebOMVdKiKoKwXzgwYY6dXL+9NxRpGiAaAfO3/ZG3gcjWfRVW
         dYcpHWWR/M4KyStBml4mwAoIOGpNlmcL9ybnc5e/56LincxeBDeJ8QRNz9mCpnh9TVBS
         crH913s1xVMJxTRRhrxqzQNvAJYvfsUVTAtWK4z2USZxRCOzR0ODpDespCh1GMD4lLjR
         PdjnDvFkrfW2YJpwHAWFNR7v+J7RL4gwCRe/U+1cYJu7dBcNZhLy7x8fJZpl9o6Tebut
         Rtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770667471; x=1771272271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1Xn+QUDfbhqS6l98lPU9CDQ0xwYzW7D1JTU7HHphZA=;
        b=WgfWQ0k2HZNICNd8JXv7ivC+1PKKNuZidqMfWjYa8Fy7H8lJIzA87lkLYSCtN0BSl2
         FNmPHCzI7s435SfZ9qpkTxmsT9Znk+AIFzGGdt2jCBqYm2JVk6EUg+SpNRDLe9vWiCf2
         Y6E7x3OmT24QzchK8c/Ba4i8sN+/UgkK2IBCBjSJgFfcxfJ+k/DcGyuY8uRKq9tFXZZR
         o613SDBidBIyXmJE0lmV2uxNvcbyryNJNbTE6k4SKFx2Vw86MnV+McKbRFe6ppFwYp+9
         6BoZsMJhUL3kGuFj2YbAV3ZCNfztfCZBZT++QybqXjNi71KCxa2NrMoCiVHxgCL0wqu3
         g65A==
X-Gm-Message-State: AOJu0YxaSJer+d6X3GY8acp1GHcmaZYCQ8cIF23BTS0Dn5ORouWGhEor
	SeC41bmhKxfPnmxmXgGDs/QVwc8AuJBa60aQs39QcSpxXs0WMpQW7c4sGHEZeWF7
X-Gm-Gg: AZuq6aIQV9f8/cqCmP/wNr5YxD5l16isiHI6DnXQWiPIoqN9mao2LPBkCqH792qbyCo
	jdXqU8nZAj8H5oQqmEwnkgkkQcaV4SBd+zjFYTOqwO/Xkq8tm2mXkuptWYY2ZHxZVj4Bn1VN+en
	xizPKcpgu+WSQq3l1Vos3DwKvU3Mki1d5Ylg+0pWDXV1VaOOAv+m9FUK3eleddHybPlSzrG/O3b
	Ts75joVfaPWWzgCMG9XC1Df7MU2cd5SQAzcqGyqa9GkCoP+rBlAEEYLMDbMgtc12IkkSpOUVTFS
	Jpc7PqI07xe83Acet3Ffc4YpJQCOlngBp+XR5GbH/mUP1qC3PVdCk0Eo94/XzNwZliqM912nuPD
	QGlgRBhRu4nBRTCfclpsGQr5WWj4QBQZpE0dhUpLH+zoQ0hOkFM0nSx+44+hf9HtarFqxAK2Zlb
	hMjRQF
X-Received: by 2002:a05:6808:2212:b0:45f:7ac:12d9 with SMTP id 5614622812f47-4635207a1acmr18098b6e.6.1770667470704;
        Mon, 09 Feb 2026 12:04:30 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462feb4fac7sm6982783b6e.15.2026.02.09.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:04:30 -0800 (PST)
Date: Mon, 9 Feb 2026 14:04:29 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] builtin/fsck: fix flags passed to `odb_has_object()`
Message-ID: <aYo8QoT2y8s_0itJ@denethor>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
 <20260126-b4-pks-read-object-info-flags-v1-2-e682a003b17c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-2-e682a003b17c@pks.im>

On 26/01/26 01:17PM, Patrick Steinhardt wrote:
> In `mark_object()` we invoke `has_object()` with a value of 1. This is
> somewhat fishy given that the function expects a bitset of flags, so any
> behaviour that this results in is purely coincidental and may break at
> any point in time.
> 
> The call to `has_object()` was originally introduced in 9eb86f41de
> (fsck: do not lazy fetch known non-promisor object, 2020-08-05). The
> intent here was to skip lazy fetches of promisor objects: we have
> already verified that the object is not a promisor object, so if the
> object is missing it indicates a corrupt repository.
> 
> The hardcoded value that we pass maps to `HAS_OBJECT_RECHECK_PACKED`,
> which is probably the intended behaviour: `odb_has_object()` will not
> fetch promisor objects unless `HAS_OBJECT_FETCH_PROMISOR` is passed, but
> we may want to verify that no concurrent process has written the object
> that we're trying to read.

As you mentioned, promisor objects are not fetched unless
`HAS_OBJECT_FETCH_PROMISOR` is passed and in this case a flag value of 1
maps only to the `HAS_OBJECT_RECHECK_PACKED` flag. This certainly seems
like the intended option.

> Convert the code to use the named flag instead of the the hardcoded
> value.

Makes sense, this patch looks good to me.

-Justin
