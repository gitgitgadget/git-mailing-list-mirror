Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE01AAC9
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100873; cv=none; b=NnRzGKYwxVxZjcRXxoW2teanvsR3gO3vRcYs4Z8Yqf0vdh9jpU7P4JzRcXBrCAJtGDBlHy/Ni/24xd9pwzYTuBqqomw7DN2/Rlc2EXItylsYBr93faMlCFWLyc9gLd+tVBQ2HVFb2QKVbg6Ybeu7IoC8jyE5mPqQFASBjND4wGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100873; c=relaxed/simple;
	bh=3oDF7equKz5NQDRsBnqdBJosnt1i4FSt+YYTToxKbUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNFLlzKXEy/5hUL9df8I20H66D2NqpprycOhmgZpWVdIiJjRjixSbvyqlDr4erNnz0dDETxBBNPx4Le4S5iDNoJh1oxp40mTZENBstHNFEBTDTEBMTTF5Epv375BOKNSHFY7nvCUoj9Rr4eDjxfkj/TfNBtdYsh7hOTElGrLjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPMsXR1o; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPMsXR1o"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so2489528a12.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 06:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734100870; x=1734705670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8+tftvFm8uz2X1sfVOT7yBYaC9xzsU1Py/ONXB5AopY=;
        b=DPMsXR1oXN5StDoX/1512Ls7bWDFzQHd5MWOC7d2CrxtOmkW0gFHChB4crKJ6ZXabe
         Kabn0vGMDLNbtotz6oXzFKq3+5Bzcz7qX9ykSwvkrLXTFwhOZuKjhf4Z2jf7NmWkVdDC
         aSdPn75z+oLdqnxoSn1ENY8pdRynZLzELkZK0XxA5qSK9FzokEdCZ7Gv7GTUztH0oKcz
         WgouH8tJ5vjoQsPcqTCFHTg941Qk3qi66m7xSPYX5cjBtr4vROzcQOTOCE/7RLbOWkaH
         i+2+mSUFY6vWTyDZPq3/UEFFogSealdfQFmyFSFFSH42ilrUC0RKmXgzNiWcnsq75CDJ
         r1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100870; x=1734705670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+tftvFm8uz2X1sfVOT7yBYaC9xzsU1Py/ONXB5AopY=;
        b=qle6qJXuHk1ICNR536f7NZjyD+8wbm+a4T3gZq7XjmQSvC1P9j+V3bp+csDwHKtXuN
         wU/yq6m5AsCLrh4R46SIAeVKnutBuZecwe0JSz7tOYD2NUi9BYe/Y54ggfchfPypZus3
         TBmjDmnRgZDrPfjokYHrSpUNHOqHvz7P174IZSularKlhlt4gmkhu2urnBG0F3VD+MRv
         2Ic5pabagPWzJcbggf+GOSRqC2yaJDEjrrMAsy614yCJKnaajXeuvIiHgHRsrgpReD9S
         hAtkW6+ldoCMGXWmU0kFO2Uk7NT+0A63gbGlEFSdThNhbZA8N1zstUh5cMtCsGdyWVm/
         YwAQ==
X-Gm-Message-State: AOJu0YycQqVZxxf4dHW8yQdgwoGJwrv6Xt5PSE+AK5V3YAhryYyRubGm
	1RYvJkcUj3NjfCBrdgcF4zab5b6EgdjbMzo5ON6F+yaZlezUq0Lq51dl87/GmgWE7viQpuUCJfz
	Z4YBMukUEm+KXH4l+r/FS9R+l4a8=
X-Gm-Gg: ASbGnctbLiSz3Lsqvdapoe3bc2Bijno+eWhDRmLoF8d3yzS6Er8qxl+SCh17Q0kA6TS
	xbq5uXLdoyviHMz/qmlU19KpJMrPr1txekHcMAt+a
X-Google-Smtp-Source: AGHT+IFyVS0kRX8PiPTwVgDv7p9APdk97Xj2lDjTErr6pTQm/UbwZqKt6ZGInb3NXeMs3ufvm9BqzWKMxHfwCBjESTw=
X-Received: by 2002:a05:6402:3906:b0:5d4:1c64:b322 with SMTP id
 4fb4d7f45d1cf-5d63c306c17mr2654684a12.13.1734100869796; Fri, 13 Dec 2024
 06:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq8qslf5h1.fsf@gitster.g>
In-Reply-To: <xmqq8qslf5h1.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 13 Dec 2024 15:40:57 +0100
Message-ID: <CAP8UFD0mizHEAjW6A86-Ndp-h2RySQU+18oL-5fG9Ni_S70ycw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2024, #05; Thu, 12)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A few typo fix suggestions:

> * ps/build (2024-12-07) 24 commits
>   (merged to 'next' on 2024-12-11 at cb270b3dea)
>  + Introduce support for the Meson build system
>  + Documentation: add comparison of build systems
>  + t: allow overriding build dir
>  + t: better support for out-of-tree builds
>  + Documentation: extract script to generate a list of mergetools
>  + Documentation: teach "cmd-list.perl" about out-of-tree builds
>  + Documentation: allow sourcing generated includes from separate dir
>  + Makefile: simplify building of templates
>  + Makefile: write absolute program path into bin-wrappers
>  + Makefile: allow "bin-wrappers/" directory to exist
>  + Makefile: refactor generators to be PWD-independent
>  + Makefile: extract script to generate gitweb.js
>  + Makefile: extract script to generate gitweb.cgi
>  + Makefile: extract script to massage Python scripts
>  + Makefile: extract script to massage Shell scripts
>  + Makefile: use "generate-perl.sh" to massage Perl library
>  + Makefile: extract script to massage Perl scripts
>  + Makefile: consistently use PERL_PATH
>  + Makefile: generate doc versions via GIT-VERSION-GEN
>  + Makefile: generate "git.rc" via GIT-VERSION-GEN
>  + Makefile: propagate Git version via generated header
>  + Makefile: refactor GIT-VERSION-GEN to be reusable
>  + Makefile: consistently use @PLACEHOLDER@ to substitute
>  + Makefile: use common template for GIT-BUILD-OPTIONS
>  (this branch is used by ps/3.0-remote-deprecation and ps/ci-meson.)
>
>  Build procedure update plus introduction of Mason based builds.

s/Mason/Meson

>  Will merge to 'master'.
>  source: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>

[...]

> * js/libgit-rust (2024-10-16) 5 commits
>  - Makefile: add option to build and test libgit-rs and libgit-rs-sys
>  - libgit: add higher-level libgit crate
>  - libgit-sys: also export some config_set functions
>  - libgit-sys: introduce Rust wrapper for libgit.a
>  - common-main: split init and exit code into new files
>
>  An rust binding to libgit.a functions has been introduced.

s/An rust/A Rust/

>  Will discard?
>  source: <cover.1729032373.git.steadmon@google.com>
