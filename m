Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B51BC31
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710608816; cv=none; b=rFqu6ZowNkAKqWfWK+q6CJtJfHU2y/GqbnCsMmSkkRvg1A5HHR+gf9I3xMxgIFOrih5TEX1Vltl+E1Hw9lksNS/UfrahMtSAyYEAEBR0cG5fvG80sGSkEiDUNLVhZAu0PCykVhgW26s3TWaAiTiO+5trGfDo1J5tq9LeCqK0/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710608816; c=relaxed/simple;
	bh=eAd2L2k+NjpOEWsX4NUGW0/TVg+PIWhkItuYdoGSBnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ld0g+u5Zlidbq3frDImKHXwtoOtD01JjS3L4VNC84CkzjLEfQbOs8kDp4AnfErNaYiUx9H57xjUM95Hj7JksT5iRqdm8zAonvrJi/ENyQquQeOhIXE4XT6oorFSSdX2a7CUuzvsMCK8B2CeDOCt7C8fXmmUq01Ns52kZBjMglt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tRlUxjf5; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tRlUxjf5"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C78C331EF;
	Sat, 16 Mar 2024 13:06:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eAd2L2k+NjpOEWsX4NUGW0/TVg+PIWhkItuYdo
	GSBnA=; b=tRlUxjf5oHcwuoXBLNIqf84qS2HS88B34s0Ut2nGILvCM5Pftkaydf
	ElC16+TtcoVa5qeYEaAmbuDWF11j1FnqfkhoisTCjNiAqHHz8beafmSO5Nqy/Mm1
	Tu2B3UhFVp/1BEd1TIPDAHufLGz8U+gnmOAbqkxUD0JWObHJK3qNE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 95075331EE;
	Sat, 16 Mar 2024 13:06:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 416F2331EB;
	Sat, 16 Mar 2024 13:06:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 0/6] Make trailer_info struct private (plus sequencer
 cleanup)
In-Reply-To: <pull.1696.git.1710570428.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Sat, 16 Mar 2024 06:27:02 +0000")
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 10:06:49 -0700
Message-ID: <xmqqjzm2m7h2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 94F7A434-E3B7-11EE-99B1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> NOTE: This series is based on the la/format-trailer-info topic branch (see
> its discussion at [1]).

Folks, a quick review of the base topic is highly appreciated.  Not
having much review to talk about in [1] makes it a bit premature to
build another series on top of it.

Thanks.
