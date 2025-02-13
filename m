Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44320C029
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438566; cv=none; b=Gkbg+2mry1FTf7sE+q+Dj5O0h+NFoM7zulZcUXXGCmpysr5KWxFUK5gnqizbwVHqPawqPpj+18TtX3apbbvTuygXsu6L/UZC7h7rX/HTPI3EITFyBuQpGVuH/0m0nxhcMsW/w5Qug1G0sJj2PPDlv853vOUkOm8Wpde0CHZq18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438566; c=relaxed/simple;
	bh=lpY5q7h1wXpe40HiMLozpVR0rFHBGqYozqr908UrK04=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcodE7ivSTUabjGwU1uAXw0ZqHIBQ0bZdp7G8Ml8zBieDRjwQdT08WZvd4oSnZDhyYuomIlA3ZTkZTl1h4wmcO6FAFILOpmJzMF+lsZDK5rfCQxhK24GpxF9QZnIrbqdqWdGaIEszt7WAYCAGce3NPVJm6pEYVi8a8x3Q9YGt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFmUnNt4; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFmUnNt4"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-520335ff378so191406e0c.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 01:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739438561; x=1740043361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+h9yLeULupWAPfzg+vYAOBL9btZH3FZDOfez2MowS4s=;
        b=nFmUnNt4lHbCmySRI79lAz2JVPkqzqtmuWij8wfsGeaf3O7eqGerlqCif6Q7FCZl4x
         ypEsFLRZX3EBCCvKFaFa4Tg3vs/GmJwJi/JNsvT7YbivK3/p5jBnFNxcXmOF/TpFf+n4
         fWNmcIhLeRcIK8Ma/vuqeNBQ2YtUx0lDafqFvv+MEqpxbrUqC0G7NFnmjqYrgVZK+1NS
         5zfeDYWITZ7ux2JSVDCcdSpOAX7a0QsffIJ5BFXiyi0HNXbzzCSWjlZFdLJmhR7eIvVD
         MXWH9NuAV/6JzmR1FlDcZYGNmm8Z9A9tFkZrrvYqSqde53MaqEy9ws7OvRluDCrd83Xh
         jaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438561; x=1740043361;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+h9yLeULupWAPfzg+vYAOBL9btZH3FZDOfez2MowS4s=;
        b=t0Nwd8E9xOUL3KRMtVzJV5rRUeNhaQwyUh/SYutVOTDeOKIn2R88CIhq7hCewjzzBC
         rxF8Xi8mXU6Ese9t7qwt0a2Bld1w/xIlh9KL27WNhTqn0ZlwfzRmsJTWAH2OCntZyaGF
         ijhNDk+eCDnMukXAVzOx/1X1QXwLSj1Z40vXE+Sqa26fixDNOompNT5I/XuD3kdy2paI
         NbaWoIzjvLAiIiKfMVHoltyDE8CjDZ5UlueYnyoedxQjd9sf0JmHOELC4TB/gtqXmg+a
         a9nw0vr35KdQI3XS7E0w022Y870b2ASdEACIKZITm7dSRctCv1O+Z8fZ++x5g7qAK3DP
         i5aQ==
X-Gm-Message-State: AOJu0Yxn9cNPj530+C61179M9eR47XYIhB3tZqG+1qe4filiyQMhCsw3
	8KhZ9F6F8I/tNP1KhKmdoP/6pKm+niTbFx79JjXhADwwajzK8oi9V5/zykZzLI14XrM12BST1W3
	AJZRYOcoFD9deekOfrfOKzzm6/sg=
X-Gm-Gg: ASbGnctKeUw4k808B5yYEfq0tt2FfJEhQUKJd4S4/wrTa0d8qZ8FyaCg9WdVNmxZWCm
	25wb2Qqc069GnhAFf9ja/N0AltipDSXqWbT5t0yP1I70YQ6amDfo045LY46rO8HQbl51oeWk=
X-Google-Smtp-Source: AGHT+IHre+k5doM4PD5x9TLHdRuKnUvl9+9z+DalhzN4gAK9Kj4BZmcXpYU3S3hJ2wu/EbQHP8VllvcxlZW9Pwnojy0=
X-Received: by 2002:a05:6122:250f:b0:520:61ee:c815 with SMTP id
 71dfb90a1353d-52077fb178fmr1577879e0c.10.1739438561016; Thu, 13 Feb 2025
 01:22:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Feb 2025 09:22:40 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqa5aqu7g9.fsf@gitster.g>
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
 <20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
 <xmqqa5aqu7g9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Feb 2025 09:22:40 +0000
X-Gm-Features: AWEUYZlzmsd6vw1MWTK7jgRYJ0HhPAVofxuMeL2XCoQ1l96GAH09diJHfSvyRTM
Message-ID: <CAOLa=ZSDLNLYQ=zsoOqJW6KhcUqeDahNfhG-n9k1t0O6B40OnA@mail.gmail.com>
Subject: Re: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="00000000000089eaee062e0299dc"

--00000000000089eaee062e0299dc
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'git-refs(1)' migrate subcommand, which transfers repositories
>> between reference backends, currently migrates reflogs by default as of
>> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>>
>> While this behavior is desirable for most client-side repositories,
>> server-side repositories are not expected to contain reflogs. However,
>> due to historical reasons, some may still have them. This could be
>> caused, for example, by bugs, misconfiguration, or an administrator
>> enabling reflogs on the server for debugging purposes.
>>
>> To address this, introduce the --skip-reflog flag, allowing users to
>> bypass reflog migration. This ensures that the repository ends up in the
>> expected state after migration.
>
> I do not quite understand the motivation behind this change.
>
> If a repository has reflog that you do not need by mistake or
> misconfiguration, I agree that there should be a way for you to
> remove the reflog.  Removing it while converting the ref backend may
> be a convenient way if and only if the reason why you noticed such a
> repository with unwanted reflog is because you were about to migrate
> it, but regardless of when you notice such refs with unwanted log,
> you would want to be able to drop their logs.  You may not even be
> planning to migrate your backend when you noticed that the refs have
> unwanted log, you may have already migrated long time ago when you
> noticed that the refs have unwanted log, or you may not even be
> planning to migrate in the first place.  Even after you migrated
> your backend, an administrator may have to enable reflog for
> debugging, and then after the administrator is done, then what?
> Should the backend migrated back from reftable to files and then
> back again, only to pass this --skip-reflog option?
>
> Wouldn't it be a lot more flexible if you add a new subcommand
> "drop" to the "git reflog" command?

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'git-refs(1)' migrate subcommand, which transfers repositories
>> between reference backends, currently migrates reflogs by default as of
>> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>>
>> While this behavior is desirable for most client-side repositories,
>> server-side repositories are not expected to contain reflogs. However,
>> due to historical reasons, some may still have them. This could be
>> caused, for example, by bugs, misconfiguration, or an administrator
>> enabling reflogs on the server for debugging purposes.
>>
>> To address this, introduce the --skip-reflog flag, allowing users to
>> bypass reflog migration. This ensures that the repository ends up in the
>> expected state after migration.
>
> I do not quite understand the motivation behind this change.
>
> If a repository has reflog that you do not need by mistake or
> misconfiguration, I agree that there should be a way for you to
> remove the reflog.  Removing it while converting the ref backend may
> be a convenient way if and only if the reason why you noticed such a
> repository with unwanted reflog is because you were about to migrate
> it, but regardless of when you notice such refs with unwanted log,
> you would want to be able to drop their logs.  You may not even be
> planning to migrate your backend when you noticed that the refs have
> unwanted log, you may have already migrated long time ago when you
> noticed that the refs have unwanted log, or you may not even be
> planning to migrate in the first place.  Even after you migrated
> your backend, an administrator may have to enable reflog for
> debugging, and then after the administrator is done, then what?
> Should the backend migrated back from reftable to files and then
> back again, only to pass this --skip-reflog option?
>
> Wouldn't it be a lot more flexible if you add a new subcommand
> "drop" to the "git reflog" command?

To just get rid of reflogs from a repository, I think 'git reflog drop'
or something similar would indeed be a better way to go about it. As you
stated, with this patch, we could still face the issue wherein the
administartor could re-enable reflog and we're back to square one.

Why I think this patch is important, is because while there could be
existing reflogs in a repository, if one doesn't care about _reflogs_
there could be significant performance gains while migrating repos from
one backend to the other, while also leaving the reflogs behind. The
intent of the patch is not to be a detterrent for reflogs. The `git refs
migrate` command is not the pathway for that. Rather, the goal is to
ensure we skip them during migraiton because we do not want to bother
migrating them.

Saying this, another option is to have `git reflog drop` and then
perform the migration, but I think it does makes sense to provide users
with a fine-tuning during migration to allow them to choose what they
want to migrate.

I know that in GitLab we have repositories with millions of references
and while we generally have reflogs disabled. There could be
repositories with reflogs enabled during debugging or just old
repositories where reflogs always existed. Since migrating backends
blocks all operations on the repository, it would be vital to also
optimize it as much as possible.

Thanks,
Karthik

--00000000000089eaee062e0299dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d5ebce76c211c815_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ldHVkOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzlQREFDVldtMDVneEtWdnYvQmJKVUVSeG9Jckc0UgoydE9nQVN2SzRH
TmVENDhyQWROY21YSkJMYWNzVWdnMlZ1dUVIamQzTEI4dGprUWRibGFVQ0dkVG82SGxGZnFOCkNG
NkRmdHRKeGp5TEVBbmlYYzNZbVAvUzk3QmdsQXh6dkt0YjJiRG5uajUwT3ZWZVhVdVpqUllUd1Jq
T2RzWWMKajZtVUhTb29VOVdtTlFna2hqRGlhQitKRVUwaUZGMkMvb05XMHo4c0Z6UXBGeUtXSXN6
b3VuZVJNamx6ZDFZNgozaDZrVW1DWXg5YjhaeXFxTVBTM2tpTUxRVTBVMUZaK2tCdVNqNmM2ZjhT
aHNlS2lxRHFWMlFXN1RBVmNKVXJDCnA2UVN1ek5Bb0pPcWRCMUg1L3pyaTlqczZjOFJEcW5Na3M4
ZUxXMHNFUTc3b2FNa3N2dXpSSUYzTlBYUFBlZDIKVDlxMFo3SjZwR0s3SUpGd3RURFdHNE1VSjBF
S3VtSUpuNFB3QVcrdXRjUUlKbzc4dWF1ZVJjc2UyMUQ3VG9NVwpaYzhoNHltWlNWQ0NFZ0FZNXJt
ZU0rVmdJWkVUaUVObnRRT0ZFNDhZTGxzMTJnZm9XeENWUWJWcW80YjUzUlVRCjdhQUhNb21NcEpv
RmQ4Z3BIQjltYlQwRy9hUTI4elZOYzJJam5aVT0KPTU0NnoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000089eaee062e0299dc--
