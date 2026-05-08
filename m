Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F8410D32
	for <git@vger.kernel.org>; Fri,  8 May 2026 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262294; cv=none; b=QkcKH8Kj9QQwiXdoxRw6Tcv5tw8JLlNMVRPu/gwn8loka04nj5x8AattjycYA64aVJpnidX/v/x0Ka05JLXVhx7hgr09Y350MB5N6+6PnqCDxDvIhkWlnbqCt8rZVLv3w/bkWLwjT5uYvs9rAffnNWy1KYP1t750M6FkzBCMEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262294; c=relaxed/simple;
	bh=iLNIVtoujK6ZMkeE0TtqWZY2hvt9HyrDod/vuXKb01w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JVC3hr3x+TWwGvytGqN7OrLWgN9lBUxN8thMIbu8gyaSoJzChXDmmY95Q+Q/rK3LeXB5CDjo2P7mmqtlw3nq4dO7g1u4ktyj3C4wAHPTXkWgif0NVZj4PsVouVQeDfT1hQWhI6eTxDSIf7qFuARIm1mGkNgxj/0zKxunwsKjRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEqV+ArY; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEqV+ArY"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f485961555so5246796eec.1
        for <git@vger.kernel.org>; Fri, 08 May 2026 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778262292; x=1778867092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLNIVtoujK6ZMkeE0TtqWZY2hvt9HyrDod/vuXKb01w=;
        b=KEqV+ArYAk0lFab0qaZwRC1KbrrxqXRfupBFoKwVx14LUf+EIhgdD43HjIrgwRDnIl
         EyNbONcZAJtKZr88Pym5u4BrYoCJt5xBS3zu5c/mtX4LzJPepgCTnss2nQmAsuoV0I5O
         tQdXuJ1HWmu5jLpz3/wvJqz8zXSr+4Max5szdBlGl1oI9yGddRUnP+C4kvO2T0LuAbA6
         fiqrmYd4Sf1KyS0e5LbesHqBKrwNJuSUHhtEB4qdkUNJIh2U1x8c2h/adTBvwX1+ooS9
         ICpnP0lKFCp2knMtY0fouR9jIIb+l4uUtJN+2083dpEJLbQyqhAEEvnvbgukGhacuNP1
         Yy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778262292; x=1778867092;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iLNIVtoujK6ZMkeE0TtqWZY2hvt9HyrDod/vuXKb01w=;
        b=KxAlvA8biYLo/R21T7BLMhVn+B624l4ObcPRfpt9QpX1S6ZFjwJC+dkeD2QS9+a+Ks
         cDZf/Cd64VDUvSbxbr/XnZ+k0+WiBl/DvaiES0cLvMwKzBkpi9s2vt5fVv22sZZPGzVq
         3v7SjVT4wZlio/CaaHX/8nPC54TXhpzKImLHdMod5ZWu7m1WRgrLRLY2s3VXqR4PwoMZ
         vd1bWQIDoH1comsbNW/uTdSh1h6nphxn0FmZdgQG6M5vGSvpvmvM3dekMNspXL3WCuIo
         Gg+EdniGxKFsmxQQbsOJETacgxJY/eV11ZWxBq5fz9p3CnaWJiRygjXiff2JkW6z237c
         lq7A==
X-Gm-Message-State: AOJu0YwUyzCPEL2EV+F42DgjjRbJa4zl6KKkUxpdlxdfBoFicy93RbiJ
	gmeqoiG3U+7z1jLrxuPDJhXQMhi5CeR759tJXHVk8zMnvEp2s1NU0iHx+U51TSUCMyjHUToKk++
	u1w==
X-Received: from dyhv20.prod.google.com ([2002:a05:7300:6794:b0:2f9:af7:5041])
 (user=snatu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2e89:b0:2f2:8857:17f6
 with SMTP id 5a478bee46e88-2f54806545bmr7197928eec.4.1778262292087; Fri, 08
 May 2026 10:44:52 -0700 (PDT)
Date: Fri,  8 May 2026 10:44:51 -0700
In-Reply-To: <CAOTNsDyygMEz4dgfkWKb=wWP0g9MhNFgDHzPPEODbMGmDQLTOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAOTNsDyygMEz4dgfkWKb=wWP0g9MhNFgDHzPPEODbMGmDQLTOQ@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508174451.606855-1-snatu@google.com>
Subject: Re: [PATCH] Makefile: link osxkeychain helper against Rust
From: Shnatu <snatu@google.com>
To: koji.nakamaru@gree.net
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com, 
	sandals@crustytoothpaste.net, snatu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the suggestion! This is indeed a much cleaner approach.

By wrapping `RUST_LIB` and the rust targets in `ifndef NO_RUST`, we can lin=
k `git-credential-osxkeychain` directly against `$(RUST_LIB)` without needi=
ng to introduce an intermediate `RUST_LIBS` variable. When `NO_RUST` is def=
ined, `$(RUST_LIB)` evaluates to empty, and Make naturally links it as a pu=
re C binary without any Rust dependencies.

To integrate this with the universal build support (`RUST_TARGETS`/`lipo`) =
introduced in this PR, I have updated the changes to:

- Wrap the `RUST_LIB` definition block (which resolves target-specific path=
s for universal builds) in ifndef `NO_RUST`.
- Wrap the entire universal compilation and lipo combining block in ifndef =
`NO_RUST`.
- Remove the `RUST_LIBS` helper variable and use `$(RUST_LIB)` directly in =
`git-credential-osxkeychain`.
