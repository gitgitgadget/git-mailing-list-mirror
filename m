Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9ED19D081
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436733; cv=none; b=oXOG1XezYa8DEYsBw9lyCXnf7wkOMBwc4l+nTjVLSlGYD/ehjK1F1leDn5abSDXHNZXFIrASVM3rf5SpGgv4QpRmsw0S5/qpxzrppVBy4SBF0qMsWrs3V7zNdSDpox0PKkJvirwW80KRE/RoNKAi0r/a4peGNu260IUiTViaVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436733; c=relaxed/simple;
	bh=c+JmoQ/kK4r6FMGycuYkCUmeww6gHss41D2g48Tz+Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2m8MTAASjXPCCpKdGyp77VDT+Jq6LKvAdHqf4+qwlfFBgGLL7PhOO6co6fCMIOMYgIq4sOX+s7Hn6yh+jSVNTFlYyOZtTlhm5EuI6aMgOF3wbDTDPZDvf9fL23LPLc2oXGJDvARb76thxjm/WIKqYydwE9XwT4B7whldjB6MUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGO5Ci+i; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGO5Ci+i"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e6deb3eb7dbso163290276.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745436730; x=1746041530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgIzDX+fXb+shi/my1s8bqnC/E5FEiztebN06PiWNz4=;
        b=FGO5Ci+igWyHhD/vhcJFeFfKw5GAD2kIAZ6YYFDTZ1jIDlouweG/VvYCH1pQFYxw8T
         yzXkMVhwCAijBHFjuybghZLMsujJthrrmIFsfZWqdBnXsrpO+ho8QLc24NXDkwROrcHa
         DwvYJ1gCYi3Ryqlwuf7SyMVUL9AwFiTX0pEp9MLTuR9D3sRuU20sciADlQoha/HcHz3i
         iDnsJtfLWxg1suv7jALeMbx3l0VESzEVZCCEj/M3pFWIYuhTk6iJGzcxorcpc2pv9wXg
         XuSxcpvfxoWEf0Xht1IvC0o2PXqpmTNI0+fZrSJJiuF5qzGTh2D/pYE/bcJHC94kEDc3
         vO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745436730; x=1746041530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgIzDX+fXb+shi/my1s8bqnC/E5FEiztebN06PiWNz4=;
        b=WZQ9r46esRuFD3LeBIpjMt4EBnXoIWYiw/fH6BTqEffH9IyYisRmAI7GaZmkbsSOnj
         9nP2VxlZOlAy0KKR2dECAB0NNJm16IMGmeYShD1J5b2krbvWT/OMxPdRbgHJYY/iHmAz
         Ogd7PcUsu9iLV8h3tiqEOHWk7Bgnb5YBz+XsktN7zEIr/Q0ITN0jildIdhx7maurmAaD
         o5wR5Mj7yfqE6ZBvAnpKUPnH0lJQamMXnKXWk7cQ4ozoEohoDlrxCsHJFA2Ok+pppprf
         asI4WFNJtUizCmbC/sL67pb1ecSb4spt18lOO/TEapKFJ7+VaAeK2xYwboKVYERPa+Ax
         G49A==
X-Gm-Message-State: AOJu0YwD2XcBnX060tc/gkPNk/ikSoiLWGxdfuKHM3ezsjCvqsvCJxtW
	2aS8nh+zyAhKmJbFPycUS5gebaNbN85zt+/RtX09F0RkuPs+5Tid
X-Gm-Gg: ASbGnctMnhG0QAFUFNUz3dkazfvNwEpP+p9pwUndcDlzCGqJxVHmBljREU6HTcYhwiZ
	mxqjfatK5WIHMVeFCdkX97cLQCcOuto9ntWlI0oVHKSGbO9lTpzcPd3o5Nq34HFYClFo6v+tr5v
	vRnOVh6vWyBc+W69ye3KTNgcjWQLQd43S6ZDcqQwAfzkutyNS49aRUvGzeqOPkhQWRfcz6jPs8U
	a0J7EtxIZK6TpUCu2KvYVPmQSYf28V5oNQMDI13JT5qe5iXBIEiqdOguhYY6AEOyc8DIXshAn0a
	kuYHlFT/Vi0TlaZlvQU1UazqqbbKSHiFdUwStsK/lO9CSWaCEgov7peS4UiVMT9+9CHIklEKuoO
	3jAtznqEIcFhESFTD
X-Google-Smtp-Source: AGHT+IEw2jY6iHJI0883nCT0NHlNxNRwbnrVCD2KfnZhis8dVSehM9RVHcGUwzzyypdqeCiHtXgqDg==
X-Received: by 2002:a05:690c:883:b0:6fd:2062:c8a2 with SMTP id 00721157ae682-7083ebfe076mr1450747b3.11.1745436730533;
        Wed, 23 Apr 2025 12:32:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a542:402d:78ab:7227? ([2600:1700:60ba:9810:a542:402d:78ab:7227])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca53bc90sm30976317b3.83.2025.04.23.12.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 12:32:10 -0700 (PDT)
Message-ID: <460cd77b-2b49-4159-bac5-0fd4fb655f84@gmail.com>
Date: Wed, 23 Apr 2025 15:32:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
 <xmqqmsc6y911.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqmsc6y911.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/2025 3:26 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> When trying to demonstrate certain behavior in tests, it can be helpful
>> to create packfiles that have specific delta structures. 'git
>> pack-objects' uses various algorithms to select deltas based on their
>> compression rates, but that does not always demonstrate all possible
>> packfile shapes. This becomes especially important when wanting to test
>> 'git index-pack' and its ability to parse certain pack shapes.
>>
>> We have prior art in t/lib-pack.sh, where certain delta structures are
>> produced by manually writing certain opaque pack contents. However,
>> producing these script updates is cumbersome and difficult to do as a
>> contributor.
>>
>> Instead, create a new test-tool, 'test-tool pack-deltas', that reads a
>> list of instructions for which objects to include in a packfile and how
>> those objects should be written in delta form.
>>
>> At the moment, this only supports REF_DELTAs as those are the kinds of
>> deltas needed to exercise a bug in 'git index-pack'.
> 
> Wonderful writing.  I agree with the destination where this effort
> wants to go, including the decision that starting with ref-delta
> only is a good enough first step.
> 
> As to the implementation, I was a tiny little bit bummed to see
> that, even though it does share the code with the real pack-objects
> code paths to compute delta data by calling diff_delta(), and to
> write per-object header by calling encode_in_pack_object_header(),
> it has its own compression loop that does not even do an error
> checking after calling into zlib deflate machinery.

I could strengthen these options to help folks more quickly understand
potential failures as being part of the pack write instead of them
failing during the later pack read.

> Perhaps that is unavoidable due to the code structure of the
> production code.

I briefly considered extracting some code out of builtin/pack-objects.c
but it relies heavily on globals and context that I won't have in this
helper. I'm open to suggestions for how I can safely share more code,
but my initial attempt required too much refactoring to be worth it.

I am grateful for the amount of code from pack-write.c that I _was_
able to reuse.

>> +static const char usage_str[] = "test-tool pack-deltas <n>";
>> ...
>> +int cmd__pack_deltas(int argc, const char **argv)
>> +{
>> +	int N;
>> +	struct hashfile *f;
>> +	struct strbuf line = STRBUF_INIT;
>> +
>> +	if (argc != 2) {
>> +		usage(usage_str);
>> +		return -1;
>> +	}
>> +
>> +	N = atoi(argv[1]);
> 
> It somewhat looks strange to see an uppercase N used as a variable
> name.  Together with the usage string, how about renaming "N" and
> "n" after "number of objects", e.g.
> 
> 	test-tool pack-deltas <num-objects>
> 	int num_objects;
> 
> or something?

I definitely should have used a better name here. Thanks.

-Stolee

