Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D625601
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430482; cv=none; b=bBzo37yeUWXfkobw7c+USs7YPlEsxNU0RPsF7llgJezWrckd6Txmm9nMOlJgvQlj892fuLCrXf8+RTgAuwSNsNHTNwnJzft472dsEHvlqbMt1gnB54+p5m6wUAEeV4H25+abiQClJRGwwPU+YWSoyTUjtG4JCPILoD7Vk39dn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430482; c=relaxed/simple;
	bh=7BxciWb74Glgk1n/iH1VKoxzE1sSq7UGWra2wLXoUwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kf1H95LYWlJkvTOsa8ejbO8A9wUYZNwPiQHBf7xIdCO/4e8hrB/mrlq5Erb0BuFZO5sirr5iSlOLGLheBRMebkDYABYd47mm26RLB7jNaNKcJMFuKg2YDW3LJnsZ8a1ohm8ibk30SN44Q1xHjUa5Dl5+PbER2zOQwHNwanKFhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MiqzFEn3; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MiqzFEn3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57B7633890;
	Mon,  3 Jun 2024 12:01:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7BxciWb74Glgk1n/iH1VKoxzE1sSq7UGWra2wL
	XoUwA=; b=MiqzFEn3bL4VdOOCnD0lIbI9UtjE6zDjSrxXsQ6xVdltaZmofQtJbM
	GYgfj5dHf2bU+UMO+PvM7lJTCUJ1sNPhSnqOdQ/f1L8bXzp0rpiIPVxPzNYBmKNl
	cPJrzSvu/ILYlPLjOKYHnIr++6F6tNv10l7ctQypgtvJkkV6LWhdI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F9A03388F;
	Mon,  3 Jun 2024 12:01:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A46F83388E;
	Mon,  3 Jun 2024 12:01:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <81d52b31ce4c287765a43d87d94f526b@manjaro.org> (Dragan Simic's
	message of "Sun, 02 Jun 2024 19:36:37 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<81d52b31ce4c287765a43d87d94f526b@manjaro.org>
Date: Mon, 03 Jun 2024 09:01:18 -0700
Message-ID: <xmqqcyoy6mnl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 842FFAEA-21C2-11EF-A4B1-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Thus, when piping to a custom program, the escape codes that
> perform the coloring should be stripped.

I tend to agree that if we do not give a way to toggle between
"with" and "without" color when piping to a program, it is safer to
make the default uncolored.

The user's configured pager is expected to deal with colors just
fine (or the user has globally configured colors to be off).  As we
are capable of telling if the user is asking to spawn the default
pager (by not giving a custom command or by clearing the previous
custom command given in the same session) or a custom one, it should
be easily doable to give colored version to the configured pager and
uncolored version to a custom/one-shot command.  Unlike the existing
support for (e)dit command, we do not read back from what the
command does using the hunk and present it again to the user, it
should be a relatively easy and safe thing to do.


