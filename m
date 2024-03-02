Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37D5680
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709397551; cv=none; b=FRcDNU7qhpUiRFnVCbY7J7aiHgl/X474wlJZYn7y3P1GhsxyCr48IilGO9V3vm9L8vDrrB5w10QhlyC4p16sEp4P+Op2fLM9dxZX3FQQD8y4HEA/fR6F/TFwF75aMi0OuqdN2YVPJVoDGYo6xpDFTBCbsRVZ7pgB0w7NU+Ix/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709397551; c=relaxed/simple;
	bh=dJ4w5UkzczghLWV9UMKf6BfbTeqMvWjX7Qs79d/yGl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uavx4rp2Ly/NMAJAzlJt7xSciviHBYQnnAzVg5QfrThFFyt0MH3/aoo/t/kRdVLWQGllDBK1nXVwUtWenrxnr/oIoNFcdcS53YA7q9fw/Jk94X1/ueDYDq3/UJc2tl4H3KyBfJydVp1+jBs97kAuIXOuEW+vzGjgBC22Cu1iPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDghW0pI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDghW0pI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d509ab80eso1314174f8f.3
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 08:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709397548; x=1710002348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HbpmxGuLk44TmCYDMDAYz4jScFE2oiWj2vAB7640GeA=;
        b=BDghW0pIu8kXSnv5kBDKn8yJGnT1y40i7Bl+Ajc/ob4wyw+qIr/9194SIOFouH0WNR
         MttBHn9q54N5wwqLXtbUDrs31mpHycDyF1d50HudZS0YDoG/9gEMV721ZAQbi9haUVYb
         oEus8jsOrQN/6iVJdU4mjrWc80z5htwNlldt7KA6kruG3iTGkK2cuM7AqXxD38pU4G1H
         cHPNq1gUj2Ataxmmj79wzcdDDT0o0G2YMVgDQKJS0yVaQ6+UZ4FasyJGebtiW+5Ba2aj
         UiygUa2hOh/uhwudUdlj2/brX/CL8mG0wwpgas3RwQNi6a2AkufGv/ZBSHuSbdu3R0ir
         LjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709397548; x=1710002348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbpmxGuLk44TmCYDMDAYz4jScFE2oiWj2vAB7640GeA=;
        b=wKjfYk87wn5fc7Fn2A0NU7jVQUVS04gdU9L4/UfZp41CEA7YAH0k9MsHxobBFDL1kj
         PbNkiuQowwZ8JJ5PcoiSzzK8EJ6/VUp4pKfaT6kwDDuJsjS+TKGYn8N4i/JVUtlEcBcM
         AKjLPn09Y0A/gJktkHPor49HX5zuIoaMchWBQBBb88uqPXR6oJbNtIQcyCNWm5I9nBx2
         j82kgTxc/Jah0ca+ItLEouxEb9QNBcOSSUb5kBgFBkhsTuIDaDRB8dZboaTU/aIukeYG
         VIpHTNTzzRCe5k418Pp0tuzG8K4ADd6r/b9AkXn9Xzvrqglp5+RICETni6OkUW77z2lY
         5/IA==
X-Forwarded-Encrypted: i=1; AJvYcCUwoD4wp3MBmoE1R5vs6mMAQmfevdTFEB98NSSth/dfW0iQ9zB37jY8VHtS3mZxl8Ztzi5NfpRu50bW0YxsdR0AxTgr
X-Gm-Message-State: AOJu0YwzUTOTEjpHjAkAjXxr1a0tFFqvkkhBMZYDzW/RPCIQPMuJQ1Pw
	48aO4pfYYs6vx7KAlG6uE2xkgrUxZuWx+hxOjgxR8gcShtpWHVjK
X-Google-Smtp-Source: AGHT+IGDsBLTdJs2riGur1Ty+BjRpwOEXkzrkRmF9dnztSZ2NJZ03feNWldmPVxwj7btIXbhZQOkmA==
X-Received: by 2002:adf:b611:0:b0:33e:1904:fd37 with SMTP id f17-20020adfb611000000b0033e1904fd37mr2871544wre.70.1709397547905;
        Sat, 02 Mar 2024 08:39:07 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033e052be14fsm7602451wrw.98.2024.03.02.08.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 08:39:07 -0800 (PST)
Message-ID: <cf978790-4885-4103-946d-10f807048441@gmail.com>
Date: Sat, 2 Mar 2024 17:38:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test-lib-functions: simplify `test_file_not_empty`
 failure message
Content-Language: en-US
To: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Aryan Gupta <garyan447@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20240301204922.40304-1-ericsunshine@charter.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240301204922.40304-1-ericsunshine@charter.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Mar 01, 2024 at 03:49:22PM -0500, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> The function `test_file_not_empty` asserts that a file exists and is not
> empty. When the assertion fails, it complains:
> 
>     'foo' is not a non-empty file.
> 
> which is difficult to interpret due to the double-negative. To make it
> easier to understand the problem, simplify the message by dropping the
> double-negative and stating the problem more directly:
> 
>     'foo' is empty but should not be
> 
> (The full-stop is also dropped from the message to reflect the style of
> messages issued by other `test_path_*` functions.)
> 
> Note: Technically, the revised message is slightly less accurate since
> the function asserts both that the file exists and that it is non-empty,
> but the new message talks only about the emptiness of the file, not
> whether it exists. A more accurate message might be "'foo' is empty but
> should not be (or doesn't exist)", but that's unnecessarily long-winded
> and adds little information that the test author couldn't discover by
> noticing the file's absence.

To improve the accuracy of the message, I wonder if it is worth doing
what we do in test_must_be_empty:

	test_must_be_empty () {
		test "$#" -ne 1 && BUG "1 param"
		test_path_is_file "$1" &&
		if test -s "$1"
		then
			echo "'$1' is not empty, it contains:"
			cat "$1"
			return 1
		fi
	}

Perhaps:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b5eaf7fdc1..5b5ee0dc1d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -989,9 +989,10 @@ test_dir_is_empty () {
 # Check if the file exists and has a size greater than zero
 test_file_not_empty () {
        test "$#" = 2 && BUG "2 param"
+       test_path_is_file "$1" &&
        if ! test -s "$1"
        then
-               echo "'$1' is not a non-empty file."
+		echo "'$1' is empty but should not be"
                false
        fi
 }

> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> 
> This is a tangential follow-up to the discussion at [1].
> 
> [1]: https://lore.kernel.org/git/CAPig+cQ+JNBwydUq0CsTZGs8mHs3L3fJDuSosd+-WdKwWWw=gg@mail.gmail.com/
> 
>  t/test-lib-functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b5eaf7fdc1..9e97b324c5 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -991,7 +991,7 @@ test_file_not_empty () {
>  	test "$#" = 2 && BUG "2 param"
>  	if ! test -s "$1"
>  	then
> -		echo "'$1' is not a non-empty file."
> +		echo "'$1' is empty but should not be"
>  		false
>  	fi
>  }
> -- 
> 2.44.0
> 
