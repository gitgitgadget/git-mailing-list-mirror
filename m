Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3A17E8E4
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349103; cv=none; b=QatWRopbNpvVSMewT8b+YhBdkA1jl56Vwrj6IKLfy/yMjRqTLztIPmJ8tW5AczCnpQU8dflVmy+XeqwKc8/Hh6gQkb+07zPuEO6RdRdyU+PupU1SWJv+D0vBxR2GRsxKmEgA+b6ZFwuMDfm0eRc2yYz4VjlMKBMXkcDb/NSZkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349103; c=relaxed/simple;
	bh=cQwRCG3VHCGaWLzgjsD9FJP3jA8PzqxiXaMYPbG5W7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPWUBJ9zgidt1yAIU7Qf9W1SDApa2DOeDimoS52Svvwj42bVkztK8GFMNZzmxUMWz/7E2aUYJ8K6rMkCc28wyVOFXVFm80olBCgMm1sCLcAbFA493TQyUVFDLazmVtsJIz0+jduRtw06HgxFWAxcbGKOjCbXoOBeerS9JVGsI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jdb5+qWk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jdb5+qWk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE5141C418;
	Tue, 25 Jun 2024 16:58:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cQwRCG3VHCGaWLzgjsD9FJP3jA8PzqxiXaMYPb
	G5W7k=; b=Jdb5+qWkkhqwzBH+QbPFdKD0YumV0fza6yTKzXs7rgJI/EYP3vTl6A
	y3cGyD+AeqfQqACTPLNwVkE0V/ytQv7i/iuFXE1XoVTkmQb/Asxp/GRzLgkTUTvI
	LhmnoMYb/L8+ZAZi4lvkYSq+X4gpz8Dhn9E98sXKfUE2PeFajAGUs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6DB61C417;
	Tue, 25 Jun 2024 16:58:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 108DE1C416;
	Tue, 25 Jun 2024 16:58:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
In-Reply-To: <03ef01dac735$f3496ac0$d9dc4040$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 25 Jun 2024 15:29:03
	-0400")
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
	<20240621154552.62038-2-randall.becker@nexbridge.ca>
	<xmqqmsnekvir.fsf@gitster.g>
	<016501dac409$7dd5bc00$79813400$@nexbridge.com>
	<xmqqwmmijf6f.fsf@gitster.g> <xmqqplsaje6z.fsf@gitster.g>
	<xmqqtthlimtr.fsf@gitster.g>
	<03ef01dac735$f3496ac0$d9dc4040$@nexbridge.com>
Date: Tue, 25 Jun 2024 13:58:18 -0700
Message-ID: <xmqqmsn87n9x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A70F582E-3335-11EF-AA37-965B910A682E-77302942!pb-smtp2.pobox.com

<rsbecker@nexbridge.com> writes:

> My take on the separate patches and discussion about reporting run-time
> values of libcurl, zlib, and OpenSSL, is that these are being added to
> --build-options not --runtime-options (does not exist yet). I think that
> grabbing run-time values could be confusing to users who expect the
> --build-options even if comparing the two values.

Yup.  I thought that the consensus was to leave all those extra
complexities like runtime versions for a later and separate topic
done after the dust from this change settles.

Thanks.
