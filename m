Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A1134431
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233612; cv=none; b=CAOmmEkfhl1KGdInTXXQd4SHX3o019U/L4qTesHquhPySzR/T4g3+vft93+w4J/xDgPZCzrpbPs0zQ4uBN2Rk2U/XJ6US8Hc/9UOiH32yJw7IIEWOh9+OeN98PIbj1KIcF3D9rZeZx6JAA/ZkaQ6rzp+AzlxiXdBGunAATl48Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233612; c=relaxed/simple;
	bh=zwKRpVuia8gTOHFl5VxKmx3E+WsBkHAvSBydKXMH5hY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pm+0CusGI5Fh308fcNMBZBZ3QTTwnCh0xYGmvLS4po/uNnAxCubWH/FkeUtLZix8XQ6GMJ4NZSjBmDLVRLYN9YG91d8p/q4Mo7pdK8lCydn10jFz4NS0vmRdQh2dDoUKw9YQQUf3feWyghh3gFDm+W9DOyiQ6VFDBVD7W3rFym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=isgMmm2e; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="isgMmm2e"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC7491D15F7;
	Thu, 29 Feb 2024 14:06:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zwKRpVuia8gT
	OHFl5VxKmx3E+WsBkHAvSBydKXMH5hY=; b=isgMmm2e65EC09hQ+iOUz0Lwa3Ft
	de1ck/Lh7gqQscJnUvoPX/u2oJHhWpWkC9gAqhoaOF6a7s3J16LKOd/xzneE+Ulw
	iuWtKl8g8SnadHyzAA+Cj/aXcDquWdCBII2AaRtJZ+eZMi1EyOJ0rY7PEUKwUtyp
	9cm5DMxtn9xYLf8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B48E21D15F6;
	Thu, 29 Feb 2024 14:06:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29A011D15F5;
	Thu, 29 Feb 2024 14:06:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] [GSoC][PATCH] t3070: refactor test -e command
In-Reply-To: <CAPig+cR2-6qONkosu7=qEQSJa_fvYuVQ0to47D5qx904zW08Eg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 29 Feb 2024 12:58:03 -0500")
References: <20240229150442.490649-1-shejialuo@gmail.com>
	<20240229150442.490649-2-shejialuo@gmail.com>
	<CAPig+cR2-6qONkosu7=qEQSJa_fvYuVQ0to47D5qx904zW08Eg@mail.gmail.com>
Date: Thu, 29 Feb 2024 11:06:41 -0800
Message-ID: <xmqqzfvjf5tq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AD10C50C-D735-11EE-881C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -175,7 +175,7 @@ match() {
>>         test_expect_success EXPENSIVE_ON_WINDOWS 'cleanup after previo=
us file test' '
>> -               if test -e .git/created_test_file
>> +               if test_path_exists .git/created_test_file
>>                 then
>>                         git reset &&
>
> ... which _do_ use test_path_exists() within a `test_expect_success`
> block. However, the changes are still undesirable because, as above,
> this `test -e` is merely part of the normal control-flow; it's not
> acting as an assertion, thus test_path_exists() -- which is an
> assertion -- is not correct.
>
> Unfortunately, none of the uses of`test -e` in t3070 are being used as
> assertions worthy of replacement with test_path_exists(), thus this
> isn't a good script in which to make such changes.

It seems that there is a recurring confusion among mentorship
program applicants that use test_path_* helpers as their practice
material.  Perhaps the source of the information that suggests it as
a microproject is poorly phrased and needs to be rewritten to avoid
misleading them.

I found one at https://git.github.io/Outreachy-23-Microprojects/,
which can be one source of such confusion:

    Find one test script that verifies the presence/absence of
    files/directories with =E2=80=98test -(e|f|d|=E2=80=A6)=E2=80=99 and =
replace them
    with the appropriate test_path_is_file, test_path_is_dir,
    etc. helper functions.

but there may be others.

This task specification does not differenciate "test -[efdx]" used
as a conditional of a control flow statement (which should never be
replaced by test_path_* helpers) and those used to directly fail the
&&-chain in test_expect_success with their exit status (which is the
target that test_path_* helpers are meant to improve).
