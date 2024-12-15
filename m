Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833614A099
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260967; cv=none; b=NXDEtJmLgfUo4Wlv/1o1PbQAQNR2mhIOc8aC3jRJwTkL5mNcjcsL7jESrUsO9i4B36FclLQzNu2DHyBWt7VqbJp5Xnxz0MxrzrGZgGtDJEsj0n7VSWEAB6pzanrEOkudrwt+UlbrAP7S1DuWnsZq6iQSwpFivg2Xa1nfisZcrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260967; c=relaxed/simple;
	bh=F/NG1ZPxjTmr/Ob6McP5F/bUq+PnmsYBoJZQ62Ruun8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbziSpClhPznNXtaBZ+D1O/5P6HKnbG22uL9SmcdvV0RnxmduzVGIuktWSR0IL39Xm7OGYLKRpjrRMb/G0+EbQ+z/5+D7hZrolOUKC8L4dyoCUG0IKLATA4KgzZHhZ50RMKV0xb20GGWNPMn6Knp1ECjcr3heDrnynp5zyzZ+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jikOAyPN; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jikOAyPN"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afdf8520c2so902826137.2
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 03:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734260964; x=1734865764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjQ7BhY10nduhdONasNCa5MKzaVLr5aQhtxMydbjjrk=;
        b=jikOAyPNqrwfeb51TbaStCONKhfISNG8MpJUrZGbmty09ppnx1UtfvAOgZRhbMJP2K
         8yFluNDNE+PSiiOwWhj1+ZcuhZeJWGSuqXc2fZxkcdwhtZ6KmHwEEgrW8z15y+Rxf18h
         jYnBngzZ+C+iWU2DdBOIwEx59Aj6tKDFfGv16p0r5vPMY4fMw7zWPMbg1X99xJTt7LB8
         uhyDqO57vkvXIzF+Gw3HVfmMwNgmoejbIwjAE1hWkHWq5JaHSSfjmEdVOQdvuu25Tz+5
         zPN1AFvlEbXYv94PRvyAE2mWJW+4/oR/AqB8GCD+6lfF8ApeuM/D7UocTlTuIKTn+FQM
         ftNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734260964; x=1734865764;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjQ7BhY10nduhdONasNCa5MKzaVLr5aQhtxMydbjjrk=;
        b=Lp0M+xPDZTX/If8ZZLJmGtNSnHSC9Ok2nAouG3AlmL/O6IxFdxdLIJ1V1+bsRFPuSD
         N5cAzT3tcGuyVvY93/UEijOIZOPazxr8nzx6YOAxSIBqBHl/DhUoMlgBvCpmAn8pDppx
         Z+iegkpQFpVVCIkzr0E5zdavN99kD5RRyAdmtFwCv579SQ09mUCEYFZZxzQ+QYB/FUXx
         bVDW6ACt3bAP/EwWQ3uczIzY+x81VeKcG8D7lS1KiiaCSGc+FEyXtKRBtVnDZSny2/0U
         yxB/4rKNGtHhVaq3qfd2IQr6GWuI7YP7RgYdGQlpOTx8HnijHI2YArQD9mQkYSH5INJ8
         Nf/Q==
X-Gm-Message-State: AOJu0YylofpI7o1X1imeyPujVbg7V962hCvX9okqqamdWSciAi57wOY6
	uOqx/ggPE3dqx7nTI7hwgZbjYfm3om7d8hEyoubQphz5Jwm38DJ1STj/QHNjfTG2GfdUnSEERs/
	qbhPQoiR5kYHfUB4ELxbvJF00lXIiNc+G
X-Gm-Gg: ASbGncsyFYaTDuCKI1f0IWHuo4GBhrpkT/Jca6hk00N0MNUbcUPOoCLpjsi9nEowFLj
	ihkAi8IUboQQJa4z5KfkkIb61ua0ko+k1VhOj3JtsO21fssKtsm8yZ1ZgCf8REc4w2Qvg86ii
X-Google-Smtp-Source: AGHT+IH3zrTfNN48l312nXpo06F0cnCmoovv9+82RvwX68jbUAKBTacveeds3LdtlikyzuUVfqh5ciUxKaSFtIGGHDM=
X-Received: by 2002:a05:6102:5e86:b0:4af:ea3b:7b31 with SMTP id
 ada2fe7eead31-4b25dce71bemr9308722137.14.1734260964449; Sun, 15 Dec 2024
 03:09:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Dec 2024 03:09:23 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z1wngv1Kox_QQcwK@pks.im>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-8-f28312cdb6c0@gmail.com> <Z1wngv1Kox_QQcwK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 15 Dec 2024 03:09:23 -0800
Message-ID: <CAOLa=ZQ9SHD3gzTVaznGhkCBjrrJbHm1fDyi1F-h6VZvtdpxgw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] refs: add support for migrating reflogs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000bc04e006294d1818"

--000000000000bc04e006294d1818
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Dec 13, 2024 at 11:36:53AM +0100, Karthik Nayak wrote:
>> diff --git a/refs.c b/refs.c
>> index 9f539369bc94a25594adc3e95847f2fe72f58a08..f19292d50f0003881220e8f7cfcf6c7eb4b2e749 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2708,6 +2710,53 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
>>  	return ret;
>>  }
>>
>> +struct reflog_migration_data {
>> +	unsigned int *index;
>> +	const char *refname;
>> +	struct ref_store *old_refs;
>> +	struct ref_transaction *transaction;
>> +	struct strbuf *errbuf;
>> +};
>> +
>> +static int migrate_one_reflog_entry(struct object_id *old_oid,
>> +				    struct object_id *new_oid,
>> +				    const char *committer,
>> +				    timestamp_t timestamp, int tz,
>> +				    const char *msg, void *cb_data)
>> +{
>> +	struct reflog_migration_data *data = cb_data;
>> +	struct strbuf sb = STRBUF_INIT;
>> +	const char *date;
>> +	int ret;
>> +
>> +	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
>> +	/* committer contains name and email */
>> +	strbuf_addstr(&sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
>> +
>> +	ret = ref_transaction_update_reflog(data->transaction, data->refname,
>> +					    new_oid, old_oid, sb.buf,
>> +					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
>> +					    (*data->index)++, data->errbuf);
>
> This is where we now increment the reflog index to ensure a proper
> ordering.
>
>> +	strbuf_release(&sb);
>> +
>> +	return ret;
>> +}
>
> We're now allocating one buffer per reflog entry. We may want to
> optimize this by having a scratch buffer in `migration_data`, which we
> could then pass on via `reflog_migration_data`.
>

That makes sense, let me do that.

>> @@ -2910,6 +2940,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>>  	if (ret < 0)
>>  		goto done;
>>
>> +	data.reflog_index = 1;
>
> I'm a bit surprised that we initialize the relfog entry here, because
> that means we now have a globally increasing counter across all reflogs.
> Couldn't we initialize the index per reflog instead? It ultimately does
> not really matter, but feels like the more obvious design to me

Yes, this was needed cause I initially didn't understand how the
udpate_index worked and assumed two logs couldn't have the same
update_index. I missed changing it, like you said, it works, but I'll
fix it.

> Also, is there any specific reason why we start at 1 and not 0? Just curious.

Not really, I wanted to distinguish between index entries vs non-indexed
entries. But logically, no, I'll remove it, to remove any confusion.

> Patrick

Thanks

--000000000000bc04e006294d1818
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 87ccc1ede855d91e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kZXVOOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzZhQy80ak1kTkpIZTU2ZEN0NzdjNlRScXpiSGZUdgpKSGRqYmttM3By
ZUFpcllhVTZDb3RnSEZNcmxvejVydkYrM2Q4eXhYeTd4djd2THUzMXRFL2wxaFF6QldhUDBXCkgy
bGhlSmpJK25sZUwvOGx2M2RkZDZldGJkMk5RRVNKcXBTM3lXcTYrc2NtVXhFY1h0T2pLRDFQK3NB
NkhSMlIKSllXMjRTQllPdGFQRzNFN1IzOHZHa2hzRUtuVkxESlZuZUNZZmZyb3gzOUdvSlNWR0FV
N0RqTFdRVmtpZzRHNwpnZU1QQVlCTEpHZ0xPM25lZVFocTZPMjIrMmE3MUJyTmFkV2dFKzRIcWNJ
WHRudHptVzdJbUppVlozWncvZGlyCm1nSEhBbUQ4OTQ5Qk9oREthellRVXdlcUFJTCtIWDdpWndT
eEZRaTVuWEE4UEFaN0JzYnNTM2hYZ3UwVWo3cSsKUFlOZW5YcFlidlY0WjV3NUptenZHdmQ4Nlhv
RkYzcWFKb0Y0NXZnTVUwS284NzZRMlJvSHk3MW5UUTNiQVFxKwozRjREdk1mZFg3SkRRamJRaTdR
K0tmc3kzWkJUWGRtY2tsd3ZqN29BQlRTUjgya1Vwd3BSaUV2YkhxYmJBaVZPCmpvdkdZUWNEcXBI
WFpkdm51eXdOYnQ4Y3NpYTBWczFOY1pnTGZzVT0KPU9vQ3IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bc04e006294d1818--
