Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD314036E
	for <git@vger.kernel.org>; Fri, 17 May 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715983929; cv=none; b=GiTlX3npAMuS0v7nNj7PHocO1m6U73SPrznnnzJjZflrlZuo5kMyPVSaPLig6vqx+yQqIEuQprBM4JLVOWCrVhnW5VDl4Gtkjgpmt5W66vfN/cIEvxE/uzAMsHcI2QrO8GykMwNRYlYyX4LnuaLnNN5LQmFw3DEhGiIeHU8PH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715983929; c=relaxed/simple;
	bh=N7+nCx0C950S8eWW9nLkir5X68fAAo+JZLXWZ6NFB5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DhHCvGxqLsSwqQbaZ9ouP4/lKoHlE7VxmLODJZDdYDHIXGMiUT7wKPFaCTaOpBckMxo8eVjIvQoLUptH4EfgvNdIxTjD37PVLghmYBIj5IoLTgGjsWEdth3t2zc6VQ3/TogmuX9cTFhbY14JmktGG7WnQpNAYWeLUhLArGc/+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N6W2wyDg; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N6W2wyDg"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD8FA2AF4F;
	Fri, 17 May 2024 18:12:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N7+nCx0C950S8eWW9nLkir5X68fAAo+JZLXWZ6
	NFB5k=; b=N6W2wyDgUOhn0gXcICl2yxO02G/XbXFymPkIRTaLb5sRv0DAypxUBI
	6hu2F+4c43VFe8cQsvefWyMs1xEtCq+fBd03QvqDD1AwbhQVpgCqWVY3rJPz88jK
	IBbBdbeuj1GOIuPquclYm8RAIYrxTFwQwqmwAtQJVqybtCJ7ofB64=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D340D2AF4E;
	Fri, 17 May 2024 18:12:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11D5B2AF4D;
	Fri, 17 May 2024 18:12:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  ps@pks.im,
  emrass@google.com,  nasamuffin@google.com
Subject: Re: [PATCH v4] doc: describe the project's decision-making process
In-Reply-To: <10f217915600eda3ebec886e4f020f87c22e318a.1715978031.git.steadmon@google.com>
	(Josh Steadmon's message of "Fri, 17 May 2024 13:35:44 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<10f217915600eda3ebec886e4f020f87c22e318a.1715978031.git.steadmon@google.com>
Date: Fri, 17 May 2024 15:12:02 -0700
Message-ID: <xmqqa5kof5ql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7DDD0CEE-149A-11EF-9D2D-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> The Git project currently operates according to an informal
> consensus-building process, which is currently described in the
> SubmittingPatches document. However, that focuses on small/medium-scale
> patch series. For larger-scale decisions, the process is not as well
> described. Document what to expect so that we have something concrete to
> help inform newcomers to the project.
>
> This document explicitly does not aim to impose a formal process to
> decision-making, nor to change pre-existing norms. Its only aim is to
> describe how the project currently operates today.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>
> Changes in V4:
> * Minor wording cleanups to be more emphatic and to clarify "other
>   specific implementation" phrase.

Thanks for an update.  I am myself undecided on the "explicit
recommendation?" question Patrick posed, but other than that this
iteration looked reasonable.

Queued.  Thanks.
