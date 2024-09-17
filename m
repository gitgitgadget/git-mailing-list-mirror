Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD82200A3
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726595203; cv=none; b=PDIlti63oK+uqBDFwygvWfPQVk1dM3iGMh3i/ZtdqUxl8+msKtPrV1NgU3eypMUKsE14rapYbcpZj6etOtasWLgB9o4MwZ0KTzS+ENoZITK5h3oeCv4Zj+lbr5T0DLsCYQUE3jeKL/BwTXCaCjkzidUGDDbs+w/rDhlQpSZoKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726595203; c=relaxed/simple;
	bh=2DhD4LXp9S5WUp/8TPBfCka/pDubNd5iOudcG9Bh1v8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=l5OEieBnzRBmoWXgzbcOttmyaOdVROX0Xl83G+on81/d5WPoix5+RCjHmy2WsT0W8dV+GKzh9m5jIyjxCvx2PSa0a0Ic9JjR6qxi8DvedamWosWhlM8WqczfUEXVy6VnlOApcaJb5BJr2mo19NLGyc8kSrgk+mqRlWe8ZDsh3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWM8nRTV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWM8nRTV"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71798661a52so4509569b3a.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726595202; x=1727200002; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCgvO+MwFs0XFVjyyJJNw89//oWiD0NjkxUFHO8YsTA=;
        b=EWM8nRTVQG7ODHz+wBoP/vtfDoeRVjs7fF+Y5WpEuZ/XLQC9uADhoVnTFGe5u1geAE
         y4q0ktBFQcjNzXxXtGn+36t1UPQRw7FMSD4q9s2A7guC0Lkp8bjkTDmSrpCBQPzhHHPi
         IHou2CNrVbffvgILG9fbqHhnAm/bof+EGY5X3MwqPDkbyfGoT/fIOK9eNdgDjXnTpprs
         mBXSIgVjjg5X99F4k/Hkps6zncRuKz3+yJDkKE8OqQcJWI+sdKj0PkgwhRO3wAdqz9Aq
         Bb1lr9VZb0hs1VJGX0Rq510RXprkNhmY1Z4bgVu4zTCYJjFDQph6+rMCjHh5EwNK9f1r
         6QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726595202; x=1727200002;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCgvO+MwFs0XFVjyyJJNw89//oWiD0NjkxUFHO8YsTA=;
        b=v2PikoSuYlNY4Wr+6KQK+uAIwOF1nlOGDvPMBUdZQF2LSgq8sHXtGCZazwK+tXIToF
         ZxdeYOSHtOqdn3gPUiz0at/jxnBNRDrpTBNR5WL2Zq2qmKNh7dZznuWxP1jg8eteoQsd
         jrkoLFhFT851j6UR+gU6AR3bz+fiH9y+0bGybc46d+Iay88qFIpFqIfVktNAjulR0y7d
         1IexzbGQFLqy9cMHFKgl7PpEkMc2+OvrenAyXSxRk04OhbcWuO71l6JCVW8KwKgrfWOy
         XZ2qvJIj7h/YGbJW7RJUMW4A/6aPGJLw4FnL2xVINCttZQM2rMCJj1vk9TEKzd6KcE0T
         JFMw==
X-Forwarded-Encrypted: i=1; AJvYcCUucr5iNlb+Aei2YPRximgvbH4uutfIJM2M4nIU7Hi0Mfk+s1zvMrDPdynlLoV/ACUHTnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4CGA5hPexalHv+yY2eJNWGURee2UrGH++aU3gCczVjLR5aXjm
	6KW+6xiwt56fbiSiH/IqGM1feozj71RSMOlQodUBTSViQEwtKdFyFPsDJICFSPHDFqg33vqUbF9
	P6GlmgGoWoA0sI9GCXcHXxuq+iNIJTx7x/YU=
X-Google-Smtp-Source: AGHT+IEavppP31MTjrtNkPWreWafZMxr8RUQauJ5UX76gtHjYZEaD1nwXdkC1OM81S51Squ8A+qEonrD/JIXMIytr3A=
X-Received: by 2002:a05:6a00:3d14:b0:70d:2a1b:422c with SMTP id
 d2e1a72fcca58-719263ea9d0mr31185783b3a.7.1726595201485; Tue, 17 Sep 2024
 10:46:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Sep 2024 13:46:39 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ca3eab99f7ef86d1b7a5b4d4bdb8d2b0a55566e1.1726578382.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im> <ca3eab99f7ef86d1b7a5b4d4bdb8d2b0a55566e1.1726578382.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 13:46:39 -0400
Message-ID: <CAOLa=ZTja-nFmKZ8iyyp0szuaAWAnPncy0E6rM5=WWgnr=01uA@mail.gmail.com>
Subject: Re: [PATCH 1/3] refs/reftable: introduce "reftable.lockTimeout"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a7f06d062254454d"

--000000000000a7f06d062254454d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> +reftable.lockTimeout::
> +	Whenever the reftable backend appends a new table to the stack, it has
> +	to lock the central "tables.list" file before updating it. This config
> +	controls how long the process will wait to acquire the lock in case
> +	another process has already acquired it. Default is 1000 (i.e., retry
> +	for 1 second).

Isn't the default 100ms? As that was what was mentioned in the commit
message

[snip]

> +test_expect_success 'ref transaction: retry acquiring tables.list lock' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		LOCK=.git/reftable/tables.list.lock &&
> +		>$LOCK &&
> +		{
> +			( sleep 1 && rm -f $LOCK ) &
> +		} &&
> +		git -c reftable.lockTimeout=5000 update-ref refs/heads/branch HEAD
> +	)
> +'

Nit: This does stall the test for 1s. Which is slightly annoying when
running single tests locally. Couldn't we achieve this by doing `sleep
0.1`?

--000000000000a7f06d062254454d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 469625e60c5ef190_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1icHdIZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWFUQy8wZjUxUVRvSjBsRG9KbjVlUmZ3TTk2UnZCYwpOc0xjL1M2eDJn
eWZ2UzVLajZWRXhOdEdlT1VWUE1KYzAwWnFHTXZwQTZRSGVoUCs0cEtLSHNxMUdyY21PckF1CkZC
SWY2c2xMcXV5aHd6OGhtMWJjRHJERVU3VDhGZEdLcHk0d1FBQzhoT2pNZmY2K1l2SjhMelhxNXhT
TytyTXQKbDBlOEhFQWV3WVh1QUZXeGdrc2xCUGw2dllVR3F1ZE5FNUt0Z0h2SEZDWHBxZXNtTndQ
VUt6b29ROHlKTTFvegpKVUZIOHhKNnVqdjJMVEpvSGhuZW5hVzFHODU5cU92NDU3QTd2SzZTWS80
V2hWd2N1d2xtVk1NbHJObG1wUWNPCnQvY2Q4dDZqWTV2QTJYQkN3UTZ2R1E1Z2lKeUpVUERHMzJ3
MW92WmR2d3JMQUZ1bUM5SFpiaGQ1blpjSHJLY1gKQXdKY2hKR2JKUHZLZW9sbERDSTZDcGxHU1BG
WVlVMHZaSzlpanpGOGJZMzhrMVA3TSt6clkvZE1FZk9QNU5TdwpXb3FsMGM2WC9HUWxFdENWNHVU
cUd5MFo4aXVWVDBBNUdubnk2cHNrYXg2NkNQenQ5Z2gzUXhMR3JyVExNR3lkCjBHT3Rjdk5Wb05P
ckF6WVc0KzlmTVRkZ0U0Rjl3UFpFcWUzUW0ycz0KPU5HZ2QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a7f06d062254454d--
