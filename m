Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC314A08E
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522813; cv=none; b=PUmaeoyHrB3YdNWrrsyhhBmX7izK8u63zx5mQATVtoucRKANXz9ok3RRANeO4mmCrWYR2H8GFG+VMMjK5Fk1WL1KFiomXy6Ry5ZIu+CCCgAsPAjasJybzveBX93Q6L6EMcJLT5SwZ7X/u4e1JXdv15qsi/16VdZWyfUNu4hnrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522813; c=relaxed/simple;
	bh=diQ1oXaK1Ss5hswQrxsE5zMHNqcAhXxXhj0uFTxmlg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uf68v6GZcgqgFEmXOVAd6ubbTAWZtkJDrGNkSm++ajgYhg0HQoE170qoQ+kksfCUxZ5iM4uQfIDAFkEkBujSbtla8l/SrsWJt9fwM+/zDkQ9KWZ8zvekqn4L4vO9qNeZmNFb5taxMszbUsLI1DQB8NlVCRC9pSDdWY4Mj3nsKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wlD0S9xW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wlD0S9xW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B268238ADB;
	Mon, 16 Sep 2024 17:40:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=diQ1oXaK1Ss5hswQrxsE5zMHNqcAhXxXhj0uFT
	xmlg4=; b=wlD0S9xWYd59tJiHy0vRgRRPk6fCvyRO4DCWY+gccsceGyCsTTZ96Y
	ShHS6CCkR0IFUH/8sJDr0IhXuEeFi4n5VKnLc1Man12lPvwwJaGt5Qn1TJKcxZFw
	fymhIKeBNAQE2kzDVjDfGY6wswg7mzIYc7QI7NUFH0xgKCUyZ8GBs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EF7138ADA;
	Mon, 16 Sep 2024 17:40:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E6C138AD6;
	Mon, 16 Sep 2024 17:40:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] apply: refactor code to drop `line_allocated`
In-Reply-To: <0427cb72507bba7ed62d13a5523fea351a0cb35f.1726470385.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 09:10:09 +0200")
References: <cover.1726470385.git.ps@pks.im>
	<0427cb72507bba7ed62d13a5523fea351a0cb35f.1726470385.git.ps@pks.im>
Date: Mon, 16 Sep 2024 14:40:04 -0700
Message-ID: <xmqqzfo7l1l7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E5835DC-7474-11EF-B91D-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> former member is the one that should be used throughougt the code,

"throughout" (I'll amend while queuing).
