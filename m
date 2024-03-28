Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C913A250
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658606; cv=none; b=tIGFsAWcuzheB5QYyhQ+KDNXaLiU9kaUuv1LwhiBNJWuwSoZJqDublMupgoIjj2r8YZRdfQu1qtCGlwwuNz809J4q0VZHi314R/w1jYXnj5SayrXp90E7UQez/oXBEz90Lt9GKxmDtD8m8/TmeeZmYR22H8o/9u1dbhysm+o7QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658606; c=relaxed/simple;
	bh=qZS0hTSyZrAItuS3Zjgx3NtCh/0oD6BZDXafGepawGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rwaBXGf0KirVWEaN8VBZ4XO8DfTasxjPoNQtM4MspF4vecUnuVooZTz80sLUwS2++GRjHkrd2V89VGTRtkBRCYBRpqHsWjhct/swEL6NBb9mgr9DNbEU2NtxZMgJQZn8KGl0BVq43AUPU8lEPW+EyEUUKpksbe5I4GIeVWD3+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f7FBFs4x; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f7FBFs4x"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2AE21ED146;
	Thu, 28 Mar 2024 16:43:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qZS0hTSyZrAItuS3Zjgx3NtCh/0oD6BZDXafGe
	pawGM=; b=f7FBFs4xAybKq9lvveAX/frU2X2jGM8N6rP7YWgsl3Cd4LUe24nWY4
	1LGmpc4UFLQ+YXdd+RqpJc8ihLshLJ78qlkWb1SI4PeaVWvwYxmfCanW54qdQGY8
	QqEg0STp+MgQp5+Ns6RnJmXuzCAEo0tNt/GaNvoNYo0QuwDVvOsC0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B9AB1ED145;
	Thu, 28 Mar 2024 16:43:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 130EC1ED144;
	Thu, 28 Mar 2024 16:43:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Eugenio Bargiacchi <svalorzen@gmail.com>,  git@vger.kernel.org
Subject: Re: Better visual separation of hunks in `git add -p`
In-Reply-To: <de182310842ea3ff04c171a271587ca1@manjaro.org> (Dragan Simic's
	message of "Thu, 28 Mar 2024 20:16:28 +0100")
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
	<xmqqo7ayuwpi.fsf@gitster.g>
	<a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
	<xmqq1q7uusin.fsf@gitster.g>
	<1b81a013dd0faccdc24fe018fd740755@manjaro.org>
	<CAHfn=+tsrgAyUUqUkq4TpXcABr7=ZcH+cna+vwALJqZ3H8LxFA@mail.gmail.com>
	<26f8d21dfd53d699804485b0f8c6abe1@manjaro.org>
	<CAHfn=+s5_hvV1osP1HFjWs4wxRfr9YUW-9=WkXbgSp-8sPZ-Qg@mail.gmail.com>
	<de182310842ea3ff04c171a271587ca1@manjaro.org>
Date: Thu, 28 Mar 2024 13:43:21 -0700
Message-ID: <xmqqr0fut7di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D1A5527E-ED43-11EE-A98B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Of course, users could pick the right escape sequences for their
> terminals, but as you already noted, the same configurations could
> end up being used on different terminals.  For example, even SSHing
> into a machine using a different SSH client could lead to a mess.

There is a separate discussion of conditional configuration based on
environment variable settings, e.g.

    [includeIf "env:TERM:vt100"]
	path = ~/.git-config-bits/vt100

where the named file might have

    [prompt] prefix = "\033[H\033[J"

so it is certainly doable.

It is a different story if doing so is sensible, of course.





