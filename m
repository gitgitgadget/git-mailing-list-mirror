Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7CBA20
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289183; cv=none; b=KgvsQChXifUbeYSyPxKOGPug8AjVKbxEsE5Ccsh6NTCDLT+wuOxTiMC4wGrhVeZtoIsTFqV1LbkUqP6daBayNyTv6szI+wHhfabRn5FZVnMBgNskySecJOQLYx9OX5BO//YnC2uh/cr8euPlsxrg23Vku4skBx+TrzEBRYKJdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289183; c=relaxed/simple;
	bh=Vi19xiQME3V3X6viusmuyFc8b1rzXPitxZointB/Q4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kis3go01usQWP/onru41M5ohnLs9/sMeYLSK8Vp1sIFzUzdrFS4pP5c/6x6WxPc9gmSz7ADw8QPf4Z6ygKaLI3X+qgSXq41U7IFwFlirNmOh6Qx611DAT75CFRbasrCzm9+hIufinpRs0x6PxTuR1H3p1PvTK+28xO3b5d6Me4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfrO8cI6; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfrO8cI6"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3882273bc8so2123320276.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732289181; x=1732893981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/oLMAL4hiUxkLm9HqF/GdDBFhYF+HYyOqyi0ZE1DRgo=;
        b=XfrO8cI6Z4t31ZN6q7eWWI6yE+XXQb8Wp2+SdbqFBp2kzSc62bsgv0Y0VDCVNrzgRs
         KmF/+g+xEMtOO+hjldY3FR4pDiJzPEL8a9hkpRgl8U//aFwl697VOO0a006xYRHB1IV7
         PEOoo6Ce5eAbIOvewDvapvVzk3XRj5iJ86mvc7y02n2AX7vFERTVuPxIpN3zrwHHpLSF
         ShssRCy1r42cQzFv2ftC3hZA+TZUcSCs29EkQpkYbq1jAuSFkjOIiuZPfyuty6DjS8BO
         g223nI+seA2fTJo5xHc5JuHhPFvU43cxcG5Dv6rwa7L2iN6X7ltrmEaj9J6eX1IV3eRu
         Zf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289181; x=1732893981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oLMAL4hiUxkLm9HqF/GdDBFhYF+HYyOqyi0ZE1DRgo=;
        b=btApshq6+B7Fqu5wf/49GF8AkyVrOu3DXrBq55WYqVZeUCor78dssq8wCkEd+v0jTp
         Hvx5LAvF/yq2v55FaaxCpHzE/7Zw0uBSth7NfDZxu9kA/Awk66cSyvbGyzCMy3Ine2tQ
         nojC1M23z2YTI2syr8sYqAvldxvyWEKiAD14Tq8wsVoQMmjrVnTcXi47g27BbZszUzEp
         c+cugBOqDFsOTrfbFOqarLGsXP9xsNNULX5tuAHa3nZZpCiMO/h2bQ8+YS6nLAaTrhiU
         BPx0UHvIV6iI+MTd6vonQTP19xRc9x9vzLjQEMDK+ULqUTWIs2G9FROT3Zu3Yx1ND4dU
         IA3A==
X-Gm-Message-State: AOJu0Yxdw1HmOuTlXouLjee3YhLQlzYEn98CYVydGDK6KeNkKG++CjUk
	vvwxsUcNEdT/g2NyTRCXRVqEWlE0fJQ3UPU/mKQJvOeLLgOg1Kvt
X-Gm-Gg: ASbGncuiZ4DNJj4tFvj0Vk8vtl2KU3U+QFYi7ITyLts6Oi33LZIQ2oHwm3wRaJX9pjR
	4pmsPQaEIpcs0A0cXCApV++Yi761NpdJHZYQagAAEMlHi6M9uMBR2uu55yZ1p6IgjKkouAS4KQZ
	ZfKvzOZJ/im1aq2QjRfqOKs7hUJCL6btO2IYcxNmYXQMzjYOqz7suKAISIwKyU7z0llBAMWwE88
	o4KvkeojQj9jnEYlXOezRq6epG6FCYBOIe0MIFqMf4g3crA7OSElKIBq96lA08Ylc0dxYfHTceT
	Sf1OhCXFtgUDiuEBdlPEF/UUZb6+ShwCLR60sg==
X-Google-Smtp-Source: AGHT+IEzyv0e0u8WNRaFeTerk0jI7Qu/fyAGTEnXG5BdGcRCXBbYZo6a6rGaoBAF4i4qP/a78EvrOw==
X-Received: by 2002:a05:6902:2382:b0:e2b:e0ba:d4f with SMTP id 3f1490d57ef6-e38f8afea50mr3357451276.18.1732289180599;
        Fri, 22 Nov 2024 07:26:20 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:313f:79e7:4a86:b985? ([2600:1700:60ba:9810:313f:79e7:4a86:b985])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f60b50bbsm645140276.36.2024.11.22.07.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:26:20 -0800 (PST)
Message-ID: <233d4261-64b3-4149-bb6f-aeba66834c1c@gmail.com>
Date: Fri, 22 Nov 2024 10:26:19 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] p5313: add size comparison test
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <c14ef6879e451401381ebbdb8f30d33c8f56c25b.1730775908.git.gitgitgadget@gmail.com>
 <Zz+YrvL8h0Cxwqfy@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zz+YrvL8h0Cxwqfy@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 3:31 PM, Taylor Blau wrote:
> On Tue, Nov 05, 2024 at 03:05:05AM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>

>> The thin pack that simulates a push is much worse with --full-name-hash
>> in this case. The name hash values are doing a lot to assist with delta
>> bases, it seems. The big pack and shallow clone cases are slightly worse
>> with the --full-name-hash option. Only the full repack gains some
>> benefits in size.
> 
> Not a problem with your patch, but just thinking aloud: do you think
> there is an easy/straightforward way to suggest when to use
> --full-name-hash or not?

The kinds of heuristics I would use are:

1. Are there enough commits that enough files have enough versions
    across history that it's very important to keep deltas within a path?

2. Is the repository at least 500MB such that there is actually room for
    a "meaningful" change in size?

3. Are there a lot of name-hash collisions? (The last patch in the series
    helps do this through a test-helper, but isn't something we can expect
    end users to check themselves.)


>> +	cat >in-shallow <<-EOF
>> +	$(git rev-parse HEAD)
>> +	--shallow $(git rev-parse HEAD)
>> +	EOF
>> +'
> 
> I was going to comment that these could probably be moved into the
> individual perf test that cares about reading each of these inputs. But
> having them shared here makes sense since we are naturally comparing
> generating two packs with the same input (with and without
> --full-name-hash). So the shared setup here makes sense to me.

I also wanted to avoid having these commands be part of the time
measurement, even if they are extremely small.

>> +
>> +test_perf 'thin pack' '
>> +	git pack-objects --thin --stdout --revs --sparse  <in-thin >out
>> +'
>> +
>> +test_size 'thin pack size' '
>> +	test_file_size out
>> +'
> 
> Nice. I always forget about this and end up writing 'wc -c <out'.

I believe this is a Junio recommendation from an earlier version.

>> +test_size 'repack size' '
>> +	pack=$(ls .git/objects/pack/pack-*.pack) &&
>> +	test_file_size "$pack"
> 
> Here and below, I think it's fine to inline this as in:
> 
>      test_file_size "$(ls .git/objects/pack/pack-*.pack)"

Generally I prefer to split things into stages so the verbose output
provides a clear definition of the value when calling the Git command.

> ...but I wonder: will using ".git" break this test in bare repositories?
> Should we write instead:
> 
>      pack="$(ls $(git rev-parse --git-dir)/objects/pack/pack-*.pack)" &&
>      test_file_size
> 
> ?
While this would break a bare repo, the perf lib makes a bare repo be
copied into a non-bare repo as follows:

test_perf_copy_repo_contents () {
	for stuff in "$1"/*
	do
		case "$stuff" in
		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees|*/fsmonitor--daemon*)
			;;
		*)
			cp -R "$stuff" "$repo/.git/" || exit 1
			;;
		esac
	done
}

I'll still add the `git rev-parse` suggestion because it's safest.

Thanks,
-Stolee

