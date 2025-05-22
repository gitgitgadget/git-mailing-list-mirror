Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDF250BF6
	for <git@vger.kernel.org>; Thu, 22 May 2025 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903821; cv=none; b=MYWB72/poQ5LuuLHclYlVj525Hkchhq8MjzgsdRbP62NHgX0JfK8XzrGqT0fxzUd4YwG5NHGqrNv0zzos5ok/RS0e+zfgkFkpIiiJMCqWwsNcyXS4hzQaZDsnbT5vrUzhEzp5U4BgJxh7k/avRyHFum1H0SRtXlmbTuk2O2Cm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903821; c=relaxed/simple;
	bh=aqFCnEyEMJ7o2MgnUMR5gqTQFkRHeDvk+9snSfsu/o8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzutVgvBBrcf4JkrJbrJnWlACtxSH3/TJElmHh4cN6IIK+M9T+p7ZRkifCRMzTQBOoX/ca3PYOCJgfmzHjFSotOQlUGjQsQ04NgMTV/advi2QNU+bWnJQ3XJV70TSaEE3/Z0VB9Ob3q2mXJPCe+VCZpJmIav/X+RyjwT77W5wWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGyv09ge; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGyv09ge"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4c4ecf86e8bso2561185137.2
        for <git@vger.kernel.org>; Thu, 22 May 2025 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747903819; x=1748508619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8Js0ARfMizDXN3TXXpeF0MNjEpL6sn1OEUih8BanVk=;
        b=hGyv09ge8TGu0JLl/Xd2dPR1eUoDKsF3u/fp6s5IV0yiUYUmNo/OYPk0qOeq4mn1RZ
         oe3mLSBcWIQC94M9datQDpzrjcw+ECqBIwPSvV3B/8maWcwftoTXvWaze1RC9WAO8931
         MOsv95w7/HhZpAk87rtn/Fkrf13ENg8h9wjk4AlU1ktmQ2KBWGJrAkj9ycoVW8O1gm3G
         FklUdQ3agY6T5LPRHOrOI4exaxPh8pEbR9dl+O/rI0iPe5XHM7glOG8LSn7r8toPpRAc
         Tshl1yEuvmoDT+TBOa/zkcp76NKkDvULU64wF5wg1ZG2Ei30wFSex9FV1l9ZLWRj8MIW
         0ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747903819; x=1748508619;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8Js0ARfMizDXN3TXXpeF0MNjEpL6sn1OEUih8BanVk=;
        b=Nw7oKOcKK3Ag4Ku4Sm2Bt2Wq1QJUzBVUe69qBG2dcEjIqFuirvUKs7I4b4fLlY5ewT
         emgtApKQWyCOvA4I+mu/5p1CCHZJEQKzT4/ehHahaBDSeWwComwHlhsBSi3MJ9K2rk8m
         E0L3ExM0kCuiXQnTRrPyA/EtQSVVyZ8bOzRsYuvYEtcYvpRu8HEHkHkyq2WIwSjIsTHB
         hXiSBaRA0EYa70rKxDCBvPpxa6A8zfwidl2MNdfH2/dzMRyaw8vmacK2Y36VI2w/pf51
         kJ169x0LP7UxBXs5YgjNNV+SDHhEs0Egu+M8w5L058Vww5Umer3Pf2k6cQ/LSRmkagaN
         qocQ==
X-Forwarded-Encrypted: i=1; AJvYcCVff7QXxxksWPhB0UsovKC4/fbUR4xobRUkHqpXHa/peukRUYJwCuqNu/7ATVJGNzWxvGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5b6plQ+q0SptB7WJDzemKM0hO0Rsc65Btp8nGKIK+0efLPwIM
	03Xhalx4trHEt2jH4HZpjR6PWn8XXSdqIa1QZBHDJ42C67nr10vmj9nHtt4fGwOEP7Djbgx4Slw
	U4lEHy+fkw4JMMIlHBsQFPR9qsJub3BU=
X-Gm-Gg: ASbGncvwh8oMuxOyVheaBaHfsvPrx2y1fACCXK/vWhhjBCbI6X85vLMQVzi1qnKSeOU
	RqNtNJxfbVSsZ3WCA9nEipUqCizt6Cfqy87+ep75PHUtg7lal7wbFWNw//VNPInCRJ/m+livAnf
	UvQlWU0/Gsv41V7rSXKRIWfZAkT5oOBdIxt5YNn4bYikNkuWSf84BUMiyV64LV0oXWG3o=
X-Google-Smtp-Source: AGHT+IHqUilXhHQvmmwVbhB5TXrj5vDPdzHx3qyIXHUUTU0JOkR+QZHEIe2VgdJ7sQT7ar8el/2FTfkP6NV8R7NkNBw=
X-Received: by 2002:a05:6102:cce:b0:4da:e6e1:c59b with SMTP id
 ada2fe7eead31-4dfa6b94016mr23372280137.13.1747903818929; Thu, 22 May 2025
 01:50:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 May 2025 01:50:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 May 2025 01:50:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250522060044.GB1135327@coredump.intra.peff.net>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
 <xmqqy0usmprh.fsf@gitster.g> <CAOLa=ZTyE9myZqy8UHe=YeZ-diy0Q1UDTBTB3d1XGC09XvshAQ@mail.gmail.com>
 <20250522060044.GB1135327@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 May 2025 01:50:18 -0700
X-Gm-Features: AX0GCFu19cfCE8RhWpxl9Jp-vX5mnyqvMSSArOtT_hq-fsW4XZ_ijhoQTA9qFvU
Message-ID: <CAOLa=ZQhaPXS1y5zkRv2CQ_S5=8+XRg_A1snXHVYXz3uvVgZSg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] fetch/receive: use batched reference updates
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000003ab1aa0635b592a2"

--0000000000003ab1aa0635b592a2
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Tue, May 20, 2025 at 02:05:09AM -0700, Karthik Nayak wrote:
>
>> > Not an issue with this series at all, but one thing I wondered is if
>> > it makes sense to change the type of strmap_get/strmap_put to deal
>> > with "const void *".  That way, it would not be necessary to cast
>> > away the constness like so:
>> >
>> >>     -+	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
>> >>     ++	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
>> >
>> > without harming the other side, namely
>> >
>> >>     @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
>> >>      +		if (reported_error)
>> >>      +			cmd->error_string = reported_error;
>> >>      +		else if (strmap_contains(&failed_refs, cmd->ref_name))
>> >>     -+			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
>> >>     ++			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
>> >
>> > this piece of code.
>> >
>> > It may not make sense, and even if it did, of course, it is totally
>> > outside of this series.
>> >
>> > Thanks.
>>
>> It definitely does, The only other typecast I did find for `strmap_put`
>> was within 'strmap.h'. Nevertheless, I think it makes sense to make that
>> change. strmap shouldn't modify the data provided. Perhaps #leftoverbits.
>
> I'm not sure that is a good idea. Even though strmap does not touch the
> void data pointer itself, it is accessible to the callers, and we do not
> know if they stored const data or not, or how they plan to access it.
>
> If we store a "const void *" pointer and returned that via strmap_get(),
> then there will be callers who need to cast away the constness.
>
> If we store and return a "void *" pointer as we do now, but accept a
> const pointer via strmap_put(), then we're casting away potentially
> important const-ness without the caller even seeing it. I think it's
> safer for the client to do the cast explicitly (since they are the ones
> who know how they plan to use it).
>

But isn't that the case now anyways? We always lose the const-ness since
we only accept a 'void *'. But by only changing 'strmap_put()' to accept
a 'const void *', but storing and returning a 'void *'. We simply modify
the current construct to also say that any data received is not
modified. But I do see your point, we'll have to cast there anyways and
might as well do it on the client side.


> I don't think we can really represent what we want in C's type system.
> But if we wanted a safe(r) interface that didn't involve type-casting,
> we might be able to do something like:
>
>   - the strmap stores an extra flag for "the data pointer is const",
>     which can be set by strmap_init(). (It is tempting to replace
>     strmap_clear()'s free_entries parameter by checking this flag, but
>     the two are not always going to be exactly the same).
>
>   - introduce strmap_get_const() and strmap_put_const() which give and
>     receive const pointers
>
>   - in the const functions, BUG() if the "pointers are const" flag is
>     not set
>
> But it feels gross, and it only gives runtime checking, not
> compile-time. What we really want are generics that can carry the type
> annotation for a particular instantiated map. That is probably pretty
> easy in most modern languages, but not really in C without horrible
> macros. :)
>
> -Peff

Agreed, and then there is additional load to ensure users will use
'strmap_put()' and 'strmap_put_const()' as required and simply not cast
away.

Overall I agree with what you're saying. Thanks for spelling it out.

Karthik

--0000000000003ab1aa0635b592a2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3a36fba5597a890b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ndTVVVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0FNQy80MS94NnJES0JHSXA1VjNVN1JHeGw2VWJBRQp1a3VjeEYxOEtD
M0wxNmRrK2hyci9rNmUyTXd5WUZpZzhEOGpTdUpwTjJjWDl1c0htd0Z4aHB5dmNDU08xaVZGCjQz
VERLc3E0TisvU21vRzlBekg0YzBrNWRWdkJPUWpwUVc4MVR6MkFmUUtpVFFRQmR2dllORUdPanBK
K2JnNDIKMlFiK01meGduc1p1c25Nd3RIeWlRUXJnNGZsK2pZMUd1Nm1UcmMzWFdvQTJkTGVaTVJj
NGNSTXdYMUs3ZElmdwpOOStKYlhFdHQwK1lrM1o2U29LeVQweDAyelBmRy9BVTdVbzRyc2hyYXUv
bU5pQzEzK2djV3RzSm9SbnBCaWdHCjcrTjhxOUdzODFCZzB5dlNpQXV0RHlLWS9qZnRINk5QMk9G
M3lNOEsxMzJrNU01bVlZTkREeUU0eXZuZGR6eWwKcDVMOGtzc09SYWVoUURLRE1rZGlhcSs0NE1i
cWtpMEZlRDdHT0x5SzMrcTUvd1d0QmZoRnlOVUl1T3B2VDhUUQpvUUpsWEk0dm1ic3ZUL3N6a3JD
Sk82MHlqL21QaWk1U01mNGxIdmRlMHZrdDhCVWgySGFFTWhxL3ViQ2l3YUlqCk5wd1paQUkzSGNp
cnVjYy9Udm03RE9aV052cFUwWm5LS2NGcWlpYz0KPXU4NUUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003ab1aa0635b592a2--
