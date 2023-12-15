Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6510E1
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RePCwENS"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B057202CE;
	Thu, 14 Dec 2023 19:06:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qPKIOfSuu0nCs6EMS8LzpwLm5jifoRxFU+qk8f
	m4rS0=; b=RePCwENSgj+bbW926k1egy6rSmx6ve14yab8n5y4mvy+oyeCwdtrY8
	QBbV51apftakRTAlYc4DXkfOOPkg76R/Ph7AyY7mFXKnllfc8jdAm2G3Xo6Akgen
	+eG9qi7RJ7YCsBQOGyFOteBFZknUD8pPtCXSNFClR0n/D5C6Nv5a0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4367C202CD;
	Thu, 14 Dec 2023 19:06:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C813D202CB;
	Thu, 14 Dec 2023 19:06:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 00/26] pack-objects: multi-pack verbatim reuse
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com> (Taylor Blau's message of
	"Thu, 14 Dec 2023 17:23:33 -0500")
References: <cover.1701198172.git.me@ttaylorr.com>
	<cover.1702592603.git.me@ttaylorr.com>
Date: Thu, 14 Dec 2023 16:06:49 -0800
Message-ID: <xmqqbkasnxba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D8A73500-9ADD-11EE-943F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

I haven't looked into the details yet, but it seems that
t5309-pack-delta-cycles.sh fails under

    $ SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true make -j16 test

