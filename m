Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C637AA7A
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830953; cv=none; b=shMEXzTHt9cLCkyPtR6W48aSjsXi2/IrN19inYx+kNR5HbYPNpEwQ8gz6WA5hqMezFeZUTfmoM281QnYRiqoK7P+Csc10m0mDMqWizHy0Z5O5ZnIDhe6KtHqOneMioIixLjEIZJg/jjcwNre7OXn46TsTUqNfYg82uUhOlULgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830953; c=relaxed/simple;
	bh=C85eZI2STQ6/jyEMILvLriDjYsTMR0IicZOhcizPILo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RyXPW2251VT4a+6jJUtndKH0PBLtOmb5L37E/gnA5foGUkrA+iH8BAa6IbnLdi5ldY9hkFWCna+BPM8Wliwb9nvecuPc3t2tsdNb/Q5l12CnLVzTE+ni3xXMNSDdhTa0UDxmN6CxVDA5GwSxRkqEktZcdakzg5QZJt8JSSVzhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GfBQnos5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v5kMkOAM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GfBQnos5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v5kMkOAM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EEEE8EC0856
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:49:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 12 Oct 2026 14:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791830950; x=1791917350; bh=R131hAjhim
	RRFHetWM7jX1HhdtIInY8vM64f+3vNus8=; b=GfBQnos5M1aMdORGRx64UQXE2I
	iuXMz7/1Avgy266b436G37x+OeycbQ3Hm8L4TFYqn0zbZRwg6PvMpi+e+2YkRymP
	Ay7hy0ghj61YVgx4AJYXDxes3nYnTmjtbld2YAF9UrSRIDhTQdjPOpN+U4KONRv2
	BwSn1GBkDq5v9GTyTHivT993ExZNdOXEsC69m4W0Ci5Sc4Fr/U+ycxIQodVNfWge
	g8DgMpnJjFM/O7SwUC1wSA2zVbp3w2DAnfebh5Mdn5eKYrH8bj6gxlsEQLkxzLP4
	irMpxpa6eRujxpMBS2YUibrcX7UMs0BkEPOdLa4GsuZ+W71LUotQZpLObtaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791830950; x=1791917350; bh=R131hAjhimRRFHetWM7jX1HhdtIInY8vM64
	f+3vNus8=; b=v5kMkOAMa99v/FHR98mj+UuGcugXlWsN0gBH5vicqgbUH6X0yIc
	GVZtmbvXpgJmK9tacRzqB88xsLZJ2YY36DiW1FFySHLTEbKCYdn22EEPrkiSZE5+
	k7Gw6g2shht/03+A/owoqYJ+oqE1h2hT5Aw9HjoIwc3Ha4hrozRJNW+kbW97sfhO
	vpY1VZP/3EWAVFiz6wfC7DwDnNT1jIp5dcdybqfxBrOD0tDaGSnOmeZNO2n8uRhM
	WqOykmgwWwauBWsOkEzLaIQBu6JjBl3XmH37lmH4dyZ0P5jJvahbXIcFp/RBO1Am
	/NNv5xpm2zgUG4+uQ8e1GghJxcnGWBqaaMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791830950; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:URv9gaN4+uR81lmmGJYX+TfM+LotjIsqMfUcv7sVNxGeyx1
	k4xeZVNHwss5lsZwX1zGfHur15masZG1SPIlWgTvvhOkewNtnVgd1pzeHPQlLuE0
	A6C5Uhri/c6GGmGsecEapOLPID6PojaEAS6s5894tudcvXDUTvMMmk1bpToaomWo
	W8VpKJU7rubNkz/mUhnuaYkllWhPjsYaGo4HCdzYed06lKq74LV/yw20Opeid1EH
	5JeBH8fCuaFfHzUWvMR33GFFVfMmwqGGZiiQXyCd3bUwW7oGDRD/3OlKOMa1UwQP
	FsnE9NFHq+LR419djgIZtZXbGIh8FOlh2+4MNFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mXOJEi3IfEKSM/oTi2siFzDYO+CBzFEBcPNxIJQW4nA=:C85eZI2STQ6/jyEMILvLriDjYsTMR0IicZOhcizPILo=;
X-ME-Sender: <xms:pivNajoolqzBoUh4hSBih4Ku545RqeWICmT164iSf5dNd9UWkNsd3g>
    <xme:pivNakgjuOBpmKGAlY7VwgQsVWXdnM2uOfAwgiEpMnbZOyV4gE1op6m7WiiU80UIW
    Y3dQVoO8yBEc76vYcPs-JjZ06E1McuUlsPfmR-AqCEa-Rtdm18yM04>
X-ME-Received: <xmr:pivNaohIjLdXgn1iKcoDgFDze84sUZfY7JMRX3ulCKP2WijYhJ-aqKbN3NiJqQ_3uV_VKEwXQUhtQaS4c3MIGYb6cGN95i9NYuOZ>
X-ME-Proxy-Cause: dmFkZTEQMEM098snaQ5VD97ORXkX5E9HxfTNGElSJsHHO91cFoNDgWQD4NWuSSf2XeVyQO
    bTS3JFknPWQyOk7MEgeRtBJdkpKFFhzTN4GNrSi9Nzz2GeiP7U9A3wqyLdQ2xigjzDibm7
    xJIq6vcrD69/aBlQUA3GAG2RiOQPrQK6cAKGXMfRoTtBPXgmZ7JO+jLND8FPNxTl9K+SbS
    CYpreLq/Ljb9mHID8/R+gOXtiEeYqCChZV/hRe0NDrZbAOYOs9qgYHEGghbMiKK7/7+4qf
    Fu6a1yC9YahHJLXhVRoO/nV4RdxV+crmyf535UFrdjPiVtxhtpE7KZLwr8mXUgRaokwhoF
    TNqCj3RYTx5vb7NLveLTq882HospRfCy8loaeW3/NxU72WKzFUlpfGqpkHf/6brYOYQ896
    OZnj54KrHw+zL1hx844wDVva0ClHS/Hh/w3mHZjzOhXfF09E+4bc/8pRcu9IOgPCZgzqw8
    eVNLazvo453F4zm+7bL+cpnD+avqB+eLN3+0LdNWiPeyIs53A4Ye/xijv3M3yDzx8n1o95
    AP6i5ayGb8BVMspTpNt+G22fzFzI2enU0IKSJaaTkjiStsgQIB1gJgHzngMtNtsRqhda2O
    m6nsRgUpx4j55meWQn+TrfP9Yu1hv2llf9SlRqg3amxSR8/16FjasUpfPhBw
X-ME-Proxy: <xmx:pivNaig85oJHRZZXbZuDWqP9uR2ocspU_VzkkDwU9UAa-PibJOWfvQ>
    <xmx:pivNagJKCfCABf1NwbCo0O5SKwSF3Ld_EfXUaPo32kHqcwqf8Bqxgw>
    <xmx:pivNapGoRoaRsYGXK2u7ZaiUSziignHn0qqX1LEm3MGcaLtK164lkQ>
    <xmx:pivNasRTbSGvnk7qhKePCZTyzcVefZLzKQJOK1aYx2p7zbnLhQj0pQ>
    <xmx:pivNaqiwa0pHduuQoBLHw0knFM6sXFFBehLt34DuImJCsB0ZndmNvu70>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 14:49:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 3/4] connected: add transfer.connectivityCheck config
 and rev-list flag
In-Reply-To: <cdf28f1df6cb36b006f367de0e18e23e3aa8d992.1791806877.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Mon, 12 Oct 2026
	12:07:56 +0000")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
	<cdf28f1df6cb36b006f367de0e18e23e3aa8d992.1791806877.git.gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 11:49:08 -0700
Message-ID: <xmqq7bjm7o0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/connected.c b/connected.c
> index 929b9bd28d..e3dcd8e2b0 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -1,6 +1,7 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>  
>  #include "git-compat-util.h"
> +#include "config.h"
>  #include "gettext.h"
>  #include "hex.h"
>  #include "odb.h"
> @@ -67,6 +68,26 @@ static int check_connected_promisor(oid_iterate_fn fn,
>  	return 1;
>  }
>  
> +static int incremental_check_applicable(struct check_connected_options *opt)
> +{
> +	const char *algorithm = NULL;
> +
> +	if (repo_config_get_string_tmp(the_repository,
> +				       "transfer.connectivitycheck",
> +				       &algorithm))
> +		return 0;

The file does declare USE_THE_REPOSITORY_VARIABLE but I wonder if we
can easily reduce the dependency to the_repository by adding "struct
repository *repo" pointer to the check_connected_options structure
and using it here and passing it to check_connected_promisor() which
is a file-scope static nearby.

> +	if (!strcasecmp(algorithm, "full"))
> +		return 0;
> +	if (strcasecmp(algorithm, "incremental"))
> +		die(_("unknown transfer.connectivityCheck algorithm '%s'"),
> +		    algorithm);
> +
> +	if (opt->is_deepening_fetch)
> +		return 0;
> +
> +	return 1;
> +}
> +
>  /*
>   * If we feed all the commits we want to verify to this command
>   *
> @@ -133,6 +154,9 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  	if (opt->progress)
>  		strvec_pushf(&rev_list.args, "--progress=%s",
>  			     _("Checking connectivity"));
> +	if (incremental_check_applicable(opt))
> +		strvec_push(&rev_list.args,
> +			    "--verify-trees-incremental");
>  
>  	rev_list.git_cmd = 1;
>  	if (opt->env)
