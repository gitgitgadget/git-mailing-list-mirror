Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB517579
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402096; cv=none; b=TRZVO+RQpEw3LoKEm9f3UbHqiPi8HNSQ28MJbm1EnkEJdMHqWl3Drp4vDSzbSL29IrfWb3/oIzzZYeq3tgrNPi9eep+XzJWrwbgBvXfuplP4hjAmCwsw43RBX8kigTM3Ht3kkEbO9gPS4Ho9k2pK2xkoHM8rMTis6pqEJ9bZxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402096; c=relaxed/simple;
	bh=/RmZ1tIHBlervuxLg+vOoFSa2Ij9y0rNA7oT6XuGAh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GDIJDgBYf4Uj4/aZZlbmNdMe8CEvfA7R8P6PfPQyvr8IcsVs4hu5Bb/zoHUAXtNOwkkPQgQbGIXZRW/TGzbRUWEh9N6c53biBJADXNWpppCcGb47fvIV2f2eJUwDHVh70GRsveaMbwH9hHvseyZmCRwK9196qCADpuAPiOLzRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E1//LIMC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E1//LIMC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 350541E906A;
	Mon, 25 Mar 2024 17:28:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/RmZ1tIHBlervuxLg+vOoFSa2Ij9y0rNA7oT6X
	uGAh0=; b=E1//LIMC4QvFsYvysdupiuSkMigpgcR5KUOQdWFm/1EzHj3RwegMxB
	3n8GZP4BKZ0ApXilVRXdKBvU5hpr9rARmhZrarPNIEL25zTWrEfTsEEG1MenbODe
	p7fy0z+OZUmK45ZLPgMQqR0J7cd43AD57Rq5KAdKuQ76jstXprQVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D5A11E9069;
	Mon, 25 Mar 2024 17:28:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90B121E9068;
	Mon, 25 Mar 2024 17:28:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  jn.avila@free.fr
Subject: Re: [PATCH v2 1/3] grep: perform some minor code and comment cleanups
In-Reply-To: <ab5145b696565ba170c90e2fc1b9a7e1@manjaro.org> (Dragan Simic's
	message of "Mon, 25 Mar 2024 22:17:40 +0100")
References: <cover.1711302588.git.dsimic@manjaro.org>
	<55867253d2925892f5192dbc3145f7bc9221b791.1711302588.git.dsimic@manjaro.org>
	<xmqq5xxahvmi.fsf@gitster.g>
	<ab5145b696565ba170c90e2fc1b9a7e1@manjaro.org>
Date: Mon, 25 Mar 2024 14:28:10 -0700
Message-ID: <xmqqr0fygfx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 94E3AC8E-EAEE-11EE-A186-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> That's fine with me.  This "experiment", so to speak, has also taught me
> not to pay attention to making the code "neater".

True.  You should not give too much weight in your sense of what is
"neater".  Spending cycles on something you can measure is more
productive.

Thanks.
