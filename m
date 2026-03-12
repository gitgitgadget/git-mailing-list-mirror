Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500613C552C
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326690; cv=none; b=c2Heedwp6vwHScKFxsxPBY3OJ8Qm93sCVmxFzgngQIrqSpfYjL2rdZgexhDgK5iq+zL8T4qaLNXuElmxS9kBdMapUYHjVGT++rpcPPbuLbrZrWm4KMhh1t9wC99kCNt8NMryJhGTCkK+uyWYmWfaSEOSXRXSfv2Wtvz1ih7QxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326690; c=relaxed/simple;
	bh=MBs5i7Rhu/DZHtG/w6RrYANH2JcjLi8oQeIEz66EQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dj7LvXbvpKdRfZZbc3JzMs3yQMAZEvkExa/CN548mfPvbGZvw0cRLlWVz66ECinyI/rJdBtU+s1ciKdLOgYntRYNjbUpkWlsPh4kfbVZzVF+CBro94+z1/Ihr3N2BomY3jU+RVwvzhiTPCgpht9U/2OBS4R98BP40tbUYi7XPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQmap+M/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQmap+M/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b94a19fdso1097108f8f.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773326685; x=1773931485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWRy6IyehC4xxNKo8K9pyyCjpWYQRLolAfcbI22x2NA=;
        b=mQmap+M/RGnlMSAhOk7fOtNmguO4d/i2CqqZM1YRE+s0VA42ceFza1UwATcVYqaGzE
         2Q8e+TqD66/zjGhiB42SEmMeYnV+4WCEToZ7mm0shPsRnQZibYx1J97b8R895FL8EIcl
         5cwMOytHgjbSif0HYop4BUENg2wLaIVNurqt7bzv8tTwFrGTgOqcT87kzmywHYz+uJ/1
         AAArDvxg1AJ1n5T5H22aXlAUGca8KHzg9fZ6Jh/2sZB8SEUTiquGzFNot0okbwfeXk45
         aWeOAMw+5FFyrUGp6bRQU1hh3JdngdgYCRBlXjV0P9m2gBv16FgEG9IUCv1jX9ptt+TP
         2PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773326685; x=1773931485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HWRy6IyehC4xxNKo8K9pyyCjpWYQRLolAfcbI22x2NA=;
        b=Lyrlu+V7mFR3On693l9ZzgSI1lNvhMoXbVIdFZ/8Ov23x5BcLeLL10xxTiO56tYFMx
         +K3GWkvpPfMnDmkly5hw4ZSknMhSfmweWfihybv8dugKNuzpK1xZWDUbw4W9GZDUvR9m
         YsUm2Fm4jcL0jkzJ76EgNgVira51B079+60JIrBTdYLacMzR2i/AEBaCt/t3ITb1+nUN
         TMt88wXlCLdkxajC3T40i5SSHwN5GPti2gqxhELs5XMA+7/VkgVTxXUszU+85ASlY6CF
         tionS08MD+WjR9lP8VlgxLjT8yRLmGO2bKFsXDspAqJvd5tVr6oU7nKj/m923Wia/W9D
         ZQ4Q==
X-Gm-Message-State: AOJu0Yzcn2SMlQdDP7wYb2JHLjfJecrZBw8ln9AVOxzvYscuIoP47zVP
	DrATSvWD6a+XRE1U/6pl7tPq+r0BtBWxjTptYId6VqeqMEmytAPzbzesznzcKg==
X-Gm-Gg: ATEYQzwBS6MYNoF3vxNukEYA8ZoXl+YhXnmIA7UquTbSOuLI+4XJtYW/O1u2Gzbkm2f
	x1b6IU8hNaEdkKayZ3CbGZP1DjFpdwIi2+Sd/J/qFsidCXOdbxh17clM7NC5CC7LbeDwZ/sVPuV
	Cnap18imgkX4YHlEiNVvTOZGl2+UoyWRi4JQk1Ja/5SkLr/JssosOWga4TH5lUuDRpDFSj9FTMU
	wnsPHt7bLugFLpPbHB3beMn0vrqxDrHs3k6yj+wXhVV4cfALwpMsuCROaxdESVk+3c6D50LAok2
	U7TVItTNj3d/BIkgYDZrIDkK1msKuRC9PbZ+i6+qYejkNCn1qXnfUXFn3rAQbNNlJdM3M2ATbl3
	C4skdtUMzH9cssQtYseo7VMQTgAt5LCKOT0I5HjoOPZGHil2xdP4RvqSL6QsnmbP8dgOSLLddd7
	BgJ9zrvrD8PnfskAs=
X-Received: by 2002:a05:600c:4710:b0:485:34b3:8587 with SMTP id 5b1f17b1804b1-4854b0bb77dmr112365195e9.10.1773326684638;
        Thu, 12 Mar 2026 07:44:44 -0700 (PDT)
Received: from fedora ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm130688015e9.0.2026.03.12.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:44:43 -0700 (PDT)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	l.s.r@web.de,
	ps@pks.im,
	peff@peff.net,
	gitster@pobox.com,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [PATCH v3 0/2] run-command: stop using the_repository 
Date: Thu, 12 Mar 2026 17:44:35 +0300
Message-ID: <20260312144437.626392-1-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311151923.4178655-1-bkkaracay@gmail.com>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patch series aims to remove the_repository dependency in
'run-command.c'.

The first patch removes the dependency in start_command() by replacing
the boolean 'close_object_store' flag with a pointer to the target
object store.

The second patch handles the prepare_auto_maintenance() and
run_auto_maintenance() functions by passing a 'struct repository *'
parameter. With no global repository dependencies left, it drops the
USE_THE_REPOSITORY_VARIABLE macro from the file.

Changes in v3:
- Added the second patch at the suggestion of Patrick to fully clean up
  the file.

Changes in v2:
- Dropped the wrapper approach and rewrote the patch around the approach
  suggested by René.

Thanks for all guidance,
Burak Kaan Karaçay

Burak Kaan Karaçay (2):
  run-command: wean start_command() off the_repository
  run-command: wean auto_maintenance() functions off the_repository

 builtin/am.c           |  2 +-
 builtin/commit.c       |  2 +-
 builtin/fetch.c        |  2 +-
 builtin/gc.c           | 14 +++++++++-----
 builtin/merge.c        |  2 +-
 builtin/pull.c         |  2 +-
 builtin/rebase.c       |  4 +++-
 builtin/receive-pack.c |  2 +-
 run-command.c          | 20 ++++++++++----------
 run-command.h          |  9 ++++++---
 10 files changed, 34 insertions(+), 25 deletions(-)

-- 
2.53.0

