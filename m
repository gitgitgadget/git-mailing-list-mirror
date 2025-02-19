Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18451AC88B
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988718; cv=none; b=fswvbbBF+dUJKz7bdwkF0ftkrF3VrHdr4Kz3QsnZvLaUmWpUSegnkvYaSX2TT2kzuX+VzY6rkTkub+AYdY6WBNkxGUa8L6wirbR5soIW2tvIIPoMDMF1sytcE4ZqPs1/g94OVSzlRGabl2bV475DnKWsIGwJTpxhJcv8o0wSb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988718; c=relaxed/simple;
	bh=burvChsECQDh9H+w/zG2VSbirWoJliia/f4mdIFNaBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ArAKz99U+qI4Zl2/GRiIaf7ICz9r4gMkDJJL5JJyKwi3SOWZzWtdN/NJS8p/RH2IYdbyNAeDjcHLMMz/vb0hbHhL3t4KpEieumb82cVO0U3WOX9cPQOEBCR3ienCNveJLqRHUNhlexvcOt6kpMrlJXz3EKFTv5J2k5OfRtBU24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hr8xd/bY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vdbT7l1T; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hr8xd/bY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vdbT7l1T"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id D51E1138095E;
	Wed, 19 Feb 2025 13:11:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 19 Feb 2025 13:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739988714; x=1740075114; bh=4bqEhr6LSk
	l2aO5CA3H5vPjLyoPpO9cwVycA3FKq/ws=; b=Hr8xd/bYx4UJnuHfW/a8SOdHH8
	b5OwFa1oQHhvZvH7dRWFjKxhVfKGv3aONYlSzD64bJWV/riTujn4l+n5jTvRPeuV
	tEBtfpCEemWuQ+ddL4cwQOMv6I/reuBQsgAio+xWaTNe5AWEvauOnLz1KO44999V
	VrzvClfAb975DXgu6YchbN4mXyvlGOo2xWk68duDH21HVyfjoSaSKKJqnV0DWAk4
	iLwa/zc02iFwwZLh0is+TnBO+29XEnxIUtXaVIMaCWb4+deZajqlDJ8jIqbaXEB0
	eVVPDOvY1NugadDq0PeY61/zWzf0ACAuSodG+GR+HlTTyRE9+eFCcbLiXmyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739988714; x=1740075114; bh=4bqEhr6LSkl2aO5CA3H5vPjLyoPpO9cwVyc
	A3FKq/ws=; b=vdbT7l1Tkk+udM39WJwkhHI/THiOImp2AaD/pJ6KL/1YLZKpeSn
	0d3JXs7n1sSeS2dgPCir3XQXuumUjyiKG9RjGm5/kGmOMZE9ETWx2tqMlvATEyxm
	Lil4bUohlhkdmU1+Yr73L9atsfw+C+OTSMWnW5UiC+445fGbx7gS3kpZvjczrwKZ
	5Zlqy3ezelnMD3CYLMC+q6oecxCDn4OtRqjNjqtXiNf5Vul1OBnnh6gDnGfsLSk/
	C7reMlOxFo2wD4qFUJjE2ACj2ahG38FjJZvjSha8tzWwMHvWNL6kL0kATxlVLSLO
	q8+oyJt8NWPBxiNdj3CyxG6lABBXINhiEQw==
X-ME-Sender: <xms:6h62ZxFSeJiSAYpcN94XnNmKZSyD3XnhmBF-GCu56IzuUhJyeMMKog>
    <xme:6h62Z2VTmLJVNsroyXtJmHE4_RQvffQkpp4yC1s-eh05JORh5xhOfLu2c1WgxKZjf
    SMfshD1TpN84Ov5Lw>
X-ME-Received: <xmr:6h62ZzKYRFSwv2m_6PpWgJH4PiwTJp1Ixk-1yTXrouQHbWar2Wl322J2z25SbQuaVbrYdteEmoocn_CKRRuXvvzv5XgriYQkWmGziH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgriihuhhhirhhordhkrghtoheshhhothhmrghilh
    drtghordhjphdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6h62Z3El7XAxn-ScuyrovH2FZmAPHwE3RNIX52x7D7A27wGmScD2kA>
    <xmx:6h62Z3U7DOMyXdtUVP6MajCdQ79_IKJhFsw2PfYkMKnaTy7jQ0-NBA>
    <xmx:6h62ZyMLY3CH8eYotJOPE3Wl57Dy2KKZzMTXwvSG5JgA6qEYTxfRdg>
    <xmx:6h62Z23BDuea949CG5OK1ViXpvelYnGW17arzIjR897aB28gCD8zaA>
    <xmx:6h62Z9wwvO8m8ObXEG_qdaC-J3y9Rg8OlWXca6iXW-pSKJXXtai9E_Lh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 13:11:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kazuhiro Kato via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>
Subject: Re: [PATCH 2/2] fix: when resolving merge conflicts, japanese file
 names become garbled.
In-Reply-To: <c698805f088e0643e5faf027d4eaa6de14d6c1ff.1739918546.git.gitgitgadget@gmail.com>
	(Kazuhiro Kato via GitGitGadget's message of "Tue, 18 Feb 2025
	22:42:26 +0000")
References: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com>
	<c698805f088e0643e5faf027d4eaa6de14d6c1ff.1739918546.git.gitgitgadget@gmail.com>
Date: Wed, 19 Feb 2025 10:11:53 -0800
Message-ID: <xmqqh64pg5xy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kazuhiro Kato via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>

Here is a place to give a bit more context.  In what way the current
code is wrong, what end-user visible symptoms are brought due to
that wrongness, what is the correct way to implement it, etc.

> Signed-off-by: Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>
> ---
>  gitk-git/gitk | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 88951ed2384..f4f8dbd5fad 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -8205,12 +8205,13 @@ proc parseblobdiffline {ids line} {
>  
>          if {$type eq "--cc"} {
>              # start of a new file in a merge diff
> -            set fname [string range $line 10 end]
> +            set fname_raw [string range $line 10 end]
> +            set fname [encoding convertfrom $fname_raw]

Is this "the Tcl read from git things as sequence of bytes, not
characters, so somebody needs to pass the bytes to "encoding"
function to turn them into a sequence of characters?  Unless
everything is US-ASCII, that is.

If that is the case, presumably the $line has a sequence of bytes,
so it may be wrong to chop it at 10th position (presumably that's
10th byte, not 10th character) when we are trying to teach the code
to deal with non-ASCII data, no?  

I am reasonably sure that [string length "diff --git"] is where 10
comes from, and that prefix will always be in ASCII, but it feels
safer and kosher if we converted the whole line first and then
chopped off the prefix.

The patch title says Japanese, but I would imagine this applies to
anything non-ASCII, so it would be better to retitle the patch to
say "non-ASCII" instead to signal that the issue the patch fixes
applies more widely.

Thanks.
