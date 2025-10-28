Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB042EACF2
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687992; cv=none; b=qMn7uxvJ4LaaU7z9QgkKD+MCzYZ79mQKN+J++KuhvdZrNHI21blzNZCosJlXpXJfxV7TmgxRhKFZaHTjer9be4BtrF7dCzyeucWZzBD6XLjwQ3C5nDrmh67lvLwJEdCi5b4vDrd5rHLCbzBuIQORyb9OHRfMzb8LSz3cQ+AngzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687992; c=relaxed/simple;
	bh=c7zHYS0aPxOwcgULMEQGFRVzR7TuPNzce7/usx3rKiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObqpILEHFqkFi8gWXTmAdIOuVK5xsS7NF5c8H+KI8edV+2GHnptawwvQWhV3bT2o3L1jsMfj+YekQ/dyyakhAfeNmYBdrd3EiYEKCkAVvKPtiW74esdL+HzBlKSDLFqhVfRbEfvddYg6wPIu0XzGlX9A9e2LQmF+nU5HAiM331A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxcc9NAF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxcc9NAF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-294cc96d187so20297235ad.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761687989; x=1762292789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2BmJibt7RuBp7ck9CaYLcxRtdyx0DYj4AxYn8lPYbw=;
        b=Kxcc9NAFy2WRDevUJg23PtXvXOxwElYQk/aDhrmgjYgjvsg4zuafPoOo89xZfPpEti
         iqCt/V5+FVvmpRA00yN6e+wwnt6l6Iu1x3LHfWbtrsNigxkv2soIAGrW0YAhQH1AVWSa
         yHst7vY7NhnK2HqRGIENFop7QjT+6HXMk9t40j/yiWH470kaZSCKj3fkcQ/4+SWqmLBE
         JRHNGjwwIolc8Gczy28WNe4PDykCGvwgrWbX2kdGZ4b1yp+z+Fx1xhgwrQvijxAaJMOc
         xz84qieVM7owt4R7uVo8/AcVoZKi8b6vL275OSlVJAmU0yOYxJF5tKRxuTCiz1O2wAca
         eiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761687989; x=1762292789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2BmJibt7RuBp7ck9CaYLcxRtdyx0DYj4AxYn8lPYbw=;
        b=gDBHWQAs0mjqCorPc9ziGw3VF66I6sQ0DHu4arAgeh4NIKAy05RaiMdN7VoTesFyJ/
         lHSFno7GfRC3xhHVKV8W6cMGLJ7QcZjYCsToTaq7rvD91Z2WmcTwcMWZi/587wc/BA9z
         HRlhTgP3cvgA7FXvZvRhMK0XX/pXLeTpp+XueETPknIy6GZ8EliWGgQ3zvqurLh3cmJ6
         ahohw3FQ2siRJ4m4WYPEQNQ9AisliIGKlWIiovA79N/FPB6o+ZkJ18ddJeX10vvq1uqQ
         p5cEclafr7ep3+YgapbYTZQ2no5ea3P6Ganl0xZjxd+WZv29DAG5uorPcJeNncytzRze
         giYg==
X-Gm-Message-State: AOJu0Ywmt90deFw4npVWBmy3nASnEbVt7gEZ9yYkP8TLyQq59co1f9wM
	osKUlTOF7VNav21P/Ou3ivxmc+4yb5MZAZCQNk7xVGvPE5kJWwwfN12YPAPUyh1wvl8=
X-Gm-Gg: ASbGnctzsfieJcQApvWKcC3Ra1zCEa/w8B4DSVeJVepmpkKc7k+e7NFf506NlM1qWyo
	X//u8UB7oRt631MXZvcEolSMUheqkDa6/TVYICLZuu6GxN3riTK9xizdu3aX/0eGQjIYpmo/5Yz
	gqDogHgSuxzyVxbprCSRA+tG8no+2mOAXWsBwFGt6gcDzBdBxT5u6Oltx/rsLPUU+rSk0WLB70X
	zeAWQRaQGSVQqm/DPgX/ZHrMy/bvo3J74VB3ieFN1JR2+6CFrKDzVF4oc/P71+CoJpNN/a3EVs9
	Aatof86FEfx80im2dcxQoVd9yq5pBqz8fTm2zS7QOd6oVko18jOHLinpbmYHuQks+1O37SG3AKI
	dCrlAM5YWEQf+Llhzww5t7G627Pk6wsaVIGqGt/eajcXf606wPB0wtFy/ojP/wMLnIBw/tBC79j
	7a42W8nt2kJ037d7BBr+jI1/6x8AzrLZNUt5Hqp/tE1EXwyNlaaTgW9iSUQi6EmpRiDyjtZcjI2
	i7yHbtg4vGO0xpLmgxAYOzZaF0vkhlA
X-Google-Smtp-Source: AGHT+IGQxV/Sdt2ZRmiudEFd2bfJGdxg98XyLf96vtOaluh1WkR1ISXB6nYKI3ycM2lI3Sd1Nmlogg==
X-Received: by 2002:a17:902:da47:b0:290:bfb7:376f with SMTP id d9443c01a7336-294def0183bmr7063325ad.51.1761687989326;
        Tue, 28 Oct 2025 14:46:29 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42afdsm125645655ad.99.2025.10.28.14.46.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 14:46:28 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 1/3] replay: use die_for_incompatible_opt2() for option validation
Date: Wed, 29 Oct 2025 03:16:07 +0530
Message-ID: <20251028214609.10041-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028214609.10041-1-siddharthasthana31@gmail.com>
References: <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251028214609.10041-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding the --ref-action option, convert option
validation to use die_for_incompatible_opt2(). This helper provides
standardized error messages for mutually exclusive options.

The following commit introduces --ref-action which will be incompatible
with certain other options. Using die_for_incompatible_opt2() now means
that commit can cleanly add its validation using the same pattern,
keeping the validation logic consistent and maintainable.

This also aligns git-replay's option handling with how other Git commands
manage option conflicts, using the established die_for_incompatible_opt*()
helper family.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 builtin/replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc..b64fc72063 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -330,9 +330,9 @@ int cmd_replay(int argc,
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (advance_name_opt && contained)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--advance", "--contained");
+	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
+				  contained, "--contained");
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
-- 
2.51.0

