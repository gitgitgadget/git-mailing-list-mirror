Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718AC2F8BE7
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758390393; cv=none; b=ikiCvxHTZEa5HWIxZOsNrX8FOw68csxide6GLGExUH3h1UeL3OQfyta7Dc54Wcfjin/zn7f5OhKzezaw40bd+PLYip4I8oarmL3k1r3uj/fPRUHolz41DxIhTsVfeBnjUrkifqwS2xS+jet/5fiE4Pjk6PjAEWjNqkNO+YxgV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758390393; c=relaxed/simple;
	bh=njzcmqEtRCSRKFfl5rOGOzSShvPGlbN31uXLzHttBow=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dXnbXOUF44EnO9IgMbHg8WUuZclOa18uBwYjb1PGj9UkLh76EPNzDSdCMLukBJEjvXpCLyL3qspcPFW4uvNyX4Kr02LZgyS8d43ee/E+bGhpNlAZGgUs3zCEc2RL0clWI/smcVVzzT92xeILHMdyubmKIMLTy/tJgI02E/PujMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdhb8O7R; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdhb8O7R"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e970acf352fso2163242276.2
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758390391; x=1758995191; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njzcmqEtRCSRKFfl5rOGOzSShvPGlbN31uXLzHttBow=;
        b=Qdhb8O7RfdRa7ac55pyczjKlmbLm4DC3jwph5te1tIwkUoa7vFGy5VEpxi0HowX5dA
         HBXZcG118XDSOlTNOUbpI9Omw9WwbhAxh4kLwQgsGuSxxIjAbxCQiZTBYFUjuXWIG29l
         1xPEVTrCeo72nJkH3VFL6BZNw1iYsgKl1J+pykaNJzT4SK5lkENnQCMSI7r80wZwjGC9
         ede1jiwbJntJCdyRzsUlt5Eu3WzBSZpOWOVJwEKgGxFQ8/eUWfwopEEoOs6DH8JXL71S
         Ca2s4CWErasluV0kSqHg/+5WV5o/5okTNmPkpSqBdnDP6vfqlC1BP6XM09MZav+Cbe9G
         Mdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758390391; x=1758995191;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njzcmqEtRCSRKFfl5rOGOzSShvPGlbN31uXLzHttBow=;
        b=wrZMbS2pe6xAF8GL9BUyVsjYQ9oqwnAZBT0S+nxVC2pms6Q3SrbWzms4UFcH7US3MZ
         fbeudkJSeih/ZrxdaK1wKB0sspG6MXCROmoE6IJyvzLXuvz3QCnOgC35iMernJyWDYM/
         ulu7evVf0YxD0ykqBKgQircBKvoePO+DyLkESEjUfRuT7CRaB/Wa7kaoAxFQyyNM2NLk
         vCLnlfDEb1ETdAastqZ8NZvGwbeA/bZswgXwNJybPH7+bJQWrGhD0zaYGa7IUsW1LNmw
         MPs5rR4MFtDoir+gzcsj+KHnW1D4V2tUd7hhHEwOr3fH6R/c47Y1pEMDfZO2otNy4y7o
         IhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnz58ppmssMTdEz0gXbdQH3RXDojQGq8qLdooOaXKcp5G++Ess6CXe3oxb+D5YdV5ca6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHZbkvto2uilDx3isfY8jDRZmgtOWCy86lqxHMNqGAabeg5rX
	yZtiMVMd8kdJTavfSMhHNEjmysOqIH5AiChR/q1OfOvSUql6PJ4tBE/E
X-Gm-Gg: ASbGncuU4/K/XejocriAwD7r2Xo17sMPNy6MbSZK+Pq+XbIbRDCLWBXH1v6t4rpjTZz
	XN94LRTLO97LzW2z9wfIR0HNRh9jiBNmWZAKiD+qyTpeOOG/EnX1c+T6AOfdvtxN2gMM0lYenVK
	+8o4koRvIgSQW4QbIQF42h4QxqoL+tiCD2hEchtnLjGuQjgVJ4oA37UQoOkbfJQL2uJ1gYUK7uA
	m7cB9u8tlFfBy+tB8XqRWwFNV/QkQAuJ0qrNhYdRYGfwP6bUPNnJEpYS6BoXoGwhf4qfKM7lpDt
	0l68XBMRTEwJ/5iA9Yb1plQ1bJAyJx84Lj++Up/mnb96XAtXZV/RYd3PGzprCZTdygNqnXiW0ay
	mnxA6hftcQLmWx5AeHROtVPDJ0a+ubfptwRlZmw0ZYa5odpXF+nbayTC1Mw2hDh8TLlsIC+sQ
X-Google-Smtp-Source: AGHT+IGWzN26MYDyQwiCwL18FhFmJYgVd+qZPehxXggiMLyP1pBjQJ4wvEtXVFWpCTpjHghrru8NqA==
X-Received: by 2002:a05:6902:124c:b0:e9b:afa3:5190 with SMTP id 3f1490d57ef6-ea89d7acee9mr5155027276.31.1758390391380;
        Sat, 20 Sep 2025 10:46:31 -0700 (PDT)
Received: from smtpclient.apple (69-77-149-20.skybest.com. [69.77.149.20])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce8544b5sm2688097276.17.2025.09.20.10.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 10:46:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in xprepare
Date: Sat, 20 Sep 2025 13:46:19 -0400
Message-Id: <83F61517-06DB-402E-911A-E33EE07D54AE@gmail.com>
References: <xmqqh5wxxcwq.fsf@gitster.g>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
In-Reply-To: <xmqqh5wxxcwq.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 20 sept. 2025 =C3=A0 13:16, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BF"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes=
:
>=20
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>=20
>> Move xdl_prepare_env() later in the file to avoid the need
>> for static forward declarations.
>>=20
>> Best-viewed-with: --color-moved
>=20
> Two comments.
>=20
> - This is a bit unusual to see in the trailer.

This was (loosely!) my suggestion, and I think Peff has once or twice done s=
omething similar.

No harm in working it into the prose instead, and I have no stake either way=
 beyond a mild personal preference for the trailer.=20=
