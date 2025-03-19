Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF838212B02
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387736; cv=none; b=XrWYYIex7zEQjPgnhnb2AAe8KIguh4DeZVSZ48g4lKznAmPbQepzidqW8pTtN0VHqMsJAKENzFaz7AYrZ9zccX6Xt2dDuIl20jkUI6UjQvt0LpoXI4uCL3noyrz+lMIqPuGzzAYfwQLGZRAIiO0/GXklp833mRuZ3R48Z8+ak28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387736; c=relaxed/simple;
	bh=XTM59BcL/C9GZnEmWI5JXvIpYPE8WVSsSFf6s4S+kNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiMKRt4sIv1bzcphF4DUzZLEFkG7sadBRwX2f9sGr1KBIUxZABhl0iLRiTFXLFxoq0WQBQPcZHPWoScBmiDJB5vVqc3T3NuKDtE7/JeG/b8X+G/4NjwP0KQ0+6z6PLG/3wsEZNOwI4VnP0i1fmmi4A7vka3+OF8bs+tTBhtyucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fnxho5Mw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnxho5Mw"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso3098790a12.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742387732; x=1742992532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTavdg6rsC7kTTkEdfFNAkH7OBl1cZyzQAJnPPIZgy4=;
        b=Fnxho5MwZ/rkCE3Q+VNe80QNQ4JN5KaPawQk3XGeJtqCt0m3FnyzRQmOROXfDDZNI0
         uYlSXBRjqf58tTFSZ7eaosnN6Ysfmqqnmbn2j0gNLQSzo1lWlyqRdqSzW2qL18puyAxH
         cG99HsbS3wCAcRju5Tet207TMW29PEH2topDuVINVr5OjPrQ1TJyKXQOd2KT/7yvQBzm
         OepW7GZ8scWL6YUWapnrfhtQoHad9tjwbfYneiQYur8I5COL+FwCB/qWVFeQtn2g9TKy
         LR+6j8b8gHXUFGlEzAHM83TxRaNlt9mK0EOXAVeZgzDhz23vguYL+rwuK6rIcDNNlGri
         L49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742387732; x=1742992532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTavdg6rsC7kTTkEdfFNAkH7OBl1cZyzQAJnPPIZgy4=;
        b=qnM+SvVEa3RaZNgqdyhNQxBEwOrtGiJXtBs9oWKWdhle2f+a6F6NanRbI1cYD8+Jdy
         NVzvc/Gjpo6J6zAHzlRtNlUKOTPk8MutWyFFYL0IkArDbPB+iCx1Qd3qoy0EU4jDpBNV
         QiaZ/sUCpXabi4A1SFX2+/30u6Y88xMVlRGgjVuyAgk3QsoTQunbgmmzAhTgQT84RV4U
         aJQ+X8vfyVB97x8K0tKoh2gIE8Dk/N52BagX3HfZKRjx8AD/sWuujGVHZEVVaJ01Qs2r
         oS1iRILQ3HrU0xvsBfwJ4rY/MgvjI7ZRD2UD4aCHy+dcZ/wgiBI48rPajqEzWlalWAge
         cepw==
X-Gm-Message-State: AOJu0YzzdCS/jO3HThEuW9Idg7pZa0aqpdUUMOJcJ1UDJWwAeBbmma74
	7SvBF9DOxnWITwid1GikXM+QnD2EAV/9KxeR0yoJzeQIadsiic2aEZ8AIZFR8fwOYiBViAy67Iz
	2v9MLpQxSfTjSZZRRvuyjYlo1qNs=
X-Gm-Gg: ASbGnctLzBbnEkaQBBhUjcwrR+EEKxy/9pKTGCcx6HAc2KBEBoBnxxyra+zyaTlfMgZ
	vpCUkdkd2YJfjRwVZNHGqnXXis1XirNsBd91mJ5azorhKnYnsAKgu9eZciwP6Gjpp3fUjR3V0VP
	EuK0bPXQ7GRtxeEexcNFnhlrObFMZqXXitbs+iejxamwUzSfZGS903TUbF5A==
X-Google-Smtp-Source: AGHT+IEJp2lpXkuEQWzClHJNPXawrLNqjosRb4dWyDK7zgqBJvJyRA6gODhkdVkdgynng4LfC3u5IaTS1a19QsVCP7A=
X-Received: by 2002:a17:907:7fa6:b0:ac1:fab4:a83 with SMTP id
 a640c23a62f3a-ac3b7ddf808mr203069266b.25.1742387731747; Wed, 19 Mar 2025
 05:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313001706.3390502-1-jltobler@gmail.com> <20250313235747.9583-1-jltobler@gmail.com>
 <20250313235747.9583-5-jltobler@gmail.com>
In-Reply-To: <20250313235747.9583-5-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 19 Mar 2025 13:35:19 +0100
X-Gm-Features: AQ5f1Jq3SC2hJEY6732zVVMwyhqBkjlMe3VwZybAPjMsTLG2LTzs9WxhGA1DYNM
Message-ID: <CAP8UFD1JAkTESnEOP621uECvoFGFmQ8SRd372hPLDhNzALAN+A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] rev-list: support delimiting objects with NUL bytes
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, peff@peff.net, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:01=E2=80=AFAM Justin Tobler <jltobler@gmail.com> =
wrote:

> For now, the `--objects` and `--stdin` flag are the only options that
> can be used in combination with `-z`. In a subsequent commit,
> NUL-delimited support for other options is added. Other options that do
> not make sense with be used in combination with `-z` are rejected.

s/with be used/when used/

[...]

> +test_expect_success 'rev-list -z' '
> +       test_when_finished rm -rf repo &&
> +
> +       git init repo &&
> +       test_commit -C repo 1 &&
> +       test_commit -C repo 2 &&
> +
> +       oid1=3D$(git -C repo rev-parse HEAD) &&
> +       oid2=3D$(git -C repo rev-parse HEAD~) &&

It seems to me that HEAD is at commit 2 and HEAD~ at commit 1 instead
of the other way around.

It looks like there is the same issue in the test added in the next
patch ("[PATCH v3 5/6] rev-list: support NUL-delimited --boundary
option")

> +       printf "%s\0%s\0" "$oid1" "$oid2" >expect &&
> +       git -C repo rev-list -z HEAD >actual &&
> +
> +       test_cmp expect actual
> +'

Otherwise the whole patch series looks good to me.

Thanks.
