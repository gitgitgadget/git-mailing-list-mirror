Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A942B2D7
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710221123; cv=none; b=ZQthSuIHXB6S78YnwdRMz32qfKL+boY7LITwyZPteOl9Q2dqeyB8zVNDCuzXpmhUbXPN+6BHwZMA8v8qygTnLLdv20Wbs9UF2NDAs/ReoxRv3XMrGlLAsBv6hETwtL7qzZgSfmZrhxRDl5a/BJOX3hldUak6nKZURSd/sPdHe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710221123; c=relaxed/simple;
	bh=5hw5jN5rN24yu8BUmTVMP3TunwonVuXJvA0SkT0M0rw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGFCj0ejKdLp/Ln31cFeocy35KYnsETHALbvgzAJsNaZJSm9R56rl786/Z7/gPm4f1+WzikUh3dHPrw8k3Kzave44AHGU6Zf6g/yVM2ZZXyeG3ivP8ho0hs23q/2WD9Ul3mp4BOkqGayTRUvDx6SouXEVuSqQ2nqGMTyUniAT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MBErJ7Ms; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MBErJ7Ms"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 68EE62AC37;
	Tue, 12 Mar 2024 01:25:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5hw5jN5rN24yu8BUmTVMP3TunwonVuXJvA0SkT
	0M0rw=; b=MBErJ7Ms4YjPy++xQpOmscOPhb+IDTOxpEg/qa/DQDsSb5xveGa2pM
	j4INpSvkFfZwTFk7KXZ2EM/BR/d6my16prUO+om8Cmi4Cnco8tUNoQGotzNVyQ49
	UFn7NvzO21DeKVcU4CHUEdDzUPexvpTrO1TWxBvEG81NpUpcTgS4M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 54CC52AC36;
	Tue, 12 Mar 2024 01:25:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E57842AC35;
	Tue, 12 Mar 2024 01:25:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Richard Quadling <rquadling@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Using git-prompt.sh is wrapping text to early in Bash.
In-Reply-To: <CAKUjMCUEmrC8XfVKC4AkCzDyqWziPjDh5EiNmx02xQF=SVBVzQ@mail.gmail.com>
	(Richard Quadling's message of "Mon, 11 Mar 2024 13:34:14 +0000")
References: <CAKUjMCUEmrC8XfVKC4AkCzDyqWziPjDh5EiNmx02xQF=SVBVzQ@mail.gmail.com>
Date: Mon, 11 Mar 2024 22:25:16 -0700
Message-ID: <xmqqsf0wkon7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E9BC4388-E030-11EE-88F6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Richard Quadling <rquadling@gmail.com> writes:

> This is my first attempt to supply a patch to git considering it
> pretty much never fails me!
>
> If there is anything else needed, I hope I can provide it.

Thanks and welcome to the Git development community.

Documentation/SubmittingPatches is your friend to see what are
expected in a patch, covering how to pick a title of a patch, how
the changes are explained (and why it is so important to do so),
what's the procedure to "sign-it-off", etc.

Thanks.
