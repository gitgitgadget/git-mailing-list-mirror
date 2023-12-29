Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10D10A18
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbd7d60729so839727b6e.0
        for <git@vger.kernel.org>; Fri, 29 Dec 2023 02:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703846161; x=1704450961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIrZm8JV5BP+0pJLC/1KHL0+tKscTNjR0o1JaUOxVsQ=;
        b=eQNMJH8FyUpYQ8bh+aYK20NHBhvjmedLpK0eevB780DpcCUp6vxpHNSTi3Xz6Jzpwu
         XSkr3nu1LBKwtdzQey+nqPe2B8JGJkkgGuu6Y1zDg5NBDrWC4GJPfZ+uOvvZbugG/oPs
         N1XrXlg7pymLPo7mwwSJKUolTiaz4Zu6rHHvlP6QjylOYQfRs3+3n+/nfxAK9vI+c813
         WsR1fEPmeBz94KdZNVWsAiagH16f0/yT7O4vXSkikF84mVDHs78oJjq7p+sQSR9gzPqv
         eGVodwNdztwAMP/tAt/KZLLbeI82y5odRJhGzbAFWHPVVSJDcLCdTZQOEEgpMpCvmAFz
         syrw==
X-Gm-Message-State: AOJu0Yxtfqumqm3hhdQDMJjBZzdChGmDX0NLmH4DRwSgtVET/B3b3KbA
	/mNeI2CPAfnDU33NThlZ3ZCtnDmuNAK/wsa1GMh3izwB
X-Google-Smtp-Source: AGHT+IHJKf7mVOPNTxiQjgEavLA6KYsAH9EBC5+fADEVOnm+FELwQypium9G+hoEtyEmUS3rjFuhJw6Mau1cpTJvG44=
X-Received: by 2002:a05:6808:130e:b0:3b9:dcf0:63b9 with SMTP id
 y14-20020a056808130e00b003b9dcf063b9mr13277263oiv.23.1703846160837; Fri, 29
 Dec 2023 02:36:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703754513.git.ps@pks.im> <3cf6ceb274d20ce76d0be65e4362a33579627052.1703754513.git.ps@pks.im>
In-Reply-To: <3cf6ceb274d20ce76d0be65e4362a33579627052.1703754513.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 29 Dec 2023 05:35:49 -0500
Message-ID: <CAPig+cRWCFdVd_+By2T-sP58u22OcgDQogSS0UP5ZYYf2K5W_A@mail.gmail.com>
Subject: Re: [PATCH 3/6] refs/files: skip creation of "refs/{heads,tags}" for worktrees
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 5:16=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The files ref backend will create both "refs/heads" and "refs/tags" in
> the Git directory. While this logic makes sense for normal repositories,
> it does not fo worktrees because those refs are "common" refs that would
> always be contained in the main repository's ref database.

s/fo/for/

(not worth a reroll)

> Introduce a new flag telling the backend that it is expected to create a
> per-worktree ref database and skip creation of these dirs in the files
> backend when the flag is set. No other backends (currently) need
> worktree-specific logic, so this is the only required change to start
> creating per-worktree ref databases via `refs_init_db()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
