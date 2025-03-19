Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65E21C165
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422999; cv=none; b=o0O12RXo4+D5piClg6gWPrYDOiOl9uUdiWhrBGtjiCE79PYoln7A8Cib23p0MBgE7Y4ctXbu5rh56gpbQdKg+jDoEmlwfwefnsgRZv874AF6vCukpOz/j042jIXmPf1Gtc+W7RHyOmuo8wEG0ueZJ1q+A0/4w6W1C+xxsTqrFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422999; c=relaxed/simple;
	bh=pL+gLmA0dVehO8VrsckkPZzwbLJV6UabM4T1xXLNE38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGNWRekw46cZv5I0KOCjV6w4t98vM6dKhmC0O6SqCDjB52G27blGG560VAlc5/PntPSRfs2eVTHNg0TIii+j4TIdgkjLGjkpT84e9hJ5lvEiw+4zcfRvbMAgTqUJ29ww7kDXLcMZLQ8zItQ2nwReIPxwXtHT1woM95a1J9eNimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1G+hbgB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1G+hbgB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2263428c8baso34785ad.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742422995; x=1743027795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLd4vivNUe8F0ORBocTWWdxwOxUfEyYyjQf2dPTDJaE=;
        b=K1G+hbgB0sSenITj+KqscmCt8HNq/iMBpTpFiKefrbkllufIwKaN9zJTFcJ+3P2JqL
         DtLxI6pfwPFS3ixkgMyNLpxBywJeSRzsk2ML6Flsw2P8/TaHEZXMKHzpwNGxk+iKOK1h
         nSxbgpBjXqk50AmxHoiO04slMxqta7h6l1ioDfHeIXQqkE4A/IrE/G+O3j7SCW9j7tZQ
         fo1twWnUj9ym+4cG36Q6ecrICEcdv8XUb6jAoKNXjONFysF4udtvFIj+scpfVbV6wSvu
         N3fwE5HDHzRoFyqxh7h09qLiEdi8+qmu6bkJ0QHtO5zvykl8s/DzsFhROvSkOT7ZW7MS
         mX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422995; x=1743027795;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLd4vivNUe8F0ORBocTWWdxwOxUfEyYyjQf2dPTDJaE=;
        b=tXsdAipL0ozLUqwxXb6dLU88tdIS9q1i54OPbuDuqtf916wxEJF6iPDrN9auUc2JtH
         vV/8WCw6epabwA4ZFCCjrG4VctJ1q/zl+L8QBMisqh4Z1fFGYQ2bnwkotrlowwZT4mAV
         ZKyR42UMxXMxdYWqYvbwOKvGMjnoQYdeqQBuK6vKfThJix+/054mE8mW7OVQ62T2T3pH
         t+vuJwN/8Jkjx6/DMoY/wGhPj7vH+xGpVZs/PdvPPDc9UUhmh0CJjc4hM223jn6YZrAb
         5Fzm4rZhvVBNuZvuCxGWBB5QmVdMdhBDn9ZLF7KT+oi/kiSVzIh0EbUn5zBS/wjukrIU
         V8Bw==
X-Gm-Message-State: AOJu0YyvHkbk518/rX+slJwYa7gDZoqO51syyUv9w+6lk4TIW+wisroF
	JE0XP97+YV/0tP8XToVpgl9YCze3Fswu+AKfSWwamhi6JxRtJut+EeHC7cm1yWKIrRbaTQNR6ds
	UQA==
X-Gm-Gg: ASbGnctTrNSGqpx3Tam2qSnaNpxJnumEBuKo0YeChUnR0dhoxbspWrxDWmd5MeB8C0r
	S/nmPAS1IkHWzbwrA8dJNoQ0khT2ilZd1rgcZbuBkMyTOFzdwKU2jg065i7XyzOp2t9j9J3EE49
	xQbX4HQDT/0z4eHBQxE0FvxFEmTaVf134/+OtpKTRDLOf+zWv4gj3tExP0/mCRxe6cdJHU6x/iN
	K575var+Nkn9snuEQrxILmTFvUR2iCQVCiu9h8cNjFn592eG7OeE/Wjifn+tUnRvQ2V0kFrIJFB
	CzY15njaLaQMD3r143shvN7iSVkyIOyd/WC74eYGwb0=
X-Google-Smtp-Source: AGHT+IHps+5c/4v4lOwBSoZ8OXWnwxePkYj2oFtlmPDwlSHH/2XX47tr9Zs7tvXnqEs5FM89KwvH9Q==
X-Received: by 2002:a17:902:d584:b0:216:7aaa:4c5f with SMTP id d9443c01a7336-22661f4e92cmr520475ad.3.1742422994345;
        Wed, 19 Mar 2025 15:23:14 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e62c:9ab7:eeea:596c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea041e7sm9708083a12.44.2025.03.19.15.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:23:13 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:23:08 -0700
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC PATCH v1 2/4] libgit-sys: add symlink to git repo root and
 clean after build
Message-ID: <uu4s2acl4lwhj2rycojebnkygwqvdhge7iwh6uaedsmvkphchz@vg75gxitvqvn>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1742339107.git.josh@steadmon.net>
 <d592a3c2e3f56aa4f6915a07307a2ed349296272.1742339107.git.josh@steadmon.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d592a3c2e3f56aa4f6915a07307a2ed349296272.1742339107.git.josh@steadmon.net>

On 2025.03.18 16:24, Josh Steadmon wrote:
> Unlike `cargo build`, `cargo package` does not get access to the entire Git repo
> containing a Rust crate. Instead, it prepares a directory starting from the
> crate root (potentially excluding files, such as those not under version
> control, or explicity excluded in the Cargo.toml file).
> 
> This means that the current method of building the libgit-sys crate does not
> work with `cargo package`, as it tries to execute the Makefile from "../.."
> relative to the crate root.
> 
> Fix this by adding a `git-src` symlink in the crate that points to the Git
> repository root. `cargo package` will flatten this to a copy of the Git repo,
> excluding non-version-controlled files, any explicitly-excluded files, and trees
> that contain a Cargo.toml file (this prevents infinite recursion on the
> symlink).
> 
> We can then execute the Makefile under the flattened git-src directory from our
> build.rs script. However, this exposes a second problem; Cargo will check that
> the build script does not add, delete, or modify any source files. This means
> that after we copy our libgitpub.a dependency to the output directory, we must
> run `make clean` to remove the object files we created during the build process.
> 
> Unfortunately, there is not a way to determine from the build.rs script whether
> we're running `cargo build` vs. `cargo package`, so now any build of the
> libgit-sys crate will result in cleaning the Git worktree.
> 
> A potential alternative is to make an additional temporary copy of the worktree
> and run the Makefile there. This would avoid removing build artifacts in the
> worktree at the cost of copying MBs worth of source files to a temporary
> directory. Perhaps hardlinking instead of making a full copy would help here,
> but that might be less portable.

I'm currently working on an alternate solution where we build the object
files in Cargo's working directory, rather than in the source tree. This
will (mostly) avoid the need to clean after the build. I hope to send a
v2 with this change in the next few days.
