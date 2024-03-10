Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366E16FF49
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096416; cv=none; b=Ji0Wt+GuewgXhDDTv3uALTaqneLH3bJGQ1LAZr2Zo6ulU2nCCm/JPse3uTBuzU6csf0IhVCS1T6VAJW0pL63IVG6wl37oOLCdwRA9aGU6DO67T72RoskbHCsX6Z7piL4tlbx8UqqDjK0J4Q20u903B0P4z61DUzmf+X3n1YIOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096416; c=relaxed/simple;
	bh=SzNCLh4fpLj1kqi96wF/fB5ulD9FYGYQ9UE170BNx48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw70vFG3Rp767r+1jJoH960LDDQcdX3kNmUcnWim8Docn3H1oRUdsl3IIfrMaz0LmfXo7+7CtwDx4nKo2U0FmXprEAO2nVyJd2K02MfHtXoqOM0Xu4MCR4YN1pSuqxCuvQRbJ+r7DXGjo8/rU8H1sotkKWEQzRfgQLtMyVR/UpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX8O8svg; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX8O8svg"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2210865d962so1408941fac.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710096413; x=1710701213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf50On5Q8kVDh2nH5HGOaiSs8kN6Dz9QZuqmFdVrO2M=;
        b=DX8O8svg2cbB3B+Lgid3WfGgOFHl/WhMTMqbEVeiiz7EH3WhiVPIkMyD9N7+KVPl69
         k6Ig4JYNrXc20kWTCzrK/k85Z01OfTEJono98nbE/z4pwPUFD3j8bQqkDS6g3Gj++IVq
         AA7MlhVFHrI/+n5X72RWAFuOr43vM64R1LeUyDu9D82tbjgJIBkg7hyyBDkBHtyl0Me6
         JOzjDXN+1HkuO5+zTY2NgAwh2ObNxk0bgjB+kNMGTaCqG5lXxfOiOSJBs0aIviqWOSmC
         sRp0SAqavBqAl+/ZmLeG8Zoy60Mo+W5pXq2vydmViTMtbvN3s++ljxt2wFqwAiXJI0hh
         ISIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096413; x=1710701213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf50On5Q8kVDh2nH5HGOaiSs8kN6Dz9QZuqmFdVrO2M=;
        b=TCrCj/RUxYm4QZygiJm8FgdR6DgpBzRRaBil2fdRV/b42OnHyjAgM4zC1yGT49uWxA
         wUMUQpbvJ0A3HA4hIrr4CpRsrByKHknzLYaFqs3FLQB0WFJiWofIrvnvvlQTtKajM1mp
         XS4j9mEk+pg5QO1Qc+ZRSVH7YFjEknce5/Rir/Cdp+9fPwS1pifJoLXVZnViS6grhISQ
         57k0sMr4uO7uGIoh1xGnDuRsi2y0AvUONFsGD7CVP2X2e3AmYpNmh1nbz1KwsyF8TJT5
         pOrJoShazzNuk19PoC7OsU5cDIJ07ZcDM27ruI84YzkgxIoW0unIJKBVqehVyAkFd1wi
         MvFg==
X-Gm-Message-State: AOJu0YwwHCltRPx61rVw8Pd/ituH7r0XBI6rf1emUqyD5RK0pX8KRsDK
	j3LqpIvAj58YD5ZwdAZaapGZmpJ893ft5bFkpqmn1aupb34oZnVh3ta+k3s9V+4=
X-Google-Smtp-Source: AGHT+IHFGw++U7xlwN6IegvmZ/33uLV3ExnDBTRJeyn3Kp7SM9tsWkAILDXPOhSACE/dwotbDFG9XQ==
X-Received: by 2002:a05:6870:2189:b0:21f:f8a9:e892 with SMTP id l9-20020a056870218900b0021ff8a9e892mr5495554oae.53.1710096412731;
        Sun, 10 Mar 2024 11:46:52 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id l8-20020a0568302b0800b006e4c97ec1f4sm742131otv.69.2024.03.10.11.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:46:52 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 0/7] cherry-pick: add `--empty` for more robust redundant commit handling
Date: Sun, 10 Mar 2024 13:41:59 -0500
Message-ID: <20240310184602.539656-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ultimate goal of this series is to allow git-cherry-pick(1) to
automatically drop redundant commits. The mechanism chosen is an
`--empty` option that provides the same flexibility as the `--empty`
options for git-rebase(1) and git-am(1).

Some secondary goals are to improve the consistency in the values and
documentation for this option across the three commands.

See "Does extending `--empty` to git-cherry-pick make sense?" [1] for
some context for why this option is desired in git-cherry-pick(1).

[1]: https://lore.kernel.org/git/CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com

Along the way, I (with some help from Elijah and Phillip) found a few
other things in the docs and related sequencer code to clean up.

The primary difference from v2 of this patch is that I no longer make
any attempt to change the behavior of `--keep-redundant-commits`
implying `--allow-empty`, and the new `--empty=keep` will likewise also
imply `--allow-empty`. See "Re: [PATCH v2 8/8] cherry-pick: add
`--empty` for more robust redundant commit handling" [2] and the
previous messages in that thread for more context. Patch 6/8 from v2 is
dropped entirely, with some adjustments to the ultimate patch in this
series as well.

[2]: https://lore.kernel.org/git/xmqqttltu7zs.fsf@gitster.g/

Brian Lyles (7):
  docs: address inaccurate `--empty` default with `--exec`
  docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
  rebase: update `--empty=ask` to `--empty=stop`
  sequencer: treat error reading HEAD as unborn branch
  sequencer: do not require `allow_empty` for redundant commit options
  cherry-pick: enforce `--keep-redundant-commits` incompatibility
  cherry-pick: add `--empty` for more robust redundant commit handling

 Documentation/git-am.txt          | 20 ++++++----
 Documentation/git-cherry-pick.txt | 30 +++++++++++----
 Documentation/git-rebase.txt      | 26 ++++++++-----
 builtin/rebase.c                  | 16 +++++---
 builtin/revert.c                  | 38 +++++++++++++++++-
 sequencer.c                       | 64 ++++++++++++++++---------------
 t/t3424-rebase-empty.sh           | 55 ++++++++++++++++++++++++--
 t/t3501-revert-cherry-pick.sh     | 14 +++++--
 t/t3505-cherry-pick-empty.sh      | 51 +++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh   | 32 ++++++++++++++++
 10 files changed, 279 insertions(+), 67 deletions(-)

-- 
2.43.0

