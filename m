Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A8F5491F
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943166; cv=none; b=KwauhH2L8Lz+2xCR8FUxQ7OYt3d39hF3AlMgSQ9PKQAKiDP+8UOVQG4V5UYODp6hQ1Sw/TSpG4iSC4bw76jsgHfnX7dAR1zJGo47oWgLtSmLEyxuc7ipxOC35VpMXMlNJdTbYt0bBP2l/EoUf4C1mq9inIy24/COvW3wTXte6fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943166; c=relaxed/simple;
	bh=lLXE0VR0zhPGTcy6ci+RFmnfb+CdH+7TF7uWnPuC6HQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cms4zc20MFJsPBCDRYQ7RxtCl13/tne6+m1dHI5Pco584WzDRW7uVgBBjKr+MSVGTh4bygln61nW5WH+ay4sLvQRIrRcuS5tpwXtlh4xTPsJx/x3wGizd4VbUgrnFotW2zKyJRcefkfpIKn6Y/0HhX+G5GHO5G6i1fdk/QTuWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e2gBdh48; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2gBdh48"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A0221E1502;
	Fri, 12 Apr 2024 13:32:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lLXE0VR0zhPGTcy6ci+RFmnfb+CdH+7TF7uWnP
	uC6HQ=; b=e2gBdh48b9/55IW7MtucCikdOy6MQ5qtD8flDZAUSDlhIy9tG7xnrt
	awngdqrXqTc3Jd6ZcuC6swDocVSUF/SOYXwZEFFJ6t2k1c6O2synZTfeg+RAF61T
	DnL40tEpZlyQPjNSBASbOS6BeZVuEpngMMlu3D0tct0XegxaQC8HY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40B2B1E1501;
	Fri, 12 Apr 2024 13:32:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A53F71E1500;
	Fri, 12 Apr 2024 13:32:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: "L. E. Segovia" <amy@amyspark.me>,  git@vger.kernel.org
Subject: Re: [BUG] Clones from local repositories do not work correctly
 under Windows
In-Reply-To: <01cf64db-2ff5-4be5-8968-d280ab0ffc50@kdbg.org> (Johannes Sixt's
	message of "Fri, 12 Apr 2024 18:16:35 +0200")
References: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>
	<2f069d1f-aa4a-4259-9cc5-dcf912f59a17@kdbg.org>
	<e25bbce7-8338-430b-865f-690fe3c94fb6@amyspark.me>
	<01cf64db-2ff5-4be5-8968-d280ab0ffc50@kdbg.org>
Date: Fri, 12 Apr 2024 10:32:42 -0700
Message-ID: <xmqqil0mmqpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AB6D6E2E-F8F2-11EE-A7CA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> alternate: C:/Temp/repoorig/.git/objects
> alternate: /c/Temp/repoorig/.git/objects
>
> This is the MSYS2/Cygwin absolute path with a "drive letter".
> Unfortunately, this kind of path is unintelligible for Git for Windows.
> It expects absolute paths to begin with drive letter-colon or a
> double-slash or double-backslash. For this reason, it reports "unable to
> normalize alternate object path".
>
> The conclusion is: Do not use two different flavors of Git on a
> repository that is set up with a link to an alternate repository.

I do not complain to the conclusion, and I do not use Windows, but
it makes me wonder if there is a way to spell that full path that
can be understood by both implementations.  The two implementations
are not incompatible in the actual object contents and refnames and
other things in .git/ directory, are they?

In short, does MSYS2/Cygwin understand paths in "C:/Temp/..." style,
and if so, writing that out, even though it may not what it
considers the native format, would make the world a happier place.



