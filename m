Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F35369D57
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360224; cv=none; b=SuMC5i63jXyEEQnzzRMVeMQNi/epG70JvwSDtWrULLjdbqvlXYgoQByENS004YhYtDzK25BqlJ9ToN8VVEMNRi3IEyYRltME680xFQtKiFOZbPDyY2z5TqRyP0PqXkBBmzw5+9gaJvxdu2FuypSKtDI6Fu8htJl6uTNq2hUb2U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360224; c=relaxed/simple;
	bh=dRhL96I2HwzjmjUGD4CX6hEF8+dSsxjC9hia//tZRxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjKB253LUBagnB5LCeN/4hjb/zd+Vj5zjKaLOfW+8sV3aFf0uSECmGTSiM8IVm6V/sijTPernXq5cRrJppY9y0KTSMiZ5yMvGwr8GeKFTmiyD8VBqJ5fqTNIY+x8nNmlBRa2FmsIfoo85GeCWRqIERiWU74wwyVH9MCMEBEPDEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=SCB4B/2q; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="SCB4B/2q"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81e9d8f3289so22183607b3.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785360222; x=1785965022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J80INUEraVID4MEdxE0W9AzTUFSWKRfFc3Z0Rl4RKnc=;
        b=SCB4B/2q6womf5lMbByM/3LtdjZYt2MXH9dYG/YI1AMyda2kZoYai1fP2xRrHFzDVt
         +uoInIIBcVPZJzY9DNLEFRnts/0kwbkEdxHBqZd/Bfr7XIS90wZEiYib1O1Oc6eTvoAX
         uMzGWhfoj2Khj/vtMf+js82+nFGKxqwt+M6wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785360222; x=1785965022;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J80INUEraVID4MEdxE0W9AzTUFSWKRfFc3Z0Rl4RKnc=;
        b=DmL624nQxURsc15/9ZlrId2vgodFWYFHYPZfOOi/y/WuoVmxD9/OUgFI+60dsFsfIa
         9BjhUZMKvU/j+PmJS+ZDp90a+HrKfN7j1/Qd20D6FyFJYLeIvc9xTvQQbjzgHuwXKdVA
         FXS/1lLOK2mvbl/Ww/fMj5JAcbNz4qy2xMbEnh+AFJdRGFIi6gK+iIMd2/izOPnGGuTj
         tYWblhUmdDRSquqOSVBAvuiUviNO11yQmAIgHByoQxuK8vI8AA0sHRGFpXxYIfPKi97A
         9QtOnfBD0IaJFfimBCwYDoayA+HS1iYWhhF+5SRm/ytgInr7g+4bQ+7oNRAN7sXqMg32
         I8Xg==
X-Forwarded-Encrypted: i=1; AHgh+RqP9pufC9fQziKQlEeYBpVcjv8U/ygx1hi+tLA3rmpG21j8QvT/S4zccQ46AnjRTtdNi30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBhjW8tVenr1ywbJ2B40in20Txdl91r81WQSYjdc9K52d64yM
	L6RQ+IgupBSQFv6KuRhp/ot5fv4IOt5Wrj2wJI8LzqO/RIecnSrst6K57a1mo7gvdhWKsknmZrx
	VlLcguug=
X-Gm-Gg: AR+sD13Q7STBwYk/kUx9TxiDfkn/8nj0MdSDt/NY8xKxU9e1CbJuKgvOYJbtpSMwrk2
	u4h9inrP5grovZ3lTyW4t3+gZAVECzHMDgztuRAWJhqiB7MaaSDtdiY1nsewLht2JgypCuuT2iy
	FTa/aL9d8gpzndGsGT5h6WTorHUa8lTarjyw3PuSdx+E0bO2E8xMjZGLAvZLPbD6uHNkL08s5A/
	KEh2OOxfFkhnVIu9WuoQJd1Uy0dnaRzDE9MlFI6ctdIflfQACMYn16udVYwYmpv2E7OUZUXXbrf
	4ZJLbn0+oTH3/iSGsOfOzghcI3vNAzENbyzHMsurV3CbPRFQuoh3pu17/kG4/tk2C5BVoX17/Mi
	f2KtI4bUNt75aHjLYZgVrChTd5RqJKFn9ZSD7wS3Hhkulek0bzK16SBYHFIxBfmvgIxdHg/f1lX
	6gfmilOcOC3JfaZJosGKafcIJLs7nUUhhrP2srUJW+tfjLueW0hNcX4CTf3svANtpMhlObYSgOW
	u/PtUTHm/tz2u1F2Lsm/XmLkhur2bVorYGjPvLnWVwGyg==
X-Received: by 2002:a05:690c:9981:b0:80b:9114:3b85 with SMTP id 00721157ae682-81fb5b42e97mr4778757b3.0.1785360221688;
        Wed, 29 Jul 2026 14:23:41 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb7de8e8asm102427b3.29.2026.07.29.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:23:41 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:23:38 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: friel@openai.com, git@vger.kernel.org, peff@peff.net, stolee@gmail.com,
	me@ttaylorr.com, ps@pks.im, jonathantanmy@fastmail.com
Subject: Re: [RFC PATCH] index-pack: optionally allow duplicate objects
Message-ID: <ampvWrDaNqmNdlUm@com-79390>
References: <20260728042550.91133-2-friel@openai.com>
 <xmqqik5ybmi9.fsf@gitster.g>
 <ampR7FkErK3CQPyC@com-79390>
 <xmqqtspho7tk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtspho7tk.fsf@gitster.g>

On Wed, Jul 29, 2026 at 01:32:39PM -0700, Junio C Hamano wrote:
> Taylor Blau <ttaylorr@openai.com> writes:
>
> > If we can find useful ways to combine the ideas above with Git's in-tree
> > implementation of upload-pack, one could imagine that Git itself may
> > eventually send packs containing duplicate copies of some object(s)
> > behind a capability. In other words, for clients that know how to
> > process such a pack, the server may wish to ask the client to do just
> > that in the name of saving some CPU cycles necessary to generate a pack
> > that doesn't have any duplicate objects.
>
> I can live with such an extension as long as we teach the receiving
> end to deduplicate the extra copy.  Leaving packs with duplicate
> objects on disk is a completely different story, as it will become a
> source of spreading such broken packs elsewhere, though.

I am trying to nudge us in the direction of reconsidering whether a
pack containing duplicate objects *is* broken. After reading some of the
historical discussions on the list, the only "broken" portion here is
client-side support, which is what my series is trying to address.

> > But I would note that having packs containing duplicate objects is not a
> > new repository state for Git. Non-strict `index-pack` accepts duplicate
> > entries today, and shallow and filtered clones can store the same pack.
>
> The same as what???

The same pack meaning the one which contains duplicate objects. As I
understand, Friel configured clients to have a shallow depth equal to
the 32-bit unsigned maximum value (which is gross), but does cause us to
run "index-pack" without "--strict".

Thanks,
Taylor
