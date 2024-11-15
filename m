Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365A1E1A35
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700507; cv=none; b=F3G+MnRXawU4xiHe/czRa12itTcNtGAEeOZJaUieKjzohnNTKUArFrZ0YmKpXk3zzRuu6UmF71EAp+0kdqO1UDPjMDlcske4gKvQyy5WVkVSPjYJZ9iC0ZPM3x+1kTLag2xQqIC4Y0CISPU+EJiHN8gZCA1YABTUmXET03cKDRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700507; c=relaxed/simple;
	bh=Jv2pwE3Vu2mFw/tz0BFpZ/eAgBDmif8C33oHRbYdcQA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Qd9RapKVLE+Ud5+GbWgIQP3ztQHPlK/62PW4gfeFEhv1KsROdxS+wGKvR62wMqMkmUSKrslZpiD/XWf/9lCrOI/H44dPjqevFKNnXjeiazBoRDZxxe2MIzd3dIH4FCo8hpo1pSdKCkjpQn+sd1k6XlP+sboF2yNS2+oIweEvmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPnXDpx4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPnXDpx4"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so18276197b3.0
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 11:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731700505; x=1732305305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmhTfi24jNsGSYvfsfruuuZKIAll+c8RqszCpLucC6Q=;
        b=hPnXDpx4249EMOxoIOtJfW1PmQSjBVmN8eNDfi8jRbG6AhUwoD9nft4SDd6nzqk+cF
         DcHfrhjYDY1F8TkVKVTF5Fc/cIbrgFd9RxPov8vMmOe7Xh7Sf7j54BxPYMVAtyfXQIxI
         kyQaRbKxO9RfHRh4nPX+NGo5b05JNcWOqYyv88RIvxM9hojd83NFR/s1BNsSpGCML7iV
         ziujQAYNPcD0UmN4BFQkxQaaBM1rL1MQPJ6BGTO9NpJeaXuDWjdtcO/FM7sm20Byahrx
         /F3rtWCAq+uLvJVb0L1K8f3nXQgqyayxTFv2WqLJyROSUDQimXYAI3FGQfMvszz0ewfq
         79BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731700505; x=1732305305;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmhTfi24jNsGSYvfsfruuuZKIAll+c8RqszCpLucC6Q=;
        b=O5U5ngtSU6EfqmAcPdYhWmRf6xzsG7pfjna9wR3zchfHK84XlvWmHQtNIPglsgcPoz
         RjHqk7gdSUWtF6jsH+TJFYS6lQuFbeMfJcjeA0R9YWhEnKZ1Obvj1XHKDML34zcIFMyj
         1k+ddmvqZwInqhkMzCOliYE6PmgSy4k+6QLnRIUBE8Tw5m8mgD4zXdx42BGYcYpd4H4P
         rO9hn2/2WD/SFzZ4wvmPhoJ3NlzwtYpBXjnlvpI+QmGzVfRwpWlzaNypBk9hrIV2dJlY
         zMqA4Bf7X4gslikajXPp2ZmVC3RYNLobWN3h9mTCOuURATax1KmAc0BXYBKX5YpxxZcV
         eg0g==
X-Forwarded-Encrypted: i=1; AJvYcCWucke0ZK0bS6xcGdYSUn7cYwhJu1kBhatRtGF7q3+30Y4+FTpESilXqTNVj6iGr/1hW5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygm173NAL6kxQnqkd91apWjdxHFJyeSRBRUWaTpoX4/wKrGJFj
	J3iWAaaTW1WbseWbwps41W6xjTSHSDW6xeulvtlV1EIBbNNlbMViEluq9wY5rwriRcdrmt3g8np
	4GMvnhO51oN8WDbITytY5OAOpgVrq8Q==
X-Google-Smtp-Source: AGHT+IFc+5LTKiBlbSL/IRr9Mf7GXlFTtmgUBH6MlzrA1SIhVfEQpw594o3I+xTzJq41D8F0Szx5HNmiERpIX+0m+lJJ
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:52dd:dce9:4fb8:8bf4])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b1c3:0:b0:6de:19f:34d7 with SMTP
 id 00721157ae682-6ee55b82b68mr1241507b3.2.1731700505511; Fri, 15 Nov 2024
 11:55:05 -0800 (PST)
Date: Fri, 15 Nov 2024 11:55:03 -0800
In-Reply-To: <20241114005652.GC1140565@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115195503.3395744-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/4] t5300: move --window clamp test next to unclamped
From: Jonathan Tan <jonathantanmy@google.com>
To: Jeff King <peff@peff.net>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, steadmon@google.com, 
	hanyang.tony@bytedance.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:
> Where it gets weirder to me is with quarantine directories (and maybe
> this is what you meant above). On receiving a push, we "index --stdin"
> into a temporary quarantine directory. If that kicks off a pack-objects
> run, where does that pack-objects put its new pack? Within the
> quarantined index-pack we set GIT_OBJECT_DIRECTORY to the quarantine and
> add the original repo as an alternate. So I _think_ both the pushed-up
> pack and the repacked promisor pack would go into the quarantine dir,
> and then we'd migrate both (or neither) when we commit to the push.
> 
> Which is OK, but I don't know that I thought that far ahead when writing
> the quarantine stuff long ago.
> 
> It's probably somewhat academic right now, as I'm not sure if you can
> even push reliably into a promisor repo (and it doesn't look like
> receive-pack knows about passing --promisor anyway).

Thanks for this description. Such a push would be an "I am pushing a
pack with missing objects to you, and you can later get those missing
objects from me" situation. Not completely implausible, but doesn't seem
high-priority to me.

> We don't quarantine
> on fetch right now, though we have discussed it in the past (and I think
> we should consider doing it).
> 
> So this may become more real in the future. I wonder if there is a way
> to add a test to future-proof against changes to how the quarantine
> system works. The theoretical problem case is if we did quarantine
> fetches, but accidentally wrote the new promisor pack into the main
> repo instead of the quarantine, and then a fetch rejected the incoming
> pack (because of a hook, failed connectivity check, etc). Then we'd end
> up with the new promisor pack when we shouldn't, which I guess could
> move objects from that incoming pack that we rejected into the main
> repo, despite the quarantine?
> 
> I can't think of a way to test that now, without the quarantine-on-fetch
> feature existing.

Quarantine on fetch does seem like a good idea. I also can't think of
a way to test that now. Although, for the fetch case, my patch set is
not the first time that an extra packfile (that is, a packfile not in
the "packfile" section of the fetch response) could be written during
a fetch: packfile-uris and bundle-uris already exist. So I would hope
that the implementor of the fetch quarantine feature would be aware of
at least one of these extra features, and design the test to check that
absolutely no packfiles are written if the fetch is rejected. (So I
don't think the future needs to be "proofed" so much.)

