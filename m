Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B030EF8F
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622391; cv=none; b=W+iK70Jg9J1TUgRSahdnSZA363NwHkEeUm0gSQLeRXsBt9golOpSjtLu3x94nJMbKJjLCMvM7FJxJQniKW4HF0miczgw6n3JhBm3qWPqCSsEkyFNTOxA4hstB4EYQWdNFbWKqyRupTQCey/NNYYFhj1wHPKT9xlZcDir4cwGHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622391; c=relaxed/simple;
	bh=xztSemg6oCdhqdKZkcXWWUlIRQ+IJPqvZj/UPxij7uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eplpWda33L/KGaoJzQ4Xyd2nzQ8SAtouzbU8E2SwYpUzfwcPj/X6RSvGVrJWAF/MwfMQKMo/o97khv4Ps2fdE47HSdDOx/uVBHYS7JI5nxNlfJAlmF8NZLF5cNGwuQIgPfHk6kp/vSkxtILY4Q4lRSOpsCWAkV4WIOwDRqnFzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1opL4RO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1opL4RO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8296dabef74so5499249b3a.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775622389; x=1776227189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xztSemg6oCdhqdKZkcXWWUlIRQ+IJPqvZj/UPxij7uk=;
        b=U1opL4ROYMb2k+lNdNYNG2wjrOcHwEx8DdZg2vvdPWoQuZTqFe6l3UARDqmMEBAzsJ
         NeiN+e6QJYIbAeJlqL/ikbFU5kShhNwhlwi1s1ghh1n3TT3jZ6jfjFMz35QvJBIzHtYV
         nFAad1oqT8vtUR7Jhiq3enVXuf5LdvhMR2zlZD9eA/IsE8D9QI+8Q5lGhFHFqPIUxaO9
         L8cZvji6RzPa8FklwgTY2xRHGrXyNQ/8qnE3ASOpRelDlDSDSphG0kCQ6WOkwCctGgR6
         VkhQ7zVnxHQ16rafJ/rjyCXSk2Fc4wLqyM3DodTQxadKmsz6uCa+pmxLzWkeuzwUTOlH
         ouGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775622389; x=1776227189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xztSemg6oCdhqdKZkcXWWUlIRQ+IJPqvZj/UPxij7uk=;
        b=SVo6UzfY/PW6sti0DEq/IYz1SazGkqmAMDty7f6Me3KqyJLvdcYf+lWZ119jUHLEV7
         xBbJc6Rrs/oI7YhCMAt/6FPmh+oaopjWrNSDhSD4G2hn+Bqg3SGrey0fNXk73MMi8cmd
         jNZaqjcXQKy0xzos9EXd6qPxF9pCgUoxNKeavH+e94gKPA1vv3DTeNHrlCRH8bdZLQ1b
         gRgjIcj1hfoJuaa8c/tKXbVJTrCl1CPjiV3g0UjgOTr/OVkuHqAT5TaoosMxrhIYMdci
         T9FEyHvZCahm39D3Dgz2r7tytw2Sir0hcZC9DFNfeZVUqDFs2MUBTPZx/yByKe/RvAoL
         IgVg==
X-Gm-Message-State: AOJu0YxcrRsqJI5NAHZVoBCYrJNHe9PyjgMcjovgzuOEAXy3i9/DLGzp
	UwLaVoELQoOaEWdfxUjFvEB9FnFyYZFz58kETm7X5v8PDdQmO4pv3FhKucNMzzuH
X-Gm-Gg: AeBDieuvYq4XF6oiPvl+kUXXv2q5hQRGM8DZyfc3PtkKd8ZrTsYrYAXBrEJvEhC/PKw
	G/mNRZL65NHrvY7HCNK49hZzQH4sH+nEpkQ37io32K8dl4wvrIt5zmdOxe+wzUxT4E54SVGA+Qx
	uyJfDfrD+ESnnoIdegpHha3YBCledmKHp0OIqMW1zo1X7SDD3MOunotavz+SDBhtPnSWN7gvXDb
	agXaDX547Y3ogep3m1dMBVAP/kkJp8cFAqHFP/lyI2hSiEdKCjrwcJd8H8A9O9jkKWvWl8YSM/I
	bPCSvNrEClfx3magNlzGq5GUah97+IqB9WXu7qIX3TcaKA1d12IXnb1XVUecK1W+gFi0/ywQ6bY
	DgM+0L2tRHxnZmbufnbdUdS62I5qgmj8T0ZUBJcJoBx1BW14HrrKjVdx3cl5hRQiIyo+3S9KRJN
	7nC/tSHeZT9k60lCi5CuAnfjdc92DlpATehuRI+N5tm++dFbygo+FNfAqvuMlPaHLhucfAWb5RE
	aeEOygvxh9hGg97JqmY
X-Received: by 2002:a05:6a00:278b:b0:82a:7f6b:3fa1 with SMTP id d2e1a72fcca58-82d0db5abfbmr18582558b3a.33.1775622389532;
        Tue, 07 Apr 2026 21:26:29 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d11f76c09sm14874760b3a.55.2026.04.07.21.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 21:26:27 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	gitgitgadget@gmail.com
Subject: Re: [PATCH v13 01/13] t9210: disable GIT_TEST_SPLIT_INDEX for scalar clone tests
Date: Tue,  7 Apr 2026 22:26:25 -0600
Message-ID: <20260408042625.31843-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqse9g0xbx.fsf@gitster.g>
References: <xmqqse9g0xbx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Not just "suspect", but it does break exactly at t9211.

Thanks. I've added sane_unset GIT_TEST_SPLIT_INDEX at the top of
t9211 (every test there does scalar clone) and verified both t9210
and t9211 pass with GIT_TEST_SPLIT_INDEX=yes on Fedora against
seen.

Paul
