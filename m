Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B808BA40
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694200; cv=none; b=fmAe2lO14KE3scDyCAMFyEGyfIEe/eOV9mnRk3EPwASmIgsNkm4W6Hp/uPRUH0GQZdbeJDUu8V9LkJBt3oc7VdtgAfe7FV6+jTrCamnSPJduhFaQIUhz7KQihSFfth812MEz7cBFJUg+Mi3hGgm2Rhl63W2kUjcMgtZJTIvnMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694200; c=relaxed/simple;
	bh=DC4z5jYAS6jQt4eAU2vvA+qs77mQWbyYZdLg/hUa3bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XisgD+mzgm7KDghLn/JOa2M5KZblHoGCa7M36oEVgrK9/4RBMjMsfpcWP6bArQoQ2rREhiLoTsPesctiFyDLFIbJvLUuVzCgPJVzWCb0TVe+pxHfmf66BmA7JZ2v7/TkhZHFwhhbzauCxKSEhikht+6bNTbdOzXS4esIzmmz4xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RYCkE7XX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RYCkE7XX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 80EDE3EC23;
	Mon, 22 Jul 2024 20:23:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DC4z5jYAS6jQt4eAU2vvA+qs77mQWbyYZdLg/h
	Ua3bg=; b=RYCkE7XXd8DBJ4fvfzGG/M+UuB8YFffApYWSTuysnhhe/ZCSjd9YXz
	Qa8Ha2kdogUih7MDB0y0nl0yNrw84hl/2PwAZLncinsmhLLpolIZCx0fW1b6toW+
	rc/PMZyigrhyJNeaqOA/5+2Cen9Xu28MbcLm2LkY35oW1DZs7mgGw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 799D03EC22;
	Mon, 22 Jul 2024 20:23:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CABA93EC19;
	Mon, 22 Jul 2024 20:23:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>,
  =?utf-8?Q?Rub=C3=A9n?=
 Justo <rjusto@gmail.com>
Subject: Re: [PATCH v3] CodingGuidelines: document a shell that "fails"
 "VAR=VAL shell_func"
In-Reply-To: <CAPig+cQnUBxttpTnucj527T0ExH1fHER4mrbyoU+hEh+Kp+Bow@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 22 Jul 2024 20:10:32 -0400")
References: <xmqqjzhd81la.fsf@gitster.g> <xmqqwmld55y1.fsf@gitster.g>
	<CAPig+cQnUBxttpTnucj527T0ExH1fHER4mrbyoU+hEh+Kp+Bow@mail.gmail.com>
Date: Mon, 22 Jul 2024 17:23:11 -0700
Message-ID: <xmqqsew1553k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BFDD3466-4889-11EF-8851-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +   to temporarily set and export environment variable VAR only while
>> +   "command args" is running is handy, but this triggers an
>> +   unspecified behaviour accoreding to POSIX when used for a command
>
> s/accoreding/according/

Thanks.

