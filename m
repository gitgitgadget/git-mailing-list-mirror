Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A31FA243
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421171; cv=none; b=W931W/+chs/OijqeMZhfH4z+4Oi6T3Qzp+8E05aopkAYD3wa2UIN0Tnkvl0E8EkGnY3eNB0C66GrIGwB4z6ak0uaE7rE+39V2T7eGyodFoeSFQabS1lXTtIqufxsjZyhzDI4kiuIgJD65g3Y0oLHpbwh5f3vox966hV9UmmZQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421171; c=relaxed/simple;
	bh=+F1j4L+SPBj4ianHkssjwSWxw8ELd7cp+J+4eietL6w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajczxWjA7RscdfxrIQezlnTlR9zMxI7F6oC9jW+0wVbUxn9QGzvHIQim0OipysthvCTP3Y/1wBQ+ZLRzjtc89A+lmRdlArMzMi+bRFJQf8GVFV3LQ/pFG+tIoqR06GKszsUgdVv1kVrXcdyI/d+l4JcVWDqrX5w7COuHn0Qkksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35WUhdm5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35WUhdm5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b061b7299so18435ad.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728421169; x=1729025969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lA7Do2jbEhds/dsLDUTNyM4174I4aA3CoavS93yDZnk=;
        b=35WUhdm5U4/YMb3JsC6N8NuxfNW8I9gr7VBZf43ULggkI6/V9yCQ5Dn9BrqZGRbYDd
         f1/n/WgBpKyJyrBCql+mufsOG2IaBCl+pzsZz1sN4yN3XwRSeOaTlH6G0UYBhH/1fJ0O
         fv6A/rM7lJF/dVzhoykyqRoo9lNFA8FdLIoo9DVeqXAI6S51rwB/mqvE//JkRogpXxzB
         CMbmT1/6AbJk8ZT/aTVgpSiRa8jKcgsM1j4ovVe6SsMy0oTJReMxph8G75+wN9JolCKe
         u/EJyaxWzEujKn5yZCeWLGMARW3ao9++qK/MEz6fjAyqMzB3xM4YUq+aVp9yFz0b/GpW
         l6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728421169; x=1729025969;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lA7Do2jbEhds/dsLDUTNyM4174I4aA3CoavS93yDZnk=;
        b=IU8VGbo5ElAWPN1u+KzILfYWuqnumstPQYcxG1yVE8EPgq3ID2yO7qVCXdyQbucZ1E
         12+JC8Sus8E4Es3f8cV5Mr60G/oZQcdo/cVMEir6TIoRDR4LtCj+dPLsGZqTQk6rKt0g
         uWIHpVYwDF9CKLLOzwLMYWTEGWcZ1EE0G0UqxA7Nu0OtR+P7iePSs3Zd/pFZYERGf3Hd
         T87yMDh5pbpgkSrA+w2TJhPDyc2DLpnzHwZEoKFcfN6kpkPIsLahsNySHQGyOjHuOD40
         XTANlsr01+gjZPjMpYC8Bp+STLkkPRnZqznbXqBk04uijKEBArSz54+KrrXPDtI6fS9R
         Sqlg==
X-Forwarded-Encrypted: i=1; AJvYcCVwOcIy5/F54aYIyxvY9J5ukejRjdhLDiOBiVgp4qFoSk+WTxlmee39Q5JTzGPbHSmh4Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXNYj1NojwQ+ww6rdlhSV8QTU6i5DTCSJrdL11sqEUiAkJfG/7
	4i5XxUylGhd+Z+KuLxrrVCI5AS9NY2dpQBgQLAwAhFnAIur1do3aCj4/DZlfUg==
X-Google-Smtp-Source: AGHT+IElAqAsQKnPONGhOiZF9IBkpaPMSk+GOozYcl79ISipwdCu947iS3Cx7RmDsRJ3rPeGvJgkAw==
X-Received: by 2002:a17:903:192:b0:20b:5046:376 with SMTP id d9443c01a7336-20c64b6356amr126875ad.1.1728421168942;
        Tue, 08 Oct 2024 13:59:28 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:7c00:8752:4498:cc1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec85sm59540685ad.69.2024.10.08.13.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 13:59:28 -0700 (PDT)
Date: Tue, 8 Oct 2024 13:59:23 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>, Calvin Wan <calvinwan@google.com>, 
	git@vger.kernel.org, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 3/6] libgit-sys: add repo initialization and config
 access
Message-ID: <zmdze3hbxfzuupx32hbnvyghzihkgjjhmh3prlwgby2hatgvuo@s6kdajzcagnb>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-3-calvinwan@google.com>
 <Zt_qOrrWubdU_yvx@pks.im>
 <bjgxdo7sjueppt2y4i2psifuvgnld47jrusgpsao6fjyqfyld7@7hybmrhbdli5>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bjgxdo7sjueppt2y4i2psifuvgnld47jrusgpsao6fjyqfyld7@7hybmrhbdli5>

On 2024.10.07 14:21, Josh Steadmon wrote:
> On 2024.09.10 08:42, Patrick Steinhardt wrote:
> > I don't quite get why we expose functionality that is inherently not
> > libified. Exposing the current state to library users certainly does not
> > feel right to me, doubly so because `the_repository` is deprecated and
> > will eventually go away. So we already know that we'll have to break the
> > API here once that has happened. I'd rather want to see that introducing
> > the library makes us double down on providing properly encapsulated
> > interfaces from hereon.
> > 
> > Also, we already have ways to initialize a repository and read their
> > config without relying on `the_repository`. So shouldn't we expose that
> > instead?
> > 
> > Patrick
> 
> Specifically in this case, yeah, we should have started with the
> libified version. This is an artifact due to the way we are figuring out
> C/Rust interop as we go, and it was easier to convert it this way
> without making the Rust side care about handling repository pointers.
> But you're right, and I'll fix this soon for V4.
> 
> In general though, we're treating the initial version of libgit-rs as a
> proof-of-concept that we can call from JJ into Git without blowing
> things up. We might not always have the option of exposing
> fully-libified code paths, and for our $DAYJOB purposes, we may have to
> deal with non-ideal interfaces for the early versions. However, we do
> want to use this as a way to motivate development of better, libified
> APIs when we find real-world use cases for them.
> 
> We've said before (even before we started libgit-rs) that we're not
> going to be able to make guarantees about early libified APIs, because
> we're learning as we go along. I don't want to use that as an excuse to
> cover up bad design, but I do want to be upfront that we can't commit to
> fully libifying any given code path before we expose it through the shim
> library or through libgit-rs.

In fact, since the JJ proof-of-concept doesn't rely on repository
initialization or repository-level config access, I think we can just
drop this patch for now and worry about getting a better interface for
repo initialization later.
