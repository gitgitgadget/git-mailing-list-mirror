Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAB3B52FF
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490523; cv=none; b=RGvYf2WdasyKbJHgB97ms3dcffJwpXJhr3EZppXbU+z+OTr3LIi/RiAKW4fJGKvNniyR446hXSyZSKGy+EhMtZ0oC5OdvLlx11olWDmR6OicxcemtqS+K0gzixr+JaUgPn4l9aCYzoaLtP6p7out6ABxaHy2+g4NFu+Vsrzomo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490523; c=relaxed/simple;
	bh=26Y9LCXW1xMsBFBhLUk8x/FI9XNkdHp/KdZKEnc3m/s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmcoOOVuqq1JqikloC1gc/4JwEjPLjk6m0Dt7NRBUpskAUi37oP827I8fT0NMg3CeKXWhfHE7OKnqn47Sddzi4Wk5WiPIxEpjLCuKDGHy5X37xPoxGY0JC7WAMzYUnbA+riya4c7zyUfXskKDF+Quj7vRcB3BHbXqZ7mqFsuvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSkf0Q4P; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSkf0Q4P"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ecddf73062so635335137.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 07:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768490513; x=1769095313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b1Z0c/A3oJno7rPDwDDhtfOBDOFBTHl+PUtHifkjvWE=;
        b=DSkf0Q4PGaQCibH8mYYouLsBkJ+GWICOT44V5SOdbchsYH4dHHG/v3UeDt1V1JQEmf
         7x7vys9uSJHxjsegGan6leqHb+3xy20Q74d+mACflKQKGdS5/kzhaod7gzGAbRjWgVcq
         mg3ceKEFDZl/3YWCoQEuGK/rjrDZQvKSFWllz0IhvYwtyOPuJXXQZLXqWOu2Rn9zglHS
         j056XuLS13MfzG/vLCpmDYm7bMvuihIN3yOvQms5FJbmqjRBMz3FVRTzkVuOAGodjhZz
         gl3PGnwHrri2snOo+bdG5KeUJKdX7zipqN23aX5l5HomB9hin4Y1H0VwCBXx1naSFa2n
         UDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768490513; x=1769095313;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1Z0c/A3oJno7rPDwDDhtfOBDOFBTHl+PUtHifkjvWE=;
        b=mxAdEE24X2SH5SEhwWF9VLwsYuIL2UKche/KLyhNpLOUNgxzpoFMBh/VEaRyiB8Huc
         w+6IygF4cOu7JZKe2NItU6SgAWDppj01PNslC11c/xp8UgS0jYTQdQaIEOcip5f4mQJQ
         O86PdpHubd1rbdG9GIxIPEnk2qjgJaAKU2cYhTLM0CK2jZ2CVZiJFZyHBxQtjNpPLrFK
         UpSTYLxylqjyIXt2bVDcbTcRWydrevj9Lgli3yvKwTnWSmrZ07UC4fIJ4YJEau7kgJLw
         axRIymUmv+IkIvRxNG9iT4J7+y8ism3JdN1HOQVsRqucDhEBrcZsEXg5iwqWXw8gWzOi
         CCMw==
X-Gm-Message-State: AOJu0YzuEsUbuiymt0bzby02ihtsKkP87bpDyffnYkGcnTNVMhA5YpTe
	6jFtI7tcuHPwo7rn4HYQTNJ50ClSdSRif0yrmMlnj+GyNBkk9FOnlvrxqym5olZRsRUWQHxvSJV
	K+WaVLdppqUG4E3/EE+t8pBRX5PQebr/vsg==
X-Gm-Gg: AY/fxX7MCDIRs8e7a4UKFVIiGGo+WwWxA3QUjp6dX9jBr1L/3ffMCB9SEjsQcsgZTKW
	cppsosvvM/oGN0SORl8ttyBjLqPKSBQkkwgZiUQdox448FkDIbSM1F610lUjijY1gEUa8hSefrf
	xkDE8X990uN2a6GKgj7xqPD1fdqWYdknuGkjbFMZRPm9KYWAKhzA7rJurWwUvRjLBdCBBpuOhbB
	R5qmeSPbgoFwc8oK4qNnHKO/b3jA8XF8CRvGugZ4+7lXnWZjFzjXtA5UI8CRsuyQruSug==
X-Received: by 2002:a05:6102:3714:b0:5ee:f96e:dde with SMTP id
 ada2fe7eead31-5f1924c70eemr1621903137.22.1768490513212; Thu, 15 Jan 2026
 07:21:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 07:21:51 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 07:21:51 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260114180306.GI885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-6-f5f8b173c501@gmail.com>
 <20260114180306.GI885771@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 07:21:51 -0800
X-Gm-Features: AZwV_QgQuLnGmUNGzVW-dHjpAy6mdbsCrKP7GNDr02jnghXEeO8APfZWvnb2b-E
Message-ID: <CAOLa=ZSCAJ-XPWK6vg3p7TO=3T3y8CD+VY4jqn41X2wbdmoaMg@mail.gmail.com>
Subject: Re: [PATCH 6/6] receive-pack: utilize rejected ref error details
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, newren@gmail.com
Content-Type: multipart/mixed; boundary="000000000000d43e8c06486ec88f"

--000000000000d43e8c06486ec88f
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Jan 14, 2026 at 04:40:47PM +0100, Karthik Nayak wrote:
>
>> In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19),
>> git-receive-pack(1) switched to using batched reference updates. This also
>> introduced a regression wherein instead of providing detailed error
>> messages for failed referenced updates, the users were provided generic
>> error messages based on the error type.
>>
>> Similar to the previous commit, switch to using detailed error messages
>> if present for failed reference updates to fix this regression.
>>
>> One downside of this is that the messages can be very verbose, for e.g.
>> in the files backend, when trying to write a non-commit object to a
>> branch, you would see:
>>
>>    ! [remote rejected] 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d ->
>>    branch (cannot update ref 'refs/heads/branch': trying to write
>>    non-commit object 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d to branch
>>    'refs/heads/branch')
>>
>> Here the refname is repeated multiple times due to how error messages
>> are propagated and filled over the code stack. This potentially can be
>> cleaned up in a future commit.
>
> If we are going to have a "potentially cleaned up in the future" state,
> I think I would prefer to see just:
>
>   if (details)
> 	rp_error("%s", details);
>
> here. And then it comes over the stderr sideband, but the actual
> status-table gets the same non-verbose message. That's what happened
> in v2.50.0 and earlier. Later if we want to try to cram more details
> into the machine-readable message we can.
>
> -Peff

Fair enough, I think that would be a better approach for now, will
change.

--000000000000d43e8c06486ec88f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8c3787c661b3d70a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1scEJnNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzlJQy85ekRQeC9CajdpU3FNTVRsOHZxR25WY3cwRgphN3B5ZlIvb2tS
NDVIdDRXNFBZODNnOTNHcXhLNStGeS9BOGJZNmdmc1dFclBwVFVIbzBJTDlWSGx4ck96czBUCmtz
bDNkSE1tbVRaTWgxT2V4TjJucVZYMERZcUU1L2FBUzl5dXdnYVUrWnFIdENMbUZ2bFBjb2srVkhy
QWszaHUKem10VnJMZXoveVEyMTBub2x6K0NhRDdBQWt0dDliNGcrblZUY2swUnhudVZmaVZkYXlC
S1oxL0FLSEJTRXNOSQpnSSt1MnZDaFRUZkJXUVdUZE1JR2VrMHdMaXl2YjJ0aFcvcDhGZzQ0c3ZW
d1VyR1JyaFFFWTF1eTIwOTFtS3FSCmNXa1dBd1BMREdrekhOV1lTZ3o5Q3lyUnN0OERqN2J3Y05H
enBXMHN2TWRwdjBqZGlqMVBtNHBGMHA5eXV5dXYKNlM5RzV5OFBpUWRud3JlKzE3RGJjbDRkQzIw
YzVRVlI3aHN5UGk3ZU5aZG56NjhSMnZ0TEFJUmdDNG9RVWR5eAp0VjcrZ0swZDlQNzZULzhLd0FU
U2QrREJiYnJVbk1JaFkyK2lkRStBK1MvSWlCNk4weHRZWWFnT2dwTTFLckpDClRkQkVXZFQ4NDVu
RDhpMlRrNXhhWkhEVEpjckl4cFdLejdvckFabz0KPUY0aXgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d43e8c06486ec88f--
