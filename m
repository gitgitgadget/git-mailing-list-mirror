Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD37A13A
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726594291; cv=none; b=YFmPaHng1+0UBQTkYS0mhZ+fYGTFGMmKXM2Q4miE7Vc39NM0eT87kceSPrZYKeVb92gj9VhECwbWL5rR8lfAljQxLtlrIfT6waNjrT3GuaGy5Bl9PCR4hhyMQvu46Q3/Qpq4kXZchQdRMuLqGvD1NgptbN6VtZ/57w/MxPm+BPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726594291; c=relaxed/simple;
	bh=gVrkHA17wh3rtnkiA+gNevyQmL6ZDv8XloivLOvdB1U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLd2xYzIA3ArYdMQrCAmkDdGOk3f60mjRXHLpx7+///27gahI2eOclEYT7QYDD8rIDtFZLPEjv33VSW5//t3ArUTuAYmj5c2zhkaAhlzi0q+3W/xzjLIUhDJV223KPJmUWyK7QXvJpFU732LjUP1fQmEmjSBxty8dTNIjeDjkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ftt7/mWq; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ftt7/mWq"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-49bc44e51bcso1359468137.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726594289; x=1727199089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vy9swWx0C412mUxwdzSxti0UfGG5Sv5u2XVzZfnip4w=;
        b=Ftt7/mWqT/cL5oEtxtp2SSjOnFotxVlex3a67V+FkZGO4i6lxLtBDmxmAcvIe0AWl3
         z09Z0yIDalNmqmo6l3Jmd0nRljLN/3qL8+kbr43TM0I/Lfy0/IKkvcN+RooF/vmbKz6s
         s4EboJak0k9u7u6vSLEiA91XlRMvoDSkYoyrj7JdcI1FwYS1TfE8QoKadyDJ/r8rkjIG
         Ylug8MqT+WZipWXeEYqMKcEd8oEK6U6h9bBO/cR8/3nL9COFzoUXL/jD7ysMK7uF9WUb
         L8vDaUKXvNL8yopnZLYPAxsZODerYDFxY8sNpmuVykmsRhs8z2L7G0hog+Djt/qEOieO
         oP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726594289; x=1727199089;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vy9swWx0C412mUxwdzSxti0UfGG5Sv5u2XVzZfnip4w=;
        b=Os+b7SIqCpk/EwfjPNWcN8NdPnhOYAN8KF8FBGek+tzXlokt+4ArxlueqoKtq32J6V
         wwrKu1IyIz3jTxWAYvPdJMoH4405VKjtifvyqwRDU5lu3Zqxyp7O0BTpFvb6BQ5C2tCb
         7vLUo3BoDjRWq9004nwbfmZOwb9LQat2PZfFXvNYF0iFNgKn71MiVWeOH9VnbLirX4DZ
         7+J5MX7QtIpNy5+rzYeHm7CUebQOgN7y3cc0ETYoyS+BAvFHXR64Fd+g8M7cYw/ChFE9
         fyIEa/F7n9b94ZhVL0tx1SP1cW8fsJ1i6dW8e16Wj7XLov7yAdVdt5xb0j6HkBO4G81h
         hh0w==
X-Gm-Message-State: AOJu0YzYNXIgSuZyqVmZ+tddQwu6pduMad5jsIxWYzL61cAKj5GTJ+wF
	72VqdmFFxVlTpIaWCNz+L0mSCWrVFJEsFY7Nb3wNXwWUSdz54nqi50HL5up6O1MrICQ8k2fSDxn
	6WSSIp0gN5B0tJkhaeaFPPPChZ38rfqUXepU=
X-Google-Smtp-Source: AGHT+IFDqSXYUmvOCQ54cv46gPzLq0bxhfj+OksPDJVZuLxfVFfcwfgdA+ksv/0Jz9wW3iQ3bJua18ely48BWdBUZwM=
X-Received: by 2002:a05:6102:32c7:b0:492:aaae:835d with SMTP id
 ada2fe7eead31-49d4f462f96mr12912108137.0.1726594289040; Tue, 17 Sep 2024
 10:31:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Sep 2024 10:31:27 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZufWkLwn0RQeCCpD@pks.im>
References: <cover.1725881266.git.ps@pks.im> <f3922b81db69cd3bbdddcfbe02c99613448fd9ed.1725881266.git.ps@pks.im>
 <CAOLa=ZQikyvJCRZ=mCfve+VWZfrvPL1bg55txB1q0Nh3SW_JJQ@mail.gmail.com> <ZufWkLwn0RQeCCpD@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:31:27 -0700
Message-ID: <CAOLa=ZS2dOOGauZa-yBtE7S_Ex8L8kNV=CAh4mQfZdhmjCUnbw@mail.gmail.com>
Subject: Re: [PATCH 6/6] refs/reftable: wire up support for exclude patterns
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000452d3d0622540f3e"

--000000000000452d3d0622540f3e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Sep 13, 2024 at 07:47:06AM -0500, karthik nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > +/*
>> > + * Handle exclude patterns. Returns either `1`, which tells the caller that the
>> > + * current reference shall not be shown. Or `0`, which indicates that it should
>> > + * be shown.
>> > + */
>> > +static int should_exclude_current_ref(struct reftable_ref_iterator *iter)
>> > +{
>> > +	while (iter->exclude_patterns[iter->exclude_patterns_index]) {
>> > +		const char *pattern = iter->exclude_patterns[iter->exclude_patterns_index];
>> > +		char *ref_after_pattern;
>> > +		int cmp;
>> > +
>> > +		/*
>> > +		 * Lazily cache the pattern length so that we don't have to
>> > +		 * recompute it every time this function is called.
>> > +		 */
>> > +		if (!iter->exclude_patterns_strlen)
>> > +			iter->exclude_patterns_strlen = strlen(pattern);
>> > +
>> > +		/*
>> > +		 * When the reference name is lexicographically bigger than the
>> > +		 * current exclude pattern we know that it won't ever match any
>> > +		 * of the following references, either. We thus advance to the
>> > +		 * next pattern and re-check whether it matches.
>>
>> So this means that the exclude patterns were lexicographically sorted.
>> Otherwise this would work.
>
> Indeed. Good that you call out my assumption, as I in fact didn't verify
> that it holds, and in fact it doesn't. It's not a correctness issue if
> it doesn't hold, because it would simply mean that we don't skip over
> some references where we really could. But it certainly is a perfomance
> issue.
>
> Will fix and add a test for it.
>
>> > +		 * Note that the seeked-to reference may also be excluded. This
>> > +		 * is not handled here though, but the caller is expected to
>> > +		 * loop and re-verify the next reference for us.
>> > +		 */
>>
>> The seeked-to reference here being the one with 0xff. We could get rid
>> of this by doing something like this:
>>
>>     int last_char_idx = iter->exclude_patterns_strlen - 1
>>     ref_after_pattern = xstrfmt("%s", pattern);
>>     ref_after_pattern[last_char_idx] = ref_after_pattern[last_char_idx] + 1;
>>
>> instead no?
>
> Sorry, I don't quite follow what you mean with "get rid of this". What
> exactly is "this"? Do you mean the re-looping?
>
> If so then the above doesn't fix it, no. We'd have to repeat a whole lot
> of code here to also retrieve the next entry, store it into `iter->ref`,
> check whether it is an actual ref starting with "refs/" and so on.
> Looping once very much feels like the better thing to do.
>

I definitely responded to the wrong chunk of your comment. I meant to
respond to

> * This is done by appending the highest possible character to
> * the pattern. Consequently, all references that have the
> * pattern as prefix and whose suffix starts with anything in
> * the range [0x00, 0xfe] are skipped. And given that 0xff is a
> * non-printable character that shouldn't ever be in a ref name,
> * we'd not yield any such record, either.

My point being, we can even skip "pattern + 0xff" by just setting the
seek to ref to be the next character in the pattern. But since "pattern
+ 0xff" is anyways not an expected ref. They should behave the same.

>> > @@ -580,9 +660,45 @@ static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
>> >  	.abort = reftable_ref_iterator_abort
>> >  };
>> >
>> > +static char **filter_exclude_patterns(const char **exclude_patterns)
>> > +{
>> > +	size_t filtered_size = 0, filtered_alloc = 0;
>> > +	char **filtered = NULL;
>> > +
>> > +	if (!exclude_patterns)
>> > +		return NULL;
>> > +
>> > +	for (size_t i = 0; ; i++) {
>> > +		const char *exclude_pattern = exclude_patterns[i];
>> > +		int has_glob = 0;
>> > +
>> > +		if (!exclude_pattern)
>> > +			break;
>> > +
>> > +		for (const char *p = exclude_pattern; *p; p++) {
>> > +			has_glob = is_glob_special(*p);
>> > +			if (has_glob)
>> > +				break;
>> > +		}
>>
>> Why do we need to filter excludes here? Don't the callee's already do
>> something like this?
>
> No, it doesn't. The code for exclude patterns is structured in such a
> way that the responsibility is with the backend to decide what it can
> and cannot filter. In theory there could be a backend that can exclude
> refs based on globs efficiently, even though neither the "files" nor the
> "reftable" backend can.

Thanks for the explanataion.

--000000000000452d3d0622540f3e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bcb5a22bf8496ae6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1icHZPd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOW5yQy85cjFWb1hGdmx0K09vQjAxUFFNNktSdEVYeQp6cDNvblhpOHZL
Q0ZNVFJuTlFRR1V2OXovTWRraXp3Y3ZKUVUxVmo0SUlxL2ljY0Y2cVRsT0hsV2RlbTBIR2NLCmQ0
VUNUWXhaemZFV1U0aWk1SUx0ZC82ZVpJaldVZTNKQVgrTmZJL0lxNE9CNjF0TG9LRnBnWmx0M002
MUNYZnUKNWYwdGNuTEh2ZVhNOU5vc0hmT1A2TEVwdXA5M0FKVzhjMU5mZTllOEF1eEtmKzFkcU1I
L0ZGUVdlT2tCSFlWZgp1WjVMTjh0bDR1SGZyRGdDSnRFYmpNOXRsRFJ0WlJMTTBURXRtYnkzOEYv
eC9OZEx5WWx0a3Znb1BJTm54Tnh3CkVaMkVBNklTTURzeG9XeXhxb0VFVFJnUndIRmJveUVIUUEw
eUdMY0FVRTc2TlBBamhEVXJzeHp1RURNUi90MzMKT2hxSGdwZG5EWUxXTVBBM3g2SGdYTjVNdUNK
ZGpIZUloS3VuRjVTRU14NThDbWZ0aWpjZ2Vid1ZqcHhuYnFJVwpReXc0NXI2M2VuYWJ2ZXFaTkRC
RlZqSjIwYm1ja0NtclhLeGdIMWZTaVI5UWhqT1NCVndJZkFLRG10cVlDMFNIClN4cUk4dWRtdk5s
cS9CSnQrK0dHMzM2bnNZeWtPQlRUUFVKa2MyWT0KPUdnSncKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000452d3d0622540f3e--
