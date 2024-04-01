Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7031A94
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009796; cv=none; b=fv4NOgLZRTcp81BlugDDEk/oPFYHeLQgkqRC7IP9UkEl0/5C3NjVTRlqbdjmEdviewJXSpgNhU8UlOvDKvRFijyxH3ZB7FrAVQnedyPaDnCF+K3AspkL1g5FgiuEdIEcBLoT5URR3oIbM19yUre7YeIuZJNO/AVQ1blspzsRX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009796; c=relaxed/simple;
	bh=KYrjH+sS4t5lyJqbVw6PGpj9U5W757ewFiVlgmC3IWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KeR5MyF8vorrnLn4zNCGBMThhSn112lkrkoBfMUDnXbz46qXy37xfNyrjGLqJ+jHI08V9aefbUHfjeVO2qgnKkof9npft4ngx9h2vDJciX2obJhYHNI3xeMHQR3qVbDpZ/9SCp1e5a81gFKrRFZbMod2i+KI/C761yGUftOfBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YPOEuJsx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YPOEuJsx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9467B1F95A;
	Mon,  1 Apr 2024 18:16:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KYrjH+sS4t5lyJqbVw6PGpj9U5W757ewFiVlgm
	C3IWY=; b=YPOEuJsx7z6+C+xY5xWZGqAw3bNkFKyqDWiNuYo76/rrkZ50h+QEyj
	VZLojJCvBvbkbdUi/QGGzh1wWkEc4WvHg7buQAEyr1HjOwNRk2pGDGNuuv+leE2F
	8Tvlh1GQAEfkUc29nf9qugJmN81KBurEUjfjeZ2yl8DlX9Rx1V5xA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C6141F959;
	Mon,  1 Apr 2024 18:16:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F03941F957;
	Mon,  1 Apr 2024 18:16:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: gitgitgadget@gmail.com,  git@vger.kernel.org,  mail@boanderson.me
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential
 helpers
In-Reply-To: <20240401214057.2018-1-mirth.hickford@gmail.com> (M. Hickford's
	message of "Mon, 1 Apr 2024 22:40:57 +0100")
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
	<20240401214057.2018-1-mirth.hickford@gmail.com>
Date: Mon, 01 Apr 2024 15:16:28 -0700
Message-ID: <xmqqv8507mpv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7D5AC570-F075-11EE-A64E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

M Hickford <mirth.hickford@gmail.com> writes:

>> From: "Bo Anderson via GitGitGadget" <gitgitgadget@gmail.com>
>> To: git@vger.kernel.org
>> Cc: Bo Anderson <mail@boanderson.me>
>> Subject: [PATCH 0/4] osxkeychain: bring in line with other credential helpers
>> Date: Sat, 17 Feb 2024 23:34:52 +0000	[thread overview]
>> Message-ID: <pull.1667.git.1708212896.gitgitgadget@gmail.com> (raw)
>>  ...
>> git-credential-osxkeychain has largely fallen behind other external
> Hi. Is this patch ready to cook in seen?

A better nudge would be for somebody who uses macOS to resend the
patches with their "Tested-by:" trailers added ;-).

Thanks.
