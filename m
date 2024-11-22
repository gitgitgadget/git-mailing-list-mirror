Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80142056
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298509; cv=none; b=UiUEZc9tuafXHjNCDxrFe/f1pEZZ3PuRhEmk2wjJqnLXj4lz5oVMwRNAEXE61Z3GxeNsUjkvY/2RqlkXh3JZpG74qM0bQRnEW89DRin7A8pY9qoVxD+Ap+SnZRxdxcmZjcLQC2QLf4wVsLHNlt7LBEGwn3zDWWBwykuF0VHgVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298509; c=relaxed/simple;
	bh=HglrBGppYbU/4vsW253B+rabodgX3C7l/qnrSZ/2Na8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=UgYufRuPpNmWokZOVzEtjLwjkTHgC97jZKHRyMhkgZB+xkKkuJC492RtjReQESBGsbOtaB2afF+2A25Xs4qIKJUQeNhpbHFBVOgYD+sQCcHizHJIpABw7WCxggWzdg6fJXZLR4Elbdp3F69s1jwE/+UFYtFOSFI77t1m6t4tFZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVcH9hvL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVcH9hvL"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8794f354so41224177b3.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732298506; x=1732903306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fg5HVgpti/ybDZmdufLtv5GJF9B3w5u+IK1AbBvN6+Q=;
        b=PVcH9hvLJpe3ggO1vm6/E6sKOk660jj6OnbNulksBdpxfyk3o/bOhCGPVilP6nHEEU
         9MJA4W2EFIfkv01d5xv5esa+o0u6dcdQ9th1etNhMWJ7NFDA6W1ZndT6GQGTIcMHVwE4
         q0SIn1SWMf83LZAn8SOuPpSbfpwITDlDHv1rZKM+x1HUr9J9snrrtLeDSrJIiIxNeyal
         1ebnsf9k2yzZvGaKpPBrHW2wSK/ftMpKXlKflpwuYlfptRDMxuE/AX9YZvVU/rbJECZR
         ipJQs7j/jYgU4Jb7KVy71qeIzZAWLL1OV/691f/rcKQNOlV89oPXKi4F9J+qXt4YUakO
         OuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298506; x=1732903306;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg5HVgpti/ybDZmdufLtv5GJF9B3w5u+IK1AbBvN6+Q=;
        b=b4eybvtEKa845dUZDpgxfsjk/6EjPxybd344m1ay4uRTqBt9tuGOR6dsTJk6vhK9LJ
         m0qZA84w6Pg2v4sV1S6TxhoA6lfbrG0hnQUmHyC80yoo/Zy7HIi5kuqUpqtOhN6ZZTrO
         2RcGPI0jlkuL8haX1bP+JKINjwDzQ8fW9af349Cr8YwhiVprFTl6zXhO2eKBUW4C0UG9
         CNnlxpae3+gDq7pfgQzOz4j/vt7VyzNL4P1TQtUg0akPSDUHOzbiSVI3Iwhhe7WA+6dI
         omDypDgRXLNluaIcTwNqQeoQKuMr2EzQwDxGRnj8R3iv5khpMf7AkMeaIQpX38SK8pd9
         aAxA==
X-Forwarded-Encrypted: i=1; AJvYcCX9S8nslBd3D/Wc5m/WHXv8ixSINFYzjceWXNq643UExkqzvyY2nQKNYyFDL0LHfyRxY4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywak5Ejm8JN+U4dk+VfA0NLLpZRjjLoutdaCXYDHG84Vhsj/rE2
	7Q8rsqYHd4p/1deSXyBlSAIqvVQtvrYMrCkD0PZ8/N8f2g7rTHekJsmVzGhIv5H9dcOWgZadsrv
	Ztujzk0u9BNs2ecwsvJM4RHzhezZzJw==
X-Google-Smtp-Source: AGHT+IFBpeNYSD84e7wAhQsT6eYifPLOy4Y1uB3VQ25I7Nh+X71fNmCGjulhSuTMxL+lZPV712mCFmESxgGa48cvuc1i
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:570a:a451:c8a3:c7d1])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:6c90:b0:6ee:613b:10c3 with
 SMTP id 00721157ae682-6eee0b7d9d1mr661877b3.8.1732298506190; Fri, 22 Nov 2024
 10:01:46 -0800 (PST)
Date: Fri, 22 Nov 2024 10:01:44 -0800
In-Reply-To: <xmqqcyioar4r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122180144.523048-1-jonathantanmy@google.com>
Subject: Re: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, 
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, johannes.schindelin@gmx.de, 
	peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, 
	newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> It is sad that it is a (probably unfixable) flaw in the "promisor
> object" concept that the "promisor object"-ness of blobA depends on
> the lazy-fetch status of treeA.  This is not merely a test failure,
> but it would cause blobA pruned if such a lazy fetch happens in the
> wild and then "git gc" triggers, no?  

Right now, it won't be pruned since we never prune promisor objects
(we just concatenate all of them into one file). But in the future, we
might only keep reachable promisor objects, in which case, yes, blobA
will be pruned. In this case, though, I think blobA is like any other
unreachable object in git. If a user memorizes a commit hash but does
not point a ref to it (or point a ref to one of its descendants), that
commit is still subject to being lost by GC. I think it's the same case
here.
