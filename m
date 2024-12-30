Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1D18784A
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735601135; cv=none; b=KVdI3H5cmtInU5QCtaSHpsxItvGZeVLAYpwA97o6eQmxlt0UAUXq1f3f72rzhr+XTeH1AIN7Htd6+VdFNBS6HUjG9nKyzYk7l+XByOhMpQsOKaoO3Pwj/JNpkjLlDIrwX1kZbjXfdAIhLthNSajcHZnm9P3SiKNT3i4pjsTmVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735601135; c=relaxed/simple;
	bh=M0nYWWU0lk9hB1oIGwMn8fbJNbhSrbNdRqLi1kP87iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3NXvacGyNv4rH1YnNoA/nI3aJxY1jTes3d10eAcIsDsFOjEVm/5B8J5faCr76qlMGmBp4fwSYumRlQsCRHNLlMx/JVY9RWy5eGkweKkHtzs3rPUZ51lfPZIL+YyRbfv6qXtu2XsS1eJRinSPXzDdtdGm8UUu1JCkAmEsuPVejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxW536GY; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxW536GY"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so10492455276.0
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 15:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735601132; x=1736205932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdEAA/lndBTf06Tg0M6JZ7tCOBw/waICJCNxEgbp44E=;
        b=mxW536GYgXRChqfANh/eRjYdR117Mq8yrHjda7VPkREGir8w8Fw5CmyTqHbRwwERX5
         rvNDxdaYygvAy/jElHVoDYMBhWONMQCxWppfjbN+y9gDg+Ne8wROIWDN5Hp6cioAWK4J
         oaE7teWrvU4EhJuYqVz/Pzese7KtPMPDdnr3kPYVL8SOk+yjWM6aJX9BwIN4UGg6sl/0
         DokF0IxeXEOpzkvasbRiv+0tZchwnlN8Dyl0bsW0UHpLNpwJL26LMXjHTzFPoPPkb4JY
         7CUmrbZ51tkQiuGiqBbnOpntAOQK7zfrSGv3EOf32iZLG/vH2HUDLItqaHGnNqSY73c6
         yDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735601132; x=1736205932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdEAA/lndBTf06Tg0M6JZ7tCOBw/waICJCNxEgbp44E=;
        b=WONPL4anwItSqj50sZM7kE3lBHmlTb+Xw+bloApx0hyS2tgO1Xw/DOIOmS/duNsPoI
         y5rpm8SS5g68DhmdSXB/Kim5l4mRXUMUmTOHfWvQaq/dYqh2flT97PrzetvQlaf7MqWi
         g0Q9CSk4NVxmlpXs4kEgqcXB+7R7xIiMAhCNkSGhamTi82BPO1GE55GA9r3Q97HcFV5z
         hQ+qvZ8eAax/zPzPK1TAoVowqPBMDESTSwIIMD5U5C1hIWo0LIkezdtCSsskIWyeu63K
         8Rbf5+e1mUd9pYnEfq/t8sA0Bo6Yhh2xYMbaYBbT28VmfU4jbTrNatGE5GB9d+qJ6zEd
         4RKw==
X-Gm-Message-State: AOJu0YzeBTCxU8DiE+lOKAi4pSX9r5vaQQTGu7M4j1d4QkVm8o9Pmskl
	8lzPUTheo+7UrzjR6zeGB++UlYRhvVLUY17rVSyE2SKUbmOF+eHSyZ5P/0uW6cihzrhW5qHicsB
	amFOdkiAhZKZmCqnW0QHOk8VrWHY=
X-Gm-Gg: ASbGnct4ARI3RE2amHnYsvzQ8IR4MGKW8FvSLIGgnvkqNLfJn5MOf5BfJSD6rM5aXzL
	JtyE3TUva48c87t/Pl4To5Ls4cfGemC1GbYayJrfW
X-Google-Smtp-Source: AGHT+IGoissAGsv0CnrRXz+KYoQCTlq4hQWpuoi96H6wx/EthSydo2ONLDt/ixdcqntRo5B5aCTpP1rlWoL5YnvkrP4=
X-Received: by 2002:a05:690c:6487:b0:6ef:6d37:181d with SMTP id
 00721157ae682-6f3f80d59b9mr291799297b3.8.1735601132632; Mon, 30 Dec 2024
 15:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241223232523.76236-1-eric.peijian@gmail.com> <xmqqpllew1k6.fsf@gitster.g>
In-Reply-To: <xmqqpllew1k6.fsf@gitster.g>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 30 Dec 2024 19:25:21 -0400
Message-ID: <CAN2LT1Dx5TK208Tc_-XRyysE_Et+0M6C4kvqCPzjUvKUt5a_mg@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] add remote-object-info to batch-command
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the noise. I forgot to CC others, so I am resending it.

On Thu, Dec 26, 2024 at 5:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> > Range-diff against v7:
> > -:  ---------- > 1:  c09e21a9d6 cat-file: add declaration of variable i=
 inside its for loop
> > -:  ---------- > 2:  ed04a4a7c4 fetch-pack: refactor packet writing
> > -:  ---------- > 3:  bc52c4f80c fetch-pack: move fetch initialization
> > -:  ---------- > 4:  4c1b989c41 serve: advertise object-info feature
> > -:  ---------- > 5:  dbc95a9ae5 transport: add client support for objec=
t-info
> > -:  ---------- > 6:  f244ec8a2f cat-file: add remote-object-info to bat=
ch-command
>
> This is curious.  Did you compare the right things?
>


Thank you.

I think I may compare it wrong.

>     --
>     2.47.0
>
>     Information Footer:
>     base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
>     Merge Request: https://gitlab.com/gitlab-org/git/-/merge_requests/168
>
> If the base-commit information is relevant, please do not write it
> below the "signature" like (i.e. a line that consists only of
> dash-dash-space near the end of the message), as some e-mail programs
> consider them irrelevant and omit from quoting.
>

Roger that.

> I tried to apply them on top of 8f8d6eee (The seventh batch,
> 2024-11-01) but the last step [6/6] fails to apply (the first five
> applied cleanly, and matched what I already had).
>
> Could you help to figure out what is going wrong on your end?
>

Should I resend v8 or send a v9 instead?

> Thanks.
