Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BC199EAF
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737859802; cv=none; b=VAaIDsKrQxnqvapSaBOZjdTQdqesJKwZcjJXbahm8zrBEh80HEF326YFumgT0KtPiTzLhruDuXSWNhC4GcWPzO2HOsj8Jzl5dw2h/VPRIoBPaSyLxMR73faiSI4P7VZXmDhBQTHa0W7TwPXeieLGThToTyYkUpO1MseNjRaStvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737859802; c=relaxed/simple;
	bh=cWbAxPPuAhr8R1JeFCOZig/zq3rrQX5DWRh6ZB6fBo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aV1pipoObRIwFYnqwmmmlkStzim48zhV8CP4c2kRqYxBDg4hLLIAXPAILs93R082z78/54OcatQl2zT+r5N/l0Ekxi3zTSJrILPPigL0x5A7o3Vq5FO3S6pJ2ws81c7pSdGUYvZx7hzjV8zsnNf1eNbIg1P96NcNX4AA1ms5Cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k10rh6nX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nTs9HtYW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k10rh6nX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nTs9HtYW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2416B11401C6;
	Sat, 25 Jan 2025 21:49:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 25 Jan 2025 21:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737859798; x=1737946198; bh=nh/dtnXP8F
	4YwMAFHOfx6ir9rxEhTCA2ehsLhHvebYM=; b=k10rh6nXhy5bjOKewqUoJMDXyL
	PTC236Am52zeQqp1VhAZa4yYx566cTIEWM25gYx6nv13DY07oAWF4wIqlgK5Cb7r
	NVEJZsO6MmvEkpoYFj56FeqSks/+Vdrd4h6I/V5JEm8lFcjoSFclublhE8hYPmQ0
	+OSvuGR45xIUu33JSoFoE4VuiG9msn7IaflWtOtX6SBG2fufFexCSLHx6gMZY5cL
	WnYVdfcRFosO2Xbj3WuM64uUe+3Ieg/eds98S0nnMMtPyvPANxx73ZX2ONu1zvcW
	8Qn7ky5/lQCUtWTiJ53V/wwRzt0jHsuNtFPmbdNOHVTOe+HI70Xm1gu/AMKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737859798; x=1737946198; bh=nh/dtnXP8F4YwMAFHOfx6ir9rxEhTCA2ehs
	LhHvebYM=; b=nTs9HtYW3bvTFcReWhjAv/SUDavJqfXfzpLsag7fuTFz0E0zsFG
	AbphFC6alf7UitKb7CVGRh38KuDBWqY1W9cdzNFUP7YnxANLwMuqltNLPlnvWX+s
	5Uk1Pp8VtpUeWxxMlyTFs397vL70TQdOR0IZyCnFvQsIYu0lEU2I1hZyHADkXONp
	KThUF2ZzBojj6gbn8nBlhGv4ysgLvekUPcljJHpFl1goN+LbwNY84FUx+1CmDji/
	q4LIddaqp1+P7XgoPwtZQbJBneuB0jGJ4Na+6HqABscxcbUkqo0Y69pbZxMFpKn2
	7PnHwSSOqfYUMYWYtu/GQDmdiO3NArV7wrw==
X-ME-Sender: <xms:1aKVZzpfyRYyKNVu_yWDDjIGpmvABZVrXaU2afyu-PWDK6FEXYYTUg>
    <xme:1aKVZ9rDufwFl4Vbvt66t5XWS5wyqt6yYzwai9uHMybWgGlqTpuHWy5NL4mzUdGwo
    3GHcbRxvAR0skPHVw>
X-ME-Received: <xmr:1aKVZwOYZhHj1SVJ0ORU5HYbuQFdqh5-EDe1Bvyiz736FD7kHXOmnXIk-ooEZ0_wr9ruiR2XjUOMZDNFTyBuGIQIqgL5n4zipMOf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgleduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1qKVZ27X6JYLq4WPGcphGyv2ujP9hC0S-cV26m691R8G8Jrl83-ONg>
    <xmx:1qKVZy5SXKyNvWsJpdsaPAq9saBEBCg62NOHqDmKfBqtJtZsdJPRbQ>
    <xmx:1qKVZ-jtcnzUoMqcRt1OwuEGYzgSc1md6s_vjy9UKipxcmhrwXZuhQ>
    <xmx:1qKVZ05NKzPCRRNEhP_-iPium18HsuAC95S_tChRkpyUsgCFsWxLIg>
    <xmx:1qKVZ933z3C9AhvVLCQ2EQ5VuWPEDqLorvnbWRlUsfvTVdxIkPdflCWI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jan 2025 21:49:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] bundle: avoid closing file descriptor twice
In-Reply-To: <pull.1857.git.1737849456338.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sat, 25 Jan 2025 23:57:36
	+0000")
References: <pull.1857.git.1737849456338.gitgitgadget@gmail.com>
Date: Sat, 25 Jan 2025 18:49:56 -0800
Message-ID: <xmqqa5bewap7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This seems not to have caused too many problems in almost two decades,
> but I encountered a situation today where it _does_ cause problems: In
> i686 variants of Git for Windows, it seems that file descriptors are
> reused quickly after they have been closed.

Nice finding.  It pays not to be in too uniform a monoculture.

>     This is a really old bug. Deviating from Git's practice, I did not apply
>     this on top of the bugged commit. In fact, I did not even apply this on
>     top of an older maint-* branch because it would cause conflicts even
>     cherry-picking it on top of maint-2.47.

Just for fun, attached is my backport to maint-2.44 track.  It
merges, with conflict which is rather trivial to resolve, back to
v2.48.1, on which your original patch is based, and gives the
merge result identical to the result of direct application of your
patch to v2.48.1.

I am not sure what to feel about the FD leak mentioned in the log
message, though.

Thanks, will queue.


--- >8 ---
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 25 Jan 2025 23:57:36 +0000
Subject: [PATCH] bundle: avoid closing file descriptor twice

Already when introduced in c7a8a16239 (Add bundle transport,
2007-09-10), the `bundle` transport had a bug where it would open a file
descriptor to the bundle file and then close it _twice_: First, ...

... At least this here patch is relatively easy to reason about, and
addresses a hard failure (`fatal: mmap: could not determine filesize`)
at the expense of leaking a file descriptor under very rare
circumstances in which `git fetch` would error out anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bundle.c    | 4 +++-
 bundle.h    | 2 ++
 transport.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

Obviously this is hard to test ;-)

diff --git a/bundle.c b/bundle.c
index a9744da255..7b3f2da40f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -616,8 +616,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
 
-	if (verify_bundle(r, header, flags))
+	if (verify_bundle(r, header, flags)) {
+		close(bundle_fd);
 		return -1;
+	}
 
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
diff --git a/bundle.h b/bundle.h
index 021adbdcbb..8b187be7cf 100644
--- a/bundle.h
+++ b/bundle.h
@@ -50,6 +50,8 @@ int verify_bundle(struct repository *r, struct bundle_header *header,
  *
  * Before unbundling, this method will call verify_bundle() with the
  * given 'flags'.
+ *
+ * Note that the `bundle_fd` will be closed as part of the operation.
  */
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, struct strvec *extra_index_pack_args,
diff --git a/transport.c b/transport.c
index df518ead70..25e2233da0 100644
--- a/transport.c
+++ b/transport.c
@@ -184,6 +184,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
 		       &extra_index_pack_args, 0);
+	data->fd = -1; /* `unbundle()` closes the file descriptor */
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
2.48.1-293-gbb90fdfe3c

