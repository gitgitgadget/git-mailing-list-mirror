Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990B2F9985
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714920; cv=none; b=TPF5QtA5bNhs4RCg6a38IZ2ZQIKZb6ZNOpJYJwsU8FwlQjtcLq5Xd6JQRW4cSfI6v06K/kpbahEBkSDYUTrlJz5WMu5iJQCNHNQmCmRjyIJAifC7FVHY6fV5wkpnolTRMtqViGhoA9lKW7x1n6qA4iyi3sYNjIkqr4DayeRaE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714920; c=relaxed/simple;
	bh=SclWWQev7dM/o1YRcCkLZi+DsA94FAPjZok8V/ctbao=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/5IIVqtimSSyqB0aRsZoXBfkmY14r2Z1cWyuO0vAnw38xBNbGDq2RhX7781GCn7H39/mWBZgPyAB3wF6eU6M7vpAHpgsI1/4I1Jd+2ELDhnhJyxc4rh97YykfTUxS7NvNK1KGR2LD4FmJz7geixjTffTj+TkM+H5iQU6QyZ42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/eh0XCy; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/eh0XCy"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dbdb139b5bso5199685137.2
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 14:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764714918; x=1765319718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pg/J390ZtXV4cqvJzKO1aBFPwQmjeRMY1jefOUMaKWs=;
        b=f/eh0XCyw4mzYpi0wifxqZpNC9N+SiUGIBdIpBS95J7PYd152Q43UNrsbG2S0hbR5G
         HP2urJiItpxoMjUhMHuqjIXZ8pt6tnlPdx+0QR30wwnykZrurGDfdFFpxsQ6Hbkme4UI
         MY9+z+WYLKZ2wzzUx3iLzwnR69k1sFsdHu9a3qUQmN7bDsyR5oYUsoXrO/JcVPW62wWw
         JsrCAHc+Uf1TDNBWVIngcLGQpgx+GBSbI9a+cye/nsOqPIbI+edPyTjX8nEQIafQIMrn
         bXUGNVTGP98O6JyfrrwWQuG8ypigamy47uyOrh95pJV4OZje4oK7Meqy3n9RsBHIIQia
         P8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714918; x=1765319718;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pg/J390ZtXV4cqvJzKO1aBFPwQmjeRMY1jefOUMaKWs=;
        b=F3ufDkzS2AcgwQ2KpqK8jMf4wcrOiQ2avNRlmlUytC38zhdrNGYr8JjIXDAR5rqlty
         W+d9FMhlD1/jwzDiyTCDzs6UWp5cYb9WI/uE9MVtl0qYK9MuyCv2EcWkJWtpbY+JytZl
         k9JoRvr5hRYF7D7nLLa5uxFlCdvyqIXX0xAR/CV7ySNbaCbTS+aAewYLwuvE4zKazWj0
         PIODs9AOiUbUSwR9BeXII6RG4PuzyYaveLTbMWXknmbqCyLC3A2o7ymhPGyAEzbDNHRy
         fQs0NvHrjmkZgLOE4koS4OqKA2Thyrf6e4p+NnMtvTgoBXB61BSYFqVxz8n7Ja7QfdsE
         DBtA==
X-Gm-Message-State: AOJu0YwQEfn5Rg6mGTZorv1BO6FJL6CJZsMahWOF1FtHhlCQNvhIxkLw
	gcTeWNyGf69FL7i0hUr2Y4JkjE+Eh3ajZCtIxIgpgZMNPG+D1ebyqTk04M94i9B4aaQmQhw30d8
	8kvvXJp948bVSJl/TKaYPwd9V+8gaxY0=
X-Gm-Gg: ASbGncvKeJMlLqq1t6Kx20adn4o1JzsSo+Z397Bk1r/B1z3s3XDjvp+8+qdIFkSLnFd
	LLPdIKF9Iy45wSit+Mcv3rFRZPxEGlev2FbZQdBwJvd6dxnUOuNpNK6N/K/2hoWN7jHdZYF9cy9
	JYeM8mgaA/1+I86kNpK6ykl4IXzoDejOBwr1r6ewHHdprNUjVK/HVNWfLiGig4Y0etFZptmYqMC
	XuiSeISm3RPhaLyTq75zwrDlGb8DH8ZcAfyAdMXDOxAKmIQFSOn+kddztZxQoMCbKtTmnlnoNY9
	VHaOWsCqKVB9hSVJTBISIXW7HsfT
X-Google-Smtp-Source: AGHT+IFoPG5RpkT30x00m+VDjn9Yu6hJiqLXYC6uafiWsC2ZZSpbhrzjsm8Z8rwtkYk0hqkofqc/w76kwKtMhE4HjCQ=
X-Received: by 2002:a05:6102:c13:b0:5db:fce3:af72 with SMTP id
 ada2fe7eead31-5e48e2545ccmr51807137.11.1764714918124; Tue, 02 Dec 2025
 14:35:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Dec 2025 14:35:16 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Dec 2025 14:35:16 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aS2Q6y_hnwBxycGk@pks.im>
References: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
 <20251121-fix-tags-not-fetching-v8-3-23b53a8a8334@gmail.com> <aS2Q6y_hnwBxycGk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Dec 2025 14:35:16 -0800
X-Gm-Features: AWmQ_blRWBtnlFTPmsDz9q4RwIf9QAr8qx5RD767top6d5Q4DlylpsuiuJ9oOIo
Message-ID: <CAOLa=ZTdfkK0ty2YQfE+GTtgYZ7wrOW_04Ony8tN+x2oqoXSCg@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] fetch: fix failed batched updates skipping operations
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com, 
	sunshine@sunshineco.com
Content-Type: multipart/mixed; boundary="000000000000d33e950644ffb566"

--000000000000d33e950644ffb566
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 4b113d7c27..a1ca4e1ac7 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -1639,6 +1639,94 @@ test_expect_success "backfill tags when providing a refspec" '
>>  	test_cmp expect actual
>>  '
>>
>> +test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
>> +	test_when_finished rm -rf base repo &&
>> +
>> +	git init base &&
>> +	(
>> +		cd base &&
>> +		test_commit "updated" &&
>> +
>> +		git update-ref refs/heads/foo @ &&
>> +		git update-ref refs/heads/branch @
>> +	) &&
>> +
>> +	git init --bare repo &&
>> +	(
>> +		cd repo &&
>> +		rm -f FETCH_HEAD &&
>> +		git remote add origin ../base &&
>> +		>refs/heads/foo.lock &&
>
> Hm. Is this compatible with all supported systems? We typically write
> this as:
>
>     : >refs/heads/foo.lock
>
> But I have to acknowledge that I only do this because some people that
> are more knowledgeable than I am know that we need this.
>
> Other than that I'm happy with the current state of this patch series.
> If the above turns out to be a non-issue I think it should be ready for
> 'next'.
>

I didn't know about this. The CI didn't complain about this too.

A quick search through our repo shows

$ rg --stats '^\s*>[\w/.-]+' t/
...
969 matches
969 matched lines
285 files contained matches
...

$ rg --stats '^\s*:\s*>[\w/.-]+' t/
...
188 matches
188 matched lines
58 files contained matches
...

So seems like we use both, meaning, this should be okay?

> Thanks!
>
> Patrick

Thanks for the review.

Since the other comment was a nit. I will hold off on sending a new version :)

--000000000000d33e950644ffb566
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aabcec9c7cdebc87_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rdmFhSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkVlQy8wVG1lUHlRd0VKNFFIWFVhWUJRdzdhN1I3Vgp2RlBxVGxlWDZl
Ykh6ODJjUUY1VG9rdHNMZXk4bnRPZVhyNEpxajFyejZWUlduMkl6ZDBuLzFvQVlZQUJTRk4zCklq
Q3daVEovVFFQVnhTYnVadkU2Vm9aaWRTeWZVM3Q1Lzc2bm1UT2x2NUNLdEJ3Ulp0T29Pd1Rad0N2
SjdSRkcKaGkvcnRVOVJFL2xLNG1jTTJiNnQzUE9ud3I4L0dTdmQ1R216S1JvUk1IeHdZS3YxMUdE
N1RrOEVjSVRhbnNVeQpBK3UvZFdvVTEwQllOS0IyRW1kTzNQQzNaWXdHTG5IMUZmcmthcGVGaVpC
WnY1VXc1SlBnbUhTSExnOW82QlpiCnlxMlV3VUNjQnMrT29oNDEvTzk2Ulg0Rk8vZ0l0QTAvME4r
aFlOdjVrazhHbndacVQwdGNWZ1VINHBpaWZtSmQKVS9vdVBSOXUvSHRwWi9JMjJoMytKNWRKVHUw
MGpGYkk1N2JJcEJtR0RhU1h5bmFvVVFPczNyV3FqSHdBV3dOagovR2dzTTZxTmNBZEtLbGRNbDJm
anpQbzhxWlV2MURCRkZPRHlHQzVlWWZ3TU9xSlRqRVJWVmdxUFcrR3V3bzRJCjMxUmVWVFNXNkNq
SXRtc1c2cEhXWHVmeGoxdkZ0emxrQjFuVDNpRT0KPWl0QjUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d33e950644ffb566--
