Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473F4084F
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144407; cv=none; b=VlbvaqHjFj7g3Tv/nt8xT/7XmoCSX9tMPkfpcqcKb8/QRIiFO7vgmKSC5jhTgoxAmo7ABA56p/DcQ5GUbyQ2qlM7mlyjPdU7zzFCSV+LoRhSkMOhUCatLkGbtmsJsedQkxE3AsNqHcKQtt06GQ8hLzSFrm/pJWiYW6441vPiBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144407; c=relaxed/simple;
	bh=NLBfkSv9lof2Mr5x+p0VLeEMuHKFADiaSSPKZCFy2IM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r8B2ltEAIFRhg7tGaIpaWmMJ4+VbfzGgptnViNeizFtxIgE9xOyxSARi6YVbFFBaytIP0jW82OJp5Wgi5wXNJio6mlV3ISJxcYQLNzYl7G95pSH9niTOTpy+Duj3UJ8iD8lvnssrO9U504poQIuN71o22ftGi7b4JX2yWSUyRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yIBrooQ1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yIBrooQ1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 820FE1DBC04;
	Wed, 28 Feb 2024 13:19:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NLBfkSv9lof2Mr5x+p0VLeEMuHKFADiaSSPKZC
	Fy2IM=; b=yIBrooQ110mwN+j6BJ1AVgOuoyZBbRtaX2mKVNskHeDiLzJe878PAN
	TG2RAc7ZQoLyGri4tPFGGh/U3zc2pyEIB91DwNeCLyEkPBMmvsmAQ5SvZ2TOY9JA
	3Xz/iRPM00c5HZ7TYAmFPOJKsSZABMmmJlvX3+zD9Ipnr5ts8qlXw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 76CD21DBC03;
	Wed, 28 Feb 2024 13:19:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD93B1DBC02;
	Wed, 28 Feb 2024 13:19:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergius Nyah <sergiusnyah@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  pk@pks.im,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC][PATCH] Userdiff: add builtin patterns for JavaScript.
In-Reply-To: <20240228150034.313196-1-sergiusnyah@gmail.com> (Sergius Nyah's
	message of "Wed, 28 Feb 2024 16:00:34 +0100")
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
	<20240228150034.313196-1-sergiusnyah@gmail.com>
Date: Wed, 28 Feb 2024 10:19:57 -0800
Message-ID: <xmqqttlsjvsi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB2F1C28-D665-11EE-9EE0-25B3960A682E-77302942!pb-smtp2.pobox.com

Sergius Nyah <sergiusnyah@gmail.com> writes:

> This commit introduces builtin patterns for JavaScript in userdiff and adds a new test
> case in t4018-diff-funcname.sh to verify the enhanced JavaScript function detection in Git diffs.
> Signed-off-by: Sergius Justus Chesami Nyah <sergiusnyah@gmail.com>
> ---
> ...-PATCH-1-2-Add-builtin-patterns-for-.patch | 53 ++++++-------------
> t/t4018-diff-funcname.sh                      | 25 ++++++++-
> 2 files changed, 38 insertions(+), 40 deletions(-)

You apparently have done "git add" of a file that is a format-patch
output, which led to ...

> diff --git a/Pattern/0001-Subject-GSOC-RFC-PATCH-1-2-Add-builtin-patterns-for-.patch b/Pattern/0001-Subject-GSOC-RFC-PATCH-1-2-Add-builtin-patterns-for-.patch
> index 43593866bc..9c3b80665e 100644
> --- a/Pattern/0001-Subject-GSOC-RFC-PATCH-1-2-Add-builtin-patterns-for-.patch
> +++ b/Pattern/0001-Subject-GSOC-RFC-PATCH-1-2-Add-builtin-patterns-for-.patch

... this thing.

Wrap the proposed commit log message to a reasonable length and have
a blank line before your sign-off.  Other pieces of advice about
formatting and contents found in Documentation/SubmittingPatches are
also helpful.

Thanks.
