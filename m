Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA3041C70
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128226; cv=none; b=E3PXqIqJmZvUa+AFDjOHLkcKcMk75ZyXhMId87LK0FgeyPCwcKyNscNI5rLerGFYc5L+KCjymgO/teVKqsjSUrm+MuxrF+2cwCl4D2ft+zqRqXOdiK6eCg7kfNWI9oNO1xS59n+uVdzW1HNQz+K1uyr985+2PJ7iHDLaarTF4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128226; c=relaxed/simple;
	bh=v5oMtXa4Iprv9gaINhtyz8uabuCKppY25SO+HYJyDOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PJYm2tg/AqWfZumXL4LI+IpDLDo8XNcy1w9JZc4G2PV9fTD2/dp8+KUsq3rGQzuqtC4qsucj4TynoEhYkmRPolyF2TyNTTN0HagqIsPg548ftp93do9sQeEUgDWi49Dr3WFgLqYOGWbL866uSN2efR+L4j4MP0Mv5BkbSyfsZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pD0prZY/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pD0prZY/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9440A1F51C8;
	Fri, 22 Mar 2024 13:23:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v5oMtXa4Iprv9gaINhtyz8uabuCKppY25SO+HY
	JyDOk=; b=pD0prZY/j1shrQvmMUjpoYgTCl6y9KhXlpvbOskOCkVS3YCOjkqbhP
	LSektwG1qoJgqa57F0ZlFZaAUbi5y5mBSbj/mHMaEqelUoj73ZWk23HEiqexxl59
	kyDmlaBb+o2FPX6fCPSM2ijn+WPowUmX6kIz/mMcOHtyf+Zu6K85k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BE9A1F51C7;
	Fri, 22 Mar 2024 13:23:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F244C1F51C6;
	Fri, 22 Mar 2024 13:23:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <stefan.naewe@atlas-elektronik.com>
Cc: <richard.kerry@eviden.com>,  <git@vger.kernel.org>
Subject: Re: Merge selected files or folders
In-Reply-To: <c3f144b20cef46de83f2282dd16a817f@atlas-elektronik.com> (stefan
	naewe's message of "Fri, 22 Mar 2024 12:24:04 +0000")
References: <PA4PR07MB7406FAC1F8C00E29979FCFF59E322@PA4PR07MB7406.eurprd07.prod.outlook.com>
	<xmqqbk778oeb.fsf@gitster.g>
	<c3f144b20cef46de83f2282dd16a817f@atlas-elektronik.com>
Date: Fri, 22 Mar 2024 10:23:41 -0700
Message-ID: <xmqqa5mq18pu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EE7B5A4C-E870-11EE-A2EF-25B3960A682E-77302942!pb-smtp2.pobox.com

<stefan.naewe@atlas-elektronik.com> writes:

>> Assuming a history of this shape:
>> 
>>       x---x---X (that other branch)
>>      /
>>     O---o---o---o---H	(current branch)
>> ... 
>>     $ git checkout H
>>     $ O=$(git merge-base X H)
>>     $ git diff $O X -- thisdir/ that/file | git apply
>>     $ git commit -m "picked changes from branch X"
>
> Isn't that the same as simply checking out the files/folders of
> "that other branch" and commiting the result ?
>
> $ git checkout X -- this/dir that/file
> $ git commit -m "picked changes from branch X"
>
> Or am I missing something ?

You would lose the changes the history O..H made to this/dir/** and
that/file if you did that, no?

