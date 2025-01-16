Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929F155756
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737065558; cv=none; b=fJ58e//bnTKx+1CUPyGcN6EPcgwiJEzndd/pZr47RhcOzrLGaMAwUwu1/CXmJ5K3vD97YEQZgS+uk8jnh17QddIQNOXEF8wJ3VyVPmjw2zsvMY6j+zhGo5H/Bl1LxzCq788kBraoxl7O4HvSFahTZ8Y20nvyVy8Jg5SQJzxi4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737065558; c=relaxed/simple;
	bh=3d9yyY/fcwAmZSZXSAc/1jo3WVMIHkv5neJz25sJXvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WxB0RURp4mt/UkKDazGYUMudznQezyZC5Wky70JYADdxEB2vLme+kGMw8J2YNhhjOu0N3SFEELzRZ8aiB6KIMjLKHpww5qEhsAOzGzSGYb6Tnhn2I8oORumsbn9Lys2cQxBqpyJyTWTYk8ntUkNsQSdXkDxVpXJ0twYEUinXfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vvQz7J/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSbYZfpm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vvQz7J/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSbYZfpm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C525113802A4;
	Thu, 16 Jan 2025 17:12:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jan 2025 17:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737065555; x=1737151955; bh=Y8FTQveP8r
	rnTCScec5wLWxwYmydMCOBl3O1ebh95TY=; b=vvQz7J/zdV9gEpvGyHJ5LP03eZ
	Y9xx8VFazAPjcwcctSYS67RO07z4f+mKksAw7d9pMPazQthysCCgu2rCmeu+INGr
	IEmaT9EE8+HGvGOk1QoO+lvgrllp8WNZju9zke/BwZqK7TOzfthTqnuAK25v8bxH
	5r1R11oTbhMHhjPlFKI/hWzP+nqVSQQobywHDlWj3uK0tJ8M0mS/OKOWYpWWC5QQ
	UONNnhZlGPZZPR8YqxCHDBBIEmm0Ung2DCUgUFftFBL+DboJ5S/E4Kcr9KaQUEQn
	CCMFwaZcUAr3sJqfnJiVo+zsbfEvs0NUHoyNyBe2UfM2jct3JuaJGflvVLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737065555; x=1737151955; bh=Y8FTQveP8rrnTCScec5wLWxwYmydMCOBl3O
	1ebh95TY=; b=YSbYZfpm5JZsP7s1zVmXe682goGAQjmzDeXPJ83KA+hzGAU5k4j
	gEC/YoFTAlK3RBSQ1PokgjdA6QTEqi0X+uHAikjD+PRCyy1mC3ZIeRA/n8gNHBfe
	YssenoZqlm7qSTOlZIBvaybOkWB8GjnnghPA/7hxmxR1T8puj6FEnqFi4qbWHmTm
	mHBArtrgnx4WZDUoACw+h5pufhbA3/RAeEZB7icx2oJpdUTjEZdu4QWYwa808Vkt
	GjP4/MiuuijxAO0xR0WRRx0j7fZWL5UOtjFHtplQCmySxZ2MrldESDgXD4jKHg2+
	sJWy/ezo4A+n2cjY27mP9/EZ5ATwhFdKYQQ==
X-ME-Sender: <xms:U4SJZ2iukMpQWLtj0ru-oeURbJsx1xJapGSw1ChWyy1Qq59qY0a4TA>
    <xme:U4SJZ3DOIXzRoT9Wnm9I3ZVavOsN7yl_A7Yq77iT_fPC0hyUPvy_3BRtSVnePK3AF
    mj9LSMPArppi0R5Lg>
X-ME-Received: <xmr:U4SJZ-HdfaCmPa1Plcj5Y-0hUgWDxy6YnVpVPwEGFTRnbokutOFllZmXeQdC7Bo3hZL_fnVrb5ObAHHoUUSOkGXSNlhMJK7z-uXv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:U4SJZ_QKP1l59wkb8Q5creAfW3AT4_jEu7LSzYM3ZRaa7vWVi_YWgw>
    <xmx:U4SJZzym4pBx5T2fq4Y5AIXcl-xXtnGpEHcyorI25Ti_pbG8wLjU9A>
    <xmx:U4SJZ95LERpTkz_cVv_VzTJJ-aGAGx-LU_yPtQqKJtKpwyZBQGHSig>
    <xmx:U4SJZwxTzIrFnFXa_ht7eRIZhK0R5IkttQKv-TLqc2uLQLhUMmVUWg>
    <xmx:U4SJZz8PGNlFuJwW_RvcFJretbtqIBXDpLa6o7leWwu8Amg1RI2JsRrf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 17:12:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] reftable: address trivial -Wsign-compare warnings
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-10-bd30e2ee96e7@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 Jan 2025 11:08:42 +0100")
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
	<20250116-b4-pks-reftable-sign-compare-v1-10-bd30e2ee96e7@pks.im>
Date: Thu, 16 Jan 2025 14:12:33 -0800
Message-ID: <xmqqldvapfvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Address the last couple of trivial -Wsign-compare warnings in the
> reftable library and remove the DISABLE_SIGN_COMPARE_WARNINGS macro that
> we have in "reftable/system.h".

Hmph.

> -	int l = strlen(str);
> +	size_t l = strlen(str);

Obviously correct.

> -	j = 1;
> -	while (j < count) {
> +	for (uint64_t j = 1; j < count; j++) {

OK.  As count is u64, it makes sense to match.

> diff --git a/reftable/stack.c b/reftable/stack.c
> index 531660a49f..5c0d6273a7 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -220,9 +220,9 @@ void reftable_stack_destroy(struct reftable_stack *st)
>  	}
>  
>  	if (st->readers) {
> -		int i = 0;
>  		struct reftable_buf filename = REFTABLE_BUF_INIT;
> -		for (i = 0; i < st->readers_len; i++) {
> +
> +		for (size_t i = 0; i < st->readers_len; i++) {

Likewise, readers_len is size_t so counters can match it.

> -	for (i = 0; i < st->readers_len; i++) {
> +	for (size_t i = 0; i < st->readers_len; i++) {

Ditto.

> -		for (i = 0; !found && i < st->readers_len; i++) {
> +		for (size_t i = 0; !found && i < st->readers_len; i++)

Ditto.

> diff --git a/reftable/writer.c b/reftable/writer.c
> index 4e6ca2e368..91d6629486 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -577,7 +577,7 @@ static int writer_finish_section(struct reftable_writer *w)
>  
>  struct common_prefix_arg {
>  	struct reftable_buf *last;
> -	int max;
> +	size_t max;
>  };

This is dubious.  write.c:update_common() uses this to keep track of
the maximum value returned by common_prefix_size(), which returns
an int.  writer.c:writer_dump_object_index() assigns the value
comparable to this member to reftable_stats.object_id_len that is of
type int.

I may be more sympathetic if we were making common_prefix_size()
return size_t instead of "int" and dealing with all the fallouts
from such a change, but this smells more like somebody _else_ is
using size_t on something that is not an allocation size, and such
mixed use is cascading down to contaminate this member, which would
be perfectly fine with platform native "int".

Ah, OK, an earlier patch does change these other things to size_t,
so this must change to size_t to be consistent.  Shouldn't it be
done in the same patch, then, though?
