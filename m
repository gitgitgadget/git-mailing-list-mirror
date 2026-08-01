Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B53368D52
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611750; cv=none; b=VfqrIp92Hlxm4M7cQggaWwIEXk050GUcbPtvxWmlSK6abCEEt4kDw5hMeJ9YHDZyYkcAzVIPvWQv3iiLem/n8soKo4Ju4yOt95NtJlbMXve1/oNLDATJHx70zCK3LF1G1NgEPzEaQC1+NkxgK8rp7sdTEZYHcIG1awl9Bl/bURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611750; c=relaxed/simple;
	bh=YXK5psGgBPROZsxQQ9axc5Hw3tHC+AoesWqQ9G+Sxbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T3QEjqrj+j9shHOjeRzSAWp2SXcay8uRWWXExenhJym5LRbJbbRqgAj1b7tH1sm6TmhmM0JKB44ZDYBXz/5hY3G3Gg1aPE8D1HSoQW8MqTHy5lEjclj7wW+bmARvFZF8VOpF6VJidjCg0bmtbuRUGAleqNjTm329lyQJ2IUp5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fk0lESgH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBJlxsY4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fk0lESgH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBJlxsY4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 904F91400143;
	Sat,  1 Aug 2026 15:15:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 01 Aug 2026 15:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785611747; x=1785698147; bh=ZkXpeDceWn
	1UN+gu0WGh+n9w8o+afbh5Z8JUv9+86qU=; b=Fk0lESgHJQQ60xcEiyvZ4gaQp2
	UTH2L6xIpLkZ9BnA2X00vTEZlUXl29vGoTPQcx2lxYfDi9j+vhazHkue3Ay/m+NY
	XkcF6aJ/pDuazpDTVjAoTizDWbKLEywBk5aJiGFbretTO2HZkFA9aksrBeSWvRch
	RCj9Ic3HMhdQaGdHdmboft9/geOIYbTjUikhAftz3oTf+gjRLoGgdPCXNbZhhekN
	V59apgDEswhgFcn76ntMJwLY5VPqxeL9NXw0uMh9/8gNztrXM12ePpapnzarGCfp
	skim99EOeZ8PTy4kZsSFpT12ngSIKzhUQxzhZF4oFlwj0kPT9o68ZrKI7dzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785611747; x=1785698147; bh=ZkXpeDceWn1UN+gu0WGh+n9w8o+afbh5Z8J
	Uv9+86qU=; b=aBJlxsY4CK12IWuzoVV/nGB3T2NHyLG7Z29jSiEAAtZyaDonGL2
	OhLu83otAjbkYenMUv8RuauSEXz+U/1D7TfWVXNTsxw9PI+B9dtLvjubs/JLO76l
	J2H6ncOxcpV6XVZjNHNPVdIfq22xzAYwo2xhhQaz3wAwhwy/A9bnfWZGbY5mRBDd
	Iuo3w6qQYYcPU1ilInKD2dxG8v+lJR13pMTZs6Oe8qwZJ6DlE/ZtQlGgmRhxKgXA
	1JtsgW5FiJ7SFc/yBrLDUY3GHlrAAPCLifewlIIfsrECstPB1y5u3abH5BiKBvLd
	rwPu5wZkZkBW+VssWBEJ4DtuilocOd/nVgQ==
X-ME-Sender: <xms:40VuaoA0rM_acfs1Yyoq1yPm-RXq7xFnQ902rerisDKBMD3SIicXrw>
    <xme:40VuahZBqqTnKOs_jwM4msK7xmrkvst4vsgsnOoFPZl9BHppBHEGu8DJWL5CGqci6
    WFwQ1CPHl68SyDcE69klDiarIwF8RY47A5HyDHyvGZQjdAB2gAX>
X-ME-Received: <xmr:40Vuaj4NUsr33dpviujGTZkK4UfSBkEKQx6d_UuVtkXy-r9U1qEQkyDpGO7vCMvZqeVHjmz1REI7mYpKCLxRbaDYGQfwfYUcDg>
X-ME-Proxy-Cause: dmFkZTE+T4bG6F7ks+vM3ZwtEkjjvDRiNaepWh8QGjERccjOtBShoGhhzMEFrLCDMAxxQ5
    dkKhTjTvpM+xwBGMz12yo53ocuSXWAYfRStpxr//7LZ0n9qYrLUkkUo5cNQBgufTwaKnMg
    cXe65Okc5KQ34zUfw0iZPzBZh5SQzvga+2nFI8RprPtUi71tzwZL0IgKh2JsQjKfCEiQ2A
    dJLuXIV7keiMVWPCcR1JDEQSWd8IIUCGPbnTHneaSix09K6irN+dZkJxDBLxM+4rjBKHhS
    O1HMUVwjewn1LplzcyWp3spnWCNdSCSeNYStcV5INOw2vDqi8njYAYdxXpguNgcqCpCqJ+
    qptpfYfuUkINOpzywOQiseGdT0peHth3rtKfkZ59GiJ3E9yB8jCf03LYlQM+kgn28OF2Qy
    N77/SEW5NCCP2aiFEI3R+P5uHTfqGMcKwLR61vKC66Zb8QBH1hGDiS+FaxrvLgiNi7r9Pm
    r/Ew3de363SJvQxAXyuZop6zHI/HpLskm5cgLI5XA2604gM+J7/xb9OgVv2/0XgCblsOCo
    xPGcIYjj/mDqLHZ/4A8TyKqD6ngUblaQoWDqU2vqf0yuO0hMDDTRGa3c8ZQBJ0IdfFZlWW
    5E8VZevMcToX9Yy2a8uoPgO8WIM78eg3pNKZi8CMT8vxQqj5npuqgCr+KsiQ
X-ME-Proxy: <xmx:40VuaqaBnltRYXoKEKW5wnwfrODVbUb9v6b2glIMOlyi3qfxCKNK6A>
    <xmx:40VuaqgUFhk-2lR4ozjPYdnzMArrR3j-eDltytKBglEFfmHZ9VOFqA>
    <xmx:40Vuaj8V0kOTrhGt8OVrH4AUmqtow3f7lge7L0dnrNLlewTj6XHrTw>
    <xmx:40Vuatrt1i2QYE8yaGbY60ZCjXwnskrkR2cBULy1ccyppDTnyar-Lg>
    <xmx:40Vuaor7S9y_1enV_7Tajv5qX2ZYVdBryICVErgM3p1U1gMThSn9Ez2g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 15:15:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 1/2] bisect: let bisect_reset() optionally check out
 quietly
In-Reply-To: <e39670edf4be8bc917a985666f200a88880212ce.1785577445.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sat, 01 Aug 2026
	09:44:04 +0000")
References: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
	<pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
	<e39670edf4be8bc917a985666f200a88880212ce.1785577445.git.gitgitgadget@gmail.com>
Date: Sat, 01 Aug 2026 12:15:45 -0700
Message-ID: <xmqqa4r58xem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add a "quiet" parameter to bisect_reset() that passes "--quiet" to the
> checkout restoring the original HEAD, suppressing its progress and
> branch-status output.
>
> No caller sets the flag yet, so behavior is unchanged.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/bisect.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 3264e2da54..1e0c043249 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -234,7 +234,7 @@ static int write_terms(const char *bad, const char *good)
>  	return res;
>  }
>  
> -static int bisect_reset(const char *commit)
> +static int bisect_reset(const char *commit, int quiet)

Not a huge deal but given that you are adding "bool defer_reset" in
the next step, it may be more consistent to add this also as a bool?

> @@ -255,8 +255,10 @@ static int bisect_reset(const char *commit)
>  		struct child_process cmd = CHILD_PROCESS_INIT;
>  
>  		cmd.git_cmd = 1;
> -		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees",
> -				branch.buf, "--", NULL);
> +		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees", NULL);
> +		if (quiet)
> +			strvec_push(&cmd.args, "--quiet");
> +		strvec_pushl(&cmd.args, branch.buf, "--", NULL);
>  		if (run_command(&cmd)) {
>  			error(_("could not check out original"
>  				" HEAD '%s'. Try 'git bisect"
> @@ -1096,7 +1098,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
>  	if (is_empty_or_missing_file(filename))
>  		return error(_("cannot read file '%s' for replaying"), filename);
>  
> -	if (bisect_reset(NULL))
> +	if (bisect_reset(NULL, 0))
>  		return BISECT_FAILED;
>  
>  	fp = fopen(filename, "r");
> @@ -1345,7 +1347,7 @@ static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNU
>  	if (argc > 1)
>  		return error(_("'%s' requires either no argument or a commit"),
>  			     "git bisect reset");
> -	return bisect_reset(argc ? argv[0] : NULL);
> +	return bisect_reset(argc ? argv[0] : NULL, 0);
>  }
>  
>  static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
