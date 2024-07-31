Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336238DEC
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454616; cv=none; b=NLUGL72+Kqf8bETUBti4dv/otH/hnKPbJlgXWsXofLca7tQgGYxlYHBT8d1EfwJjRQkRawlLx2gMT2TP1qqPGao5g0icexuzrKxl8lCiR3/ka3ZRjbRZy/ux+mqGA63+A84kJhJLbf12ep9p6V+naijGUX2KuTrsQs202HSp0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454616; c=relaxed/simple;
	bh=q8AlTG7LJY28WvGRxsBn9lzrzdzcMHdAu5HsDuQmhBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FYpySmkTHhgh7+eYIu23gZU8Kw6NNV/4G9gjPZ4uCDcDAQmgwNVd3+bEPk2MqE6noWowiP0s22uHsDmE/gdrrmoAwmSOAyLwwXmiX86k/Z+3WmEXG9NCNcEUM5y5fneG9S2oGU6JNc3gT9doU2kQJb/3OdF1daSeOv0fMuDsgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JEfvI8Sr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JEfvI8Sr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 90F243B291;
	Wed, 31 Jul 2024 15:36:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=q8AlTG7LJY28WvGRxsBn9lzrzdzcMHdAu5HsDu
	QmhBQ=; b=JEfvI8SruGW0GUDpjpEQPYCPI+/oPhXrqeLXEXEm/ytCoR5nqq6/HR
	sZ7AS2San8yfok7575sAGEwtIqaUtM6kdWaMTYFcf66k0lzmLUe1IfSXXqVLGLYe
	N4L6446OOglfLSnpYSyqTFAbGFEcjiO5Nwv/zWY+qEvKirYGYVizc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 88B173B290;
	Wed, 31 Jul 2024 15:36:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3AF83B288;
	Wed, 31 Jul 2024 15:36:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Kyle Lippincott <spectral@google.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/3] t: import the clar unit testing framework
In-Reply-To: <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
	(Josh Steadmon's message of "Wed, 31 Jul 2024 11:27:13 -0700")
References: <cover.1722415748.git.ps@pks.im>
	<b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im>
	<463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
Date: Wed, 31 Jul 2024 12:36:51 -0700
Message-ID: <xmqqv80l1hgs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3D031E1A-4F74-11EF-88F4-BAC1940A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2024.07.31 11:04, Patrick Steinhardt wrote:
>> Import the clar unit testing framework at commit faa8419 (Merge pull
>> request #93 from clar-test/ethomson/fixtures, 2023-12-14). The framework
>> will be wired up in subsequent commits.
>
> Rather than forking our own copy of clar, could we just add it as a
> submodule instead?

I doubt that forking was Patrick's intention to begin with.
Convenience is.

It certainly is a possibility to bind it as a submodule, but it
would be easier for everybody to futz with and experiment, at least
while it is in its RFC phase.

Thanks.
