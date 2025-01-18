Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096519FA8D
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737230995; cv=none; b=Ow4V8TaPnjFqQ3RMkJsIuUW5blZ0MyfLG3aWV4LrPty4+3wWReG6tEqta6WMpY7lSnBnQb8LqTbU6bJ/EnJsQ1sS6/LbDLPeO/obYWb6SWxuM7su5eEtE2Gy5XFOwo6EL69OTdlakCNoXGYbFcy7cqP6M1yxryh6VZZgOwr5X6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737230995; c=relaxed/simple;
	bh=Pu7EY++IzHY96Vf/8N2WcxDgZdjQarbCxoqkCokbTLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YD+YKXRiFCMKlvRGu7sCWW9DHWnuvZxsYWPE7nm6bNsEkbUNKgmO6SFbSrS2y1SgQIeJQgF1sLOYgU92cPmtaLKj5huiZOf61hZpLKowZN7NXsQO5PNr4isd4QJWJSQxvE7fiGqnpbkACqtNkDyNj3yVW0Sg4PH6sKo3P1w1mL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iah0L23l; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iah0L23l"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so1957232f8f.0
        for <git@vger.kernel.org>; Sat, 18 Jan 2025 12:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737230992; x=1737835792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SkjwysJ4sDI6L4+jRAsc3G12LbSKQpzCwXKNwMdN6Y=;
        b=Iah0L23lcjt6BrtUvg5Sa+hG/5Tnq/l6LOLk5pJME0s6OzjL1pT5TmAX2mf3sBf8ZG
         aXb8Q1vBl5m1YfZffQZ7Z15XKzdz0CwnErYC8La/78gp9/865UmkWXp279+BNElyWpDv
         wasPH+WdVkZFzbrWZvUrVyYTQG75DMbCIN57yYHHjaj3IsNowHNeaZRrlNqlk286qdNC
         qwtVDioy7DCF8MMA4NwT+QFEnps/I/5aiEGCxCgWI3RECvO++0FzcTFWeIMFDrWE6jVS
         0Avf70DVHBY97Avoxu2bpKuvMwc6dBGpsZGonKnnv6PMnt45jrfW5z8PtjL3b8v/Lcs6
         WYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737230992; x=1737835792;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SkjwysJ4sDI6L4+jRAsc3G12LbSKQpzCwXKNwMdN6Y=;
        b=S5JzOcRh/06YC2tHtYMZeEuZ7bBbcbrzoooZXFVSIWfKZNWXPgAjOGx2b/il0GK/J4
         EYIdo/lwN8cPAkW61w15L4dFnsrkGCLoFw4RSyMBr5++yqlD8a+amh8sKRt7JSxblM5L
         Jh4cNiRxw5oxTuybXqiJ6ezfSJgsqtWh2flr9+WwttPsSsrwlv5rvcahaXy9PC4ggXPD
         /Td8cK9wCOMHmURVWZix0Q6+s2ordj+ErBcx8HObleZaAWIZ488Uvd8M76L0OQzpoxU8
         sHy4aHsg2RXdu6GkXlCHzc3Q/hAZ9ElmrJhybY/tnlFy6Mw9JnUpWK6G6BV53sf5RKQe
         Dq2g==
X-Forwarded-Encrypted: i=1; AJvYcCWOR5VopW0MJkN37ucTXT2YDOx7dbqFWyXKlFkexw7G0YPQ9ayQNKGo7VuXKmHNSe5o2ME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb2r0Jfl3K+PQ7+1Wg3rBA2cc0bmdpOP4Qof+/JAhUw6HZIOS8
	+3yU2Rhd7vwYOweP1iXrRtDqWEwn7HU/zj4pyf539GSK6yfXU6qO
X-Gm-Gg: ASbGnctaJefIuZfNGtONi0xEx56o4dIrKebmXVkU9cBzMxhPig7EhNLSoTsz3hVHDJD
	ApkKl5efWx1LMZQwcyQTHLDNxSwDol7wN/4oM2XR1Yil2/kk7D0Ib02ToWNuo59HvfaHFCaVbk8
	fM2SwFL19tStuEuA+/47CBgjZGLL/d3WAzSSjAAITdr9FtfnPZ1Rt5Lw98/DxJ81qfNkfypNO/0
	6HS0HsXHh1ta+qQbsSqVHRJN/22r5muEGp1NGf7yFgas4RiYuTkeZ5B+MnNJNH1jvqJBHYGyOAA
	d6viVMVZlV7+QKblQg==
X-Google-Smtp-Source: AGHT+IGnyTcPDTGt8qwvQmHEPD96jTs2ZF7YZz1Xp0uvJe1YVd+4lMovb9Rwcga5zi3PfFco6RSLUQ==
X-Received: by 2002:a5d:4d83:0:b0:385:f195:2a8 with SMTP id ffacd0b85a97d-38bf566cd2emr4877562f8f.30.1737230991585;
        Sat, 18 Jan 2025 12:09:51 -0800 (PST)
Received: from [192.168.1.186] ([2.26.170.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32755f0sm6007513f8f.76.2025.01.18.12.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 12:09:51 -0800 (PST)
Message-ID: <8ef3bd22-d2e4-4361-93da-581d2f76204f@gmail.com>
Date: Sat, 18 Jan 2025 20:09:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] credential-cache: respect authtype capability
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1842.v4.git.1736212760709.gitgitgadget@gmail.com>
 <pull.1842.v5.git.1736462721156.gitgitgadget@gmail.com>
Content-Language: en-GB
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, gitster@pobox.com
From: M Hickford <mirth.hickford@gmail.com>
In-Reply-To: <pull.1842.v5.git.1736462721156.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-09 22:45, M Hickford via GitGitGadget wrote:
> From: M Hickford <mirth.hickford@gmail.com>
> 
> Previously, credential-cache populated authtype regardless whether
> "get" request had authtype capability. As documented in
> git-credential.txt, authtype "should not be sent unless the appropriate
> capability ... is provided".
> 
> Add test. Without this change, the test failed because "credential fill"
> printed an incomplete credential with only protocol and host attributes
> (the unexpected authtype attribute was discarded by credential.c).
> 
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>      credential-cache: respect request capabilities
>      
>      CC: sandals@crustytoothpaste.net CC: gitster@pobox.com
>      
>      Patch v5 adds details to the commit message
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1842%2Fhickford%2Fcache-capability-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1842/hickford/cache-capability-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1842
> 
> Range-diff vs v4:
> 
>   1:  23942f9fa47 ! 1:  db575d9d116 credential-cache: respect request capabilities
>       @@ Metadata
>        Author: M Hickford <mirth.hickford@gmail.com>
>        
>         ## Commit message ##
>       -    credential-cache: respect request capabilities
>       +    credential-cache: respect authtype capability
>        
>       -    Previously, credential-cache populated authtype regardless of request.
>       +    Previously, credential-cache populated authtype regardless whether
>       +    "get" request had authtype capability. As documented in
>       +    git-credential.txt, authtype "should not be sent unless the appropriate
>       +    capability ... is provided".
>       +
>       +    Add test. Without this change, the test failed because "credential fill"
>       +    printed an incomplete credential with only protocol and host attributes
>       +    (the unexpected authtype attribute was discarded by credential.c).
>        
>            Signed-off-by: M Hickford <mirth.hickford@gmail.com>
>        
> 
> 
>   builtin/credential-cache--daemon.c |  4 ++--
>   t/lib-credential.sh                | 15 +++++++++++++++
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index bc22f5c6d24..e707618e743 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -142,9 +142,9 @@ static void serve_one_client(FILE *in, FILE *out)
>   				fprintf(out, "username=%s\n", e->item.username);
>   			if (e->item.password)
>   				fprintf(out, "password=%s\n", e->item.password);
> -			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.authtype)
> +			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.authtype)
>   				fprintf(out, "authtype=%s\n", e->item.authtype);
> -			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.credential)
> +			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.credential)
>   				fprintf(out, "credential=%s\n", e->item.credential);
>   			if (e->item.password_expiry_utc != TIME_MAX)
>   				fprintf(out, "password_expiry_utc=%"PRItime"\n",
> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index 58b9c740605..cc6bf9aa5f3 100644
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -566,6 +566,21 @@ helper_test_authtype() {
>   		EOF
>   	'
>   
> +	test_expect_success "helper ($HELPER) gets authtype and credential only if request has authtype capability" '
> +		check fill $HELPER <<-\EOF
> +		protocol=https
> +		host=git.example.com
> +		--
> +		protocol=https
> +		host=git.example.com
> +		username=askpass-username
> +		password=askpass-password
> +		--
> +		askpass: Username for '\''https://git.example.com'\'':
> +		askpass: Password for '\''https://askpass-username@git.example.com'\'':
> +		EOF
> +	'
> +
>   	test_expect_success "helper ($HELPER) stores authtype and credential with username" '
>   		check approve $HELPER <<-\EOF
>   		capability[]=authtype
> 
> base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f

Hi Brian. Any further comments on patch v5? This addresses your comments 
on v2 and expands the commit message as encouraged by Junio. (Thank you 
both for the review so far.)

https://lore.kernel.org/git/Z3xhqCf7Gr74BHO4@tapette.crustytoothpaste.net/
https://lore.kernel.org/git/xmqqttaaoyaz.fsf@gitster.g/
