Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64C82488
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214325; cv=none; b=sqxpFt01Hj8UZVSRaznv+eKPcbqS8+S9BzJoCR4ECDbmI9twvgut45jEfkyTcUkgDywTchfzJPwrdy85Qg3B6bAV/HtOq0d/KlcpPos4kw3sG4zjYtua+ebJp4l6+BiUOtFHjLOgSt4fcb+IOdLTFEjPcBFP+bQzfjBIkBfgFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214325; c=relaxed/simple;
	bh=bYOr7prsVuuTek41KRJ4vnS1mzvUSouBaHYB2J69G0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V/hfV+zmhuVYLb70E2SE277Z4jO4IlJoTEENbOe+rafq7k7c/Pmmif9E2tNL3iEOxnM4HMyz3dVPnzh9SmNamGmft9sjPHVAl4gs/shnLSeTeoJlBUVQmJ3iKKtP20eQnk95onVybaacUoTBllzE/jCarIp7Nqbsl2pxw8YVQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yX3deHUK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yX3deHUK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 304851A6F5;
	Tue, 24 Sep 2024 17:45:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bYOr7prsVuuTek41KRJ4vnS1mzvUSouBaHYB2J
	69G0Y=; b=yX3deHUKEfBwLVEJl4y1lQi2jD/SNabkkYA4poev1hNCDnppzR9g5n
	GhLpjMU1CeFeBY97aj85T/S7SOPrseEH5buDJdlHggA081aM14A97DEupfAObpN0
	PKedBfENsDZdot4AYf/Xh/nTZHmHLNa9rMxTY1GE4/IhnfzXwpbLU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 278BD1A6F4;
	Tue, 24 Sep 2024 17:45:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D20C1A6F3;
	Tue, 24 Sep 2024 17:45:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] send-email: document --mailmap and associated
 configuration
In-Reply-To: <xmqqr098rap4.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	24 Sep 2024 14:41:43 -0700")
References: <20240923222429.4102405-1-jacob.e.keller@intel.com>
	<xmqqr098rap4.fsf@gitster.g>
Date: Tue, 24 Sep 2024 14:45:20 -0700
Message-ID: <xmqqmsjwraj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4C5323FE-7ABE-11EF-B069-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> +sendemail.mailmap.blob::
>> +	Like `sendemail.mailmap.file`, but consider the value as a reference
>> +	to a blob in the repository. Entries in `sendemail.mailmap.file`
>> +	take precedence over entries here. See linkgit:git-mailmap[1].
>
> No such documentation page git-mailmap[1] exists, hence this breaks
> "make check-docs".

IOW linkgit:git-mailmap[1] -> linkgit:gitmailmap[5] everywhere.  I
did that while requeuing and reintegrating 'seen' for today's
pushout, so unless there are other things to be updated, no need to
resend.

Thanks.
