Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC333FBBE
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141160; cv=none; b=g7wm2Z/c2GuPP8d92GNOHqKogl3PsDYhWFsfEclMyt1SphWhEr9M08naIdcUt9VHQ0UzW1VUNlIabSdBqicoqAZT2bNTqGcTw9QF+A5kEL7Qzxmkde1iz/MaS2KN+TfsE2ubl1c/8Uzt1BU/69WJhdJB9dwxKjL70ufbP7etO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141160; c=relaxed/simple;
	bh=QpoYPLaRPFdgcBe8v88SO3jPYxesPrvrmqCHwalujkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fqlg5VAtc5zsscLpp4aZtIJfr/tocivJBjLl6pVQT2wuKCUN6Flkq/lKynE+ba82vAp5fKTF5ruV2Ev7OqiQFBYMkGfbwSe5Zg+PM1zhlrPvYKEmkEa+CK7dqSIWdI0TYZUs9C4kjgqS/IIIloK38yDg5rYPjtGGxStc2hjdYLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oQ7cd9cr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oQ7cd9cr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B42BD1E5E69;
	Wed, 28 Feb 2024 12:25:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QpoYPLaRPFdg
	cBe8v88SO3jPYxesPrvrmqCHwalujkw=; b=oQ7cd9crtRCgI3TSjgYeZGF5bG4+
	9/nvWrJXvVcHGKWMlZAQe5zjFEBwsqrJQIgDFaetU2Uv1hlBBHIlo+ehnm+K1rF8
	uiKdshza+ShOOx+Cf0cijbXwabJNrYt6mQEFUsISexHhd//Ho8bIT6GunmiJY8sb
	0eSnqmcrIG1gWFc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABEC31E5E68;
	Wed, 28 Feb 2024 12:25:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17F5A1E5E67;
	Wed, 28 Feb 2024 12:25:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #09; Tue, 27)
In-Reply-To: <dbfc2788-1a02-2b5f-bee0-6fae747ac92e@gmail.com> (Philippe
	Blain's message of "Wed, 28 Feb 2024 08:38:38 -0500")
References: <xmqqjzmpm9b8.fsf@gitster.g>
	<dbfc2788-1a02-2b5f-bee0-6fae747ac92e@gmail.com>
Date: Wed, 28 Feb 2024 09:25:50 -0800
Message-ID: <xmqqil28lcv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6BEEC902-D65E-11EE-AC34-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2024-02-28 =C3=A0 00:44, Junio C Hamano a =C3=A9crit=C2=A0:
>> * ml/log-merge-with-cherry-pick-and-other-pseudo-heads (2024-02-27) 2 =
commits
> ...
> I'll send a new version with a reworked error message, so best to wait.

Thanks. Will do.
