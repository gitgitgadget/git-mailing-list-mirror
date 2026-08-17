Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A42EEE99
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955548; cv=none; b=pW2+VBAfZ0QJnWaWfD5iurAbnsWSZFR1IjiN4evuj6LFnuL5q7I578xGnmDBElm5B02cPv7tQAIpZeCqhSeWlMPAqY7e62WFSl+FmHg9rrGzTAC4YKi3vB8PyeDqdRhq4HhIHV/mU5FhCTfYJHskDzX09rwNqyexfBbOAAHH0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955548; c=relaxed/simple;
	bh=chXODBFG+Ykn+AbfB7/ooSX/zZjBuHWRjrxB/FCvemk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK6yCAMYDboArWWI+AORlzjI0kNCOVhsdzGXv6pbLFt+UA/mn+KuZb2VrZ6XnB0FahcZ1Fhn8tXJMYJybVkEMglOiv7d6j1XKK8f/NHPaLCrMWk11Ms6woBagNIhbMNaqodjEFti54XiSnaFOyYltb1VaM2cEw1hKze63I50ujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgchwyBs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgchwyBs"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so2484944b3a.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2026 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786955546; x=1787560346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=chXODBFG+Ykn+AbfB7/ooSX/zZjBuHWRjrxB/FCvemk=;
        b=JgchwyBsmeYHpZzEEDTtRAZFvHv2jcgguwhShDBl0h6ie88eU/ESv6xq79oMhbggsx
         hczkG3rgrMpxrbBUOcfV7UCwgq8/d+zEXKxsi5a/uia86rB857Boe5jXP0mP5Bsp5QLQ
         c4EmFoVgMNhzJ6PrT+zXkUTkXVOAfpFvEtnAeHO4i+rv6tTv0PZAOHR0G65vV45V23Cu
         55zBleVpitVQxBjhrR4aW0lpY3Ss8tMovpWtKOL+kt4Ah81xxgpEMx4BTvR2fTopG1rG
         X+TACICsX80LSy0XtfSX7t3l666FPI/fIKIz69FrqfthuQORdxG3Tpo3cJ2oyUzT6Wgv
         EgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786955546; x=1787560346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=chXODBFG+Ykn+AbfB7/ooSX/zZjBuHWRjrxB/FCvemk=;
        b=KSaQLuMZtvzWv6/tHLfmNhXudjm41j7cJnKlYkBPr53gx/HysF1MauSo1QMGJiFHaF
         3jlFxI9BYom5SKrhqYK4sb5ipEmJfn10j9DX9AWOh+7tn0BJykSOrTAf5E+h8OwX2yVg
         PGItYbC9QOExQtjx733foZkmf+764PVF0BrbgfrPgQdws0UfxjGPaYLCM9H3DxcakvnN
         DKc+7dlJ1JSPprROa5t+dNX5mzhGNVvhF5zD4wYTX6qs6xHR2gvNbIl3xZWZMUaJvuZI
         F3aQDuULc1UsCMfWEj6zBLcjDJhldqV+VSSrVckDx/YtK4RzMffGgsaHxtGrRVqqdCbw
         CYqA==
X-Gm-Message-State: AOJu0Yyvyn/VTVT6Qx5mQcAlenNJMv7iWZC/4dWfFr8Uwqo0UgmWdvRL
	POqCMymjE6NRyjA6cloaaNvjU92/cF4jprPsdJWNhhWDTk1TMJxUX7na
X-Gm-Gg: AR+sD12Nkt98nhntnfS47napIVsgEV2o9Q1wYiL7e7Twwyhl0P/dH77m9q2ttPooKJK
	oOZSCzuN2tusdxtXkkEGmaW1YIKBDYNADIfkMizW6bT30GIap1v4cYb6I3Afr8tuW08MFwOpNI4
	msmzHmFt625J8hEKlo4O3rBj8TQFLkbdg78SPmeEhoBEPAL7H9nWwZm0fMopmUTdnatH4TtCRGa
	LLeMPbAAoagFdy6EKhvVeQKJJi2pd+xAPUn+V7HSM657k0Mhdbe05YhM1ESbaXa+0auOUrO/9QL
	GhFS6xyx03JcuGZ/cGby8OGpYeAw+jG6bSzeWl46lSeWUbP1mt2X6jYXYBLj2wCH628tJTvKzah
	wPWrSnIJK+b69qnAdskxh1EQqDDGAJbudWM0DZBA3lIzdrHimOJ+82J1u0sq6EZvxcnOoPFg01V
	+suj1IZQgi6DNlJl3G291kWyv0b2e+pofzZrix46dMotHQMyf5BqWIgjgTKwiqM93mfRKnfvNRJ
	yajQXHHW75TdG8ZF+8v8Tpb
X-Received: by 2002:a05:6a20:d498:b0:3b2:a809:1000 with SMTP id adf61e73a8af0-3cc71c1e647mr26922234637.3.1786955546590;
        Mon, 17 Aug 2026 01:32:26 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32678dd22f7sm6369234eec.1.2026.08.17.01.32.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 01:32:26 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	l.s.r@web.de,
	Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] object-name: avoid use-after-free in get_oid_with_context_1()
Date: Mon, 17 Aug 2026 14:02:21 +0530
Message-ID: <20260817083221.83212-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <anltEAohp3F9Jbx5@pks.im>
References: <20260809194212.77439-1-diy2903@gmail.com> <anltEAohp3F9Jbx5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> But I won't insist on that change, this is already a clear improvement.

Thanks for the review. That does read cleaner, so I've included it in
v3.

Shlok
