Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E651212B02
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736528113; cv=none; b=RAXZRWPeMWeTukAS1UHnUzhNthdUoPbflmjCTvQsCe4I0GMH8PRX/3YsnQfr+mtWxG8AgMfN3HyHK4sElXy1SyAx4EiBeqSqWW3/Xgzhx/T1A0QhGrPTZcTpfQSa+1OKPG8PFZvB+deu+rVprHAZ680YyVjQXVvaD//rlVS5enc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736528113; c=relaxed/simple;
	bh=wgX3JRDIeqMMsVopWY5dy3QnGSfVORBqOldu/OO+HFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QKWfWcBbvJShQF6EB8aCZiJU146LEFGZKy8rj98/TDsCTDDK3qSDnlrsA4O2kpwJQY0U3VMGfshxhB+VOV2glvGB5bydMSITZMF+cm4vmlGDuV5vkjzamM3U5ulEQux3rze7GXeuRdvYM6kUG4puyA8A5IGH9xUWjM1T6/5aYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ecJug61A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GsYjmCPX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ecJug61A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GsYjmCPX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 523EB25401BE;
	Fri, 10 Jan 2025 11:55:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 10 Jan 2025 11:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736528110; x=1736614510; bh=EmYex/Rygp
	NBU+6Ww7D4d4H2SlYmdswXvqaDLPGUG0g=; b=ecJug61AUK9HlyNWSvyYFT4YDd
	AaSuIUQLC/e7Qn3vT8AzVenICiDJq2IDOkTzDlVNW0OElYjWInEwZXUtyrXhv8Xu
	m6SJ8tY4nL9TC3LogteisvpPM/RImXd/EN16lKSBsY1MXYzCY57A+zcgBRHeLeHQ
	zxvTUgEc/b+iml+Hr+X3OO2qIMBI/3kAImE8txvyNbL9V54CGevdvG7fcs+hKiLW
	tH/8IGvReOf1GrvHAd3968YqGA/HJhAqfXf9sTa9mk9BGKSw5REHurTmIXTyJdST
	sPw1Ychl/uli5dOHdbkBgPE/x6+wbnu3v4l+QJKysQMst930bfb7Gqk6nQ/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736528110; x=1736614510; bh=EmYex/RygpNBU+6Ww7D4d4H2SlYmdswXvqa
	DLPGUG0g=; b=GsYjmCPXpN5VElyiUfki9/dI91KFwzRi/daq8hvD99O0KNE4CHN
	Ar8rkfEZYowEMEfuvAEz/e9v81X7Bzd8WyM+Pu+G+mz1L9h+VOZd8Wxw/Kxd8+oK
	yq5ITQjbXtlF7Wblv+mnvrWLeAhj4v8FulAt8jZVY8koZGtGBMnUriwmhMMh9Ejl
	zCinGWXvvjnHDE8Q0FG19dz/ns4Hb0t32UbYDTTxeU6CLWfM3oqhDgXFJgFiTklx
	7f9FQpKfCv6Q8adeFAHRY36iGogNuvjNnFqnINsWM5N2db9TZHNprQ0mo0BvBKwM
	vlxTI6aPLhVt3aVsd3LZ4ExRjwS34S2quNQ==
X-ME-Sender: <xms:7VCBZx6mMqPb38ai4vwi15SHVtT2SBtnIAfNrFV-V_cE6YAhOt8usQ>
    <xme:7VCBZ-7KbW1l-YWP8RyEP2klaKGnTBd0EWD9jJq8h0Aa4OPwLXowXmteBs6p1pCpx
    W5KU2QDlDCfRnQ53w>
X-ME-Received: <xmr:7VCBZ4eT2aoaX6e2xtSdjlnS1ST1M1qWfxvSwfF3dTbkBpph2WfbhQkBwWtxEnZR-VLxUpp_5xZZ_0iXFza8CFLnKfNYc_UMfNYi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgrrhhtih
    hnrdgrghhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:7VCBZ6KGhpDIZKfStFhGqCpsCPxSdmG_tacrt4h7U27sZM5RC_OckQ>
    <xmx:7VCBZ1Kj2DuwyNzdXiK7CGetLCiptnKU0HMiOOQ3TRR79dZU36Kpaw>
    <xmx:7VCBZzzSd0oA7JVkR8AnyEYJDg9Md1FjQEHQGbMSoilALxeyhsXZNQ>
    <xmx:7VCBZxL906W-S6pwoAzpE-4mfXT4R3fCnocTwOwRMBFfzhSTHq-ekg>
    <xmx:7lCBZ9_OLQaB_zcE1n3SRHaFhBU1SkftuHOs1rN5H76OQEbndT9FqICe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 11:55:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Martin
 =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] GIT-VERSION-GEN: allow it to be run in parallel
In-Reply-To: <pull.1850.v2.git.1736509717426.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 10 Jan 2025 11:48:37
	+0000")
References: <pull.1850.git.1736432663587.gitgitgadget@gmail.com>
	<pull.1850.v2.git.1736509717426.gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 08:55:08 -0800
Message-ID: <xmqqldvi8v83.fsf@gitster.g>
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

>      * Appended + again, to get the benefit of the .gitignore pattern that
>        prevents the temporary files from being committed.

I had queued an incremental fix-up in my tree on top, which may have
been easier to read, but you did the testing on a system that showed
the problem earlier, so I'll drop it (together with the v1) and
replace them with this one.

Thanks.


--- >8 ---
Subject: [PATCH] Make sure the name of the temporary file ends with "+"

To avoid regression by leaving untracked cruft that is not covered
by the .gitignore file, match the convention to generate into
$name$suffix and then move to $name where $suffix ends with "+",
which is used everywhere else in the system.

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 5b49e2d72f..bc11258d9b 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -78,6 +78,8 @@ read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trail
 $(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
 EOF
 
+OUTPUT_TMP="$OUTPUT.$$+"
+
 sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
@@ -86,11 +88,11 @@ sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
 	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
 	-e "s|@GIT_DATE@|$GIT_DATE|" \
-	"$INPUT" >"$OUTPUT".$$
+	"$INPUT" >"$OUTPUT_TMP"
 
-if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$ "$OUTPUT" >/dev/null
+if ! test -f "$OUTPUT" || ! cmp "$OUTPUT_TMP" "$OUTPUT" >/dev/null
 then
-	mv "$OUTPUT".$$ "$OUTPUT"
+	mv "$OUTPUT_TMP" "$OUTPUT"
 else
-	rm "$OUTPUT".$$
+	rm "$OUTPUT_TMP"
 fi

--- 8< ---

>  GIT-VERSION-GEN | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 6d1cb66d69a..2e2d0811581 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -86,11 +86,11 @@ sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
>  	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
>  	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
>  	-e "s|@GIT_DATE@|$GIT_DATE|" \
> -	"$INPUT" >"$OUTPUT"+
> +	"$INPUT" >"$OUTPUT".$$+
>  
> -if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null
> +if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$+ "$OUTPUT" >/dev/null
>  then
> -	mv "$OUTPUT"+ "$OUTPUT"
> +	mv "$OUTPUT".$$+ "$OUTPUT"
>  else
> -	rm "$OUTPUT"+
> +	rm "$OUTPUT".$$+
>  fi
>
> base-commit: a60673e9252b08d4eca90543b3729f4798b9aafd
