Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03B1DC1BE
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461678; cv=none; b=O8rU+nP10Zmfy296HU9PJBHlLtl9BEB7jJ6tHOYL5xCm+xMOloOXR3HY/WmyZTBXrMTYnD7iIub3nrik5y6CzoxpDDYqt0iaseIf+CQ+RLDEEOQsUSnBovRFtB2xbiSsIfEZ+5j5cYTvzYXawUjfmyrpyHae27/zA0Bg+wBNtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461678; c=relaxed/simple;
	bh=qCn1Qt01M7vleg+T+ohbJs0jGJ7hEp4OERhuWsDEOaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GwAmKHrFYV+im67EHzDe9Tcvzkp1aULUlKGBpMeCoXWEYjsLoOYer0++0l3mG1Fp2E6WcO2Rxkqclo49fKkErerq59I+syIy+C2Qg2lBijMHvo5EoxRLo6hJiR4MwMdNZxaKNrTf+zYP0aDCIY4fgZjoi7z9Yr38s3DuUSxLEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IiHFbX96; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IiHFbX96"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D4491C1F7;
	Wed,  4 Sep 2024 10:54:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qCn1Qt01M7vl
	eg+T+ohbJs0jGJ7hEp4OERhuWsDEOaQ=; b=IiHFbX96dWqTsbtcniQ7tJgRmAgd
	XwcaPmCbulcAJDuQmIF14Hb+M0hrjDBvciOamg0zsRzp6y5IWdEy2GObUhKtUb3b
	RsGzgMpw+N0afx91UY0Tq3F+WdHldJ4H5pnm5Z8ZRla0OMwPSGSOgGJucp8GIIgn
	UteaFmbhed4PLAs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 047261C1F6;
	Wed,  4 Sep 2024 10:54:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 670FD1C1F5;
	Wed,  4 Sep 2024 10:54:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: sideshowbarker <mike@w3.org>,  git@vger.kernel.org
Subject: Re: Problem: git Notes not discoverable (+proposed solutions)
In-Reply-To: <20240904071338.GW26466@kitsune.suse.cz> ("Michal =?utf-8?Q?S?=
 =?utf-8?Q?uch=C3=A1nek=22's?=
	message of "Wed, 4 Sep 2024 09:13:38 +0200")
References: <Zp89ntYaeFUumaTO@w3.org> <xmqq7cbsh16d.fsf@gitster.g>
	<20240904071338.GW26466@kitsune.suse.cz>
Date: Wed, 04 Sep 2024 07:54:34 -0700
Message-ID: <xmqqbk13eafp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 99E28B60-6ACD-11EF-9E4E-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Tue, Sep 03, 2024 at 02:34:02PM -0700, Junio C Hamano wrote:
>
> The notes could be also used to annotate existing upstream history
> without altering it.
>
> However, the problems with notes worflows make it impractical.

Indeed.  As a mechanism for the only publisher to publish auxiliary
pieces of information to cloners, notes is a very useful mechanism,
but for such a use case to be effective, the project participants
must understand when they are supposed to use the notes read-only.
