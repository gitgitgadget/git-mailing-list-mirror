Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B02F2E
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752725404; cv=none; b=lrPaN7q70albddx0MjYk9CzFqDuMXEjmqDgf2nIb8VhNncDqA3jop5xizSSwWltjqqIwToGXvzuwKeuRXO5OnMj3uWC43sad40GNVYAzj68GncDmEmbD2Os6OQA+e8eiMkcb3tcJQxZuJ0Fl2ypWlC7Vovjpx+sr4vOiFpS1aQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752725404; c=relaxed/simple;
	bh=4P0UoyJeTjksAFKZd9rnAe4olH20oMn1QSexHOufVAw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SreFFXfTiNzh//77XOvrzzge9YKeEuWx9w+Enkc3TrpPY4w+9PN60a3A/vz0eLcNDnesGD5jux2+OEGScgynC/tj27xbC4jzUWiOWVSXJZJOe62OgtNCf+Bdgezv7wXLBWKoUD1i1ptd4u69NVjPY0l+APY5wjZfUqlBTxTqXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiULLCEE; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiULLCEE"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-73c17c770a7so719895b3a.2
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752725402; x=1753330202; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkWKy5mkMzUWPAo8bKTY2nns+U07a9HaqFxjPJGwoLc=;
        b=EiULLCEEeowbaAf9nH0kJ1zrVJkL5jo/WaPBcYPlt1MqbcIxzGnefXMm1irHjM9NlM
         LljoEom0aDpgoVFzyp8R/G1klsMOKmP/UDgNIn4BMycF4qtcnOy2KZ8H8jlisfq1HMHw
         pqedvGzn+HWypsZGtlgYBEiPm/uIx1Vhv43LVPyCW2ARMQJW3zJYaI8Azy2VYfDovudZ
         akrjg/vQbTFUHrgaaoGkaYJ9//AJGhoF7jMwJIOpkD5Pt57vSPnTQ449AVMmd1TAmTNj
         Z65v75M4/g+R1/w5DuKTEcKwQtwMlXwl/m2/cVrHgx+UuK+1/ONgVUYsUx17HWklpmvm
         1Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752725402; x=1753330202;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkWKy5mkMzUWPAo8bKTY2nns+U07a9HaqFxjPJGwoLc=;
        b=avdGnTtlk24TE71JjHGuyTKFZeQsZJAhVmchr0y3Do+QIxCpBQjlpnGBUkw8rRdPqs
         4HfjX1KMipcRPU+uLkAUp4Ct9y6i1GdgvXmETXyfo1hBG47C8oic66Rz/DgCiaPuxWMj
         SfMjbzlk8fxUD8FtzNZwgQXN/cffxONJtIt5Pt+tD+ErsvPgMKTPdqBxo2CHyiKsQMuo
         l1Uh1Xdd1zMlZD+5WD/WNr4Aw8hlR7YTzVTn4y2ORR50aNA6LiKpY9UExv1tOjsAQm5y
         OU0zZeGNTFAMuocI+OlctRv8LwQvniHNF/ByQ9Gf0StIkdAXkEu4Ilv6tmoUl3Zykwyi
         Ollg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4UHguMggDHHhd/BILDWrmLs3HKFntZgeJNPBP49ZLGjtO8QNKuwwDPOPBl6D18jqirA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPI7+Xal01zI1BZ9MXJ2ejAIziN+mTbTibfgD6RLJ82+l3+xLL
	3G5XMiZpfGihM189XJ+HvQcoKM7ceBVq2m+GlCgYWOZh9DUgIl57rHeoasttVUnmVAM=
X-Gm-Gg: ASbGncsD3jKSb9pyZm1h281FyCOXdeBvR4ib4MbwcJp6z/qZcEg0Q1OUVHhVBbcyZ5U
	Ec0Yr+diX2RndY2Tz7Jw8goKmgt1tX/X0JoLwKulmhTMjF9oZwF44niuzJsgf41i9X+Us6nc3gR
	CF3M992F4/NuDJrj7+PTH5YvfGPrPdHqcM7yZ2MMoxNp9wXFn2R8PThXl1xMmiSyFCwnaL0yL4X
	s23qN1VvIEaxXIAhswocq/fHE8VjoSd+qcMXqlzr89Zl0HTQ8sX/T0Kfj2ahnjl/KKFsn/okKPR
	mHN8U4TP/aeMRdKadENWJzxVFX9Nq+9rfBwPTvn9cEu7fla2tKZ0m5CA501DRtQGzPQRiSJbTOX
	wqDs8YDw14ExLFOcg3rKCu2i+zDNGx6fw
X-Google-Smtp-Source: AGHT+IFZAqi5dYhQReA7LIbpqGfQKEULulTBT1fBvNA4QjJmZRsqjcBcuwRf5vqcSevxRGKvod3ZmQ==
X-Received: by 2002:a05:6a00:178d:b0:754:7376:548f with SMTP id d2e1a72fcca58-75725a8a00cmr7493233b3a.23.1752725401891;
        Wed, 16 Jul 2025 21:10:01 -0700 (PDT)
Received: from smtpclient.apple ([188.253.126.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06aa6sm15561200b3a.62.2025.07.16.21.10.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jul 2025 21:10:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] pull: add pull.autoStash config option
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <CAPig+cTQ017qGK_Qx04+R_0rCXEOirW+oLEjeaDoCFJiQbnsGw@mail.gmail.com>
Date: Thu, 17 Jul 2025 12:09:48 +0800
Cc: gitster@pobox.com,
 git@vger.kernel.org,
 j6t@kdbg.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <78DFE806-5DAC-4A90-893B-77F32E393E07@gmail.com>
References: <xmqq5xfsdv3w.fsf@gitster.g>
 <20250717030732.75106-1-yldhome2d2@gmail.com>
 <CAPig+cTQ017qGK_Qx04+R_0rCXEOirW+oLEjeaDoCFJiQbnsGw@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Eric Sunshine <sunshine@sunshineco.com> write:
> You will want to add one or more new tests to a test script to verify
> that this new configuration works as expected, and probably also to
> verify that `pull.autoStash` takes precedence over `rebase.autoStash`.

Got it. Always make sure to add tests when introducing new features.

>> diff --git a/Documentation/config/pull.adoc =
b/Documentation/config/pull.adoc
>> @@ -13,6 +13,15 @@ pull.rebase::
>> +pull.autoStash::
>> +       When true, Git will automatically perform a `git stash` =
before the
>> +       operation and then restore the local changes with `git stash =
pop`
>> +       after the merge or rebase is complete. This means that you =
can run
>=20
> I wonder if you meant "pull" instead of "merge or rebase".

Yes, I think I should also say that pull.autoStash only works if we set =
pull.rebase.

>=20
>> +       pull on a dirty worktree. Noticed that `rebase.autoStash` =
provides
>=20
> s/Noticed/Notice/
>=20
>> +       the same functionality, but `pull.autoStash` overrides its =
behavior
>=20
> Rather: "...same functionality as `pull.autoStash` but overrides the
> latter when..."

Got it.

>=20
>> +       when both are set. This option can be overridden by the =
`--no-autostash`
>> +       and `--autostash` options of linkgit:git-pull[1]. Defaults to =
false.
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> @@ -1052,7 +1056,7 @@ int cmd_pull(int argc,
>>        if (opt_rebase) {
>>                if (opt_autostash =3D=3D -1)
>> -                       opt_autostash =3D config_autostash;
>> +                       opt_autostash =3D config_pull_autostash =3D=3D =
-1 ? config_rebase_autostash : config_pull_autostash;
>=20
> You may want to wrap this over-long line. Perhaps:
>=20
>    opt_autostash =3D config_pull_autostash =3D=3D -1 ?
>        config_rebase_autostash : config_pull_autostash;

Here's something completely unrelated: the output of clang-format can
sometimes be confusing.

- opt_autostash =3D config_pull_autostash =3D=3D -1 ?
-       config_rebase_autostash :
-       config_pull_autostash;
+ opt_autostash =3D config_pull_autostash =3D=3D -1 ? =
config_rebase_autostash : config_pull_autostash;

This made me mistakenly think that Git had set a large line length =
limit,
So I didn=E2=80=99t break this line here.

Thanks,
Lidong

