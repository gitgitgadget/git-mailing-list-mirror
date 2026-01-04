Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19902749DF
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767522475; cv=none; b=Fsq/Nn3voYdFG8tKBLhP+crJrIGYCs+9alehKlYZ9jbK58HDQRcltAAs3WrO8gu+zJx5lobdMTeb+UKRT6nwHHIRfsSuc00dgQufca72hgrNdx62Y9WWdvnyvgBIXNTUZZIKRqOlUzPIneRBh6blgLAOFuirOWh1kBoXpCJZXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767522475; c=relaxed/simple;
	bh=gbLr9LjaMMn7If0pVCcOe0LjKSoi5uC27M8Owgvljc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3BvmT2Dh7br0zOj7eT+hwp3eGLstXQoMh+tfSsTQIBqnwR4d/jP93cvPO3mMpV/1eKPSkOiFKRsO3/puo+328QI7AsWQ2MivWiGThK9W5N2xTesUiPRAckXk37H08E3HrYibcbZW0tlqrdsohBbS3VjeDB2FCb9Avv+Jo/UVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqFxTuHV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqFxTuHV"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-595825c8eb3so13349457e87.0
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767522472; x=1768127272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbLr9LjaMMn7If0pVCcOe0LjKSoi5uC27M8Owgvljc8=;
        b=JqFxTuHV598xCG0nW4wcCwzgeoVuQq5F8ujiPOQAi4keUfwS1WtR/fa/IcWqla5BPQ
         tz9r+UyxZeWPg62A+wqmU2NjviV826a2xFuBwlODknAqk4hvivIcVYc0U60NYU1wDuxB
         WLspJ0SEg0jhMI84Ev9kZAkTAfpuJfiQONxm6wJFmzZLnSOOYRGjZ+VY9LRe0uc6xyrL
         gxhWai4NY7Fi1QYT0e2KrB8ngGWouVhWWVriA5iqGZmdkSGXQsB/qK1gTIfT8UQiXAOo
         tHNLhCYhGT3M6sr2zDlqcKEqyY/9StwN/YtkuBJ5VcPqJuF+iadguJIsnUoRSYosjwyA
         2CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767522472; x=1768127272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gbLr9LjaMMn7If0pVCcOe0LjKSoi5uC27M8Owgvljc8=;
        b=RJsXk7G5R2PrjVsdYClhDDGqyGWWu287WkLL7mR9UJ+H48UwNGpo+rpWm0mXLALg+K
         jyK5QeAoypnL2JBaAHC24rQE7Wuhb+WSrUgchz7lRrhH+Y0ioZ/bCM/ZpvPWdca5SIpA
         EnevYwWjemFJOrVxrhrQoKzoH/P0QaxBiD7+JD0s4bL/TMdcFeA9YnZt/QdJ9zxRG193
         LshSVJ5L2QkMlvBCdQJV0GKB45obGy/HHVXQO1N7mjacy5CaF/Ol3xXi96yAuapj/yTL
         vdHzWiQcObTRQaQtXqAmZE+N+Vjq/Vfr5gr8RomROBtM/OwhA/5bWqRnmvu5bLOFlSIO
         5LZQ==
X-Gm-Message-State: AOJu0YzK5PTeMOYbggzMUNDSsjYMLAk4S49fiVxbeU9idp7/Tzat4QTB
	TnCn7/p/AxElKjEKQEy4hd6Pkl2ls/8vqhBr0p2/tZQyNmmZKyoD8LIu
X-Gm-Gg: AY/fxX4yI981x3xbtoSgJ9o6/wq+aOkymQbKNDz0adDEN1jVNhyQVZuPd9LzZzRBF/z
	VzUuA+fvJrcJSc6AlEoiOfQlryBVW9ZzSuaiGRoMmSDy4gEM5tO2Ho1PZHL+faRsmgI34F9Afnu
	UJx5RZXQjQgFlsvcQ3PELMjxH4LsmK59gkoN8IvoW1tMe7fQcUetzSWV9yrRkgpSMY7bAeF3CHD
	JS+CzPC9v5hwy9cF1CXtiHwQr4YUttg7ZgazOrDPaGFDuvzzZCTRsXZ+t1kU9ZJF8jLerShJgKW
	32WL3gyXEZzcPuuDfVZ8LsYKkTbJLjUBGsy7n2Qwp1z3hCDqrnxV/ebFhyRrxfX/fiwRyZoPGro
	w6Pyt4B2ZSntcn4BO3dIraYT33/ZNFH59/Yg+bJtwFKLq0buJVGr9mjynqrjaYfmLerBbZ8V6de
	lBeLQgG3hun5W0nqQ/Qv1raAHEpMN35p/VdZ12X2+rKExNl/5ft+wZ9Oa3DwXjZedoD/GWKwM=
X-Google-Smtp-Source: AGHT+IHp7g2JvDSVoZ2TjETjMhSB4k0n0E0tZHmJ5hHcjqOWDFBiSJ5vsamK6iwQedPOdQMBTFM9MQ==
X-Received: by 2002:ac2:4c49:0:b0:594:2a0f:916f with SMTP id 2adb3069b0e04-59a17d5dd7amr15446527e87.43.1767522471546;
        Sun, 04 Jan 2026 02:27:51 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5e5csm13777638e87.15.2026.01.04.02.27.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Jan 2026 02:27:50 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Another look?
Date: Sun,  4 Jan 2026 11:27:49 +0100
Message-Id: <20260104102749.30950-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqq8qeeng7c.fsf@gitster.g>
References: <xmqq8qeeng7c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> And if the new calling convention is to let the caller be responsible for
> calling stat_tracking_info() and figuring out the base branch name, it
> probably is also better to have the caller handle upstream_is_gone case.
> This is especially true if your plan is to reuse this "branch comparison"
> helper to compare a branch with another branch that is *NOT* its upstream
> (e.g., where the result is pushed to).

Done, will be in the next patch!

> IOW, it smells to me that leaving "sti" as a parameter to this function
> is an incomplete refactoring---I say "smell" because I haven't seen the
> other, new, caller that will be added in the future step of this patch
> series.
>
> [...]
>
> As the code already handled !sti, which is equivalent to (!theirs &&
> !ours), in the original, !theirs here meant (!theirs && ours), which is
> (ahead && !behind) in the new world order, which we see a few lines below.

This sounds reasonable, however, if I replace '!sti' with 'ahead && !behind'
then old tests are breaking, one why to avoid them breaking is to switch the
order of these cases, to this, would that be acceptable?

``` } else if (abf == AHEAD_BEHIND_QUICK) { strbuf_addf(sb, _("Your
branch and '%s' refer to different commits.\n"), branch_name); if
(advice_enabled(ADVICE_STATUS_HINTS)) strbuf_addf(sb, _(" (use \"%s\" for
details)\n"), "git status --ahead-behind"); } else if (!theirs && !ours) {
strbuf_addf(sb, _("Your branch is up to date with '%s'.\n"), branch_name);
```

> Do not compare with 0 for equality. Instead write it like so:

Good point! I will upate it!

Thanks for you continued attention to this, much appreciated!



Harald
