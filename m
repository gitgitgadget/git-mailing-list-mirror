Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3B3594B
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750719594; cv=none; b=H48/bAZSucNvdD3R8mVeFIdW+KNWsh4S0yNw6r8AhOClpGO85V6j/Pce6LI2ABZs9G+7bYZUdkCH9zZVvTntvoGCNS0WJZKQV5lW8xj21DV9upBvqbn0R007HYoGfWwEFfnQw/iopFH9Jgn+yiJQcJtXXZwOefDFcqAPBit+XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750719594; c=relaxed/simple;
	bh=rZlYgXIkC7Lgdm/ey9+uwaoisjmub6NkzQHCqzfJkpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=puXQdpPBVbU+VGiGUTYZo40BVPBrkW67MiESFsLHcxuKz+6NrDFMXZksMpGpsIYPdTPRegTWq1jeWVgt7vGvosfgKflg50CmGb9IffZL+a0X919qX3sk13otPDhLgGlrohAfJRAYYfY0nezbyDNqW8tiPaIiTdEAM4IRrcp3XhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=opsksle7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTHZFzvl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="opsksle7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTHZFzvl"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6DDDF11400D6;
	Mon, 23 Jun 2025 18:59:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 23 Jun 2025 18:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750719591; x=1750805991; bh=h7sPplLD4d
	Mkg392BfBKf3pwzQqyaHXCWOuXKktFoLc=; b=opsksle7hchCM9smai96NQiDaZ
	UT7VIwFuU3Ho/qzW1jfKxrBLI/lcuL7Qvtt+v3lfhfDIjtNN8THnsAr9tlRvzMd0
	MszGnsTIYY71vDBmh6qZUEm/t0LXjbVZtq5YsY7VfdvBPOLcDnAlT0qDRNQspFXW
	PGACfepieaWwFP1fEmoV9cnz4JQsii6X7hjF2xbocU61p1ZpBAw5BB5VUNXnW9ut
	NyIVKiVbaGQoRmf+wJav10DkCdpwkZIxeYQFORNQzVm5QfY2xyA4UNz4GmqpGaJp
	7qh4VIkWqYK5g1S8KTXM72Ny3bWJKmROkaxtDRTw6iGQqUuo6xEgnpVneEuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750719591; x=1750805991; bh=h7sPplLD4dMkg392BfBKf3pwzQqyaHXCWOu
	XKktFoLc=; b=DTHZFzvlP2Bk4mKL8FInKj2MatavVH43jNxx4+x7orZ/lw1jQbE
	eQwXV7u0loGWWL6szFsSnGqZHnIWmceQ482qykkSau3cHOiu7qLoXumC9ZlZktmJ
	8wd58asxLZo/6JHyBBmWue8LKX7fgLFuLKrHdJbtwhcy9CwtHWQ1owgzvh7C2kBo
	q7t7zsocJTPW9SIf/MEK6CExd+xcaeAdVlgm9IR+DHPVauZ5vys3NXzrA6gdgS88
	RIALRenVruFNZNaSIW1DJUY56aehgP024dVtYlZNWJGaPdLGah4Hy0f0E6qmPi1/
	kjamYSkTLa6JV6Nf0s+9u6S21KZ0DzFiM5A==
X-ME-Sender: <xms:Z9xZaIFIeAnsEL8T-h3CPR7frWjCL4wg-szGL1nq2QDd1XGsUkYXSA>
    <xme:Z9xZaBXhPBaBSpn8fyovmqBDZRAG-_xUDfhCTxTY3swEZNV3bSkikE7fCvh73Ar_O
    219QgzUghcWXbNJnQ>
X-ME-Received: <xmr:Z9xZaCIM4dZEaBbyc499Onr-As4jdgAivnM-pcD2I7TOe5g7V3SgWHx5kM3ujxK2oCnSTF0u8KpIMKrPqBike53DFVzEBvbEjVwmj7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddukedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Z9xZaKEi9J4TMjPcl5UXUVawq1OFDnWcNlslnOcehI0F6QbEExOKug>
    <xmx:Z9xZaOUov8sMjeE6GW4t3qWz2iPFjIbBpT9OEh1_cBwutyyHijmgHQ>
    <xmx:Z9xZaNPDJEkmm1dTwaEyuI8Mwcc6i2gfsVKt1_n2bbf9bzzw0SpSpg>
    <xmx:Z9xZaF2EuB8EcHQeQjPeIrDkPWcO5LpSpCsCfqY7qc0oPlSXwOhO4Q>
    <xmx:Z9xZaAbGbvIhD2NsPFPpKQRLc405eU0t5mZNUGLuqtRUqM_CV3gP_iGY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 18:59:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v6 4/9] pack-objects: declare 'rev_info' for
 '--stdin-packs' earlier
In-Reply-To: <c9f874eb9470bf2a5d97614b89304e892c30e129.1750717921.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 23 Jun 2025 18:32:18 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1750717921.git.me@ttaylorr.com>
	<c9f874eb9470bf2a5d97614b89304e892c30e129.1750717921.git.me@ttaylorr.com>
Date: Mon, 23 Jun 2025 15:59:49 -0700
Message-ID: <xmqqo6ue3vyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Once 'read_packs_list_from_stdin()' has called for_each_object_in_pack()
> on each of the input packs, we do a reachability traversal to discover
> names for any objects we picked up so we can generate name hash values
> and hopefully get higher quality deltas as a result.
>
> A future commit will change the purpose of this reachability traversal
> to find and pack objects which are reachable from commits in the input
> packs, but are packed in an unknown (not included nor excluded) pack.
>
> Extract the code which initializes and performs the reachability
> traversal to take place in the caller, not the callee, which prepares us
> to share this code for the '--unpacked' case (see the function
> add_unreachable_loose_objects() for more details).
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 71 +++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 35 deletions(-)

Makes sense.  

Another forward declaration of add_unreachable_loose_objects(),
after one was already added in the previous step, confused me a bit,
but this step is merely moving that a bit higher, so there is
nothing funny here.  Looking good.

