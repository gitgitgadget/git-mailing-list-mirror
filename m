Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B9145324
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401631; cv=none; b=SWzg5O4nwg3MUwtT/7h39Izd4aWSvwURHldmLJjXYKD0FNUNCeoojJ7/xJ+pBbboE3Cbd9l4X0NhUQG/98d4dKTRc/4NN/8txnKT2bjoi05IpOS9nr1PY05D3mYl+KV4FJlaaTQ/0zZTvallNzl0pE+KATqZKkjUqa0odtRqpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401631; c=relaxed/simple;
	bh=+p6lJHTxdIDjRjJyvFRDKrneAQudyMhVg8CI5lGHLoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pfYgu/As3vJIU1+w6HWM3McfyZousEELZ/L4z4hiX/L30x4zend2lLiNhyRnzsNWraT268NQE5ATLMZY9Ic0YdO3pA1g+iK5SMOKMCTR5oUOEDx+vtEtV8UzyPioPMLRrip9LQkAowr2nDVpn/QdHtihaBHkZB3CE6mOSmJhPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iZW/3xr4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZW/3xr4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 871B31C83D;
	Fri, 19 Jul 2024 11:07:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+p6lJHTxdIDjRjJyvFRDKrneAQudyMhVg8CI5l
	GHLoE=; b=iZW/3xr4a4xY7h7Fjm/tK0lS9DXHNFjAAFO37s8B01Wo9fMUjsYzwE
	7aCXEwoWNeS85xomkT1hsSQnv4vwR7uJdO8MrpNylCgKvg/ectmcW6aT9YQyjqir
	X+7rIlFPwn2E8Mi6NP+WUvR/qVgRRk+lPYACQg/EzmizZXEmo56GI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 801A41C83C;
	Fri, 19 Jul 2024 11:07:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8175C1C839;
	Fri, 19 Jul 2024 11:07:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix bug in revision walk if
 --exclude-promisor-objects is set
In-Reply-To: <20240719093435.69238-1-hanyang.tony@bytedance.com> (Han Young's
	message of "Fri, 19 Jul 2024 17:34:34 +0800")
References: <20240719093435.69238-1-hanyang.tony@bytedance.com>
Date: Fri, 19 Jul 2024 08:07:03 -0700
Message-ID: <xmqq7cdhl8tk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8F913D3A-45E0-11EF-9401-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Han Young <hanyang.tony@bytedance.com> writes:

> We use --filter=blob:none to clone our large monorepo. After a while we started getting reports from engineers complaining that their local repository was broken. Upon further investigation, we found that broken repositories are missing objects that created in that particular local repository. `git fsck` reports "bad object: xxxx".

Please wrap overly long lines.  Unless they are wrapped down to
something that can be quoted in e-mail responses a few times and
still comfortably fit on a terminal line, e.g. 68-72 columns, they
are just unreadable mess.

Thanks.
