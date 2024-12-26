Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA818E1F
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735248797; cv=none; b=LqtZwLBb2eCrFzgDN3lq1tsNrWFrTBpvkYtBMA8L8emo3rLJNTFCLy18fCdJghcGvMKgtXDhAOQO5Mj8l5WQMpE0Mq32wEZH40mXPXBVWlNq7Qd4n/j0kRj3OQF6pIjJi4Fw9X85TaYQCbWzN63+ymWSAjS73Q1TugEeueInuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735248797; c=relaxed/simple;
	bh=jauGxFn8DV7xnHtIMiYcQqk3P0ykgywkXbDQZ0qZ5Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lowTsPTb3kqaTofGkzC8zslBp9n4yP2qqK4IafVJPru9yKdK+Fc1u2C7PVhRuut72i3H1cV7ydAiCKNIqtlE7hJMtXqUA0os0MyZ9WXDnp+8ENQhydpPPFUJQGKGxfo7TSVu6217HuZVMzf/6lOGmDXezlmLwB/B8rzsdww4oF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zUQDmnat; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q/5Y8z/x; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zUQDmnat";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q/5Y8z/x"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CF4F114012C;
	Thu, 26 Dec 2024 16:33:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 26 Dec 2024 16:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735248794;
	 x=1735335194; bh=iwSxeVE4vuhrYnuoGPznDfQN6baPTtX/vcSlJ0HBs3A=; b=
	zUQDmnatW8QAfxw9bLj/Al523s8HvK+e4+hL4zEbxFiCgzc9iOizCvKO0QpZ7eJ1
	cMdJ5495lAGEnAiC6XsaG5xUHhZIBut2R8Dm6VAl44u+vwiLrGardEA+eKlIcO6M
	/Vu6SR6A/mhLevKbCuu4A/q/Pqyn4wJhCMmVB7ePIQonSdLNHPQg5M/y3N98WKyk
	UVQFgQ+ghQ+Kp/Rr/7i5+0I0i/7ggxEwZf1r3BdNwHZZEhkvseuYERojySDI37U5
	TM/YFpn30BXSw1SFgZZpQMWifgYotfEuC+FTVRsatVJUbJ4MZUf5C35at1BOwhvn
	6TbIJ7qfrwSD5hp9QAvtOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248794; x=
	1735335194; bh=iwSxeVE4vuhrYnuoGPznDfQN6baPTtX/vcSlJ0HBs3A=; b=q
	/5Y8z/xQ7LZGvL4s62Qf4aCnVKLIGu8gi8KkoIoSXLG1JTO5pT1FIysWeSPatO8T
	5uJzR+7RpCvkjw4xCksYu9JWsGuQC+6lKbxKKgfBeRWsWxjakLm5CLYuDJOquu94
	kaItN/6TQRq7CiciWHuW3xjjIRHpdQ9Kuay96mksJ1/37ZKsEgOYSVvkhGMfcXWp
	KJK+Q6iQJdGWiJKlADhTb9SmMx3OQe6f9OWzbUf8x/17ddM1eWAEXCzm4edj0Xyj
	6iEJYH2VTvsOAA7Cw3mQ3J2/nvIAcnrb8+RBAr/6sn60J20UfqAmzX2mHHkTqCb0
	AkB22ZmyFib4u2ASWGvqQ==
X-ME-Sender: <xms:mcttZ9YKHmzgpksxh_QGMzHmDQcGpyZMMG5XkgPpLcBij6XmxTcs5A>
    <xme:mcttZ0b9xN_IQ8lg-NMYaJFaJMeIv7TF7QEdScvHkfCaDksXfPcFVjxfDRMpdhzIo
    kHI7-Egbub_QvDUpA>
X-ME-Received: <xmr:mcttZ_8SVWpOEfLpmhm794arLBhj300iPJg2xzTd94VYr-oQ2sPooBKeNyVdTUQOBOo545mXrfOrnRThE0Hy3DlGftB0BYEcMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsohgvkhhklhgvsehfrhgvvghnvghtrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:mcttZ7qcQZ-F0oRegj9OOPjBnbQwWki1hcQBEGyNOGLP32dydABoTg>
    <xmx:mcttZ4qbesUtGw3xmyzdXyXPMf_JZrkVimxo_YWLXGXuM3jL_x314A>
    <xmx:mcttZxTSEM1ARJ_SNHmaJ5on31cGbp1ZRMWg_KpJLIGhxVUa72VAjg>
    <xmx:mcttZwr89OECEma0ECsygS70py8-tIkUN3ErQ-z4Ml7PQfwLT_omeA>
    <xmx:msttZzXmMZDdzOGRXxyflQBMJ4gXfarhLRFYR_rgjRGhfn6pvuMkaCAU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:33:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] add-patch: Fix type missmatch rom msvc
In-Reply-To: <20241223110407.3308-2-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Mon, 23 Dec 2024 12:04:04 +0100")
References: <20241223110407.3308-1-soekkle@freenet.de>
	<20241223110407.3308-2-soekkle@freenet.de>
Date: Thu, 26 Dec 2024 13:33:12 -0800
Message-ID: <xmqq34iaxh7r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sören Krecker <soekkle@freenet.de> writes:

> Fix some compiler warings from msvw in add-patch.c for value truncation
> form 64 bit to 32 bit integers.Change unsigned long to size_t for
> correct variable size on linux and windows
>
> Signed-off-by: Sören Krecker <soekkle@freenet.de>
> ---
>  add-patch.c | 44 +++++++++++++++++++++++++-------------------
>  gettext.h   |  2 +-
>  2 files changed, 26 insertions(+), 20 deletions(-)



>  struct hunk_header {
> -	unsigned long old_offset, old_count, new_offset, new_count;
> +	size_t old_offset, old_count, new_offset, new_count;

These are not "size"s in the traditional sense of what size_t is
(i.e. the number of bytes in a region of memory), but are more or
less proportional to that in that they count in number of lines.

If ulong is sufficient to count number of lines in an incoming
patch, then turning size_t may be excessive---are we sure that we
are not unnecessarily using wider-than-necessary size_t in some
places to hold these values for which ulong is sufficient, causing
compilers to emit unnecessary warning?

IOW, if we have variables of unsigned integer of various sizes, we
_could_ rewrite all of them to use uintmax_t and there won't be
truncation-upon-assignment warnings from a compiler, but such a
rewrite can be pointless.  We'd need to find where we stuff these
values, which are originally ulong, to size_t, and see if the use of
size_t is really sensible.

> @@ -321,7 +321,7 @@ static void setup_child_process(struct add_p_state *s,
>  }
>  
>  static int parse_range(const char **p,
> -		       unsigned long *offset, unsigned long *count)
> +		       size_t *offset, size_t *count)
>  {
>  	char *pend;
>  
> @@ -672,8 +672,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>  		 */
>  		const char *p;
>  		size_t len;
> -		unsigned long old_offset = header->old_offset;
> -		unsigned long new_offset = header->new_offset;
> +		size_t old_offset = header->old_offset;
> +		size_t new_offset = header->new_offset;
>  
>  		if (!colored) {
>  			p = s->plain.buf + header->extra_start;
> @@ -699,12 +699,14 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>  		else
>  			new_offset += delta;
>  
> -		strbuf_addf(out, "@@ -%lu", old_offset);
> +		strbuf_addf(out, "@@ -%" PRIuMAX, (uintmax_t)old_offset);
>  		if (header->old_count != 1)
> -			strbuf_addf(out, ",%lu", header->old_count);
> -		strbuf_addf(out, " +%lu", new_offset);
> +			strbuf_addf(out, ",%" PRIuMAX,
> +				    (uintmax_t)header->old_count);
> +		strbuf_addf(out, " +%" PRIuMAX, (uintmax_t)new_offset);
>  		if (header->new_count != 1)
> -			strbuf_addf(out, ",%lu", header->new_count);
> +			strbuf_addf(out, ",%" PRIuMAX,
> +				    (uintmax_t)header->new_count);
>  		strbuf_addstr(out, " @@");
>  
>  		if (len)

So far if we left the types of *_offset and count all ulong, I do
not see anything that causes trunation-upon-assignment.

> @@ -1065,11 +1067,13 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>  
>  	/* last hunk simply gets the rest */
>  	if (header->old_offset != remaining.old_offset)
> -		BUG("miscounted old_offset: %lu != %lu",
> -		    header->old_offset, remaining.old_offset);
> +		BUG("miscounted old_offset: %"PRIuMAX" != %"PRIuMAX,
> +		    (uintmax_t)header->old_offset,
> +		    (uintmax_t)remaining.old_offset);
>  	if (header->new_offset != remaining.new_offset)
> -		BUG("miscounted new_offset: %lu != %lu",
> -		    header->new_offset, remaining.new_offset);
> +		BUG("miscounted new_offset: %"PRIuMAX" != %"PRIuMAX,
> +		    (uintmax_t)header->new_offset,
> +		    (uintmax_t)remaining.new_offset);
>  	header->old_count = remaining.old_count;
>  	header->new_count = remaining.new_count;
>  	hunk->end = end;

This hunk unfortunately may be needed because this function somehow
decided to use size_t for things like "hunk_index" and "end" when it
was added, even though the surrounding functions it interacts with
all used ulong.

> @@ -1353,9 +1357,10 @@ static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
>  	struct strbuf *plain = &s->plain;
>  	size_t len = out->len, i;
>  
> -	strbuf_addf(out, " -%lu,%lu +%lu,%lu ",
> -		    header->old_offset, header->old_count,
> -		    header->new_offset, header->new_count);
> +	strbuf_addf(out,
> +		    " -%"PRIuMAX",%"PRIuMAX" +%"PRIuMAX",%"PRIuMAX" ",
> +		    (uintmax_t)header->old_offset, (uintmax_t)header->old_count,
> +		    (uintmax_t)header->new_offset, (uintmax_t)header->new_count);
>  	if (out->len - len < SUMMARY_HEADER_WIDTH)
>  		strbuf_addchars(out, ' ',
>  				SUMMARY_HEADER_WIDTH + len - out->len);

Again, if we left the types of *_offset and count all ulong, I do
not see anything that causes trunation-upon-assignment.

> @@ -1624,10 +1629,11 @@ static int patch_update_file(struct add_p_state *s,
>  			else if (0 < response && response <= file_diff->hunk_nr)
>  				hunk_index = response - 1;
>  			else
> -				err(s, Q_("Sorry, only %d hunk available.",
> -					  "Sorry, only %d hunks available.",
> -					  file_diff->hunk_nr),
> -				    (int)file_diff->hunk_nr);
> +				err(s,
> +				    Q_("Sorry, only %"PRIuMAX" hunk available.",
> +				       "Sorry, only %"PRIuMAX" hunks available.",
> +				       (uintmax_t)file_diff->hunk_nr),
> +				    (uintmax_t)file_diff->hunk_nr);

Again, this hunk may be needed, as the "hunk_nr" uses size_t, which
probably is overly wide.

So, I do not mind too much to adjust the code around hunk_nr,
hunk_alloc and other things that are already size_t (but before
doing so, we probably should see if it makes more sense to use ulong
for these members instead of size_t), hbut I am not sure if it is a
sensible move to change old_offset, count, etc. that count in number
of lines and use ulong (not bytes) to use size_t instead.

size_t _might_ be wider than some other forms of unsigned integers,
but it is not necessarily the widest, so "because on msvc ulong is
merely 32-bit and I want wider integer like everybody else!" is not
a good excuse for such a change (if it were, we'd all coding with
nothing but uintmax_t).

So I dunno.

> diff --git a/gettext.h b/gettext.h
> index 484cafa562..d36f5a7ade 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -53,7 +53,7 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
>  }
>  
>  static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
> -const char *Q_(const char *msgid, const char *plu, unsigned long n)
> +const char *Q_(const char *msgid, const char *plu, size_t n)
>  {
>  	if (!git_gettext_enabled)
>  		return n == 1 ? msgid : plu;
