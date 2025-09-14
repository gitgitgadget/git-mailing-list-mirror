Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD01E4BE
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757857731; cv=none; b=ZH415CGjMAETUHJd7S63cfCGl6hzzGQVxH0CLdbemat1fDwrSAsCpfmdh/xkhRkIXjQBMmrg3g0tr2ERKoFcg3ElfNfwYXDHXSrOU2nVGgtJjGWmrfnQ+42w/ajyeqpk/5Wf6VXNPsx7x1GeObN1O2Y1x9pGxK8kpe1sfDElp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757857731; c=relaxed/simple;
	bh=96jtWZun7Db2y40c+QntJUPD+/Xx/x6RV10hkuct1EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8E+TC3gFnDx/VBKdJQ7+sCjTBZsZwSUJv11J2VvCBerypXCsHFCkh1ydd9DvgllsmogQ0/rV9H0/YbZQ89rHDtiS0+IHyQh8+q53mJBMj912DxF3bFBcprP8pyqNXd5Jop9V4HqSdrgtKoqbInmNzaSBeNlPJnnl6QDjjtJCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIZM6iUU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIZM6iUU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so1998515f8f.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2025 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757857728; x=1758462528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ3ewvN6MYL0nrmEH5gdJTTjY45HOJhLd9BHmmpb61Q=;
        b=WIZM6iUU9dTBOSp2RrgoCl/g/BKZPnmHgPawwjRf860gAXOaQMn2U/Mr/e/HzbZlMH
         7GamxStwS+KV/uxhSD1LYQWUw8+YI+C3ntW8nVQ5gXVVEcuaJE7kvn+XPRZvfC3bf6IP
         YHfSwHD3kWNYWJGOoAW2zGf6xvkNKdbrkUgHUp1YklSw4GKQdIz1pYXkmUWlbxjzFddS
         /CULB5/H+sQ6VleSi7J7rr7vD+ugQoC7dxefFZz+hMyqkpNpOLO9lg8jOY+E5AyvTm6Q
         3ExtDOXNMhTpMA+gy6T4TIu3Q7p4N0pkvX6eRd7+PBHllE/avdJ29oKTJ9rHBNliMlrW
         +Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757857728; x=1758462528;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJ3ewvN6MYL0nrmEH5gdJTTjY45HOJhLd9BHmmpb61Q=;
        b=PogMcgSRafFY2z2W3AAPgLg8IIiGey4qe55cX3prCxrWLI6aDMYDpy18/bIWw8gBrN
         ZEqihTFpL6qlS6XtWMzTORv3qX80/uKUzgKKgCBLzJTPquUL9dSsD923GHsgRfwL8wV0
         E+o9P49GSsDcAFHzC3zuGMv3PFUtl4uyxaAEYVaOuLUm9p11vuvLbEdV8ntEUdDlWLBa
         UE0gc4WerTzUkeZpt9OaNM6BYQxwmpNizyHAib2PPE35zoJKVBRai6VY8B0VL39geWHv
         wjXbIhm6gKkroEU+omR22P/Pr+Wzuj1o2zf02cM16+bfUE8lrEViFHxvwC9TXtnT6CfN
         WXwQ==
X-Gm-Message-State: AOJu0YzoDAyppqr7i9IKtLjZkUAJ1i9xDqehzmAEgJD5aa5GOpXcGp3O
	bgOXD8cEzwn7EVreM+lPLsiOttDLryW5BV9Lodx0sclQC3yDJ1OHroSmXI2raQ==
X-Gm-Gg: ASbGncvkETq1gfw2oi/iomd0bGnCkuxE2n9DrgugaPIbBFvZlx1JeNzeVaznOI6QW10
	F9IqKcdl2iVrvevm62kBeKt4io/Lqd+GGp6w1Oq6VjQk7v4/rjlRVCwQKOdz+GTg0Lxa10ybu9p
	aA80aHKDgbYhBpL3Sa6JEjttkReuAE2fVqZQMk9WaKqBmjxZiuEAJ5aMsrJ7BCZ8uN+/vzVM10Q
	A1Acd9YCHkERsqsmgeiQn2Gs/4RAmvrjahrvC1Y5OfEoWHWekBTbN+szJqhsqlsLhRAiSYOW41f
	PBKDRifT+AXfRI9q6hp49tTS8fK0ik+IoZMh7QS3C4fcuu99HSwokXzsvm7Kl93NSl19LSFUSw+
	x/7Y8XTsieC/0V5g+hebJpOVXK6VLGA3oq0WTrmnglmy+lbh9QjPEw4dbcrp+fx4GA88XsAHz/N
	xOp+472pR/UQ==
X-Google-Smtp-Source: AGHT+IE1ImLYlCj06yaV7757SdEjLEIUBG/FtKqDdAWNPYiWPt2zzAJh+f0VX+3VHnbV673DpGzEeA==
X-Received: by 2002:a05:6000:3103:b0:3e7:47e3:5af0 with SMTP id ffacd0b85a97d-3e7659e7823mr9345570f8f.52.1757857727742;
        Sun, 14 Sep 2025 06:48:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e911188fb9sm4622276f8f.28.2025.09.14.06.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 06:48:47 -0700 (PDT)
Message-ID: <a57d5857-b096-4d92-993a-3f09d15cdcb9@gmail.com>
Date: Sun, 14 Sep 2025 14:48:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [QUESTION] mergetool environment variables
To: rsbecker@nexbridge.com, 'Johannes Sixt' <j6t@kdbg.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <074901dc2422$2039a910$60acfb30$@nexbridge.com>
 <a5e01f0f-1789-427c-83c3-90644fa234c9@kdbg.org>
 <000201dc24bc$a1b8d9d0$e52a8d70$@nexbridge.com>
 <9a03a436-8240-4566-9383-7afbf740719e@kdbg.org>
 <004101dc250d$18173950$4845abf0$@nexbridge.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <004101dc250d$18173950$4845abf0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Randall

On 14/09/2025 01:18, rsbecker@nexbridge.com wrote:
> On September 13, 2025 5:04 PM, Johannes Sixt wrote:
>> To: rsbecker@nexbridge.com
>> Cc: git@vger.kernel.org
>> Subject: Re: [QUESTION] mergetool environment variables
>>
>> Am 13.09.25 um 16:42 schrieb rsbecker@nexbridge.com:
>>> Let me try to infer what is happening and please correct me if my
>>> assumptions are wrong:
>> I'm sorry to say that I can't help. I tried to disentangle what is going on, but this
>> stuff is far too convoluted to be understood in a few minutes. I cannot tell if it is
>> possible to write a mergetool that is not installed with Git.
>>
>> I would just copy one of the existing tool scripts and run `make install` from the Git
>> source directory.
> 
> Yes, it needs to be in the git install area. Adding export BASE export LOCAL, etc.,
> works to resolve the situation. I wonder whether that should be documented.

Looking at t7610-mergetool.sh I think you can use mergetool.<tool>.cmd 
to call a user defined merge tool. The value of the config variable is 
eval'd in the shell so if you run

     git config mergetool.my-tool.cmd 'my-tool "$BASE" "$LOCAL" "$REMOTE"'

then

     git mergetool --tool=my-tool

will run

     my-tool <base-file> <local-file> <remote-file>

on each unmerged file

Thanks

Phillip

