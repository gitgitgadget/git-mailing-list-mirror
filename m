Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E654757C720
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988654; cv=none; b=IVT9KgAC3pEhZ4GASh4Ekwt14tyXq4NTC37/NXf7+YQLX4ZXDiGmPddIZJO06vlstCwZUW2Xwnk+sFtvzVay0PaxD1eCtBx6142NEp8LGLEI7dKiBL54ZwjXFBUshHAjnWnjDOlU/Khv6NJz3LuLglEBpvyp1uZ3++jz5TCdjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988654; c=relaxed/simple;
	bh=3ltF/qcCEM6oj7OyS0CgrJxFnAWj0dtkeRBFgpDUD5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vA6SSoc47QlmoizsG/SnuZg5BbfyL8YzfIbuHDqtap99Cq+wG1UDmNRcg2ATMKAZLGA0HfMInH+wyhghv/5mPwuznqEVA+6L9LTYD/J7XkLRQwfmlaUGzMAiPRw4Z1RVR+aa6uWvI72VqgnF3c+Af3FleYkH9EGrYLuqigMuOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YHzAh5hR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V9PpVffH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YHzAh5hR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V9PpVffH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E634EEC01D1;
	Wed,  9 Sep 2026 17:17:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 17:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788988651; x=1789075051; bh=eqWoVyORc5
	RMwFWwJm5rvZGwyYeCMFtycnlRYlG8zF8=; b=YHzAh5hRKMbXVt3Lq+isWtcLnG
	YIPdCk5o0KY6kz51QwDCtJdr62LdDeAaFJfW7I31aqdruBkmNIi5VQm87d9W5O66
	gOUFj1WgaezS40sR7Rs9yiHqf/yBFrlolhtUxBGKLO9XntKrPeG0mKr7I20dmMPP
	umLIfhPSrt2CXT5i3ivbuUTC67csUn7zcYKV6qWK1b+fCLTH21h7MGvNJm6HXJpi
	DdsII5Z5+GYbogLVqQb73ceRs8NbaQKdR9x3qJoe09tJhNoBb7UB3pIGFjwrO52s
	GrEUZNuiU1nxNZwnrnm1bYyZsG0dXpDbSSfkMMtLUyHmPhiYS8kVsf3bqGiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788988651; x=1789075051; bh=eqWoVyORc5RMwFWwJm5rvZGwyYeCMFtycnl
	RYlG8zF8=; b=V9PpVffHqB4XPYsbEK94wgsrs3T302y6JrOnnPFeMAapRbLBFd7
	FDJzk7P6G72Pggg+PEJqF8+VL497iTqD/8C9eKBe0wt1M43JOsn8o894G3VO2aq8
	4xTP8cGtRKkeKVgYTsTNJHZrcXDsHQE5xI8ogIUZWegyCRdPho9dGSOwCMd1Z/mk
	hagX8G3DKluMiHFZurtWJ2OXkH1PULUuUdKvNCAVaJ26vDc8j61RXW9D1cNdkTXl
	l/AdbwFXly+qiqtpn2/mKEgEKKgGFAd9kgM5zV/zYscOuvfbKn268p7qh5OxCXYA
	THBOBgwX2j85YIhBzVPYxQ11MfgByh7qOmg==
X-ME-Sender: <xms:68yhainxvOsN76dhR77L6z_32_zi_xwJq3hxPCVPP7It0QbS6QiVEQ>
    <xme:68yhagtrFhsww7Nl6T5ImCQKWii3Kr7iwinxlrYi4hRhim1Fp-pB4_9LZCQE8uEW_
    ywPlKaCBeQPpl9wJbM9LZ3rD-UDFpL9hi0XY7luvRoMnJboKD6uRBk>
X-ME-Received: <xmr:68yhao8I7oeF8Ptr4IO9ltgP94V1X1WlXahZo_SE-_3t0oWNBS7UVCpz9sfHmLdlGgNz5kuxRwptUSPdae0-OPwhSel413J_Q4jg>
X-ME-Proxy-Cause: dmFkZTFdfgijf/WQ3o4K7QbHtJnMDeKQkAnXmveRwuObyEpydt32P0AdwR1QUkjaWg2c1P
    4IOxIPZ4l/mZSKSjLRYQcjdAnNRDbrR53pUKdRbfW1sjHVqLXsEiqcXgQ/5/yXYIx5pJbi
    h89VfC6IGsTtL4xmTbYz7UG0Ngd2XSQASCBPKQXoQs+JktWuNaNP52wqibTCdIFYtcMu2a
    FljDSjZTiQKWRgfWdzptE0AuGrdFNDunduzPwWaMQMOmreVATn1m5O8iyGEFiCp5So+LNg
    jA7HdgGge2v+21cYkNLYPIg3N6jSuzf36iCNa+VQIUbI8yPUNrZuq1T5+5DNqEnzQZYpCj
    q3DxSibktfmXcKfRYF78zempv1yXVXLDa53OcyeUxfhinWOmlH6086nBvTFtp8x9nmUQl9
    0A9ppq2qnQc2CgykrA0/9LMs0VAtWLKWZOxBvjAAf6rmeHAtVnbIuLaG4vkHoZhBt4dEKN
    mqJSsINv7GnXS60o4dGxoOiAoDqGUOcYEMWuK6Rwz+ku7UO1QipZiA2g/Lici1f0uVQapl
    jgWFTKmVLRM+G6RW76nooCpmbfKniblLmy6YGu9j5okg6RBGmeeQkex5pjd1Vk0QcdODxU
    7VDjSMpuA3LHGkKnDBDOER6CPEbpSeGs+8EazdcUoz68L4YK+UlFEkoXbd5Q
X-ME-Proxy: <xmx:68yhaiNJfydpc3Vc03d-iBdh8U9hp8OgF4EpNyFrBOOU6qjrf6PCTQ>
    <xmx:68yhauFSQSgDPl-TAcRAga0ra2uMp6nXhNd92mfE4Fn5cc-Gk-oG1A>
    <xmx:68yhaoTJrl2YXiP-T7TtzJyi3I4sUsGK0L0GvL4xE-dqm357FJ9d7g>
    <xmx:68yhajutYYBz1V0ddzWU38zwfrGcSXRX3WOOkTNzj5gh07tFzvBiXw>
    <xmx:68yhauiObe-MRCwi0KxA904oCbqg3XrsaKkK1Y8zAcDkNVhItpXiugiP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 17:17:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Sixt <j6t@kdbg.org>,  git@vger.kernel.org,  Johannes Schindelin
 via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
In-Reply-To: <7ac8168d-5b5f-fec2-ec91-ff72f7b6f1fa@gmx.de> (Johannes
	Schindelin's message of "Wed, 9 Sep 2026 22:13:25 +0200 (CEST)")
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
	<4cc14553dcddbd7fb1a49864ae988bad19626391.1788981436.git.gitgitgadget@gmail.com>
	<9f078382-411f-4865-9f01-4fe0b1ee118f@kdbg.org>
	<7ac8168d-5b5f-fec2-ec91-ff72f7b6f1fa@gmx.de>
Date: Wed, 09 Sep 2026 14:17:30 -0700
Message-ID: <xmqqik4ep1jp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Hannes,
>
> On Wed, 9 Sep 2026, Johannes Sixt wrote:
>
>> Am 09.09.26 um 21:17 schrieb Johannes Schindelin via GitGitGadget:
>> > [...]
>> > 
>> > Note: This keeps the same, hard-coded MSYSTEM platform support for CMake
>> > as before, but drops it for Meson (because it is unclear how Meson could
>> > do this in a more flexible manner).
>> 
>> I think this paragraph is now stale and should be removed from this
>> commit message. I don't know if it makes sense to insert in 12/12, though.
>
> D'oh, of course! It _was_ unclear to me how Meson could do this, but I
> obviously found a way to support this _somewhat_.
>
>> > 
>> > Helped-by: Junio C Hamano <gitster@pobox.com>
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> Except for this, this is looking good now.
>
> Yes, this should also have a `Helped-by: Johannes Sixt <j6t@kdbg.org>`.
>
> Junio, can you squash those changes before merging to `next`, or do you
> want me to send another iteration before I go to bed?

Those changes meaning removal of the "Note:" paragraph from 08/12 or
anything more elaborate?
