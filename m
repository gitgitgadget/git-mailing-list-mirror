Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DF1F37CE
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080888; cv=none; b=VXw2V7bynxruxwqhgHReIhyWPhqxQFU/WZAhasVXCJzrPpsgStSaWqeOG7zOZVenhyIjpsOpeg/xgtxH3ATXXUkjGNkaxp/F/CqDdBZJX9a8Ve85/OMdSC3UP+wGZhtj07J+kAqZrlorcmv3yLYS9llcU3E7anppV5Qiu3OZq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080888; c=relaxed/simple;
	bh=AByzqV2DCaZSUYrDi0/eKhk6yDlYteotDl2qynjEif0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KUQG4e/il3/D/q39xx4qt90L/bLu0moCI7o2u1IrAeSywiZJgG7CPBgtyjPkc82JFITY5/wNQB488RWrJ7zEBrrQ8vrWFrZzaTyVZ/CS1MqBoPK1ueERBVafj/yqBb8Zet4CRxJzbnoKGxQSEE9Ny3/CkDdc3zSmFIxEq+P2vxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYAIhJdQ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYAIhJdQ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3983426f80so4500267276.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 01:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741080886; x=1741685686; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AByzqV2DCaZSUYrDi0/eKhk6yDlYteotDl2qynjEif0=;
        b=AYAIhJdQHFDxUCobpjEOeVEVT97s49XO0RjaMaWmlxZS1nzrfHxrlMM6Z5XFiKdAxv
         noEPjVo88Y+yeANpWhncOPchEGRjHG6HI0HG4G3tCQ7U69hApDt1l7A1yFvbh44s7gsB
         xfDxrLVVSW+g0rSPc8TvmUzuJWkuZT0tZI8A3mVEjjuSM/SLers8Se9CMkl8l77t8qaz
         craSNxqfsgGF7j1ngpvvrzhZO090yPgROHg1pC+9kRlcTPP9J9Jm5pOn85SRsHEzehga
         GEX1sJT0EsXNDig6ZkbIaAE6WkdG2SGsDDO5EgeNogIleGIFykMdZBSAOlrzxg7EeZQg
         9hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080886; x=1741685686;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AByzqV2DCaZSUYrDi0/eKhk6yDlYteotDl2qynjEif0=;
        b=Jw7GFfwzkx2IfIOMCb5iT6vCS5A7pt/v95tXiu31btc6wyW1v9EdJLTUApKrPVOpqi
         6KCF7VnVphFRUW/esbb1pPqLVfhv2GRttxMkmey0KXEFGUJi6BNQgHs+LMm9RDyLcPeT
         B4+mbh1jePg8MFFSxOfNKjZcz6j9bpE5eS2Rt33/7YJFtEjgswyoHXbgFcjaWxi5w8Ia
         c/KVN7uyWQ+ccO9E9aFKipbde+6YCp3mkYnMTcQ9iIRIdjGC+WkDDLTdU99ndLJh1afj
         QTbYotxRmKk6GVGnMezB4EFpV9HVU8RGAr4VkohACyu5TwQ3nNnht3PJLLISFJXbGNqC
         sTTA==
X-Gm-Message-State: AOJu0YwXKEQOZAv1QtVUqWGp9jNKs5LpKFsD4L+qtPyiqxg+MEfdygPN
	TszrTi1tjZHW4vdoTK6GE/j/2ljOMFvry/8WZZKU07lVNcyfpnj+nSoGA+eXfpC5cXCDqDysTHO
	IBepTfc5wbRq2fGJNTAnTaTkfaYh1YaiPDto=
X-Gm-Gg: ASbGnctqQcPjz1n6UkZjUpIMJAitGLHvfbeBfZxkSi2ipfFmwRAAKpy0dlLlgBfRhJn
	7y3KzBTzwqwWLA2qljBgNo/Q77sWzWRnxULY9qEUODHZuFpAIcrv2ZQ3UxzzrvQb2LaEAJUDq7j
	WVJLDy/eUKqSMHvHsupnZtTCOlCDc=
X-Google-Smtp-Source: AGHT+IHg38+RFtS2ev1CGPJyNSOl81dKgKaf2qE3RMqQ0EsWxp6Pfacf5myIMEhqTEHblJCFqCJPcf3y/aqaO6t4ACY=
X-Received: by 2002:a05:6902:2501:b0:e60:a70b:23c9 with SMTP id
 3f1490d57ef6-e60b2f2cddcmr20369112276.32.1741080885933; Tue, 04 Mar 2025
 01:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hisham Hasan <hishhasanstudent@gmail.com>
Date: Tue, 4 Mar 2025 14:34:35 +0500
X-Gm-Features: AQ5f1JovU94VNTvS8O7wHhX_WW7Q_Vfg9n-AbzifOSKV77KE1EJ_8n6p5CV1JQg
Message-ID: <CAPPeA_SNEbXMJnz=-qAjNoJZFWxW1fV0yQFsZYzW9VcwEUOSjA@mail.gmail.com>
Subject: [GSoC] Introduction and dev environment setup help
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

You may refer to me as Hisham (he/him). I am currently doing my BS in
Computer Science.
I meet all the eligibility requirements for the Google Summer of Code program.

To begin with, before I start working on a microproject, is it
possible for me to contribute to an even smaller task (A
nanoproject!?) that pertains mainly to something like a minor
refactoring issue. This is mainly to ease myself into the codebase,
meet with members of the community, and gain a better understanding of
my capabilities here. If this option is not suitable and it is more
preferable to start with a microproject, that's perfectly fine as
well.

I have looked at the SoC 2025 Microprojects list and the SoC 2025
Ideas list. I am currently setting up my development environment. I
have cloned the git repository to my local machine. I would like to
ask some clarifying questions about setting up my development
environment as I couldn't find adequate answers in the docs.

Thanks all,
Hisham
