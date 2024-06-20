Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADF7CF39
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927709; cv=none; b=ZsbWnd7Gab8RwiRIMMmGelYLqyCEjWYHOcXQPIvJvGlMcoga2EKlGRcCtpwAn4EcdK2cUo8N55bhqcpmajdXTsshvHNfpgAvXfEEaDerNeWRDF5UWY+J8/Cg55P7/U3aD8GIKaTCVY5XWRXxTSdCLjLCtIVeBxDLAFbGyZaziuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927709; c=relaxed/simple;
	bh=/ReFOWsldYZtI/d2tdFqePTqI7KdKxPOBYX7zEXwyzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ftqzHaHUFIsnp1Yhv/j+C0s6eR6JySZXmfWFJE1epiW+VlVrWk07+oIFbyyn4q8DPGZ2ghzH0YvXQhcqz9/tL9wgfZ+3erxzNhyCLPavw567hjTtJjTgpny69Na7mMHpmFWwI+SVYe+Qmfg/fV6FXhxKz4208fEB0MhYmBIWrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WeqpuRXF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WeqpuRXF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E518A1B09F;
	Thu, 20 Jun 2024 19:55:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/ReFOWsldYZtI/d2tdFqePTqI7KdKxPOBYX7zE
	Xwyzk=; b=WeqpuRXFI72x5oJATbV+0TBKJZg2gYyoePUoKcVNtjK1eHnpuwNXvZ
	UjUNHcCIIoXR61W8PMsX1p9vggSvbrGj3ICCcwDw2nvdIGd7gi8whYRIxaIM6PTf
	pogJvZ7LqZSDNYDa+ioCQg0Zl4n9gpnAVDPZX9PUNr4uJrgMNMD8g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D2E181B09D;
	Thu, 20 Jun 2024 19:55:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 158991B09C;
	Thu, 20 Jun 2024 19:55:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
In-Reply-To: <00ea01dac362$73935e20$5aba1a60$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Thu, 20 Jun 2024 18:37:31
	-0400")
References: <20240619172421.33548-1-randall.becker@nexbridge.ca>
	<20240619172421.33548-2-randall.becker@nexbridge.ca>
	<xmqq8qyzv5a3.fsf@gitster.g> <xmqq34p7v4x1.fsf@gitster.g>
	<DS0PR17MB60311D246BF2E89FAEB3C64DF4C82@DS0PR17MB6031.namprd17.prod.outlook.com>
	<00ea01dac362$73935e20$5aba1a60$@nexbridge.com>
Importance: high
Date: Thu, 20 Jun 2024 16:55:04 -0700
Message-ID: <xmqqv823p3tz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 84AE932C-2F60-11EF-918B-965B910A682E-77302942!pb-smtp2.pobox.com

<rsbecker@nexbridge.com> writes:

> I have another patch almost ready for zlib and libcurl, but it is based on
> the OpenSSL change. Would you like a re-roll or should I wait for the merge?
> I do not have the PCRE - not available on my system, so someone else should
> do that one.

A two-patch series for zlib and libcURL that builds on top of
8b731b8d (version: --build-options reports OpenSSL version
information, 2024-06-19), which has already hit 'next', would be OK,
but most likely, these three are independent "for X in (cURL, zlib,
OpenSSL), append X if X is there", and when the three changes are
merged together, it would result in

    #if defined CURL_something
	strbuf_add*(...libcurl thing...);
    #endif
    #if defined OPENSSL_something
	strbuf_add*(...openssl thing...);
    #endif
    #if defined libz_something
	strbuf_add*(...zlib thing...);
    #endif

with possible permutation of different ordering of them.  And in
such a case, three parallel topics that build on the same base
(i.e. some recent tip of 'master') would be just fine, even though
they _surely_ will introduce trivial textual conflicts.

If you introduced a helper function or CPP macro to make it easy to
add the OpenSSL version string in your OpenSSL patch, and the other
two patches took advantage of the helper or CPP macro while adding
the zlib or libcURL version string, then it would be a different
story.  A two-patch series for zlib and libcURL that builds on top
of the OpenSSL patch would become the best (and the only practical)
approach in such a case, but there is nothing in the OpenSSL patch
we have reviewed that these other two would want to depend on, so...


