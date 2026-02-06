Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DA2C3255
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393158; cv=none; b=DptXKcYAw+HToxnK4VvULIVGCK3cE8xSGyvpM5pY0lWSxWJXgvZkLvEeJdZVhsLoJoyFH3I9G0FXr+Axgfoxv8SQ4lju5q1QK2bN2kObkoeDkjZAw8XbTrNae+UTXoY/MIkKf3zG1UXLeIVFB8YZeqJp5ajYm6dl766ieDb7ilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393158; c=relaxed/simple;
	bh=dOHJwWhB12aP7LXN2VHivX6b3bMfnilQwvI81FSx3CA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c/WS2TtGPlaulngPdHsVY+ZieHSH/pkdCNdWC5o3i+1SbplygdNb+0SnADPxXDdsv/ytVi1R1gv6FSyh1FxpHOGMgg73GD4ROpEFYeAPJTrNVUAHl7W3lT8P6dqp7Ti9vxlYoH9rNmkiD0PzKjetYwJp1rofrso1n1v98Z0r9fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfcWxm5D; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfcWxm5D"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so7798655e9.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 07:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770393156; x=1770997956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEy9uHl9ssQ/tuSeW66+za/tEj2UNS97U+DuT/24HLU=;
        b=IfcWxm5DFtq2EibKFnWB3hZ49UvA5hmeYR0qI9aXlySIJ6bdvfGfeXG/CUgLgqCZax
         jADSjN2oI/RsZllzArJsUb0d5BHWMY5phGY9wKbHef9ey24Wovzy5hEJ2e3plE/vddiO
         5IsVXyxNo5rGafmvPHhdIUqGLF1o513g63CAWmrTYLnRKeq+Hc+wbeRTeX0rrBFZDAg4
         l/tQASYyMfBAmsigu9Xl2b/pv4dg8JyYolyf5o+tLMf9c3TyJiebjGaKOXMj95fqmVTA
         hXIgNzIuAdl+SpNYlX74ABcuw4MzAKUrOPSx6cRz8Qckb2equAqf3g5RkTZRWOwh9kSM
         ccmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393156; x=1770997956;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEy9uHl9ssQ/tuSeW66+za/tEj2UNS97U+DuT/24HLU=;
        b=WmVA6vS2xsLyJqb4iXLQrvTmFqEmrEL4MlNa6MOY6lpz9wscS85UsS6+O/A3L+Or32
         aQWF9WLPuVTg6eYRl2zHj0WWqx8o262qHn7AZ1byALRw7thNZ7rkw0DaNH6TsIVCFq6q
         PEakmlv7r9YdzmRSfRCKVXEqfS/6Nq4z2+KfvLGY0mBMyOVQmuexEdvidFsL82dNY+vj
         BtoyiSgCNdq4MFFToTtZX2wAi+5ZjQP5fx3n5vUT3m7SbL+SynVyYUf7iKiclDeoijUI
         pmngXpBxLI66k966btsUyYjIUoFJMKdRrVXafO2KrURhYRmwkiplgTWRfXLDh0aiaZH0
         Mzhg==
X-Gm-Message-State: AOJu0Yzjrv1uAXQ6dQPUVgng5DxbUhI14otdSdX6LHS10wdb1yuwloP0
	14/eYAHTJYg2nGkkY3QCHRdVTB3qt4GA2kdVvj4dgPiOKZbQfRDvHzGimq4Hq2Fnt1k=
X-Gm-Gg: AZuq6aJFMQHisOx+3inpOXXdVn8nzFy7wDNB7ihD3qAoNzaXz8LQ9PTkfsd3lGuSpxw
	Zp5FjpqRBfJacj+NxN6Ti3HTOeuX3r90COjy/zcq22wgfxnCgNfhA9D33JTv0f6AcaId/OramXz
	oNnVFArKcePDdIIv48fIrW2k8Y94KWQL6EdwwVVhoWWnfo4npt6JuypDlcIASvTRqU36CmGlvLv
	nzgkrm7ONpWYzyGwYTrcxbmjQOduPIQhd34Z+BR1smByZ6nBB5XAMLjgeDVgnh0I/1S/ETyfdya
	4jm4VCw7FEzJXKks6YGhTGabgZIdH6KA1s5pY5OeEg9DHzCCPa/fyzKhDOTdNRfkjNduwOjBPir
	QdAz6iO+1WFiLzcrbzBey11/RBk/yhcFbItUk2AALHIIZQBjsYaMCpVdhTWRjE9B7buYDruqFjL
	Z2nnfpDOkGU6zjUZtY3/3h
X-Received: by 2002:a05:600c:8411:b0:480:426e:9d38 with SMTP id 5b1f17b1804b1-4832021d688mr44119085e9.27.1770393155582;
        Fri, 06 Feb 2026 07:52:35 -0800 (PST)
Received: from localhost ([102.91.81.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297462a8sm6560117f8f.30.2026.02.06.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:52:35 -0800 (PST)
Date: Fri, 6 Feb 2026 16:52:39 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/3] introduce new option `rework-with-file`
Message-ID: <cover.1770390576.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769522219.git.abrahamadekunle50@gmail.com>

Hello,
After further review from Junio, I have been able to make reworking with a
file during hunk selection an optional feature by passing the `rework-with-file`
flag to the --patch option in the interactive machinery.

With the option, users can navigate in between files and while deciding on
hunks as they wish with the '>' and '<' option for going to the next and
previous file respectively if there are more than one file.

The process shows a prompt which allows reworking with the file and changing
previous decisions if need be, going to the next or previous file if possible
or using 'q' to submit and end the process.

Patch 1 implements the new 'rework-with-file' options, Patch 2 makes some changes
to allow interfile navigation when the option is supplied and Patch 3 modifies
the code to allow the patches to be applied only after all decisions have
been made and session ends when this option is enabled.

Abraham Samuel Adekunle (3):
  interactive -p: add new `--rework-with-file` flag to interactive
    machinery
  add-patch: Allow interfile navigation when selecting hunks
  add-patch: Allow proper 'git apply' when using the --rework-with-file
    flag

 add-interactive.c     |   3 +
 add-interactive.h     |   5 +-
 add-patch.c           | 161 +++++++++++++++++++++++++++++++-----------
 builtin/add.c         |   4 ++
 builtin/checkout.c    |   6 ++
 builtin/reset.c       |   4 ++
 builtin/stash.c       |   8 +++
 t/t9902-completion.sh |   1 +
 8 files changed, 148 insertions(+), 44 deletions(-)

-- 
2.39.5 (Apple Git-154)

