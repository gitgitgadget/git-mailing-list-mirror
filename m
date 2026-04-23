Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC353DC4D1
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937476; cv=none; b=dtsiuJJoIyhrQe46PpKNku0aGSwiZp50OAEAwhC9yekMM2sRz7ByP1WOhYppjZWJBhYGi1Vbx2yvtpC2ueNr8Aqhc6+mGar0mseTs8Y4jbn+hqSXIcufshOEJzTTiUyd36WeGIHgIsg40lAJI/6kiiFU41SGztCalMMaUTsOnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937476; c=relaxed/simple;
	bh=Q+AhoSd46Hn6JMqnx3Hq99ar+d6fvhRHU21P/4Smc7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0L+4I2Ap2qjzqVAQYY6Ne9S8ue+LmxckbjSxbR8Qnps+9T4rUft0uYNwYjwD585M3utXc05eL5AM7APGHHCj2V0aqbovKJiJi0ViTyaP7dqdbiGh1motcW00ZbDLY6d2BBNcKZCM8yivgVkaX4VILDyzL31VVhTJ1KdDhOQM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/ZHVByT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/ZHVByT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so61417615e9.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776937473; x=1777542273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LqtTcAXgERxeaKJhOVZv9Gwq+FRzxe/yi8NTsTDOTgY=;
        b=a/ZHVByTlNR2ibyZ1118p1fTo6290mL5kMa61vCfS7zyuPtBMk2c73xsZw54axjg+X
         aQ1w/2fskM5oRZmOIvcuLlKE/6RpoaqY3X5QzDcvq6qlIKr+mVu7d53voPBPcJVhOMeQ
         pyTOqLbffwpBLg4X2cuB3pzxg9i67iUg78bZhhioIcItUIDEG6/122aSl1mSLad5dmAS
         +erm/r57n52F9G1s6mn/jRmFQM7hWogQQZVBdWHRCoAU0I+1fYlCN18AT/98nMbfQ7A7
         lnaHKbX6ZKhkhuEEkhbRgCJ0cZNnzzvo+7vqD688/h4a3tc6lqrgV97aa+YqBIMdZTBa
         XoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776937473; x=1777542273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqtTcAXgERxeaKJhOVZv9Gwq+FRzxe/yi8NTsTDOTgY=;
        b=p8K/OOzpxUIFGvbvPBEIk8o4+1E9l0Qo+34bXuUGl+Y36ueom/Ib2jg5LS4Gi6gth1
         kbHTx5eeXjVAK4HmyhFp+7lP9xYOnaFfNUrT1NcOGcgzsnQYEHFEdgrfT5oKywjO/Ret
         O/o9gjLwpyTD7bebqQt2XEynmpXRF/4FBEXdUWxHvuFNMY2dSSh0Yt3WzetprOUy7GQv
         0ctSZLo/VHzP4ex1wLqEVGJLGm7uT+iRwu7QlN2roQhH/cQh/JriSxHWWKC9TwxSjBj9
         Iz3pKpnnBpCMHpbX4KGSXRhfJXLPaLt9KwSR8LyKqx2H6Mi/XZ1Yocq4r4Z0Stgvpdnq
         g03Q==
X-Gm-Message-State: AOJu0YzJvoL3ocCOMyH49lhbAGWYQdKaC0zDXMlJxA9kzSeud4jiaoQW
	9fH50FskpBJtcHrKTyYkGCrkqclxDQBV8vCG+FGQ6rwrkydEfwk5n2L6
X-Gm-Gg: AeBDievRrkC63yttvcoIHmR3hJRqTw4/l+o27KGF6WaQbwwnYQx/ppZO4BTMLshD5l7
	oYEkZ3zKcfdFLxy2VJYruAU70IjDMl78oKcBUJjF4Z7qvVA+neBYbruZqqnecwwOQopFJ6wsmtk
	dkIziPhPp5NWxe9Ei0ejgTHuEDjwytv3TYhPCvQO+O6PaXCbU2pRvaVvnzw/A7rojEbAgCHqM9v
	hK5w+mjSNb+Mk356aPjnDSYiK7DggO0VYfn8EH1AV46PaqpD5SBvpgh89uDk4zQKWlueKpuuYwm
	VLoudaRYP44IDOnJmUD11Rt4AyHv42lNxr5eOrxvd1q8J0KhW9zya01KTssWI9k6dL9pz/preZ1
	GTQQErvJ9DqvI/JNnegN9sAWaY7T+f2vDS5Lkn0bUy3rg9d7O2G6Dkr8UvS24BJuTfCC8jmnjJ7
	58JBRNHji2lTZp8MSPYpGdbQXVK+0XaMjpoOuAsv+8uELwWjMXDRMcwnvbS/SzwAMulW2AiT9TN
	NrlvV3Zqgq2Ag==
X-Received: by 2002:a05:600c:3e0d:b0:489:6c28:dbc6 with SMTP id 5b1f17b1804b1-4896c28dd4emr216405885e9.31.1776937473206;
        Thu, 23 Apr 2026 02:44:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm50703128f8f.33.2026.04.23.02.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 02:44:32 -0700 (PDT)
Message-ID: <033622e1-1f61-4f9d-b56f-fafc7850d275@gmail.com>
Date: Thu, 23 Apr 2026 10:44:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git grep bug with --column and --only-matching
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Brandon Chinn <brandonchinn178@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <CAGANf=dkRgFp+bEkB5f8QBeiR3m+3WE8sKqT9vKstkGHqbxA3A@mail.gmail.com>
 <3ce1906a-85e3-4fb1-9ebc-a5639f3194c9@web.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <3ce1906a-85e3-4fb1-9ebc-a5639f3194c9@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/04/2026 21:33, René Scharfe wrote:
> On 4/21/26 7:03 AM, Brandon Chinn wrote:
>> I'm encountering a bug when using `git grep` with both `--column` and
>> `--only-matching`, is this a known limitation?
>>
>> Repro:
>>
>> ```
>> $ echo 'x   x   x' > repro.txt
>>
>> $ grep -bo x repro.txt
>> 0:x
>> 4:x
>> 8:x
>>
>> $ git grep --no-index -o -n --column x repro.txt
>> repro.txt:1:  1:x
>> repro.txt:1:  2:x
>> repro.txt:1:  6:x
> 
> The first column value matches (1-based for git grep, 0-based for
> grep(1)), the remaining ones are different.  grep(1) shows the offset
> like for the first match, but git grep adds the relative position of the
> end of the previous match.

I'm having a hard time understanding what git is doing. Looking at your 
example with the ruler

>    (`man gitcvs-migration` or `git help cvs-migration` if git is
>          ^^^                   ^^^                        ^^^
>             1111111111222222222233333333334444444444555555555566
>    123456789 123456789 123456789 123456789 123456789 123456789 1
>             
>    7:git
>    16:git
>    38:git

The first match ends at column 9 and the second match starts at column 
29 so how do we end up with 16 as the "column" of the second match when 
the difference between them is 20?

> I don't know how to use the resulting numbers and I agree that it seems
> like a bug -- showing the column of each match within its line makes
> more sense for an option named --column.

Indeed

> However, the original submission of this feature in
> https://lore.kernel.org/git/cover.1529961706.git.me@ttaylorr.com/
> gave similar examples in its commit message and its tests, called
> them "as one would expect" and was not challenged on that, so I may be
> missing something.

I wonder how hard anyone looked at the examples and tests, the 
discussion seemed to have focused on other things.

Thanks

Phillip

> Here's its first example with underlined matches, a ruler and the
> intended output (without unnecessary headers):
> 
>    (`man gitcvs-migration` or `git help cvs-migration` if git is
>          ^^^                   ^^^                        ^^^
>             1111111111222222222233333333334444444444555555555566
>    123456789 123456789 123456789 123456789 123456789 123456789 1
>             
>    7:git
>    16:git
>    38:git
> 
> And here's the last line of the test file from t7810 with underlined
> matches (the other four lines are very similar), a ruler and the
> expected output (unncessary headers removed):
> 
>    foo_mmap bar mmap baz
>        ^^^^     ^^^^
>             111111111122
>    123456789 123456789 1
> 
>    5:mmap
>    13:mmap
> 
> If we wanted to show the column of matches 2 and beyond then we could do
> something like this:
> 
> 
> diff --git a/grep.c b/grep.c
> index c7e1dc1e0e..a54e5d86a9 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1267,6 +1267,7 @@ static void show_line(struct grep_opt *opt,
>   		regmatch_t match;
>   		enum grep_context ctx = GREP_CONTEXT_BODY;
>   		int eflags = 0;
> +		const char *start = bol;
>   
>   		if (want_color(opt->color)) {
>   			if (sign == ':')
> @@ -1285,6 +1286,7 @@ static void show_line(struct grep_opt *opt,
>   			if (match.rm_so == match.rm_eo)
>   				break;
>   
> +			cno = bol - start + match.rm_so + 1;
>   			if (opt->only_matching)
>   				show_line_header(opt, name, lno, cno, sign);
>   			else
> @@ -1294,7 +1296,6 @@ static void show_line(struct grep_opt *opt,
>   			if (opt->only_matching)
>   				opt->output(opt, "\n", 1);
>   			bol += match.rm_eo;
> -			cno += match.rm_eo;
>   			rest -= match.rm_eo;
>   			eflags = REG_NOTBOL;
>   		}
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 64ac4f04ee..bd439563d6 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -322,11 +322,11 @@ do
>   		${HC}file:1:5:mmap
>   		${HC}file:2:5:mmap
>   		${HC}file:3:5:mmap
> -		${HC}file:3:13:mmap
> +		${HC}file:3:14:mmap
>   		${HC}file:4:5:mmap
> -		${HC}file:4:13:mmap
> +		${HC}file:4:14:mmap
>   		${HC}file:5:5:mmap
> -		${HC}file:5:13:mmap
> +		${HC}file:5:14:mmap
>   		EOF
>   		git grep --column -n -o -e mmap $H >actual &&
>   		test_cmp expected actual
> 
> 

