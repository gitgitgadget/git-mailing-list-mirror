Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E9279DCA
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176789; cv=none; b=c1mvDIhsnCQLQSneT46ZRo0mTWtU2NNMisU7S59zXqOK6fAWtv2zPoYo8VoPOXrX1slsbd5JX9ac9zN5Qwp+M54wfCqMACnmagBaCN5WchURksVLdq/26t1xNvuSgEm9tCkVwM0oM4lmS+ay8dCrJGjY/VmALYeuKzuvOtE424U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176789; c=relaxed/simple;
	bh=uznGXqNRbT41UQZpPDV86ZGLHG05U5gwxQnt5eXdAPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG8FqtFNXrsN9faP7288qWe0LGx6uyrU0Flg/w5HTPC2c3EormKLP7ThSv+3yNf6FiVouj9xTdDCoZ4050lFYl3GtiFRnzdQVXOo7lI9N2G07Yqj1jnQzdjNrj8G2XIY9VxB3/TKrn3hfbvF3sLlXOhhWNiLZq/GUz9SkgyVkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2QIrnNm; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2QIrnNm"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d749f99691so1459455a34.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773176787; x=1773781587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNtkKoqiK1APE+xhZN16bF8/MsTHtKVcRurMzaKEI2s=;
        b=D2QIrnNmVcDwOp8t6c20324bWtzAzxUMCWvMT5bPkShcGp1oC4D9PxPNDxj1WY7CXJ
         I2TQpEHTGyNr43id6V+2RuNOMWTmxitg4OUZdf/tQwQL/IgUAmstUi8ZRKTf5z+Otq97
         FvA5yeQNiChEhPmKa8yDIoT495sNuvIyakkC15hpqAPzD0Lj/fPoexfQiqJk5vSEQyX+
         IEgwyNa1xyAcSyoq5Ol5UUkPVMc/d0ca3WAZtl7T15o6lDwSg2yq+XGULhRYmgCwAPrw
         BtX13OQwah070x0FHPGg2m4uUS7lHnPvEuUlTblJlkoti0dqSD+zr6W77mLiLMTdcYxI
         QDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773176787; x=1773781587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNtkKoqiK1APE+xhZN16bF8/MsTHtKVcRurMzaKEI2s=;
        b=NEPOceEJMqJDYvLvRg2wxGFuHc+0dm9TCfu7B5YsZ3rHyBLylPeF5DRKw/ikJyW41Z
         0KB6w0wctdkcjx0wNrsSc0PCxOpOQC4oPqyHNOOelIrJMbAuIe9DYojvTzPoyyQhORFn
         K1LaL+FxzKpyja5LEJPvC8sU8dGx18c3b40MeQ3RjRoM4UEkZ5JnXogsBk9TBcG3O8zz
         xLTFTuKvsDBfRbvicJBb/LIuWWnEqrfCGVCTPAgiwRqH/oGyEK1fiLGCFToCg35NE293
         CQPMSzlKJyMu5uSRRl6gMNovn6Rvzy43ZZjA2dbQSPVrq1VQj1UiFQ6jD490sKnG5qbD
         wP6w==
X-Gm-Message-State: AOJu0YwFTwAap1mj9+A5rJsle13kzusfBis29QGljdCw54Z04mtw+2XK
	btTFSpnnKy1e4FKO61HCdAClQjgZ7rrKkXk+zAhNeZO7vNWnsUUUNi4s
X-Gm-Gg: ATEYQzxYbzhfByeilPNABni8icwwGyw1i3ovE6ak7HJoCUZ8j90c6lRZ+s0K1bmOraT
	6sADW3Ivgiqyt0L9W9RTVn5Hbv286F3kv3gjYw1iNXSpbZk5+9fLnwW1RzghPJ6vslXig979xAa
	OL3LktIKhxX1rc/41r4iSXSAlXMGCmT5B+6hQYhQu3XbeUfqLTuGCziDJyauOSF5IRoTdRVoNMF
	BX7B5KbeqLMCUL8+t+7aEp+X7WrS1I5hseKDOfiShowArU4hX1N/PAtljEoUccW39bve43F4361
	1iixV7OSx/ogbT1CVb2slo5+laUX7vbuKUKvPjPb1I3eqbUFsVsS5CQ4yETtwatUq0Nekl0pKoC
	bhG5uivij1jZMhEHcafhkGc+Xd8/bcK4iZHjNKcP532j7m1uYFQfyJR3DeMIvr6I5WNlgWs726K
	24eCY3dkDXV1Y2Rq4V
X-Received: by 2002:a05:6830:3893:b0:7c5:2e2a:d386 with SMTP id 46e09a7af769-7d76a75dabemr219755a34.21.1773176787008;
        Tue, 10 Mar 2026 14:06:27 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ac328a1sm209582a34.6.2026.03.10.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:06:26 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:06:23 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, ps@pks.im
Subject: Re: [PATCH v3 0/3] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <abCFKEHxu7OZr9bm@denethor>
References: <20260306205359.1723254-1-jltobler@gmail.com>
 <20260310201116.1130160-1-jltobler@gmail.com>
 <xmqqv7f3s93l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7f3s93l.fsf@gitster.g>

On 26/03/10 01:49PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
> > --signed-commits=<mode>, 2025-11-17), it became possible to remove
> > invalid signatures from commits via git-fast-import(1) while maintaining
> > valid commit signatures. Building upon this functionality, a user may
> > want to re-sign these invalid commit signatures. This series introduces
> > the `re-sign-if-invalid` mode to do so accordingly.
> 
> I know that this "re-sign" used to be "resign", and the update is
> indeed a replacement, but I wonder if we can just say "sign"?
> 
> When we see a signature on an object we are rewriting, we either
> "strip" it, or we "sign" it (afresh).  It is not like we are
> retaining the old signature, and signing on top of it.  We are
> discarding the old one so there is no difference from signing the
> object that never had a signature, no?

From my perspective, "re-sign" implies that the signature was previously
signed, but we are now going to sign it again. Indeed, the resulting
commit signing is functionally the same as if the object never had a
previous signature though. Also, "if-invalid" already implies that the
object is signed, but its signature is invalid. So it could be argued
that "re-sign" is already redundant.

Ultimately, I don't feel super strongly, but I can send another version
that changes this option to "sign-if-invalid". It's probably a bit
simpler this way too. I guess the enum value would need to be changed to
"SIGN_SIGN_IF_INVALID"? Or maybe just "SIGN_IF_INVALID"?

Thanks,
-Justin
