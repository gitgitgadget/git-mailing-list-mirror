Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB617799B
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804464; cv=none; b=DTJj+4EwTq5slXqE2pFFQGasU4CZ7d016p0mSJnIs7bqCvC4IbTylodC+5K+6iCVay2WNafQIT41BkpZDtit8lYLUuytoGeG/3x1tqS+QfyFhkZ6V5ty7aIBoRTlYCJTflblyweu00wppEQoJmwbDkPQm3tRvrX1JhmI7jqb8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804464; c=relaxed/simple;
	bh=XKUSyHCfvI1q2nTXcyjA4jEdfwijguqWHXPPRL01Xsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WKkJiXCJkIBtLQtr2aG37bwgRbxWfwQRXKURVMuYU2GbZgIFV9eZonLXxFmOdGdixs3l0kXeLZu/WfU4DT9HrBgeCRp1sDjUhEl8/u6feHojFBtsgd2JYItzzKvqcH2LV/MIwBQKWwwmJCWFd2mIh98mbKESjbcZiWFQKUxT3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XOVbLJvS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XOVbLJvS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B587A332B2;
	Fri, 12 Jul 2024 13:14:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XKUSyHCfvI1q2nTXcyjA4jEdfwijguqWHXPPRL
	01Xsg=; b=XOVbLJvSlZk2Auf2aNcMRBIkvEjhnfgRNeo/0+yBYQMqC0nxNr2uUl
	9ofAXiwY3VCZsjUnqUIRcPNkPPh2DHJJ7EVYpKLsfUxcitE4qU0Hf8k+tvvxF1Q9
	iSSbnggBhN1GzU10dpn49mU9tVtX3zJ0Z4YoamrBriortGRXhGIjA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC393332B1;
	Fri, 12 Jul 2024 13:14:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24DFE332B0;
	Fri, 12 Jul 2024 13:14:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Cc: <git@vger.kernel.org>,  "Christian Couder" <christian.couder@gmail.com>,
  "Christian Couder" <chriscool@tuxfamily.org>,  "Kaartic Sivaraam"
 <kaartic.sivaraam@gmail.com>,  "Josh Steadmon" <steadmon@google.com>,
  "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: [GSoC][PATCH v3] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
In-Reply-To: <D2N4AG0P10QT.2EMBZAPNDBSP0@gmail.com> (Ghanshyam Thakkar's
	message of "Fri, 12 Jul 2024 05:30:48 +0530")
References: <20240708161641.10335-2-shyamthakkar001@gmail.com>
	<20240711235159.5320-1-shyamthakkar001@gmail.com>
	<D2N4AG0P10QT.2EMBZAPNDBSP0@gmail.com>
X-Gnus-Delayed: Fri, 12 Jul 2024 11:55:30 -0700
Date: Fri, 12 Jul 2024 10:14:20 -0700
Message-ID: <xmqqcynimt1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2DDCFEF8-4072-11EF-B4FF-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

> - And replaced the third elements of key_val[] which recorded
>   the presence of certain key-val pair with 'char seen[]'.

It makes it in-line with the oidmap test, which is good.
