Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251F3BB44
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764376210; cv=none; b=llUreYqg9lWLMqPUYbjMx4GNaaE0F+l/O7+xagQdoWAzuE3gLgaq5wn203xxxJRqupW+UP8XCPCXXjnVmXRysfNhkXfljomn02+XWs+B5+vALzleDeRyGBdI5DOt5fQBpFkvoZqXLrhNzB/UHiWbT3R3r7UXtDylvgMa+/Oq2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764376210; c=relaxed/simple;
	bh=a2DkpqPegcYtZx5nHg1oA4f4MB9J5TQIWSBL/BvkUdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=N1trS+miYQy5tx39AA4CkE4iTx9Mj1vc5eWKRNSD8rIt1EeII2AZgIWAqhg5HTeb4WdVuiIW6eamchNA1pGqDnX41XxFAXhBMXi93JxQhbRjUkSmpTr84GhaXfXU6PJErjhOOyQ+6qaJAdfBoLiru9kvuWwV320XeJBOITOr2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpsdXjMo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpsdXjMo"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc8ceb76c04so1584754a12.1
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764376208; x=1764981008; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2DkpqPegcYtZx5nHg1oA4f4MB9J5TQIWSBL/BvkUdk=;
        b=dpsdXjMoVTfKbFuBTu2QDDGZZcZMZJoNeWV2xRiB0Sj0Sqoh9Twco+xg8SWnNl+iMq
         tOFbBPLBtHcUsESKvM2sKPw59UFX00hwjc+0dMoavu+gVkGlsaENd+v+0M32UYQRWt47
         gkL93QSwFwt43Y6NHHqBkKrJRO/OzEzCENTQRnMTVbdLBwa3MXeyxEqg5PsgWyzpwwYC
         1LtuhvXtOTDheXdmUhD/gYeEDTIHdqTxgcod7R8j2Gg5G4b9jHUQ8fCfHszxdJKtQxKd
         DiS9Dab2T2rImBFX5VNrLgOmcyDu6peIlApP/TDbRjXCnrIzfXnBQj9H8bTAwGB63f86
         3gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764376208; x=1764981008;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2DkpqPegcYtZx5nHg1oA4f4MB9J5TQIWSBL/BvkUdk=;
        b=QqGrW9J/oPVZVrey9XLCDnveEVb6mE4PGNlr4okl5f907zbjLBb4moLwJVVJXlPEMK
         KocCvANxhQOoSXzxZVdZ9Dij3qJQuIj4jpyGr5+RfRt9q8Ku5w+6Txq1n2l9Y+ueimEQ
         vfFtUObKr0GPUcdpXbcYp7LDzBltopXj/Nr3Nd4HnKeGZHgwyT/Z4fJQ1AR3W73W6j5J
         t5vc7oHhWHXMClrR5zQOnVZCCzSxik/zFJFfyJU8WhLVh3aTBYshFR24iLDPYKXSl19t
         /anzpU324RmmQ5Bz5GyPc/7672ahJShKmPkFXdk+3bwLjDcy6kE+b3BWkLQn7qe7vYZf
         kfmw==
X-Forwarded-Encrypted: i=1; AJvYcCUqtqfnH+MeYCfmRdNlegSvF0OqqzfQDvZ3N30lGdAzqb9BkhHnRaPBsUay4WKvQWIvvaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6AXQax6Bj+9da+q/cwJBkAkh2GKrBjhuwv4bpH7foNPJpyFMp
	8pOT5olmTNNkX2t8GNAf8owpQOjVp0gMcW8ypYldRtT93JDIC5xsCbydQYlRiaX0cakn+XxHArf
	403nLY3V8kdhogpnguyxZ0M091AQg7A==
X-Gm-Gg: ASbGncuiZyn4N1dVXwPzZD6Y7HP0b02HLGNKjEF8cgMaqbPl6EYxLDSTXDvCF15jVUM
	kEV+a9yauKjPTYIBqt4Yvl8vlDkPsUA5SWQk9gbZYRIYOt7vAWPBBwFPsybWoxZrNa9ze9MjewY
	YA3TyFwbT4Yk7tvcVCwYwsm6Kj3z8nCWs5cEL1c2mfRILjRMAqydIW93NBIbwjd+9WArsmOZbQF
	IQLIjeyLTL+lh3U6Mxr8/MT6njQIgrqQLpxFph1BzeVWMxY/DtrcqhZzLejEz8wJPL7WEZ+WZsr
	yVZLZbAQUoYh7MXMk7kDTW2QoH8x6MmAwQIt62Ubo1ciRsshmrTBDTkzTmtgO0E71YtXNWC9gjh
	rnQv1oC6PJ0w8c2wIyGWiNJQhpNlCUPwRHf1wtwTs
X-Google-Smtp-Source: AGHT+IFwpjm2C1I2ClfA5lneYVM0+F0IO8ki5ORE9o/tUqgreN0cwnjpdI+ggBQ7lEP0e/76YWNbq4JWHc5VXxaCJ+w=
X-Received: by 2002:a05:7300:d405:b0:2a4:3593:c7d6 with SMTP id
 5a478bee46e88-2a7195cb23fmr17148503eec.22.1764376208550; Fri, 28 Nov 2025
 16:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=S_8JufSGCOBjCQJ6R1Lq-GumJXTPzWGv2JCZK2SPw_XuGPA@mail.gmail.com>
 <aSo2n2dhEoZd3nZW@fruit.crustytoothpaste.net> <CAB=S_8JFLYsGe7fs7UjCfFfTJGMqpikZavztU6ZiW4KS21A+MQ@mail.gmail.com>
In-Reply-To: <CAB=S_8JFLYsGe7fs7UjCfFfTJGMqpikZavztU6ZiW4KS21A+MQ@mail.gmail.com>
From: Justin Su <injustsu@gmail.com>
Date: Fri, 28 Nov 2025 19:29:32 -0500
X-Gm-Features: AWmQ_blgpTrfAswJ2tY4HmXj3oN8t0xlwKx_LHMoVcGVKjKH7zgeto3pqNIqmyM
Message-ID: <CAB=S_8+omhdW9Mx3kr=McZvoC-GbftWmsBVLQuRH=0CmChq85Q@mail.gmail.com>
Subject: Re: SIGSEGV when running git fetch
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Justin Su <injustsu@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I narrowed down my Git config to these 2 options that reproduce the crash:

`git -c fetch.writeCommitGraph=true -c submodule.recurse=true fetch`

I tested with a fresh clone of the repo on a new EC2 instance.
