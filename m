Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F822DFB5
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669771; cv=none; b=C8H7TdypIQKMobjrTfuLWeiXCcM0nf+MFuAZQM58ainLnltT8fIrBjr8EOf9eTnpkgB+TpOkYBH8cjHsA4vLiSCxmraalLrvdr7QqiRASYMjPOimGreFcY1+XNmtY86pO4ZJjk7hIJgVdfTnKicTO5nUyMxUOy+BS0xpLtICI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669771; c=relaxed/simple;
	bh=9DlznDkOPM9w5WEze2M87jpF8UYexYdcNrWeJ4DbqJo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TbGktZSIyUtqPXa6p1WZD1aXQfhK30YuYnMfDaGeWvibTdrLVEsFJhgAnUr+u345A81O7sqHEPQ15K2Ctv0jIdZFJKzXnO8HsygmjjrUAET/25XpBDUhbYX7ffJMoNfMnCe/6zE+URQG/+fzvhwhG7UImn9EExAxDObmFq12d6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZlTc6EQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZlTc6EQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so3358745f8f.2
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750669768; x=1751274568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EoCe0trbfWoxSpT69VxqXRYXJkxFUJvkCH29NChZnwI=;
        b=AZlTc6EQBMHniZmGAu2qNwsAGu3VaUL6+OW7juS2PfFUEbi8jAnu9AEwhj6mKFeL5a
         Q6tIGibiuaw0dycKkJHLXXxmmFVix0EmfaO/Lh7u/mCS5Jczhn/kFBLQ9BjHQ8lBWRH1
         AogwEl9VZr7xg/5/oMCw3OuofPmyLgm6ZAfYZnPtgqodU5Hj1uokyq5WMyXnyjnh8yBY
         t+n7/tZm8O7JBDiUAx+Yy02rtFVeNt/3eCWkMfO6QyJv9bas8nHqmFk+u+vwI0jKHkJO
         yz3T/AnR+u86ZXDx5UbdGrASEC20W1xJK98YeNzLh7TpMi5jDfFMFfapcd9UYxFutSP8
         7b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669768; x=1751274568;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoCe0trbfWoxSpT69VxqXRYXJkxFUJvkCH29NChZnwI=;
        b=ejqYaieW81aHrCD/xuV5GF4M1c8gHZkkmn2X8eoYpmrJlOtttd49Jp/3ykmM8aThMZ
         DzPp95rV3cx/fSg36lEr1gpWLaUJ4exv0Osljn5R0z9ODFDLwdP7Bj2Eay+qyz4AbC1I
         SnoVk4L6jgKZBU16sR7D6N3YpBL7Ha8qGCahXC2rQSIgb59Tb/iN5lre1+AX9Eu5R1Dx
         KjyqQg/MQ/1R+GCA1cVo7l7Yzwmvj/QyMg/whP6EMqCYuSuwW2Vq7yV6T0f4yILVyKCV
         cprFtbufr2bx37BLBN2ck9ZT/fptvpDg5PwPTbBMwhehQosdJ4jsjPmZip1nSp+NjuEY
         jrZw==
X-Gm-Message-State: AOJu0Ywfp1iiIAq/Zz6yCpZO6IibvqLQsYruCttZNRd87uNNGz76m/3G
	pXa7xdPRrQbXuCvdCDmIDKaNcRhosZAJ8npgj4+Muu2KkQBv6ZSH76tc
X-Gm-Gg: ASbGncuLgeki+vlAO+sIr/gqJcRYGWIlWOCgD8Oba3TFbGKorzVGuM8C3afliW9UXyw
	02HDYRgUB4OOEZLetAgv0XSkDCxywQmJoLwLXLNc9jIOg2RcZQbBwgf/t6sqELyupM4vE7nqIWi
	5Gy8WhLuDeiRnR3zaRlbhPJPWpVNKIJhGu2wyPf7aw1TdyFYHYi+bCLcZSLvfj/sBld1Z8XLOI9
	7GTuGvxMPNwH8AF16fhRZxFi4g6aXf++lRfbPKMHDsgBv2w8yYQU1AWws2TlV3YzF9vwAWyNYEc
	/sJRVH20lS9rNMNueAAWwJEWvuxQVa9N1kf5ieZiZrg+Zm5wYMJc1Cqghu3ygFubWKOAaHhbBG3
	Jn1AbAv7JVZXPyD5q8z4ArwNVBX9gBJMatCVRAA==
X-Google-Smtp-Source: AGHT+IHOm5E5n5/eosJq9rms83dcFdFn/P3DLwwoHZM0y28NgDn2gfVi53nnJUGbx+tJVt3J/h+Qfw==
X-Received: by 2002:a05:6000:4282:b0:3a5:783f:5296 with SMTP id ffacd0b85a97d-3a6d13339f6mr9849472f8f.56.1750669767760;
        Mon, 23 Jun 2025 02:09:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1057esm9046286f8f.10.2025.06.23.02.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:09:27 -0700 (PDT)
Message-ID: <c787a41c-97c6-437f-aae0-52132c79db7c@gmail.com>
Date: Mon, 23 Jun 2025 10:09:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v19 00/10] imap-send: make it usable again and add
 OAuth2.0 support
To: Junio C Hamano <gitster@pobox.com>, Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Zi Yao <ziyao@disroot.org>, "brian m . carlson"
 <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>,
 Ben Knoble <ben.knoble@gmail.com>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqh60a4dk6.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh60a4dk6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/06/2025 16:50, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>> v19: - Use xstrfmt() for OAuth2 strings and strbuf for PLAIN.
>>
>> Aditya Garg (10):
>>    imap-send: fix bug causing cfg->folder being set to NULL
>>    imap-send: fix memory leak in case auth_cram_md5 fails
>>    imap-send: gracefully fail if CRAM-MD5 authentication is requested
>>      without OpenSSL
>>    imap-send: add support for OAuth2.0 authentication
>>    imap-send: add PLAIN authentication method to OpenSSL
>>    imap-send: enable specifying the folder using the command line
>>    imap-send: add ability to list the available folders
>>    imap-send: display port alongwith host when git credential is invoked
>>    imap-send: display the destination mailbox when sending a message
>>    imap-send: fix minor mistakes in the logs
>>
>>   Documentation/config/imap.adoc   |  11 +-
>>   Documentation/git-imap-send.adoc |  68 +++++-
>>   imap-send.c                      | 405 ++++++++++++++++++++++++++-----
>>   3 files changed, 407 insertions(+), 77 deletions(-)
> 
> Looking good.  Will replace.
> 
> Should we declare victory and mark the topic for 'next' now?

I think so, the range diff looks good. I've not reviewed each patch but 
I just had a quick scan of

     git diff origin/master origin/seen imap-send.c

and it looked reasonable.

Best Wishes

Phillip
