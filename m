Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D09C2C9
	for <git@vger.kernel.org>; Thu, 15 May 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308204; cv=none; b=HF318tfiQgf8ZAznFuTTwCncEgNTJbTWZ77bcimrEow++4xMZVfbDUKL1k8haD4rUQ7CA9g+LgLyvEco+Ih5J93jTefadNLDSxBRixJvYij3/QQmaz41yLX0o2HfwdIP9vLJ1DlhePBk5TJHy5wNRQhKKfWco6tybpY0FjCvD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308204; c=relaxed/simple;
	bh=lZB5CsJgZu5UOavg78Ebh8CcU2DwNio+hmIYWRYSv9U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+RuEi0AqabbxxYaLSB0EeYomPHvo7St21lD0k4nOLmqpHfDOIIyEl3pZBXiEzjQavcsRVSpzV8kfLzKDWO+CAabQNBujctzsZmM4yVew4Ed2582bE8N5MEdMGPfQSVywBgt/JmuxVYCMSRnH+ML/XiGu0RcJexc7tSE99kh/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT+ypC9z; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT+ypC9z"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-878af63c5eeso231168241.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308201; x=1747913001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z11sNEDqwz5o/PhVBfrde6O9qQG9YZxBItoaZXS4usU=;
        b=JT+ypC9z/La/YifLTtBCi5ZxB6v15//q158G8zqx4zX7qoRFtzzVZVNkqPQCyQa8lg
         7qO7MthXl2EJr9VDHVHsys6S1Id/98K6H/xu2W5boSNCSL5CbS2lN9ARU3N/U0Q6VNoe
         +pqZg2FAzG17McRiJ7Cir0nUPnzcyjIiSXjSjIsa4be8yE/Y2EXYBAJI28vvudoxChkl
         DLQuUleouILmDKy+ul6KCmE+T8BgEJUnjlzWc72kz5fW/3DD6X+VHd2Jr9Ai9LZQGdX4
         CIHuvhP+R8DWGsyK1XjCFSVsYCjMJ0FixB6I7ASS3e0E1AofX873G5MiHBri47AEvJkQ
         VM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308201; x=1747913001;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z11sNEDqwz5o/PhVBfrde6O9qQG9YZxBItoaZXS4usU=;
        b=DgkcRYP55JjcQqz6f4qYBgN1QnJ+KbAxpiDWIzADZFFjv0cyJSS0p09tJOY9U2pYLq
         ONU2ObHJyaJGGwXvxwn3f5O+tTnGCj3dkGYcL0SeiomgIR/mSLiTB1JhaIuVIub01jfU
         CK+E5SSk4ctXDThdWzh2UzM4uoLMlf8L5boJK2f7UrYUCp1h/ZwgvahZNi0xiIvLT56F
         v/MmRW/QHSbGSvAwsPDKud0h1u8kdbunK04A/ThpcDlhRPcVXoOSQRWG8LnzWJS9GazI
         Trr7MXZ7iJHKQ8UCXReklLG1vw8nbIoH6SI34ZBh2gdNKiwgeAzB/INba+VX9QR/oqab
         u+tg==
X-Gm-Message-State: AOJu0YwEQ8TXYsdoxG9hE6OWtMtmvLhyD4REwjTxbqzEr3bCE4yN9EPO
	e9ywo8cjO2x0TzBh23uAkOzD7YPTJXwYPg09cfGlF3/XUMqI5p0oQXsnUG8iVvPOY0m6XsVo6eo
	QMli0wyYyTfSqyV4ujIrzv782pVk=
X-Gm-Gg: ASbGncvDF/NQvV3TI25naT191E3mlwv2rvLrIcRBgCEQviXJJ8Tod8LNmHALqAOWt7m
	5PFPADmN+2ztzzsVj95xdhfQ5QAhQerL1jCakzRFqDVp1M/+kmB5NyLP/YsuX5hYodr4HMTM9Sy
	/ADpCshp9vu3Rd10MpTfcvH3UvPYSnU3g=
X-Google-Smtp-Source: AGHT+IFDV5+hWOZfZR0j2oGPkIY0eKfmffUsbzYeDzbOwO/cRgwbWF9QQ26beZeZh4ofumM9+wdz60XbnI3hpD2BnXQ=
X-Received: by 2002:a05:6122:200d:b0:52a:cdfb:7ff9 with SMTP id
 71dfb90a1353d-52d9c5c3b0amr6424027e0c.4.1747308201138; Thu, 15 May 2025
 04:23:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 04:23:20 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 04:23:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqikm39jbp.fsf@gitster.g>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-2-7c65f46493d4@gmail.com>
 <xmqqikm39jbp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 May 2025 04:23:20 -0700
X-Gm-Features: AX0GCFt6tlv0LBOL7KPLdhDvWMMPJRw6byW0oOISukYF_O8uoYY4k3n209_RiLc
Message-ID: <CAOLa=ZRA7ax5buMO-3MewzH7ZH7jddDYAVw8abrEkGYDvd6Vvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] send-pack: fix memory leak around duplicate refs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000a498dc06352ae4bf"

--000000000000a498dc06352ae4bf
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'git-send-pack(1)' allows users to push objects to a remote
>> repository and explicitly list the references to be pushed. The status
>> of each reference pushed is captured into a list mapped by refname.
>>
>> If a reference fails to be updated, its error message is captured in the
>> `ref->remote_status` field. While the command allows duplicate ref
>> inputs, the list of doesn't accommodate this behavior as a particular
>
> -ECANNOTPARSE around "the list of doesn't accommodate".
>

Indeed, a s/of// should make this readable.

>> refname is linked to a single `struct ref*` element. So if the user
>> inputs a reference twice like:
>>
>>   git send-pack remote.git A:foo B:foo
>>
>> where the user is trying to update the same reference 'foo' twice and
>> the reference fails to be updated, we first fill `ref->remote_status`
>> with error message for the input 'A:foo' then we override the same field
>> with the error message for 'B:foo'. This override happens without first
>> free'ing the previous value. Fix this leak.
>
> OK.  A natural question is what happens when A successfully updates
> and B fails, or A fails but B successfully updates (failing both is
> much less interesting).  What should happen in such cases is unclear
> but my gut feeling is that the last-one wins (which you implemented)
> is probably just as OK as the first-one gets retained (which might
> be less work at runtime), and perhaps keeping-the-more-severe-one
> might be more useful than either of these two, but I didn't think
> it through.
>

I think the whole thing reeks a little bit. We shouldn't allow such
duplicates in the first place. This is something we tackle in the next
patch, where any such duplicates fails all updates. This is a lot more
deterministic and also the error reporting to the user is inline with
what is actually done.

As of this patch, if there are duplicates, one success one failure,
means that the ref is updated once. But we report to the user that both
the refs failed to be updated as:

  $ git send-pack remote.git A:foo B:foo
  Enumerating objects: 3, done.
  Counting objects: 100% (3/3), done.
  Delta compression using up to 20 threads
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), 226 bytes | 226.00 KiB/s, done.
  Total 3 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
  remote: error: cannot lock ref 'refs/heads/foo': reference already exists
  To remote.git
   ! [remote rejected] A -> foo (failed to update ref)
   ! [remote failure]  B -> foo (remote failed to report status)

This is totally wrong, since we actually do update one of the refs.

> THanks.

--000000000000a498dc06352ae4bf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9a2b87f82977ce45_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbHpxWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWRPQy80OXZKbTlvRWw3RUZJak9TbkJqOUtZY2hpVAp4V2tJTWpvV1Bh
NG1VOFJ1di9zRU4xajRTSGxTRStJd1pqdTJ3V3A5clRxWW5jYjU2bzJ4ZFc3WWY2OSsyL0hvCmFF
VU1Ia3dQUkdiR0NFRGtnYUIvdmxHbjFsTSsxS2cyUGx5eHNGcDNRMUp5dnVIK2l4bVk4K2dsM2ky
dGVyTUMKZHh1dWY5OEVVcmhydVJDdTJxSlJTTFZ5NnhmUkhHU2JHWjNUZjhVcWlObWVxN3V5Wmx4
SnpuZUwyUHE0Tjh2ZAppdCtKeHlpZ0ZiRGpvYnVjcHZvMStPZE9Bc0hYMjY0cHZpeHZrMUxVSlp3
Nkw4dXNrM3U4cC9HOEZUem5DVm9TCm1WeUwyVkRYMDljMk83ejFJcXRnRXdMUERDYThlQkxhTmJ5
TGRjam1zZnRLS2g5UHRLVW5TbXlKOVlsU0paY1EKcWs2V1hPU3cvUWhaVDZSRE5BbGxkbHZFNHZD
d1FPNy9Ea3lDOWZSZEdmbFNNbndpTlRMa0FpV08yc29veW1uOApMZU9hTVVJZkFVR2cyV21vcmtT
cTQwb3RkanhzYStDUDZKT3A0U1N5Vy9DYW9UYjBJZ2RRckVnTHp3VUNWZmZLCnNTUG5yTE1xUXJt
Y2d0U25VWEk3RWhPeEd1ZHU0MHVLdkpmWk5xMD0KPXUraVUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a498dc06352ae4bf--
