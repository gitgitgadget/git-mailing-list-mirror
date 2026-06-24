Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AC8834
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340387; cv=none; b=F1aq6Lsxw74eY47B3zy7Up1tFVpqZqhqcaQpGTc62s49oZY2Pr56H0OAYOpQXrDOu2FHZ75Xd629H967TuS3ZwT2LcYamMqU5t5IoMDrVoAIHTUF6gBLdXaqSfUzqEIx60tjzKR+hB9rN7+QZduE4At4rNP7VDWATzM1d4vfBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340387; c=relaxed/simple;
	bh=DhI3vZtWBmAte3cycNIwkXWDElZxAwF5VkiCktlx3HY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8Ck83rOBY5rhZYZCTv7/TwEO+HAHP5RUyjD26eIdELhzebfZIKIeIhhkKtGobDtzPpygx04eaBwz3sKnMHicx4K7m3B97kdhiGxrFilQ+IjwODM5NLd2oT9neVLpbREnvPirOGnhch7rpctKcYO1YcNrzCC6EHy/mH5LBwdwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d+LQODNz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sra4Spdb; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d+LQODNz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sra4Spdb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AB161D00064;
	Wed, 24 Jun 2026 18:33:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 18:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782340385; x=1782426785; bh=ZW6ysUu4hi
	hUqF4QxFnU8g1uKWH7GN5DnAorwMTRXdY=; b=d+LQODNzw8wQI6cTpASQmAlrNQ
	LlzW7XyuSG5hvp/kDF5Scf3krvv6c221NvyjT0lyE+Myqe3FJiIFLWzDemGXx2uA
	1Gva03DItwFsIJr8yTAvkQCwPjJyrJzpWk7CG1TGE/SxoWtZvIAxL508FDu/2nD2
	YKOQ1jAaamUY/p5kPhd5R2GHQj4HluEE8gtV4rOgXndcuKXnjPeFulKXRrJzuWdR
	prR0k3SY4VmeN6lDOXUp5WEXHFaWhT7GdpXO6EoUWnvKq6NG0xNt+yS003zcrdpv
	zJoECGMgzqSWTK0B2HzrUzl3gUOnyOeieKEdwKijA0N+gj1v2umQDLrL3MDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782340385; x=1782426785; bh=ZW6ysUu4hihUqF4QxFnU8g1uKWH7GN5DnAo
	rwMTRXdY=; b=Sra4SpdbiXNpo3cEepwfTDUeWHmSTh3GABDjns7q7jr4kX903vj
	A2W6CQqTV13SXLa1igikInr+iXsIIXxl8m5LATkfopbuny1TN5B09EkdDDd47Al0
	ppf8y4cBYkUG3Uy8EYSt2wa0hWAVvWCfdBBoxmoE5PTo5c2XNi7IfLkry5lTAtLn
	2nBM5p/wAbFDpgDrfYAQmSjUhT6JDZH63rb7nfL7pRbqzq0Q1MOiDj5jCsOr4uak
	59PHxb6U06msQYhyxPVkjsvemPhd8VjvgTAvOojGCssFz4HF9HXqdVmxiL681Bhj
	wNdN/XtJebkhIHIZV/XgBK4C+tayurQ3ROQ==
X-ME-Sender: <xms:IVs8aj7_or5AnJPqG8uNPv2XqxUY5rD-Kx8e3_TGJ3fdOz4Go7xw3A>
    <xme:IVs8av4hDxEWNuev6805dapX6j_ENoWpBqa8GrLr28NNqgwwO2iotka-3O9OXFce_
    Bcq-Kayjn788ofPmCL02CDQQlkD8i16mlwrdvkoHPURe7alMSB50w>
X-ME-Received: <xmr:IVs8ave6DeTJkYanVKOl0ssf_emSrPtsNM8Yr-dsL1ZzjKbKtnio66F1auhpauYWpOiry-xik93UczI_lOl00g1Engoj0uq-1Xu-a5w>
X-ME-Proxy-Cause: dmFkZTG2eoxmkzuVK9IFVlPM4JZm8kLCAhCPD162cP/GIJ6sT2l6CuCIdj3L3LY20w6Lhi
    hhKt4r2tac1h+msaLdPfZDkOChbNKCxZs1l56K/ivf8WQjU1gdllATPtlNPGeJX+5nLGKv
    /OnrMlMl+1mxw9GIubYOh5vgSExmBaS9ouzNZZG98604XvhjQutJDxCEfD+OpZjbDYBsIq
    OToqWMIaOA/sj+oZeA+59vqhlJEU+8JK7BH0v2ZbArixUIGyqvsIs4+RIuaXk7UO5PyDhN
    3ID9wz+jS3Lm62h2pzYtpAMzQ5aEXvZW21IBkAS1MjHzZtUboRJhKnA4Xf99h8g8KGBQZx
    keWe0qaqqFlmH0huHArZl/vCyUXg08qST0F5hac5B9n1/akMiXikhkeiR9Qfos3kE13wKb
    AUAQ83xANqP8umF7RjUVJrmwVNZTn8XC5vyzezgsEjLALb1duuO4JoxYRfoed2/CIyCZ/5
    pQ4IuTIUol4Lo3GCEhVjc3sYiyDtJjosfdqtRtnvB2O3WpBKn+JnoDJbE3mYxNGq4nxthq
    OqUzUOacadwDS/eNuJLyTcqkB33pCk4/TSV6UhihJUV4xT+vvl02yFqvs6Zuuwtv4xyKyo
    Uw8HQXn9oYNdYB619+8kEwTfO71jqz5AacXPVmXipMWM7bbWNymCsOObly5A
X-ME-Proxy: <xmx:IVs8ajCTptZOe9msr0rBXOIR-lXToa1A8r78711GMXv2uQRyruG02g>
    <xmx:IVs8ai8BqwqY_ghVWcuB1kDpZaMKd2QRSI3tV6zaSf-ODo17X85BWA>
    <xmx:IVs8auIIylW2WrNlWJW1XFnDtNedcoezOqcKr3sXD9KKWHLxMXc3eg>
    <xmx:IVs8arjnQ79dsiqQighyljrXnwv_SG3n92YL2uSEqPWT4fywi021Cg>
    <xmx:IVs8au-btI95ps41Jhd-Q_6z1PlYNFGqc24u_TuUuJZhMzVKbScg27_l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 18:33:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 1/2] branch: suggest <remote>/<branch> on upstream slip
In-Reply-To: <11bcecebf43797a889f08e79401370f43b2917a8.1782338114.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 24 Jun 2026
	21:55:13 +0000")
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
	<11bcecebf43797a889f08e79401370f43b2917a8.1782338114.git.gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 15:33:03 -0700
Message-ID: <xmqqechvh8m8.fsf@gitster.g>
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
> When setting the upstream of the current branch to the 'main' branch
> of the remote 'origin', i.e.,
>
>     $ git branch --set-upstream-to origin/main
>
> it is easy to mistakenly write
>
>     $ git branch --set-upstream-to origin main
>
> That is parsed as a request to set the upstream of the local branch
> 'main' to 'origin'. When 'main' does not exist, the command dies
> with:
>
>     fatal: branch 'main' does not exist
>
> pointing at a branch the user never meant to name.

It is more complete to add the other case here, something along the
lines of ...

    And then when 'main' does exist, the command would die with

        fatal: the requested upstream branch 'origin' does not exist

    leaving the user equally confused.

... no?  In any case, this is much more nicely described than the
previous round.  I see no room for confusion.

> When the operated-on branch is missing and '<remote>/<branch>' names
> a real remote-tracking ref, suggest the intended form:
>
>     $ git branch --set-upstream-to=origin/main
>
> The suggestion is gated on '<remote>/<branch>' existing so it only
> appears when a slipped slash is the likely explanation.

Makes sense.

Do we want to do anything on a case where the operated-on branch
does exist but '<remote>' is not a name suitable for an upstream,
but '<remote>/<branch>' is?

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1572a4f9ef..cefc4519a7 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -706,6 +706,29 @@ static int edit_branch_description(const char *branch_name)
>  	return 0;
>  }
>  
> +static void die_if_upstream_looks_like_remote(const char *new_upstream, const char *branch_name)
> +{
> +	struct strbuf remote_ref = STRBUF_INIT;
> +	int code;
> +
> +	if (strchr(new_upstream, '/') ||
> +	    !remote_is_configured(remote_get(new_upstream), 0))
> +		return;
> +
> +	strbuf_addf(&remote_ref, "refs/remotes/%s/%s", new_upstream, branch_name);
> +	if (!refs_ref_exists(get_main_ref_store(the_repository), remote_ref.buf)) {
> +		strbuf_release(&remote_ref);
> +		return;
> +	}
> +
> +	code = die_message(_("--set-upstream-to takes a single <remote>/<branch> argument"));
> +	advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
> +			  _("Did you mean to use: git branch --set-upstream-to=%s/%s?"),
> +			  new_upstream, branch_name);

Do we still need the _if_enabled() thing here?  Isn't the caller
gated with the same condition in this version?

> +	strbuf_release(&remote_ref);
> +	exit(code);
> +}
> +
>  int cmd_branch(int argc,
>  	       const char **argv,
>  	       const char *prefix,
> @@ -957,6 +980,9 @@ int cmd_branch(int argc,
>  		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname)) {
>  			if (!argc || branch_checked_out(branch->refname))
>  				die(_("no commit on branch '%s' yet"), branch->name);
> +			if (argc == 1 &&
> +			    advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
> +				die_if_upstream_looks_like_remote(new_upstream, argv[0]);
>  			die(_("branch '%s' does not exist"), branch->name);
>  		}

This is totally a tangent, but has anybody noticed that the web
interface to the lore archive seems to be constipated?  I am reading
over nntp and subscribers are reading from their inbox, so no real
harm done, but from time to time we get reminded how heavily our
development process relies on the services like kernel.org and feel
grateful to have them.
