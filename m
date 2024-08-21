Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F016D4FB
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265976; cv=none; b=iLg1FVFTd/aVtLys9iKSHjmDvwRmn7g1sDWO8T1vjzA0LaH4/HJPxNunMXDWZ/B9gxZqnKh8qeVaY4aJz3sg1q4VfnBKnS4Sz5hhIBWZwH3uIWOIndtKymzjw7NzFa6cMvsrh6q5zemLlTNgeT9YBXoIDBDksBDnY2hJfF268CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265976; c=relaxed/simple;
	bh=CHbsW6esayo6eiSornh37ocAq3+Jwv+Ktupm4nPxJro=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OZdT0fzKIazPfQdcnd8L0tCW4TvytLYT1ffwQA4YhdQQ5/J82Lb5mDiJkn8h8YapA8LdIFTZj4D8EUmygqBG8G65gzfWSOOqlL77UcOWqi7KradnqR3NoY7X8dVhWHU/Wtmb0YCkRHyDu9oIn8WL0F2RvMXoJLPfxl2EeFdtBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZde99fy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZde99fy"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cd854e1869so11664a12.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724265974; x=1724870774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hpuG9EFgLgJSb2Wjn8aSBrEYXKvtbjBxRf48pQrMWig=;
        b=XZde99fyjSBRWy2WpTHfT9JeMRhdd12FDE1l/1PViNKZgi1CQM7cQU6holbEt12Luk
         1VWAseZuQgH7LCsd6NTboCZvRDl09fctMEmseih0y1P0Uqo6cGMp3ZWVNmhCqYk0oclW
         QbEzdb5Ui9qYQYnRR7oF9fGXTD0gPEryLy9Wh5eZaZA8zKXq7VgaU1noCFastQaB5LID
         PCCY/guTGbvfaG4xyc7TlwpYk4DeciQuRj3HkYO2dLLWbuMKh9RfIrp5V59an4X6DXgS
         5E43vrWw2FLDnpKQzVbPjcYb/n3/LxESPDqWqcZWeJuBP8OU+LpNEiA1PWsF5ln+ExTU
         /Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724265974; x=1724870774;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpuG9EFgLgJSb2Wjn8aSBrEYXKvtbjBxRf48pQrMWig=;
        b=H3Yjwty/FsA8SVllPEUUSd6GyAJPuD3DSOWtO4vIggfei4rJBO5mcMmdmKqu6yWVMO
         2DcgLyT2/eL3x/0DetwtZPlEXRCrhxa/9rYWlHOd45/BQgFGGAIGUT33KDZmjSrz/4AH
         g3gF/+SbiinB8ywL5U9E9NyOge2r9NoioL9KABj1sIfMin175fjiTc7AQ3KOoVm+GEx5
         aZFF8R5rEPlv9EcE3X2OMMf4BQl6gG8YwkgFKf9tMFNwJwn5U5uft8TgcRoGcqN4y7Cg
         Wp9Ykpkig8M2L5PBZKzSSDbrjaL2b67lGl4mzLlvndlhyyL91RSDryG+3Tlty0jS7ExL
         8Vjg==
X-Forwarded-Encrypted: i=1; AJvYcCVQvor9IrhoJrXLbVR7bx45WZPWDaja+hJ+qefpi1nT9NJOzGHWe27KnEKjWKGzVPjzfnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Sb4CP8vbcws7H/HIMqf333IZ5TfiQfBMGJjBq0wj2SM4gbCo
	QNXwMUVyVxJprl87/G6sEyMeIbxwECNxT89t+ED2N/RGguiWgNZI24k5amUVhSKxj4N/ht1CciO
	hEcocVHfd5GsnIg==
X-Google-Smtp-Source: AGHT+IG9mmYmpoQtbVqaLC0sfNC6lLGq065132o/PuA+P/3hz2Nm18lHIrD0TikFuunqUzG/1MB4gc+HZCrTYt0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:164d:b0:2d3:d0b8:ec3a with SMTP
 id 98e67ed59e1d1-2d5ea8a50ccmr58188a91.7.1724265974283; Wed, 21 Aug 2024
 11:46:14 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:46:05 +0000
In-Reply-To: <e3f7d292-ee51-4784-8c85-14b5223c380f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240821184605.341205-1-calvinwan@google.com>
Subject: Re: [PATCH v2 5/5] cgit: add higher-level cgit crate
From: Calvin Wan <calvinwan@google.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:
> Hi Josh
> 
> On 09/08/2024 23:41, Josh Steadmon wrote:
> > From: Calvin Wan <calvinwan@google.com>
> > 
> > Wrap `struct config_set` and a few of its associated functions in
> > cgit-sys. Also introduce a higher-level "cgit" crate which provides a
> > more Rust-friendly interface to config_set structs.
> 
> Having an ergonamic interface is a really good idea. As far as the 
> naming goes I think the suggestion of "libgit-rs" is a good one.

Agreed -- we plan on renaming it to "libgit-rs" in the next reroll.

> 
> > diff --git a/contrib/cgit-rs/cgit-sys/public_symbol_export.h b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
> > index 64332f30de..882c7932e8 100644
> > --- a/contrib/cgit-rs/cgit-sys/public_symbol_export.h
> > +++ b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
> > @@ -9,6 +9,18 @@ void libgit_init_git(const char **argv);
> >   
> >   int libgit_parse_maybe_bool(const char *val);
> 
> I'm suprised the compiler does not complain that 'struct config_set' is 
> not declared in this header - I was expecting to see
> 
> 	struct config_set;

I'm surprised as well actually. Removing the forward declaration of
"struct config_set" in repository.h doesn't result in any complaints
from the compiler either. Will add it in the reroll, but am curious if
anyone has any ideas why the compiler isn't complaining.

> before the function declarations. As I said in my comments on the last 
> patch I think we'd be better to namespace our types as well as our 
> functions in this library layer so this can be resued by other language 
> bindings.

Are you suggesting something like "#define libgit_config_set
config_set"? I wouldn't be comfortable renaming config_set in git.git
just yet until config/config_set can be a standalone library by itself.

> 
>  > [...]
> > +    pub fn get_str(&mut self, key: &str) -> Option<CString> {
> 
> If we're adding an ergonomic api then having return CString isn't ideal. 
> I think the equivalent function in libgit2-rs has variants that return a 
> String which is convinent if the caller is expecting utf8 values or 
> Vec<u8> for non-utf8 values.

Having both get_cstr() and get_str() makes sense to me.
