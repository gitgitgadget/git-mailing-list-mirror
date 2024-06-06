Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4301C2309
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683646; cv=none; b=OlmkCpA2Wt5w9nod83bUo31IkNn8pZ2821p9ULSohNf/Jbx0GlMOQMO7Lfm+kQTPkhYT1IhAYtZheQXzz0Gcl9ac8wHNmNXY0CbOndkQbqCjAPwAQYGMJOeJclUuypYeyhxQ1kvTOdBEkI8ShaIQMJlUHq/WFCgxYAuIoEdtyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683646; c=relaxed/simple;
	bh=7oV/CaWV5FVxbF7AeI78f45wtTPxkGb7iOVIWbRAvu4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MARM8P4YnSilCyXN6NV4p6Eza/qQDqshSw7TP92ab0Rsku2GdbzMiJMfPfNnCdbvfMwqxFK1H4DW3AFRPEjpAvGKhmSDV5ixRQ2XwzVkeD+e4b9SrbVskI77w5X0GAWIvp+w0gAUmBjzzR18Lnt0n6gN/xIfM1PGB5TUqA4uSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7WL9vGs; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7WL9vGs"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2512a0b6916so496861fac.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717683644; x=1718288444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ4KIYhOCcfTT/cBKZQ2BpCdXxcZEhhHJeX55OXw7p4=;
        b=P7WL9vGsFsI4+Bw7yIuQjcto3Jfl2hVHDbfZFzwzQ/6lJnqS9YJbviGFzdJwriFpEe
         bgKVBTnyGquXeS4hBKwzMfI5g6/Bon8LHPUtXqS/48Bdjap/uglJQ2EubFTHqxz7G0HS
         P2R+dsW0nNDcHyRicNL6ijmedSR3zZHAgqyhUxBeBdEdCZSqdM1fSw7kr4GZihYjXLr0
         KSIz+j8goOuROmk+c8RjcwzG2v6/sJK0/viubFAtNKAh/HYWr4SAFurQdr9Yx4xOQ5P4
         tUkczssCmpFIvA4/cV68wHKpQYFPsxpYrc9irNfhHiIgHp+ktbGsLNHMYMJ5bVL/AIDL
         mRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683644; x=1718288444;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ4KIYhOCcfTT/cBKZQ2BpCdXxcZEhhHJeX55OXw7p4=;
        b=DCMBK4uuRLlpJOII1jUjjelDvszhNT1tbcokp1FpR+hT5P+xZfaxYWE6ENvKc1xhAc
         a/9gsIfFx0WjTxQ6JGvrt4mk8AVGIT2JcXrL4rDQ0PmMmcN5jnhA/DqlX+FUOR4HmdaY
         mQHmlGxtH2AHNID3I4nY4rYDaARwiQWaEfm4x+0blNXGxTs8Dokcbmj8rePDSG7mgaCl
         89UYnRPn40lofAXu34xIIjlH27a1esCe768AHKaS+6LI2p7KKzm+WKqVaEPAwLCKRRZo
         A9uGjxjiZYqPDUd4WSaFN+fD4DdTMHjHd7DeWynqtuGAqr2URjT0RpbFOq0RnQ/5eCET
         hdKQ==
X-Gm-Message-State: AOJu0YywhSBKYiS9orxOU62nc50A/A42JEokNRW6QkBLKQbZLFI49C2v
	cwClTfjL7y88ah0DTMl7BMfhQzkPPBqrZLSFfKwHi14Tro14OQugxgME8kkZMP7rwoknpFn7RzE
	dNMeJh5evVhLHLeAfos3gyHtPVtw=
X-Google-Smtp-Source: AGHT+IFhoHIukgwWjM32il1ogpxQf1J/iRectwjkXlzIpKCTv6WNwihIsX55SAz1h4CYXIsjq25qPqiRBMCBJvCT0AI=
X-Received: by 2002:a05:6870:970e:b0:24f:d202:8ba3 with SMTP id
 586e51a60fabf-2512267b088mr6770721fac.11.1717683643773; Thu, 06 Jun 2024
 07:20:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 07:20:42 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZmGXREp9Xa6qHpMC@tanuki>
References: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
 <20240605102958.716432-3-knayak@gitlab.com> <ZmGXREp9Xa6qHpMC@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Jun 2024 07:20:42 -0700
Message-ID: <CAOLa=ZQcZ+pqhe+GbiG=UJi1a3vjQBCz4EDthpa+Rj85FQ0ecw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] refs: specify error for regular refs with `old_target`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000006c90e8061a396329"

--0000000000006c90e8061a396329
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jun 05, 2024 at 12:29:53PM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> When a regular reference update contains `old_target` set, we call the
>
> s/contains/has its/
>
>> `ref_update_check_old_target` function to check the referent value. But
>> for regular refs we know that the referent value is not set and this
>
> This is fairly technical and focussed on the implementation. Can we
> maybe talk more about intent ("expected a symref, but is a direct ref")
> rather than the exact implementation to make the commit message a bit
> easier to understand for folks?
>

Fair enough, will change this.

>> simply raises a generic error which says nothing about this being a
>> regular ref. Instead let's raise a more specific error when a regular
>> ref update contains `old_target`.
>
> It might be helpful to include before/after in this commit message to
> show the change. Even better would be a test of course, but I think we
> cannot add one at this point in time yet.
>

Yeah will do.

Yeah, adding a test is only possible in the commit where we introduce
`symref-delete` and we do test it there.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs/files-backend.c    | 13 +++++++------
>>  refs/reftable-backend.c |  9 +++++++++
>>  2 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 194e74eb4d..f516d4d82f 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2491,14 +2491,15 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>
>>  		/*
>>  		 * Even if the ref is a regular ref, if `old_target` is set, we
>> -		 * check the referent value. Ideally `old_target` should only
>> -		 * be set for symrefs, but we're strict about its usage.
>> +		 * fail with an error.
>>  		 */
>>  		if (update->old_target) {
>> -			if (ref_update_check_old_target(referent.buf, update, err)) {
>> -				ret = TRANSACTION_GENERIC_ERROR;
>> -				goto out;
>> -			}
>> +			strbuf_addf(err, _("cannot update regular ref: '%s': "
>> +					   "symref target '%s' set"),
>> +				    ref_update_original_update_refname(update),
>> +				    update->old_target);
>> +			ret = TRANSACTION_GENERIC_ERROR;
>> +			goto out;
>
> I feel like these error messages are somewhat technical. If I were
> reading it as a user, I don't think I'd understand what it is trying to
> tell me. How about:
>
>         strbuf_addf(err, _("cannot lock ref '%s': %s",
>                            "expected symref but is a direct ref"));
>
> This also matches the other error messages we have in this function more
> closely. The same is true for the equivalent in the reftable backend.
>
> Patrick
>

I do want to also note that there is a old_target set so perhaps

modified   refs/files-backend.c
@@ -2494,8 +2494,9 @@ static int lock_ref_for_update(struct
files_ref_store *refs,
 		 * fail with an error.
 		 */
 		if (update->old_target) {
-			strbuf_addf(err, _("cannot update regular ref: '%s': "
-					   "symref target '%s' set"),
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "expected symref with target '%s': "
+					   "but is a regular ref"),
 				    ref_update_original_update_refname(update),
 				    update->old_target);
 			ret = TRANSACTION_GENERIC_ERROR;

--0000000000006c90e8061a396329
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e6e904c4f26dfd80_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aaHhia1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1V5Qy93TFl0Snl5L3ExU2FkZlJsRGNHd3ZrMXJBTApHZ014NE83R3Fa
WUp4a2dvakdkTVRrUnRTdVZvanhtbXd2dzcwQVM5bWJEMXF4ZkdSeWNQeGFtKytISCtXS1BoClZj
bm1ZQmpZL0dDblQ3Q1MzUXAxMklBTXFHVFhqRHFnUkEzZXJZd3VsWnUxKzFVMjl2S1VuOW8zU1RY
VW1COWEKSjZnM0ZLQkhYNDMzaHN3YzVjQSsxR0xMb3NoL3NzN09aZHd6bVJqOUVHRGpKRDYrejN3
bDVYNGRCRC9lbnNydQpxVjIrNHVMM2xZalBRT0s5RlJyRWlMT1JHSDJiOHVMSlhGR1kzc0w5V1pY
ZW5IaC9OVm5oc3ZiSjJUN1ZON3JMCjZRNEJsQ1B6MDBVLzNBRDlMeWY1M3Y5MFNjNW5hYndaaXgy
aElKODg2OEdDbDRkU1RVQ1VUNUNoS0N5d1BBV1AKVUZ2QlowWXhMaVAyWGlHVUpOSENUZGF2THFt
bFdaMkZvbHVGblVZOUVsRjkrYnVNVThwV0VBSkM4Rkw2dXcxNgpuYnV5d0JnWkZKOVhrRjh6cXJv
ek1TTW55SVpPNFQ2TDZNRWdOZnAwUzVubHFOYm9RTGxRSUc1Q2JoZTZPbzBlCnc2ZUsrV3pYSzZn
VlFqYUlaa0RkalNrTUVWQVFZTUZuL1hEUVhHaz0KPVlqRU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006c90e8061a396329--
