Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F3B661
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392084; cv=none; b=RazMwKR8/XHl74t5VBkipzFxnf4c4DUdYXBF4N8I3G2CzIxWHsfOkqAUARdkTNSJaGlh3W0+Bd8K0q4SPImA3svE9K8abFF23FwBR6mYJCHGz/Kr0b2fhx5yPh89qQwHfaboHuvW27AgR4tYYTVV6D0hA/4Zs2XzfojWiiEoPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392084; c=relaxed/simple;
	bh=aqs112uXKOtrGxzy4zxPePQ/Z19aLL8FUYR+ibopJJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N/SkN+bA3WZyPdRp2cqnK4gGLa4HuY1v4teb9xmWGtOpIZxP56+id0B2nsVrErxhFivCX0eT57Z4S0ayc+Gr0aTbrskTmsgWb7LlCMXW+trADCs7ebIRWHO75zOUjEHTMMcBwEbDxY/oI8e2clMBYAnfh8qTaaoIOqhEDdT1ALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l8U0P6F0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q5pj7yoa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l8U0P6F0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q5pj7yoa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B134EC020A;
	Thu, 24 Jul 2025 17:21:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 24 Jul 2025 17:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753392082; x=1753478482; bh=ovoIVjFiff
	tR1fsQzFrg80YLNn9mH3N8Lgaw31XJqt8=; b=l8U0P6F0CcMWPetncqZOJYxhac
	lOFr2ANn1JbumoT75MxOD8x82MuR5q218bEcMKOn8x2HlD8H0D4Fo9WNfjgEt80O
	qV8qvM7r7jPN4N+lwm8VElku1ZXfC9JdO2sUXVLNgb1KElEa4tMUhweGiJMP7JnS
	pwRQiMxBrOa2cbDoxGoEicFZF+PlCwJbnLwokJ0/+J8iJkNSsRk3FTfURt6N0SfV
	+f+xvKQlmbT3zZ4+ffLJklkmeX5viM9cNB67HhYLjqN2VcH9rwU5IVe8ExYVVkRg
	t+p60DKD/Fk8kIJCzNq+nGbZvvd5QeEq5YTKWFtk//9shlDxVkzD1u511N0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753392082; x=1753478482; bh=ovoIVjFifftR1fsQzFrg80YLNn9mH3N8Lga
	w31XJqt8=; b=Q5pj7yoaNw8p5V/K38gvU4Chiy71Cq20cY57991pvCaUIV40BQC
	nreou7CkeDih5YvoGdBlEAAD93zAZGt7vyRADMRgyoef18vBh144LveCXKHmXHC+
	uyDryweiSGiUuDXgQpWH0P75hWu7IUTrfQkdr7mmRKah757/6rqqlzvzywQMiU2L
	7zfnrf0QC9Ekr/eXApD7SGPRWnm9YtdSXkeT0vD6TPHP6ZgS8zQhUqQ24z1go+DM
	uSYXUpXnZzmO5VZpelfeXXdDAv+qKsKcaio20m2iys8nE/JfFWY/JBpFxcncZZBk
	FsbrIYjoFplORMeoxRSzVOzMgBpDhqZXLHA==
X-ME-Sender: <xms:0aOCaBJFsVGFAYTEm76zlIoM6h9BhObHrwbohDygZonCmZLRUSg2Fg>
    <xme:0aOCaAadnokSLx-dzv6Smkr_9e9R9o3hSKSPlihODDWXuak9Cs2iA40-DI7wxiYaN
    iR-AqMRsyaUTm_6aA>
X-ME-Received: <xmr:0aOCaDLD7vfDsWs-V4yRkSoezl5J8i-cJ3zSUtmqUmWHVfr8mBBYMfaFARcV7az6YzM_yBnAy1_74ggjhb_xgxdNrVOTAmqYRbQk2pc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeufeeluddvkeekgfeftdejhefgtdevhfduheejkedtjeelkeegkedtieeiudff
    feenucffohhmrghinhepshhusghmohguuhhlvgdrrggtthhivhgvnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0aOCaOCDgczqnKxtZVHHnV1i7e2s8_wlZqROAUKUbi23F7WX75pOfg>
    <xmx:0aOCaIrnsUykLTnuNhSNJhT8MPSHWrrxR8A4m-6Xf0aMcoLfQeIzxw>
    <xmx:0aOCaJib0Ar5KSg7Ir2UgticsqUqZ6qQ213VtQS24AOBec27xP3GPQ>
    <xmx:0aOCaFCQ66n0l1cjjcxiaBmi07krkwPXniExMb0MzBeduJ2AchDWyg>
    <xmx:0qOCaFH3QIeetuiDLAnV5p_noJprL7CUBO2fFXi2LUW523_mJ3DRfSnp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 17:21:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule: skip redundant active entries when
 pattern covers path
In-Reply-To: <20250724152418.45226-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Thu, 24 Jul 2025 20:54:18 +0530")
References: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
	<20250724152418.45226-3-jayatheerthkulkarni2005@gmail.com>
Date: Thu, 24 Jul 2025 14:21:20 -0700
Message-ID: <xmqq1pq5z3n3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> @@ -3308,6 +3310,9 @@ static void configure_added_submodule(struct add_data *add_data)
>  	struct child_process add_submod = CHILD_PROCESS_INIT;
>  	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
>  
> +	const struct string_list *values;
> +	size_t i;
> +	int matched = 0;
>  	key = xstrfmt("submodule.%s.url", add_data->sm_name);
>  	git_config_set_gently(key, add_data->realrepo);
>  	free(key);

The blank line should be between the end of block of decls
(i.e. "int matched = 0") and the first statement (i.e. "key =
xstrfmt(...)"), not there.  You probably do not need "i" in such a
wide scope; just use

	for (size_t i = 0; i < values->nr; i++)

in the only loop that uses it.

> @@ -3349,20 +3354,28 @@ static void configure_added_submodule(struct add_data *add_data)
>  	 * is_submodule_active(), since that function needs to find
>  	 * out the value of "submodule.active" again anyway.
>  	 */
> -	if (!git_config_get("submodule.active")) {
> +	if (git_config_get("submodule.active") || /* key absent */
> +	    git_config_get_string_multi("submodule.active", &values)) {

Hmph, do we need two calls here, or would a single call to
get_string_multi() sufficient to learn what we want here?  When
there is no such key, the function may fail (or succeed and leave
values->nr == 0), and either way, we can tell that there is no such
key, right?
