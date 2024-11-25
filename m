Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572331B3945
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563945; cv=none; b=HmtPh7E7XI2Bwwub47nIabx7g+TRQizTfgeLg4xoKdyzT/d/W2GAFUtsye8EcNTSs+/uo2ETwl1OhUtvpCDlmITvSDGHkooQjDVZmf32DCRhCt+bZTIkws+WO4dzjeTg19R3aSddN5IYtQuTJ39uXwIsUZ2rmc4DWVIk7Cf8lQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563945; c=relaxed/simple;
	bh=x39CQm23C/r6HqnnainJpqPHl5eaefsk/O+YeCetdoI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=DZlpkCi6zCgu93wx8rNy6LiaB/sUYuAm2bwzOD6UObZPGt6I0wg3ea6nkvUW7uuMmgxvbU5PUJtdWZ/AoTayNImB1NHqz3I3Z7LHTfuLdBnyQkDPV1Zv2+WDXfC2/P1zDuQWMRRAxfA/uUxNjkJYf6zwd+kDeQzxAxpCXFKYjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fda2DBpx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fda2DBpx"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ea5e1bbcb4so5057954a91.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732563943; x=1733168743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/3DnU0P3KrSAJHgB5sKDwx+6aDiFSLcPfZok6mL1ork=;
        b=fda2DBpxLfxu16QeZUAmuail+9W7MvTuCtGzqhqsW7Ke/lvFQihssWndSpYBodKZpJ
         9QRBTBYZwsE47radpo9R59xvUD+OWs0OQhDIYSO7rfV0GNB2HLRspD/dO+BAiqO5o5mA
         +qqZb6smq2SAamFC+1xIR44ILw4v39g8i6U06MM+zjpCEuFVGX0a1FsF58THSQdzTszM
         LIKFe8eqWvLebt1YNX0NFrU4yiXF/Fj8AEVWM/UHyzL/8rhPdOhdMKq6TR0pKsI/Br9s
         xJy8oMr7N0/VuXBgDvlE2VGQ6y2LLLi8mJdY1tRwy+tDWH/lilM8ErDjkWusWD24m/+R
         AIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732563943; x=1733168743;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3DnU0P3KrSAJHgB5sKDwx+6aDiFSLcPfZok6mL1ork=;
        b=sOjRW+WzoGAlcaNHQshUM+3cyOoqNAE7MFxTbBp+k5YZ1LkNTJv6IBrZDFTzxUx3bF
         5jhY14t5CnasIQEzY/3rH81D9yumKxONlHbubjzDmzrPtPp0rLEF+7QMVQ8BrFi6/UM5
         UOxK0geT5c6WdGs99G/VbERXJwWQC/kUxdr+1eBHNhiPEFTlmONGTe3A/Mw8rrkig8LV
         g+PRh5uwqLDbi0F9NH/6XTc1uIU/e1jnAqDFwVwhqvbq+LM++GvkNokPkVH9H7wbb2cw
         XdAo0gakyrCMwDlnNSTG4bfHxnSZQ+aUoihyrr0sQxtGnuI4iTCqWnvV6xXLHwUSS48f
         OtYw==
X-Forwarded-Encrypted: i=1; AJvYcCX5zxG87vXKmnV4fXPx0pvYuZ5IIQjVC4S5Wz54NzliW5uN3sSKtOCyt+zkQSz14t3D0l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7yA8Be5r2wdl055px3ZMwJsMJGIMjgKikhCj+dYm1eWhO82YQ
	qG7wJqvkXQQOtRMvRA1m3bO5wbPG3bcAPHD+K+omIwNILcUsMO7OnzbciZ1PIfHlF3HuKYbEiTE
	Q/d4R+pRLvMesdq9ucfTXuGbFObmUTw==
X-Google-Smtp-Source: AGHT+IGiCwLG/lwvMUusf+8T/BA7QQFfuxphyHQjpFlmeI4z2cs+ELCkTOzmt/weYvdrKZ6OMM2C+D3aFc7ocfqSXabr
X-Received: from pjbqc17.prod.google.com ([2002:a17:90b:2891:b0:2eb:12c1:bf8f])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c03:b0:2ea:bea2:dffd with SMTP id 98e67ed59e1d1-2eb0e528e71mr15247851a91.21.1732563943600;
 Mon, 25 Nov 2024 11:45:43 -0800 (PST)
Date: Mon, 25 Nov 2024 11:45:41 -0800
In-Reply-To: <xmqqjzcs87u0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241125194541.809707-1-jonathantanmy@google.com>
Subject: Re: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, 
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, johannes.schindelin@gmx.de, 
	peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, 
	newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >> It is sad that it is a (probably unfixable) flaw in the "promisor
> >> object" concept that the "promisor object"-ness of blobA depends on
> >> the lazy-fetch status of treeA.  This is not merely a test failure,
> >> but it would cause blobA pruned if such a lazy fetch happens in the
> >> wild and then "git gc" triggers, no?  
> >
> > Right now, it won't be pruned since we never prune promisor objects
> > (we just concatenate all of them into one file).
> 
> Sorry, but I am lost.  In the scenario discussed, you have two
> commits A and B with their trees and blobs.  You initially only have
> commit A because the partial clone is done with "tree:0".  Then you
> fetch commit B (A's child), tree B in non-delta form, and blob B
> contained within tree B.  Due to the tweak in the name hash
> function, we do not know of tree A (we used to learn about it
> because tree B was sent as a delta against it with the old name
> hash).  

Yes, that's correct.

> If blob B was sent as a delta against blob A, lazy fetch
> would later materialize blob A even if you do not still have tree A,
> no?

Just to be clear, this is not happening right now (blob B is sent whole,
not as a delta). But let's suppose that blob B was sent as a delta, then
yes, the lazy fetch would materialize blob A...

> I thought the story was that we would not know who refers to blobA
> when treeA hasn't been lazily fetched, hence we cannot tell if blobA
> is a "promisor object" to begin with, no?

...ah, in this case, blob A vouches for itself. Whenever we lazy fetch,
all objects that are fetched go into promisor packs (packfiles with an
associated .promisor file), so we know that they are promisor objects.
