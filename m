Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FED1E86E
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617389; cv=none; b=qzPbZSU6B45iIX4gGtPz+1jdWPO8Maca/SWzbQllqUxXzhVmt3JenfiCx/W83YwVa5TLqGZ0k/46HHF06j+CROwmLwKpnRi3pDqH769Qzyn1NQIbGs+U3/T6FIavkLPQbBrAW7r9aGbp+g4O7klVMqRKBNfeq7332S1aLn8mt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617389; c=relaxed/simple;
	bh=300ldf3PLzdxHwgKhYd44HpQRqYN/LeOycRwzGw6l04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXTWLvsJnjN4HsX6HN3FBLzU6KHg3oicrscPE4r6S6IeIxaF/A/R0vECFAoyyJCJkaHfcWIKoNuLILb1XiAX0i/FmUX+bTbnjT2ijSi7FvJydQlGt2MZmP7iGWfjEJn+qlBjTCy4GVJrIeTSnhSRinbq7vf3tmdydpX4fKuW5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNkcSV8X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNkcSV8X"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45310223677so4091185e9.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751617386; x=1752222186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MLUu/p5v8CYN9rtNxJktMUOPGv4vjWfVxT6pBoNLyoM=;
        b=fNkcSV8XovqBcOjP/wKk6KkrIWlORFCSbIfHskc+FYonXbbgJ2t5PPXCS+slNmoXNG
         MVvPpzCuj9V/kQOV8LJZzsSYQdg6YwPOHCq7c0o1Hp4wCING+Dlz8xgnLduIeNjZudrT
         FV/AebMaBeFRpNfw1Tn97WSMju9qRxLGdXvfmmX2MRDIdHlQ9ol8zoxRrtTiOe9lKsEK
         sZmySso+YrAWxdYzqDq7fqPvreQmLqxr5bRwW4+ZBwj3Rq6KBVofIpji03XiKH4dNQDh
         TyNvDOuq15rHunFifBZA4aMU5Cc9F5NyZxoVoU3LPRr+O5I/N7ZmUKFQj755I1OoaN/7
         N+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751617386; x=1752222186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLUu/p5v8CYN9rtNxJktMUOPGv4vjWfVxT6pBoNLyoM=;
        b=wpolLWTUd+xXVFt2nWhqzT/CUFZEJda+XLSfnH8qNhjc7ccEbpkKk87NE6AD+zfyOy
         1sLbi+KVzzybG2LexF75h7ykP+YMvfPi0Yq1NvmEoCUC7oAmCKvKe/q7YBetbsj+kTBP
         KdG5ZrooquzzLPJ7EwNpe0K9EpaQHXcR4+pFKn1M5/8UMmLRz75Of7uZ0zRK+tJHd/Vb
         HItQ2VtRh7/Rqi37KRnXLxGbG7Qvr/d2KVzyhp8kF95oKiNntNrEWdeB4xEDWE4YO5hm
         ntAbA4JQsjsjS4a21W6A7WrSil2zDYp+/hiyGwo+cS4D3pBwMxDO6wu+HBeQx0JcYWAo
         5Zig==
X-Forwarded-Encrypted: i=1; AJvYcCXFpJjvI272Q8+c/Wabo2nkRxE4V3JRQPfL5idwhU5sPgGvSqC3JTzFk+oM5xB1dCMDne4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqsNFQRQSgzSz8XiNEnEfU/mT9DZ4UOrBECpbUjHu6s3MdMVW
	0xbp/1l7CPnzKYLTk4BQ5WJo5S3JtnTEQsixtCE/gfX0DJxMccYFWEmv
X-Gm-Gg: ASbGncuEQk8eJmIPNVlQRYWIa2NOyLySuKFWUWe2qR/RCfRnEPZ0dM+EPFZHToqniXk
	IC4pLRW3RPBG6eDcN998fuxVQLUDq3GNcx1RFHpd375EPxjI2gM6011F3Gs0JYH84jJ3p0apjg6
	sG5/fN8tL5IEZNhxQxOEGmBhdpMK+6DjmPZzOoxb4IWT8oi2Lqm4VC+s1il7cuycz1wzbiiGvdT
	Dgo/jaMEyblas6wp6G3v9F7sJUpSOFVEdKUH9xgrFrqMBx/gQOu1eGi9WBYe2CnlJ6WjPC/UKBU
	PKAA1Xb7/OFQjui1Mcd3a76KW6klwgOlGGpd+KM6uBMaQnLqp/n2TI0/OL72Xnk6lJDPfEn35CC
	UGRgUTha88ZU+8su6sRzpRA6H444qhw4RVMTxtw==
X-Google-Smtp-Source: AGHT+IGU6jL64Orv2PXTJQg3Y1j03QNHcdqZ04ZLJPDfG9dF5DBLZZzADAQamXxHQwmiwvIoEhjcnA==
X-Received: by 2002:a05:600c:1c94:b0:43c:ec97:75db with SMTP id 5b1f17b1804b1-454b4e79819mr10387035e9.11.1751617385651;
        Fri, 04 Jul 2025 01:23:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b161e8f1sm19849025e9.8.2025.07.04.01.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 01:23:05 -0700 (PDT)
Message-ID: <062e7abd-97b1-4806-9753-338906642265@gmail.com>
Date: Fri, 4 Jul 2025 09:23:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v3] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Ayush Chandekar <ayu.chandekar@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com,
 gitster@pobox.com
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250630182527.69167-1-ayu.chandekar@gmail.com>
 <f22e864e-669d-457c-838e-961bbc977c4b@gmail.com>
 <CAE7as+Z7GXMB4LJGwESK3Pj63ppfFMKDq-xw46YCELJ7E3p+DA@mail.gmail.com>
 <9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com>
 <CAE7as+abNzqbGSCWsuYe8D_c5dBUuRdDEbHL0pVW5j3kTMER4Q@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAE7as+abNzqbGSCWsuYe8D_c5dBUuRdDEbHL0pVW5j3kTMER4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ayush

On 03/07/2025 00:46, Ayush Chandekar wrote:
> On Wed, Jul 2, 2025 at 1:02 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> diff --git a/config.c b/config.c
>> index eb60c293ab3..bb75bdc65d3 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1537,9 +1537,11 @@ static int git_default_core_config(const char
>> *var, const char *value,
>>                !strcmp(var, "core.commentstring")) {
>>                    if (!value)
>>                            return config_error_nonbool(var);
>> -                else if (!strcasecmp(value, "auto"))
>> +                else if (!strcasecmp(value, "auto")) {
>>                            auto_comment_line_char = 1;
>> -                else if (value[0]) {
>> +                        FREE_AND_NULL(comment_line_str_to_free);
>> +                        comment_line_str = "#";
>> +                } else if (value[0]) {
>>                            if (strchr(value, '\n'))
>>                                    return error(_("%s cannot contain
>> newline"), var);
>>                            comment_line_str = value;
>>
> 
> Thanks, I understood it.
> 
> What if we simply return the function `adjust_comment_line_char()` if
> we get a non-zero value from `ignored_log_message_bytes()`, i.e we
> won't scan the commit message in case conflict message exists, and we
> let the old code exist as it is?
> 
> +       if(ignored_log_message_bytes(sb->buf, sb->len))
> +               return;

So we'd ignore core.commentChar=auto if we detected conflict comments? 
That might be surprising to the user - it would mean that we'd always 
avoid adding the conflict comments to the commit message but we'd lose 
any lines that begin with the comment string. I think I'm leaning 
slightly towards the original solution but it is not clear to me that 
one option is much better that the other.

Thanks

Phillip

