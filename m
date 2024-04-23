Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6C86254
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912084; cv=none; b=ugRzs7ofZRBKGjJynLcsOG+v11C5TcDGDj5oPAGP38bS4aT1mTg1+oumefX62I4kEfJS6LXFtkCfmyowGw4Rrkt23+v7LF3QA8z32gTkorWT2NbzyFImb9mX7fqTv7zXGY+IhTjXov6H5KfITAUJqfxcVPW/llJmJTkEGa33Xbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912084; c=relaxed/simple;
	bh=7ee7yPayj9GuPXaNIL+hS7ULkRAiDuNsfP8teCA9/Do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XnuUhqh99zONEA/XMJQUezQRnmB5OUMcxvckBT/yxtR/i3eDg87yw9NXQ5bdDqzWFcCKh7dsqlN2PdtkWMmFPq+62U5inqidXHiHDD447fZPFiU0vDJYp8hRjE6CyMhtqNSoSLKMODtNkNQqjoC6AQ7RGpc5iH0CEGB4vks4trA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hNbWq76Q; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hNbWq76Q"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B2081A8C9;
	Tue, 23 Apr 2024 18:41:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7ee7yPayj9GuPXaNIL+hS7ULkRAiDuNsfP8teC
	A9/Do=; b=hNbWq76QQadTmcoBWPYJgrnspgLrBq4pF/g2PlqLe1IYynwTjboM4M
	VqwIH2mfxw7meWTcG9Fm8d+HbWYwPUHBr3TdQ7uP8OdV5n0YK638MUm5d6OSJ78S
	bcGbxa+riBn+qwplZ9AGcIscPWlUEh1FY6uTc/gYjgg+xlmw8AYJI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 828AF1A8C8;
	Tue, 23 Apr 2024 18:41:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9A8C1A8C7;
	Tue, 23 Apr 2024 18:41:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  avarab@gmail.com,  christian.couder@gmail.com,
  me@ttaylorr.com
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
In-Reply-To: <xmqqy195t794.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	22 Apr 2024 14:30:47 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<xmqq34rmi28h.fsf@gitster.g> <ZibSUPezSU3ZV1HA@google.com>
	<xmqqy195t794.fsf@gitster.g>
Date: Tue, 23 Apr 2024 15:41:19 -0700
Message-ID: <xmqqjzkn66sw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B21872A-01C2-11EF-913B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> As I said, I do think it is rare for us to start with only "ideas"
> without anything concrete to comment on, and that is why I asked
> some references (e.g., URLs into the archive) to a discussion in the
> past of a larger decisions where (1) something is proposed, (2)
> discussed, and (3) declaration that a consensus has reached, if a
> document describes the status quo.

FYI, what I readily recall was the discussion that started here.

  https://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com/

It did have a few iterations and then near the end the consensus has
turned into a "patch" that adds the design document to our history,
but otherwise, it did not involve a "series" level patch reviews.

HTH..
