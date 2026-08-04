Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CEC47FB16
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865103; cv=none; b=M2F7dRlNQcNJMhi54RfhrxsicEdUfCJOOXoVdVUDazn6qpPnb8dj0+Gam7SCcst82IkDscxBk5Idpuh0d0TUuOJaDl6o7mTrIuI3QV/+syd3En0XU3tWvkV3DPGaXISk7CSF2c9SJfhrtO6RobDR5i130LuK18yANUXzDMrsyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865103; c=relaxed/simple;
	bh=u/chMJi6SlxlucXYNmyce3DrokcFRsuLiwWrTqYIU9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P1qx6jprEOVfFwYl9IWSZVYAd+KzP4UYW2wwzX2PV7mX+Yl0BQrpT0a4jaar5FLw1pnPxewOrwpNdsVS1wqv6X7EQxgrlooPm7nS+6+ncyG9BJrS5FIABeYHbwtmK6Tu24mE+qPs2XXJ9O5VTxCkOutDnDLeoQEb0WTV0IXQUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BnSasNyd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3QRWy3q; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BnSasNyd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3QRWy3q"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A15E81D00110;
	Tue,  4 Aug 2026 13:38:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 04 Aug 2026 13:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785865096; x=1785951496; bh=n06JfepM/l
	NhxUHX6yfdnqRpPXm5dwpr1KkG1mSL/Os=; b=BnSasNyduXSxMgfXi731+VTFKE
	jrxBN7dghCqFpSbvomfiqGTRhw4bTzeHJUauZeKOUDAK5AUEEuGUIMZLRfe1f8S5
	Y7LvFOxjwCQXOnK2zjObJPcQTINT9+cLMCSjIFyLuLjGBhKm8jUz76weaQsG31RF
	3DWmD5Ispi+ah8C6GhnCgQ+x72Y+GownkDZyzgb6x6RxEJNg4pYBC56mGNVPhN0q
	hajRoG5B266JofylLvUsDsKTIc9Z97EKFb9PpgiZzII9m2zmtKpSuAjxxXqg+BK/
	3oZ7gw6NV407TazHptFN8IrYUaFRbI0LDyc937VdFGmGPLUPMLcdaIK0UQ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785865096; x=1785951496; bh=n06JfepM/lNhxUHX6yfdnqRpPXm5dwpr1Kk
	G1mSL/Os=; b=h3QRWy3q6JmjDnUU5PbnXJF3e76tHVIh/Q0d4XfOX5/jCo8LGTe
	XaWFkV0+FhsF+OkHHO9cJnHG6dGIKoMyj/HFs0rbN6hbh84rHy6UF6dCj7KOyZxz
	w8GhlQ8Ir+SY6vP3uiDTMdmVpBe/FUUnY2xu8g92BTYyPjUJCMXtZZwxpWPe4ClE
	GUr19LrFXnN3IZMSBZh312VAcwGs92OvXuxfvtqGOtHgbql9hzp9NpCH3WZrbChJ
	KFPPLYxoJ+JkRtyd0CK3U9tQ/oo5Vltjl0OCHjQv+DiZOyeWF3t/MBYkH1m/xfrT
	/KnX0uICbyCIHsJTlKdND+gQCzsXH3li16A==
X-ME-Sender: <xms:iCNyas7JlL6vE0VGGPvWuZVk8v1NwWB79xLR9JzXHH8hVv70VgsVlA>
    <xme:iCNyagfhRLNoiSbMTt68yak5rrwPxQToZJNKlOKMWLCALR5ait0MPbfKAFpnoiO_K
    lVtl5w4dDM-T-xvpC-H5Lnm8jYQ40FcGaWvjimSDX2vvzMz1Z-b5sQ>
X-ME-Received: <xmr:iCNyavHuEULgCubmy3O0JuiDkj0byamDe6XqFr7LOknBFtv4CqkPnURxx6YjcJ5KNNtAHnPkSwd_xsJmvtBnDBZ941_TwQEo0g>
X-ME-Proxy-Cause: dmFkZTFlUBVwCQsXAE6iqPaW1nGUgfOjrPnSxit6gR+ZuGKtEfCdt6kVrkY00f3bjUnMYm
    52/u+N/jUbie21eej2ux9ivuEgqmvgT8w1fh5udnmJEHGaYHQc7bGGVB/K8AdnnnkHGBx+
    deTJIQZ7nmHCgDkdH0T9rgKCGXFhA7xKdB2acGlJ8wrY5q/oZzQhWImAw6rznpPvRq7ISI
    9fWSP/271cYiScYA3tbP4lpE7hHGMl9T157omLOvXJAIFA+jE8Rio3mrO0UihLN0ACmNhg
    2+XV7mWGOCFFD5p+4hkxVeXMvoBsjqcvnC3pQGML3sk7t9OwsGcCk2T5Y5dAFsxlGOyWsP
    Cf2r9jUahoepWO8H+ZZcXeUoWgKh0r3OuB/Nz5hpWGYSMTfluPH4oL+qk33EWQ2hg2RvgY
    q3VVdiiwutceMt6g81YHN+76QOEjlUmMK7Tf1c8G86KErOIJ+kyA1on/edKvL9H9hOWne5
    CkEmtWNNaMdE8US8/RMMmgNQIoFJLgGMYgGHCvx4lmNppv/GVpp/g91rjdRcEw0vMSNrlM
    HFYbQUhOOhYUF+dWcPIA875nZmnWcCrSTblf3epAZeXFdaVnnrpoeY61TvwqdLkMorrIzH
    8zb5OAyDD5m/AyFyDuQ0O+1bQdxCm3GZSPdxWh54JPPYBID/NCVaJ9Ix88KQ
X-ME-Proxy: <xmx:iCNyahT4B5B4GcWA9srnQmselN0s_FPqoY42vfA6sfFZshVttWbAtQ>
    <xmx:iCNyalbINghSIM_nQyOklkN0YYTsWQVN1mHGkZfwSffhYX-kT4x2_g>
    <xmx:iCNyas1GOgz6E4iSjV-oECl47QfpxeNS_suHb62L4JFaSwHbXu_YPg>
    <xmx:iCNyaopPb2TRXVdIwNW_qbZXo3E2_gQeHS1NdMiVTch-Gy3F5lDN1Q>
    <xmx:iCNyarCSTONBQm3hdbgcRZYFDgAmgTs6sDZUUG9OJMV3j6mDw2eoaOSC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 13:38:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,
  five231003@gmail.com,  hariom18599@gmail.com,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v2] repository: move fetch_if_missing into struct
 repository
In-Reply-To: <anGhtfPaGK7v3NNR@pks.im> (Patrick Steinhardt's message of "Tue,
	4 Aug 2026 10:24:21 +0200")
References: <20260715011850.3181131-1-cat@malon.dev>
	<20260716072954.582235-1-cat@malon.dev> <anGhtfPaGK7v3NNR@pks.im>
Date: Tue, 04 Aug 2026 10:38:14 -0700
Message-ID: <xmqqwlu5vla1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index 0793dc595c..74f9694662 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -1898,15 +1898,16 @@ int cmd_index_pack(int argc,
>>  	int report_end_of_input = 0;
>>  	int hash_algo = 0;
>>  
>> +	show_usage_if_asked(argc, argv, index_pack_usage);
>> +
>>  	/*
>>  	 * index-pack never needs to fetch missing objects except when
>>  	 * REF_DELTA bases are missing (which are explicitly handled). It only
>>  	 * accesses the repo to do hash collision checks and to check which
>>  	 * REF_DELTA bases need to be fetched.
>>  	 */
>> -	fetch_if_missing = 0;
>> -
>> -	show_usage_if_asked(argc, argv, index_pack_usage);
>> +	if (repo)
>> +		the_repository->fetch_if_missing = 0;
>>  
>>  	disable_replace_refs();
>>  
>
> This one looks a bit weird -- we check for `repo`, but then set
> `the_repository->fetch_if_missing`. We can probably just loose the
> conditional completely, and furthermore we don't need to reorder any
> code here at all anymore.

The 4-line comment is about disabling fetch-if-missing, so the code
movement is not even unnecessary, but it is harmful, I think.  If
the command can work without repository, incoming "repo" might be
NULL, and unconditionally doing

	repo->fetch_if_missing = 0;

may cause a crash.  But that is not an excuse to blindly add

	if (repo)

in front of such an assignment.

It gives you a chance to rethink what you are doing.

If a command can work without a repository, yet it cares about how
fetch_if_missing bit is set, it hints that it may be a mistake in
the first place to try associating fetch_if_missing bit with a
particular struct repository instance, as you must be prepared to
work with repo==NULL.

There could be at least three approaches you may have to think about
at that point.

 * Perhaps the command may not have to work outside a repository at
   all.  If so, then it is a bug for the caller to call this
   function with repo==NULL.  So we should just say

	repo->fetch_if_missing = 0;

   without "if (repo)" check at all here.  After all, the situation
   we might want to enable fetch_if_missing is where we have a place
   to fetch into, so by definition, we _should_ have a repository in
   such a case.

 * Perhaps the command may want to work outside a repository but it
   may be acceptable to operate in a degraded way.  By definition,
   when we are outside a repository, we have no object store to
   fetch objects lazily into, so fetch_if_missing MUST BE off.

   Because Git is primarily about working inside a repository,
   perhaps it may be acceptable, even when you are outside a
   repository, to assume that the_repository can be used as a
   back-up "fake repository" object, and fetch_if_missing and its
   friends that are necessary to have their meaning to be in that
   fake repository object.  If that the stance we are going to take,
   this part should probably say:

	(repo ? repo : the_repository)->fetch_if_missing = 0;

   We need to make sure that everybody who passes the code paths
   that ever reference fetch_if_missing would pass the_repository
   down when the command is running outside a repository, though.

 * Or perhaps there are some settings that really need to be
   available whether you are in a repository or not.  I think
   fetch_if_missing is a borderline case, but more generally, things
   like user.name should conceptually be available even outside a
   repository, with in-repository configuration files overriding
   them.  And it may be a mistake to force such settings to be
   stored in an instance of "struct repository" (or repo_settings
   that is part of it).  We would need a framework to represent a
   structure in which a basic setting, which does not belong to any
   repository (whose members may be the same as those in "struct
   repo_settings", so I think it is OK to use an instance of that
   struct to represnt this "basic settings that is global"), exists
   globally, and it is overriden by per repository setting, which is
   in "struct repo_settings" embedded in "struct repository".

The earlier choices require fewer changes than the later choices,
but the later choices are more concepturely pure, I think.




