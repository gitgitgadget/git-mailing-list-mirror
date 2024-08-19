Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6A186E56
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095014; cv=none; b=YUZxJdSIc/O0vOEmJoI5geWH5xNS70Acp5SRGB72bg+gKJyv0kpZ2TuE2YgCMmIoRr7sB/QPhvvZL+b9WPf5LRaLzLT33BZhXu6Dv2l95d2fS3rK0yg43F14scUPsXFQDzyzrq0ysQaWxNSunCi/gOR10mNbQ6Kc+IrDvQjyuEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095014; c=relaxed/simple;
	bh=MwS2iFi8Jc+dYpw2FV+H80SCy0RwWPcPDr6kf6Ll/yU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JUKb66xHdR20NLx423ji5v/h7Qn3ADzgIbDIYQpbwFsmFzl2MKZcNDLcm4r/eNiOc5gzmGBBGfrknVKwT2GX4cqDEGG5ewWteZfACf+ZiOTetxw36fCcKuL6O8oaZSKzWL8EcvVv4y1CoUpNI2/5XjVhD4YHVt56ROMQNaurdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dQM0wkwv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dQM0wkwv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AC0251B6D8;
	Mon, 19 Aug 2024 15:16:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MwS2iFi8Jc+dYpw2FV+H80SCy0RwWPcPDr6kf6
	Ll/yU=; b=dQM0wkwvUKP4QSDxQoYnJaYL6aQYM6w+Z9XTyPpZwpCh3XpqWTyxhX
	UzJpdL2mj0DnKIoJ/Z/U6K9FC27EewgVDWbkILn+wtNN4ksf7T6tf2YzpSlmMV7V
	uHBE8fmnq18j8CXzKTpR/PLSPBt5Fh9IJLRbGeeMoBRKvQU/JVB10=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A532E1B6D7;
	Mon, 19 Aug 2024 15:16:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32D421B6D6;
	Mon, 19 Aug 2024 15:16:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: v2.46.1? was Re: What's cooking in git.git (Aug 2024, #06; Fri,
 16)
In-Reply-To: <b6e3763d-945f-fdf7-e620-cd26b8c72419@gmx.de> (Johannes
	Schindelin's message of "Mon, 19 Aug 2024 18:49:07 +0200 (CEST)")
References: <xmqqwmkgjomp.fsf@gitster.g>
	<b6e3763d-945f-fdf7-e620-cd26b8c72419@gmx.de>
Date: Mon, 19 Aug 2024 12:16:47 -0700
Message-ID: <xmqqplq4e31c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 955732B4-5E5F-11EF-8483-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I frequently look at these two paragraphs in the What's cooking mails, or
> more specifically: at a paragraph inserted between these two occasionally,
> to get hints about imminent maintenance versions (to allow me to better
> prepare for them such as keeping back component updates in Git for Windows
> that strike me as needing some exercise before being released in an
> official version).
>
> About 2.5h after sending the quoted mail, it seems that the `maint` branch
> was updated with a hint that you plan on releasing a v2.46.1.

There is no immediate need for it and 2.46.1 does not even have to
happen.  Just a grab bag of topics that are safe and are already on
track for 2.47 are kept in case we accumulate enough of them.

