Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9736166F
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857345; cv=none; b=Yy5ZdcKLAE3vjlnOUc/rhnUCesZ18KmUH9HBmJFVaZBP0vot2LOAaJdbQ8gmzj0snQxz1lUip5B8GigfN89wrePnLKxrpaYqOmjKpLvTl3bbnqtT/VTV+PPzIBIvJ8/NdfN5ujInQSBMFp7lQq+kbGK0ef5m+T+9fWDCCdlopzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857345; c=relaxed/simple;
	bh=I/it9GITc5I07AsB6/Q1jxhH/rJKXWwoFCT6qm2DPU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eaIGVufPgwOcSTnt/P14Dz1cNK1s/0ByS4U80a+1a2Ng9fdbD4jb7npC0rz6G8Leb/LU4X3OsZF8JbX3dAOfZ3dhkcjQpae9IeZ51/8pKra9UOfVef1JUx6bN1WJXV/Actzl/5Q4b44Bf6tggCAHJL/4EBP8jdNKkGr8OZ4eOeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rt33rAQ5; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rt33rAQ5"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A565819F95;
	Tue, 13 Feb 2024 15:49:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=I/it9GITc5I07AsB6/Q1jxhH/rJKXWwoFCT6qm
	2DPU0=; b=rt33rAQ5AN/Lvqe2Z1sTCyjMHvJwqx4dCrpR5PDayDKto4/7OombqI
	sBuNEaXKKzUay101Y0x351B0AhfZoh92j0I575SJIXg6jgRrpIS/FSH+3n3C2sDR
	dcv1CBmcDQICX51U1wPyoWGzX9Y+DBd9+gmJHuLI/BCLK97DDdSWA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D73F19F94;
	Tue, 13 Feb 2024 15:49:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3325019F91;
	Tue, 13 Feb 2024 15:49:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2] unit-tests: do show relative file paths on
 non-Windows, too
In-Reply-To: <0fb4e912-b25e-0240-c49f-aac5cbc3ef9e@gmx.de> (Johannes
	Schindelin's message of "Tue, 13 Feb 2024 20:58:53 +0100 (CET)")
References: <xmqqttmf9y46.fsf@gitster.g>
	<6872b42d-8763-44dc-9502-2362d1ed80a7@gmail.com>
	<xmqqle7r9enn.fsf_-_@gitster.g>
	<0fb4e912-b25e-0240-c49f-aac5cbc3ef9e@gmx.de>
Date: Tue, 13 Feb 2024 12:48:58 -0800
Message-ID: <xmqqzfw43xad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 506A9F16-CAB1-11EE-80BF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +		/*
>> +		 * The path could be relative (t/unit-tests/test-lib.c)
>> +		 * or full (/home/user/git/t/unit-tests/test-lib.c).
>> +		 * Check the slash between "t" and "unit-tests".
>> +		 */
>> +		prefix_len = len - needle_len;
>> +		if (prefix[prefix_len + 1] == '/') {
>> +			/* Oh, we're not Windows */
>> +			for (size_t i = 0; i < needle_len; i++)
>> +				if (needle[i] == '\\')
>> +					needle[i] = '/';
>
> This looks very similar to the `convert_slashes()` function that is
> defined in `compat/mingw.h`.

I lifted it from your later loop in the function, but given that
many of the things that needed on Windows came from you, it is not
surprising if you have another copy there ;-)

> It might be a good opportunity to rename that
> function and move it to `git-compat-util.h`, then use it here and once
> more below at the end of `make_relative()`.

Right.  But not as part of the -rc fix.  Let's leave it as
#leftoverbits.

Thanks.
