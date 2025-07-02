Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971518EAB
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440486; cv=none; b=USysXGlSHOANAlAzs5wIYf46PVwYN8Y5o2WgBIWFqiZHG9otByid8icK8z9YpB+KZi+7T8RTxjc1eJ5DCNFNc9kvIjiTcTyOgsQTYKTpvxyUhFDf8lXcMp/y+DeE7OBGH86XyLR1HAo5gE/Uuh+iT43tvdUuS1Yf8LzyH8n7SYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440486; c=relaxed/simple;
	bh=dpoNKP1KwepgaXYqqz6n6skyS7rToVcGDFOY6RN8WrM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ltlP2p0xVD9bpRVSfvhgpSQICXiW81MprpaZxw2+PsGvs6zRQKZsrgAJuZpIXH/1D5MwU5U3EJeffjlN+AGuB/3QT0YvWR4KLgXhmfcJImOOpVkEGVaWaJ+ujKlBRhfR3dkYcTaEnfA5Zya/XiHOm1hhzFih+tg9p+cg9kfrWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azGgDfC/; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azGgDfC/"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b31d8dd18cbso8078342a12.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751440485; x=1752045285; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8RpMuHgwjwHR/MPszwpgS3ibpxcF/qWzg8URcJEsV8=;
        b=azGgDfC/c8DtIUD7YFag0KY2FfEzQFGYHjc00tQQKMMDzKJVFuaVisNwf7848bNzbd
         kwQJ3YaWUM2b4cUyVVB7QlGuXzN9VsIRMsEEn7qYtCQ0IQ/XjwQiIbTTzyLq0vkXeyx+
         4KSopBpJFUBmFgmSwSn7oiwNKAj/1TeAIhkV0P//+HoAFZdR7MD6x20tNeMZLEcAj/0d
         abA1otqcrveeTYWSbx1bTNjKZGZTzkQOT+J1koXsXrtyRmdxjXLuiHtROmiatEaBnp01
         Gyjr8YP1udHyHjd4D8QIXetKYb6H8h5f794tOIJMegGDe6QH087KEmdsnriipLMV1U58
         Mzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440485; x=1752045285;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8RpMuHgwjwHR/MPszwpgS3ibpxcF/qWzg8URcJEsV8=;
        b=epp77tB9CVSzWJ02cOGLAxsqt9wuzQNOKvLzN9VeJ+acfP1yBp91S1syDi4rp6bfIX
         GsKaWGg0B8DZ/dZLah4/d3Knoz8UlYao+zhCeckkzZ1v4pTEsdQmy2xbY3UMyqqf9l8L
         OY877y9aqdXVH04iHhEstvtZz6EKZpf+SnTEXTk+PlInopsM1WmYQa3Y2NcxvMqfq44d
         Ygg8DJs3/BTdHIk2mAUFJHtWYNtCmnk9fjDsVc6y+P8XyapmGhkW/mMMVMm20RknNviu
         iimR5T0KgyBoE064hqgKXIgvvpwMxzKt4af+zKgzhPDQ7Yva/NyYTtuWJnFcS+5ILiSh
         Z43g==
X-Gm-Message-State: AOJu0YyjEzpJ5LrN8EwLWsdj/aAgt7kORtvNHH14cC8wb2q6c149vLQB
	d2yravmVh+LfjVDmdPwgvGnBoH959P6s4eZvMGlbvX9z0/JbDO+Po5IS
X-Gm-Gg: ASbGncvzugBVZrPOO0GQqczHMt98YZUni4otkmYKTNKMzGQgjUsg+MLy0oELhohpoRg
	aoNsv4hH7h2UBBElwixMif7+AL2D47f2LBR18uHJLX7vleyW0NDTlHTf7KX/Xpe9YrJ56VuWd3U
	cB23D6TUXFGoNhEZLFQOZPdBXwDh5YLR1JbnYg75Zn3mRIEHOYDOV+Yc3HoOszXCS5ZAg/8P6yE
	EYZMwVWTTIgW7Ii7wk660//ut/B6EVSgaRT62M7YSi+JUqSs26T4JcewYof5XtF5D5Ahq9V+ha+
	CyfTatw6nn6stq4GBlKa+XIZDv7YohqVBgaco1X1ftLSsxpZA9TpwXjxomgtEht2PbV6VkZLyNq
	3Rw8eDEH05t2hyDu3EeW7QhNmu5c3VX4DdBTmTeeqyfBuW8yMRQmDXBvOdZnjTrgEEnpjPtzkxg
	==
X-Google-Smtp-Source: AGHT+IGyMR1i+YA3yl+mHRvCGry5bXEFBMdM4vA6Lweyrl9Trn6C1SRwEUijXxrK/wY4Gnyzgpk87A==
X-Received: by 2002:a05:6a21:4d17:b0:1f5:80a3:b008 with SMTP id adf61e73a8af0-222d7ee95camr4028277637.32.1751440484708;
        Wed, 02 Jul 2025 00:14:44 -0700 (PDT)
Received: from smtpclient.apple (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3642e9dcacsm280812a12.12.2025.07.02.00.14.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jul 2025 00:14:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqo6u4kkg0.fsf@gitster.g>
Date: Wed, 2 Jul 2025 15:14:26 +0800
Cc: git@vger.kernel.org,
 =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5CB9B7A-C7B2-4F5A-B358-8F46A4E18CDB@gmail.com>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
 <xmqqy0td8fa9.fsf@gitster.g> <C8E0D62E-11B1-4921-AD4C-2905F10E07B6@gmail.com>
 <xmqqo6u4kkg0.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> I do not know about icase; though.  Asking about "Dir/Path" and
> getting "Dir/ or Dir/Path cannot possibly be in the set of paths
> that were modified" from the changed-path Bloom filter would not
> help us optimize the tree comparison out, when we do not want to
> miss modifications for "dir/path".

Make sense, both PATHSPEC_EXCLUDE and PATHSPEC_ICASE shouldn=E2=80=99t =
be
optimized by bloom filter.

I found that my [PATCH v3 2/2] contains two unaligned parameters. Should =
I reroll
this patch and introduce the nowildcard_len change in a separate commit?

>=20
>> Here;s are all possible pathspec magic
>> #define PATHSPEC_FROMTOP (1<<0)
>> #define PATHSPEC_MAXDEPTH (1<<1)
>> #define PATHSPEC_LITERAL (1<<2)
>> #define PATHSPEC_GLOB (1<<3)
>> #define PATHSPEC_ICASE (1<<4)
>> #define PATHSPEC_EXCLUDE (1<<5)
>> #define PATHSPEC_ATTR (1<<6)

