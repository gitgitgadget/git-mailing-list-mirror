Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FD17A2EA
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326363; cv=none; b=Leoe4znX/EIWJ633Q2dsyrTYyxw+KPFlaLww0zCSn++Jsr9ndecpgpLxsjxep/INUhdzO8XlwexsvwZkPxUj8trfngDbCKQweMMHewOBYhN2L4rud8oB3sNlJW8xshquT1vr+O0GnGVReARi1g7Vijz2h8AhPHPfviQwwVJjyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326363; c=relaxed/simple;
	bh=kUw5ZR0n0LCtboQ7A0XM8RjLkAsH+I/wRXv4S0YmQNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cV5YmeCdfOYv1+S9c3WUfGuRq4yRgo3YpkwR6J3KrvNOwf/vsXnPOiBKJzho/+kOfSiWZh2iLO9Q6Q/rRAC2avo/FBF/XG1LagMo5LSzhxOrQ6RFMyi+qVQAhOq5uCwrjQZuheDa2nFDUgclBr4Aw5G5896wLx2NE9kmgE1yoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSM8wLGu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSM8wLGu"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2680cf68265so19915325ad.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 16:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758326361; x=1758931161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFiSvaVh4gMhhkuhm9FwjzgJ9iDIGrDx9TdNMrQK6pY=;
        b=VSM8wLGugrOz4QM2ENUhdNbm01wk9o+7c5Zr1R48hKn+84Eig1qo9pLx0zbv6ajqOR
         u2KtwG8U29PooqVYmLqHaBGx8DfnCybfVZZJU0Eph8IUigb8lWUKcK+T9Wzf/QAMyGSn
         m79g8Ol8XrvPwzue7iPHL58zNJ4auKa/w3MZXdX6CkCp8A+q2gmeKc6OHuTWy4y8a0F0
         asZKo1V73ezkVmRlpGWKX+I+kubiZ/jdC/xgCVyyBz3s6ZSFPCh8F+4JFmjf8N990dsy
         oric4EvRjC3/2JNfYCjCnkViniRzByTSLyEATBrb0u2JQfxbWGzzsQRliW3St6x5pnFL
         M9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758326361; x=1758931161;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFiSvaVh4gMhhkuhm9FwjzgJ9iDIGrDx9TdNMrQK6pY=;
        b=E2py5z13AWw1MVdTtJdYu0Sjf82lLV1ed/g7qZRYaoR/OY8dxmr00GR9MF0D1uT6pB
         yycLuLSGR2JpFcAD8WNFLiyNejBTX90tXXJbfHOg8nmDVY6cnKkm9/CzxkXIu2v2Zs9+
         SQ8Xlh+VKHaa+rg/0Ks7I/vlY0i0gxhnAvQTe5irGpwKQsSeKRJO4SmyaYeBa1HPqlkK
         nL12ExBNWdDUuWOjdlwGYgsfHOlTx5yDgPNWv0LcfGKMy8TDbwXmk8cA7WCrHnbvo10S
         v1enWRA+MtjCscD4P7UjQoU4qK8fsLEtdq3kFh4P4PwXEWX38AseRPh7lypkJo/HboKl
         4p9A==
X-Forwarded-Encrypted: i=1; AJvYcCU8N9Tbnbv6O427MC4Jdp/66oMuKaFnqyKtJQNYTYMx1h4ZO1uNz7NIs4DmtbP67hZLcso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxm3vRSXo/5JXijn4+dmWHNSt7/g+PRGMqPJEwSDuZzaypEw0d
	EpHXPuxMl0PNpm4pOCLdPJ6JIzy2TVdo476EEPEZmw7H4iuV5IiZ/T5sVvybeg==
X-Gm-Gg: ASbGnctUJ/x96KQzc06+7lORY+K9UKGxDd/1Glngw9wc9+jNvrFx622c1J8p7p1RHNB
	T03LEymo7UlmwiYd/t2lMXkDan9P5vPD/vuNC1F+iqkTmPvRqIBYj2VLTrwNibBeEnKc6zQT660
	xgMHhjsqGGw1BzxZ6Vs4Y1h5UdfImBr5jiaL05nqJIxZ72EzjOe5IZx1fdHWgLfTx/0fXs4utCt
	TD8iSUIAp8SqVFgtxOwohc4kf71xBe4iZQVCRqaiRjBy1Pdiaofjie7pYL+BYqyyiUiF2sRFWwf
	z+Hjx/WwCQioSCE1qXyIktaqxW+MqlOHIByr6l0qeMDuHTJKAGrFhh7GtGiVOM0sW74VHIhdjOJ
	Y74QE
X-Google-Smtp-Source: AGHT+IF9apQGYnKV/Sw2arDUChDqO3VkipUyUoa7TCpQHGY52vLW2kYgyjSuPbJ4u4Bs7qGM3HzJ9Q==
X-Received: by 2002:a17:902:ea04:b0:26d:72f8:8d0a with SMTP id d9443c01a7336-26d72f88eb0mr35972375ad.12.1758326360747;
        Fri, 19 Sep 2025 16:59:20 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::641b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c959sm66883275ad.48.2025.09.19.16.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:59:20 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel
 Newren via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 02/18] make: add -fPIE flag
In-Reply-To: <xmqqa52qypo8.fsf@gitster.g>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
	<CAPig+cRGtMX9bQhb+7g5aXRVjpLKY-qDdQP95f9TmbY8j_BweQ@mail.gmail.com>
	<CAH=ZcbAOBnEVfyNy_4hdpe_dvsqDxsKVTcvurJz_iUWiqOzG3g@mail.gmail.com>
	<xmqq5xde435i.fsf@gitster.g>
	<CAH=ZcbDvwbCdnpeNv6vp=+Zy1h8RpG125ZCQNUzNOc5qLi8gNg@mail.gmail.com>
	<xmqqa52qypo8.fsf@gitster.g>
Date: Fri, 19 Sep 2025 16:59:19 -0700
Message-ID: <87plbmyox4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>
>> On Fri, Sep 19, 2025 at 2:07=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>>
>>> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>>>
>>> > I was trying to get the rust compiler to link against libgit.a. Both
>>> > Meson and Makefile produce libgit.a. No changes were to meson.build
>>> > were necessary for that to work, but but with Makefile I would get
>>> > errors like:
>>> > relocation R_X86_64_32 against `.rodata' can not be used when making a
>>> > PIE object; recompile with -fPIE
>>>
>>> This sounds like a workaround that is somewhat platform and compiler
>>> specific limitation, at least to me.  Does this need to be conditional
>>> and if so on what?
>>
>> I don't know, but I have another question to add to yours. Why does
>> Make need -fPIE in order for the Rust compiler to link against
>> libgit.a created by Make, when Meson doesn't seem to specify PIE
>> anywhere and yet the Rust compiler can work with Meson's libgit.a
>> output?
>
> I do not know what the build procedure using meson exactly does to
> create a library archive.  On the Make side, we do not compile for
> position independence, and don't do anything other than bog standard
> "ar rcs".  Patrick, any hint?

Not too familiar with Rust, but looks like the answer is here [1].
Specificially, this part:

    pic - fully relocatable position independent code, machine
    instructions need to use relative addressing modes. Equivalent to
    the "uppercase" -fPIC or -fPIE options in other compilers, depending
    on the produced crate types. This is the default model for majority
    of supported targets.

Collin

[1] https://doc.rust-lang.org/rustc/codegen-options/index.html#relocation-m=
odel
