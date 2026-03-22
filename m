Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54233D4EE
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774200246; cv=none; b=NQt6PvH7ZgYtSjYbjDrPsfHTWsf07GlJH/2ubeDHn93XiIp85K+GD2joAoEwAkvbnlnkFFGHrNJPdBiO46P86M9UCWUV2JvSHQzhgwOTqotB1RZvTF6XrO5m/YBTI44q/Wqqx24p4xdJn+I4ciLg1LjioD4+i8NCdqHxcixFsds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774200246; c=relaxed/simple;
	bh=t1h/F8ctLebidtlcbpoRE3V06Gl4kcil885/3PoCj/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDWfzAYJW5fCG9rz4PM7Ss7hTle8Yho7DeciL2DeZLtdzCubaigBcP+T6EuLUt+evlxDCXzMhJ2mc95eeqDBsobvWbjGlihn8v1yR0MuwL5F3wqcUM2iRNxF1c+22VjvUvVftWx8CSX0SMuhqqYoRrkdQkqDwR5UqKNxw115tOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTYgmK6H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTYgmK6H"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a9633ef0d6so5374605ad.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774200244; x=1774805044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLclnF61adL652p5nxOGAYsehf5cvcHDlt4OKWUfoWQ=;
        b=JTYgmK6HsQqv7Sdf90KX1KVsIY1zMwqfLQS0z76fRVeia2NtDhEkQnjls96IpMQ7fD
         quWF5iJrVqtTuoPOqkqKbbuLAgyD2DNPlHcRef31HyrnGAMeq4EXTKMIrVz8cMn97VbB
         onxgNgshMDaqHm8Z+VNHbNBcRrmW4pAHI0PFb1wIKiKxAFjnTCee8aIqS2x5JfToZxLh
         QTrZIAe9yhwud4nuDPXJXhlFoTEZUG7yAKBtxCPDNo+RmgQt60X+6mBIIIRAA4zwJVWH
         wKDArRIcgPGQACezMQ0bigeRdgUxzEYRvqqRkrAAUgKIUxWMXixHEuHMUQER8B6jQ2Pc
         HY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774200244; x=1774805044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLclnF61adL652p5nxOGAYsehf5cvcHDlt4OKWUfoWQ=;
        b=CJF/2inoDtUnCTgVKWpUTjAG57r/Z3Cw/H8iVRAxaiBlXdF8GRl6rlOwCupLbPtFXH
         g2cDSG8uy5aQxntzu/asCk0kgYId5NYOKtjxLxTkX5uKRT9fJy9AUzkqSYg+wRXOvwk8
         cwRiQ3mXLjiX7I6ru8HDZMCXAcfJjVWeO5HQD312GA8z5JUH7DFLoGpaaEQZWE+Bfq65
         XzPvCqJc1Q+rUsqTTsOEfYW703uHXCF0JMer7rA9nyu1Aoeay/HRpzgsSmZpVkWBxA4I
         vN+yZxnNub1ppWj5TOuzozG+LBh6Pal8KrkJhbv18De0Ug2HH2ghG7YKMBw8nTH49cBw
         iC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo2V+lA7bOr3lHM7GHG5Su684qzEkIcpgtsa8JclOBv4auRpsoYtbBLS1gR2HERJsdd/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbBVT5q4jQ7Bpm9DQ1pHJ/GVbdal8Qvgd2g/oc85lggOZ5B9p
	85fADuIgjc+rIQy620UKVbovQrgsCZ+zVIHss8CLYiwYob35LQQaCgjDcsob0cH1
X-Gm-Gg: ATEYQzwRBVaxj2kYDSQt9ThxZRS0x6daZIsYyKzPknQSXPpOgS7B5HZxPF9Xdfp0vOC
	+F8gVkL0ea3FFYr/ej+k7eI/8jK+4JtpqgVYVgOjH8pPOcwbHH1XoxYRLGgAWpIXaNVCl9osTIj
	4E6vg8CZxq2krH8N4eZB+U3behH/VdwU/pzmzCoWYsbbduTTSrVqXlAuSMOa+8PxZwBjaXsEPf5
	d22EtDuA/0FZNgJjH61O106208nGjv8w+2zWEKPf20u9Br6imA5QjSDDhHPMzc8zHIu9nl9553X
	1XMuzDn11COmymG2hb8+HiOSpiM47+xpPM2x8qVgVlHY93w0Cxaxo0a176SyCwwPWnC/m+I3T2z
	2evCniycumMlQYEXP4x6FfOrUX0voejWQDfVcx9EZ5V+S0X/1aNjziJsOfCKwPGilllIS54z750
	Zz5bbZg56i7R3fujSpGTUIA37ebmliwVT7ATee9EGPdBoe061J78l0erRWHDsTcKmyhkA1sugX/
	B0uu0NqDoo=
X-Received: by 2002:a05:6a21:1f87:b0:343:c095:c4d6 with SMTP id adf61e73a8af0-39bceb37710mr5697111637.3.1774200244260;
        Sun, 22 Mar 2026 10:24:04 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b041059a5sm8425446b3a.53.2026.03.22.10.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 10:24:03 -0700 (PDT)
Message-ID: <b992e118-f948-4145-8d77-96f00b497f99@gmail.com>
Date: Mon, 23 Mar 2026 01:24:00 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] diff-highlight: use test_decode_color in tests
Content-Language: en-US
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
 <20260320004436.GE3654226@coredump.intra.peff.net>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260320004436.GE3654226@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/20/26 08:44, Jeff King wrote:
> The diff-highlight tests use raw color bytes when comparing expected and
> actual output. Let's use test_decode_color, which is our usual technique
> in other tests. It makes reading test output diffs a bit easier, since
> you're not relying on your terminal to interpret the result (or worse,
> interpreting characters yourself via "cat -A").
> 
> This will also make it easier to add tests with new colors/attributes,
> without having to pre-define the byte sequences ourselves.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   .../diff-highlight/t/t9400-diff-highlight.sh  | 37 +++++++++----------
>   1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> index 42d331c6cd..ba80cda7c8 100755
> --- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
> +++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> @@ -7,9 +7,6 @@ TEST_OUTPUT_DIRECTORY=$(pwd)
>   TEST_DIRECTORY="$CURR_DIR"/../../../t
>   DIFF_HIGHLIGHT="$CURR_DIR"/../diff-highlight
>   
> -CW="$(printf "\033[7m")"	# white
> -CR="$(printf "\033[27m")"	# reset
> -
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   . "$TEST_DIRECTORY"/test-lib.sh
> @@ -42,9 +39,9 @@ dh_test () {
>   	} >/dev/null &&
>   
>   	"$DIFF_HIGHLIGHT" <diff.raw >diff.hi &&
> -	test_strip_patch_header <diff.hi >diff.act
> +	test_strip_patch_header <diff.hi | test_decode_color >diff.act

Although this is just simple text filtering and leaving it as is 
wouldn’t cause any problems IMO, why not go ahead and add the && while 
you’re at it?

I've noticed that there are several missing &&.

>   	"$DIFF_HIGHLIGHT" <commit.raw >commit.hi &&
> -	test_strip_patch_header <commit.hi >commit.act &&
> +	test_strip_patch_header <commit.hi | test_decode_color >commit.act &&
>   	test_cmp patch.exp diff.act &&
>   	test_cmp patch.exp commit.act
>   }
> @@ -126,8 +123,8 @@ test_expect_success 'diff-highlight highlights the beginning of a line' '
>   	dh_test a b <<-EOF
>   		@@ -1,3 +1,3 @@
>   		 aaa
> -		-${CW}b${CR}bb
> -		+${CW}0${CR}bb
> +		-<REVERSE>b<NOREVERSE>bb
> +		+<REVERSE>0<NOREVERSE>bb
>   		 ccc
>   	EOF
>   '
> @@ -148,8 +145,8 @@ test_expect_success 'diff-highlight highlights the end of a line' '
>   	dh_test a b <<-EOF
>   		@@ -1,3 +1,3 @@
>   		 aaa
> -		-bb${CW}b${CR}
> -		+bb${CW}0${CR}
> +		-bb<REVERSE>b<NOREVERSE>
> +		+bb<REVERSE>0<NOREVERSE>
>   		 ccc
>   	EOF
>   '
> @@ -170,8 +167,8 @@ test_expect_success 'diff-highlight highlights the middle of a line' '
>   	dh_test a b <<-EOF
>   		@@ -1,3 +1,3 @@
>   		 aaa
> -		-b${CW}b${CR}b
> -		+b${CW}0${CR}b
> +		-b<REVERSE>b<NOREVERSE>b
> +		+b<REVERSE>0<NOREVERSE>b
>   		 ccc
>   	EOF
>   '
> @@ -213,8 +210,8 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
>   	dh_test a b <<-EOF
>   		@@ -1,3 +1,3 @@
>   		 aaa
> -		-b${CW}b${CR}b
> -		+b${CW}0${CR}b
> +		-b<REVERSE>b<NOREVERSE>b
> +		+b<REVERSE>0<NOREVERSE>b
>   		+ccc
>   	EOF
>   '
> @@ -232,8 +229,8 @@ test_expect_success 'diff-highlight treats multibyte utf-8 as a unit' '
>   	echo "unic${o_stroke}de" >b &&
>   	dh_test a b <<-EOF
>   		@@ -1 +1 @@
> -		-unic${CW}${o_accent}${CR}de
> -		+unic${CW}${o_stroke}${CR}de
> +		-unic<REVERSE>${o_accent}<NOREVERSE>de
> +		+unic<REVERSE>${o_stroke}<NOREVERSE>de
>   	EOF
>   '
>   
> @@ -250,8 +247,8 @@ test_expect_failure 'diff-highlight treats combining code points as a unit' '
>   	echo "unico${combine_circum}de" >b &&
>   	dh_test a b <<-EOF
>   		@@ -1 +1 @@
> -		-unic${CW}o${combine_accent}${CR}de
> -		+unic${CW}o${combine_circum}${CR}de
> +		-unic<REVERSE>o${combine_accent}<NOREVERSE>de
> +		+unic<REVERSE>o${combine_circum}<NOREVERSE>de
>   	EOF
>   '
>   
> @@ -333,12 +330,12 @@ test_expect_success 'diff-highlight handles --graph with leading dash' '
>   	+++ b/file
>   	@@ -1,3 +1,3 @@
>   	 before
> -	-the ${CW}old${CR} line
> -	+the ${CW}new${CR} line
> +	-the <REVERSE>old<NOREVERSE> line
> +	+the <REVERSE>new<NOREVERSE> line
>   	 -leading dash
>   	EOF
>   	git log --graph -p -1 | "$DIFF_HIGHLIGHT" >actual.raw &&
> -	trim_graph <actual.raw | sed -n "/^---/,\$p" >actual &&
> +	trim_graph <actual.raw | sed -n "/^---/,\$p" | test_decode_color >actual &&
>   	test_cmp expect actual
>   '
>   

Thanks,

Yuchen

