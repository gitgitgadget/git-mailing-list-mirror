Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10E8825
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316934; cv=none; b=kZ4YUOqxCkaP+jPpI8LNjN3K21lz3oGEy1sWHmuPkUZxPhIAW7DPN/QpFyc6C5/KJ5xSwM4d/m/YHjI9otOvYAVemn5rQQoh9/xGZrSc6/0PAzDSc5z9C4Ia91Wh1SAl/aCSpkQJwvXk/VWHrD+eJqVxY85aMSFjCRaZ4uorOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316934; c=relaxed/simple;
	bh=aifyi56jKCpL70S5x/ra0Mj6l8qoSA4FYbmu7P3p/tU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cTTQK/XaAItkTEb3vx4b/jCeOtgEhSTHwxMmowKGHfKk+ksjTwJ7LCX2DNJ+qBdW2u86DTUdUoenFUO7W4miBtL1mqR0OvxHOwpH2KBakvrU2L+YfRoi+iC+qLx8jpM8SUVKQVvof6oXbcoxg+gIZDSvQN4RArA8Jpy9YPCHIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XETOWbb0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XETOWbb0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0AAA61E14C;
	Fri,  1 Mar 2024 13:15:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aifyi56jKCpL70S5x/ra0Mj6l8qoSA4FYbmu7P
	3p/tU=; b=XETOWbb04qtfIzKuN+4lz8jmioJQ5bOolRGRUo5Ddct9tF/sMhW/O7
	jEGKCDhByIq1HgO5L9LK3x6uza+JE/WThEZltGWrcNUUKhKTWB6u+P3vmxseNpwx
	o5At2/o15WlvjLAzR8u3KgvTakOQsUEU9/ZuEzD+RsjC7VEQWA7pI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0252F1E14B;
	Fri,  1 Mar 2024 13:15:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B1FA1E14A;
	Fri,  1 Mar 2024 13:15:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Haritha D <Harithamma.D@ibm.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [PATCH v3] build: support z/OS (OS/390).
In-Reply-To: <B3775704-6FCE-4994-8682-309D521FD2CB@ibm.com> (Haritha D.'s
	message of "Fri, 1 Mar 2024 09:09:17 +0000")
References: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
	<pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
	<xmqq7circevo.fsf@gitster.g>
	<B3775704-6FCE-4994-8682-309D521FD2CB@ibm.com>
Date: Fri, 01 Mar 2024 10:15:26 -0800
Message-ID: <xmqqbk7x6cox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AE996D30-D7F7-11EE-8F20-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Haritha D <Harithamma.D@ibm.com> writes:

> The win test(7) test case failed stating the reason as "The
> Operation cancelled". I saw that it failed after 5 hours 59
> minutes of running the test cases(build). How do I handle this?

Those "win test (n)", at least some of them, seem to have been
somewhat flaky [*1*].  If you are certain you did not break them
with your change, you do not have to fix them yourself.

I am a wrong person to ask how the test failure that may [*2*] block
GGG submission can be circumvented, as I am not involved in that
machinery at all.

Thanks.


[Footnotes]

*1* Also I've seen osx-clang job time-out from time to time, without
    failing any specific test.  Re-running failed jobs from the menu
    often make them pass, which is why I said "somewhat flaky".

*2* I do not even know if GGG refuses to submit a series with a test
    failure, let alone if it allows to override such a safety if
    exists.
