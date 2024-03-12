Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCC142636
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281769; cv=none; b=ge0/gjJZmsIivDQGEPb/chuV9J7WmWJG0e7AvxvhslU9Gp9/mCJXR/6dth9QMurE5TAn0a2u3UpB7wbPWrrQjhA9YYgRGwYeTusHoBQ1IMml3Fmu7D+sGSgK5tNXrcWrznu+lGUTCpS5jv8vC2MSAUhBbv8IjWN9uHNqQp+vVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281769; c=relaxed/simple;
	bh=NCKCpazDQ1xYvbsNa9a6+JodWMnPzWSZjtuR6tMilKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIFUmtLaaU0hwp1wbUGN4prUQQIfx5I4Jk1525HvZkcemAEYLgYnKdDlQb/jtKUqvG7Tnq4TJkuimgwnKtUBA8pJ3InLHEftlWABS/9li12uKGeHF7gyupKt1Rvcgv7DEIUZiFRC13xbghv8UsI3RuO10E4xMCDloU0Uw8ZFT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eu+yjRsR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eu+yjRsR"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56840d872aeso4731170a12.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710281766; x=1710886566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+ivbbbCl6zYtzMAtSZ6IZy7W7ZXKKjxeFX2f9wLi7g=;
        b=Eu+yjRsRBA9mjnBaYxjzDy5oIY0O+Da0abn9hjdBNumfigDO3LX7RMguMwzwgNmvWi
         O/0fnDE27VDIQx2w6hL6cKJ1hH4eVKp3JaH5vAyOZoJVFrhFSNKf+H0LMco+gajInBW3
         cjdjaG7dudAHpXsG6uATsWzT2C9IoM9oIS82FsBLKMEX+iT/UN8qu9x70dExN7M8ebAV
         m67re96ExnxLqK9SwiOgoXtnDbzQaBVcGzuXktsi/FQQs5L8uQ3IUqOT0frey0tHRIot
         VruFTLJRmpnrKKLUuomSKSUBJeARoohBGm9+NyJc+PPuHLapkHfVP68UjXsalhpB0bAJ
         Wx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281766; x=1710886566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+ivbbbCl6zYtzMAtSZ6IZy7W7ZXKKjxeFX2f9wLi7g=;
        b=KcbTIApTIjHrrzxEYBnByAtAHDs9lLt+oI4cPDrypHmqSaljLjb0Cnkpn4SU7XKVq9
         kRtYwkZN3f5tHGqBWjSfHnXzrPLMsCO8yldhlGJ4c6YzBP56gPaj8HNcdxYyDgEKMegk
         xmaGgu+YgvzVIdIHGeDuUbOaCFA5P0b5gUHo9hURIPWXNi3IB9v/u2Gyua1SSOZb6Wng
         W/KkozG7eqxCPpWD4PrUt+p53BFWmw0GPGJ6qPHueM52/vuIuXeDm3OiiSvCApoTOKpT
         abWinKUFpiALeArAyU8EW64I021SnqkAdSR6oujOmzS8wH7kIfqOZahI7+pisJV9qxA+
         1HrA==
X-Gm-Message-State: AOJu0YzbHZU9UG2NHHSUuTt5WXa2fbgNDvqThWkFDYu+YQjYLZVDa+ly
	i0Zv3yAP5M6tTbxcmckAk7XkjpKCSvEFOpLWqQAR7GPC3I3TZBBSnmUPMpuEpfmvPvxlYKLHcOI
	0SDzDQKXXbeUuDblXbuUnUIcQGxUGM81yegTP
X-Google-Smtp-Source: AGHT+IHNj9tkMBG933DT+ZN+XjPXgjwflF1z+0bmv5mVQEuLrw1vrN8Wjk87eHQCcbmiGSuaaDkzPsr+kMd6miuGMOY=
X-Received: by 2002:a17:907:d389:b0:a45:92c4:7892 with SMTP id
 vh9-20020a170907d38900b00a4592c47892mr8913946ejc.56.1710281766328; Tue, 12
 Mar 2024 15:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305012112.1598053-2-atneya@google.com> <20240305012112.1598053-4-atneya@google.com>
 <xmqqwmqg38u2.fsf@gitster.g>
In-Reply-To: <xmqqwmqg38u2.fsf@gitster.g>
From: Atneya Nair <atneya@google.com>
Date: Tue, 12 Mar 2024 15:15:29 -0700
Message-ID: <CA+D9mTHD6iwXuSdgAg1JZHYu1s0G6y8Kgv07V_JUkKU2Kcm_vA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] Make ce_compare_gitlink thread-safe
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jeffhost@microsoft.com, me@ttaylorr.com, 
	nasamuffin@google.com, Tanay Abhra <tanayabh@gmail.com>, Glen Choo <glencbz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 9:08=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Atneya Nair <atneya@google.com> writes:
>
> > To enable parallel update of the read cache for submodules,
> > ce_compare_gitlink must be thread safe (for different objects).
> >
> > Remove string interning in do_config_from (called from
> > repo_submodule_init) and add locking around accessing the ref_store_map=
.
>
> This step does two independent things, even though they may have
> dependencies, i.e., for one to be a solution for the problem it is
> tackling, the other may have to be there already.  E.g., even after
> calls to ce_compare_gitlink() get serialized via a mutex, it may for
> some reason not work without giving each kvi.filename its own copy
> [*], and if that is the case, you may need to have the "stop
> interning" step in a single patch with its own justification, and
> then "have mutex around ref_store calls" patch has to come after it.
>

What is the appropriate way to split an intermediate patch into two? Simply
adding the additional commit as 3 of 4 would cause a mismatch between patch=
-set
versions? Would that cause any issues?
