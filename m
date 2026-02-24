Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E863806DE
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934881; cv=none; b=GoH5Ntn97MZWw/hOFq7uLwraTebi9dnHfJjppZaPhb60Z6pBBhNJzuNaHJBU0pLiGEWUWyPTSKprm4Isx2gC3OEHu4E0/cqLkY0wGht8hjpgQ52aEFDWaP1WUGXWwyquvOEWzmO/SbklVML58zpQVBjfdpW5BcfC9T0ODvvYgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934881; c=relaxed/simple;
	bh=87O1ZOjSYYUGY1mCFXx+J7UJlLPqeEXqGI6BAaEP0f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke7cFFinGKYgN1IbWYq2uVcADiYwYcFEBj7izU9pri0NL++Kse/v3OJsfUsN2hO3K8zs6eGhe07HdhQyNTFKcKQJZB3PwQ2sBuhSX3p7l32nfuQo258RWDB6QgATc2dJ2AKRZAB2t3BCHEQzXdss1jxvrAXPkkyZkUU0X8gtpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBndXEeL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBndXEeL"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c7199e7f79so727464785a.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 04:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771934879; x=1772539679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0OrdB+cHg/F1gk9+uSR9wxCnODYzBZtOcGYDv/hM6Q=;
        b=hBndXEeLUPusITzgRt/KXfWqAld2DdwJXmffQ5NVvlVsAckvP0TAgt7EjVhponeazn
         j9aBKCHP5aW98XOQtHyUy3wnqKj5iFcBpN2XZXf98b+qjEAu1y8oSw6MTM55gvNqYBwb
         mwF4w5K/DyR8g/kxPU2QjYNEOnZRt8QeFBsiSYWmc7qFOrtdBzNwk20Jj9Ni0NTHwJ9r
         EzRl56uKVzmQscK4kZIUR7EDJ9Vv08R1qyoVjAux0I9rJSATcIEmuDNYGyKb0h92keAX
         f3PsNgF1uPHVEwyXdF8iLJFYU7NsTFjDv+YsXQBeeYyRUaVKY7/xhSM99fKMd4bQpemH
         1cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771934879; x=1772539679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0OrdB+cHg/F1gk9+uSR9wxCnODYzBZtOcGYDv/hM6Q=;
        b=O9L1LzcmY7PHV/Vi7zlKSXg+1Mbo1y10FXLwlKR9rgHkP3p9KCXOq/MhU0wIppCR7o
         j+tzy62/T9cgjb8ObVyO5UtwjiqrnCgWTfRWiobgirWU6tOVTlH5uoXrSOwCks7AmXyy
         ApvI3/+f9TqyFy3g7ohk2EjXWdJrK0HUBJwxbFr1/1fXpWq5TSZALEbFWJOVUyLOZOwX
         mL1o8YVEVSuXskNzXQ2DTkSFZ6U66nYHTsGKMEdmMME4LI+QbuUaPiJf5Jygq4yCbc5M
         tz+5KOj2Cst+JZWWVjXTji8NIXxOCstnGa/vuAsQsmDumTrWpoKd5Rt4bdVU+MM+hQrN
         0ODw==
X-Gm-Message-State: AOJu0Yy7Ui9VSOtmzNFzUPkGNxcRDXDjJz4aMUh6/Thh/CuSC59pqH/6
	XuM6ucS26glXeg6Db4Y7WlM1qKdgkGHOIhkOgxDtMCJj98mVM7ec4+Sh7CUQGA==
X-Gm-Gg: AZuq6aI5Q8YOjcxDsDRbWLPU6zwxVGIfgbLo8fejdLuJqUQCYr8SmgKM90Y5DBRuSfe
	r7XBB393kwUTxUnurj8eB7mFKJGk65D9txFQ+5S28TWmRgSlY+IBJ1P9KaYQ1iNXs4nnTXElvZx
	prsnhcqlS3JurN708d2y1cOdS0/8FJQG8Lt2mmjVvDWPb3M+k3s0fOCaVoMy/+7KIEAlx9fBUT6
	/TKStB46iAMLw2ZNRVCjrf+5izGnBUNcLt3YB3LgRx5YWDbgKMRpE4VnjFJk6/l+nOImU8bSgGq
	1z/k18Ym4CCJWAPrY2Hs8G0jsDEcykpdhNfgI5eH2yjJk1iH7Aduj6vApe54RP9h+P6ejUpqWbR
	0tAX3TsxeNchuSIRgtO6MhUH0H23awsA//70BMwLFZM+ilJ1q+Z7+/7t17abtt4DUOG+dU6Qhb1
	OmnTPL/Dl5Dwh8iGiRKiiLmsyuGcyFHzUoUxGuW3f9RXqHoWHsgMPPrdo5rnvfU4Ru/WlGvsaNE
	adq/DcoSW9j7ZhF0IWCuIcFXwuy746jM2HFPDDxyrRNvoKz
X-Received: by 2002:a05:620a:4587:b0:8cb:50d6:18c4 with SMTP id af79cd13be357-8cb8c9cde98mr1443584085a.11.1771934879313;
        Tue, 24 Feb 2026 04:07:59 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d122906sm945954685a.51.2026.02.24.04.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:07:58 -0800 (PST)
Message-ID: <614c8072-347a-4ba5-8796-4742868389d3@gmail.com>
Date: Tue, 24 Feb 2026 07:07:57 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] for-each-repo: stop using the_repository
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <86cd83f65b30aab3233e27b3e5c4f03041e68766.1771903950.git.gitgitgadget@gmail.com>
 <aZ1s7tONvd9wiYZV@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aZ1s7tONvd9wiYZV@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 4:18 AM, Patrick Steinhardt wrote:
> On Tue, Feb 24, 2026 at 03:32:29AM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
>> index 325a7925f1..478ccf1287 100644
>> --- a/builtin/for-each-repo.c
>> +++ b/builtin/for-each-repo.c
>> @@ -1,5 +1,3 @@
>> -#define USE_THE_REPOSITORY_VARIABLE
>> -
>>   #include "builtin.h"
>>   #include "config.h"
>>   #include "gettext.h"
>> @@ -33,7 +31,7 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
>>   int cmd_for_each_repo(int argc,
>>   		      const char **argv,
>>   		      const char *prefix,
>> -		      struct repository *repo UNUSED)
>> +		      struct repository *repo)
>>   {
>>   	static const char *config_key = NULL;
>>   	int keep_going = 0;
>> @@ -55,7 +53,7 @@ int cmd_for_each_repo(int argc,
>>   	if (!config_key)
>>   		die(_("missing --config=<config>"));
>>   
>> -	err = repo_config_get_string_multi(the_repository, config_key, &values);
>> +	err = repo_config_get_string_multi(repo, config_key, &values);
>>   	if (err < 0)
>>   		usage_msg_optf(_("got bad config --config=%s"),
>>   			       for_each_repo_usage, options, config_key);
> 
> The command is marked as `RUN_SETUP_GENTLY`, so it may run in a context
> where there is no repository. In such cases, `repo` would be `NULL`, and
> that would cause the command to segfault here, wouldn't it?

Ah. That's an interesting subtlety of the setup that I did not know.

I'll make sure this is covered in tests, because the current tests run in
the default test repo but our expected use case should be outside a repo.

Thanks,
-Stolee

