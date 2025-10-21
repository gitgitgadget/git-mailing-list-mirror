Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C94355805
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069137; cv=none; b=gaSHUTK2vPsGcuaa9+hKaSNBcbL1lnMhbv8gBFb6jqvQp4ybBYrVLCjS7k/U4KY4PXaa0eIHx2BAf5n85ERM8K1Pl6/ikHGui70hNKkVVbR6wcgAiRqCUbGda90s2R9Qx7HC/EPJr+IrkrCXS2HrhAgsIzA/UFUZY3ljN8oKa+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069137; c=relaxed/simple;
	bh=fG+gCwa+NS+CsoCMJpfqrn9XB/oZcLsIKS7DwzEV+Yc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzlzpelO4feVfFPf3sOZozWCo+z1tRg+ExZFrogE2I2O8fiEvrWop5xeASW7gixCXJ8Pbc5SB0oUupMdk4BwmqlLotZtYSoRPhzNHFXawFn9lzH5hq3/aEOKQlwPPL3KnEeHjgMVZ7ItB6EQ7lrh/03yzT8S22L+QztgGlHGvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YF1gUy1W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sfq5hqc+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YF1gUy1W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sfq5hqc+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 852CD7A00DB;
	Tue, 21 Oct 2025 13:52:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 13:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761069133; x=1761155533; bh=bz71JPaDSq
	P4ZUR4b65ANgbgxxKrGIHXhmuGOlzcgIQ=; b=YF1gUy1WyjzK7VKUrp6qbPdXq7
	Rdf9tSTmDrUEhpwagkpXAxo768QeVBSajENBqItcO0f0rzguy3WQu6T+3Nxbs22W
	8HU1Oyj0+Grv+7nrjWioImuohxyLyrr3VLe7T661epw2PuGr13UtT+mKhOlF62Bj
	BR5B6bToTlxxpp0M2C24nBNkvDIeavdLqcjSvwOMy5bQXLwIoXd98feCgQSO9P+n
	B4Zea3k8+lh//RDuBUi7U/unUs+btndiarpChvn+znmVwUBqTdyBnZgIKP7W60RR
	QTBuNjj9ixuTHS1usLaMzlaTqbIrlMuYF3+mKhs6y7VTnecq2okkgBuJoZmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761069133; x=1761155533; bh=bz71JPaDSqP4ZUR4b65ANgbgxxKrGIHXhmu
	GOlzcgIQ=; b=sfq5hqc+q9S/2adCfUOZSdU/jXQfNmY1HnkRfVzferudGkgVTGl
	3LBcPayO2qwtwkYiuVzI9m2CaU3nkOnjbwN7dPGxDiQnvxN/I+33S5wzfv8ZK1ON
	nbNq+QgXITRCpXuilhvPXMCg2UUsmP3j3TuP/IBvLfQXSNd1kxmmElrlilkzPObj
	hMUpARtNGDDMgvuhcG9RasLROl9opZRVkOO0xL1JNIYp74rmBDkktE3kMVkobp7N
	YAXjtsG65lldRhh5Cv+t7y+PWSXsCN248RelVg5JAj7FQx9qQ7M7xLEUHJ4WM9YN
	MYpqTuxRoYB1ojaT8q30WrHiCg6WeYi2ZQg==
X-ME-Sender: <xms:TMj3aLg31CHmOiwj7XsSmn4dMvaGeC2qQbQUP57vUvECyesovloSog>
    <xme:TMj3aHEEdI2ye2G8tEXTEArDwCiZHhztv2p5SfmmoXtjscazpshBxWUlBirC3lP3E
    NjoC1NIp1BT8xnYcLx6nZmieFPMf6hrxJgems8YdbXWCXS2ArButw>
X-ME-Received: <xmr:TMj3aBQoHCB7q74vpDi_DQYSAMeCF_e0gipwhSo4QCWsF7rAxqCfrAkfujETN745YKslklcNLdtiN0milqj81MSf4zYUWhVAyJa8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedufeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefujghffffkfgggtges
    thdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsth
    gvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepvdevieeftdeifedvgeej
    vdfhleetvdejgeegteeggeetvdfhgeekheetfffgfeejnecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghdpfihorhguphhrvghsshdrtghomhdplhgrshhtqdhmohguihhfihgvugdr
    tgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TMj3aEwmWLfK4DtYsi3vQ8dmCbE88iAOEXsucfJ7wjDsPSbbpllAaA>
    <xmx:TMj3aNckP6Hzx7ejf7jdGWvmWij_VpE1QAsOkB2bmxV9dTRDYXoSPA>
    <xmx:TMj3aHPX56umk9Wc-ZKg78aaN3Rgl0S6R0Ha7Efyi2pbKSR5WSfKAw>
    <xmx:TMj3aIteD1jy0HzKC7MeYtQC6W7o5y612tpz7QK7C9ywK32qLlldbg>
    <xmx:Tcj3aJCJ7oet99UnW1uhNnzbdUtjvLILJl3NwkPTMGrgyO2IJzCqsoGC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 13:52:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] last-modified: implement faster algorithm
In-Reply-To: <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
	(Toon Claes's message of "Tue, 21 Oct 2025 14:56:19 +0200")
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
	<20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
Date: Tue, 21 Oct 2025 10:52:11 -0700
Message-ID: <xmqqy0p4uoqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> +static size_t path_idx(struct last_modified *lm, char *path)
> +{
> +	struct last_modified_entry *ent;
> +	ent = hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
> +					  struct last_modified_entry, hashent);
> +
> +	return ent ? ent->diff_idx : -1;
> +}

size_t is unsigned and cannot reutrn -1 sanely, unless the caller
knows that ((size_t)-1) signals an error.  The compiler warns, and
we compile with -Werror, so we end up getting

    builtin/last-modified.c: In function 'path_idx':
    builtin/last-modified.c:235:38: error: operand of '?:' changes signedness from 'int' to 'size_t' {aka 'long unsigned int'} due to unsignedness of other operand [-Werror=sign-compare]
      235 |         return ent ? ent->diff_idx : -1;
          |                                      ^~

> +static void pass_to_parent(struct last_modified *lm,
> +			   struct bitmap *c,
> +			   struct bitmap *p,
> +			   size_t pos)
> +{
> +	bitmap_unset(c, pos);
> +	bitmap_set(p, pos);
> +}

Mark lm as UNUSED, or we'd get 

    builtin/last-modified.c: In function 'pass_to_parent':
    builtin/last-modified.c:238:50: error: unused parameter 'lm' [-Werror=unused-parameter]
      238 | static void pass_to_parent(struct last_modified *lm,
          |                            ~~~~~~~~~~~~~~~~~~~~~~^~

> @@ -220,42 +273,195 @@ static bool maybe_changed_path(struct last_modified *lm, struct commit *origin)
>  	return false;
>  }
>  
> +static void process_parent(struct last_modified *lm,
> +			   struct prio_queue *queue,
> +			   struct commit *c, struct bitmap *active_c,
> +			   struct commit *parent, int parent_i)
> +{
> +	size_t i;
> +...
> +	for (i = 0; i < diff_queued_diff.nr; i++) {

Our -Wsign-compare forces the compiler to give a stupid warning
here, that i is unsigned and diff_queued_diff.nr is signed.  

    builtin/last-modified.c: In function 'process_parent':
    builtin/last-modified.c:304:23: error: comparison of integer expressions of different signedness: 'size_t' {aka 'long unsigned int'} and 'int' [-Werror=sign-compare]
      304 |         for (i = 0; i < diff_queued_diff.nr; i++) {
          |                       ^

Yes, it is comparing unsigned with signed but so what?

As people may now know, my preference is to wean ourselves off of
this dogmatic trust in -Wsign-compare but those who disagree and want
to remove #define DISABLE_SIGN_COMPARE_WARNINGS should help our poor
compiler here by telling it that this comparison is perfectly fine.

We know diff_queued_diff.nr is an int, and i is size_t, but we also
know diff_queued_diff.nr won't be negative (or we have much bigger
problems) and cannot be larger than what size_t can represent.

> +		struct diff_filepair *fp = diff_queued_diff.queue[i];
> +		size_t k = path_idx(lm, fp->two->path);
> +		if (0 <= k && bitmap_get(active_c, k))
> +			bitmap_set(lm->scratch, k);
> +	}

Earlier path_idx() wanted to signal an error by returning negative,
but the type is size_t that is unsigned so it cannot do so.  We
instead get

    builtin/last-modified.c:307:23: error: comparison of unsigned expression in '>= 0' is always true [-Werror=type-limits]
      307 |                 if (0 <= k && bitmap_get(active_c, k))
          |                       ^~

and in this case we actually deserve it (in the sense that this is
not the fault of dogmatic trust in -Wsign-compare; this is caused by
using size_t to count things).

And the solution for this is *not* "size_t" -> "ssize_t", because
ssize_t is not "store half the range of size_t with negative values
reserved for something else like errors".  Its width can be much
narrower (this came up in a separate thread very recently [*]).
Instead we'd need something ugly like

	if (k != (size_t)-1 && bitmap_get(active_c, k))

A quick band-aid patch to make it compile is attached at the end,
but it does not try to address the root causes, which are abuse of
size_t as count_t and religious use of "-Wsign-compare" [*].


[Reference]

* https://lore.kernel.org/git/9eafee4d-ea94-4382-ada0-58000d229d2e@gmail.com/
* https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/


 builtin/last-modified.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git c/builtin/last-modified.c w/builtin/last-modified.c
index e9050485a9..6135bcc584 100644
--- c/builtin/last-modified.c
+++ w/builtin/last-modified.c
@@ -232,10 +232,10 @@ static size_t path_idx(struct last_modified *lm, char *path)
 	ent = hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
 					  struct last_modified_entry, hashent);
 
-	return ent ? ent->diff_idx : -1;
+	return ent ? ent->diff_idx : (size_t)-1;
 }
 
-static void pass_to_parent(struct last_modified *lm,
+static void pass_to_parent(struct last_modified *lm UNUSED,
 			   struct bitmap *c,
 			   struct bitmap *p,
 			   size_t pos)
@@ -278,7 +278,6 @@ static void process_parent(struct last_modified *lm,
 			   struct commit *c, struct bitmap *active_c,
 			   struct commit *parent, int parent_i)
 {
-	size_t i;
 	struct bitmap *active_p;
 
 	repo_parse_commit(lm->rev.repo, parent);
@@ -301,13 +300,13 @@ static void process_parent(struct last_modified *lm,
 	 * First, collect all paths that are *not* TREESAME in 'scratch'.
 	 * Then, pass paths that *are* TREESAME and active to the parent.
 	 */
-	for (i = 0; i < diff_queued_diff.nr; i++) {
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *fp = diff_queued_diff.queue[i];
 		size_t k = path_idx(lm, fp->two->path);
-		if (0 <= k && bitmap_get(active_c, k))
+		if (k != (size_t)-1 && bitmap_get(active_c, k))
 			bitmap_set(lm->scratch, k);
 	}
-	for (i = 0; i < lm->all_paths_nr; i++) {
+	for (size_t i = 0; i < lm->all_paths_nr; i++) {
 		if (bitmap_get(active_c, i) && !bitmap_get(lm->scratch, i))
 			pass_to_parent(lm, active_c, active_p, i);
 	}

