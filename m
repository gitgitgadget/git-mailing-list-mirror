Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A03E0C79
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648277; cv=none; b=EDKPU47pp/lxIaEq+NqAB3EmPCBOUtZwq3SjsPpr5nQOT5OK8F2mI65/m6VBvnbAP/Uf8vS3wUip9Nq2tPk8eLEnAR9d3ij38uQeaUzeycV56Fu4L2y7smFBtCil0jltQ5f/HnXi57rkViCST25C02BUoYNyn72o6FTUeCuIo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648277; c=relaxed/simple;
	bh=hZV0uhFPXXf+eWP3hpCKX2OsLVxr/qGaOEQ7MzZtjsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKxrFkMoi2afRRMrdmhlCeM6bjtnVboWZRfcBTp0mXeHL2kTMgUKHnLv0BcfKDwSNvC6NZApUerMc9eNf2iIxXu+YcYCDJITG+kgVxV7DiY8eKymAft3GWMui5ufah5kSJevEqpcwslCBlrXRVmTaMVCSAKVxREExMQi8AyUC6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlVvmLkM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlVvmLkM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2adff872068so35383485ad.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648276; x=1773253076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZV0uhFPXXf+eWP3hpCKX2OsLVxr/qGaOEQ7MzZtjsc=;
        b=LlVvmLkMKlI6QtE/wn4Iuwtj2xqL+zkTuRZUneXlsdjsZSObVDv1ttLdwCFFoFX6+2
         Ds2SPCrET8UJ5zGGWygA1RrURlb1au/6Q87kw5yAXQGdfjszBN2BRNrTWp3dy4yoidtv
         n0x7SiSBCrnff/DtuYcndB44yxc0PkzH/l9ZSJS2SvzktsZiKfLDJRtGtj5WUIwrk4Tj
         XiO4VwcyA+IloczcdrQ8wJ7KKsQeTg1u3YOGQj6LnrtYHvCsSnqUEjH1oU9DVHMFCX5g
         IVrG58or0M/Xie6oNhKCYEvoknXIcsQYmAQxOf3m5DFBRQESEnoY0p5eocudlTPmMCWW
         74aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648276; x=1773253076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZV0uhFPXXf+eWP3hpCKX2OsLVxr/qGaOEQ7MzZtjsc=;
        b=FDHUf0e8PKFoxqdxPokQkNWx8xXPT9bf9DPMFDbW/tuyLdFnpOQDo/7lEmTWUDwomp
         uDXEjF8xhvTzFJp9Vc/e+DT0PbmJepW+5h0HOmibJjty+0QmaXe7VFUIJo05mBdvuVDc
         ordBhDNafP/KkUFNH4cNtGDUzVSu6r9chEifK4bCS4ZTcIPuUS33vF6H55+A2eRH8bKA
         Fa0vFB12+d6dzkS6UMekYW0kzGkHR5mYqam3TbEu2ENV6yHDPYCTiFkwgyK98+xQntkl
         /T1WVDjrV6O5tQxdWwxAcxXh1GrjiaTJwZOMQsW0cIE3oqq3EWwAozPFK3MzwpbpxQCa
         gJnA==
X-Gm-Message-State: AOJu0YzkXFCrplnIu8DEg53ccwjHQA5Xelybwdxvtfkrhf5DOdcmXUl0
	qU2E6puzAsIU/qU/mNCUcThtq1XwPEn4xxlvs3SiC6dap0zCE2jtpD3HQ7kXug==
X-Gm-Gg: ATEYQzzVtBxSppCU4AKszdeqe2Hp1pEiKGKQ+LqbyVTT6aYQ5nKyZlYBjNCHqa1898n
	w9z5f3MnjEde+q8Gmu8gZVbcvL2N00mo4zx8AGmSit5jP0WBauHz6z55t+t/0AV3RBkIYvECbsE
	49W8DjqY7X9zPTdACi5KJNN/enLNhtUWi9iq8H9078g62SL9hWsE7wcEEmQ5s8Hyoj1I5uFVzv3
	MnMEib2lKn6VHsDakPm7cIGut5iLwOYBm7Px22pW3gkj1sC/c8/mqdtbwSeLz84QKDg9xEoYpG5
	yC1wEDXwS1FyoExF8NLgVduFn+6wjGJrDOD+kbXUnIvBXHPFx6RlEZA7ye+mwtvkLgjT+b/psjS
	jfXkqKH6e8pXMYwA9DoWKlY6MQPKIAIkx4ozqACvJwdTthesYX79Til6FfdonQtGIjA05voqXId
	JaWkEbmPYu6dkPGgL68CV+MfW9zUq6UMBDJG+Kp3UVGiG6xbC3ho3lclmC74EJcXz3Br81kxbTC
	qFoJmrblQ==
X-Received: by 2002:a17:902:e5c2:b0:2ae:3e4a:3cb8 with SMTP id d9443c01a7336-2ae6ab75d62mr31879975ad.53.1772648275506;
        Wed, 04 Mar 2026 10:17:55 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4cd40e4dsm105026405ad.92.2026.03.04.10.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:17:55 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v7 10/10] fsmonitor: close inherited file descriptors and detach in daemon
Date: Wed,  4 Mar 2026 11:17:53 -0700
Message-ID: <20260304181753.25787-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aafilb7FnvWBTQ0J@pks.im>
References: <aafilb7FnvWBTQ0J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Patrick Steinhardt wrote:
> Hm. We already have related logic in `daemonize()`. Should we maybe
> reuse that function, and potentially expand it to handle closing all FDs
> up to the maximum file descriptor?

daemonize() does a double-fork with setsid, which is the classic Unix
daemon pattern. But fsmonitor uses start_bg_command(), which forks the
daemon and waits for it to signal readiness over IPC. If we called
daemonize() inside the child, start_bg_command() would lose track of
the PID.

So instead we just use setsid() to detach from the terminal, and
close_fd_above_stderr in run-command to close inherited FDs before exec.

> This feels like a "while-at-it" change to me. Should it maybe be moved
> into a separate commit?

Done. Split the 30-second stop timeout into its own commit (patch 10,
"fsmonitor: add timeout to daemon stop command").

> Might make sense to reorder commits a bit so that the fix comes first.
> In that case we wouldn't ever have to introduce the timeouts in the
> first place.

Done. Reordered in v8 so run-command and daemon detach come before
the test commit. The meson timeout never appears now.

> This change feels unrelated and is not mentioned in the commit message.

--start-timeout=10 is now in the tests commit (patch 11) and documented
in that commit message.

> I thought with our call to setsid() we're not part of the same process
> group anymore. So why is this change here still needed?

setsid() runs inside the daemon after it's already been forked. The
set -m in the test is about the shell putting `git pull &` into its own
process group. Without it, the background job inherits the test
shell's pgid and `wait` stalls. Moved to the tests commit (patch 11)
with a note in the commit message explaining why it's still needed.
