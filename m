Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF030EF88
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334017; cv=none; b=WKNwnTW4V3LSFHPyYkEq3VVT3MaWhRoNLdY+GqO1yVOxanfDOQAd4r8DLBd/PYvfJcnfmXtgVx1HLJvxlbFUieNv8fIpFpmSZCDenDhWJXbfW7MNkVCYq1J6knKexGvW9dsQebp+/WrnHua9/5ZpH7xbsWRJIx2203WYqbI458g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334017; c=relaxed/simple;
	bh=bJt7rAV+axgpNccbgX/gvbSkwrDr9OywLHPpAccFi3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qE0kMS5Hnp37d/ZbRdWWXQldt9/VgLZCUGpBZ0MiyXmYhgD6ii4Z0TSTLo3fp7XN9sn+0jTt58tXUC458WorO0ng0Jq2lCQjqDGRIdEzYNBxETpBSrkNlSGba1rt5EeomG/Bec32PRWoqOcaJCbajkwDjxvdgNTVDtQeilSPYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zk05T4ti; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BosYUXlb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zk05T4ti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BosYUXlb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75BDF140003B;
	Tue, 13 Jan 2026 14:53:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 13 Jan 2026 14:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768334015; x=1768420415; bh=X0m5kgP1sJ
	Gx1qW0bgdYjY43cGQadFE2KocCctATlpg=; b=Zk05T4tilnAIrBvScUpOF3+wu7
	NmdY36gxHrICTclmGmyxxkYYsuP3SRmee/QrQVaJsRTY3HW9eTHR6gZaI+IsxJCg
	caiVZ1HVu5oQjkFYkebMbPZ4ldkxPBkD9NYrjkLrMWHbzAIk2LrR/DklgVwhxFqN
	tHzotf/6e3z7jerJf9lGZvmdtHIjBR5SzcZmzNW13p9y8rp2KbtsIjr1SNnYKA/H
	I7C59q0ytJ8l19A5KcrFd0xk/ZzhekpNz9DkxBd6clNiv6fmNbEej55WL8F1N9cY
	rDsG3pkL6RuIbfdgUx0cxcTP1oIcJhW1N/ol0LXbYesHEIGAg2r/18giDF3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768334015; x=1768420415; bh=X0m5kgP1sJGx1qW0bgdYjY43cGQadFE2Koc
	CctATlpg=; b=BosYUXlbrmbSTF6j4qnTIikgitwTeli7WYzAfrJUCJu3rEN00R/
	34eKhNonKUkSIYqH4lAQpCyXE9XE/NIYW0CALsOtVXuPQc6lfBWIQMAIYF85YFM3
	KNShkjnfzsmZuq2AOOpTNsKuREtxazeh74sGm7YkL2OJUFinomIrujfVWtysfLAM
	rcTJPCqHVGIjTHbcxgLL605OQIHhxIzE2PoiRlK0T9Zpfv6Qv6crw7TjkhAOI0MF
	hSmWSE1jBKwKqTYxck7RUt+zkj480sm2dk8LbRkd7fsS3HNagod7yrxjiKD+2f9E
	z09wNEbzHi4xV5FYc7NE8kU1azM4P3VaIOA==
X-ME-Sender: <xms:v6JmaaFGdbEhk-FNqnlLlrAFQ2Yh6z3ms1fiQABRXzpOTX4YWXACrA>
    <xme:v6Jmad6Yg9nYlJac3BVhf2-80MSXoiEFmy3ppONNb2WVAZNsMYnHjYytZLz_-EUkN
    Xm5T4f1zbPzsGo0FGFnKSVvPlB7XDAn7euOsDN6nnb4l3C-Pf-c>
X-ME-Received: <xmr:v6JmaXxfJdAPjZrIpnoL7eXY7_yWzBTICc4xmsXA4rGA_Gf9EArP2psGV-FM7VzJnWgfSON7lAP72_RbT7mbtX0wNFWCHwLDyriSP7o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdduvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:v6JmaUPFj8-qfZN81ZvfrNnzd8h9tAJ71-4TINZvFDb_-xHRlF39ig>
    <xmx:v6JmaVlftQDbxBSj6c-qVZsMar48NVc6s1UDU-Ga3ge7c7Q7iO6rSg>
    <xmx:v6JmaRRFkWYxWUUSU9jvRGR2FGo2-hT_EJPVgb0at9PelcalueIekQ>
    <xmx:v6JmacVdYf97127P57Y8i1qpIZRtJbGwUmSi_TwTGB6zk8mSrCHK2A>
    <xmx:v6JmaY3jkRifwTNwdUEkN1oN95THxtdnprr1rh0sAJ1thI7W-_7c0cmM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 14:53:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v2 3/3] environment: move
 "branch.autoSetupMerge" into `struct repo_config_values`
In-Reply-To: <6e54e22ac7096f26e774acc4740bcb135496fb69.1768318762.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Tue, 13 Jan 2026 17:44:02 +0100")
References: <cover.1768318762.git.belkid98@gmail.com>
	<6e54e22ac7096f26e774acc4740bcb135496fb69.1768318762.git.belkid98@gmail.com>
Date: Tue, 13 Jan 2026 11:53:33 -0800
Message-ID: <xmqqo6mxi91e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> The config value `brach.autoSetupMerge` is parsed in
> `git_default_branch_config()` and stored in the global variable
> `git_branch_track`. This global variable can cause unexpected behaviours
> when multiple Git repos run in the the same process.
>
> Move this value into `struct repo_config_values` which holds all values
> parsed by `git_default_config()` and can be accessed per
> repo via `git_default_config()`. This would retain the same
> behaviours while achieving repository scoped access.
>
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---

Currently the code flow is for git_config(git_default_config) to be
called fairly early in the program, updating the singleton globals
that are independent from individual repository.  This moves these
global variables to be stored in the config_values structure that is
tied to the_repository.

The claim in the cover letter was that this will make it possible
for us to later work on more than one repositories at once and each
repository can keep its own independent value.  While the updated
data structure may make it _possible_, I am not sure if this is a
safe approach to get to the final state, without seeing how the
config_values structure in the second "repo" structure is populated.

And before moving all these globals into config_values, it is not
possible to safely populate the config_values structure in the
second "repo" structure, if git_config(git_default_config) is what
we plan to use.  The settings that are still stored in globals will
then get overwritten.

That is why my first question for this round of patches was "are all
these settings inherently per repository?", because the scheme would
not work if there are globals that cannot be moved to config_value
structure to be per-repo.


> diff --git a/repository.c b/repository.c
> index c7e75215ac..d308cd78bf 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
>  	ALLOC_ARRAY(repo->index, 1);
>  	index_state_init(repo->index, repo);
>  	repo->check_deprecated_config = true;
> +	repo_config_values_init(&repo->config_values);

Having a call to repo_config_values_init() when initializing an
in-core repository instance is a reasonable design, and I see this
step has an initialization of git_branch_track in that function.
Shouldn't we be doing similar initialization in the same
config_values_init() function for other members of the structure,
namely, attributes_file_path and sparse_checkout?

The function also may be a good place to do an equivalent of calling
git_config(git_default_config) there to grab values that are suitable
for the given repository, but I didn't think things through.

Thanks.
