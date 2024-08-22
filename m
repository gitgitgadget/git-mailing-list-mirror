Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F391CB30F
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341227; cv=none; b=SAcrHvmNVWg/DNyYaF9pzfgkqpgwSNrI50gEFg/UkQYgeuwBxfO5CuFkev7zxZBN5e1WXi1cLAc7FhPJNkTSZJpf4JgY1PvEcH5K86t4kmA5ujkoUeFqtTwLecu37cze0k9VAAAvkqWb8GUqzYSq01eX3DDGOVDzPnvtD2PrLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341227; c=relaxed/simple;
	bh=zJQfXvqYCWGdojMvi1zrsfc/8BOeP/sDnlm3OmCD0M8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DFgykKlCz90nbG/4wH0GUH2r+jj4M3A9GuBOns0IwSRuttBYKrrqgRYwPJHkdZ4JpKBzevnEEoU0Evj4b3TcIz5To4OFoj1jLqEvwn3KkHp7ZdmosaebADc46OVq2pIzrc9CPQk5D+EUHzFe/VFcaSiPedMitpyZg8LMl22+bHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sl58cgsi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sl58cgsi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B88B920CC6;
	Thu, 22 Aug 2024 11:40:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zJQfXvqYCWGd
	ojMvi1zrsfc/8BOeP/sDnlm3OmCD0M8=; b=Sl58cgsi+1A93ArVMj3FWmZpKAVP
	F4nmMXKgbHiE0+jwe95BB8XLGLlQ4gY2FxKpd7qyGZQpNNOu0TxfKb04PnZinLug
	PSWnMxpTeZTMiTscO0WIkz0pifm56qHg7Jh1o9Ec8NadBaz7P5qro2FyBqvsmvHc
	fWo7LrYYREZE1TE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF74620CC4;
	Thu, 22 Aug 2024 11:40:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1CA9B20CC3;
	Thu, 22 Aug 2024 11:40:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marlon Regenhardt <marlon.r@hotmail.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Wrong error message when cloning from http gitlab (and
 everything still works anyway)
In-Reply-To: <DB8P194MB0870877CBCB0576CCCB520C0E08F2@DB8P194MB0870.EURP194.PROD.OUTLOOK.COM>
	(Marlon Regenhardt's message of "Thu, 22 Aug 2024 10:40:15 +0000")
References: <DB8P194MB08704DAF8B33C67FCCE43EBDE08F2@DB8P194MB0870.EURP194.PROD.OUTLOOK.COM>
	<DB8P194MB0870877CBCB0576CCCB520C0E08F2@DB8P194MB0870.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 22 Aug 2024 08:40:22 -0700
Message-ID: <xmqqh6bcva55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D8DD65E6-609C-11EF-AA34-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Marlon Regenhardt <marlon.r@hotmail.de> writes:

> I'm currently setting up my new work PC (now Windows 11) and got a weir=
d error message when cloning our repository:
>
>  - run git clone on an http GitLab instance, in my case I ran `git clon=
e http://gitlab.company-local-domain.de/group/project=C2=A0LocalRepo-Name=
`
>    Note:
>     - http, not https
>     - GitLab
>  - Get the following error message:
>    fatal: Unencrypted HTTP is not supported for GitHub. Ensure the repo=
sitory remote URL is using HTTPS.

A funny thing is that

    $ git grep "Unencrypted HTTP is not"

in the entire codebase of Git gives no hits.  If this message is
coming from some add-on Git-for-Windows ships with, a better place
to raise this issue would be Git-for-Windows project's tracker page

  https://github.com/git-for-windows/git/issues

than here on this list.  I tried

  https://github.com/search?q=3Dorg%3Agit-for-windows%20%22Unencrypted%20=
HTTP%22&type=3Dcode

to see if they have that string, which found no hits, so there may
be some other components, other than Git project ships and
Git-for-windws project adds, that is in play.
