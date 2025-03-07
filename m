Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F341A239E
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343869; cv=none; b=G6tIT/GXgNyktr/Y42/37yP/bBO+akX1kAN+2j3XOUU39QZAwBjDtd4AvHg45i6i7baqE8ykqRHcpaEcpshaECTxumT8mTkOhk6T5qnE6r1LQ69FQbKhVSJGwccyesk8mNUtGrZlNHQEmsLNkx17Z9XglAw2mY6yjbUy+OBikiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343869; c=relaxed/simple;
	bh=o6LCAHuQ1g/vP3wpsjBRwqoevhcJdwVMv4q6FGR+Oms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdPZMJCITLzh0XxrPNiguAHB3UMxuXl4RdUH8lklIO9h9tOlQyOJgery16MyY0bXLzL1tahZp+ftNs68L+50VlTXrciT8MzTywjA4NMaM+ZMTCnyaXUMtXAsK8fDoK/cdHGBwytxB2S8VuFnTY6RKMQFsaMm9DOi2ZCOuAlkFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ychu8d2B; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ychu8d2B"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso1979907a12.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 02:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741343866; x=1741948666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nOV0U/zvIjE512zH7K/wqGzNUKV4IsKw7qUJgRzvIOg=;
        b=Ychu8d2B9DuvH9IRGsiHzamdpcGwD8axxIosNSv1wCk1RVJZ/Sb2OmrKhY5yRTnkez
         cq+X3oB0pzvQ9eCOQH8NePND5hALkxax//7pNbgIqNRZ9EnHHCZpIneHS3iPyaOO/Bd+
         RSIC1JrBY260mF/Jba+NpDLR6UoCy2ZZNNlD7n64AeQxAsXZoixZ/Z7Xl5uGof5MFlya
         Q8hG0Xo8N9EqJBe8mMm8wCCWTYGhKkC/tdLs6Wr+HAmmwElxugrAiUSnh6f0F683IIuf
         siNUibV0S1UvraCWp4JLzAT4p/9a5zyn+VVa9dbFVDJ8ufIj464p/pKNWSdSdy7jk3No
         NiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343866; x=1741948666;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOV0U/zvIjE512zH7K/wqGzNUKV4IsKw7qUJgRzvIOg=;
        b=KuDJVzHmiAcHQoh82ju0P7g0McfaYMgj6y84pIjP6KWG9J3UNbJpf/8dSJ0os8iRD+
         79HjPd+qrZHg/BBsr5Gx9T3FG+eDLKad+ID8z2jem6Dxk/djkQ+zA/tlqakUV8qBFSBN
         mnmbaMnjgtz3h98+q+JiwqxnnQMeKcNr5JPPqbs43/zcpNO5bxis3jrfnMVFwSWYsy5I
         2NjnRbWVcehXYEm+9rh/vwTYAdP3TTNKkKEje0t/4R7HXtJssjjutE6mGp/dN1GszQFY
         VyLnrhk32XxAN8AQYy7T7pH2iAgiLKtWg9t7jlL+eILRd0JS39JK0kZohJR3J0GoO8Q/
         AFFw==
X-Gm-Message-State: AOJu0YwQ496YVopfkKz/Mdup/g+2iZwMCW48n1QmIKjmdaI24HbcUo8u
	Dgw9t8/aWxZQiYX5H9nzLkwV91AjfeAZxG14dHMkbZiYgDKuNdM0VD+aLIBgGI8=
X-Gm-Gg: ASbGncu8sOI4/Qvto54IYwfJw9Ka3fWMy+og9SiCKa+sX63L0V9OruF8EHMsHQMjiVc
	2B2iDdcooAorkEiCP4ViDqm9h9JsGeiqvZPXvMERH0kwZp6/YX6Ezck/sXaLtyHnjU3I/3s7F2o
	EE+IKiz0olFnejg7wfcXeWZJFKtYhfEHhlU6vMilbinxdnj4d3c6bNrBrQlatDQkMXA68SqYvL7
	lVpMu8H7EL48SfHsiSXD/0d656VhkmSZDJWrJsKiR6U7E8TWm92GJ3lReVxyVxTZpohv8hfudUT
	CE3tGEzNDWPH7k+PyDJT0Ow1sSnOzk06hFlK7LmzzkzHUsruGSLMkl8kOLTucNAu/RHT7aTQBV2
	6HmM4tJwQtULy/VddutsHZMY=
X-Google-Smtp-Source: AGHT+IGQfWWQP6jB5RyDg7f6ebsUwcc02OUYfoOBDIW7gWA8s98bB5ijQQiyLeFDo/jc+M3GKssmIQ==
X-Received: by 2002:a17:907:7ba3:b0:abf:7a26:c473 with SMTP id a640c23a62f3a-ac24e9a0251mr428452266b.13.1741343865313;
        Fri, 07 Mar 2025 02:37:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239887693sm252186066b.126.2025.03.07.02.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 02:37:44 -0800 (PST)
Message-ID: <162727f9-fb65-4bae-87fb-48fd5527064c@gmail.com>
Date: Fri, 7 Mar 2025 10:37:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/8] config: teach repo_config to allow `repo` to be
 NULL
To: Junio C Hamano <gitster@pobox.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, johncai86@gmail.com,
 me@ttaylorr.com, ps@pks.im, shejialuo@gmail.com,
 Christian Couder <chriscool@tuxfamily.org>
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-2-usmanakinyemi202@gmail.com>
 <xmqqcyeuhwqb.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcyeuhwqb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2025 17:53, Junio C Hamano wrote:
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
 >
> I am wondering if we should describe the effect we want out of the
> design more prominently than the way we try to obtain the effect
> here.  In other words, instead of (rather, in addition to) saying
> that we call helper X, wouldn't it be more helpful to future
> developers why we call X, to convey the intent, so that they know
> how to adjust when for example what X does change or X even
> disappears?  E.g.,
> 
> 	When repo==NULL, skip reading the per-repository
> 	configuration file but still use the system- and globa-
> 	configuration, by calling X.  Note that this ignores
> 	one-time configuration override "git -c var=val" given from
> 	the command line.  The only use case the feature to allow
> 	passing repo==NULL was designed for is to support handling
> 	"git foo -h" (which lets git.c:run_builtin() to pass NULL
> 	and have the cmd_foo() call repo_config() before calling
> 	parse_options() to notice "-h", give help and exit) for a
> 	command that ordinarily require a repository, so this
> 	limitation may be OK (but if needed you are welcome to fix
> 	it).

I think that would be very helpful as it makes it clear why we don't 
care about config on the commandline for this series.

Best Wishes

Phillip

> That way, folks who are planning to update read_veriy_early_config()
> so that it pays attention to the "git -c var=val" in the future will
> be rest assured that they won't be breaking this caller with their
> planned change.
> 
> Of course I didn't spend enough brainpower to make the above comment
> more concise and to the point, which the final version should be,
> but hopefully you got the idea.
> 
> Thanks.
> 
> 

