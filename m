Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF274C14
	for <git@vger.kernel.org>; Tue, 13 May 2025 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173939; cv=none; b=btiHw/iKEO0yz7pQs6wub3/IrrBO+8TELz8vf8V4V109NN2b/BMNybvpfnW2UFSGMa9Sh4xwqXfZNeamhkIENCcYO5SmxwJv9sHcAaeCncRG5iqM/v1Nv3ITaMr1iKsDkKYrNPe/REJy1dyfM1QHRw+RhpoupkrBDPr/A852Xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173939; c=relaxed/simple;
	bh=eNbx2ATQvDSk9ZZt6S9qNY1hVu/W1UrSUkksjV3I/rQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GV+ZX26vxpWoNBIq39ypq4n2iismIdV3THyloltlAdei/IOJWKjdeQLd+KumPvCjFrIpPLC1bmHGNZ8oI1J6yGldVKeAib65bqR8zJrR/N0Ma4nX4eVHtTsR5lyW9HNDAV8+ptel40poo73XRggsCZV2njMv26gDyYTTDna8ykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9ZEnCTM; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9ZEnCTM"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5240b014f47so2316778e0c.1
        for <git@vger.kernel.org>; Tue, 13 May 2025 15:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747173936; x=1747778736; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMjIVBhK2HtQ+fGwqlEgoktAC1k2RW0oxgaAoSI7w20=;
        b=c9ZEnCTMNvUWxvh6hBTxUFYbSiyZ+JgLezpUP473HQggmGcgGWL9wTto9jOL8mJYy+
         u73pZAI33YqkI1BPmxjvPseyFg7ZWP6CNIgygaXDCM6EMU2UUTNPGCCxNymjjaEMnQ8s
         RT5DEPLYsWJXFb2QTcrURD9inXaEY+Wy7ATMlKyjJVTE+BrEo6982Tz9uoC4CcIpYjGd
         YxRyxvGUyoFK7Ek3rps2Ceui808Y5DCs3HZsehGBm5mGUNFDx7ZmfvkfYSmQ0aoHWsfc
         UMy6f5irOW5mPcF8iVLlt/6IESMs4wZCGJsmhu8wjgA95fE6ZbvMMvirNaEwph+RX+cJ
         oH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747173936; x=1747778736;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMjIVBhK2HtQ+fGwqlEgoktAC1k2RW0oxgaAoSI7w20=;
        b=fLIz3upo1RufnHkb4lWsibq9a9fa7VlFZBk5VsHAyHtFwsRkoVR+RXXmh326+Zh6Hb
         9cIkvp3hFwOknyTqL7cbdgI5L0IqOHX0vmVUrvhZhTBy6Y/JciL21xixkVB6BZIDS5e9
         q3spGn6qhWWO1UuD5H2t4okaR6y2Q1XlwlotGCUjmFeqjX3BeyWFJOFENeaozn+rlCxN
         6Dlo4SXpaxQ6Ijh69KgACecfvHPV2MEL1hcWLTZ6pRfg93/Xh/z1jXtFKlnqKw0rPZ3k
         DzugpPBPlnYBIVtHRj0DkPUt3iqQ4ik352vFgYHOt+QOsMLwR7fdSPQF21DIzKThs+/s
         j5ng==
X-Gm-Message-State: AOJu0YwDWk8BReAAKLg3CpkiuxO9r8c8GMoQgMSTHMTtmZ1tGECwKEy7
	M2F5nwMtlObeClm44+tgRTHLX7gP20YjA/R35JN6DB7LxSkbn50LWkKzEd0v
X-Gm-Gg: ASbGncsDHyxk9vaKLDK4NaBFJpPjHFo8BOGh2zAgWsSYPD7Fb2UawQWJVpCv4uPhuF+
	3ZThTX2D0gVhsFY+u+aIBsrv6SuPlaM86BqPxTcRk1+G8FC8TgIzlw9Ksz2ioInpm5JBFaf0ZwE
	F1N2ayF1xMtkstxNLId2/+uFyqXH6VhbAJxiXtmeHPJqpIw3VAmDyLzOXqQOkk4nuHyLQhNTjSX
	z6ZDnGhxLBTppHi/NxQqZahcnEqFZHyXp3ZY2MZZprv8w9xcXfyQF4iYWO8uX7+yzPU/fGLZKMJ
	QHN26J7ShsgZm1F2/5gk92wutPPXKuwcVvT6oam/0zH+Y4/T4V+PB3yHIDy7fdvcOMY/MgzveIk
	=
X-Google-Smtp-Source: AGHT+IFxOEvDv5lFfh+a2j3+16aqxTYxXG/psYTzF4i3JBYYSw/owaR4K0ruLAEEvAKVbjlSTkX8Lg==
X-Received: by 2002:a05:6122:2505:b0:52b:789:2d0 with SMTP id 71dfb90a1353d-52d9c5f36a3mr1073219e0c.5.1747173936585;
        Tue, 13 May 2025 15:05:36 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c536fcc07sm8396916e0c.1.2025.05.13.15.05.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2025 15:05:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [GSoC PATCH v2 1/2] json-writer: add docstrings to jw_* functions
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aCG2XkW2lJ1qYHKW@pks.im>
Date: Tue, 13 May 2025 19:05:21 -0300
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 karthik.188@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBE59EF3-4C4D-4FD0-80E7-D9BAF70EFDAB@gmail.com>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
 <20250512020935.73140-2-lucasseikioshiro@gmail.com> <aCG2XkW2lJ1qYHKW@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> I don't think there's a need to add "Mentored-by" trailers to every
> commit just because we happen to be your mentors right now :) If we
> actually helped then sure, makes sense. But to the best of my =
knowledge
> we didn't, so I'd just leave them out for now.

Ok! But given that now both of you are helping me here I think it's
fair to give at least a Helped-by :-)

> void jw_object_begin(struct json_writer *jw, int pretty);
>=20
> I think it would be interesting to learn _when_ to use this function. =
Is
> it mandatory to call it? Can it be nested? Why is there no =
corresponding
> `jw_object_end()`?
>=20
>> void jw_array_begin(struct json_writer *jw, int pretty);
>=20
> Same questions here.

A JSON can be a list or an object, composed by other lists or objects.
Those functions, then, define if the current json_writer will output a
list or an object.

Internal lists and objects are declared with
jw_{array, object}_inline_begin_{array, object}, depending if we want
to begin a list or an object and depending if we want to begin it
inside a list or an object.

In all those cases, there's no need to jw_object_end or jw_array_end.
jw_end covers both.

>> void jw_object_string(struct json_writer *jw, const char *key,
>>      const char *value);
>=20
> What happens when called after `jw_array_begin()`? Same question is =
true
> for all the other `jw_object_*` functions.

It raises a bug: "json-writer: array: not in array

>=20
>> void jw_object_inline_begin_object(struct json_writer *jw, const char =
*key);
>>=20
>> void jw_object_inline_begin_array(struct json_writer *jw, const char =
*key);
>=20
> Do these nest? E.g. can you call `inline_begin_object()` multiple =
times?

They are only tested up to the second nesting level. However, based
on the source code it looks like they should.

json_writer has a stack. The *inline_begin* functions basically append { =
or
[ to the buffer and to the stack.

Perhaps it would be a good idea to include a test for those cases?

> Patrick

Thanks!

