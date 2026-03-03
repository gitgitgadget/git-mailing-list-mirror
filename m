Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72F25DB1C
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 04:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512358; cv=none; b=M/KfZsJm0henfCkw16m4fLZ9ONv00iIrmMlvsPvOvgRfvUUZcQ2cBWy25oXO5+LYvRQr/ujiX2rx3myMIspRHvc5JRarCjtYWoBueWFUw+Q1hqY1fpeygmNUFH3LrnGhHjBvCnw5NWhTJFImVED59ADX3DB4XXnHNjKlMw8Llx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512358; c=relaxed/simple;
	bh=5H5r3VP+2B++uzOwDoAkrNA0b77bpE30gcvyhoS4rEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbqFEAa5ZPm50ZgmVdaGrH+OQfJ2zj6/o6ONqABaQaDI6TrKA9sGL+cM/G44UwIvENCPhgHs4r1e3n355sOJHF+7ZkkHxjs8VLP/ybIPvdwzPz0kmMy11/PAjU5G8m2z3nooOy1lKeOVosVpRQPRmesoZgL2P7k+20VtiH+Gsiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7hGq+7L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7hGq+7L"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a9633ef0d6so7464165ad.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 20:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772512356; x=1773117156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfyBWYUDiS1UJ67IU0NHvQId1X+KyOb9RUssAqp/wlw=;
        b=O7hGq+7Lhokwg2gqNcDQhgVjGhxlnjGAXywA0es/wnFygWC3Zip0JHB1Rd1NjUztZ/
         nXl7pphY2b1woY4UqFiowiSKqtM6vybpI2s9EmPyP7EJ87q9idLVSGyhpxAKYbcArHSR
         QAqrYT0iWSm616Rh+2Q5xVZMD/PP9U0BooiAMaPn4mtM/KSMvodBPHAgwJx5jcxACPbW
         VP7XflQf3MaBflgAjIAD0L7ul+8Wu6OfikwhfA29UqF6uOmd9LStTdaU26UHP4DO+Lyj
         lyZQ/uZDFzUQG+KoBjMKnpsq0CIfyEvhRnsD/oOVvI1w0FwxjPhb/KudtiAIqQSJKp+2
         hQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772512356; x=1773117156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfyBWYUDiS1UJ67IU0NHvQId1X+KyOb9RUssAqp/wlw=;
        b=le+ncvZ15SYjKG62JKZred0sZrRHQ82lqo1uvR3Q/cOjMN5dOGg7KNRiSetVE0MXOx
         T36AMTaeWwAO6UUpUx+9s14L2zKqxRAAMIk2fszRTfDog4KPOXg/XSy5CU0/7qHy+uZT
         Thzsc6ptvnWK7F4KnIvCDp/2nYIB9m8jG9sUlYVCAmurKF7tdpScHnId0I1VHGKhyUuR
         SHDYoHWdWe3US79EgsgSrYfdv3nVQkeU/4SuB84ItPYswGTS9DZ1Ae/dz5Fc+ZvriVy6
         vk030MHCg4TBB5qVpBMYJNKsOyVv+SU6FT8DR5eIQiRdw1n856n1MdLKoCTw0vAk2+6x
         r46Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYgIeWwNpXL0I814BMb/rnEFVBtey/hwNjz/EjihlKcrihNlr2C2iZQ2/fwMoZ7RF2jW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1367xD/jcDNqlj8AwkTNOpwvV5BgzKRMgwle6Rwe/HI84JQA
	ceZXUHiKhnAyif9FmZ2QcEh0BOlvPso1GXWEmbRlU5ReQRIXMIJdYVL+
X-Gm-Gg: ATEYQzwbl3Cq0KojHQhRewigJtQytYZkoNMfLmlfbxzW+UMidL9KYGy8U9GwhyEHmwP
	0/gWE0GA6p5L7A129iiUYU6rI8sOgSoRUVTS9Pey1J9cc130DxTCMnQJpCjLFduH2tMvHX7BWvd
	RCNsZ+kN8TCDI+Angk6pBjBTfzhgeYkYoXLb0VWzQfuoocLU4DkIM3HtgYTim+Ripc6cAdnWBom
	Htlng7cAeXxdaxG7g0mnHYYIiBqzG1B+fKLW9qQ1I0xYtN+sVqqzHROl7ofd/ETa/OU8BmMtTjS
	dh+GNG22OMSUaM5KUeFAGwwh5I7dJ65RMI5IJ3P0sG4j6cEy/AzqROHkPkhCIvHnNBAf1iTgDjr
	JGjVI30W6QWgpXtpHYQabbklXh8E7864YUMZYephW+uoSs8XUHLfVIkCfbQNJGLbJucvdNWYnew
	m/Alh0UNI+h5V23RjcQuiZOK/aPpFlbGBm8pqxd/rVConCpfVzsKWHwvnPO7nvwYHy2H89g10Je
	s3jmowpxXBf
X-Received: by 2002:a17:902:fc50:b0:2ae:464f:fe3e with SMTP id d9443c01a7336-2ae46500022mr55468225ad.5.1772512356429;
        Mon, 02 Mar 2026 20:32:36 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae49bf44dfsm59584675ad.16.2026.03.02.20.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 20:32:36 -0800 (PST)
Message-ID: <108ccc9d-5777-4c84-9dad-c2d0f5dc2e42@gmail.com>
Date: Tue, 3 Mar 2026 12:32:32 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
 kumarayushjha123@gmail.com, valusoutrik@gmail.com,
 pushkarkumarsingh1970@gmail.com
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net> <xmqqbjh64262.fsf@gitster.g>
 <3983da40-bf2c-4665-a7d9-dfebaacb8bd3@gmail.com>
 <CA+rGoLfbzXqP1Tw+94jMmWcSGPoefMv5E_fvwriad-O5CUeKHQ@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CA+rGoLfbzXqP1Tw+94jMmWcSGPoefMv5E_fvwriad-O5CUeKHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi JAYATHEERTH,

> I see your point here.
> but wouldn't this effectively be the same as Ayush's suggestion, just
> with a different syntax?

In my view, this issue is actually to choose the most suitable tool for 
the job. After all, we don't want to use something like rev-parse, which 
is riddled with *ancient* technical debt, nor do we want to write an 
even more verbose parsing function from scratch for what you call 
verbose user input, right?

If I'm not mistaken, using different parsing functions to parse input is 
absolutely not just a matter of syntax differences. Instead, this will 
directly result in differences in data structures.

In ref-filter.c, we can easily see how Git parses format modifiers.

After the user input is parse by parse_ref_filter_atom(), it is then 
passed to the atom_valid[] static registry, which is like;

static struct {
	const char *name;
	info_source source;
	cmp_type cmp_type;
	int (*parser)(struct ref_format *format, struct used_atom *atom,
		      const char *arg, struct strbuf *err);
} valid_atom[] = {
	[ATOM_REFNAME] = { "refname", SOURCE_NONE, FIELD_STR, 
refname_atom_parser },
	[ATOM_OBJECTTYPE] = { "objecttype", SOURCE_OTHER, FIELD_STR, 
objecttype_atom_parser },
	[ATOM_OBJECTSIZE] = { "objectsize", SOURCE_OTHER, FIELD_ULONG, 
objectsize_atom_parser },
	[ATOM_OBJECTNAME] = { "objectname", SOURCE_OTHER, FIELD_STR, 
oid_atom_parser },
...

As you can see, each mapping relationship points to a parsing function 
(..._parser()). This parsing function is solely responsible for handling 
the state arg, fundamentally resolving the issue of function 
responsibility/naming confusion.

The reason I recommend this approach is because its implementation is 
incredibly clear and concise. To achieve the functionality we desire, 
all we need to do is add the following to the registry:

[ATOM_PATH] = { "path", SOURCE_NONE, FIELD_STR, path_atom_parser }

And the corresponding path_atom_parser().

This approach also offers strong scalability: If one day I decide to add 
a new feature like %(path:commondir,relative) output, all it would take 
is adding a switch statement in the parser() function (along with a few 
other minor tweaks).

*I'm not saying this approach is better than the solution you've 
discussed. I'm simply presenting a possible implementation for 
reference. (´～`)

> Coming to user friendliness
> I believe Junio has already raised an appropriate question.

This isn't a case of “you can't have your cake and eat it too,” right? I 
think user-friendliness can be achieved without compromising 
maintainability, predictability, or high performance in this case.

Regards,

Yuchen
