Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56138249FA
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e3EnAM+g"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6777899
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 15:50:27 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 23E8E25A14;
	Mon, 13 Nov 2023 18:50:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JdLgZllje+J3LUftWn6PRiSG1df6TR5MQJHesB
	9vvJE=; b=e3EnAM+gEcmVxAOoeAw2YTKaQI2qlIlA67y10n8AjTIF4s7BzzpGkm
	EZT2kCLb/0aYJoliCCo1I4vpHD/xTy9NOSmHKOPYGenKrAdLHqOtFp8sUCc//oi9
	AsqLGbzrCcxWtZ3P938eDJqG5ijpbiuaQiiaD28noqaBQeTm1mpp0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C58E25A13;
	Mon, 13 Nov 2023 18:50:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B35B925A0B;
	Mon, 13 Nov 2023 18:50:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
    Karthik Nayak <karthik.188@gmail.com>
Subject: Re: commit-graph paranoia performance, was Re: [ANNOUNCE] Git
 v2.43.0-rc1
In-Reply-To: <20231113205538.GA2028092@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 13 Nov 2023 15:55:38 -0500")
References: <xmqq8r785ev1.fsf@gitster.g>
	<20231113205538.GA2028092@coredump.intra.peff.net>
Date: Tue, 14 Nov 2023 08:50:22 +0900
Message-ID: <xmqq8r7143i9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 697FD0F4-827F-11EE-B3EB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Should we default GIT_COMMIT_GRAPH_PARANOIA to "0"? Yes, some operations
> might miss a breakage, but that is true of so much of Git. For day to
> day commands we generally assume that the repository is not corrupted,
> and avoid looking at any data we can. Other commands (like "commit-graph
> verify", but maybe others) would probably want to be more careful
> (either by checking this case explicitly, or by enabling the paranoia
> flag themselves).

I am obviously fine with that direction, as that was exactly the
stance I took when we discussed the topic on "rev-list --missing"
;-)

Patrick?  Karthik?
