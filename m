Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364C2F5B
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921432; cv=none; b=tu8opGZLfcp4oZ66fRBv7JHU4hjI55xlBYOn1w0iDbBKuTeYVKIAoMHcnpCioSwbpBFSYGGJd27X7cbXzdRocKcLg5ffxkLHIy7bWXU+cBb19V3ZU16RQ0upOvsehfiqH5NlRLzecGJnkXobbOFN4400RAyPfM/WkD3F3CFKKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921432; c=relaxed/simple;
	bh=6PRb4EMlFQB8VL+kKOOMCW58GFmfn5MJ8lXnMX1ApsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QG6oRTAhawgvHfJA90e1H+dlXb8haVFRy7CaON+gSBgWFFWg0tvH+OWwASPb2r057W7Y1L7vzp/jzjikU1XF+/YlsVBIen22A/eSXv46eB7d5iorXro8tQfcJCSEHF1S6NpW+05rjTolei2Vmc3koiDbBkEBuSF8ahkNtOr6GaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CHXeDRlN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CHXeDRlN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 20D841F69FD;
	Tue, 23 Apr 2024 21:17:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6PRb4EMlFQB8VL+kKOOMCW58GFmfn5MJ8lXnMX
	1ApsM=; b=CHXeDRlN/B4GEsFyU2mZ4YT2YMaUwg9V55NJztYC9u6+HCl7vWLN2L
	kMVz/jWiLQP6DuobzYP55gdXao3OpRdik3SwoICEBKF6ii+FKbzb5IBtuAKJac7O
	ruoviYSFtk3Vj8qSCWXb72gvH03Fj3TJI3GtH5Fd1Z1f4geCgNuGs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1975D1F69FB;
	Tue, 23 Apr 2024 21:17:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66CAB1F69FA;
	Tue, 23 Apr 2024 21:17:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  chris.torek@gmail.com,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
In-Reply-To: <20240423220308.GC1172807@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 23 Apr 2024 18:03:08 -0400")
References: <20240412095908.1134387-1-knayak@gitlab.com>
	<20240423212818.574123-1-knayak@gitlab.com>
	<20240423220308.GC1172807@coredump.intra.peff.net>
Date: Tue, 23 Apr 2024 18:17:08 -0700
Message-ID: <xmqqcyqf4l0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5F407A7A-01D8-11EF-8A26-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> That's pretty convoluted. But we can avoid it entirely if there's no
> ambiguity in the protocol at all.

;-).
