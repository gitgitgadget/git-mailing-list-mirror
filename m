Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9821CC64
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325963; cv=none; b=od+b41feitGp3m85rgv+ffxZ/8heL+dGaBB4iZKWEOY5aD7L3vvCwWClh+eyRUX8tF5eD5ZFGRY12hjgF8jqv8twRpsUye1aNnSQewKIB3apmHzZbDyWAxotSfmcMWrPsqaK9vSxqLVQPuHcBjrcyGsZ8mEa6mPJgm+LsvfCzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325963; c=relaxed/simple;
	bh=xGJysYXE+Qt19sqmFZcjQQZYHA42K7ajukbI3s7f+kk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oty4cixRLZg1UYGepCd4GdzQfYfJDtgjSGZbbt6gsLmTDRIisAmrxk/lkKqGJ9BpzYW+vwMSkZaXvX7RE5AkOXTbsDqIQCTjshSIf5pLpeSHWmVmc53SWqvhjk4FNHPk4HkPZhQwakRi0tai7nGDkxs/8x+2tyNavKDrPTnBj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBuwn7HV; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBuwn7HV"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e9a1090360so165215137.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750325959; x=1750930759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iz/AeR+Z80fUgb6SpAlIdGPCAK4d6RdYU49Tg6E/9i4=;
        b=fBuwn7HVb8C9wnMjgzWnUFK6lzIYipl90u68muLDqkpbe3CCKVYlvqnggQTt/Br2EX
         5VwAY0t9ul4bWF6xIhkdHqYY3GC0je5DAFF3rJk0R/JyzLY0YCs3d+xZeIF2L00vH2oO
         Oi2hYW0bqY3zlHb8zTG7rCxRtcnQ5gIE+2HGzRtVHzIN3O3wPnX/+E2O6l6DdBkxyu5y
         YHYY82pMiQyVFb9q8ai8CUYkzIvOT+yKDp9Ry1kOztSOIurEkxaYvyh/1ECg4PhjNHd+
         eqpn1ycBxWl/JwIv4AoQSaygiFAjmWXVc4DMtd+6bEnwU1B7r5y636SZNl/4xKAPR2ef
         8HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750325959; x=1750930759;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iz/AeR+Z80fUgb6SpAlIdGPCAK4d6RdYU49Tg6E/9i4=;
        b=Kr1SiGcaH1jbV3e25/NaH6rV+z1bxc2c5Xt8Z+qQgryYq/mVFTE5e+9z02acKRzmZL
         8TeMiiqsAzM+NcpVkEnraqekUn1iHlbD+O7ShWBYwJvKebAi3z/sP3G/QwBqrTWthJcY
         441Gad+//TKJ/9NbEKTjBtwcw5nnfolP5HbsWA4Vv1Kxv7xNgHXVmvutNAhBnxXrP9tM
         68Q2ZzyS9B06Ew3HA1IECoqjn3VCQpbO2k0egzcZZztMucv5X089w+92rM4oECYFBovv
         ofhJIi/I1xuUUUVSSPtOYbQM31f35cV78PTXBorFxenkSV30sv1UpnaMjkRnOS3iUruc
         tvEw==
X-Gm-Message-State: AOJu0YyJ62nAMYY3AYYx9qMwDA0qh1dOd8s/y96OiP89/enP532ghnPD
	QSigYOcW4fFm+zBlutMGUDhIDiTeF+WBgK3rqDe/omdOqaMl1hm8wIEkbDWu6uiZHgDnrgM06V4
	m3mPj5XR8VqxWZUNSMJbVbV5vpj+j0Wo=
X-Gm-Gg: ASbGncuxi80QxvMn3eWlFF2zd+Mq+6AWFR/dUH0J+aORI/+E20OURBHFQ6RVgNRelLU
	IsIzJL5rHnNaaXLlZ84mE8xQQBygqcE+HMJ47JROFCVu+DE6j7m8AIL8JYg4Y2ZPVt8xPVYHp3M
	uyd6nbi5fAVE0qCBQV6GmEAaGgJ6RisDGY5oKrvouD
X-Google-Smtp-Source: AGHT+IGXYVNHO2tll/TatGnx0jWIbbBxpJb+xBFD6AFN+GivWQi6t4BSQPVBE0R3W3tRZA3ee3DJ2Bda2S0d++/fBlk=
X-Received: by 2002:a05:6102:6f03:b0:4e9:8f71:bd53 with SMTP id
 ada2fe7eead31-4e98f71c027mr5494709137.2.1750325959370; Thu, 19 Jun 2025
 02:39:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Jun 2025 04:39:17 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqldpvably.fsf@gitster.g>
References: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
 <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-2-ebf53edb9795@gmail.com>
 <xmqqldpvably.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 04:39:17 -0500
X-Gm-Features: Ac12FXyWm7axzXnuVYzYzF8cEJTyYSG_IYNNgRnt8nw0AJUJsk8FYpINmFxShPk
Message-ID: <CAOLa=ZQUJ_RDLn9W64=0_E+ybeWjJ9oNtK036uTX1DGjQshxcw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] receive-pack: handle reference deletions separately
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000000ccc160637e98519"

--0000000000000ccc160637e98519
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
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
>> while the first update applies, the second fails due to D/F conflict. A
>> similar issue was present in 'git-fetch(1)' and was fixed by separating
>
> Do you have a reference to such an earlier fix to "git fetch"?  If
> so, let's add it here.
>

Good point, will add it in.

>> out reference pruning into a separate transaction. Apply a similar
>> mechanism for 'git-receive-pack(1)' and separate out reference deletions
>> into its own batch.
>
> The implication of this is that the earlier "delete" half of the
> operation can succeed and be committed but the "create" half can
> fail, leaving the resulting repository without the reference the
> user wanted to have.
>

I'm not sure which earlier you're referring to, so let me describe them
all.

- Before we introduced batch updates. In this scenario, every reference
  update was independent. Meaning every update could pass/fail and we'd
  still iterate over all other references. Here, if a 'delete' reference
  passed and the 'create' failed, we'd end up in the scenario you
  mentioned.

- Post introduction of the batch updates. In this scenario, we use batch
  transactions, where all updates where batched together. Even here,
  individual updates can pass/fail and we'd still iterate over all the
  other references. The only issue was that, if there was a 'delete' &
  'create' with a D/F conflict, then the create would fail as they were
  within the same transaction. The ultimate fix for this is conflict
  resolution within a transaction.

- After this fix. In this scenario, we separate out deletions into their
  transaction, this ensures we don't have D/F conflicts within a single
  transaction. But we still iterate over all references.

You're right that now 'delete' half can pass and 'create' could fail,
leaving the repository in a state the user didn't want. But this was
also true before batched updates were introduced.

> For now, this "two transactions" may suffice as a workaround but do
> you think it is a viable solution for longer term?  As long as we
> claim that the reference updates are transactional, my answer is no.
> We'd need to fix it at a lower layer within a single transaction.
>

Yes definitely agreed here. Conflict resolution within a transaction is
something we should definitely look into after this, wherein if there is
a 'delete' and a 'create' within a single transaction they shouldn't
cause D/F conflicts. Since the conflict is going to be deleted out
anyways.

> It is outside the topic of this patch series but we can at least
> leave a NEEDSWORK comment that this is merely a workaround and we'll
> have to fix the later?  I see a in-code comment that says "To
> mitigate this" to hint the nature of the two phase solution, but we
> may want an explicit note that says that "we know this is broken
> even though it is less broken than it used to be".
>

Totally valid point. I will add in something like that.

>> This means 'git-receive-pack(1)' will now use up to two transactions,
>> whereas before using batched updates it would use _at least_ two
>> transactions. So using batched updates is still the better option.
>>
>> Add a test to validate this behavior.
>
> I wonder if we can write a test against a remote that accepts
> deletions but fails the actions in the second phase as a
> test_expect_failure documentation?
>

Well we possibly could, but could you explain the intent here? I'm not
able to see why we'd need that. Mostly since we allow individual
reference updates to fail when using batched updates. So the second
transaction here could pass with a few individual updates failing, this
would be similar to how things were before we introduced batched
reference updates to 'git-receive-pack(1)'.

> Other than that, very well described.  I know it is hard to describe
> a patch that knowingly does a workaround instead of doing the right
> thing for the sake of simplicity, and the proposed log message did a
> very good job at it.
>
> Will queue.  Thanks.
>

Thanks, and sorry for the late response, I was on vacation. Will send in
a new version soon.

- Karthik

--0000000000000ccc160637e98519
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: df99b200ae5e7604_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oVDJzRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTFUQy85U0wvbCtxL2NBNVUyKzFNbmZaYys0N0phdApLQ3RQaCs0TFVF
ejd2TEx3UmlnZVFxV2NiTWxLT05yQVFnTkJtTGUvR2xqbzR3RUtEbjJTeFI5dEZDVmxJMy8rCnZj
SitKcnhaSlA3WExGdDArY0hLTlVjakZYRVpQMVRKdnBaL1FlbW1abXRPekxlbnZDMFJhd2Y5WW83
eG54dlkKbndpLzBGSHVsQW83NE50UGkvbE8wV1NHYzBmbWdsQUZDRUxHZU0xQWNVL3FpTUJ3RHlo
ejJqT3ZadG9ycGNTVAppV2V0SXhSWjE0UjN0cDJHU2t5T3pMY3N3Y0FyeDRzN0RWaGF2R082OXhr
aitiaVd2UTVuTFAvQ0NaRE83Q05RCmQ2SG9WaWQ3MjA2OVQwQUtUaHRPbTVscnRETXkzOGFuaGtu
NVZkWW0zczdiSUhrZUFjYU1UTG1DbEJjbnpCOU0KazRrdmlWM29jMjJNVWdmTHAxSm5lL01pRHYr
ekVXYTByMDlKVzdxZlE5WG5mYS8vSTJLRGxYY1Z2ZTJ0T1hjMwpNaXBEb1FYN3ovUjFSYnlVa2V6
ZjBvOWlIelhNZDBLU1BGWElqYTludCsrSkJmVmY2Y3FCNWd3cU5zQ0hKR3FPClhXWlNDY2lYWlBL
OG5uZFZxcUs1MTJKYmZSaFdaaHBHS0E0cm44ND0KPTAwQmMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000ccc160637e98519--
