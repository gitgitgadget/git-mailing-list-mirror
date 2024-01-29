Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E706F071
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552903; cv=none; b=R0US5biiQBLYsn565loA+fqmlB4ZcFvPWYuae8QKp2b+vpZZxzmmciOVVWIy6ZGsZbf+Ji660fm9Pe22lArAaeThxc9lQag/3N544ScITe4NnYXKSXBlD2zEZq5Lh4IgCRTGDAsMpD9ZTOSQCjyUXEdfGJZg/PudtDoNR6M/dEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552903; c=relaxed/simple;
	bh=2nC5vsp5EOj6qpzw7enX7uGu5+XLDhwj43YxeIlTHAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dLLuaDa6dTcAfBmp8zbyi/fjndDncqT4lpA3tmHYE5n2lp6/bzxou2mtJ+qlfJhc3LGPU23NI53e+WtxThb+KAM0CLyuh2Tq+yzEbYkTjgwaMerFE92BGgXAmrhp2LgwDSV/5Mx7ncEHb55rfLhpOXFjcYyfxBrIhjoXMUYFheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bT+AJWrG; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bT+AJWrG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A0C0E2069A;
	Mon, 29 Jan 2024 13:28:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2nC5vsp5EOj6qpzw7enX7uGu5+XLDhwj43YxeI
	lTHAQ=; b=bT+AJWrG13MMne5967Qpmi94L2stkUB0ykdajMQaX6EpC7iSVPan5x
	ac3MffjP9SHfUVeWJC7t/BQt8apy+yCdVgz9EjJDMlXUh0ARjEXPjh5DL1wTwhn6
	YQkRNU7zpmlYECN98C2nqg+FpVdLjPcw8mnDfAQOWehV+grmi91gw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9946A20699;
	Mon, 29 Jan 2024 13:28:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 359DB20696;
	Mon, 29 Jan 2024 13:28:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] config: add back code comment
In-Reply-To: <ZbeMw5tgY9S6k6y6@tanuki> (Patrick Steinhardt's message of "Mon,
	29 Jan 2024 12:32:19 +0100")
References: <cover.1706466321.git.code@khaugsbakk.name>
	<48d66e94ece3b763acbe933561d82157c02a5f58.1706466321.git.code@khaugsbakk.name>
	<ZbeMw5tgY9S6k6y6@tanuki>
Date: Mon, 29 Jan 2024 10:28:16 -0800
Message-ID: <xmqqil3chu4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C66FF08-BED4-11EE-B619-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>>  		if (!given_config_source.file)
>> +			/*
>> +			 * It is unknown if HOME/.gitconfig exists, so
>> +			 * we do not know if we should write to XDG
>> +			 * location; error out even if XDG_CONFIG_HOME
>> +			 * is set and points at a sane location.
>> +			 */
>>  			die(_("$HOME not set"));
>>  		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
>>  	} else if (use_system_config) {
>
> Thanks for adding the comment back in! The patch looks good to me.

Yeah, thanks, both.
