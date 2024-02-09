Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C98394
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707445839; cv=none; b=boRS4cj+KGhZdBxQ9eO5rrgzpWQE6ptRwcJQ4sAKu+tPuh3rl3PMZlezGUb+Y4v8IykSPI7cgYMaK4CViTCuFRjrq54Dg3IZFF3UT6tggiWHKXs20K4jpxy/P30ud/UvPSQwR+Mg2FUHaGlb6C9ZdLioI0rAIlD5IopDMBP4wqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707445839; c=relaxed/simple;
	bh=Dv79cuN8WH2fw91oqmvKijlh1BtNI6lJm7iqkfJ383E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AHSvJRPWWwoc/hf/CMnkcBFe1xnilIKXoGMVWtf5jd0O43WgGE3E14Dfn3M078QQ2S6s/ma9G7pAAWf/cLacEqj4EBH8OUabF9HdLnGRCVEzIW5aTISoxGDz+70LUwrTtx+LtjqNC1tW4Bts4oUDALsiqmM2+SdVZ11Pk3A6RMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rr7zPsxI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rr7zPsxI"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a388c5542e9so281959066b.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 18:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707445836; x=1708050636; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dv79cuN8WH2fw91oqmvKijlh1BtNI6lJm7iqkfJ383E=;
        b=Rr7zPsxICjKsIJG+KrtmmXAOTJEaxSH6qxerxcEg4lIj4kpJ2ZL53qm0/9+GfvRx5/
         VaXjrZamuiCkEyMRqIJCwuph5QUXseR1ltWJmCUZWljboTSKcKtazI2r7BJtCvSMGf1B
         hct+neadgE7J4RmYoYAiotoaStxIcSnpOAvMNI8YapLAr2rZG0XtiEkSvPWSrsrSKT/a
         ur1hZO2s9V7lEDA9orteBs9Vhs5jQwB+FwsIzoT4X58v9zfj64r2bMybIyBfsfGGfEu2
         1WeLe/D77B/+Lv6MISRm42XX5FvKlT59umrL1WCL9R21cgqVouacjiFYVPVBF5RmndjE
         cdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707445836; x=1708050636;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dv79cuN8WH2fw91oqmvKijlh1BtNI6lJm7iqkfJ383E=;
        b=SoMPwDz3yknozSZiFzF/89dvAGylwEhTvCB9PnF4G8+qII3fUaP5wU1fK9TjV8aw8D
         Y6ujY4CP6UgguAMMrvHgyqgWe+NyocYEQOwPhh3XA2iKLdWyO8UIMzQ1OMfWCetHncW1
         yvo17ErFTvtii3JnUfVlU9pZev4H5OQPlGmQgjECwMFXbxqKraOTf9TvYsS2q8HY0TAt
         8kRpJlhvOBLGK5PNY0wqLlebZ7jxlqn1XqcnvQpromZ1XXXGMJ/3BKeulrDVji9JjPdC
         74iGY3B7p/YsYLi6j3I7Q51rVX+xmTxnB7nhSXk7k0gU/xHbg8d3WXcv1Bko61dGfcM6
         SZ9A==
X-Gm-Message-State: AOJu0YzXANyop5VnOiUQqgFkJm1ZD1vvWLh6h3jwbSA74I8lfhUQP1h5
	nO/hPF20M6iN46k20WXyOi3e8R5XrbRqDkbGs+EnMvOt0r2twUs4lxJ0m5FRuD0UYuZ3GtyoXvK
	maOXHaVQVVCiHcJ4QHvQwKWMbKBKLZ09DIGuRTpYy/wudtzVowQ==
X-Google-Smtp-Source: AGHT+IHV4BLFIy+4LfP4XFCMl85DZtO95nIEARDy8B7Wb/M3dDDC0xuWQyQr1m7SryIt3g7+zV6LgXxdK/z4W2/yzFE=
X-Received: by 2002:a17:906:a299:b0:a38:158b:bbbc with SMTP id
 i25-20020a170906a29900b00a38158bbbbcmr179220ejz.38.1707445835690; Thu, 08 Feb
 2024 18:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 8 Feb 2024 18:30:22 -0800
Message-ID: <CAO_smVji5aGjx1V-EGbumRRpOuGY0SkXZUn9g4LxKmMO3aw=Sg@mail.gmail.com>
Subject: libification: how to avoid symbol collisions?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While thinking about libification, I was wondering what we can/need to
do about symbols (specifically functions, since our libraries will
likely have few to no extern variables) that need to escape their
translation unit (.c file) but that we don't want to risk colliding
with symbols from our "host" project.

For any header that we're offering up as an API boundary we can have
prefixed names, but there are symbols from git-compat-util.h with
simple and likely common names like `die`, `usage`, error`, etc. I'm
far from an expert on linkers, but I'm under the impression that even
though we'll only be #including git-compat-util.h in our own .c files
(so the compiler for the host project wouldn't see them), the produced
static library will still be "providing" these symbols unless we mark
them as `static` (and if we mark them as `static`, they can't be used
outside of their translation unit). This means that if the host
project has a version of `die` (or links against yet another library
that does), we run into what C++ calls a One Definition Rule (ODR)
violation: we have two providers of the symbol `die` with different
implementations, and the behavior is undefined (no error needs to be
generated as far as I know).

With dynamic libraries I believe that we have more control over what
gets exposed, but I don't know of functionality for this when linking
statically. I'm assuming there is no such functionality, as projects
like openssl (ty Randall for mentioning this) appear to have a
convention of prefixing the symbols they put in their "public" API
(i.e. in non-internal header files) with things like OSSL_, and of
prefixing the symbols they put in their "private" APIs that can't be
marked as `static` with `ossl_`. I'd love to be wrong about this. :)

If I'm right that this is an issue, does this imply that we'd need to
rename every non-static function in the git codebase that's part of a
library to have a `git_` prefix, even if it won't be used outside of
the git project's own .c files? Is there a solution that doesn't
involve making it so that we have to type `git_` a billion times a day
that's also maintainable? We could try to guess at how likely a name
collision would be and only do this for ones where it's obviously
going to collide, but if we get it wrong, I'm concerned that we'll run
into subtle ODR violations that *at best* erode confidence in our
library, and can actually cause outages, data corruption, and
security/privacy issues.
