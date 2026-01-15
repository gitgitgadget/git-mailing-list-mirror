Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531536402C
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474487; cv=none; b=riP2/ycqX/YCGn2xG5DLOZnN356T/6LfKI7DO61xNQeIObDIFTjX6Z7/bU6ExjG/8pO9UvA7IvGEQLhKUS4LPzUz60JTedbdosNFawvoFTc37Ukcae1xjx/A96at2+ueN2UgO5ZiISA6DIEoUmvrJmZSm10QM4a87UB3NRqP4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474487; c=relaxed/simple;
	bh=aQoQHEdOOvSaMhu5qHKbSHbVC+hfulJSCVBY79oIFD4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NO9bDy2/fQkQtuKDDiMvvez7NlwuvuqJu3REOLayPJnrHeYMOTBlN2PijaaQh0hHdOOmLtH7I7xgaPh31A5GlXZrx4pbIlMIHSHEKjwBw0bz5/J7838FPtsVaGGax8onLuFemxbAt1oFJgLQES4OfcvAEiXKsf8Nnp7ZdIkV2iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKArVu4y; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKArVu4y"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93f523bba52so494443241.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 02:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768474485; x=1769079285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6fznTySuiLOf1C7D6AoBpnLNIYl2r9+qbYcftArJLs=;
        b=XKArVu4ynBp6SriG8pT9Vu9psp0aQGdRYdB/zjBnm6sMOoZbudGoz2vVK1L+I+Qkat
         G8ZaT0IvbTJVAZh4NeKLw6MqtpwOeX5iFzQRHSooUgFKSh5OQSkwRGcEloJPYIoxiJ/p
         eK758NxSSlx7slo59j269mQJZPjj6caaFIj5iWAhCDLO2SlNrwA+m1Dj2dK8uQcO8j4C
         dp65haLq3LKcrWGRxcf/eSq7ypwk7pMbWUcLv2EpyMqwsnYItZp0ZXBogSeSDJaJbxJW
         Uy1qir+iJV0sV4vCHQaSM8GPyPcSdSMyZa5a6oHR738v9X0eHhkO4Eve0ctxTLEAhq1u
         9FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768474485; x=1769079285;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6fznTySuiLOf1C7D6AoBpnLNIYl2r9+qbYcftArJLs=;
        b=PNmbedMK2omr6k74Jy2e7LbtJVAb/SGS4m5d5xMbpGdhvDLSLIvga+vQ2SLMJbWk37
         kDcnP7E2em7G0ecaB/8dqY56r+toaD22Rsc6tu726W7BtbkUalELBo2s/aA6Dwx5SSWJ
         kC9Q2q6K8IQG/eWTq5NNuXjo1AmPaP/nahWYuI6+rkA+/9gvZSbtM5JrIqaK0YkwdhEa
         +CB9n857CaP3Ar+4PvDAOjhgzGK5ydZeKBBPXnoLU3iZEiq1cVeoZkpSmL6CqioBMwLo
         9s09Y7Sz7BO4NrmYi2SHUSmv4KTkBbiEMrJzESQBUyxxlykm2XsgYCaQK7ZOG/0Q5Nt7
         Ijqg==
X-Gm-Message-State: AOJu0YxWIZZMT1lV4bJwgC9ViFoQFARzdUgN2xkMAmI0v/7XJdXkAjrb
	P5ly2T1aEQOPsqFlsSXoCzIZ1JUGOTevhKfz2N9t6Kgmp8Fn7AtKhguiXv9rt1Br3J48QkUUIGB
	Z6r2UnPtv3oZx13A/hsALUKp9d9z4uYk=
X-Gm-Gg: AY/fxX4W+fgxz6b2fKD8CYGfR7nvA2pdA54nlq6Mu73RbcI3ARwZwxdQEIeHh3kBkpM
	UiYynyugTyIlKsnNxIMyebT6JYiaA/EYtfT92QvaabtAmpE/ByxfjdQ9dTH7zq5hprbLUTHo1Ew
	KpeFCDR5WBynvqgYd5r3QgHLawhsqj1CYoXhMR80BgRxdlrRQAaS6TSB44LVzwhHxJcJoUSS+Dk
	ae2UB6faO+/9PKn9TU/hNt2GWGKnniZMXm02Vogj8t9zfaC1knxJIvGZFCgeraVl8ToJDBbN+5b
	0cF3
X-Received: by 2002:a05:6102:2927:b0:5dd:a08e:5bac with SMTP id
 ada2fe7eead31-5f1924527dbmr1203310137.6.1768474484946; Thu, 15 Jan 2026
 02:54:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 02:54:43 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 02:54:43 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqldi0f6a4.fsf@gitster.g>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-5-f5f8b173c501@gmail.com>
 <xmqqldi0f6a4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 02:54:43 -0800
X-Gm-Features: AZwV_QjuWFXcM9JwAAJyu9N5fmU1HuOBOG6djawOEoyWubUyeBc-EFAOgRarBeI
Message-ID: <CAOLa=ZS0i+YXfVHHAax699ME48YG7jXNZ3WOBYryS0hypMZO-A@mail.gmail.com>
Subject: Re: [PATCH 5/6] fetch: utilize rejected ref error details
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, newren@gmail.com
Content-Type: multipart/mixed; boundary="000000000000785b2006486b0d4d"

--000000000000785b2006486b0d4d
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> In 0e358de64a (fetch: use batched reference updates, 2025-05-19),
>> git-fetch(1) switched to using batched reference updates. This also
>> introduced a regression wherein instead of providing detailed error
>> messages for failed referenced updates, the users were provided generic
>> error messages based on the error type.
>>
>> Similar to the previous commit, switch to using detailed error messages
>> if present for failed reference updates to fix this regression.
>
> The same question applkies as the previous step.  That is ...
>
>> @@ -1674,9 +1674,11 @@ static void ref_transaction_rejection_handler(const char *refname,
>>  			"branches"), data->remote_name);
>>  		data->conflict_msg_shown = true;
>>  	} else {
>> -		const char *reason = ref_transaction_error_msg(err);
>> -
>> -		error(_("fetching ref %s failed: %s"), refname, reason);
>> +		if (details)
>> +			error("%s", details);
>> +		else
>> +			error(_("fetching ref %s failed: %s"),
>> +			      refname, ref_transaction_error_msg(err));
>
> ... would "details" always carry enough information to cover
> "refname" here, plus what the err code tells us?
>
> I guess ...
>

In general, yes. Here's the final detailed error we'd show:

generic availability checks (files + reftable backend):
- '%s' exists; cannot create '%s'
- cannot process '%s' and '%s' at the same time

packed-backend:
- cannot update ref '%s': reference already exists
- cannot update ref '%s': is at %s but expected %s
- cannot update ref '%s': reference is missing but expected %s

files-backend:
- cannot lock ref '%s': '%s' exists; cannot create '%s'
- cannot lock ref '%s': cannot process '%s' and '%s' at the same time
- cannot lock ref '%s': unable to resolve reference '%s'
- multiple updates for 'HEAD' (including one via its referent '%s')
are not allowed
- cannot lock ref '%s': Unable to create '%s.lock': %s.\n\n
  Another git process seems to be running in this repository, e.g.\n an
  editor opened by 'git commit'. Please make sure all processes\n are
  terminated then try again. If it still fails, a git process\n may have
  crashed in this repository earlier:\n remove the file manually to
  continue.
- cannot lock ref '%s': Unable to create '%s.lock': %s
- cannot lock ref '%s': dangling symref already exists
- cannot lock ref '%s': expected symref with target '%s': but is a regular ref
- cannot lock ref '%s': is at %s but expected %s
- cannot lock ref '%s': reference already exists
- cannot lock ref '%s': reference is missing but expected %s
- cannot lock ref '%s': there is a non-empty directory '%s' blocking
reference '%s'
- cannot lock ref '%s': unable to resolve reference '%s'
- cannot update ref '%s': trying to write non-commit object %s to branch '%s'
- cannot update ref '%s': trying to write ref '%s' with nonexistent object %s
- multiple updates for '%s' (including one via symref '%s') are not allowed
- verifying symref target: '%s': is at %s but expected %s
- verifying symref target: '%s': reference is missing but expected %s

reftable-backend:
- cannot lock ref '%s': dangling symref already exists
- cannot lock ref '%s': expected symref with target '%s': but is a
regular ref
- cannot lock ref '%s': is at %s but expected %s
- cannot lock ref '%s': reference already exists
- cannot lock ref '%s': reference is missing but expected %s
- cannot lock ref '%s': unable to resolve reference '%s'
- multiple updates for '%s' (including one via symref '%s') are not allowed
- multiple updates for 'HEAD' (including one via its referent '%s')
are not allowed
- trying to write non-commit object %s to branch '%s'
- trying to write ref '%s' with nonexistent object %s
- verifying symref target: '%s': is at %s but expected %s
- verifying symref target: '%s': reference is missing but expected %s


>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index ce1c23684e..c69afb5a60 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -1516,7 +1516,7 @@ test_expect_success REFFILES 'existing reference lock in repo' '
>>  		git remote add origin ../base &&
>>  		touch refs/heads/foo.lock &&
>>  		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
>> -		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
>> +		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&
>
> ... the error only talks about our local name, and when the command
> is "git fetch origin refs/heads/foo:refs/remotes/origin/bar", we
> only complain about refs/remotes/origin/bar without ever mentioning
> refs/heads/foo on the remote side, so I think "details" has enough
> information to replace the existing message here in this case.
>
> Thanks.
>

Yup. I do think there is a good cleanup we could potentially do here,
with some of the error messages and perhaps following a better pattern
in general, perhaps a more structured error message. But I didn't want
to tackle that in this series.

Karthik

--000000000000785b2006486b0d4d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a8714be9abef64df_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sb3gyOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmF3Qy85ckVaaVZEYkkyN2Jic1gwRWVBeWdQUU12aAptY1ZMN2R4aFgy
VFJvY0VONHZVWlhzZWFmNFZIQXE3aTV3MGk5OU1XUnNnRTRxWkgvd29KR0wxUW9INGNiYnZUCjRM
aWdUSkFtYm5nV0xVR0R6eUJwUEx6WjB6b21zOE1GMDB3OEY2dW0vV2d0Z29la3hVQWJneFN5NWtx
ZVBzSmoKN2tXZGFpZFN6WGFQem9GbUZKbWptaVJNNmluWlFyNHA5Nzl6S1RUTFlpR3RnSjVDckFt
UnFCWkVOUHI0RlpkKwpyQlQ5UHFDT2VqMkk0MDV3UDZBVm43dW5XTWtSTmhHVWNtdXhDZnA1YjhT
SXBqQ1pqbVhCeHhmMnlwK2tIaGhNCnA1YkY2VG1tRmhjd1Z4ako1REN4OUdqWDExRnBZSWtwV1ZH
TFZFM3VqRTlhbEtmQkh0bWs0cTFnSlg0b1dtOEQKc3ZMd2R6VUMyTy90UXE0U21qcFV2VU01d0Nu
Z1FybXY4K09FY2EzeXVobWtOeDZKc1ptR3o5dkxFallMRFdQdgoxdHFnRm5yRFZiVW5EbkZqK3do
SXlFVUpCWnR4R215bFEzVi9zdDBaYnhGQk9hanp6YVhjbWRYSXpiOE85MGFKCno0b1RBUVdFcjdT
TlNkaGRFUEd0aklSZDJRcUdTelhzRzREZkZIVT0KPW9ObFMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000785b2006486b0d4d--
