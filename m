Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46F134AB
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739559414; cv=none; b=GBnGFqHKZPl5f8CyF7Uw8sm/bRzPesDc375Xp+9OKCUjYOZwRVvyhU/GuvbBEjb7Il4/wMq+00hSk4p6OEmotaRNQc/t+xH1OXgy+xEZWCVoU97IHJMZ8KhLwkYHTEuNGtEEr8g35EZ7KdgRacFQdiedglJodUPPWXAjLrWZ36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739559414; c=relaxed/simple;
	bh=5Uh/qmu1+WxEEd0KDraVNWkl0DuMSLbTxfEZ5eEaHeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AXcJapVkWgv5ogq1rgeYDuc0G/fqjTxjwe/RMiLubXDKF5aCDQifWnr76Vrt2I1NC4B5ig4fyeCPA8qoTRAe8r695/WEl0K/zEk305K8j4udvZD66sWCuTocNM/ZidV68AI1Ik+G7Q1tvRD/pDW1WEeANqMIjtEKcA6iUBVU1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=he4mZJSP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SPRD5Gfy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="he4mZJSP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SPRD5Gfy"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E1CF13808B7;
	Fri, 14 Feb 2025 13:56:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-13.internal (MEProxy); Fri, 14 Feb 2025 13:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739559411; x=1739645811; bh=Scovc73kUx
	2oSYcNYDq2vlBJYw59mtWL+G7Zgtdj63M=; b=he4mZJSP1Mfl2u7hkrIe/PSTNJ
	gFZcukOtFpfyLL0/f+dzAvV6SjI2VXfYMGzYp5dJArgQWjMVZCRdMkBCkIWoJKr5
	k1QqQMRl7dbLKYqu8QOjHOnK2Zx2fQuV1phF+k7rumfTo7kKbZRkElwugID6B8MJ
	C/QmgYW6Vc6PRRm3U4ADH6m5E/o3RmEm0Q74yTjsG1ES7SvxLORSoIsKCW8QZrmH
	m2Wo9PzbLhZWdrRY2eS91k+xDTYAE/mSKbb4eMC+f9QZ4XPmK4KAxsNpjKqaZn+Q
	TCvtCQHPsJedi8qhkeeoKhCELBiJeGK5U7WliLHBVvNDWM5tU+2t2cB34Nvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739559411; x=1739645811; bh=Scovc73kUx2oSYcNYDq2vlBJYw59mtWL+G7
	Zgtdj63M=; b=SPRD5GfybejF4XBTgG3wAkTkMGr8dA93vu0wylovruRB7YFB4xp
	HIKD7P/r3m1ittBUSblykuN8c5I+8pB54gUoiG2RhxehCWspv1qwyjTk9PtpR/UQ
	562dHdw9Wpxmkh53u7x8NGVOFPMOuUHTM0zFpHOZyWbcnuI3qJlPxszPRof3ybw1
	V4gcnC3tj5gNUpe1i9pmk6Dk5u+Kr8SjOPxVuXtalAQ0P1OOJed0W15Jvb6nZA9y
	2gMCaDVxPYsC7z7qMBAvxQVMRhfktJ5QXISOvibGPxs/F1reKA7hgSA6hkC96cn3
	ck3qSVedUk7AHUeDktgbZziM4E/oFGA8t0A==
X-ME-Sender: <xms:85GvZ7md4w_5WdjHy2HiuIMfmR9mdAolu5qdd8Pb4jXl9wg8pzf_zA>
    <xme:85GvZ-15IGBsBGZMbun1EW2sdmM2ieZXXrXyX4cqRtRdbJJXxYj6K-uXf2ajBhfSE
    L1AtKYnKONG-Pa07g>
X-ME-Received: <xmr:85GvZxowO_85JZl3cNGzulT8ErPlCYNdjSsAbSU7gMIl83JO_Ya4WAb00UTqv4kCGq5HxHXe6xkbDuAMUziayb4__wkmpJPBHtv9v3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:85GvZzlDRgImH_LXTW7PrB-bI_q_thdK0zfrm78Z9AUN6_10Sd_coA>
    <xmx:85GvZ52ZH7tfG_iLFZpoIOV62cODUvXxWeqBiUEbVZp9xIXRtc_4AA>
    <xmx:85GvZysSGlQ7Zj8R0RfTY2pwh4_r4qeBC5fYvRcnGfw27x3Mu6Mi8w>
    <xmx:85GvZ9XvrbfJ0bnwNqEo9HgFi-QonmBv8qHD7GHiM503mqEKj-nSiQ>
    <xmx:85GvZyxyhEMpnWwQTOqX4brCliNYVpOxv1KCQIVZnXyOikGUqwO04NbO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 13:56:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][PATCH] refspec: clarify function naming and documentation
In-Reply-To: <20250214053938.26807-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Fri, 14 Feb 2025 11:09:38 +0530")
References: <20250214053938.26807-1-meetsoni3017@gmail.com>
Date: Fri, 14 Feb 2025 10:56:49 -0800
Message-ID: <xmqqldu8l5hq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Rename `match_name_with_pattern()` to `match_refname_with_pattern()` to
> better reflect its purpose and improve documentation comment clarity.
> The previous function name and parameter names were inconsistent, making
> it harder to understand their roles in refspec matching.
>
> - Rename parameters:
>   - `key` -> `src_pattern` (source globbing pattern)
>   - `name` -> `refname` (refname to check)
>   - `value` -> `dst_pattern` (destination mapping pattern)
>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
> This change was previously discussed in an earlier patch series [1], where
> Junio suggested making this update after the dust settled there.
>
> [1]: https://lore.kernel.org/git/xmqqa5bctbnx.fsf@gitster.g/

Yeah, and the dust settled a few days ago when the
ms/refspec-cleanup topic graduated to the 'master' branch.

Thanks for that work.

The tldr is that I like two things in the above rename, and find two
things problematic.  "name->refname" is very good, adding "pattern"
is very good.  using "src" and "dst" is problematic.

One thing to note is that match_refname_with_pattern() can also be
used to reverse map.

A refspec that says "refs/heads/*:refs/remotes/origin/*" can be used
to answer these two questions:

 * I see what they call "refs/heads/master", where should I store it?

 * I have "refs/remotes/origin/main", where did it come from?

The src/dst distinction you updated the parameters to the function
only reflects the first usage, and it is a bit confusing when the
code asks the other question.

    Find the "refname" in A and replace the same glob part in B when
    it finds a match

is what the function does, and we used to call A=key and B=value,
which were not great.  With "pattern" in their names, the new names
"src/dst_pattern" are improvement, but src/dst hints as if they are
directly related to src/dst sides of a refspec, which is the source
of possible confusion when we talk about the "please map from our
remote-tracking branch name to the branch name at the origin" use
case.

So, I very much have problems with the "(*source* globbing pattern)"
you state as the reasoning beind the new name in the proposed log
message and "src/dst" in these names.

What do other people who wrote tools that do something very similar
call these two things?  For example, "sed -e 's/A/B/'" command does
"find A and replace with B".  They call A=RE and B=replacement

Perhaps "key -> pattern" and "value -> replacement" would be a
better pair of names that are easier to understand?  I dunno.

> -int match_name_with_pattern(const char *key, const char *name,
> -				   const char *value, char **result)
> +int match_refname_with_pattern(const char *src_pattern, const char *refname,
> +				   const char *dst_pattern, char **result)
>  {

Thanks.
