Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211C637F33F
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413208; cv=none; b=hxiWh4A3EX7FFlCS8fPB4y7aTFFAFrK/x7lxna/6MjVgzeBy4VJ+Zrb4Cdy3TFyPjeY4QUmCnZs1MBZ9YcR+tfAAJhn8zGa04jHHLHktoKzwDppOAeJRuzpD4IiscAXXk68qeaTsq7h43PCRiy0I3yLnnXeoE2v+vv90Vc/KUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413208; c=relaxed/simple;
	bh=/W0vlcQN1Cd+cGk8GYIVMQZTB5j9Y4KnIP3UCKGkIo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8vpGcgaLqsR/O8XsHfqiK1E4FmvZy7mojU9k4Ftt9aqW86buLVHCVezS+e579LYieQfUdkLZm0o31Y0chi0GjiJijCHgX5Toqf2W8dsld44VMMAawAE5tmeHMn2Jkxw7dzzGJdTeuzEhx9NxNcOwP/mRI7oxP09n5xBwgsmCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cIJWzIln; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ru+r2NEN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cIJWzIln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ru+r2NEN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EF097A0015;
	Thu,  3 Sep 2026 01:26:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 01:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788413204; x=1788499604; bh=zwX1aMvIoy
	JEfQGEwrOc/a+e4fUAP4n3NiZwKmdOGzQ=; b=cIJWzIln1BD6LBBLlcKOpJH1e7
	UBYIcXYREcqW7FDqreqTWecEKZZgyXNTxIkPODrgojgXUyeGt2gTj/bvLTrbJZDi
	astDhBrrgHRbZVuVBWpo5fAIzFxa8fnqZo6wSoSghmcJUMxkXbeBO8pnlZgRWCn4
	KKPyFzkQjlRLxNm5VuFQ9H3SZj6JG3/Ow3/aOdv7pbBwiMq7XMkYNU8GzNfNU9+C
	4g+A2NR9eM34pkNIN32UyyP5gCTfe8v3f7tEfUplwUVSNeGqyXUYi4XKDeZE+k7D
	phXRrkvyv8wFHtClcpuxX3XL2/Hg6APGBctongqixVyMeDk1DkEnr8glZdIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788413204; x=1788499604; bh=zwX1aMvIoyJEfQGEwrOc/a+e4fUAP4n3NiZ
	wKmdOGzQ=; b=Ru+r2NEN4rxKjHpSE3MazdWIHPjvt8D+qaflCpW8wqUqnMNWbgh
	ES13bUbHqr8krlS1Zm30S8qz4ezQIGLLNilma6fwocd+nHp19Lt5bFKSaYBiLXiG
	4Kv8dXJnJ0ar11g4PJSGXnaU9EAH+cpJAatvjqL2WqdljZp+R8wM6w1dd8gKZGBf
	nXDrpWKEdRgeSHDkRxNiPOPOsG/q6t0P16mmzW0Kw3jrsvK3g6rKsKAfprImlKHl
	x7TvmhsFVuu+7rI0qj7WBBOUPM6IoXQSmvMGQRzl31aAexZGsg/3+SMuLR00otCT
	G7nVGHpsUtivC2SkYXCHK0ffkX+BaiZNmzw==
X-ME-Sender: <xms:EQWZaoZwFar1fLhf9agxGNiChMpPGRGixZX6IbfTQE4DnI81luTWtg>
    <xme:EQWZau2aV-zPhxFfOe9aFfXB-ZuKft9sK6RbxipiAm06cWm8O5_7IXY49z4xVH1XU
    6-Jv9hWpxuyfNu4kof9ai8ABAz9LviZ_9O-sBVEEqweL2Gfk5g9fA>
X-ME-Received: <xmr:EQWZamf45DZ9K87VpDbxUpinLjREoTgoyfPMCcAjibeevzyJJAl-ew>
X-ME-Proxy-Cause: dmFkZTE5LjnXGgjGIM7K5YQO6gqih08EU76MH7udHYHPIXiM2WFHcuqIKGzSrDK3YoVS4K
    KkHYDkFo+uTojQNk6RwDsMAj9H1NA3EmUPUjI5MEY5MZHCszKi+uxQsMrYZO2wGTXybQNd
    2qu9KBVY+l/RDYyxWm04VZigiILoNiBo8ziEAbr+J02tfsiBa5skVXQn9Y4GpduPaSCm+z
    B6KCEbRyOJT3iACwuqvF81UddMPlHR6I8sOaDEWwFkgLBuPoGuPcP+bHRmsMhgZh01MuCO
    PyveHv7xRkKNqPBKzVlg8ai49PT6vIpVTRf9ciztHs25nsn60rwa3s2G4dc67+2aMUMmTY
    KzoRsOEDv58VqOKZ8B98sVw44dwrQxdObZ8fI4tmTTWDY6OUXY+FZQ37Cs/HsjoqPFQdoL
    9QKAQcNvhc8XciugIGu5OkWn/h207I4NvaP+zwP6nnKJBvDT0AJFdEfFmWa7Fon2ummmHd
    HMCbxpYWKZ16spDbjN54RhzkSNO1xCoR4nP5lsyjPDraOcO+IfywtYkZkuM1BmKr2ru3QN
    kLFXxNvBxO98+1LJUt+VPQYnAtHQyhww7+iWqA1Quz7OWzZlVzIlcH4lQhh5k04gcvkDew
    Bg1bpDVQGwEONJzDr4/ewRymLjdi53Efxe5QfY7wjNtc98MrBp0gRsEHWhUQ
X-ME-Proxy: <xmx:EQWZanE0y4Jusdi6pmDUGg969ty2ybla77q0QwbkNAMO-8-KGhN4Og>
    <xmx:EQWZav1s4TqvBB9eXTOqELD2Y5iJhRZrHqzUAX4db2bbodWL3MDNBg>
    <xmx:EQWZavnfw_5kkUIuGhRtWe03QqfdoBq1YVcvWqsw4fd7Xnmu5s1CTQ>
    <xmx:EQWZav_PQRHWyndStteU2NmWptQoR7hef4Joj8mX3oEKr4mgZfhmgg>
    <xmx:FAWZapnZDggDNH7tixw2PWcO8_LsXHIta0vBa1mbYothvit6onCxbcqu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 01:26:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a4bd82a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 05:26:43 +0000 (UTC)
Date: Thu, 3 Sep 2026 07:26:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: zkd18cjb@mail.ustc.edu.cn
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com
Subject: Re: [PATCH] history: do not dereference NULL when parent tree is
 missing
Message-ID: <apkFBluOhc3SyKV1@pks.im>
References: <5438d465.ab31e.1a062047bd5.Coremail.zkd18cjb@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5438d465.ab31e.1a062047bd5.Coremail.zkd18cjb@mail.ustc.edu.cn>

On Wed, Sep 02, 2026 at 08:07:36PM +0800, zkd18cjb@mail.ustc.edu.cn wrote:
> write_ondisk_index() dereferences the return value of
> repo_parse_tree_indirect() unconditionally.  If the parent commit's
> tree object is missing from the object store (corrupt repository,
> object removed by tooling, or incomplete restore), the function
> returns NULL and "git history split" crashes with a SIGSEGV
> (release build; UBSan reports a null-pointer member access at
> builtin/history.c:789).

Nit: the information in the braces does not really add a lot of signal,
I'd just drop it.

> Guard the parse result and error out gracefully, following the
> codebase convention for objects that cannot be loaded.
> 
> Signed-off-by: Jinbao Chen <zkd18cjb@mail.ustc.edu.cn>

Nit: your From address does not match the Signed-off-by.

[snip]
> Reproduction (verified on master @ f78ce2f7b6, x86-64 Linux):
> 
>     git init r && cd r
>     git config user.email t@t && git config user.name t
>     echo a > f && git add f && git commit -qm one
>     echo b > f && git commit -qam two
>     tree=$(git rev-parse 'HEAD^^{tree}')
>     rm .git/objects/$(echo "$tree" | cut -c1-2)/$(echo "$tree" | cut -c3-)
>     GIT_EDITOR=true git history split HEAD

We could of course add a test for this, but I don't really think that
it's worth it.

> diff --git a/builtin/history.c b/builtin/history.c
> index 000155ad9c..097631f5ba 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -786,6 +786,10 @@ static int write_ondisk_index(struct repository *repo,
>  	opts.dst_index = &index;
>  
>  	tree = repo_parse_tree_indirect(repo, oid);
> +	if (!tree) {
> +		ret = error(_("unable to parse tree %s"), oid_to_hex(oid));
> +		goto out;
> +	}

Yup, the fix looks obviously good to me, thanks!

Patrick
