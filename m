Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F928312F
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531105; cv=none; b=nxZfBDKmF5G578RWp03mjJ0lcQRrp4NV88nQ2ZFX0G0Y+icrP+zasX/9J4DGkdNQ+70/efQMaDYsZlX5GMOEo+2NbP3TxuoXcd8j7H47CJKsmZL/f3dSIYP85C2Kn1JLLdgTaxwWFCr5yXmHw2WO7beyd3FYlttqowFLo9vcSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531105; c=relaxed/simple;
	bh=aFjOLuq44YVw04Au/EWUN83b8u9Zuu/ArncrP+l2Fu0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jb3rRvTviiR9NJHrSQiRDTGvOEAkstiwUgXEjRcS5HXfhdjLwCQSp9UB7A695g4Qm+BY4VdJzy6l+OlgiGaUdH7J5+w6njPANaKxragDOdrY/rdyH124+S6MS26eXSSQeaeNaN5autMUL4YtdrQtKlbt+zaNbHw8Vw/EdRf8NfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSZvkDJ9; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSZvkDJ9"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-89019079fbeso256028241.2
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 07:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531102; x=1763135902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CG1F1mHMlfJof5QG/E/WPMlWAMiTeusSPFMr/cd0Zds=;
        b=RSZvkDJ9Ei2Q0EvN4n86u1da4wvad57UmQJf4ilpheaY17XEXfovakXRVWYMysOCNv
         rlayzEAFhlmdqDOYyGkrz5DLfCSGFlxZ7oPaVqSf9mNI0iJlbYj9TzrgbYd3WVT2GHfh
         r8K6iPvapvSteNQoPBhoplZIgnV/xj/I/T/EJR/45g0wZtSLS+nMNU8WCXYVB3AUKwOd
         D4vu0o9wwwLQl8YzDSOGEBSZMPzs+LKcFGF1CT4U99Zsm7Py9GUpaLpH0ed7tTsaiQjn
         d/FaR7druN4s2fFnXoD5a0fJ7tDCw1rFX/EEHVZvhy/5ew0N9dumbD+0R7EnOnu4Ch5M
         wk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531102; x=1763135902;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CG1F1mHMlfJof5QG/E/WPMlWAMiTeusSPFMr/cd0Zds=;
        b=isw9ZGIhkURUfsaObcQaw6kc3/lEqaAXqnsJUxSD4Sx2YrjZKH8CKKOIIqfRwiqq0F
         RCxH6CwxgFib78N7NHv3lan1tp4HMtDaQFQHD05d8rTsgqsHQfkVIGJsA9Ok6gvUNvH8
         KaPNMeIuPdLO02OgZrgzBBVBt3M2stcB9qEvzEX00uGXTIvqxZnPm8sQxo6hiYsAdgdk
         AO7eLGMFf9yahFVIfxdNrYQWKynb/nqeGZiqdEyWP5DExIbscv8ezsyvGkEFWY4w32mk
         iRf5Lds612/wfRwnxuDwrv3+00fp3m+qhvZK8jILamc81kr8Vt2OXd2Ygf+i1HHnyGPG
         AMiA==
X-Gm-Message-State: AOJu0YwPOQg6r0dWH4aYeT461M6qKO65l/ZxDEWbA/JxRbjJEoQJUf5N
	ltWu9TEWHiuYmL2rk0R0yp6LPII3BdB1JwXqbEYJSh0y/8PJdejTQDCNQgO/3uxK/250TL7QYx7
	zquqLz4HG9FhdW9BW8D+vETyBd5So6pU=
X-Gm-Gg: ASbGnct96V3KErTofVKeqIrTp3rqb12bCc5nkBrAcwyFGpuICghWofY1QT5AHqLV1HD
	Md/Q66GfJDCthLRmTa5msAU7qJU0CFU9OUOWXGEhApnsMKzFEAlA728Bz5jIFdt4jDXivyxhk5E
	KupKQJ7naVykZ+W78lhnjBRQ7Q9p2lFcIKMxZncHzP53N9e4JNWwR3EVbepak0qDw3BdW8mcd5L
	EYaIyE1zLr7lNu5qGZ0WV0QEktbYMVbw49xiZisx5ancVtv43yBYxoXp7RkX1LuAl3Y0pC8cc6O
	90Ai1rsjz0CYOV+T+mtu3A5VnIc=
X-Google-Smtp-Source: AGHT+IHQTiXYC9TEl4JTxoEJ6ASwrj3TtI/kWDh1Jx+8xx1WpTxEnmDQLFurjgIKiGgmkG9u5EKJ6nROPk+TeDtpybk=
X-Received: by 2002:a05:6102:3f10:b0:5db:23ed:3840 with SMTP id
 ada2fe7eead31-5ddb22a94b7mr1293446137.37.1762531102421; Fri, 07 Nov 2025
 07:58:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:58:21 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:58:21 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqpl9vjiaj.fsf@gitster.g>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
 <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-4-d611a2a95cf5@gmail.com>
 <aQyNSOdPWAxm15U3@pks.im> <xmqqpl9vjiaj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Nov 2025 07:58:21 -0800
X-Gm-Features: AWmQ_bmxN5yvb3XjzyUuO42X9UDZF8Y_t_tRQ1gxNNKQiweGUjg1fMwDEsH0ITM
Message-ID: <CAOLa=ZT6CnTRz5bX+Vv7pb_3oqV0XNSMEzh=57sF6O5bFYxWhQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] maintenance: add checking logic in `pack_refs_condition()`
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000004411380643034014"

--0000000000004411380643034014
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> +	/* Check for all refs, similar to 'git refs optimize --all'. */
>>> +	string_list_append(optimize_opts.includes, "*");
>>> +
>>> +	if (refs_optimize_required(get_main_ref_store(the_repository),
>>> +				   &optimize_opts, &required))
>>> +		return 0;
>>> +
>>> +	clear_ref_exclusions(&excludes);
>>> +	string_list_clear(&included_refs, 0);
>>> +
>>> +	return required == true;
>>
>> Tiny nit: I think in our codebase this can be written in a more
>> idiomatic way by saying `!!required`.
>
> Comparing for equality with Boolean in general is stupid, as
> Booleans are designed to be usable as-is.  If it is "true", it is
> true, and you do not have to compare it with "true" to ascertain
> that it is true.
>
> I do 100% prefer "!!required" over "required == true" or "required
> != false" all the time, since it is more idiomatic, but I vaguely
> recall we had something that contradicts it in the CodingGuidelines
> document.  Perhaps we'd want to fix that.
>

I could only find

  - Some clever tricks, like using the !! operator with arithmetic
     constructs, can be extremely confusing to others.  Avoid them,
     unless there is a compelling reason to use them.

I think its okay? This is more of a suggestion than a rule.

> Thanks.
>
>
> [Footnote]
>
> But doesn't your suggested rewrite potentially change the meaning?
>
> The original allows required to be "true" and nothing else, while
> "!!required" allows it to be any form of true (and in C, things that
> are not zero, even a pointer that is not NULL, are all true).

I get what you mean, but with the context that required is of type
'bool', this would mean that we simply convert it to '0'/'1' here.

With all this, perhaps `return required` as used in the v1 was the best
approach. I'm happy to go either ways.

--0000000000004411380643034014
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f08f515a079d9f5d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rT0Z4c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFVuQy85VXBXUXZOd0dLSmxLZ3lpSkJXK3Y3YTZYUgorcmpCR2owdTRp
d0VlYWJIS1U2NVI1aDd5cWE3RGVsTW1IZWhaaU1EZjB0d1M0aHZBdUt4SkdubnFNUkMraXl0Cmhk
SGxrVnVRSnZFYlVGOFllRjFkQjhPMFdRcGhMaDV1QTAxc1dPaGlxU2pwNU52c1BBRmYyb014UWdH
bjcvZEwKN3lHcXJVaTExN1g4b1VUWXZjc0lhVGNMUWRTU1hzZmRZdE56S21ZUlM1KytObkJuVmMv
N1lqM1RkMDJNUzRQVAo1V3N2Ym9UTCtCUDM1VHM3S0s3bUVPK0lFSEtTSkhLYUNVK3VLbGttYWVu
cGNxN2x4aG9UTDdzdGZ5V2pvb1U3CjJEV25jcFpBM2p0ZklRUUpJQk5TN1RhQzJiT1BJdnlHZGI2
SVRBcGUxaUhkQWVwUzRvZ0J0VWZMSW0yeUM1TlIKRWZWNWdBOGVMM296WnpmM1ZhVGtrcG5CWjlS
Ti9YWFJ0SnRCRTQ4SDVGenpVekRpVldWdjhoVnJtZUFHMmRtMgpoRmNkN0tud1FoZXJYTDVpRlE1
VDh5aGg0eVRBckpVVUJsOC8rVjN0MHFabGVDeDh3cWRObjQzeCtIaDg5ZzQyCkp1VWV3bnpDazJt
bnp6VURNbFp4VHpWb0ZoYWg2RXY4M3BrbWhJdz0KPUtUOEQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004411380643034014--
