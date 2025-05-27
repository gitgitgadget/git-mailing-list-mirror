Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4F19005E
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748356970; cv=none; b=AYGCL6+ISSh/YsXUaZjxgLz/zLTt+GMVAiQzcrFBm3W0cW6z33mhYsiadfesNxxkdLlsnl8KZGdwWndyQlgWcvaP5yAaISphxCRb8nFmdZu7uNM4YPK5hsQdpL7i9dlimpkx5mK/02Ym63EHCHK1yYCkkMFyiibHFQMzaCshiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748356970; c=relaxed/simple;
	bh=Vto2of1UTc1RSQZ3jloakBhUiX3XVuQd9qyvf2s8/X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rGiKGJyGJFsrEhnA8Fb+eyiMcgJrPRq7EtIsrLwREtliAwAGgQ1K4+2guUuykOKzBd4OrTiXU0fQ8F5x1dEx/kmGOPTjNWDvToTwbItNDDIXhNUGKPQrnOhgb6mJ9KxwbP5G+bRF6CyV+GjTu/wFdvqmsD89r/IYbGWqf714LuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DoPCxeqi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3wBqQ8d; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DoPCxeqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3wBqQ8d"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DF30111400B1;
	Tue, 27 May 2025 10:42:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 10:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748356966;
	 x=1748443366; bh=512uxRJiJWBaOla4auM8hcVBZvzJOWjkEnr0h7pcgsU=; b=
	DoPCxeqidkO28Bm2dC3kpDJ3w8E1P0nJZhJMyyn7Y+cwftqkIChAltPm/TrKWzxf
	Len1Qcd2c/zuNg7VmQDZVJoRpbAStfJadHL3f/BagpfW16El32QmI+5jqhXnqPfM
	FtHKI0ozfUuLord1LOYm7eFuu9NdhPajGWulwhoeYdyTEhjp32Q9rwY4H+t0Ny8x
	g516BlM/+owGvmjkV88HQD22TrGg6dac/XdowAaD9llgokpVHGIImDLog9GuWKGC
	f2vjxs/xs3n4N8ui2gICVCMIukqnMUUDtMpnLXdwufOA8DXumQ9EayCvx/BmbQi3
	84IT4VadNp4Ko/rmBpFcqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748356966; x=
	1748443366; bh=512uxRJiJWBaOla4auM8hcVBZvzJOWjkEnr0h7pcgsU=; b=S
	3wBqQ8dvZ+HMRxQtbZpCjCGyf/1mFeSjpuaqo70qxYOojQXLQdScFpbABQcieUpt
	ytnbEyhlDn2MVgUXF8xnV0/z1y1ZHgzn3E5pJVtlcQ+IMHAfGmzSF2ttbHIxUdWW
	w6V5YkXSp+d4L4hOwYH2smkwIZjmupkvWDguo6npNxy96aglovsmFrMp07+ktBxy
	e32KVMs3jub+Ax+qGdqrv00PpS6wjAFrvBgol++lKP8U6PckYfGwyEK2bVchxFL4
	2ycJuroUCzFAv78Nj4z77U8zYz++zX8jrXcgSWVAscgBevWCkxVQiEobAbURVzzd
	6mb4mXJg0tZLzU4RAngyA==
X-ME-Sender: <xms:Zs81aI2iz9r1e0E9SdTEm_uJXRQm3oua7KoYHgPEnN0PmgerAKdc_w>
    <xme:Zs81aDEAZR46a9zvqseUoTS3UXkZKY8f2d25gD9aMLwdJujJt5X8b9PmXtO2AKilV
    4kYmyqL7gmJxvum8g>
X-ME-Received: <xmr:Zs81aA5zuVF0KVKYE177SYQOPGMFjx4ohBtpKabXFPK5TNjbLAa2hITapkvPhkjwzh2PrxeIGandBhhg4Y_vnZtYN-OtG4O4x3oWWrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdeigeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouc
    eoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdet
    gedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Zs81aB39H-PjwTbFmfU1En1uC6cbD37oC0abNOHYfbe0euYddD3z1A>
    <xmx:Zs81aLGXBisYlvrSBGDgQvq_ywjuO3YSfD0jv0sDr8xMhNunY7fkJw>
    <xmx:Zs81aK84KhT5UabzUsVV_aDz1_5ayooFxY4FPWGat8p8A61XN_i5kg>
    <xmx:Zs81aAnu2PoxTIpeGznB2EciJPMWQ5brDqqppQcQmWRgVLCWQmz6ag>
    <xmx:Zs81aCwzj8uFvW7Y-pYM0B-E5IJNA-25NHMDXExeY9uFX65R9D_JiPAm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:42:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v7 2/2] submodule: skip redundant active entries when
 pattern covers path
In-Reply-To: <20250524073628.58944-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sat, 24 May 2025 13:06:28 +0530")
References: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
	<20250524073628.58944-3-jayatheerthkulkarni2005@gmail.com>
Date: Tue, 27 May 2025 07:42:44 -0700
Message-ID: <xmqqcyburu6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> configure_added_submodule always writes an explicit submodule.<name>.active
> entry, even when the new path is already matched by submodule.active
> patterns. This leads to unnecessary and cluttered configuration.

It might be less cluttered but is it a good thing?

Earlier, if submodule.active were b* (as documented in the "git help
submodules") and then you added submodule "baz", your "baz" would be
kept active even after you reconfigured submodule.active to another
pattern.  With this change, that is no longer true, which to existing
users is a change in behaviour, and to some it may appear a regression.

According to that documentation, presense of submodule.<name>.url is
also a signal that the submodule is activated.  If we are going to
omit setting .active because its path matches submodule.active,
shouldn't we also be checking if .url exists and omit setting
.active as well?

> Introduce a single helper to centralize wildmatch-based pattern lookup.
> In configure_added_submodule, wrap the active-entry write in a conditional
> that only fires when that helper reports no existing pattern covers the
> submodule’s path.

The new helper is a maintenance burden to keep in sync with
submodule.c:is_tree_submodule_active(); if we really want to go this
route, the patch should extract that "ah, submodule.active is set so
let's turn it into pathspec and see if the path matches" part of the
logic to make sure the logic is shared.  But I am wondering if we
can do this without any new helper.

> @@ -3370,17 +3390,7 @@ static void configure_added_submodule(struct add_data *add_data)
>  	 * is_submodule_active(), since that function needs to find
>  	 * out the value of "submodule.active" again anyway.
>  	 */
> -	if (!git_config_get("submodule.active")) {
> -		/*
> -		 * If the submodule being added isn't already covered by the
> -		 * current configured pathspec, set the submodule's active flag
> -		 */
> -		if (!is_submodule_active(the_repository, add_data->sm_path)) {
> -			key = xstrfmt("submodule.%s.active", add_data->sm_name);
> -			git_config_set_gently(key, "true");
> -			free(key);
> -		}
> -	} else {
> +	if (!submodule_active_matches_path(add_data->sm_path)) {

I.e.  Can we replace this if() condition with something like this?

	/*
	 * Explicitly set 'submodule.<name>.active' only if it is not
	 * 'active' due to other reasons.
	 */
	if (!is_submodule_active(the_repository, add_data->sm_path)) {

That is, we ask if the submodule is already active (we are before
adding submodule.<name>.active for this thing---if may be active due
to submodule.active or submodule.<name>.url) and enter the block
only when it is not yet.

That way, this codepath does not have to worry about the exact logic
that determines if a submodule is 'active' even when its .active
configuration variable is not set.

>  		key = xstrfmt("submodule.%s.active", add_data->sm_name);
>  		git_config_set_gently(key, "true");
>  		free(key);
