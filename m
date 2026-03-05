Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579281F1534
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737308; cv=none; b=R5R06QHQ14VAUQwZjCNBcWCMQoLpJBXnb6730dZnpYKCEX3ocy73AagtZwF2vr7V7R9EEZg0+fA4nTUXiTk+yYTmCZs9KiWqq0mNj6KX/hjV5Nqc9O+l+i6LgOFqNqNrZWpCg/LS2A44kndXQifSQQJ8JurnTnKX+sbtKVILakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737308; c=relaxed/simple;
	bh=L1uW+1JL5jcp/PT+HiDUHNONYlxg8qx29MMDt2EGOHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gUnqZmhGyPIpsFicouVeO5DWGtfPq9taMQREQ1w3qRF1SKK3wYvnqu1NNFkV04F+qaJEYzkRkSJrdZvtPl/PP+0jCkewm9hWIowMwRQJ9rV5/cLQba8133RvJF9gF8m1/w0tnojmWF36NIx5UgXeC58SkgJHUqC6silYcLE5tio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UyLKMvXW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UpddKIM9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UyLKMvXW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UpddKIM9"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96D351400195;
	Thu,  5 Mar 2026 14:01:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 05 Mar 2026 14:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772737305;
	 x=1772823705; bh=6K3iddK7bzSWU2EiCtM5UA+OuCrwQPFzD2La1b/HKHk=; b=
	UyLKMvXWGng6dFbOjomi9g2Hh+u4qjFC4g72MT8OLTjnhg2rqgfr8WM07HRyl8T1
	/pQnTQRHrzT6xr2xFkoEO1vv3lyw/XxX4snRMUJ58f5LTdth7w6EjCc5uNhnj1QK
	/PiuNh84mSg/IBvpPLXKn3HdvVbUX+7uqodWmqNrmRlHqDkZbLxaBTej1gw7oj3X
	TVRV7NlDK8Qk1NPyF6sEG0ch1zRP5xuinZzTHhrbTqC9D6LhXtvFNFtoVLR8Co4Q
	8OTwTOm9HXDfCMoAXRzEb0dGCXwk0gMJMSMp05Bq2GZxleTqMXAWXPRfp1/4Q2Wj
	s33upyMtu41Rg2yYxjJV4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772737305; x=
	1772823705; bh=6K3iddK7bzSWU2EiCtM5UA+OuCrwQPFzD2La1b/HKHk=; b=U
	pddKIM9vYQyFOAKmaX8AF76kD1IYLh/HyN6rVRARghIeuMkjIpP2UkQ3SCiuPPL6
	LRoqYAu6a7AAOLs/Qp2f+shBfOO8ZHAmTV/ejHF7673fqA8F6xSqVW/6MqcpNvsE
	RfFxNFIVlM7OqZTWEIF3sU12jhvKYB5QFOdQpMHmUn0vSaZT6+TQxSBSj2Uhd5UD
	rk3KRVXKmP6tpAPnn0iCIR4dYZf92I2BksgUYWb2OM7xox0xBcnZxqrrqmjPRRYl
	MFLM2kwv9gYq8vHyLI0GP27ZVF/7HtkH4ZG2jMdsI8Jr3EUfH9wQFFp0JhWj4DWv
	TT4mZdfN6NoG/6hMhp1vg==
X-ME-Sender: <xms:GdOpacFlkN-Bh-mdDhD17vx2_TfyXw4PP_tBrbM0v0S6HAFc_oP_wA>
    <xme:GdOpaX6ZhkrCN76UbJIU_YVuLkGmxG3i_iZ9xSpAc2-OsVfvovjf7Y87VHubZ4WNz
    6U1OHG60fEk5dswxULcOhbvV88PJvMXlNLAqmjin0JYk46O9VwmjQ>
X-ME-Received: <xmr:GdOpaZxjfPSsosbCyC1BnlKA1K0z1-M_1LojfMRQQrnAsuQLg8IShn9TtXeKnblpOda98raBd2yspSjUMxBkKic3STR19JLGpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeettdfffefhheejfeffteegteejudevvdetleettedujefggefhheegueei
    ueevkeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgtohhrphdrtghomhdpuhhrlh
    drqdihohhunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprghlrghnsegsrhgrih
    hthhifrghithgvrdguvghvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:GdOpaeNG0QOTSJz8_BFX0yn7G-4uY8UkPRXH-6eijJ2ltZ4eKCqD2g>
    <xmx:GdOpaXlQj1q2oWYntpjvzi5OYnMMvfUAOvwDMPdo6N8mEJErzEDNtg>
    <xmx:GdOpabSvf4CxamjjIf6r45pWEIjU5gfR-EcM2VB2fMbz1tqIZ3cIlg>
    <xmx:GdOpaeWDMEl-JkyYh_hJ-wIKREvo0r4CLfekcLw_l-xOoZm0KEDwjQ>
    <xmx:GdOpaTs1xzM9__k6iV--oF7NOc_7HIiY0JRjtwNQvHU3zBRZX2awaoTR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 14:01:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com,
  jonathantanmy@google.com,  me@ttaylorr.com,  Jeff King <peff@peff.net>,
  Alan Braithwaite <alan@braithwaite.dev>
Subject: Re: [PATCH v2] clone: add clone.<url>.defaultObjectFilter config
In-Reply-To: <pull.2058.v2.git.1772672251281.gitgitgadget@gmail.com> (Alan
	Braithwaite via GitGitGadget's message of "Thu, 05 Mar 2026 00:57:31
	+0000")
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
	<pull.2058.v2.git.1772672251281.gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 11:01:43 -0800
Message-ID: <xmqqcy1i3xt4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alan Braithwaite <alan@braithwaite.dev>
>
> Add a new configuration option that lets users specify a default
> partial clone filter per URL pattern.  When cloning a repository
> whose URL matches a configured pattern, git-clone automatically
> applies the filter, equivalent to passing --filter on the command
> line.
>
>     [clone "https://github.com/"]
>         defaultObjectFilter = blob:limit=5m
>
>     [clone "https://internal.corp.com/large-project/"]
>         defaultObjectFilter = blob:none
>
> URL matching uses the existing urlmatch_config_entry() infrastructure,
> following the same rules as http.<url>.* — you can match a domain,
> a namespace path, or a specific project, and the most specific match
> wins.
>
> The config only affects the initial clone.  Once the clone completes,
> the filter is recorded in remote.<name>.partialCloneFilter, so
> subsequent fetches inherit it automatically.  An explicit --filter
> flag on the command line takes precedence.

The motivation behind the change is clearly described.  Reusing the
existing urlmatch_config_entry() infrastructure is very appropriate
as it makes the feature intuitive for those familiar with
http.<url>.* settings.

> Only the URL-qualified form (clone.<url>.defaultObjectFilter) is
> honored; a bare clone.defaultObjectFilter without a URL subsection
> is ignored.

This is unlike how http.<url>.<var> configuration variables work,
and while I can see that server operators may not want to see users
set clone.defaultObjectFilter and affect traffic with _all_ sites, I
am afraid that this design choice may appear a bit counter-intuitive
to end users.


> Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>

>  Documentation/config/clone.adoc | 26 ++++++++++++
>  builtin/clone.c                 | 68 ++++++++++++++++++++++++++++++
>  t/t5616-partial-clone.sh        | 73 +++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 45d8fa0eed..5e20b5343d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -44,6 +44,7 @@
>  #include "path.h"
>  #include "pkt-line.h"
>  #include "list-objects-filter-options.h"
> +#include "urlmatch.h"
>  #include "hook.h"
>  #include "bundle.h"
>  #include "bundle-uri.h"
> @@ -757,6 +758,65 @@ static int git_clone_config(const char *k, const char *v,
>  	return git_default_config(k, v, ctx, cb);
>  }
>  
> +struct clone_filter_data {
> +	char *default_object_filter;
> +};
> +
> +static int clone_filter_collect(const char *var, const char *value,
> +				const struct config_context *ctx UNUSED,
> +				void *cb)
> +{
> +	struct clone_filter_data *data = cb;
> +
> +	if (!strcmp(var, "clone.defaultobjectfilter")) {
> +		free(data->default_object_filter);
> +		data->default_object_filter = xstrdup(value);
> +	}
> +	return 0;
> +}

This will segfault with a "value-less truth", i.e.,

	[clone "<URL>"]
		defaultObjectFilter

so there should be 

		if (!value)
			return config_error_nonbool(var);

in it.

I cannot convince myself that a new structure only to hold a single
"char *" member is not over-engineering.  Wouldn't it work equally
well (unless you have an immediate plan to add more members to the
struct, that is):

	char **filter_spec_p = cb;

	if (!strcmp(var, "clone.defaultobjectfilter")) {
		if (!value)
			retgurn config_error_nonbool(var);
		free(*filter_spec_p);
		*filter_spec_p = xstrdup(value);
	}
	return 0;

> +/*
> + * Look up clone.<url>.defaultObjectFilter using the urlmatch
> + * infrastructure.  Only URL-qualified forms are supported; a bare
> + * clone.defaultObjectFilter (without a URL) is ignored.
> + */
> +static char *get_default_object_filter(const char *url)
> +{
> +	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
> +	struct clone_filter_data data = { 0 };
> +	struct string_list_item *item;
> +	char *normalized_url;
> +
> +	config.section = "clone";
> +	config.key = "defaultobjectfilter";
> +	config.collect_fn = clone_filter_collect;
> +	config.cascade_fn = git_clone_config;
> +	config.cb = &data;
> +
> +	normalized_url = url_normalize(url, &config.url);
> +
> +	repo_config(the_repository, urlmatch_config_entry, &config);
> +	free(normalized_url);

This forces a second full scan of the configuration space.  But it
cannot be avoided, because the existing repo_config() call has to
happen early before we call parse_options() to give us the
configured default to overwrite with the command line, and we would
not know what our URL is before we called parse_options().

However, I thihk you want to leave the .cascade_fn NULL; you do not
want urlmatch_config_entry() to call git_clone_config() AGAIN on the
configuration variables, as the first call to repo_config() before
we call parse_options() should have already handled them, no?

Thanks.
