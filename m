Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B320217F24
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301081; cv=none; b=DW3RW/JyaFYoycgVpmu2xpiYIRTKTtTDEH4NHEa5E0/W1EL50r2l4spFh8QZlRypfvAkb/zUvN2EOQWpn3CoGIiNcVgmCVgJrlAId9c53qwQ6+f8Mfe4A0Wce2rNHB/zSO8ZPmEh80umR8l01aHnDHl2HJzWvg6XE2o4Id6vrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301081; c=relaxed/simple;
	bh=Z1ODwwG/bG/FLzocCiKhLNc64xZFCemx7O28FwOMym8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khoJlQ50Y9QvmEc2FsreUOzji0AOlhkX0xSeoS2IMXriFBAmmhGn2OZgfSrEv7v0eHGGk7T5AxKuqZngnGJdaBFkJwhZAciiHL7HT6pDcyqBdpvwcaln2ARjcGRJbuezrPuXKvSxLZYvD7mpXVdJvDFnB/0JO7JVGjgfOhKORTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG0A23dp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG0A23dp"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a367a1dbbso17197266d6.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 06:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770301080; x=1770905880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6uVIqim8cR6r1k3YeQPwDr6og3lwtYsjgaHLC608FQ=;
        b=eG0A23dpEetaq1bUmR4VLdggkHeIk2l5lOdXGKn6PimahRm0doEgRZcBMYJdpjpUJE
         mscoSWg/SwxOjNhywpxwRo3LwjT75wRlp48hCCFDGjfO+oNSH+QJxg0zrhh4+Mh7Qqr1
         vSF/kO7hAxG77EvgUL3wWzsf0g4II8Lku7JcL/PUH5V0h5Qi86ODhM69Si+CPFR3DyQv
         ocl2FoBQ0F9BJtsfrOkjT0oEkGdfJq2hjBx9V/UaybEJfB+IsHt7mBcV+rGwkbavSbn5
         7f4UO4kea2FY/EpQS+4NShjh6gA3tyCYI2kcgUebVR9CR4dq2tOru1sVdEsFIXDA/IY5
         0yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770301080; x=1770905880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6uVIqim8cR6r1k3YeQPwDr6og3lwtYsjgaHLC608FQ=;
        b=DEzReo9U1tOfT1Zk/IjcAw6Ifh9pVlq0AISaLB5vMZjeiAW/TaSYMRACYRo8wrw1TQ
         JQrK7JuqFBhM8PZWpYR4c/hKsiJ4U+ncS9Hwf4bsCZ+9RabxpNr50/wGkFHGOMAWwcUD
         eY8EMBH4VX/ijQbJwWMM2pdmMEu1B3QIkJw1gR6R9Pt7biToISDD1iuajCLclTuH44Mo
         gG7+oi7Z40mwd2mqTIJMUshKsg5xtr10dm1gAO12PwuEvyDC4maZSK/BC75LNa4EYdtD
         qKXM++bGK5P6T6PMdd+BWdOs2rrY0J7QNI+EFsiZh8jYLvYR8mwUc/OBjNw4bWhTyilT
         Kt+g==
X-Gm-Message-State: AOJu0YxeZMCzsaCWRQHU/WxXWrPKiVr0sPx7Y1/+274HX5yFzDi4G6Tv
	nR9LB9jkWOrPGTcKorok1EOD4QHRszlqRZ3e+kvED3QLaFRyLSApXZZi
X-Gm-Gg: AZuq6aIrDadqtUSID3Joa9czEk8HwTMulbgOp3oaX2oss4VoMd1oWxRBAi945q36W18
	v2cRMcjZavyt0JOfXoB0yvtwSL8dhUgqbilBSTtCmMYuBbrP3G/z65iNes22LY2WYVSz6r3t1ef
	KGQaIzFLOld3+kfYD04tqS0Na1Scpq7P3Gf2NK2hNMYXYu3Q7QT05AVXb+hEg5PruKzdrl9wDhs
	6JEvsix8Z+Nwz8P7k6Rh/ulvJhHtEgn2/Z+Lq5bHocFbin6NipQZ7YQLMELj0IAl8wFvpMLnNnC
	h7ivqllFY0Xf9+M6xFP8IrhgdwIgb4Chvu/2L308SWUCAtnKToG+b7S7D2RWGPMKjapxvaSpCAV
	4S6/bHO1xdthwpVjhZXCApzxmcwxLx2CO/oSyCH3BsjG7H7SAeKRjmGWbzfSlzprp6FR+wN57qo
	xjixIG9pD8YBG2Vclmeg/xnfrlaIQXSpTS2i/fa/UW15jboM6xRhdBZ6DbxQ==
X-Received: by 2002:a05:622a:144c:b0:501:4e06:695c with SMTP id d75a77b69052e-5061c1a98a4mr80022721cf.59.1770301080165;
        Thu, 05 Feb 2026 06:18:00 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bffb41sm42516856d6.4.2026.02.05.06.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 06:17:59 -0800 (PST)
Message-ID: <6c8b984e-feda-48c6-b67d-80a41343bfc0@gmail.com>
Date: Thu, 5 Feb 2026 09:17:58 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] config-batch: basic boilerplate of new builtin
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <c4dab0609613bc5d43bce705dca2f057674a5d5b.1770214803.git.gitgitgadget@gmail.com>
 <xmqq1pj0nleg.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq1pj0nleg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/2026 6:23 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> Later changes will document, implement, and test this new builtin. For now,
>> this serves as the latest example of the minimum boilerplate to introduce a
>> new builtin.
>>
>> Recently, we updated the comment in builtin.h about how to create a new
>> builtin, but failed to mention the required change to meson.build files for
>> some CI builds to pass. Fix that oversight.
>>
>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> ---
> 
> We have had a bad reputation for having too many commands; would it
> be better to present it as a new mode of existing "git config"
> command at the end-user level, I wonder?

Interesting thought. I think we also have a bad reputation of commands
that are overloaded with too many purposes.

In this case, though, I do think that the modern 'git config <subcommand>'
model presents some clear boundaries for how the command should behave
with the 'batch' (or 'server') subcommand. Grouping all config-related
operations in the same builtin may be ideal. 

> Also after reading patches for a few early steps, I do not quite see
> "batch"-ness in this protocol; it is strictly "a single request is
> met with a single response".

The batch-ness is that multiple requests can eventually go to the same
process. The client could collect multiple commands in a batch and send
them all without processing the responses one-by-one. This is how it works
in the tests: a single input file is prepared and all responses are
scanned after-the-fact.

The back-and-forth mechanism is how the git-credential-manager tool would
use it, because it dynamically explores certain config keys. For example:
it checks the deepest possible URL for a specific key then peels away the
last segment of the URL to see if there is a directory-prefix match in a
key. (This is the main reason that there are so many requests in this
application.)

I believe this is similar to how 'git cat-file --batch' or 'git cat-file
--batch-check' work, which was my inspiration for this word. If we regret
those names, then I'm happy to move towards a better name.

Thanks,
-Stolee
