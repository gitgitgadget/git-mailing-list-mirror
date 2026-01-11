Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899B2AD20
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768111156; cv=none; b=DT82HWbhnJOt53Gu1/Jvjbna+Mn3RaribjGcMHQIcG8CqvgWlVzJg1rEhrF4bi9moc8rIZW5KwMD87bv19Gs/ZDrAy68IOkMT06rkAg10V2Kc/qCfbLgiW9+dVXHyEm+1f7++z7cgNUmsQHBZ/FTokBJ87hjG2A7tMBT8lf271E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768111156; c=relaxed/simple;
	bh=Uwymb28zXASsYjFgh00oGwtGgK+zTxt9Xssvy3kn/dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hiy0U0Vn5KrBzVCEiRBTOvDcAXnoiC6SFNEV89xJ3hAiTENKuSrzzbz3/uPlbRbxWcW/42SCk+U2hGCKTraumJcOkMZiPoVMbfQSZPsopnGIooswDxk3TR4I5ENcEaY12Cyi8IBADsQQ0W/VNFIqQX8tUQ86LFIrQNIfEWBkYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ra+oXgGG; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra+oXgGG"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ae53df0be7so8679260eec.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 21:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768111154; x=1768715954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRaz6uXnIbanbXyGxUWzqePL6xH1hNuuHvSZza5XUd8=;
        b=Ra+oXgGGcMZ3UmbDb18fATqp7YPHpJllaKeFCJyN3ghEqMX90g/+JwGbIk9vuH62MU
         zpFMoQKT5EVKxXer/bWpPo+PJ3D8eO07EffPZIwOpumc5qaho0S29GR3/h4uj3kJFrAb
         5xpViWlmjXoEJFrpcC4mUpmtABPeVKaQBV0omp66C5P2OW+E4nV8CzFcHzsjvSEjWi9C
         HHcdHUqSXAWL1iWXDMlBDu6FSBPKNozV3e3c6UAQCrm+YaWFfm5qHPXnQLc0L9e0efUm
         /D46LZbMnw8MX/f0jR++MQR0WOPK+CFvNl1AVL4DMvgL93ZQdk3ACACnDdG23vuK5sAf
         YcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768111154; x=1768715954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRaz6uXnIbanbXyGxUWzqePL6xH1hNuuHvSZza5XUd8=;
        b=GZx3re0TTGgO4QZUKEX/03IiXG4ikQJ/NHnxizriop3GGS5TFmmnc+geacJ39F77PX
         Ic+a9q5X0zZPfY0aiVaIapqDywTEq2AaN9iIh9MRd6und/Qsk0PjToCDGxz8bcLdsYkZ
         GD3lh3+v8O7AmMLU3pwH+F0iQEn9+sjFJucSGpwNL3LyDOymBxwnGDtrhcBdQpUw1IG0
         5A8jNrjBPQMCu1Z9nSRAHv3nhlIyr/9tB1uXbIdlkjayyaDa5WbkkRf4PHUV3z5YfBzz
         pZHlkbDq7N8GGA4XW07lXfeq4MQoAeGKRr2khsWmDZ3c77WiE3H2pf/hNtA799QeWiKi
         FUAA==
X-Forwarded-Encrypted: i=1; AJvYcCXrms/MoQK7XOKF2Jo3E6aHcewXBY3HZwnddfnEZPJ605UHcXilVKv4/NGo3ntub3bG93g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhuiau5AkFNcO7jHdtkTxngCam2k/BymUkDTGf5TOXMD3pXCQn
	pcson7dZEAaCZTj1J/vicsPssNSlpiQCDljukpzxVnE2JVtVjKOyfkaw
X-Gm-Gg: AY/fxX7DPEvgTPbFSUhVqDAE9u4xaL6L90V2pOhDbXKsqckEeBqxj7WiS7skEp3cZcX
	lcZ7ii0Inj6eFkesllgj8KLbSZl2Yvyu9w6TfRQiqdiJEK6NBt0K0QlThs6ju9IqmcZXe6oRvpm
	rOdHpx0mXSsXP3bevlUDJXtaT8ZWI5JCEaUigoQOmsloEXcVfBoSts11CgeAW15F7z9N3xLAPeF
	FFHSJYlKFNZVri1NVeK/0pDqulOIqd4DDMub6PpXQ67jGkMoOGu39GZcyh5p5UUGwRohpjl0vAc
	bGWDTQb3NKZMc+KEKmpzxdwoN86IeZDfUiwe882EiCRKO4z9M8zZfcY6L3hqUaV7z5agbdNQ3Z1
	7b+5tWIuxt5nNpMSm6aVEYXzlurmofz/Sg5/D2Q2HUqa7q3ptJud4G2fZ2fZi8WZVpeddlkBNJC
	Gs0XZIR927a6c/C5RDvLTYU6rdzgBte3c=
X-Google-Smtp-Source: AGHT+IGeSXpONRFqfH6eBx4V16xDRB7V2fnZOu+U2xlfT8mSyWbq7Z5MC4bSpnhY1lcl01iJYYnWeA==
X-Received: by 2002:a05:7301:314:b0:2a4:3593:646a with SMTP id 5a478bee46e88-2b17d2e4f68mr11035346eec.26.1768111153942;
        Sat, 10 Jan 2026 21:59:13 -0800 (PST)
Received: from PW0EDBZC.hsd1.ca.comcast.net ([2601:646:9e00:ecc0:93a8:3b8e:dd1c:9340])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b13bdsm13215133eec.24.2026.01.10.21.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 21:59:13 -0800 (PST)
From: Elijah Newren <newren@gmail.com>
To: Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] Some 
Date: Sat, 10 Jan 2026 21:58:57 -0800
Message-ID: <20260111055859.408891-1-newren@gmail.com>
X-Mailer: git-send-email 2.52.0.410.g227cdbe8e36
In-Reply-To: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been waiting for the history series to consolidate before
upstream some local GitHub changes to replay and adding some others of
my own.

So, I figured sending some of my suggestions from my reviews as a
"SQUASH ME" patch that Patrick could split up and squash into his series
might be helpful.

Plus, I noticed a bug (pre-dating his series) with handling of detached
heads in replay that has propagated with his history stuff, so I added a
second patch to fix that bug in both replay and history..

Elijah Newren (2):
  SQUASH ME: Fixups
  history: fix detached HEAD handling

 Documentation/git-history.adoc |  2 +-
 builtin/history.c              | 31 ++++++++++++----------
 builtin/replay.c               | 10 ++------
 replay.c                       | 28 +++++++++++++-------
 replay.h                       | 21 +--------------
 t/t3451-history-reword.sh      | 47 ++++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 52 deletions(-)

-- 
2.52.0.410.g227cdbe8e36

