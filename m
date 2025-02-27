Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58711A9B2A
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672193; cv=none; b=gJjioN+Zf4dEG0jx1cIHc+dvv63EkfpiaUbpIGzrdiXO+0o4jHr2/5O8rh03mvp8ioIbfqXhPRhT3MVHaCNX0mC5k7DURq+YtD+CbbZEd+aBHE/TLQt2cHxtcuUCpJXQlKPz4MRPvQ25KpLhfmBWUOxOgTgKy6Jn/Ty6L2mItUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672193; c=relaxed/simple;
	bh=0uzPph5r+otI405Kbz5vWHx82HAVTvb4s9RPPf0zgXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5dNpcV1GyhOJPxxDUakNtdUI5nxDV9B4phvqZWWI35ACt3zJRPQPqO2paGB7YOTVG1GYZY2o2bTzou3DdJ6oS5Axg+pFvc2oYUyGbH4fITujZka2K+327e8dv6EsDK1lb3BDDsy53UTTQ7BS209thJlt+F7sRlmPXjDA0tdpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbm/jR/5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbm/jR/5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-222e8d07dc6so21945965ad.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672190; x=1741276990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAvF9JBM2DT+4A4AJKqj8mz6z/zDrTT0vI3/pMZ7E5Y=;
        b=cbm/jR/5LucNWoth73AU9GGAxJdArgpfe6J1g6I2gUpsv1lQcKTcyRlvRo2r5MGCiK
         jtj2xMYYUg83h4Theg4xur9enbi6/d6+K1XeQk9rOEkPRIAMnEQVRsQDLFi7IeHQ0M78
         st2l0U0tOAUjAn8lmKvEjg5Oar5PHl+DivwnUv3o6QMalWRK64h/VE/oJiDxZeDtGqo/
         L/1shBJP7wltq3xmfKnC7tZDRcY5UyUtJhz66QsJ/vWP9y+HpJXUV7aR5l/KxqAeP/Sm
         L6CilmWBn5wFYaC/aVPEGuSEWB6oq+VqYDgQcL/9BCZJb+JLBbKhpjihh20FKtAOHwZa
         yZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672190; x=1741276990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAvF9JBM2DT+4A4AJKqj8mz6z/zDrTT0vI3/pMZ7E5Y=;
        b=v8jubor9ZVyGUkoxEuGIFmOM8eDv5DhzUTBIqS8MB7Ylh7C9PIuDcz1p1QG8ITm/EO
         TPPF+Cq8ihk96T6tcvH2p1vUbnFJDUk0L2LaUTvmYFFotRk4trgLanrMlMbeWXBSfqxU
         7rE+w6Bg8BiO36G+YmZKBi7lo/NFAaKYtYwQSTMvrUIrg8eShaD2vi6vmvpoAnfL8vh7
         qAV+AH6erRri7bcY1bepARB5HUJbuKIQXG5mECDPrPa2GHMnPWU3bVsbPJy1xFDT0sCM
         JnPQ/cnaJiKtcUz/4isc2YGiKyp1VhoKTJL0fFFFqIv6UIUHwlkbbnJh/waFhRfbl5mv
         gxoA==
X-Gm-Message-State: AOJu0YywNOmAsEGOtwgLkZdOK8iButWdcnx2UiuZBkj/sV3ttsjSzsRU
	F3i7heeI4kp3qNCIJfyc6kyTTLW2A715WCyqY4BZsUB/6XGeBKz/ORTJlw==
X-Gm-Gg: ASbGncsecCVcuhOBE7+8YMv/5TNegz+LYXpRFDKQwyr0gjY3iuV9lvrDJ4ewW2gLHCO
	mpLSVZW7TOqKhkeNBDaq8BnquGKgtsbAF6GjaqWuYSfUraN7cfAtSTDCFpysTDErl417nJ64nhB
	+VVrjpowECgOIisW6QQBFgQRI7cz9AylWiEG7CNg75ZNTzBelOEBq6ik04Rh/sKtMMj1d0622PF
	tcYmVgprA0bfYpnEJW5xlyw0tqClK+DA3AgkaBRMvzXzyPBsCoTmsaLtXR8BlJ2cJSjLkPkl2Qr
	CQOUvcr56hWQ5RlWhVoe4Q==
X-Google-Smtp-Source: AGHT+IGWvGSAXI+A2m/Uwqks0nzV+Z/fsp49Ukgr9YiUC3QyyEyBpZFmMJzbKHQjff5lmnUzerQyVw==
X-Received: by 2002:a17:903:947:b0:223:607c:1d99 with SMTP id d9443c01a7336-2236735292fmr523245ad.0.1740672190439;
        Thu, 27 Feb 2025 08:03:10 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501f9e46sm16651345ad.53.2025.02.27.08.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:03:09 -0800 (PST)
Date: Fri, 28 Feb 2025 00:03:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 0/9] add more ref consistency checks
Message-ID: <Z8CMx7O19PMs9sVY@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78bmBSrDR20GY6g@ArchLinux>

Hi All:

This changes enhances the following things:

1. [PATCH v8 3/9]: initialize fd = -1 for two purposes:
   1. We could use unified `goto cleanup` where we have one only
   control.
   2. We should not close the fd when we cannot open the file.

Hope that this version would be final. Thank for the effort of every
reviewer.

Thanks,
Jialuo

---

This series mainly does the following things:

1. Fix subshell issues
2. Add ref checks for packed-backend.
   1. Check whether the filetype of "packed-refs" is correct.
   2. Check whether the syntax of "packed-refs" is correct by using the
      rules from "packed-backend.c::create_snapshot" and
      "packed-backend.c::next_record".
   3. Check whether the pointed object exists and whether the
      "packed-refs" file is sorted.
3. Call "git refs verify" for "git-fsck(1)".

shejialuo (9):
  t0602: use subshell to ensure working directory unchanged
  builtin/refs: get worktrees without reading head information
  packed-backend: check whether the "packed-refs" is regular file
  packed-backend: check if header starts with "# pack-refs with: "
  packed-backend: add "packed-refs" header consistency check
  packed-backend: check whether the refname contains NUL characters
  packed-backend: add "packed-refs" entry consistency check
  packed-backend: check whether the "packed-refs" is sorted
  builtin/fsck: add `git refs verify` child process

 Documentation/fsck-msgids.adoc |   14 +
 Documentation/git-fsck.adoc    |    7 +-
 builtin/fsck.c                 |   33 +-
 builtin/refs.c                 |    2 +-
 fsck.h                         |    4 +
 refs/packed-backend.c          |  363 +++++++++-
 t/t0602-reffiles-fsck.sh       | 1209 +++++++++++++++++++-------------
 worktree.c                     |    5 +
 worktree.h                     |    8 +
 9 files changed, 1162 insertions(+), 483 deletions(-)

Range-diff against v7:
 1:  b3952d80a2 =  1:  b3952d80a2 t0602: use subshell to ensure working directory unchanged
 2:  fa5ce20bb7 =  2:  fa5ce20bb7 builtin/refs: get worktrees without reading head information
 3:  861583f417 !  3:  b3686a9695 packed-backend: check whether the "packed-refs" is regular file
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +							REF_STORE_READ, "fsck");
     +	struct stat st;
     +	int ret = 0;
    -+	int fd;
    ++	int fd = -1;
      
      	if (!is_main_worktree(wt))
    - 		return 0;
    +-		return 0;
    ++		goto cleanup;
      
     -	return 0;
     +	if (o->verbose)
 4:  5f54cb05c3 =  4:  2638d5043f packed-backend: check if header starts with "# pack-refs with: "
 5:  7d7dc899ad !  5:  13e34de350 packed-backend: add "packed-refs" header consistency check
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +	struct strbuf packed_ref_content = STRBUF_INIT;
      	struct stat st;
      	int ret = 0;
    - 	int fd;
    + 	int fd = -1;
     @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
      	}
 6:  571479d3e7 =  6:  0632a1d5e2 packed-backend: check whether the refname contains NUL characters
 7:  e498a57286 =  7:  4618da3199 packed-backend: add "packed-refs" entry consistency check
 8:  3638cb118d !  8:  355e43d251 packed-backend: check whether the "packed-refs" is sorted
    @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
     +	unsigned int sorted = 0;
      	struct stat st;
      	int ret = 0;
    - 	int fd;
    + 	int fd = -1;
     @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
      	}
 9:  5d87e76d28 =  9:  57dac06151 builtin/fsck: add `git refs verify` child process
-- 
2.48.1

