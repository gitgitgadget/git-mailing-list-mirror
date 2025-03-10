Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AC224AEB
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597658; cv=none; b=hCmmKc73nuY4K63xJiHJ3bRS4XYPShbLd3F7RNpL4lFCB7mdCSm2eKw7BffJgb+XZ2T3QrR12tJ4G4kFLld6svZBCxy29qWKQDAd3WXuRblat1rGA8VK6K8g4ehp8EH8J8ZOjBmWuQpsw2a29EOv2hjSIP5fCT3xL39cbW/8LcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597658; c=relaxed/simple;
	bh=1PayPm7arFwA9xCEtCZyLsfFxayB/90KGALs4amQtTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlkOHzqqwmtPsBRtzi28Gr1fQBgpQl1RYQcrmdfzUlwZyA/ScrvGEpLerbneEKm9PKKmW/WC/RiNdzsFuke/ISd2r8qC6ZPc1UVWBBB2iVg2/OzX2vYFhk0VXMZgseZ0J28BvmvSgthLWAqC1YBb4F1hWxFzBUE4f9A7OuzgMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAPrEmes; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAPrEmes"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225477548e1so23326115ad.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741597656; x=1742202456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1PayPm7arFwA9xCEtCZyLsfFxayB/90KGALs4amQtTg=;
        b=QAPrEmeskc8hnIdSFWgfSF8CBgdhm4gi0pzPHguHi4kVNfzvXAurE7Ku3a1erYXU8V
         DCnPCzUkhHmXpbwFEuVFhfyVQ5Hz+/ABL6K9FAX4S76ZmXBWJhhvv0unxhpfzjhu87pT
         jYoEohDQ9Tt4aNcSmJj57nTr92lYKaTp/8XniTz0pGtjTNC9nQYN0Vl5IR2oVB443h9p
         454JnwWr7zQEVr2uNIcNMXrK7pJh9eOqEr5KsPfUT6AA4Vb8RSGbzd5HJl/vHmEoOsYO
         SCbLY4G50RTr+S+sSxwsPJs8HMMSjXg5wCyjVoCfKz0tMiyWZ0nEWBtcLhu7+CpppWg/
         BxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741597656; x=1742202456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PayPm7arFwA9xCEtCZyLsfFxayB/90KGALs4amQtTg=;
        b=Zs+YKGC6HN7He5ITkS+tsacuhFh9b0eA98siButidDPr1w0laQfdVcjZHd6oPD7AEG
         Ud5Vyvg87es/Wf4oW/GC9RpkdHT4hbXsgeNelFhBQH2Hio8WFaqbZcphg/Q7X8AimPBt
         3JjWmibTVjB45U3yDJ6ilmxgjLdqsai4KlhLMHiDw7/i1FQ0YwyrFpWMfpXxbllW8uNr
         s0Pwuf8g1pCJ8Y2rESfoDZHCBdSa0mjv5jvNcp5G89aVihkgEYjdcPfjdZ9aPir8VpIH
         Hg2y+SFObyDI2tKxuoEtHG+vmvk2fh9joX4CuuPbuREwHKyg87zjrCbGBUTxeH8f97/f
         CyNA==
X-Gm-Message-State: AOJu0Yw8XrNfYyU0kqnsnAGPrqArkX5SPa6FZCdPGsG/GvpXTLHnaLbP
	aDMqn2SFKJ6hGCu+3aI+zgH2MKtasaOiTJ70N/duDKLUx2Ip5u9eVKbwQvt+zMMF5uG4xnToCEY
	LTwCiXFvA+CpXK8kmb2ATL7cClIY=
X-Gm-Gg: ASbGncvpsJ2kQfHrKG2KpTutFHswQkfqZAOUlCBav6NEJXDvhoDOdz4nx81jwb3k2ci
	cQFGFUWg4ihcwxiYDjvH3YW+KIJmeuvv8xrc04x8hrzrZCF6DJ57HsYzp+rZWvgJj/OTeUK6umW
	Nf/q1uDVPxSkeZ5rsuyx/iiEjV8pSVzM63Wrj0zA==
X-Google-Smtp-Source: AGHT+IE54o4aGXyjtIg7Wo6zxqA+IfP4ULaj/d9s4Ma2JYm1BYDc0bj/fl8o8qBAGK/bQHjqdE2RpdvJAuSdmsMuyw4=
X-Received: by 2002:a17:90b:180c:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-2ff7ce8cfccmr21510308a91.9.1741597655826; Mon, 10 Mar 2025
 02:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309153321.254844-1-ayu.chandekar@gmail.com> <Z86PUkJ1sbSH2VTU@pks.im>
In-Reply-To: <Z86PUkJ1sbSH2VTU@pks.im>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Mon, 10 Mar 2025 14:37:24 +0530
X-Gm-Features: AQ5f1JqZIDW_Y-ThMoiu5wf5u6tr2j-o26KN5jbzJ0H_s9JmZU-WYJWTsenda3U
Message-ID: <CAE7as+bm1+aMz3SpiYeZWD9PUHNjzOYNgKm_FnEPzJesSFcodA@mail.gmail.com>
Subject: Re: [PATCH] environment: move access to "core.attributesfile" into
 repo settings
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hey,
thanks for reviewing the patch!

> We typically switch the order around a bit in our commit messages: we
> first explain what the actual problem is, and then we say how we fix it.

Got it.


> Hm. I wonder what the actual merit of this function is after the
> refactoring. Right now there isn't really any as it is a direct wrapper
> of `repo_settings_get_attributesfile_path()`.

I can remove the function and replace all the instances with
`repo_settings_get_attributesfile_path()`. What do you think?

> I think it would make sense to split out this change into a separate
> commit. The first commit would move the config into "repo-settings.c",
> the second commit would adapt functions and their callers as necessary.

Alright.

> Extraneous newline.
Apologies. Will fix it.

> I think we should just retain `git_attr_val_global()` and plug in
> `the_repository`. The extra change here doesn't add anything, and
> "builtin/var.c" being a builtin means is not reused anywhere else,
> either.

Makes sense. I will drop `repo_git_attr_val_globa()` and keep
`git_attr_val_global()` with `the_repository`.


> We don't use curly braces around one-line statements.
Will fix it.

> One thing I'm missing is the code to `free()` the allocated memory in
> `repo_settings_clear()`.
Oh right.

> > \ No newline at end of file

Got it.

Thanks,
Ayush:)
