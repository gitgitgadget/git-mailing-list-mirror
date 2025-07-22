Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84526A0FD
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208127; cv=none; b=j8QzLDgMaSicWJmafGhIslmXjqApZV9lRC7m7yH225pGc09EinckrffNX7s3GsPltqrL/Sa+jgfhIMhS/7eryBYUbq/qeFOmW/zvsF22rcfD36Tvzw7d0wEpoofmcwIXxrqrmsVHC10Tww7vZetwftwKGIyuy/fcNAncp7vHMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208127; c=relaxed/simple;
	bh=MCZKhVjboFHFmztZUoeWuSc0liZBVtlnkVK/Vtdokps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXOrKIKwF+NTL2n9809LtlwCZ8oBV1rq2qV5X6gK4MhJeahucoSu9RDgHQzuOupo+MUE4djGXAMLQP/sDkX/29hQTpUFAoODaLFptvp+HeylE0DEmiTYdpiJ7WeFtpcI5w8K9NPihq500ajoyVZJrPDrEjki89sqMYdqVjEm9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMc93ilA; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMc93ilA"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e82d2ec21so2627532a34.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753208125; x=1753812925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4iknFmv4SLo79ha/Bp9hNrGhHCog2tui0VwiSi1L+rM=;
        b=NMc93ilALWpae7Mgx/vfM27J2ZnD/pSMYsHSJsPGN4Cszz78N32WYozFrq12YMkn0i
         WaB3Wx+WxDlruoh4Mud+Od9TUa2RTXQ1pPCcDxxe33BuQ8guYP+msD+cFdvYdszUU9Wi
         R5CpmPgvrwhfdgje8o5TDKjiOP5bnUrdcNvPPgIkxvvlqI0ovr55PyGB6OiXLnhceKJH
         iPqI56AAF7XWBtmJjAEXQtLXLRuUV3zkOiauoRak+dTy8EkJLchvYHEbqq5pPEo7vUv5
         s5Pnf7aeKgQ4nNzCXdkwo2QOwKgAXEvhMbsbknTrEWGsN2z5tn+2+nV1z6ZqK28dPFZB
         3iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208125; x=1753812925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iknFmv4SLo79ha/Bp9hNrGhHCog2tui0VwiSi1L+rM=;
        b=PQP13FKEVLfCyFe3qvt5PWkl53toJEfI7DEEgjA9TbgpJPPv8WiFg4hJ/XSqcYOeVR
         TBQAxqvJjC/vQul++FCgphtJp8zW52UGmYWTKIRD8X6ydu4YPBjppS8qDgUmZyHqigeP
         npM0n7pPtPRePa9c26MtpoSEruM/TNgB6EbH6swbIGXjHFPVsFjaS5eytxfUz4410/nH
         EesU9Q39ct+KE4TpTMOQPkQs6RfTq1RjsDlUuqUjzAdeEms59nINZhTXU+nTnWpvdF+X
         iTJTUQdJahrsk5z631Jt76snXTArPLei8XbbZph5IcFRTWoxVaeB6gR+zsu1Tajyxs9v
         6gxA==
X-Gm-Message-State: AOJu0YwNf54IiwvAyaPlV8wCzuaDQUBGtjK+onOunFlN4UQQbMOAOKUN
	MsJCXLDEfWAgea9jyv9EtkFCDkVLZU4CjlWhVVFKnUzqz9E4xo3uo2udh99xEQ==
X-Gm-Gg: ASbGncsK8/JSeBDb9pxW/YAsdq2dRYAWh/unx3sprmtl5kBWrPdYwBHM2XwvkZYBvHv
	XI6WXzKYky0x0A/8sUyNkPuyxWOcyp37NgtSKwRnbi5E+kMd5X+oU+yxjgBqZw575EaExISYeur
	e3fZLsl0A7O9g9SZ/bsXN8cWgqENDW/OayO5uItifGIqh1nS96WUGoj5JwpK0ZXS8sqO2n6WUl5
	3ySn0kZGEOC2EQeKaM62EMPGmrV7cnGOUFaEXMMu87FQN6w9Hlrxzrm/F5Rl9Ib1bZk4ot6gEMS
	rPeYpbOpXRAb0uMM0DLiNS37kthaKWKVfMokwBsMocyFmuxBKgsb722Zqe8sYKotTcnSO3oYsgl
	k3sWyuDX1mQDcy5wBLiVD1LFTGKXYkw==
X-Google-Smtp-Source: AGHT+IFnLibXWCYbwgrEkaUkZmcJjawA3m2k7N1iZmpl1MogyfZzX1dxfIJwBFC1P3tlzcLx94My1A==
X-Received: by 2002:a05:6808:e8b:b0:40a:fb27:9e8d with SMTP id 5614622812f47-426c47e8352mr211040b6e.15.1753208124041;
        Tue, 22 Jul 2025 11:15:24 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd498c218sm2914153b6e.29.2025.07.22.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:15:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/2] builtin: unmark git-switch and git-restore as experimental
Date: Tue, 22 Jul 2025 13:08:16 -0500
Message-ID: <20250722180818.1043014-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.50.1.214.ga30f80fde9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

In 4e43b7ff (Declare both git-switch and git-restore experimental,
2019-04-25), the newly introduced git-switch(1) and git-restore(1)
commands were marked as experimental. This was done to provide time to
make breaking changes to the interface. It has now been over six years
since these commands were implemented and, over this time, there has not
been much change that would warrant these commands being labeled as
experimental.

There was a patch submitted[1] about a year ago also with the intent to
remove the experimental marker for these commands, but fizzled out
seemingly due to uncertainty around whether past discussions around
git-switch(1) had been resolved. Digging through some of these
conversations[2], a point of concern for git-switch(1) was around some of
the chosen short flags for git-switch(1), namely the `-c` flag for
creating a branch and the `-m` flag for merging local modifications into
the target branch via a three-way merge. The idea was that maybe these
short flags should instead be reserved for other not yet implemented
options in the future.

At this point, it seems rather difficult to justify changing
`-c/--create` to something different as it has been that way for a long
time and is used frequently. Also I'm not entirely convinced switching
to something like `-n/--new` is much better as it would run into a
similar issue of taking the short flag commonly used for the `--dry-run`
option. As for the `-m/--merge` flag, I don't think there is much harm
in dropping the short flag for what I presume to be a relatively
uncommon option. Outside of these explicitly brought up concerns though,
I have not found anything that would require a breaking change to
git-switch(1).

By removing the experimental marker, we help clarify the stability and
maturity of these commands. It will also make it easier for users to
adopt and recommend, as the experimental label has been a point of
hesitation for some. For new users, git-switch(1) and git-restore(1) do
help avoid some confusion that comes with the one-command-do-all
git-checkout(1) so helping to further promote their use should be
beneficial.

Thanks,
-Justin

[1]: <20240220092957.1296283-2-matttbe@kernel.org>
[2]: <877dkdwgfe.fsf@evledraar.gmail.com>

Justin Tobler (2):
  builtin: remove merge short flag for switch and restore
  builtin: unmark git-switch and git-restore as experimental

 Documentation/git-restore.adoc |  3 ---
 Documentation/git-switch.adoc  |  3 ---
 builtin/checkout.c             | 24 ++++++++++++++++--------
 3 files changed, 16 insertions(+), 14 deletions(-)


base-commit: 3f2a94875d2f41fe4758a439f68d8b73cfb19d0f
-- 
2.50.1.214.ga30f80fde9

