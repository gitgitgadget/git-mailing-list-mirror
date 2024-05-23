Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2A171A5
	for <git@vger.kernel.org>; Thu, 23 May 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479912; cv=none; b=Y+padjfIT2njeky2/wSCKcYIFKSDry6sxErS6JgrULt94f2D+Z+2L3myJ6ZQdiUv6uIiRjMXH44VUHM9mvuzNftweJqDmiNUeumaoLjnbTnX0hiqC1Avb5m3a2Ws8nCDIwXBCkxKcQo9sSfEhM8jtyk9bNuxYILEG5qcQ8wt2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479912; c=relaxed/simple;
	bh=NsGVHNTJsRhelO+CuIkFbOULS/S4CdqllU0IFA4FpjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rf86GTge9jPX+NVl/rLQTQs6bvYXNxKwhtl3GwFHL6uoXxaqcOHLOqnZDMoOmFjAlKMk0Bf1tgmIy5XTNNRf1qGfQ+m0GsC+wMXnjdsPHn3cZ8csrRHoO2uaGFSBL4wsyjCtyEDodeVskjTH54tyDaKdY2LhXZ12RenLbHvquqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ab+g+YsF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ab+g+YsF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EDAB920C7E;
	Thu, 23 May 2024 11:58:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NsGVHNTJsRhelO+CuIkFbOULS/S4CdqllU0IFA
	4FpjY=; b=Ab+g+YsFdngNGGnWWcBqHRWyfcU5xZGQOkLUtIiPpXwRUuiCCRDnBg
	0obpVO5AYh+xRtj9r/5sazrjK4mpOwW+wct8tL9+nVg0eI+Bq1wdvTlmGrmlHO4m
	1RKFXuuYMdaIwnfQxN4+SdJdWUlMz80a/IPfGosnK1i7bN1P31qHo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E595020C7D;
	Thu, 23 May 2024 11:58:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 91A7A20C7A;
	Thu, 23 May 2024 11:58:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v4] add-patch: enforce only one-letter response to prompts
In-Reply-To: <Zk7UsJjhY_FV2z8C@tanuki> (Patrick Steinhardt's message of "Thu,
	23 May 2024 07:31:28 +0200")
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
	<xmqqikz56a6o.fsf_-_@gitster.g> <xmqqh6ep1pwz.fsf_-_@gitster.g>
	<Zk7UsJjhY_FV2z8C@tanuki>
Date: Thu, 23 May 2024 08:58:25 -0700
Message-ID: <xmqq5xv4wme6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A7AEBBE-191D-11EF-9A1F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>>    As an experiment, this message has the range-diff at the end, not
>>    before the primary part of the patch text.  I think this format
>>    should be easier to read for reviewers.
>
> Huh, interesting. I do like that format better indeed. You did that
> manually instead of using `--range-diff`, right?

Yes.

To me, "format-patch --range-diff" is a lot more cumbersome to use
than running "format-patch", open the result in Emacs, and then
doing "\C-u \M-! git range-diff ..." to insert its output, as I'll
be opening it in the editor for typofixes anyway.



