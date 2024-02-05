Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11318E00
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133175; cv=none; b=ThZ+6iVp3kbvHyLWw6YA65twIqQsjlpD4MdXgkorgbnGOHJ9CKyUCX5vslLmCIDjfuGVBDeLyz5J8t+QVDTjZnD2k3tyL3QRlme5xvqqwf+w0mMqFMaVWYu+RnIv14b6DktaRk/tk7sNgWGweR2tfwK/vFTLKYEsZleMdwubfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133175; c=relaxed/simple;
	bh=ufAfwzYrGvcJmYxSmfswkaxzlZUVpsucacyx7tD+LtI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOqaoy0SUdFOQ4VXrgJEI45ImFElNXKJjLTtG4PleNgfGMc/xOhjuvj/ZGTgelD9GZO5o6UKIelHmiKQ3mbBmVLRKMcytBjb/SAgUOXXkEtJJcBVQTEzP72h0RLluph1++eVDvZy5VK+RY726Imzi1zWV/y2+hOp7VqTfCgdYFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4QJ+c8y; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4QJ+c8y"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e271dcd738so1890125a34.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 03:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707133172; x=1707737972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dprEaXDoP7CRyVJfGFscY/XxKG/GVoGzYAe4uhgWKz8=;
        b=e4QJ+c8yEnMXHEcdaBbC2wMGMctHYbhLBPEMbKX6WE/5Rb5/WxcbdVYtzHDT4P1T5k
         3fj7ISq5O0VC47nFqUL7fC0z41cvRcye+LoK8ngz2GoBgJgmkpc0oHAtzonYfa0dQSjY
         MsyD+jsR3wu24oE7eI87alMJHYMT3eQ/78fvtT0tNGAten7BHw+lRykK5YrBJDBM+Fqt
         PhJ6rxAOIiuaK8Y6ooofX0zk8jaKFhupfIVh3lrctwkmoSIJcV86iVBzZXZKRDRM7MVS
         4Ramt1FIFSIW1jjfgOBhFJjAogaegk+bzJdVs4Mz3n6am3NiwJ5m875f8aLA3sALBJlL
         LKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707133172; x=1707737972;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dprEaXDoP7CRyVJfGFscY/XxKG/GVoGzYAe4uhgWKz8=;
        b=TslBIF1lhfW1REioArw3XGMiN+q0cmf7JMWZv7WGyl0tH2QUXf7CaaUBTd+LEYQj9X
         Age3HM19DNON6f8LERnKmE8r1XyGKOa8YWrEPU4g8Eg4PupyigiWYJQv/kDVCKWVEPq4
         1gnfy4saBiLvaAIovsAlgfI4vNxMUuwcqhHjtRJsYDw8dcP2TKHqaQwptf0VQK6K96HL
         yvrIezZKKEdOF4EaGvIdXYqdXnNeL775zx0WhHUQq0QIZ5c823aY8curYe9rqHI32VC0
         FGV+JU2cvZ+2ALzSl7fK3Bgrr09Q+PaEksiMEl8wepeb6Dq5kanExBn3fXpuYpy/wfca
         tSUg==
X-Gm-Message-State: AOJu0Yz5aRfNr4G09Ex1iTbhFkXNbFCVYn1iLsNvFs1P9AJiWlhRLogn
	UQTKQdpFWIABaeyBGeWeOKhCs0lxjOJWA7iciD6fhDea8CiAt/FaIA91D0AfJ0eV1E/+WK4P+Fh
	tX4gzuyToJkSt8KH9nOWXdB/uTbY=
X-Google-Smtp-Source: AGHT+IFCN2muYzk4DjDBivGP5pUeg91fib3eFJ0WvzlpM0zPIA7kirih0kvgWodMQ9pYez9c1gWqOLCBT/HVciP4ZLQ=
X-Received: by 2002:a05:6870:d1c8:b0:219:10ee:8c19 with SMTP id
 b8-20020a056870d1c800b0021910ee8c19mr7076391oac.54.1707133172481; Mon, 05 Feb
 2024 03:39:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Feb 2024 03:39:31 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <f1d21904892153c74d22e4fc814aedfafcb28f41.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im> <cover.1704262787.git.ps@pks.im> <f1d21904892153c74d22e4fc814aedfafcb28f41.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Feb 2024 03:39:31 -0800
Message-ID: <CAOLa=ZQk_SocUWkoTgJuKyyGWVU85gtw+=8o1ffgBQmh5dQnqQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] reftable/record: store "val1" hashes as static arrays
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000005494440610a0ea8d"

--0000000000005494440610a0ea8d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When reading ref records of type "val1", we store its object ID in an
> allocated array. This results in an additional allocation for every
> single ref record we read, which is rather inefficient especially when
> iterating over refs.
>
> Refactor the code to instead use an embedded array of `GIT_MAX_RAWSZ`
> bytes. While this means that `struct ref_record` is bigger now, we
> typically do not store all refs in an array anyway and instead only
> handle a limited number of records at the same point in time.
>
> Using `git show-ref --quiet` in a repository with ~350k refs this leads
> to a significant drop in allocations. Before:
>
>     HEAP SUMMARY:
>         in use at exit: 21,098 bytes in 192 blocks
>       total heap usage: 2,116,683 allocs, 2,116,491 frees, 76,098,060 bytes allocated
>
> After:
>
>     HEAP SUMMARY:
>         in use at exit: 21,098 bytes in 192 blocks
>       total heap usage: 1,419,031 allocs, 1,418,839 frees, 62,145,036 bytes allocated

Curious, did you also do perf benchmarking on this?

--0000000000005494440610a0ea8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3b1b8174e9e7eeee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YQXlPOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWdEQy93TzVLanRpNnVWQURMVE9MMktYSVkrbm8wcApIZVovU1UyMndp
MDBEY0tPeTdVL3NQeVAyOTUzb24xVk4vandNR0owWkJCeEZuVlA1RllraDJPZWlQcjhtYmJvCklV
Tk1RQ29mOWUxVHd3cER3R1REcDNnbDJzN2lMWXBaWWtmZ0wwSDVYanI4QVZOdjU1alJodDJac1FJ
anRkWUIKcTBPTkhmM1g3MXVqaHlveDREeUxqVTNkNjlUb1NhenFaa3R2c21sbnp3eVJWRE1yZ2ll
YW5vSzZZcGpJWGo1VAp3M1B6VWxURmlueWRhZjFKRzVleW9DRTNvWlRWV1c0SWNaVFRPWTBQQVJT
bytWTE5XazZXL0tYdDN0NGRDV1Z4CjdNK2o0OE90Nk9jTk5tUGI3MHpwc0FVNVdXc0QxbWRqcVBz
aC9YVVEzTmtNNE41THZmYlhGK01oZ0E4MS9iWVgKT2xaUmNjNGRLdmxmbHM4ZjJEZ29NWElHb3p0
TXJtbURoZWpjVmJ3UzBiMlVXSUVpekhROUZrN3RxL01SakV2dwp3OUJHRi9kT0pQcmI0WmFZZFhr
elIzUStzRHVsYVNsSmNGOGpPOHh3T21BZWljTHk5UG43QzhMUEowSmVnTGFaClZsdldhczRUd3FH
TzVnTHpGWS92cDJyL3NvKy8vK0JGZFhsaUZvST0KPXRCeUIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005494440610a0ea8d--
