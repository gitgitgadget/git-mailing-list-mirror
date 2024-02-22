Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BD148FF2
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621215; cv=none; b=W3c6JwwuF/Nk8Q2QOu+Lvkt4ziOW7Vt0bn5L0xtsn2LJLi292y9u4Q1lhKkRwa9gULTVLYTzmvQFeur7TxKkgMx6ZdhNrymvaEvTFDGaf5tv6+EvDse2qsatPURpVAaYjFShMZHWJcRVJ1r12GbRDCNebjoP7iqpw6470n51Y74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621215; c=relaxed/simple;
	bh=6Z2TmsRt+mES8qKg9bIaPYmgDHsQHrmDWJl69Yj5NP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqFwL9fRDFJ0FuzL4nVwIW2WprGKrkxsVpY8K3r6sZtnwlr5nCDu79J9DYZL3zLIoHFag1PPhIY8VTiFgnY357h6Fw4wzEX5Ys4iMFBWGxlIn19W9IHq5ymLroBAZHA/gAbUrgHSot9qvey81VGJjYaiofd4FvGe+aoctgEQSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s2i+AYkn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s2i+AYkn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 940CF1D5E9F;
	Thu, 22 Feb 2024 12:00:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6Z2TmsRt+mES
	8qKg9bIaPYmgDHsQHrmDWJl69Yj5NP0=; b=s2i+AYkn+CR3FdfEOgibXEa4Ih54
	kfl9iCp+UXNR/6WGSwtC73RfMfmcd+nUXObeu283DipL/q9TEkxpgI478f1fJVfK
	7GvWC63r2zrJmPyGmNWkS6hte+xrrBOhDPD+Ggz779PBA6RPBOXTZc0k1SMhcbou
	8WCDH6gxZYLtb1Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67D891D5E9D;
	Thu, 22 Feb 2024 12:00:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E35C1D5E92;
	Thu, 22 Feb 2024 12:00:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  "Harmen Stoppels"
 <me@harmenstoppels.nl>,  git@vger.kernel.org
Subject: Re: [PATCH v2] rebase: make warning less passive aggressive
In-Reply-To: <759cbb30-96dd-456a-baab-b9451d400dcb@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 22 Feb 2024 11:53:10 +0100")
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
	<pull.1669.v2.git.1708537097448.gitgitgadget@gmail.com>
	<759cbb30-96dd-456a-baab-b9451d400dcb@app.fastmail.com>
Date: Thu, 22 Feb 2024 09:00:08 -0800
Message-ID: <xmqqcysoh1t3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D71FACF6-D1A3-11EE-A080-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> I=E2=80=99ve interpreted this error as: I=E2=80=99m not quite sure but =
it looks like you
> are not in the middle of a rebase? Like it can=E2=80=99t be completely
> sure. Maybe from a more =E2=80=9Cprimitive=E2=80=9D time, implementatio=
n-wise?[1] :)

It certainly is a good point.  At least one other message in the
same command is equally less assertive, e.g.

	die(_("It looks like 'git am' is in progress. Cannot rebase."));

It may have been OK to be uncertain in the earlier times back when
we did not much know what we were doing, but by now we should be
more assertive, so that the end-users can more easily complain,
saying "The command said I was not rebasing, but I was!  Here is
what I did", which would hopefully be a valuable feedback for
improving the logic to diagnose what state we are in.

So, making it clear that it is a statement of a fact, or at least we
are telling the users what we _think_ the state is assertively, is a
good idea either way.

Thanks.
