Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E7249E5
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302125; cv=none; b=dXM/NlCu5pf0Zgz/QzTS4W1ZmzcY/gvoxvJfVi4roQEdGcSMWcFA+TwcTj1YaaIe5uy+eZ76/p/qFnQKEIINKOJ/qArGdrmvHR0hmV1JEWg3uVf4addjpjYnOtaW8+e6Be6BqXBdoavpdom/7qXMXnLex5qXT6+5XSDfDpqSokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302125; c=relaxed/simple;
	bh=4P20cA87Ek8J5M2KEkI3Emchev2oNelUqHo/hRYZjZA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cFYSuzjMInGieCKGFsbheHhiE1BQOWza9lzXinJ59wOPRZjs28Z6/OZG11+iTHBdHaF9qa0vbZikmJ40U7V3hktFhHwwSt0SI20aQ/WyG54gpcixuzmgSZhZQw96P02R8gyKDTgD8sQ3+WZJJg9fp2a/WRnJX+s6bdLKnCC4KZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMpQJ+v9; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMpQJ+v9"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d405853c0fso15645786d6.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732302123; x=1732906923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+R6LofvQfFhQjFHov1ip2FC+G9AOR7RG76PHjl1Aro=;
        b=RMpQJ+v9pwZ0wKUlOfJwuzsAURtilQoWGQSCnLUG5u6DGYzyDZtlAe3s5BFD/Utalq
         G2jPqiZweL7mRjPrhwKc2qI7IyEo+P4jDmt2crJoS2ME9vt336JZrtFfjOvu8P6IbjEr
         EMMu3TahXNFGDHwb5fuKVcwzDNf8J0JkePRNG8r21JY0cQ+A7exefXRBCn5ani4s9Xx6
         p7y0rPJv0Qe+BOiKC0yqaYLDxPPfrhkOrvA7ZK2MLZqWuLOqvevYZ3R5YfXnNXBfBS1j
         W1PGHOXZJAp2w0+iFOt7zW/ZMcp2ggto6JcwQgA/XrCbbg35LM1a5BBjQdSevEKIc4I4
         ZTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732302123; x=1732906923;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+R6LofvQfFhQjFHov1ip2FC+G9AOR7RG76PHjl1Aro=;
        b=E8yNYHFZ2AooyV0R+qxncg0TSflR6uEHcWIvk7T6ns4hAv+bgUDiQJtHRzKKngqWvE
         3DFYOV8xSvyQAYFkInEr3qdnLbsQW6zJrCqan4kltrrT7uYXLceSKiPT/wWzaALQCQJU
         FP1gG2mxmksWT2Qorzzdvj8As8QgNw61fp4qsEAIaR/8lpX593M5zaMDrdwwnt4r1Qji
         xmKa0q9r/TQOGOObvs5stLeyS+0DJWxAA6rumuh6oORSjiM/g/V8OJAdLtj2Xc+Pgikq
         N8lKvgkd0zlf2e7Kt+Rwj9s0l0brKprVrovlMZ2d81vOLb96QEdgHwnZVKup1gtaR1A2
         f+Xg==
X-Gm-Message-State: AOJu0YzEEeKAEvjCkgi9LF2XK1Jq0EKORk05lViM8EnSSdTN0JMQQv8P
	WaRfbV0uSNdSoZLeg2ElbK4KjkFRBSiWsu2zOcacVWBwewvgwwv5
X-Gm-Gg: ASbGncuW4QTuCYpMD64buPFUHN8GlzuEX5TtQ2jmWPXjQWCrgPrh0iIWg57gJmlySpy
	2nQ0eIhbuYv7Ui3nxTwvX7kDaURw6WAJVeCIDO8XxU5TDmyJ5Ari9E5gjonpWJUzyUMUp10DTdY
	9iLX8eGz6Im1Ro7WB3x0Xu2ivs8UOS7PBRxY2ldKkTitPIbGTeorZ/YP8NbCEcowfRjpH7qx7lI
	Af7EEMYDBj7n9DtpaQg1hxc1wVpsVzvwwly+pTHdvv5lAiEX9Z+n3p4rtY64N+1iE7ntgLX6i+f
	/ehhhQv/79DW9lHVte8KJuNyI1bepEx5ggdR/PceGckV5W0EhhTJtFs=
X-Google-Smtp-Source: AGHT+IHGn1oYmyrfmGGRVvefxzTwXz/ZSS6AQia3nIunChBY+uX0yX++3iB2CRS92fBJl/f7pslrxQ==
X-Received: by 2002:a05:6214:19e1:b0:6d1:8c91:99f0 with SMTP id 6a1803df08f44-6d451352b4emr55146716d6.40.1732302122681;
        Fri, 22 Nov 2024 11:02:02 -0800 (PST)
Received: from ?IPv6:2606:6d00:15:40f8:689a:b10f:19f5:4246? ([2606:6d00:15:40f8:689a:b10f:19f5:4246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451ab5ccesm13086526d6.67.2024.11.22.11.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 11:02:02 -0800 (PST)
Subject: Re: [PATCH 3/5] git-mergetool--lib.sh: add error message in
 'setup_user_tool'
To: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Seth House <seth@eseth.com>,
 David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
 <79c3a6ffe8f2872755f76340e2d5ae1a94885456.1731459128.git.gitgitgadget@gmail.com>
 <xmqqwmh729ah.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <47763d09-8e3c-ea58-c8f7-0580c7d2291a@gmail.com>
Date: Fri, 22 Nov 2024 14:02:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqwmh729ah.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-11-12 à 20:48, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  setup_user_tool () {
>>  	merge_tool_cmd=$(get_merge_tool_cmd "$tool")
>> -	test -n "$merge_tool_cmd" || return 1
>> +	if test -z "$merge_tool_cmd"
>> +	then
>> +		echo >&2 "error: ${TOOL_MODE}tool.$tool.cmd not set for tool '$tool'"
>> +		return 1
>> +	fi
> 
> There are only two callers of setup_user_tool, and one of them
> squelches this message by sending it to /dev/null.  The error
> message composed here does not use anything that is unique to the
> function (in other words, $tool and ${TOOL_MODE} are available to
> its callers).
> 
> I wonder if it is a better design to leave this one as-is, and
> instead show the error message from the other caller of
> setup_user_tool that does not squelch the message?  Are we planning
> to add more callers of this function that want to show the same
> message?

I don't think we are planning to add more callers, no.

> 
>>  	diff_cmd () {
>>  		( eval $merge_tool_cmd )
>> @@ -255,7 +259,7 @@ setup_tool () {
>>  
>>  	# Now let the user override the default command for the tool.  If
>>  	# they have not done so then this will return 1 which we ignore.
>> -	setup_user_tool
>> +	setup_user_tool 2>/dev/null
> 
> If we did that, then this change can be dropped.  Instead, a few
> lines above this hunk, we can give the error message ourselves from
> this setup_tool function.

I agree it could be done this way, I can change if it we wish.


>>  	if ! list_tool_variants | grep -q "^$tool$"
>>  	then
>> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
>> index 22b3a85b3e9..82a88107850 100755
>> --- a/t/t7610-mergetool.sh
>> +++ b/t/t7610-mergetool.sh
>> @@ -898,4 +898,12 @@ test_expect_success 'mergetool with guiDefault' '
>>  	git commit -m "branch1 resolved with mergetool"
>>  '
>>  
>> +test_expect_success 'mergetool with non-existent tool' '
>> +	test_when_finished "git reset --hard" &&
>> +	git checkout -b test$test_count branch1 &&
>> +	test_must_fail git merge main &&
>> +	yes "" | test_must_fail git mergetool --tool=absent >out 2>&1 &&
>> +	test_grep -i "not set for tool" out
>> +'
> 
> Why "-i"?  I do not offhand see the reason why we want to be loose
> here.

Indeed this is a leftover from my bisection test in which I had to 
be a bit more loose. I'll remove that flag.
 
> The "${TOOL_MODE}tool" part may also want to be verified, perhaps,
> which was related to the topic of the fix in [2/5]?

Yes, I guess I could make the pattern stricter. I'll update that.
