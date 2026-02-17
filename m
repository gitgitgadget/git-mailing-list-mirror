Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1A374191
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354223; cv=pass; b=KYdFh8wS8NFimBoh9wLIGrtfIslsWn8yHExxnJNeb7KC8GkoPf3BHd6lkR0z8vJgxFegCt/bMupu1K8n5CSQwcli5CyAJO5AmDFi89F9egTyun+pqMHvrG6MSePfgLXpVEkncDKxdcuEFclTUfJxE0EO81KVbLBQTDsVrXoqEoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354223; c=relaxed/simple;
	bh=jSyHGq/AoysdJ16ArdCb1CyUdw6WBOK7RT75K5mgLjk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOhb/fb1zZYtuEZ2Wjkb5lgMKDF6nb1xAOhADkmr1j4vCh3k9CAnD/1ZnYtuYjoFgcCGEnec2PweGWLSxXivZMfFcjk9phXpC0ERsc7l/khQm+EPA9wYux8yRWlsbb6NCO/dkhE4Uvu8yjutIcKO3meVKiPPD49m9nBJ5PfO5cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNf4noWt; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNf4noWt"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5fae01e8893so2737078137.3
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 10:50:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771354221; cv=none;
        d=google.com; s=arc-20240605;
        b=Xj/OXfblrDdo1UzTU/8Ofv+Be5++9smkHZXgW19Kpw7FPvOYBZvIL5iwt78+sngXJr
         +cknvyZQs1jtUN+jbepqn3WUWkt207gUvHil9AB2HczgkROs/haXFdB7t5xhFyEpKWuH
         XYGI5aEn0uUn3D8L+oh8CoT4Z5nenSmSXTU01SaQM2jO3TAlK6BJ4giC/NqJh3N8v8mU
         6Ir67bdjHmPpfFK9mu2zTqpGFNQHxEg85o95jTyOiJ7zdOs0i5Q4k6vg5LcChQfZ7uJV
         YUqZEv16xs1Rw9CbnVVR6y5X8ewEZvECKfiBXHGINMrmPssiq8twIE30AR/OuNaoC8VZ
         Ckgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=zTStp94y3A0YTsFQzqdfqRQP5qfxWBLcvleMEWui6eY=;
        fh=YaCBF5sdNYPimzZ5pisSxN0bMhONE61fh1ghe6XkObE=;
        b=MactS9iRtKj0tEkjoB41A9CpF3pza6jK7uMfRIgbf8BS7vw27j5he7mt/y/1T6h+cc
         ro2xD9UHMvAqYwIr8/BrSMShUr27rOemxrNHV6wckjrWMqHTvsD7e4+24Re2JARPQWsm
         NMKXVQyExeU3QUOC/lcaLOMwpHggEPP+6JPnk4d+yiKOZo/fv8j++PtxSe/P2enZ+UOM
         AQWaiJUxarSck89DkmzOfxeDbhZ/uu9T7ZXfvyD+lCWvS8SMmyoIa/ikaXLMs4VOMfzr
         XhcQfcVMApW+hjXnZCIM8JlcP6g1icaQRGVzDz3EvwTSMAdlgXDpGsAHgCS/7GkEjkaL
         CYEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771354221; x=1771959021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zTStp94y3A0YTsFQzqdfqRQP5qfxWBLcvleMEWui6eY=;
        b=JNf4noWtIk154Mxb8bFkSfqKxe3quF6JMaXj76hvOhz943ZjZ0HB0cGdFfoQb3EDiX
         dUvtMgX/dNV1sjZn14Stk3A+7ZHNdsgqEtlXafv34+EXGO2GuYCg7GzNXoVckThoSqeH
         9RrN19UXVV/JLmkOoKAhC34yefClT4DuALciat8oiceR9gVAV1OAsb2rdnFgZM78+0mt
         DzJNzBBQyzw7CTZLOa/aFKmij/I8MQJHhiaCHjnQHZo5TzT/u6bPqKBC/RrOici9xB16
         Zixnx9rVAjlUtOqLM1eMhMyut6Th54sjCSWmMcApLtlQrNTWQ8Sf/BuxfnnuvOD+0/L0
         76AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771354221; x=1771959021;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTStp94y3A0YTsFQzqdfqRQP5qfxWBLcvleMEWui6eY=;
        b=l2+FsK2QkEoB/UGmv8dFbdEZURz20g1C50h8JKEC/BN30EuBfyW5rEBs/sGHUzOqiu
         Ijc8K3VZUEPIl5ovXsKSSM6ynb7NI1KHt3wJrZqjqYIZfA8Dqj80O5ZP3lE8i911MxO5
         Y6YmEKWl/PKdqk4K9Z2tozRRtkRIrpY27DjOlVESXYpn8qEhXvuqvJF2jgw8dGOoza27
         9U296igwdwPwuHqwf0G56Nnv72r86CMoZz9lHBFdmgj9dtX2y2y4doWO/cYvEIh0hJAh
         hMg9qTc34xUfcpBd4Q6PlsEVsUOrGHVJoHQVUM1XqgSBkFdH4B+hBDbOGa5ZxWb/E51r
         ujRg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+Ndlt/Vozt0wm6OWBailv0v1JnjQ93KQwBkt2AkNjVuVmCNe5Lqgfc8o6k+6Uh09m0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIBqhWOoyn2aJCUjFaTfiTLdMiaLt+zkw2vjx5NNz/MUVXQ71
	GKvoSE66QcdFEnkIHNd4clmes/OHhL7UNAlSo4DgzQkwcKIaMYfOAa9Tl8AhucODrHXu8gFuM47
	vGjNDwgK72+43+SmBt1leBYEAK84UFQjKMvqj
X-Gm-Gg: AZuq6aK98HpvFz+FHTwZKcX/ln8CQndUTXuUHvSZMMhJGhgKfuZvMYT1mTTVIWGNHAH
	VEwGaHuMj/UmWmUcxQufIm2OQpZl4wu/7qiXt27G8YE5mx4jnokxNIKTf0R5kO1WK3KQYvwa+W7
	3HgyQia8NdprwrGliDwLMffahgww17+cs1qM+JYU9QtIJYe5vUdkGBmwqeN3E9cekhQz3Fw0B19
	YqGec3UD8HEc0yYlIvL5KjTvA5O3L2j6XzV94AcZaGhP6DRgiT0aPdJoPkCTIFjcPgFZgsFx9Fe
	zO7KH/YBn1/HUYkn/eSsGThC6/KQ3OiIqvwzN7lVZA==
X-Received: by 2002:a05:6102:508f:b0:5fd:f64a:8d73 with SMTP id
 ada2fe7eead31-5fe1ace24c9mr5854261137.18.1771354221258; Tue, 17 Feb 2026
 10:50:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 12:50:20 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 12:50:20 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv7fvcnj5.fsf@gitster.g>
References: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com>
 <20260217084124.150366-1-a3205153416@gmail.com> <CAOLa=ZTeTWhb0Yc8rPEv8vONTHtSg3bSvW6FBC-AWrZzi12oCA@mail.gmail.com>
 <xmqqv7fvcnj5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 12:50:20 -0600
X-Gm-Features: AaiRm517Yko5k-RuJ9wPw3_X8Pzq3b3M9jjLWL1RVojL-aO9_vNcOf1C8K0q9V8
Message-ID: <CAOLa=ZQ8i0pUAbF8NGidR=6jVLJuiYdUWu=ZLDrJMek005D9bA@mail.gmail.com>
Subject: Re: [PATCH v4] setup: allow cwd/.git to be a symlink to a directory
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000214585064b098b7c"

--000000000000214585064b098b7c
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> @@ -994,7 +1000,9 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>>>  cleanup_return:
>>>  	if (return_error_code)
>>>  		*return_error_code = error_code;
>>> -	else if (error_code)
>>> +	else if (error_code &&
>>> +		error_code != READ_GITFILE_ERR_STAT_ENOENT &&
>>> +		error_code != READ_GITFILE_ERR_IS_A_DIR)
>>>  		read_gitfile_error_die(error_code, path, dir);
>>>
>>
>> I understand the exclusion here (they are non-fatal flows), but wouldn't
>> it more make sense to add these two exclusions within
>> `read_gitfile_error_die()` which already has two such exclusions? By
>> separating this out, it gets really confusing.
>
> Absolutely.  The point of this change, IIUC, is that these two
> existing exclusions were too broad.  stat() can fail for many
> reasons, but because we did not differenciate ENOENT (which we *are*
> happy to see and do not want to consider an error) from all other
> error cases (which we may have been better off if we diagnosed them
> as error), we pretended both ENOENT and all other stat() failures
> were happy case and "case ERR_STAT_FAILED:" covered both.

Yeah, so this is the situation before the patch, and I'm in agreement.

> To fix
> this, the patch splits stat() failures into two, ERR_STAT_ENOENT is
> the happy case we should have been returning without dying from
> read_gitfile_error_die(), and ERR_STAT_FAILED is the rest that we
> should have been dying there but in order to return from there
> without dying when we got ENOENT, we were not dying there.  Now we
> have a separate ERR_STAT_ENOENT, read_gitfile_error_die() can (and
> should) die when we see ERR_STAT_FAILED, and it can (and should)
> return to us when we see ERR_STAT_ENOENT as a happy case.

Okay, this is what I was expecting too, historically
`read_gitfile_error_die()` treated ERR_STAT_FAILED as the non-fatal path
which made sense. But now that we have ERR_STAT_ENOENT. It should treat
the latter as the non-fatal path and the former as an actual issue.

> The story
> is exactly the same between ERR_NOT_A_FILE (which had been non-error
> only because we wanted to treat a directory as OK, but we can make
> it an error) and ERR_IS_A DIR (which is new, and is an OK case).
>

Yup makes sense.

> The above exception on the caller's side you quoted is a complete
> opposite from that line of reasoning, and that is why it is
> confusing.
>
> If there are other callers of read_gitfile_error_die() and different
> semantics, such a "now we die on every possible errors" may also be
> a valid position to take, *but* then it does not make sense unless
> this patch makes read_gitfile_error_die() to die on ERR_STAT_FAILED
> and ERR_NOT_A_FILE.

Exactly! Thanks for clearing it out.

Karthik

--000000000000214585064b098b7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a022739dee1ed068_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVXVHb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUJ3Qy80Mnl2ZlFHYVVqWmQ3cDZrZXpCa2praHV2TwozcURsa25XY0xy
QitQVWlEd3lCTjM0TFczdTZMT081Sy91eDZqaE1PZ29ESEMyNDlwd3QzSEo1cVhoMUZQWjZyCnRq
eXFxSUFjbVBjSEJoSjhaT0R3MDc4SVBOd3BybThpY0sydTNlVXRGdlJNb0REb1FHNEc2Z0I2T3NM
eTJOUVUKbGp6NndyenBmeHo2VjdJamVWM2tJcC9ZVzMzVEdNdnliWEl0bWFsNjB2NXZ6MEFVbG05
S2RyNVZycGt4NmtYWgpNejlVM1F3UkVqT2grREI5TTBlYTNRaGg3RVgwbjF1M1EyR3orMGJtMHVt
VTQ2NnhwWktqNUFhaHpWK0JReVQrCkZXTFlTVmFYZFFkWlZtaU9ncUg2aFFhaWQ1VW5JUTRkWDZn
c2paV1ZvMlhkVG5tWTFPSUJKYzlDcnhkaTVHcU4Ka0czVWZhUFArVnExS2YzemN1c2RNUXR0NjNv
c0ZxSUhsVjhZejFyTzhPWUVETUxETWZKYVVzbWdKY2p1TmNTWAphaGNMQmRjZkNYREdMaWdxcko5
UDhHeXNzTHBPWUxWcmRLeWF5aWQ1dmVkQXNObm1rWmpSQkZ4ZlA0UzhPMGgxCjRwd2hDbWw5a3Vw
MkE5bkZRNHluUnd4d3ZQa0t6YWZwQitNQzU4UT0KPUhmOGoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000214585064b098b7c--
