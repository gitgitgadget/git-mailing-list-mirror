Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED02A1C5
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378974; cv=none; b=frv8hk2GMOBdhBievT/5jFWS10HZVgcYcNkmJ0Lm5PlFSPlPTHkKCmwFPA3X903FWlJCSMufWUapuLi9tthLO0seIfNLKHLnsuEK7lDq2kJwzWk4rw7WzvlA3dlR/Z+VpT7yXepGSA3Mt3vxJ7ETyVxiUw/sljjnJ7wkU/yLAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378974; c=relaxed/simple;
	bh=FYD4J5QwpZyBwakxfIqYZNGABpb5KZJ3MClbQzG8Gwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MogMrm8UlkzHB6i/xy6FksQj82yGA6cj+cS/kYGC7IMu5F69v3Bx3Ne3qFdf1Snek9BHEuBkVGgjfCMHsap6W2cPrktMFxy7OR1PgYEaxI3vuUr9u+ZmsLsOYmG2nMafeyTcqLsmbQJSi4KcY1yb9npO6MKqoCM53CgEyv3hvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FrPfHm6A; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FrPfHm6A"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C86036505;
	Tue,  3 Sep 2024 11:56:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FYD4J5QwpZyBwakxfIqYZNGABpb5KZJ3MClbQz
	G8Gwc=; b=FrPfHm6A+Vr636xDBiRhfiFBafNrGzGlomuxX8yj7Q8L2lFI3aAmtU
	Bt6YfIgsIgNLpIICqyXrrzDAkyjpgxLDQIURhpbA/FkGybpftMX75+jxMjaRLXSL
	UJSiyUZNDt5HRPc8cV1S4L3Yp/nbNkjVqZoDpt5pqV955Yhn1m0JA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 44DE236504;
	Tue,  3 Sep 2024 11:56:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC83236503;
	Tue,  3 Sep 2024 11:56:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Alex Henrie <alexhenrie24@gmail.com>,  cogoni.guillaume@gmail.com,
  stolee@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH] mergetools: vscode: new tool
In-Reply-To: <78e1d2b8-4d22-9bc9-ec5d-aaa072cbd393@gmx.de> (Johannes
	Schindelin's message of "Tue, 3 Sep 2024 13:11:44 +0200 (CEST)")
References: <20240902025918.99657-1-alexhenrie24@gmail.com>
	<78e1d2b8-4d22-9bc9-ec5d-aaa072cbd393@gmx.de>
Date: Tue, 03 Sep 2024 08:56:10 -0700
Message-ID: <xmqqr0a0n339.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0AA0E07A-6A0D-11EF-82CF-9B0F950A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> On Windows, VSCode adds the directory that contains code.cmd to %PATH%,
>> so there is no need to invoke mergetool_find_win32_cmd to search for the
>> program.
>
> The commit message and the patch look good to me.

Thanks, both.  Let me mark the topic for 'next'.
