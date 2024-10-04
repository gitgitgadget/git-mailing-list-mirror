Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922D1DD863
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067686; cv=none; b=r2keS0CJ2c0r4/GuKm7SjAN1cBgF721woCCbScGviv/uuQ779out4qpSneK/12lm0h3JQEeaMmg/WWBqhtXOVcL8JeqSxNu/N6Sn4J36XRXQhN7VrGJzGQSKAINnjKZkCzElnqKx43kXNhdR0K6zt2M1RhN22WGpQMl7qzHsh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067686; c=relaxed/simple;
	bh=jaH8SorIMll/zpovYTOv2bxSD7WnmBtfpjqPIGo5G0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jItPQnonkJpFx271/U+IHfLltoO4aVKCIq2qa6HCm1HOKOVRnlq/eA6l7Owh6f05tARsSeoqED3evOfxooX7LevaTGybebyB9hTu24OPHjnn6IcDnBEgdussoznJuKkbHOWZHQL4PisxIo7qxqD8VXweU0oRSOrRPbWYH1zQ3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=G3CM0hSk; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="G3CM0hSk"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id wnLIsgdT9AMaswnLJsShXo; Fri, 04 Oct 2024 19:47:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1728067678; bh=IIQOjodjszCbMAEsqlrIdHxnWOtW3xeMhksLhArciU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G3CM0hSkH5LioP6JsqAFfhVLqiUg1X1MS96cFq/kMXZh8LOVGWloVTjv6ZpjAJ7YY
	 L35LlFGRd1EiMFo5p2z9sUQFcyYbPl6snNPpdd34BadbhsLBpQ0R0tfKg7LaylvIDd
	 c7ycsPjIRLq2ebUjq3HfKoqz1CFpSYRDaO2U3eT80Di/xYMVIBVbyoqMOI1SaKr9A4
	 ACAx+srNxYScAiMKW+ffJXtgi9eD1D0VQ1d8OuwUtQQdnewqIu3yHBSRqXwElyPvEs
	 JNMy5Vy6BcxsnaS96TjiW8Snpal58dogiqqDNW6Jp2d1zQIj8stnNUGde2/y88dVAo
	 Hc+PpV9xjrscw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JP6YsNKb c=1 sm=1 tr=0 ts=6700385e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=iqw2XKfirq_h4aKVsAcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <d350d598-fc99-4384-b2d5-5cc898a17c12@ramsayjones.plus.com>
Date: Fri, 4 Oct 2024 19:47:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fsmonitor OSX: fix hangs for submodules
To: Junio C Hamano <gitster@pobox.com>,
 Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Koji Nakamaru <koji.nakamaru@gree.net>
References: <pull.1802.v3.git.1727810964571.gitgitgadget@gmail.com>
 <pull.1802.v4.git.1728000433326.gitgitgadget@gmail.com>
 <xmqqiku7epa7.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqiku7epa7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM7JK3caxCeyfxtkoSTifGnf+HwiaDe3+E8PzKNHEn6HQ9hWXofcTTOwOVg7xyGlSfEcd5WSKZUec49HN3l8KEilY1rIU5/Que8jY9uhnylWBIztMwAJ
 1m9xAmheA5BuLWXdY5gxX2V3d9beMpBp9LsjVfpoPt25t7ArNaFR/g3txECrO0969DmL3i/LFhQItB/G6+kaakfeftMA3x4yPSk=



On 04/10/2024 18:44, Junio C Hamano wrote:
> "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> ... The test is
>> disabled for MINGW because hangs treated with this patch occur only for
>> Darwin and there is no simple way to terminate the win32 fsmonitor
>> daemon that hangs.
>> ...
>>      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "submodule absorbgitdirs impli
>>       +	done
>>       +}
>>       +
>>      -+test_expect_success "submodule implicitly starts daemon by pull" '
>>      ++test_expect_success !MINGW "submodule implicitly starts daemon by pull" '
>>       +	test_atexit "stop_watchdog" &&
>>       +	test_when_finished "stop_git; rm -rf cloned super sub" &&
>>       +
> 
> Let me update !MINGW to !WINDOWS while queuing.
> 

While this won't hurt, this test file is skipped on cygwin:

[23:19:33] t7527-builtin-fsmonitor.sh ......................... skipped: fsmonitor--daemon is not supported on this platform

(my eternal TODO list has an 'fsmonitor on cygwin?' item ...)

Thanks.

ATB,
Ramsay Jones



