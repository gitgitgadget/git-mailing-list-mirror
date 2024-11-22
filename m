Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAF1DDA32
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298142; cv=none; b=m0bKbDAHlogQc+CZ9UGgT6X/BdS2Qhohf1zTRUhsC+4GmhaLOoBNV7EUrQgyRtBWs2kVF8LASl+AzQQWeEYk/sH+52yymFp2tR7f1BZnja7eB2InHwvjhakxYCd3nuegiTCIf9NuDuX03yIQA1uVe1akoXu/ZW5PQgOlxWKNvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298142; c=relaxed/simple;
	bh=ywuUuiyJMffkQRM6TU050IKQThctadjoqTdrdYw9kXg=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=DWJzZHa+Ci/CSy6sr8DHO1ZMousq0287EPEDE4s6dZsOywkfovoXeVFtIvlfSYlAgxvRmffcpGUNTpYe0VarQh2NNYmksnrBPX7exSP/Zk8XURCW3mT4ukXoqh2Vjs4Jk7IIC2vFdP9Ha4l/xA+6ypgIFnFzcFgQDY5hbhdxiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGPn5dD9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGPn5dD9"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eeb889aeecso38708217b3.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732298139; x=1732902939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+F6eDLtOGnOquw8q6ypMpMe71OzaPkB6WzOiMvL6bxk=;
        b=EGPn5dD9b+J+nRfRorXrNHpT532g2VzSnaRvsM8sH0fthxAduAsKWPAvstfFsyavsJ
         ev1IDnXN6qmOAvlk+vFXI8uqk5M2K7wfWdRFwlSFtX5KPtyP6eqzb4CwOOLW8GnQK0Iq
         hOoLfbu9c9q6JsmgBC085BvOcozxZTkCtnDJsBmNTJVIrFZdUskaYDEVDcA2hu0NgvAE
         FDrWuvo+An3fjCvs3GtVwktFoCCpwybmmpDWU6lggRVPKesku0TfQ8n9jVuqq+2/SVI1
         lUSlj7ImIJyR4Hd3aitagz9yygEC/fvG8h8eqJ4PsrLtmKixvDZzbsFjLZC4WX5t4rtx
         +5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298139; x=1732902939;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+F6eDLtOGnOquw8q6ypMpMe71OzaPkB6WzOiMvL6bxk=;
        b=ncJbYq6UOQGPNEk5zj8TidUYfhn0usJw9EyxcH4725UTrfh0wi3i2Ds1pkVHeuhct4
         uv2DR+L0R++VzndDMzT0CJAxLYLl2M4P2rP+QNmkDvbbT5josOzemhaq4FCQEtY+WB4q
         cLLBL/mIVBzXKZOZY533NV+e3ujVXWA0j5ip8i8YsGuNG0sSPQV8NUe7CPWOEOd60pmc
         38sZabBNIgVgxYrlqvRNEGconF/ADwX+udul6TWf6ljEdvWDMt8PgsM9gU3C0bUvwTHu
         hmeZJoSqZWskOTHNRlztu9XC2RHfqfcWeRl8UEDHZX3DDEkmoxWgmTI10HIdXw05qosQ
         kfZw==
X-Forwarded-Encrypted: i=1; AJvYcCV6QJAdBjv2WjbgICKaPQNX1xIZDrRMoeCS9gkIKbeRGXSB16Z4j2cqYaLJo/3dga1NuhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDalv4yxtgnVcv/NhNbiuHZ4DO7Gd1HRPBDSCZg2j9aQrCS6hM
	CTHgT1WQ5mCQiUPKJ48npbJeIkpRy7eQ7nAaFKaGnYt6feLwtUuCWPrrpFkckbhZQwY94e2Moqr
	aZ4gpt8oI27VflWvjpDAIMeACFeNqpA==
X-Google-Smtp-Source: AGHT+IGymTl7UuqNwqi1laPbKdEDS9KSUC6lMjM3gJ3LNf3QKFTrPTPDcbMa/Cf16I1UtkmfwfsXztSZtjVgE/iUUZDR
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:570a:a451:c8a3:c7d1])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:b83:b0:62c:f976:a763 with
 SMTP id 00721157ae682-6eee08afffbmr430107b3.1.1732298139457; Fri, 22 Nov 2024
 09:55:39 -0800 (PST)
Date: Fri, 22 Nov 2024 09:55:35 -0800
In-Reply-To: <dd8b5cdb-2ce8-4ad6-ae96-197fa898b206@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122175536.510952-1-jonathantanmy@google.com>
Subject: Re: [External] Re: git-blame extremely slow in partial clones due to
 serial object fetching
From: Jonathan Tan <jonathantanmy@google.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Junio C Hamano <gitster@pobox.com>, 
	Han Young <hanyang.tony@bytedance.com>, Burke Libbey <burke.libbey@shopify.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
>=20
>=20
> On 22/11/24 1:59 pm, Junio C Hamano wrote:
> > Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
> >=20
> >> Junio =E2=80=94=C2=A0would it make sense to add an option (and config)=
 for `git
> >> blame` that limits how far back it looks for fetching blobs?
> >=20
> > No, I do not think it would.
> >=20
> > What would our workaround for the next one when people say "oh, 'git
> > log -p' fetches blobs on demand and latency kills me"?  Yet another
> > such an option only for 'git log'?
> >=20
>=20
> I'm guessing `git log` already provides options to limit history using=20
> `-n` or `--since` so ideally its not unbounded if you use those, unlike=
=20
> with `git blame`?

`git blame` also has options. See "SPECIFYING RANGES" in its man page,
which teaches you how to specify revision ranges (and also line ranges,
but that is not relevant here).

> I understand our concerns regarding adding new config options though.=20
> Between the solutions discussed in this thread =E2=80=94 batching, adding=
 server=20
> side support, (or another) =E2=80=94 what do you think could be a good tr=
ack to=20
> pursue here because this makes using `git blame` on larger partially=20
> cloned repos a possible footgun.

Typically questions like this should be answered by the person who is
actually going to pursue the track. If you'd like to pursue a track but
don't know which to pursue, maybe start with what you believe the best
solution to be. It seems that you think that limiting either the number
of blobs fetched or the time range of the commits to be considered is
best, so maybe you could try one of them.

Limiting the time range is already possible, so I'll provide my ideas
aboult limiting the number of blobs fetched. You can detect when
a blob is missing (and therefore needs to be fetched) by a flag in
oid_object_info_extended() (or use has_object()), so you can count the
number of blobs fetched as the blame is being run. My biggest concern
is that there is no good limit - I suspect that for a file that is
extensively changed, 10 blobs is too few and you'll need something like
50 blobs. But 50 blobs means 50 RTTs, which also might be too much for
an end user. But in any case, you know your users' needs better than
we do.
