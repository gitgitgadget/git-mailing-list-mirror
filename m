Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD71213E7B
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675694; cv=none; b=OLoedvTXAF4dQPUA9ZC8xofFLCsZWxcaHvzaBzIeUzULBJsIAD6FlWNrUbrZevbT7LjV9MEkto9t0tcfcud9vEmngHlKCeAU0fA8mCLLy18oudScY95Wp29ik3FQ+JACMjBr/MjcrUqX8WZIB7D9ZfqKnHDgqYOZ2dEiSRwCQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675694; c=relaxed/simple;
	bh=M06i3QloZudbBFjnrE/gxXJefqlUja5Gx4MrbeOmr9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjUg3Ph/YERbYw+zuEOauNOS2aKmHFYSUUCyGwjRJeA1gGI7KSpuxh8fj+SYeHsjDmSFVylCTuUHen2V13nMEr5KHNk3P1X2XGdpgqu33IyZrSeLpwX90lF3AihqzLgHRy6cJKo79afLicrZASzf4EL6tTeByglAcAPxYfPqCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LCU0comr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yAZ2/mUc; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LCU0comr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yAZ2/mUc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D3C672540126;
	Tue,  4 Feb 2025 08:28:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 04 Feb 2025 08:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738675691; x=1738762091; bh=RQ5ScEaa2p
	uXG2ZbdtApNNh9v58lGWvgXxyzypPsYIA=; b=LCU0comrPSfMotLrTSf1PAwleB
	gR/fFnlsCG1Dcq84teUq7I4HLi9gJb6WFOJOII1eAN4F/jpFjI0KtkZ8c3Y3jEUA
	7TGLBWTsY6VUgmno3rldtigBSYXiF7JmxqkkYHsZLwL+YnisN9OrFPvGbhhkdfMk
	txlXVTFNDtMDo1xcbTlq6wiwQFI0AGFACcWi6KCcBB2B7cmaQdBifQixF/e+2iuW
	uJTC6NpYi57e+A03zmK7Opp3Ez2j2VonfiAsPzzYzvtBRbfq5nkcKWe+DzXoBitM
	OLJ1ZhHDzZpYiRe1utqOtY76V+YhZFHMRRA/EwOQQ248LmaaCUJH643O4uMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738675691; x=1738762091; bh=RQ5ScEaa2puXG2ZbdtApNNh9v58lGWvgXxy
	zypPsYIA=; b=yAZ2/mUcSKv8mDl/ANnnP2I8rIFVxmx72mwdsl5O5TPIfsjlRBa
	z7Jtf4v31fdLDWkftShrHHF7NDybM9OLf2SDMflHqU2Z986gZJEczOoi/zRLNGGR
	RB5caWFl29GGT3CE0H+vkUSWVehBsnTWHYWbVhbLr6+DvpMvIS+NsW81G9gS/hyK
	TWbgZeloEaEcAi1LmQFoAFMWuvA+MIoC3tAqSGgk/SZ6tNJpjvEuN3USHnmbJcNF
	c8hm2+jXOf2mKbYyEebncs7bH8PIrA6zFPbZtQNlKWU8kIvdIbpGvqf+reYqUZtY
	7Egh1BKzQYSf4kfCnBtrZPQJg13tqLKCoPA==
X-ME-Sender: <xms:6xWiZ77J4D6QoS_9PJpQjSu5RvMGY95pOBHYih0ZE3-Y1hUx66ZxJg>
    <xme:6xWiZw62FMIet4e8nEf_JLMnZH6f27Q1b_mRyy2DBBLwWqZLcKwTHPOWFuiyY1Hqj
    SNTU7kAUeIFZhu7YA>
X-ME-Received: <xmr:6xWiZydwqi7ihSMDR2yzY6VGzv96UmxbEuBLzOUSXTIe6yqyRkyKYwq9sIG5W7ksmYxiOmPdjpCqDpAy1XYEd23hK_61-TRVakIb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6xWiZ8I2LHoQQXblopNQ8p-At854ZWIQD2EcotoPNSITdX05o1hyMA>
    <xmx:6xWiZ_JgIbG-VocmwYrg1f06H_RxSacsIdNfj_4qOysQwk9932ac9Q>
    <xmx:6xWiZ1xPTiRKmhjdR4L3d4VEca2jG3PtVKsvW0Lh08nZTr14MrAf2w>
    <xmx:6xWiZ7IDEjRHqr6G0ZmmGtDJuBrH5X4NOiIM6FOe2q5pt4KrzROqEg>
    <xmx:6xWiZ33EVtOqeeRbIbeDgGXmUKWuE1EF03bdeDhVZSiImliZna8jlg5X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 08:28:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/repack: fix `--keep-unreachable` when there
 are no packs
In-Reply-To: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-2-7c4d69c5072c@pks.im>
	(Patrick Steinhardt's message of "Mon, 03 Feb 2025 14:06:55 +0100")
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
	<20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-2-7c4d69c5072c@pks.im>
Date: Tue, 04 Feb 2025 05:28:09 -0800
Message-ID: <xmqq8qqlx2ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "--keep-unreachable" flag is supposed to append any unreachable
> objects to the newly written pack. This flag is explicitly documented as
> appending both packed and loose unreachable objects to the new packfile.
> And while this works alright when repacking with preexisting packfiles,
> it stops working when the repository does not have any packfiles at all.

Chuckle.  That's a cute corner case the developers never considered,
it seems ;-).

> The root cause are the conditions used to decide whether or not we want
> to append "--pack-loose-unreachable" to git-pack-objects(1). There are
> a couple of conditions here:
>
>   - `has_existing_non_kept_packs()` checks whether there are existing
>     packfiles. This condition makes sense to guard "--keep-pack=",
>     "--unpack-unreachable" and "--keep-unreachable", because all of
>     these flags only make sense in combination with existing packfiles.
>     But it does not make sense to disable `--pack-loose-unreachable`
>     when there aren't any preexisting packfiles, as loose objects can be
>     packed into the new packfile regardless of that.
>
>   - `delete_redundant` checks whether we want to delete any objects or
>     packs that are about to become redundant. The documentation of
>     `--keep-unreachable` explicitly says that `git repack -ad` needs to
>     be executed for the flag to have an effect.
>
>     It is not immediately obvious why such redundant objects need to be
>     deleted in order for "--pack-unreachable-objects" to be effective.
>     But as things are working as documented this is nothing we'll change
>     for now.
>
>   - `pack_everything & PACK_CRUFT` checks that we're not creating a
>     cruft pack. This condition makes sense in the context of
>     "--pack-loose-unreachable", as unreachable objects would end up in
>     the cruft pack anyway.
>
> So while the second and third condition are sensible, it does not make
> any sense to condition `--pack-loose-unreachable` on the existence of
> packfiles.
>
> Fix the bug by splitting out the "--pack-loose-unreachable" and only
> making it depend on the second and third condition. Like this, loose
> unreachable objects will be packed regardless of any preexisting
> packfiles.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/repack.c  | 5 ++++-
>  t/t7700-repack.sh | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Nicely analized and described.  Thanks.
