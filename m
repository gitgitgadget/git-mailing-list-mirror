Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0F3D903F
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685158; cv=none; b=JfhUseYdYqV1SVLUncBqq4ABXq4nLzDcKygj7jBYcMWRmuU81hBVy5IZ2BASemaMpE0zPl/oRg9tJY4p4UDVWXSDtEicCvVbUPgH8+rCoqr8xIcaKsbDlfAfwnRlVUoow3/Ll94IXdYdbzuXI3SzuUgz/PGqLOqcuKUs8AEuh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685158; c=relaxed/simple;
	bh=9d41aaF32fpyTuKBpXQTPZk0/5muSZEdEQfHJXWhJzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ggarr8ohgjHlSBFqJeKe6nMJH/I+LmReT60+AMbtY4jl4jvr6qY/oTn0tnohl6plDXoK9GldFzVYPmgnOdv9BwEjoF07lSLPWooGiJ7ILa+aOTmnEHI2kNGagSbaZh8CY/t/K8Ux1i4NDQPQVpaP1gMasBH5SWduu9uwuYTWzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=je82pbYK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RAWky7ox; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="je82pbYK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RAWky7ox"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 83E1E1D00152;
	Mon, 16 Mar 2026 14:19:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773685153; x=1773771553; bh=LvN7+X2q4q
	LqIwFaeUh0asbbroAJbhW3xTVra98c2U4=; b=je82pbYKnRfSd4tWAmX6xdVN+u
	5m8VLOR3PtYfp080dx4swzMoNCFyd+pz1a3VQH9ZLUOfcz35Gz9TEVoH/JW/39Ue
	/GN5+fGTJHH2LYytvcSNHYBHzwlyhxIGPJDAJZNq3RLdZxss/ez2bw2MZcO2gDtH
	b7EaLLBjAw/HWoP9FSdux3VkceS1m7jPNymvOwalw/QXCdhGla/4rbFM9f9/NUdS
	8QbkxsVmbyWpZ1cbxmJwfn/9gpdJhszdtgIQSjfEnMC20QXjoRcZmeeFSY6H+Xvk
	Ixh+0Hm1C7w+knwW0aG5p7zfi4510u4SZTD4Bt8cozk6ekLK6lrnUwvNNGPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773685153; x=1773771553; bh=LvN7+X2q4qLqIwFaeUh0asbbroAJbhW3xTV
	ra98c2U4=; b=RAWky7ox+j9xKBmpfgJQCa9A//6MscI/kQs3ZpVBYW/u6T3GZth
	p1qqZR2KRJQ4OnEBkNycyAsyOmD/MUZvaPegCS9uaMVgbCcGu6xmeRYMTO724FU+
	eLQXthpYdOtu+uLDAVNXDEQkugSm5JA3LklcUtQa9xuL/yfmCZbJW+CNNjLOOyDr
	3zUg8r73me9OV9PehFpmof1EVMdRuByFLh0IeHDwLVBghHVvrwP0nOIZeClFjy2j
	rJVUDo6fjixUv/DyaD8SsAQeS0Wj5nnk67el9MwelLRB4Du/WJFmYm/fn2fyEuO1
	Nv1qvjnmefTYHCWzkvEBfjti/4LL69Ht5Pg==
X-ME-Sender: <xms:oUm4ad_hb1mwAzAAq7GFHGvAEmvqNjJ587UfofTlOunNqWWOKdZGgw>
    <xme:oUm4aYtGVJjUC2ZRPpKuCevQ1PjRBeFznlx1BtO_fkkcI_WW-8pj3ujEvJBpXxomW
    ighZCxfgUuFBqK74axR549pJ2qYmwG6NqbM8ct-DxqJyKXSvNGe3g8>
X-ME-Received: <xmr:oUm4aQD5UJOMhXB2jev4w0s-JBPc0sCuMDnYQCaehwTq6M-f8aSwW6g6BwOb9tiHJmJHHdTmVTlnkGLIvCUomikLZ_oriHTbaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgvrhhrhiifrghnghdukeefseihrghhohhordgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oUm4aQUTUN7OGTlJdfhMwQLmlttOk9HYhw6IpdYSsyKZWKn8GyfYgA>
    <xmx:oUm4aeDMCyW5QVFsQsqXdEw1q3JbJmfPXBGidgGncrqO9gGEre0j5Q>
    <xmx:oUm4aT_JLc0nYLv9_hIi3V9kNR0URP2C7ZRtw4oucDBAj8-DHMz4sw>
    <xmx:oUm4aVFdTC9FPwjJ0mfIK72WnuVRHmBpn5MlSYViGwuv-fmgAjrDdw>
    <xmx:oUm4aRkaHd_Dzvgfc1t10TrgTK3iJGrNGW7rC3bw0-Xnw5a-bWY0rwWn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 14:19:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jialong Wang <jerrywang183@yahoo.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [GSoC PATCH v2] apply: report the location of corrupt patches
In-Reply-To: <20260316113459.77794-1-jerrywang183@yahoo.com> (Jialong Wang's
	message of "Mon, 16 Mar 2026 07:34:59 -0400")
References: <20260315231538.68586-1-jerrywang183@yahoo.com>
	<20260316113459.77794-1-jerrywang183@yahoo.com>
Date: Mon, 16 Mar 2026 11:19:11 -0700
Message-ID: <xmqqbjgnprhc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jialong Wang <jerrywang183@yahoo.com> writes:

> When parsing a corrupt patch, git apply reports only the line number.
> That does not tell the user which input the line number refers to.
>
> Include the patch input path in the error message, and reset the line
> number for each patch input so the reported location remains useful
> when multiple patch files are provided.
>
> Add tests for file input, standard input, and multiple patch inputs.
>
> Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
> ---
> Changes since v1:
> - reset the line number for each patch input
> - add a test for multiple patch inputs where one input is corrupted
>
>  apply.c               |  4 +++-
>  t/t4100-apply-stat.sh | 38 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index b6dd1066a0..b7b0a201b3 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1875,7 +1875,8 @@ static int parse_single_patch(struct apply_state *state,
>  		len = parse_fragment(state, line, size, patch, fragment);
>  		if (len <= 0) {
>  			free(fragment);
> -			return error(_("corrupt patch at line %d"), state->linenr);
> +			return error(_("corrupt patch at %s:%d"),
> +				     state->patch_input_file, state->linenr);
>  		}
>  		fragment->patch = line;
>  		fragment->size = len;
> @@ -4825,6 +4826,7 @@ static int apply_patch(struct apply_state *state,
>  	int flush_attributes = 0;
>  
>  	state->patch_input_file = filename;
> +	state->linenr = 1;
>  	if (read_patch_file(&buf, fd) < 0)
>  		return -128;
>  	offset = 0;

This change is expecially interesting; it shows that practically
nobody feeds more than one patch to a single invocation of the
command ("git am" certainly does not) that this has gone undetected
ever since it was written by Linus 46979f56 (git-apply: improve
error detection and messages, 2005-05-23) ;-)

And all the changes contained in this patch look correctly done.

Having said that, there are places in apply.c that still report
errors only the line number, which we may want to address with a
follow-up patch, or in an updated version of this patch.
find_header() is one, parse_git_diff_header() is another.  There
might be more.

Thanks, will queue.
