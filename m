Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98832D47FF
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693508; cv=none; b=QQzL1Mn2aZz/K858vv/ZDZvUvHTG4yW4n69meUO9+Iyb3Cr4+hkLhzEWw7vxUqioMNhqN/54kPE5kq3cKMIKvjYeaxL7Z8od1YAVc+GyQrgm4/8KAJj1TMJCSOUhP+SluW8sUOmF6GlV39mY9m/dVOXGMkMCb6jDyHpoxrDXcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693508; c=relaxed/simple;
	bh=fjwYCFMjpipBtSawLDtmOhELfWrvFPgWeAPRjjX2gOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dtXqTfspI8npJjrglKxLpaOAU1bFfopJuar7WzmqivvfnpsJ9yLMs8u2c2OX4yeE48VuyG6gOYCTgEZqTkFrZ7LnDx+GsjIDrzbCIoZrvXHmA6/vaOJk/q0sDjenLa7wXwIG9Jp13GxaCJfpGa9rQrZcjUijDRwcLd/3qmEbmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uGNLstTN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFDvbU9F; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uGNLstTN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFDvbU9F"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D778114000E3;
	Tue, 25 Aug 2026 17:31:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 25 Aug 2026 17:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787693505; x=1787779905; bh=nXeHum6kA+
	Sp/lM5RcpOgri6vjoyKGO3l4IRIaRBbiM=; b=uGNLstTNRZpkbIh/2K6HzuSDyA
	dFLkwm9769vjgC3mELEAK1lponyR1MwxZzMRr3f2BdrLebK9VW80Tx+YMD8dz79X
	jYfGpKyWnPh/Oxf6gpqnJkVzEG3hsOT5VKmo9My3Hnuyw1jYJJfoOfuTheNijY9r
	NXmWwob2wpRZUbph8ZegmXsCz7YRBNradOA91dbdGhZJfy3DHPc1iskxlD/t0kNA
	DouBZqCiPKkHpUXKxBgbMIh1IBHCyyb9DBcHD358mhu05CW3tSCOMEhWmEVT4Gjd
	uAGX1w3J9GvsDKWduAkBhLYOvTvn64//I9iou+LUcwfoCKeXINzT5rtCUerg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787693505; x=1787779905; bh=nXeHum6kA+Sp/lM5RcpOgri6vjoyKGO3l4I
	RIaRBbiM=; b=iFDvbU9F1BlNjakpIyxvCen65UI14dn0xZcEc8GOGK047fL9OFW
	SelivChOftwvwd7t/n2OLHdso3y0GJgMRAzPmZHVFPtErwDoEOyAS9fhtwpEkjiq
	5cFsz2T614cB+yRcE1d3akZdJRulLOflKCi4zpd8nOdrdfGWJw3lgaaEnpamgdUJ
	GpBdHwuTKSLnKFxraOLLK87nELhl/6OGKum3dUlGRyxiBH/VSfEPpLNduYzexcSX
	9PJhm1BaJ1vaMtlQbKYsQ3k+gYn65dF2EUj29OqJYlmZ+lymZETPXf3RQZVtnKxM
	p+H/W1QdxuZN1MlvCjnROe1cUcTsD9Wnthg==
X-ME-Sender: <xms:wQmOahaQuJt2erlydAOMh-h_Sma6222DqklKE7prk27OZwGI7HPRBg>
    <xme:wQmOasFewv7pIcrZ2xmO5b_DqDyh8j0jnSTCNSt0FKZIOViIwbD-peg2G5Wpy-zAR
    hDsMl4nolivdCGgMaZscZ-VRvdp3EnJXrjGJgqj6CrXRbw4boinxQ>
X-ME-Received: <xmr:wQmOatwYkxpDvZ5H2XCRdcx-Xl73Ha1fw5P6EHRJMHAMfNd_yfWeFXCf1MzXN4Rfm6lAwqZWZo4y2twgNhD-NEZDSrvMgeYVnA>
X-ME-Proxy-Cause: dmFkZTFSo5p5V3RO/V0xfct2EWPNL2Ce2aPlgNAtIYgM35N1CcYQZcbDH5C2hQa6xuh9qD
    RuJjzBU4VConqlYMolHQTtMAeTy1LgZbC8RU1KB/O8NsoD6IIbqOWR75mBoLzKcjrwci72
    Cq7GIqZ/VB+fJAmPI4AwjRiNZN/zshm1kjacLgKkiKH0ueAKj7LeVahoZIiFgGhoRxsQKJ
    /MD+D4Q0r4wCs7zVdPvzoe1y10/D1B8T2Ez1YC0IkKvJkGQ+YtyKTeZJtNNrV0isnXSfR1
    /6noXfL99sGPmsXBBfa4Z1KXiJMiz2UAONERkv83BaDvwLQb4us9JqxmQmkZu57d6ztyce
    xgGE+3fNoEvMxbzU/SuCd0jexNqGPt/TfMQtW4rvsq/uB4mizOJb+5aOv7mu9dMhGe8WOK
    fLtvktVOvcQ35s+QIzb/YmRhxMZHJ14d32q9rhVsdydI5VgkVZltfvValjWniiHpKaqYCN
    AhJJi85oBZBHMD+9nqj70WRuu6HdD/r+Oh3cUI9HJzRbZ5NJElFA5aIeo08acjoywleC75
    nrPvNPDqi+Qjsaik4oe+Ni7BVaBzoJJQ5K8rmWaZ2y7anh0mDHlJR2F2Q5vRsHKdSbrMNG
    Hu0+gAaZl/c4II/QIY0XMATZKegIc0QnkEIbd0Xb5t9SozQPr6+k4JtFXUAg
X-ME-Proxy: <xmx:wQmOammttA8F-kYFTG_vWTF0P35-yol4-CksjfKovNPjSCtXyojRyQ>
    <xmx:wQmOaun6-1TTB0moGNOhHuCTJ6Jbvx3jyL5jQuQ_zdAkPTGvmjv_dg>
    <xmx:wQmOagxKs36K1GHmUj5W7r3ffnbaIY2MdxASQLU5IIc7jceRcpP-hw>
    <xmx:wQmOarrF9b_XwywCQhx0fnojjMw6E4kxhPQG6-9rQdaoK9VSAvRWEg>
    <xmx:wQmOak_865-PPdddzZW0V7IR591OQ9XJ6_5UHJ3dvJbFpYmJJkbOD_wM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 17:31:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  Yoichi Nakayama <yoichi.nakayama@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v8 4/4] worktree add: treat multiple matches with
 --guess-remote as an error
In-Reply-To: <927856e0a07cf6d9e7e1093a4fbf979584141224.1787691875.git.gitgitgadget@gmail.com>
	(Yoichi NAKAYAMA via GitGitGadget's message of "Tue, 25 Aug 2026
	21:04:35 +0000")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v8.git.1787691875.gitgitgadget@gmail.com>
	<927856e0a07cf6d9e7e1093a4fbf979584141224.1787691875.git.gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 14:31:43 -0700
Message-ID: <xmqqcxv5lwe8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void advise_disambiguating_remotes(const char *path, const char *branch,
> +					  const struct string_list *matched_remote_names)
> +{
> +	struct string_list_item *item;
> +
> +	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
> +	for_each_string_list_item(item, matched_remote_names) {
> +		advise(_("  %s"), item->string);
> +	}
> +	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
> +		 "<remote>, you can do so by:\n"
> +		 "\n"
> +		 "    git worktree add -b %s %s <remote>/%s\n"
> +		 "\n"
> +		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
> +		 "consider setting checkout.defaultRemote=origin in your config."),
> +	       branch, path, branch);
> +}

Wasn't this function added in this series somewhere earlier in the
topic?  If we add it high enough when we did so, we wouldn't have to
move it higher like this patch does.

> +static char *dwim_branch(const struct add_opts *opts, const char *path, char **new_branch)
>  {
>  	int n;
>  	int branch_exists;
> @@ -782,31 +801,26 @@ static char *dwim_branch(const char *path, char **new_branch)
>  	*new_branch = branchname;
>  	if (guess_remote) {
>  		struct object_id oid;
> -		char *remote = unique_tracking_name(*new_branch, &oid, NULL, NULL);
> +		char *remote;
> +		int num_matches = 0;
> +		struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
> +
> +		remote = unique_tracking_name(*new_branch, &oid, &num_matches,
> +					      &matched_remote_names);
> +		if (!remote && num_matches > 1) {
> +			if (!opts->quiet &&
> +			    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
> +				advise_disambiguating_remotes(path, *new_branch,
> +							      &matched_remote_names);
> +			die(_("'%s' matched multiple (%d) remote tracking branches"),
> +			    *new_branch, num_matches);
> +		}
> +		string_list_clear(&matched_remote_names, 0);
>  		return remote;
>  	}
>  	return NULL;
>  }

Looking good.

Thanks.

