Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19F214A7C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748868900; cv=none; b=BX7/SUVt9KzRusTbGvxkQ2o0i2tgBeNcMuzXZU2BjHs030at477VNrNbR57/KlBXVxR3uepFn4lAghEDNepYbrfu3gJKeEtz0+OFWM4Rfyy3DM2tcLgdpClwnre8+qkjfHJM8RxkqeTX6mDyG/CropVM0GrENixdOADM59gWGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748868900; c=relaxed/simple;
	bh=f9JvzGm2nZxLyzOYtgYMHbTP1p9Hn5SMZaB1iCG9S9g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8BZtV4ievxYo8apfbKLq+QLPVF21cz2waCiwek9Ai0c53oSZVGDVGDFTSXzk7sKzohPDxw7vFL1WeEN0OdIkMX1oLSpvcOzy5CFJX+iCbZmczpeHCkj+/KB7kefhGc9IzOQP06x9M0pckYqdEJXMbXzQbDEL7fubf0hDXeYoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6VboNzQ; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6VboNzQ"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5290be1aedcso3569707e0c.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748868897; x=1749473697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjtfYh+5gYvPLA8V5sKnG59ObEZz2B1ocPceP4zXgKU=;
        b=X6VboNzQNr5l5SbNsulpyyQGVfl458EUll7BkflH2cv3m+aj8Bk9P1bGzKfIZhyFd1
         XdCFvwrGU2V8pj2uqxf8SJ/c5Qp2Zht6dude8OkRrOX0Tm7mK7dfRU44S8v01wB34SRH
         CVnKOoSfHs4qxjpez2YoINncn+TXqsc31e+tqghTt0+mK2g7So4Cx5Js+dp0K7fab7Ig
         5bVRc3GaAhovUWlmkcX9onNAL7lXaQVw/crbINZRUZ6kJagmfjbx1FkQJfddq2ovHeHQ
         zZBWKu882H29Z7khI4S5r4CkoPk3Xr4xmMGrg2KUwgZgNCN0Yb+IkJYfF3i0/nYNDdmd
         ljOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748868897; x=1749473697;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjtfYh+5gYvPLA8V5sKnG59ObEZz2B1ocPceP4zXgKU=;
        b=Fv5FBocEhNL3n9+SjZJfqR6lNvUvPJhrjIEwSN2s7NgDO9RrJKF1HXta+8aypqGZqn
         H3Jwytz9T+ZfiGfRThKmpsGB3/HBybuW62ykyxhskplZ5yiUfzrYnZ3A7XQG6EnZ+zup
         gxiXhyVDPldLBaldc198LQ/MC5Br1B2cVsNkdcC/tQtjD0ARzS05Id2UA05nKVrnVgoS
         IzP0A4B+27ldQViBksoiv8kzFNSJKOFfFxzA7wgGQ7jIrwDJnxNR13/shrCIr3uX8zS2
         +Rhc1n0/i7JJlULNYR1WMMj87ttaDb9ldJM7pKPNon5Lf4GSpXgmci5eYzApkTNqna7c
         yWoQ==
X-Gm-Message-State: AOJu0YwsP08CwS9B3bj96btXqY0tgvh5JICiV7da1znga+46UyU/R187
	L6IdG+lMGX3fGJAXl8m99xDI6GPawZ6NYBL9/WLmTqgYIUVOD10SldzT2rOot3HU/r5g1Sep07N
	DB7kSGbub7V1e3LuL4HRK4mufoLGsVtaDOSHD
X-Gm-Gg: ASbGncuSMCVcPYGHnyuH5VwN7c4J+2S48IsB0rK8DZ/cugtrwMOjBCv4biX/XQsZ2OL
	/Wzc3JJvQG4mYSXHjvbriSC8wMbrNDXi8z4+U1CJq3sbctnYbTAKumlpMuqFrkJoI5oSTIjaPk3
	8rQtWv28XJThTLeT27O3SF1FThsUAEzX62QdgmWolKi1ww3QDiVFM54QX+qm9A/Nsz70Q=
X-Google-Smtp-Source: AGHT+IERnNGmz+mO+qQLtUxgYyZZeUFlIZeVyRXWNAb11Bg8taxDrNfBL9jsqG6BcuQ0dLP1SAILc1zgqIeQGSa8Z8Q=
X-Received: by 2002:a05:6122:1354:b0:530:2c65:5bb8 with SMTP id
 71dfb90a1353d-5308126b2ecmr9582061e0c.1.1748868897433; Mon, 02 Jun 2025
 05:54:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 12:54:55 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 12:54:55 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aD2SPsro694yr60Z@pks.im>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-3-903d1db3f10e@gmail.com>
 <aD2SPsro694yr60Z@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Jun 2025 12:54:55 +0000
X-Gm-Features: AX0GCFtgqCpEtULmGl1u32V0prDS6u1mwhVZjeXRg4VbQrczJN8H_ooixT384a4
Message-ID: <CAOLa=ZQ5To=ksfv7pfCoeJLsORWxaAvAR4Qs8kj8O_e8pNjsJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] receive-pack: handle reference deletions separately
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000006405ca06369645e2"

--0000000000006405ca06369645e2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 02, 2025 at 11:57:26AM +0200, Karthik Nayak wrote:
>> In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
>> we updated the 'git-receive-pack(1)' command to use batched reference
>> updates. One edge case which was missed during this implementation was
>> when a user pushes multiple branches such as:
>>
>>   delete refs/heads/branch/conflict
>>   create refs/heads/branch
>>
>> Before using batched updates, the references would be applied
>> sequentially and hence no conflicts would arise. With batched updates,
>> while the first update applies, the second fails due to F/D conflict. A
>> similar issue was present in 'git-fetch(1)' and was fixed by using
>> separating out reference pruning into a separate transaction. Apply a
>> similar mechanism for 'git-receive-pack(1)' and separate out reference
>> deletions into its own batch.
>>
>> Add a test to validate this behavior.
>
> Okay. All of this is unfortunate as ideally the reference transaction
> itself would know to resolve such conflicts. But we're no worse off than
> before because we at most perform exactly two transactions now, whereas
> before we would have performed _at least_ two transactions in this
> conflicting case.
>

Exactly. It is not easy to build in conflict resolution but it would be
great to have it. Also to some extent F/D conflicts are due to
implementation details. With the reftable backend, we artificially
introduce this limitation, maybe someday if we get rid of the files
backend, we won't even have this issue.

Thanks for spelling this out, I think it would be worthwhile to add this
to the commit message too. I will do that.

>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  builtin/receive-pack.c           | 23 +++++++++++++++++++----
>>  t/t1416-ref-transaction-hooks.sh |  2 ++
>>  t/t5516-fetch-push.sh            | 17 +++++++++++++----
>>  3 files changed, 34 insertions(+), 8 deletions(-)
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 9e3cfb85cf..7157ced2a6 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1879,6 +1880,8 @@ static void execute_commands_non_atomic(struct command *commands,
>>  	for (cmd = commands; cmd; cmd = cmd->next) {
>>  		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
>>  			continue;
>> +		if (only_deletions ^ is_null_oid(&cmd->new_oid))
>> +			continue;
>>
>>  		cmd->error_string = update(cmd, si);
>>  	}
>
> Fancy.
>
>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> index 029ef92d58..34eb3a5a07 100755
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -744,8 +744,8 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
>>  		EOF
>>
>>  		cat >update.expect <<-EOF &&
>> -		refs/heads/main $orgmain $newmain
>>  		refs/heads/next $orgnext $newnext
>> +		refs/heads/main $orgmain $newmain
>>  		EOF
>>
>>  		cat >post-receive.expect <<-EOF &&
>
> Hm, so the ordering does change now as all deletes will now be listed
> before the updates. We don't make any guarantees about how these are
> sorted, but it makes me a bit uneasy to see this change. Can we avoid
> this change in behaviour somehow?
>

Yeah it does. I couldn't think of a way thought to retain this behavior.
But I will spend some time on it.

> Patrick

--0000000000006405ca06369645e2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c581d4b7df0690da_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nOW54MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0dpQy9rQlJlWGRqS1ZwZ29PclcyNHNmUTlCOFFnZwo3N0djNXBJbDVL
TWNhVHR5aUFkcmV6MUpVTmVubmxJOGxCdVU3VllmRWRyZnh4SlVmZHJqbThtYzJjU0NaK1lGCkI3
K2F4bzEwQS91ajZjbnM4U1grYUtna1VrZ2pINXo2dzFVL1JYNFFCa2pFL2tWdkw3YnUzZVlzWVdW
SGo3djEKZm5OVWFibmpsaFhOcXFwNVJ2aVhkMVNYREdUajNYbzAreUQ4UDEySXhpdUNvazNlSWwr
azhyZVcvcXp4ZFExWgp4TE93VUUrbUVqYTBUMWpFdFFrTHd2ejlJR05uL2lqaldyQ2dTMTlldDhw
T2VOTEFTaDlLSTc4V1I0bURNQldlCnhuUWFIM3g0OU54RS9tSCs3djRBTCtjUjRZVGp0SDM4Y01u
bzBjdDVJUW9NbEE1TWZtZTBOd0hyRE01eXBZSGQKTVc0Wk1Lb0s3ekliSUpBamJzbk8vUXNET0xh
cklsMEtxS1I5eXVQR1pDN0UzM3NLL1pkUDh6ZCsrOXNzZTFBVAp6a3pwTDJucnFhUm5nTUlURFdH
eHlsSnNPSW1JU1BHT1JwaFN1WElDWEFYRSs1MEZLQmdnaWwxc0FKbDFvdSttCnVLeS9SRXFiZ2J4
QXpqVEt5R2ZvOXNuZDZySFQrcWRLbnd4cWRQaz0KPTZlWUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006405ca06369645e2--
