Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02414F9F9
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465154; cv=none; b=Xz0Va5OnaXmOU6vVvr1dVogCTnml9WoscLTm4umK0Eg1DG3x9RMryLrtYC6o38qN8OLJdL3Bwhqh13ZKF8q3KPhtElsJmGskMURqYE+/DUw5aL0xR/sTOrxtzDUykl7/Xki9DeuRhn6OvAFAPbZm2M538gXeUbND3HuCzNDMA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465154; c=relaxed/simple;
	bh=ccpuHowleCyo1PpafTfW/wNw7vKIQHPo3bsIeqlmvSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XZcb/O4bjMlssxZj+iGXPMBl6eTVXu8dqyCj2DrPhzNAuOVEJsIU6T7UudyhFPjo7SBvOUmx2pdpygZvHY/kJkpmoUhyhn/bA34kh/wHNI5WyJs5TkzLrClmMLGGW7KfCKS5jTeSMVnPz46dRgzGTvWt3+5TQqhtiESDwfUNgms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YF2GjL44; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YF2GjL44"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1C663C71D;
	Wed, 31 Jul 2024 18:32:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ccpuHowleCyo1PpafTfW/wNw7vKIQHPo3bsIeq
	lmvSA=; b=YF2GjL449HBMWCTPAU+B5unajxwrzor1QZMaLirgor3yYsOfGfRyGT
	I7Wu7CbwYkqH0yz/X8nP+EpGbTrFTimoreksMZ0UuUsy3ypJpBQl/aJK5VYWmc/i
	o4b+YLGTmj6Q952qSdNuaUtRAmxaEU/m4X3p02pUkbX9XbN9K/yVA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98BE13C71C;
	Wed, 31 Jul 2024 18:32:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC99C3C71B;
	Wed, 31 Jul 2024 18:32:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Improvements for Perforce tests
In-Reply-To: <na5mwletzpnacietbc7pzqcgb622mvrwgrkjgjosysz3gvjcso@gzxxi7d7icr7>
	(Justin Tobler's message of "Wed, 31 Jul 2024 15:50:32 -0500")
References: <cover.1721740612.git.ps@pks.im> <cover.1722421911.git.ps@pks.im>
	<na5mwletzpnacietbc7pzqcgb622mvrwgrkjgjosysz3gvjcso@gzxxi7d7icr7>
Date: Wed, 31 Jul 2024 15:32:29 -0700
Message-ID: <xmqqh6c5yyyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C5F9C0C6-4F8C-11EF-AAA9-BAC1940A682E-77302942!pb-smtp2.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> From looking at the range diff, this version looks good to me. Thanks

Thanks, both.  Perhaps I should mark this for 'next' by now.

