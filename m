Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238738;
	b=cLmdEk3ROeoQ4kuzVmtSd0aGuUeS0NoMC1lTgHDjcUHxKIwGK47EJLGOZAtpvrpxOmnU
	 bRwwS0U7SI+38yGmw8mlWaavr9QjQYPKmX8IhvX14q9M/7tX4wW9SIKXKD0Jk6GcFuxTU
	 koFEeITsI0RPPv69I6ouUUjpYDjG4CkyEYkg09ZtoJ1HjwFKeSlm1uwAS+ket+uvramNO
	 46Jc81S3nbygVZed7KcXb66WMTEbYYUZpRHNwap7npW4/EQoaqBNUd4fooBBqn5JsiicR
	 1VlFgkUj3y+cyVeT/tMw5pUzRJyrqFLAhqZ9inISDjjiIo8F1Fm82gLeBRtUdH7q7Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238738;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=esLX6nFjB702RdkIXmwF83l3XY0qqKCp+0Od6rfLsUA=;
	b=Uk92ykWUfnBZd0j0XDH+0WjE4YG2isynOeXF2W9/h3JQggA17GrlFdX9/8UL8NUrClu/
	 z2K87kuVYZSkRcYHsSnAmOUGbYgNy/XMHwx0XCav7SyhMH73116FcyHwp65Fg2SWB7acc
	 udsKFZyvADu6i76GyWLY4Z1TPXfeMw+isTLoTiSvK+nAQjw3XXrpWbSjgJgtWWTU1K+Hy
	 owamZzq6dhYTaqkxLasTRyi345F91N260/tYyRfpvFjsy2afNmxjInBXaFAcrQNMs9ogw
	 aDmYykIU5O/5555YzbZxVXmUKiUT1qtOyPiRsZmmoaAQDxzYhfh/YSVX4glz+108sJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.15
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA94606A326
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA94606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.102] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4jNYpx16VNzRpL8;
	Mon,  9 Nov 2026 16:38:49 +0100 (CET)
Message-ID: <7b2e7ddf-dc8b-4538-b736-92217e20c8f0@kdbg.org>
Date: Mon, 9 Nov 2026 16:38:48 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
Content-Language: en-US
To: Kristofer Karlsson <krka@spotify.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
 <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org>
 <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
 <6992b7e9-8721-4e1f-9c00-9fd0e0704e80@kdbg.org>
 <CAL71e4NKsTZNoLFOuSPfiJPf7oS57S01MpM5V+UOr+bgMGjOkQ@mail.gmail.com>
 <c8688e1a-17b6-4d0b-ba9a-fc1e0fa8938b@kdbg.org>
 <ddea802a-d4f4-4de9-9108-e68201841bc4@kdbg.org>
 <CAL71e4PSOJgKFfBLrTXJSAewnZTJpNEiAMC-_FbW_9cmpEvLmg@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAL71e4PSOJgKFfBLrTXJSAewnZTJpNEiAMC-_FbW_9cmpEvLmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.11.26 um 14:05 schrieb Kristofer Karlsson:
> On Mon, 9 Nov 2026 at 10:33, Johannes Sixt <j6t@kdbg.org> wrote:
>>  test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
>> -       test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
>> +       # 3 * 715827883 == 2147483649
>> +       printf %0715827883d 0 0 0 >expect &&
>>         huge_commit=$(git commit-tree -F expect HEAD^{tree})
> 
> I tested this and it passes on all the macOS jobs.  t4205 goes
> from 800-900s to 170-280s there, so your idea works well.
> 
> Two caveats: the printf builtin in bash 3.2 (/bin/sh on macOS)
> silently prints nothing for a field wider than INT_MAX - 15,
> and it builds each field in memory, so this peaks at about 2.1GB
> RSS.  Both go away by writing in 1MiB chunks, at the same speed:
> 
>     gen_ascii_zeros () {
>         _n=$1
>         while test "$_n" -gt 0
>         do
>             _chunk=$(( _n > 1048576 ? 1048576 : _n ))
>             printf "%0${_chunk}d" 0 || return 1
>             _n=$(( _n - _chunk ))
>         done
>     }

I wouldn't do that (and pay the memory price instead), because the next
shell doesn't have printf as a builtin and spawns 2000 printf processes.

Now let's stop painting bikeshes. I'd be fine with your previous
suggestion to have both `test-tool genzeros` and `test-tool genbytes`.

-- Hannes

