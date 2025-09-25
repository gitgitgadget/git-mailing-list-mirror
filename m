Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8206270578
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788419; cv=none; b=aiUcIOy5hBxTziHwTeEJlX5elWPtd1HpamSubikQWoR15VvPTFDDp+pRIkT5cD4TJTjL8EH95gWqL0Dt1EXayL35BHHLthmhHEn/omY7ABd41m5n9jZOMaSWWjY8uFfHzkXlw0K/nddSJy0/ameIq135FtNggJUdZf75TI+BwyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788419; c=relaxed/simple;
	bh=kI7avvne8rCck7qDC45zlKY9zF++SVm7Byj8dufvytQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJu/QfjrwNSRCsxfXnjbteTC8pCIRjjD/HqfLA5FT26XG1InhHpkRxMJvLuuxqfej2DZq3UpYPQR2SIBL+1UG2F1NiAY3BJ8Re3egEaSjfuaumFd4NJtwJlOlaZH/De5WwDPdw6xoKv8dpPY+9HuK5UdWUmatrPz4YsDWxh1C5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKfde+8V; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKfde+8V"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-51d14932f27so374711137.2
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758788415; x=1759393215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWlS0o+3GRVl9HHSCSOe9aD2ZfpdyTKLGFyiLyJ+Htw=;
        b=IKfde+8VL7O35Vlort6Le2CJ1tVGpsQQzFJBKDeIzM0rYzM8gtiDwdKgsDCy+PltOi
         YY4uc5MVQK8C/9q4fEi0/4cHe0YidpO1Fht1cWTChnz9aKS1+MYTw37JlmjLDGNuH5sf
         j6tV0HlvEwfqMiXdQBPb9zewm14xZ1ujfj29TIfKXOjwY1NrYPyZe755TSexiW+8pgvo
         Ww2pcPtlYwoQkly2YffziEwDUQZYNMZzNl3vhHS/ieo76zJ1w6ekqMrWZ6n6grpVnQ6I
         8O9UFqLhhJ3p7TF6lJFp3L4XilsubX05cbjV9OV4Mq5ed0bDKZcnq73gkO1b2Wfy38P+
         Bxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788415; x=1759393215;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWlS0o+3GRVl9HHSCSOe9aD2ZfpdyTKLGFyiLyJ+Htw=;
        b=VCqwnuCUGA/irTbN6j2+2gTjtSSqlzfW1nEKQ9hLGYq3Ps1xjFkPoIGFKv/UDwP3Tr
         LFL+64G7PgJtBMk2AOmwXwWPr1c4wZjdewWOxzexc6v52NkQ+6KbBDAGRqIkWTf9zi2t
         A8opXu5Jq9Io83QRfg1wxz/upzJ/4jLBn5vO2xBPLa7g89rtBU4GkBRzOKOqmgKoorjb
         8kWfznj0meO5Abscwr3t5s0NMLxUXaiCJO12s4yRIx2tfRLGpuWJ4Q5VyLTVZV4sle1I
         dQIbdgRPLPwpZUaW1be1m/YBjlhsEB+LdZC2EOqlSPuJoms3SBHV/tKXrVAZxCn4jhFZ
         +7Fg==
X-Gm-Message-State: AOJu0YwH5R8P+OEr44VYbuhoxOEgqyI9D5hQb/H4itI86YT+WcRBSQGe
	99+aAjzileyT751RV0EPnIp2pW+DeTW+g0g3oY1hTxtp14hxm5LWKX1r4VNWQvT00A78YpCHfSp
	7POE9/7Zf3lSs1EBFxW3DAKt9RObVVYSD0Oyb
X-Gm-Gg: ASbGnct93jRNh2OT0Bbtk79Y5JOVbleCH61MpoH4CC12uPsejyxbpytGRAm+6G6Bgqg
	tWMdACW8uJhEioNZWDfmZGfUX3hdHWoFhAm0N3nqjFUWeEt1aR59yoCQLgiKOA6DjKdj+Bi8Hol
	A1lz93+blb/vaJCr440DkB/+Fj6tWS+ja2XT8KUF08oeMAaUq4geE5apYdkD9iN8ZrQmtng91QE
	HUa7TY7PrsG31SBNahzj+cGwAC2GVXcuDZg8IG1fg==
X-Google-Smtp-Source: AGHT+IE+IKHoPWsixHExVhjzPDwEH+SRVFzA5HMDw0Ph5Ld3160esAS1EhUDKFSPUuQoliEhRDdspNWbNB12opoA5Ck=
X-Received: by 2002:a05:6102:390d:b0:59b:ecd8:c0d6 with SMTP id
 ada2fe7eead31-5acc62383b7mr939355137.9.1758788414564; Thu, 25 Sep 2025
 01:20:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Sep 2025 01:20:11 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Sep 2025 01:20:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aNPkA9UZtEqHsa3f@pks.im>
References: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
 <aNPkA9UZtEqHsa3f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Sep 2025 01:20:11 -0700
X-Gm-Features: AS18NWBzZJJJOm_Rro72GxAG2kdiNC_W1H7D9Azm5srU0CQnlDayEW4dGsJDMWc
Message-ID: <CAOLa=ZS=y5Q-_BH+q2xhzh6mpg2oQJptv1rp_T0jdqH-jBf0+g@mail.gmail.com>
Subject: Re: [PATCH] refs/ref-cache: stop seeking into empty directories
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000afa3de063f9bd630"

--000000000000afa3de063f9bd630
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Sep 24, 2025 at 09:55:51AM +0200, Karthik Nayak wrote:
>> The 'cache_ref_iterator_seek()' function is used to seek the
>> `ref_iterator` to the desired reference in the ref-cache mechanism. We
>> use the seeking functionality to implement the '--start-after' flag in
>> 'git-for-each-ref(1)'.
>>
>> When using the files-backend with packed-refs, it is possible that some
>> of the refs directories are empty. For e.g. just after repacking, the
>> 'refs/heads' directory would be empty. The ref-cache seek mechanism
>> doesn't take this into consideration, causing SEGFAULT as we try to
>> access entries within the directory.
>
> Why do we even try to access any entry in an empty directory? We have
> `dir->nr`, so shouldn't we check that `idx < dir->nr` every time we try
> to deref an entry?
>
> In other words, I wonder whether we fix a symptom of a missing bounds
> check instead of addressing that missing bounds check as the root cause
> directly.
>

We do a bounds check to ensure that we don't overflow the entries in a
directory with `idx = idx >= dir->nr ? dir->nr - 1 : idx;`.

The issue is that when `dir->nr = 0`, this will set the `idx = -1`. So
this is where it fails.

Taking a step back, the while loop shouldn't even operate when we hit a
directory with no entries. So I'll modify the loop condition to include
a check for `dir->nr`.

>> Fix this by breaking out of the
>> loop when we enter an empty directory.
>>
>> Add tests which simulate this behavior and also provide coverage over
>> using the feature over packed-refs.
>
> Nit: the commit subject might be adjusted to mention the symptom we're
> fixing rather than what we're doing in the commit. At least, it feels
> like the segfault is the more important thing to talk about here.
>

That's fair, let me modify that.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs/ref-cache.c               |  3 ++
>>  t/t6302-for-each-ref-filter.sh | 65 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 68 insertions(+)
>>
>> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
>> index c180e0aad7..8a260028ec 100644
>> --- a/refs/ref-cache.c
>> +++ b/refs/ref-cache.c
>> @@ -507,6 +507,9 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>>  			slash = strchr(slash, '/');
>>  			len = slash ? (size_t)(slash - refname) : strlen(refname);
>>
>> +			if (dir->nr == 0)
>> +				break;
>
> Can't we break before sorting already? Avoids a couple of no-op changes.
>

Yup, in the next iteration, I'll move it to the loop condition, so we
don't even enter the loop.

>>  			for (idx = 0; idx < dir->nr; idx++) {
>>  				cmp = strncmp(refname, dir->entries[idx]->name, len);
>>  				if (cmp <= 0)
>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>> index 9b80ea1e3b..d14567cb62 100755
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -754,4 +754,69 @@ test_expect_success 'start after used with custom sort order' '
>>  	test_cmp expect actual
>>  '
>>
>> +test_expect_success 'start after with packed refs' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		test_commit default &&
>> +
>> +		git update-ref --stdin <<-EOF &&
>
> s/EOF/\EOF/
>
> The same is true for the other test.
>
> Patrick

This always trips me up. Will fix.

Thanks for the review.

--000000000000afa3de063f9bd630
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bfa0d8554072f023_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qVSt6a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL29QQy85V0dYYjdZUnVINXhSZVUwVUM0bDZNRnRsdQpmakR2eng5cE9z
enMrMWtKYks4d3h0QlpHWDZZZG9mVFpieWxTRElwL3Rpam9JRm5yRUdIVUY0OE8xaHFMeC83Clh4
SU5XQjJ5MkhNd1A5NkJvME13THZUR2VaVVRTbEdWa3Q3NVREMGFkU2JzdFZZaVF5cktGemdTRCs3
UXNQMGgKckYwNCsxMW5iQ2JCQ1I0SXNkMUVXTUtUeHVldys1TjhSWTJJR2FGV0xrV3RpeE1DT3dk
b3VTQzBUcCtrSS9JSQpITmRMOGNzUlgxY2hYNUZoK3hlKytnQ0cxM2RzVEFLQ1Z5SmxTSkJYUkJv
aTEveWFlT1VoREc0d1RYb0NyYmF2CmR6cVdTUjRIRkNvaWwzZCtGUUkxMVhYM1NvbXZoMlRnV1RT
NHRuWXhaTTd1RG1NTVJ5c2VsYmRPd3g3QU1XNDMKelhTVEFhdFgvTWVheHZEK0FBUDV1Y3loZHI0
T21RVSs1VUZvVXJFbzlIYXhyYSs1ME8wN1p1QU4zaVJ0dERyMQpKMTBTaEpwVWdOQ1g3NjJCbHpE
Q2MxTjJwcVY3MnZrTDJzbVM4bmJaeXFIaEVqL1JodUFFNWsrNmxPSzltVVd1CkRZTFZsRm5aNnNT
dGFRcDl6cFdmNEI1MnhQM29RT09HTmtRVHZvOD0KPUNBcUIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000afa3de063f9bd630--
