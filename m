Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB0B14EC59
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498685; cv=none; b=icmR4UoE6E5m9QRjUEw+258ecYd+5aOL8RJcdPaeDhtvnjcBXIcn4kbR2Jev85lbh8fOC65W4W470ZNnYXv+SwTkpDgE64Jbf3XLI1DMi0ybtqlufUv0C5LVtamETggcocfSKktnmpBDn6adr4tICOS9cKogXsUtTRJWhP6wgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498685; c=relaxed/simple;
	bh=xcklNg1VI5bmZe4dkrod98k1xq2zrM7Zv2alj6xt/tI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EkWkSKlyTYViORIaew7yxLeLKQ/bj5W3A8TimEaTWiRHIeBgIEuZ03mFoOce3rTSL6Fbv3xtorvkr4IMIRyp8PARAYPBTUTnaVpF9tHHCQjed5UCv1rGkbU4DvrCYq20xsJY6buh6W54JtrEq4Oj40D4W64XZuY5Xhsj1LNK/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MIey99PF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MIey99PF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C314D3EF23;
	Mon, 12 Aug 2024 17:38:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xcklNg1VI5bmZe4dkrod98k1xq2zrM7Zv2alj6
	xt/tI=; b=MIey99PFUL4UYiPxTkp1idL0BUD8blRSGdKXO+Stecx4VOOIxnKhqJ
	LZqEPRinfp20AwV1wC63ZUPyO4I/cPgXlu++XrXS/xXMoHHXfvrYUfqmRvoKiDR3
	EPhkGA4PwU3ZItPO9kPXQWUHR6UBuq2nxN5v166sjvdLE/Q9irEl0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BBC343EF22;
	Mon, 12 Aug 2024 17:38:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 032023EF1F;
	Mon, 12 Aug 2024 17:37:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Dragan Simic
 <dsimic@manjaro.org>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,
  git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <rt4ruismrzhtkbry4kuube5fwf2zprajjen7wagl5nyyjivhvz@xuxq6paidcmr>
	(Josh Steadmon's message of "Mon, 12 Aug 2024 14:24:03 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1723242556.git.steadmon@google.com>
	<Zrdn6QcnfmZhyEqJ@zx2c4.com>
	<6398d60387a6607398e4b8731363572e@manjaro.org>
	<CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
	<xmqq5xs688cz.fsf@gitster.g>
	<rt4ruismrzhtkbry4kuube5fwf2zprajjen7wagl5nyyjivhvz@xuxq6paidcmr>
Date: Mon, 12 Aug 2024 14:37:58 -0700
Message-ID: <xmqqmslhzakp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2571D63C-58F3-11EF-B6CB-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> I was avoiding addressing this topic in the hopes that folks might
> suggest additional name options,...

I've seen libgit-rs (or was it libgit-rust?) suggested already and
found them reasonable.  If libgit2 folks do not use libgit_ prefix,
I do not see any reason for us to avoid it, either.

Thanks.


