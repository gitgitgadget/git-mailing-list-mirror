Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA52D0C63
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273228; cv=none; b=Pknf2/We5W24wCwXY6xnJ+hrYK9GEXBDjnQ9LSiuwtppeJZnJdruXPPNUliY5Wm4q+6TqEIYvRIdLRlXQbF8EiD2vezRu6N2j5ZbMcFivIvib6mNcaHPd76lYYELmE5poIpEPIU1R4GUmcov7KvwLZ3uQ9HUWD4epC2PComUlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273228; c=relaxed/simple;
	bh=Q7CKXzTvNKGAtq4pN+gkE/m+5qHv+YC8Dck/lXv+YNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReSivbPXGTsEVVfJVt6u8JYIowV2ienY6DZijU03LWjtO934v4Q+ROaGzB71+yzhPyGL1etCSFLov1zEOM9m5+tUDdMUuQb2u4OrZKuTpEsWcsd9MzhT73qz5q3JP5ZL4NOd/Jegt21oDtpQ/f7mw0zi0fWbXkN3HsrmkrOCN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXqnSqNh; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXqnSqNh"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4ab70b882c5so152209b6e.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 14:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785273226; x=1785878026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q7CKXzTvNKGAtq4pN+gkE/m+5qHv+YC8Dck/lXv+YNU=;
        b=aXqnSqNh6hKZlW9nKnx68B/b+XKUV94bZmPZfu6q+okAxc4YQKcxXnIRnLP3yU8Svt
         rkezzFS73ha2X1xGp/kI/Yn5RLvZuA5jHvsIJN0mLfDREGC8DJ93u5oCoW/Ruj52mq+d
         TUiGE4y20Pk+PV6BbnKMnQ2Flw3t+YoUaRM9Riq0jiXjnpq7Ru+LXL3y7sf/VtueiAqO
         Yg6yJvZrKGDtvFYbctDK9b9a1QfNcbtbQu1vYFDhJ7bhO4JcCW2oOs8QiH/38/7jlI89
         9g5KKabEoJHUHsBkw6KCRo0xbNfN+qMFIlMCMASgMmeF56MRVWcE5pUU4PqbeP4A74Bm
         pMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273226; x=1785878026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7CKXzTvNKGAtq4pN+gkE/m+5qHv+YC8Dck/lXv+YNU=;
        b=qiJQSA746NFnxefTbdqT7E4QSnwU0N3ditOvg1foyL0n0RMmSRoOWiZOkWjIvjYGL4
         70R+7rJ3I9HXpsG2NIJCOAArmbxEU88Ma8dqsGO1tktiVMKsfQs0Qx9uoxOXh3zkNMTH
         cp7e7j8PW1HaHBueXctP115t9z4ovb9XXvIYyWmO/H800YXwcPOE3OzqK5tDV6oiMDQs
         KlZj1rTDwVGVZM6SyIye+bg3DnDVFM29WbU05OcZCRiJmmeTinwHplUivfEqAKRhSN4i
         3OV1yB4roelTSgPM52G6PeaXOHn1FCjZiErXPqF0pMqJhUiIuZ4yBOSgnBglt/Ag3QlM
         PZpQ==
X-Gm-Message-State: AOJu0YydZL92a2gvj1j0fW4LSxnRijQQwbILnOEjPegYkTCyVKW1ahbF
	nCoZPU8XiJwQTAhOQSvl5h44wUtSyBCY+oaW8cy+M1F5V3ajfqol/gSV
X-Gm-Gg: AR+sD10sft8z9yvpL0KyqL/ipv7vj9n3k2xoKhp2KffNKR7MOVJF90AWI1X9rhsbSMS
	YMZ1Cj4CgIM8RniAhgtb6MeNK2vSqBv6ZtJ/HjYZSLCOFBVS09xnzDI3hJbFvPCuwawPckfeGx7
	ivUTilYtktWBudZUt3gCUTJueeDLtCbBEAhRmFDNSArl1thtNzecp8Xrd/AVvM16ftgF/uaaXYk
	tykL7fs9akwjNjdQ54sN/Wfc9e4Tm4Bzy+L7Tt3WFD2cNQzqT6HUcnA9HEURT17+NYHL1abyKV3
	mPsTMjYlZiQxKu6IU6A4rlYyfSmodO2B3ZnppwG91moVA1Yxd8efFp1pO6w6kiqngSMY0wOBVKk
	HLVmzEWw3hJfhd+tBRFepPMSsJ+gQMVGNhZNQ835UiGuc9nbXRRo0oiZELhymNDvHwlywTKiv4G
	JvgocmT1giXZAnPM+utQCxyAnIM22PBhG6bJsFH3+x0ohh//vDrcbnug==
X-Received: by 2002:a05:6808:2294:b0:4a4:c12:ee68 with SMTP id 5614622812f47-4ad5b9acf65mr2397078b6e.10.1785273225846;
        Tue, 28 Jul 2026 14:13:45 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc6ffcsm200105b6e.15.2026.07.28.14.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:13:45 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:13:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] setup: defer object database creation
Message-ID: <amkXcmwzbBYsMgjc@denethor>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-3-3b3d265d979b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-3-3b3d265d979b@pks.im>

On 26/07/24 05:48AM, Patrick Steinhardt wrote:
> In a subsequent commit we'll make the creation of the on-disk data
> structures of an object database pluggable. This will lead to an
> in-between state where we have already configured the repository's
> object database, but it's not usable yet until we eventually call
> `create_object_directory()`.
>
> Defer the object database creation so that we handle both steps in the
> same function.

So IIUC, the repository gets configured via `apply_repository_format()`
which invokes `odb_new()`. In this patch a
APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION flag is introduced to allow
the creation of the ODB to be delayed until after source specific
on-disk state has been created.

Naive question: would it be simpler to just require invoking `odb_new()`
explicitly after `apply_repository_format()` in all cases? There doesn't
appear to be too many callsites.

-Justin
