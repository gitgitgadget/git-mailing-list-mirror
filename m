Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1B29406
	for <git@vger.kernel.org>; Wed, 29 May 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971119; cv=none; b=C1o6Yd9fc+/WN5sOM6pdZtQ1t9WTVZPyiZN64zwPxXEmy2NVb7U+R9gyR1louLxn7q3ttcm5BjB24+i5Nz7NC+ex2Ey3oJqD7gGEfXoqQLxWGRgvnnx4/HFFk5H5YFUBgzUdL+xP+0CV30p2qVzkDJt9Tx/5IY96KkPOsvViZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971119; c=relaxed/simple;
	bh=7U64XbvWHyLExQDJdsaU9FWUCosx5rS7i4dm0I0pUGA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m420gQhE9KNWNRbdm3ZGcSkMVHng1DQyfUmyIP9gag9Hss7Rd7zP/1AKgq/85sDaiSKlcBbqCC8KlZJuQSDsQ6q94ZnEDhI3IcGGLrDw4LMwPWjzjo+vUCKObtBd35cnxpLv+HT0ZepyGEX7VqXt7nJvWQv0DpQln6LX7Og/lis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpVxch1i; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpVxch1i"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95afec7e6so5202991fa.0
        for <git@vger.kernel.org>; Wed, 29 May 2024 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971116; x=1717575916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYZs9dj8CJjPzKAsBwLGX1fm4WQO3KwC3BvQrsHmxds=;
        b=WpVxch1iQ8BlKGEuv3fInaUXRUGlFyitUXI7CylBcf3N933zA+a94i8vpzhTGhNlCU
         jJKY5+9XHV3mfgK706TjX874+kvkvmO4/usN33/ETAEVTop4rs+wSLzZWM6wa36cQBk0
         /C9LKjJpSmhzCFhLlybfvmKs2770E3PVSpHGwWbJZgkEjHRjTHzWm8/4XgonnEhdvt7q
         G/frYyLQF2yOjD3CEZufkbfn52CaE5jWEVEeyz4FFcoXCG3Sfa8AoVKTpnx8ng04IfqH
         JcRTe8+dSq5gBYJ9paar+nLanvQtwDLyQi25A1qIxMtdSILwI8idAjceq0o8XJM5kkrz
         6OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971116; x=1717575916;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYZs9dj8CJjPzKAsBwLGX1fm4WQO3KwC3BvQrsHmxds=;
        b=o6UDR69F1a0vURGpI4khH9jxIDRsdE6zBQNaRNg4vqsOQl+Gqd9FVuLwLBUViqaV5y
         k636bVp03wT3y4BhMkDOnUg5o+D1zlAvyIOXWHrUHwa8XpqOafA8TG/NicrzdZh0aBRc
         616re2yy/t47WIPheGucohRtreHrgqSS9D8euZ4pWInDNjfgVClBvVGk8mLs/CgAyrcU
         sH8ylaVrbWTtYfO6u/woEPPIXmWVVA2tJ+4FeGBkcJ7teqMXnnkdTEgpZz7qSopwrfLO
         KLIIVgm6HTFgTPqq3SGvZyq6XMmcr64j61uvej6hkjipxIyeST0gyE/87xHqkKsDTOUA
         FT4g==
X-Gm-Message-State: AOJu0YwfQhKsm/5N3WJhETwCkEPUrQ6iyvshhVjzTf7HFF6QiKbYeV1F
	+V9h+9FnjVXtwk2PX8KvOecSvCTHYSTrWcLFQppQzgO2MLw7oNbXhWSK+Alpw/s4Plaq10INTOd
	bP0nG3DZL7j9I964C6pCDVMKl5MI=
X-Google-Smtp-Source: AGHT+IGjhk2qXDXQCch6Ai4BmFZT7udPTfYMSRrkvUI2SLQ9K7JneWB5299JCu/3bDTP2N0gkMQA1g45jsYarK5c2Hs=
X-Received: by 2002:a2e:780c:0:b0:2e6:a1c4:4328 with SMTP id
 38308e7fff4ca-2ea4c8960bdmr4153021fa.22.1716971115458; Wed, 29 May 2024
 01:25:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 May 2024 04:25:12 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZlQr11P_C-KyO2DF@tanuki>
References: <cover.1716465556.git.ps@pks.im> <cover.1716541556.git.ps@pks.im>
 <xmqqwmniiqv2.fsf@gitster.g> <ZlQr11P_C-KyO2DF@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 May 2024 04:25:12 -0400
Message-ID: <CAOLa=ZQZ2ap9rgS-u0K9LsoZVfZ5hDPLY1ALZDSnfNmQXx35Bg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Various memory leak fixes
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="0000000000006d4adf0619937dbf"

--0000000000006d4adf0619937dbf
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, May 24, 2024 at 07:10:09PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > this is the second version of my patch series that fixes various memory
>> > leaks in Git. Changes compared to v1:
>> >
>> >   - t4153 and t7006 aren't marked as passing anymore. I thought they
>> >     pass because most of these tests were skipped because of a missing
>> >     TTY prerequisite both on my local machine, but also in our CI.
>> >
>> >   - Add another patch to install the Perl IO:Pty module on Alpine and
>> >     Ubuntu. This fulfills the TTY prerequisite and thus surfaces the
>> >     memory leaks in both of the above tests.
>> >
>> >   - Add another unit test for strvec that exercise replacing a string in
>> >     the strvec with a copy of itself.
>> >
>> >   - A bunch of commit message improvements.
>>
>> Looking very good.  This seems to reveal existing leaks when merged
>> to 'seen'; other topics that are not in 'master' may be introducing
>> these leaks.  I'll see if a trial merge to 'next' is leak-free (in
>> which case I'll merge it down to 'next') or there are other topics
>> in 'next' that are leaking (in which case we'll play by ear---either
>> mark the tests again as non-leak-free, or plug the leak if it seems
>> trivial).
>>
>>  https://github.com/git/git/actions/runs/9231313414/job/25400998823
>>
>> says t1400-update-ref has many "stdin symref-update" things are
>> failing.
>
> Indeed. The following diff fixes the leak:
>
>     diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>     index 7d2a419230..e54be9c429 100644
>     --- a/builtin/update-ref.c
>     +++ b/builtin/update-ref.c
>     @@ -130,6 +130,8 @@ static char *parse_next_arg(const char **next)
>
>         if (arg.len)
>             return strbuf_detach(&arg, NULL);
>     +
>     +	strbuf_release(&arg);
>         return NULL;
>      }
>
>
> Karthik is out of office this week, so you may want to add this as a
> "SQUASH???" commit on top of his topic branch to make "seen" pass.
>

Thanks Patrick. Indeed I'm a bit slow on my responses, since I'm on
vacation, but yeah, I too came about adding this as a fix.

I'll mostly check for all tests and send a new version based on this
series soon.

>> Also
>>
>>  https://github.com/git/git/actions/runs/9231313414/job/25401102951
>>
>> shows that t1460-refs-migrate fails on Windows.
>
> Hm, this one is curious. There are no leak logs at all, and the exit
> code is 139. Might be SIGSEGV, indicating that something else is going
> on here than a memory leak.
>
> I'll investigate.
>
> Patrick

--0000000000006d4adf0619937dbf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9d1fd05b1d3cf31f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aVzVtWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0tEREFDUFo4OVVSQjc3elZpVGtmL3VqQnJ6YzI4egpRVmkzYUwxc2R2
cHdrWU1VMmlVVGlEd0tIL1laRjREa00zdG1DRXBXZEVaQ3A2K05yZng4cnBnZ25ieHhIRXF0ClpK
V3VZVlhtTHlTUUdWUDQ3cmlMUlRRM2psek5kM3gxMDZUTXVBOSt6Wm15YW5obmVOeDFGb2RXZ2kw
bmZJNlYKM1NncTlGTlRBc21NWUtmNlA5djh4cFMyRTk2dDJsc3NDNXc2b3Y0amthczRoU1ZUS0lB
UUtnWmp0VjB1eHJMQwphL3dybVJPWFFHdGcvV0ZPek51RytJQ2gydmNGQk5ndGpJY3NpS0JXZnJ2
anhyOXkyZkhyM1FteVFYWjVnRG1yCnd1ZkpDbXg4Mldqc2ZNMTNRV2RxaXVyN3VpUzZlTjVGclBk
WlVsRWUvamlsdlJROXFiQUR5Qy9rWlhLd0FUd3AKR0pCVFpaVk1LeDh3akhSVWpTODgvYVlubTlu
WUprbFp6WEU2dmtMMnF1a0Erbjc1akVxbURZMjVoSWxONVVKeAp0TGkwalF5N3I5c3htY1llc292
bDNsSjArTXo1OVB3NVhyeXprV2czQVV5eXVIcGlFbjgwcE9kYUxOV0ZQWkQyCmhkdWMvRUpkN1Nt
d0VsaUd5dUhzem5hMWVVMmgrQytseERZUzFvRT0KPUU3Q2sKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006d4adf0619937dbf--
