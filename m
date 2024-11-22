Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C344206B
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732238643; cv=none; b=pwWn6sxjm08Q4ABgWWMKWcqEUe8/LYYqRArxY6AEXSYB/fdenizMJ/2P864iyZ5296A0Pk1vd7p4wJvLqsMsfPdBDnhM18XAZlGddXoAL5pQV2BChkX4td0EhZDqgXhNIsB/ojvwW1/Wx/Tg2f9uyPdBu11f1y28HYAXOyKTGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732238643; c=relaxed/simple;
	bh=Ld7lZZ1IU3xx+ZPeMrhgZRh3fDNQCUWTQkcQ2yQTNPc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ACqe62HoeRL4dGjQiGHCbGQtrnpHyb6qlQlEJN9nmHbrqhg4R/tQcznQbfZ5XorBDBZQ+ZKmbAV2rT6k9DcdAgkUIzpqGLaTcgWuvy8UNSrHphDKKS0qjuvY21Ejo4vT5Y61BnkvBAQgNc38R5xTn1/Qm9wke6x2UEvIvGWpCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2rewcSZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2rewcSZ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e38fdac3895so41912276.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 17:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732238641; x=1732843441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DMUUBis0ILwGOV4ND33Ot+wARlHNAX9XUXjrUQbGOWc=;
        b=r2rewcSZU36bV3T6idkTLA8zWrs+bKljAkKIwG421mrRc0R+UJvS/g12MDes7Cr5Y1
         lOBcvEoVzq1SYVtgSv5gNFXAN7aopdFfQpPdsdVIL+kyDMbXx659kx2ARNbvfnH23v86
         /tsePK8lyrYryYErBKiGJeCEnxuECEQGmY14R9YSo4XBVguUpfyIolH7e0ThHNIN8/w6
         Wccpxlqe+nhukQnOpqfsVN/ZnWk9YIVS2NK9UfOeti0ibHpTqtvcG29ijLBzlei9Xeol
         659EGmniwcOxVZ/CMIGQti6N3bHOSbLzjT/D5UsejF+8vhnhtBLA4JpGMkSPLN8endfW
         PmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732238641; x=1732843441;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMUUBis0ILwGOV4ND33Ot+wARlHNAX9XUXjrUQbGOWc=;
        b=OTtzjRIG3yyMAoYRDBygUGQHiT/aXauiCcApQqIAH2wXyKKbZ2BnRGxRG158GijFE9
         MeN7w8CPeyK+ccaoJV7RHfbIgdK+F0+BixPTRwR6PSBy8uVwkOwHe//r9U841Eo7nICQ
         mfOxrKjUGNzQ+36l3F+0xHpfIS4RfcDFO7cpLT+qlpTXkMiKU7SG51+MU+bJNS2SGXez
         G8+XtLA/9W8dVoOW2/K7v5wC9+GCdO5fZctWaTS/FDeKkU6k4ApST14mTkZHP43IYTAN
         CXumAk6lyPsoWiRGdNOQgb9KB1UYN+YNZOYKeazoZ6+jRMYMu4l0sWlZBjB1ZCA5ldNl
         Tzww==
X-Forwarded-Encrypted: i=1; AJvYcCWJN81hDfxViCvD43yvbPbPT4qkxTHItVCboB1CCDbWdCxkSrH6xWHk0X7b+nFIkZ1u7sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkPzUChNl/x5rJibPibsSVq6fNhlzmRByQmkObaivLXgrCovNn
	7jYwy69woyCpXoMupKP6Ojie8MxSKTAlgLYDwPh+DJydyXrcOwhWwlfs+nAT5uGQW7Kqrtdz6bm
	BLmH+vrPMVGTtjYsaGLbB7BQes+XNYQ==
X-Google-Smtp-Source: AGHT+IEsUkGKUfq0Tv21nNf5u4O2Wt/xIm87k31rFTgHk6eV4S0Ba/aDj8w7u4Bvv3ORnWW7u4CXkw9ASuIwzFDcxCoR
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:d214:e3cc:8644:78ef])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2d25:0:b0:e28:ec75:75ed with
 SMTP id 3f1490d57ef6-e38f8892f14mr1359276.0.1732238640924; Thu, 21 Nov 2024
 17:24:00 -0800 (PST)
Date: Thu, 21 Nov 2024 17:23:58 -0800
In-Reply-To: <ab341dd0e58f77b3c7c6f5765d9e34cb02bef56f.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122012359.2764951-1-jonathantanmy@google.com>
Subject: Re: [PATCH 7/7] test-tool: add helper for name-hash values
From: Jonathan Tan <jonathantanmy@google.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, me@ttaylorr.com, 
	johncai86@gmail.com, newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Derrick Stolee <stolee@gmail.com>
> 
> Add a new test-tool helper, name-hash, to output the value of the
> name-hash algorithms for the input list of strings, one per line.

I've looked at all 7 patches.

I didn't really understand the concern with shallow in patch 6 (in
particular, the documentation of "git pack-objects --shallow" seems
to imply that it's for use by a server to a shallow client, but at
the point that the server would need such a feature, it probably would
already have bitmaps packed with the new hash algorithm). I didn't look
at it further, though, since I had an algorithm that seemed to also do
OK in the shallow test. So we might be able to drop patch 6.

Other than that, and other than all my comments and Taylor's comments,
this series looks good.
 
