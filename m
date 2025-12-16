Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37233A018
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878344; cv=pass; b=dtrFSDlo4I2aICCyZeIvrXBf2vYVZaSeLEqlM5c8yEAzmbxmMab1VNAcG8OcVV2SffuWDHiyfpEb2VSBksxze+0aJnuyzQPYGK1Ho6lD5B8aTxM1zTYrnqf29cvYjqvRgl6k8JIg/bn2TH6nkC4r2IVw8GCb28w6UYhtcTum0ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878344; c=relaxed/simple;
	bh=4wPTMl/HD/pvbaOmseWS+/yGItf0cjCMm//7HFoIk2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jw9/FWh8Phgzu+4WAsprSc+cpRQefuwDm2A8JJbSIaciYi8+yFvfA/OE75R39iau1V07kaYWEKzMkym2VRh+zRWvwYI/j4bin1u3rGVFAY4htt2wmno6neFiqziAFAm6I+qNR2b0ajZL+Ly1AJDw5xqyWa1SD4PMXB0e780LWIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=cPqUxAGf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="cPqUxAGf"
ARC-Seal: i=1; a=rsa-sha256; t=1765878326; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FNApENizzI+0uGrnY+cMXwo3ohtSxTm9slsoO3gdSbeblPk2jsrz3DNEv8yvgzgs77gcXZuWUIo2EW1N3y3F2r+6MeCzLBj72hAUH9NCtxXGlSD+t6zuliGOaIIJBMISFGdskrl/0Mkzdg2HVc1xMQobA4HNqCu3xcPwfZdsWdw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765878326; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e3i6Ix/NNMgezbp3LU8VbcJ+Q8JwE3jOMZrtjmZXrOg=; 
	b=AIlDvxBOaxTn26OMJud2l2qGl9Nc+0TDN3/xMIcruhEDGFOjtWoCzyYGSKJpgw6NqA/HVQpfqim5kvComt8/0h5Wn7atqihThNGTDEQ9RH6zoygUFooe8zi74FqGq/nzEEe0e/OnMKmux+wXLDwGc60v+Kuh7JjNzdF9oCu8jSo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765878326;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=e3i6Ix/NNMgezbp3LU8VbcJ+Q8JwE3jOMZrtjmZXrOg=;
	b=cPqUxAGfyyF6BKedqEbbrvuE68ibjd4TCVW6u/mqiAMh+pNsCrH5rfqtBuB5Mq8B
	77Jrx2cIoTXnAOyBDSu73djaN15M8QeDjNTHaI4zdLdX89XJZPFBl8XD43LxAFu+Dfh
	p1zBEJ/oZCE13HYewgbwI5/yK7pqx1CFBS6GF3Zs=
Received: by mx.zohomail.com with SMTPS id 1765878323679687.9268992394315;
	Tue, 16 Dec 2025 01:45:23 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 04/10] submodule: introduce
 extensions.submodulePathConfig
In-Reply-To: <aUEh14H242nm0NcE@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-5-adrian.ratiu@collabora.com>
 <aUEh14H242nm0NcE@pks.im>
Date: Tue, 16 Dec 2025 11:45:17 +0200
Message-ID: <874ipqhiaa.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 16 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Sat, Dec 13, 2025 at 10:08:10AM +0200, Adrian Ratiu wrote:
>> diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
>> index 0672d99117..4cf7424cda 100644
>> --- a/Documentation/config/submodule.adoc
>> +++ b/Documentation/config/submodule.adoc
>> @@ -52,6 +52,13 @@ submodule.<name>.active::
>>  	submodule.active config option. See linkgit:gitsubmodules[7] for
>>  	details.
>>  
>> +submodule.<name>.gitdir::
>> +	This sets the gitdir path for submodule <name>. It only works when
>> +	`extensions.submodulePathConfig` is enabled, otherwise it does nothing.
>
> This reads a tiny bit awkward. How about: "This configuration is only
> respected when..."?

Ack, will fix on the next reroll.

>> diff --git a/submodule.c b/submodule.c
>> index f645372a18..85ca7ea0fb 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -2570,30 +2570,39 @@ int submodule_to_gitdir(struct repository *repo,
>>  void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>>  			      const char *submodule_name)
>>  {
>> -	/*
>> -	 * NEEDSWORK: The current way of mapping a submodule's name to
>> -	 * its location in .git/modules/ has problems with some naming
>> -	 * schemes. For example, if a submodule is named "foo" and
>> -	 * another is named "foo/bar" (whether present in the same
>> -	 * superproject commit or not - the problem will arise if both
>> -	 * superproject commits have been checked out at any point in
>> -	 * time), or if two submodule names only have different cases in
>> -	 * a case-insensitive filesystem.
>> -	 *
>> -	 * There are several solutions, including encoding the path in
>> -	 * some way, introducing a submodule.<name>.gitdir config in
>> -	 * .git/config (not .gitmodules) that allows overriding what the
>> -	 * gitdir of a submodule would be (and teach Git, upon noticing
>> -	 * a clash, to automatically determine a non-clashing name and
>> -	 * to write such a config), or introducing a
>> -	 * submodule.<name>.gitdir config in .gitmodules that repo
>> -	 * administrators can explicitly set. Nothing has been decided,
>> -	 * so for now, just append the name at the end of the path.
>> -	 */
>> -	repo_git_path_append(r, buf, "modules/");
>> -	strbuf_addstr(buf, submodule_name);
>> +	const char *gitdir;
>> +	char *key;
>> +	int ret;
>> +
>> +	/* If extensions.submodulePathConfig is disabled, continue to use the plain path */
>> +	if (!r->repository_format_submodule_path_cfg) {
>> +		repo_git_path_append(r, buf, "modules/%s", submodule_name);
>> +		if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
>> +			die(_("refusing to create/use '%s' in another submodule's "
>> +			      "git dir"), buf->buf);
>> +
>> +		return; /* plain gitdir is valid for use */
>> +	}
>> +
>> +	/* Extension is enabled: use the gitdir config if it exists */
>> +	key = xstrfmt("submodule.%s.gitdir", submodule_name);
>> +	ret = repo_config_get_string_tmp(r, key, &gitdir);
>> +	FREE_AND_NULL(key);
>> +
>> +	if (!ret) {
>> +		strbuf_addstr(buf, gitdir);
>> +
>> +		/* validate because users might have modified the config */
>> +		if (validate_submodule_git_dir(buf->buf, submodule_name))
>> +			die(_("invalid 'submodule.%s.gitdir' config: '%s' please check "
>> +			      "if it is unique or conflicts with another module"),
>> +			    submodule_name, gitdir);
>> +
>> +		return; /* gitdir from config is valid for use */
>> +	}
>>  
>> -	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
>> -		die(_("refusing to create/use '%s' in another submodule's "
>> -		      "git dir"), buf->buf);
>> +	die(_("the 'submodule.%s.gitdir' config does not exist for module '%s'. "
>> +	      "Please ensure it is set, for example by running something like: "
>> +	      "'git config submodule.%s.gitdir .git/modules/%s'"),
>> +	    submodule_name, submodule_name, submodule_name, submodule_name);
>
> I think the logic would flow a bit more naturally if we didn't have all
> the early returns. Something like the following untested and uncompiled
> code:
>
> void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
> 			      const char *submodule_name)
> {
> 	if (!r->repository_format_submodule_path_cfg) {
> 		/*
> 		 * If extensions.submodulePathConfig is disabled,
> 		 * continue to use the plain path.
> 		 */
> 		repo_git_path_append(r, buf, "modules/%s", submodule_name);
> 	} else {
> 		const char *gitdir;
> 		char *key;
>
> 		/* Otherwise, if the extension is enabled, we use the gitdir config. */
> 		key = xstrfmt("submodule.%s.gitdir", submodule_name);
>
> 		if (repo_config_get_string_tmp(r, key, &gitdir)) {
> 			die(_("the 'submodule.%s.gitdir' config does not exist for module '%s'. "
> 			      "Please ensure it is set, for example by running something like: "
> 			      "'git config submodule.%s.gitdir .git/modules/%s'"),
> 			    submodule_name, submodule_name, submodule_name, submodule_name);
> 		}
>
> 		strbuf_addstr(buf, gitdir);
> 		FREE_AND_NULL(key);
> 	}
>
> 	if (validate_submodule_git_dir(buf->buf, submodule_name)) {
> 		die(_("invalid 'submodule.%s.gitdir' config: '%s' please check "
> 		      "if it is unique or conflicts with another module"),
> 		    submodule_name, gitdir);
> 	}
> }
>
> I think it would make sense to also hint at the extension in the error
> message here so that users know _why_ we expect the key to be set.

Ack, will fix in the next reroll.
