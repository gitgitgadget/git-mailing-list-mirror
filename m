Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288FC2C8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083670; cv=none; b=gkQ+7VI/HKx3H1mcmQfJZnX7TLKw64TGLHPsTABNdzpO9O6590ZdfI5hoBndNdsXpuB73BC5OrUcEBQJAx8oCLmK/LdMHDnnLzRfsr+uEkrf5FBOJoENb5ZS37htEcvgoVz8TgfvzvDSYJe/ryJFBw0LgqRp3F903FlzN611Hjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083670; c=relaxed/simple;
	bh=4Ft5+3EI7DCf14sT4RYURMhn8ihlVU9i+xYb/59uQho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rskJGzmZDhfIO1QtyRflcqc+PRmMBS+dr9U1Vp+QpdvU1EpwjvPBJYv45XlNS8pXa/5dThLXqvFJEaCKMw3tQd9fQMCtQPXrQjYD2lX7KJkFi9eUEkGxCVePolVlKKxRrvFswHsqriivMiE4dbAkH8hpOrcz/tUJFyr3HsvBIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dfeV2Pcl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dfeV2Pcl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C351929899;
	Wed,  7 Aug 2024 22:21:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4Ft5+3EI7DCf14sT4RYURMhn8ihlVU9i+xYb/5
	9uQho=; b=dfeV2Pcl7QxdXz4p711u65CVW2q53x38vnRpvaDEbwabuMzVRDdxgm
	hRXQ9FKj8CG7piPDn8kF+SzoitVxVIYagIRYdAaa9CeGMFxDDp8CgP9Sigt1/vC6
	GlWAOXM/G7Q5LpdmDKUKPwneo74s3Iar9e3bNqmtXMwTKGzUNrw/k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA60D29898;
	Wed,  7 Aug 2024 22:21:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A8B429895;
	Wed,  7 Aug 2024 22:21:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  calvinwan@google.com,  spectral@google.com,  emilyshaffer@google.com,
  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
In-Reply-To: <ZrQJe32sYNOTSJGf@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 7 Aug 2024 23:55:39 +0000")
References: <cover.1723054623.git.steadmon@google.com>
	<9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
	<ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
	<b5epjlsptw3punygmx2abmfnrkki6n6ta4fk3yse7iodlabr63@zss4z3575r7v>
	<ZrQJe32sYNOTSJGf@tapette.crustytoothpaste.net>
Date: Wed, 07 Aug 2024 19:21:04 -0700
Message-ID: <xmqqo763lppr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DDEC22AA-552C-11EF-909C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think if we're going to be writing a general purpose API for
> libification, we probably should provide free functions.  Normally, that
> will be a call to free(3), but in some cases we may need more complex
> logic, and by providing those, we're making the API more consistent and
> easy to use.

Do you mean that we should have variants of free() that are specific
to each data structure?  E.g., Patrick taught fetch_task_release()
to release the task structure itself, in addition to the resources
it holds, while renaming fetch_task_release() to fetch_task_free(),
with ff25992c (submodule: fix leaking fetch tasks, 2024-08-07), so
if cgit-sys wants to expose fetch_task object to the outside world,
the consumers would call fetch_task_free() on it?

