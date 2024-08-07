Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D171509A5
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072060; cv=none; b=hmTMicU0eR8TkDB4vbbJwePf2YDQ4pnNBaLVD4rgUxEeW2DjENmPWI889vCkoscPvYwmVl9KCnPR/iJHn94RlZQo9hqUWRyVu1Vd5FJfZxIKPMzTvUy5CwCajp0bPCAymDyV3fAsnj2eUJJkIW45auwjSrGiq2ZImLJOTy7JTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072060; c=relaxed/simple;
	bh=rozI4rBANaNpFqjePmKaRMf94HA/HPdoFXMLETsfDVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm/kdogFz9yL2N957J1qXnvfQJjvwLAih8EICSUxMuLhkMtmAykJWnjEPWwFV4AOb0uNw6gmyxO91JYMEfhUSzXysmgl3Ag5cJbm+ikVff2YdwokgPueiuO1NjKEoYFOyaraV+5AmqdOk/WtQ+nAtZK6LazgYX7iPqC5FAKHaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlPpgJ0m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlPpgJ0m"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd9e70b592so3728995ad.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723072058; x=1723676858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJiT37xNb3J3qYcF0JcvhVF5SeeIr2p3PzCb40BTew4=;
        b=DlPpgJ0myJNhXz8lsLF26Hhgu05BXRkuH8+hMywGuwit4A8TZQXvi1EjXn/pkzs0IK
         GbaFaCd+KeZ4zC/C8cqR7QXeMYZlk6M3MRSkeXV7MQwjZSrDNYLRboh8lxuqDwz1DMTr
         xu6OG3oXc88p7txeMFVmfEgKI+SrCPP9HrOTk/psrdGuOjtnSO+0aarAqn37GiGgLMxK
         hHBokPT5iupGVC3VNu/KL2CBjt4khg2khtCch1BSzjhDCeonSM6pqXwP8yIFu9gI4Idm
         tQWFioW9bTlrp5gtpEvlfOKG5ZmrytIY8c2LmkG9wq+BvDhgM0kqYyNRfN2CuQ1x09rd
         /hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723072058; x=1723676858;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJiT37xNb3J3qYcF0JcvhVF5SeeIr2p3PzCb40BTew4=;
        b=wNqzbhOkqz2OAaNBIzs104Xb1gAIxbrvJtozcKHFK+e9TuTeCWbol446ym1Eix9UZQ
         LauBoQMMiOc3QiTWv7Sr8xI0xo/fvcIWhScxY+wXOGF7l9V+05apX6TkbJAsu67g1WPr
         XOw0zhBpnwI5kBxC2ysgvaREKF3GwWiKcNinJZEHY7ZDsZ6dZKGWLMq3S6/yMt1mbxlT
         tTRx5Xj738qdTXC1O5A3P8F4uK9MlMofYjsu04htIb0PgGQ3NDZ97Q8Ipcok6sRokOXh
         zmFvLssOb8ht2AqQJAl56RR4uSIy5IGDHt2O95KVoZlpDK6Fu/zM18Vz8h/r/eL8ocTV
         5Jzw==
X-Forwarded-Encrypted: i=1; AJvYcCW26H7vktySoHOaQSwbWDS6BSYqatMexyd7hMtHmwvESkZR75AHtVQ3Ts4Md20XE3zmtTUeAzPrIYZNMIidNj/0sB7z
X-Gm-Message-State: AOJu0YxlsXhD6PaAn9mf9/Vs4FZwdri/n5XiBi6jmubUAVijEGxI+blR
	8++/50fyPXeLwKB8JLVLJnth7R0mL8KHZ+XYQaQ6R9No9GOq6keWqWUMrJSMLw==
X-Google-Smtp-Source: AGHT+IG1tKSso8JjHsYMC35f7D/4cGXb/PgCWaXMzHQ5MTsW0MDdLXde55rG1yD7iYnXbaVcWACANQ==
X-Received: by 2002:a17:902:e88e:b0:1fb:8c35:6036 with SMTP id d9443c01a7336-2009528e379mr1992015ad.5.1723072057783;
        Wed, 07 Aug 2024 16:07:37 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff590608a7sm111571625ad.141.2024.08.07.16.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:07:37 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:07:32 -0700
From: Josh Steadmon <steadmon@google.com>
To: rsbecker@nexbridge.com
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>, 
	git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <zrbylipleb7fd7jrlnsampufeiuyiw2suwvd3tuxqoukhz6h52@dnjr7urrwzn3>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	rsbecker@nexbridge.com, "'brian m. carlson'" <sandals@crustytoothpaste.net>, 
	git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
 <0a4601dae912$68d8e920$3a8abb60$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4601dae912$68d8e920$3a8abb60$@nexbridge.com>

On 2024.08.07 17:40, rsbecker@nexbridge.com wrote:
> On Wednesday, August 7, 2024 5:21 PM, brian m. carlson wrote:
> >On 2024-08-07 at 18:21:28, Josh Steadmon wrote:
> >> Introduce cgit-rs, a Rust wrapper crate that allows Rust code to call
> >> functions in libgit.a. This initial patch defines build rules and an
> >> interface that exposes user agent string getter functions as a proof
> >> of concept. A proof-of-concept library consumer is provided in
> >> contrib/cgit-rs/src/main.rs. This executable can be run with `cargo
> >> run`
> >>
> >> Symbols in cgit can collide with symbols from other libraries such as
> >> libgit2. We avoid this by first exposing library symbols in
> >> public_symbol_export.[ch]. These symbols are prepended with "libgit_"
> >> to avoid collisions and set to visible using a visibility pragma. In
> >> build.rs, Rust builds contrib/cgit-rs/libcgit.a, which also contains
> >> libgit.a and other dependent libraries, with -fvisibility=hidden to
> >> hide all symbols within those libraries that haven't been exposed with
> >> a visibility pragma.
> >
> >I think this is a good idea.  It's optional and it allows us to add functionality as we go
> >along.  Platforms that don't have Rust can just omit building it.
> >
> >> +[dependencies]
> >> +libc = "0.2.155"
> >
> >I don't love that we're using libc here.  It would be better to use rustix because that
> >provides safe APIs that are compatible with POSIX, but I think for now we need this
> >because rustix doesn't offer memory management like free(3).  I'd really prefer that
> >we didn't have to do memory management in Rust, but maybe that can come in
> >with a future series.
> 
> This is a good point. Libc is not portable, but because I can't build with RUST anyway,
> I hope that libc is restricted to this facility if used. It should not be included in the
> git C build. It is probably moot for me anyway for this series, but I have to mention it
> in case anyone else gets the idea to include it as a dependency for git C.

I know you don't have access to Rust, but would you be able to test the
symbol visibility steps with `make contrib/cgit-rs/libcgit.a`?
