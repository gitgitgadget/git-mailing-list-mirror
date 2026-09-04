Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E9D3D9041
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508430; cv=none; b=LymY7MNTGD8TR4u5MQm+G82DL6rC6ZXykj8HLebmuRCMmxSid8naEzbqCGYSlakuMLgl6CoE8V1450Xx5sfAPwwa/TX59vjRMz6z4jE1Ko14SModl7kw9YYOCPHj6FeF0YDFIY3egvEAntgB/ZMfGPbKcYVZvf1+meG7GbJ2MCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508430; c=relaxed/simple;
	bh=hMSrWieTm35NlUrfp5FV/1p4V4+87Xqe2vPnKQJ5xpc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZIl0wIXyP5TT3jAMZ6U2C0hNU8OytMhcHkp688ttYVJ69XCKw2kQzzAAsZRPPbBuzgwoFerxxqoM3Mjddyojo3h80XmHqE3BZxPAc2PBJoTtp4cxCjFSXtdJxCnWjp11J9cY9xtRdQPWpILR2gTsgaMCa/iTVccPusOuZ4r+MX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkUTTYcE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkUTTYcE"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93903d81a82so57695485a.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 00:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788508427; x=1789113227; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bqjebayDC8XUnhWDRMaUgYnLvabGJBcQSbgjkeyxLqw=;
        b=BkUTTYcEmeBBoQQ90EXujaoVqtSxyOFSTRwnPoFw44YWUc6HGpBN7kKmYdAx1wnFrY
         PN0WZTf78HHeB+iPMq8w3Jdd2B+d+OKKUt6upfCS8gqiIr/O8lwIndvRNc3O7oAqB4AQ
         sCN4P+WaTBlD+8xe2j9hyQRwE7a3BNj/rqJotlLvFwHfpGVydhQpdjYdugX6mxxqt8Wx
         7gAfVYfcpq8VjV7PFKe47XzmBWuTYgUPq4jMzshQFGXoAjabJvgIpuya+NibEwQkcI8T
         ZE5j8RAdaRzHhS64pf8X6EvrTbL9/Hq/exwN4RFmt4nbCWRA3uAwgx3rUWQpzmSvkv9u
         +RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508427; x=1789113227;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bqjebayDC8XUnhWDRMaUgYnLvabGJBcQSbgjkeyxLqw=;
        b=Dh/J5H3oRsHqMfG0Yr9VTMhhi5siX6nuXjJZQy2DkY2d4pEMsRurSF/F6SfK3f2545
         90nIS8kPVU1s47bvuz9wiS/4b5XpA5uRuRvQHCCMFGTYWEQ2YbGkdk/ouy87rH4MJL2z
         7LS3DOMSm5mOsbhRY7Eu56uiyBes4Oag1KIc+rRLxFn/6d4crVpDrJepFzkezFgc7f+u
         iFh7fbKUOAOXX648HT9BXWx1xijzZYds7DHyiiXzrnGj84IHV4SM5uSXyJQx574C7fpi
         KmInpv61S5SaLv9Wq+YsqU57R0f6XapNJsHS3NS6CX4bL93klWPeYoQwfQoRXWqjNkq8
         fVHw==
X-Gm-Message-State: AFuF++n2rKQFgCPIfRGSanuPioEi48YNtNM067yn3p1Noawh5HQ+oZeF
	ecsPK0MyeTQyxE8rwaFZr+Nf3PiqmbdT7AyRPoflJ6TzzHQmMS1yeuXTJJzhCFcE
X-Gm-Gg: AYBFou3vv0a+Ab0jn6/uBe9UNkIiE1i6NtG8QRLuQHcodwc1s4v1+n+cBu+SZCfB0aB
	FyDVOz0qlXTe0y4mYuAh43o9sK6GJQMFOUw4EjitB/VscioXAhrApINPlSQz40bXCbOr3ymDWcE
	5UvdLfM8Zo0MOftjkWBiMwUJpKerQDJxni8Sq0BdrxgtTj7nJM0Lv+PITedMke9SrmYzwq3G2bU
	xWN9RjiZ5wAGbjwithPZyNi6f1vKzuH/c0jIZrZzOoD46hTEKLL8p57AvQ+y/ef6iBm/oBrOjdZ
	5yCZaq2ZcszlwBjL1ibOyFW1BKf8Eebx0GKnptt8IxVaNp4QG0+NBiHaJdPYy2AXvdtP/VSlKuX
	hT4ToMlVoz8J48PpcNoQbbCIdBLfp8nTslgT+zh8kYq7sm6I2S9GRgGAP/SGlKxiam5RG+YIg2q
	HF52dObMvdImiBDJPB0WrfMjRCGOnfdwRTt6Myqxgbz0B541ikdljLXYJ/f8LyH5qh
X-Received: by 2002:a05:620a:4392:b0:930:987d:9cd7 with SMTP id af79cd13be357-939802efaf3mr451724885a.11.1788508427518;
        Fri, 04 Sep 2026 00:53:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.210.149.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb90d6csm156861985a.33.2026.09.04.00.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:53:47 -0700 (PDT)
Message-Id: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 07:53:44 +0000
Subject: [PATCH 0/2] sequencer: leave auto maintenance to the end of a rebase
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Thomas Bachem <mail@thomasbachem.com>

While looking into the rerere lock race in [1], the "git commit" a rebase
spawns for a resolved pick turned out to be about the only place a rebase
with the merge backend runs auto maintenance, and it runs it against the
rebase itself. Phillip asked for auto maintenance to be kept out of a rebase
altogether [2], and for the merge backend to run it once at the end the way
the apply backend does [3]. Patrick would rather see that discussed on its
own [4], hence this series.

Patch 1 runs auto maintenance where the sequencer finishes a rebase, as the
apply backend does. Patch 2 then passes maintenance.auto=false and gc.auto=0
to the "git commit", "git merge" and exec commands a rebase spawns, so that
a rebase runs it once, at its end. Cherry-pick and revert are left as they
are.

Based on master. Independent of [1], which makes the rerere lock non-fatal:
with both, a rebase neither spawns the gc nor dies on one that something
else spawned.

[1] <pull.2214.git.1788337897490.gitgitgadget@gmail.com>

[2] <ca3b91b6-254c-4b86-adb8-da3217e9f6e7@gmail.com>

[3] <86efb07c-a0ce-49b0-b4eb-7d6b4bbaeccc@gmail.com>

[4] <apkwpKTGaMwTf0Hz@pks.im>

Thomas Bachem (2):
  sequencer: run auto maintenance once a rebase is done
  sequencer: keep auto maintenance out of the commands a rebase spawns

 sequencer.c                | 32 ++++++++++++++++++++++++++++++++
 t/t3418-rebase-continue.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2217%2Fthomasbachem%2Frebase-auto-maintenance-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2217/thomasbachem/rebase-auto-maintenance-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2217
-- 
gitgitgadget
