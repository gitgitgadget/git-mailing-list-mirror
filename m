Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490E1EA7F1
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261664; cv=none; b=V8Q2zKPA6mb3eE8KnUTM8C/t+MnF4raAev3WAxo6jAuxT5aYCwyhlHpoCRfg5AvRO54kta3OqMMtW7nkXdkIjgj+HoIg1vC40RqVRbF/+5vF8JdwsPaG18+W2Xm5iDn82/5wH5FdoHb0mOJwjN0xAXeVXJFXxx4khX7LI5dl76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261664; c=relaxed/simple;
	bh=j/EARLM1u7oircRfvNWNk5AIUxlol+LKSs1KOwX134c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gO6AxrXHea/I3eSPnXaXCZLQan0t65j/GCINcKKtLD7ovAeK00iJAHWxgF6FieBm0k76tnM/9NDjZUgpnppSAQiD4I78imusy/L9RfPd/VohaB65ke2hUTihEqt7uF9a0QEdxweSjbl5iyZcrUZ1WQnySUSVeJhkydLS6mRaXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL3WcAp/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL3WcAp/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so32489305e9.0
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745261661; x=1745866461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cGsFHziJdS+yv5Oi8xV8yNITD00Ic/03ylbhSZgo5Nc=;
        b=FL3WcAp/GasNpbEaE4OhFlfVtWs6l8zIPyJyiIkAhEWzZCsX3Lp91/8zDpqYeca6U1
         WUdvovv4tzWHfcgjqdf6H8zYBhgVUAMaBPLF5dIiPpD9Lm7RwWpSvB7WZeYjf3hj2d03
         9D4BCCnZh7C2c4ymE3bNOHkP7iotIZfIm21eNArCZ8uaBWuu3RJxlK8eNcBQy70+kZrR
         YAsXUHIx+29U6+LjSxc1iVLxtMnyZyaZZ3Roup2s3+vn7WSnBjNFI4CyIC8K6yJVhKR/
         aw84xB56LdLbhvUXXEI6HfcVyhwT6E/tMPOFyPUzfVloHrUNjQtfy4mWleANa/Wxj4lH
         0ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745261661; x=1745866461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGsFHziJdS+yv5Oi8xV8yNITD00Ic/03ylbhSZgo5Nc=;
        b=FPxr5OQGySb7MyINMwjFP05jmVNai8QBwnicTcBkA9aCTFCt+1iv+4O2oz57pvAUM6
         kgTofpg3QZc4Bpde68f7q5F+a6z6fdq9xOvGcP+Y3SH/STJ2Ca8qY+rO5ZnuYbYBRJkz
         DzIhwI1jW7yZmTlnVeynqTgu5jk88Ft3UtPqnxx55JhmvOW2wfYWFsiUJ65HlqSEMeOQ
         Uv3j91u5AnTqxRWvR6CuY3849hmPhKGiBJCjCPmUavnmmvhYAu21q1TCjkIpzVXWwQSh
         IFvn5NLarbLzgCYfioylGg8iahY19oTpGqLcsTxEEsYsMWoRPdx+tdw9azApOgKqy3UM
         G5/g==
X-Forwarded-Encrypted: i=1; AJvYcCVdHiOkPWIqQGvRzaswqCzj9cL+pgzJZMbhG1FdxQ7WZpGCznSZVNz4fneHbCSZkwrdb44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRBsGDf0rUed6JqJMKXV8OI+ocW3u0H4NihHXHjst+gwjlA7qp
	afHF9i4+KIB7DDMbzWCztHjP4XpyZmYXEykcnwYVLCpQVZgpPbe+
X-Gm-Gg: ASbGncuRb2NZCBtlEGqZd/el44DMTT+RX4A2efYjwJUPQBhac6hHXKSXJIKVKVczHgv
	z9fkyMV0yZOBVaE3g9hohV2sUO7JJGOQThM/6xrfxzNwzmtuj3wlAB11L1zXdqdJYYeOmV3HLQ4
	GqAREBQdiR/FKK1rW1KoGoqWA0WtU/NJl5H/NKBq+KYDgxyqexljBIcHluu47mElEPzg9/PAU31
	1Hpg1VBc+ehx06owChpPOepp+DeTo/eM9N0g1C+ITbVsx7RmFMgVyeC3ewB+zvjiu+XqTRUeUCa
	47RU1UoSeSi58ZsC3uLzNjHTZY2l+zncswikQ9wgRdLciME58WH5n0t3l3TrxayJGDxAGQHY1Nj
	GNP+3sWQAoPGvxFZ1
X-Google-Smtp-Source: AGHT+IEcq5/c9qvzmcSVr+5D1O5ujx9hTPVfwQNyLDBRfVjUvfNCgzuLFGwJu2KAbsqFPIEXmjDz5A==
X-Received: by 2002:a05:600c:5395:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-4406ab96f63mr120588365e9.12.1745261661269;
        Mon, 21 Apr 2025 11:54:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acccdsm142715215e9.11.2025.04.21.11.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 11:54:19 -0700 (PDT)
Message-ID: <3389d086-4e6e-4896-94dd-9f62d7c4f2df@gmail.com>
Date: Mon, 21 Apr 2025 19:54:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
 toon@iotcl.com, ps@pks.im
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <xmqq8qnt7c9w.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8qnt7c9w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/04/2025 16:41, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> "git ls-files" is complaining that there isn't a git
>> repository. Looking at the output of the checkout action (reproduced
>> below) it appears it is extracting a tarball rather than using "git
>> clone" because git is not available. I don't know what the best way to
>> fix that is - I guess we could run "apt-get install git" before
>> calling the checkout action.
> 
> Interesting.  The use of actions/checkout@v4 is nothing new in
> Karthik's series and we haven't seen this issue come up.  What's so
> different with this particular series, I have to wonder...

Good Question. Looking at contrib/coccinelle/meson.build which is where 
the invocation of "git ls-files" has been moved from it starts with

     coccinelle_opt = get_option('coccinelle').require(
       fs.exists(meson.project_source_root() / '.git'),
       error_message: 'coccinelle can only be run from a git checkout',
     )

I think it is probably fine to skip checking our headers and running 
coccinelle when we don't have a git repository but we should ensure the 
meson build can still be configured in that case by skipping those 
targets. The Makefile falls back to using "find" if "git ls-files" fails 
which is another option.

Best Wishes

Phillip

