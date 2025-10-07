Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5C02D47F4
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829056; cv=pass; b=sMVlWegVYlcC0b09guS2K1ptmIjndo4DuMoaC6iur2QSHrH5pnThmYJVePRGIC7Irf/vJOUy9qLEyt31LpWBY6d45uHbt/RPu5LGIY8iCRNWhBAsErqaKF1v/sEzLaMYlM/4w5xtyQ+Y/Y/9tFH8VikTdf2ik5tyDv0xpChSQIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829056; c=relaxed/simple;
	bh=mhk1wvSK4yeh13JfM70bEKYpteDDNWPZ9poJbSiSPPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BAGrZibYmHXJ0jL/qG0DfZhCi2inFgVrYnCUppbftL2nqhHErlUztjeiF+RZcs1kSzW3lLw/3Fgp33rIlCe3UgF2O7nsfqKVZVjSKXZDJb/OMDxRc3mSWu23ZSelKTw4fzGsPHpCVljslYojgxUiXE3Fxc8qGGUK3wysLa0/+x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ATgI0m7j; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ATgI0m7j"
ARC-Seal: i=1; a=rsa-sha256; t=1759829037; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fxxiAKDC+ZqniwrzZKea1RyXzsT2DKHB2c9GJaR1I7JVNzaMDhFPNbBI8YPAg+2zA/QoxVq3zFw2EFglIScWGvZ7LN9HJH6WoQ9fo/yddIZ7uwH0Z1A81EK+Tqx2418I4t90va5LU0JJdnssNLNL0n8YOtatDoOPpZBig0nEhIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759829037; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WGcfKFyWEMXl4XlNgr9m+Ulro2rQXJOjLrQu9pPPtCU=; 
	b=LobBJy6s7+FKm+z8f28809g4JhUuCs9Es4YSANWRnJdQkQm0dJTzveAdnEavhVQ/5yA19URJ/5Vp3mMrBzZB9cAdAb3GUXVMyZbe118ql+r+f4EvnOD79wQ1HXD7cxaM/xOHtl/wOfho6DuNmqaFZtFz6evO5XQ0cP+CceZlvJg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759829037;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=WGcfKFyWEMXl4XlNgr9m+Ulro2rQXJOjLrQu9pPPtCU=;
	b=ATgI0m7jFMfKc10SVQWU247eXQ19Er+fUv04qG0eFiD4jBkFFvd+Q9qMMd/WgiOi
	v5Z8zQ43xZIAknh0Pv4cYj9uejtJCw1LeLWneYJSbQsVm4oLK1pyWGV2LzAW3+oDgqm
	2cmi8o81HVu3lfWsfHCwKKvy8WOdx4TIDKvSqnM8=
Received: by mx.zohomail.com with SMTPS id 1759829034457346.8256216688667;
	Tue, 7 Oct 2025 02:23:54 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 1/5] submodule--helper: use submodule_name_to_gitdir
 in add_submodule
In-Reply-To: <xmqqh5wcq94v.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-2-adrian.ratiu@collabora.com>
 <xmqqh5wcq94v.fsf@gitster.g>
Date: Tue, 07 Oct 2025 12:23:43 +0300
Message-ID: <87plaz3w0w.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 06 Oct 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> While testing submodule gitdir path encoding, I noticed 
>> submodule--helper is still using a hardcoded name-based path 
>> leading to test failures, so convert it to the common helper 
>> function introduced by commit ce125d431a (submodule: extract 
>> path to submodule gitdir func, 2021-09-15)  and used in other 
>> locations across the source tree. 
> 
> OK.  To me during my first reading, the above read as if you 
> found an open coded logic here in add_submodule(), made it into 
> a new common helper function, and made this part as well as 
> other locations call that new common helper function.  Of course 
> that is not the case. 
> 
> Perhaps replacing everything after ", so convert it" with 
> something simpler like 
> 
>     ... to test failures.  Call submodule_name_to_gitdir() 
>     helper instead, which was invented exactly for this purpose 
>     and everybody else uses.  
> might have helped me to avoid such a confusion.  I dunno. 

Ack, I'll reword as you suggested to make it clearer.

 
>> diff --git a/builtin/submodule--helper.c 
>> b/builtin/submodule--helper.c index fcd73abe53..2873b2780e 
>> 100644 --- a/builtin/submodule--helper.c +++ 
>> b/builtin/submodule--helper.c @@ -3187,13 +3187,13 @@ static 
>> void append_fetch_remotes(struct strbuf *msg, const char 
>> *git_dir_path) 
>>   static int add_submodule(const struct add_data *add_data) { 
>> -	char *submod_gitdir_path; 
>>  	struct module_clone_data clone_data = 
>>  MODULE_CLONE_DATA_INIT; struct string_list reference = 
>>  STRING_LIST_INIT_NODUP; int ret = -1;  /* perhaps the path 
>>  already exists and is already a git repo, else clone it */ if 
>>  (is_directory(add_data->sm_path)) { 
>> +		char *submod_gitdir_path; 
> 
> This hunk is not related to the theme of the change and not 
> explained?  I think the variable becomes used only within this 
> block after the patch that loses the use of it on the "else" 
> side, so in that sense it is not strictly unrelated, but is a 
> fallout of this change.  If we were to mention the change in the 
> log message, something like "Also narrow the scope of a variable 
> that is no longer used in the updated code" would suffice.

Your understanding is correct, yes. I'll add it to the log msg.
