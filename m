Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975EC10F1
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675293; cv=none; b=iJ+luyd7VbcKHLkH6UIO67s085tgtcHQjOlkaQrzRG9cAY8gjYfUxNhLFpXThtF6dHsc4PmlESt8ET3kmGp5QdfoqIfOuKWQwG2isSPMykkWbQcSSYdVfleTBscqnOyTzz+Rjw6xC2qQjJvxOkBxVtB31BehnDHB5lZUfNFpBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675293; c=relaxed/simple;
	bh=XbVXXGqkIQV0COvUIrJexG4sM9SOj7pB+aJ5ThXBn58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IJ+pGbX1KbSm7D53ObGfX+tF82n9wmRms2e6RGz3koy9dhxJmr3GpW/gnzYz7iFUa3Jzgyy5B6hT4c0prWREyF2OKUEtWzTWjGQYYx0PTPwvYXwPJN3WB54HRR4tNZaKisfRvi218Gnyp/imWgP0Aj4KbHCwCczc09WzZ8TSeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ixLyH3hD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PszbQ4/I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ixLyH3hD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PszbQ4/I"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D0E91D000D7;
	Fri,  8 Aug 2025 13:48:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 08 Aug 2025 13:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754675289; x=1754761689; bh=Po8OSxK00z
	ZlmBtABb8RyrKeSzn0ZLuuXG/g94rP+fI=; b=ixLyH3hDL7KRib0jTbGRoiie6d
	cbbqxIypqQBb6RKZ6zvGCexkDKENlI/H3HDp9gv1xbLvFmTG6vJOXAEnN0yAKwJ2
	K9ucYKTU5/nu9PkfDiiRk8eZd6zEtEU2Ih79FzSPJLoBK1nrMEUAHUTYfTcYw3yk
	JHDUkdkWyyBLAWTRXrdTTBRXvgWg0ZxPPOOjrnK0ft7jFceqI2wPD4cxy7Pf/Ngm
	2mKsSW9yiRey9Mr95YQnk+fPj+oAyQP0TkvFKrJffjc54Jg90LFBvJPWY7vw9C1i
	iHuXhMWyPq8MgO7E36bmRUY9OCf5LSmyzW4OFSV1muKadaimZJvsCvikhPrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754675289; x=1754761689; bh=Po8OSxK00zZlmBtABb8RyrKeSzn0ZLuuXG/
	g94rP+fI=; b=PszbQ4/IqQoLHdr6C8FOBysie7PXYuYzOveL1hK8NXkjrzjXVMG
	LZOVtlS+ZFsg0vQYfeHJ8YANOJXsgBLIhLRF2zChpsBwNw3/wF/ZRXOBQINneFdS
	HaByMUWoBg4zD7bpiCVXrf0mtsl7hTGp6Po05Z+t5+uj1Xdy9UpvXx28LgkUZ+ts
	vk+O/Pj3PbtKVIDqnBEs1K4QvTI97XG8IsLBZLDagxp1obGMZpuBt7YODY0LVTnE
	Z9p3bzKjW5202ErSMPRq6uCFThBKbRyHmsdGdkGgLnmqYmYsHX1ywyVUPq0m89Br
	OWSB4jNjnz7TMJLxjoxbtIE/z9RFYPpx1Iw==
X-ME-Sender: <xms:WTiWaNxMO-a_eFuP7mQNlV6_zWxMopcl6zDdcY44g2rBoSSonfr8Cw>
    <xme:WTiWaH1vB19dDBnFxTgRPIzgR6d0MEy9ZxLyuXxxBklBpigM9nV2yfv17yoI0I32L
    ysvOlUm3y1HZtv7UQ>
X-ME-Received: <xmr:WTiWaD7UsCrI4j4E9YLBGpp_-_mjrkuc1AH3hrzDgC5Ob73aJbhWOReQWMAND2lvCycgH2JgKmMDj1A0GmicMyFbkS0ZXWRrDJ_l-a0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:WTiWaCVIYyZVdJqg5o6qMnnwbSKpER6xdO55VfKtBhpFj0knjIvekQ>
    <xmx:WTiWaKBDyXFCtiazIKURIBGnu7Lc-3OOdEeXxe0PMjhAo2DMeD9OTA>
    <xmx:WTiWaJ6e3uTvJGe_79gJ0bq8AWP3DwGmRleS39SRZXuurporlv5c4A>
    <xmx:WTiWaNxjIM4lYyQRLDh1XZEpjZQR-sjOC-0sM6Kr412dmGBMqueVfg>
    <xmx:WTiWaIh7vlvMz86H9ViKIdT8qqhkPcpZ5Yvl8Ph6fnjbjKAgzi4Cn5a6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 13:48:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 2/5] doc: git rebase: dedup merge conflict discussion
In-Reply-To: <f4f0a5a1172b283d5254ce06ef08795286bb725c.1754666665.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 08 Aug 2025 15:24:22
	+0000")
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<f4f0a5a1172b283d5254ce06ef08795286bb725c.1754666665.git.gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 10:48:07 -0700
Message-ID: <xmqqikixhfhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +If there is a merge conflict during this process, `git rebase` will stop at the
> +first problematic commit and leave conflict markers. If this happens, you can:

By using the numbered enumeration below, we may mislead the readers
that these are the things they have to do in this order, when we
actually are giving them choices.

	If this happens, you can do one of these things:

would be an easy workaround.

> +1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
> +   and make edits to resolve the conflict. For each file you edit, you need to
> +   tell Git that the conflict has been resolved. Typically this would be
> +   done with
> +
> +   git add <filename>
> +
> +   You can then continue the rebasing process with
> +
> +   git rebase --continue

The original (below) does not do a perfect job, but I am afraid that
this increases the chance of misunderstanding by new readers that
they'd run "continue" after marking each confclited fines as "done"
with "git add", by reducing a sentence to a mere "then" in "You can
then continue".

	Typically after resolving all the conflicts in a single
	file, you would tell Git that you are done with this file:

	git add <filename>

	And after dealing with all the conflicted files and telling
	Git that you are done, you would continue the rebasing
	process with

	git rebase --continue

or something?

> +2. Stop the `git rebase` and return your branch to its original state with
> +
> +   git rebase --abort
> +
> +3. Skip the commit that caused the merge conflict with
> +
> +   git rebase --skip

The explanation in the above looks good, and the new organization is
much easier to follow and is definite improvement compared to the
original.

I am not sure how the above how the above formats, though,
especially on a medium that is not monospaced text (e.g., html
rendition, not "git help -m rebase" on terminals).  The prose should
typeset just like the normal text (i.e. your "Transplant a series of
commits" in the previous step that starts the description section),
but the command that the users would type should be typeset in
monospace typewriter.  Have you tried?

Thanks.
