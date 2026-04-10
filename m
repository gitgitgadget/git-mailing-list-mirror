Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F559393DE9
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831889; cv=none; b=dKdVGFovuXBsK+41IkEpZLRG2mxgYptFbk4G7j5yYZzTEpSBokP1q/KW23z1TwwTfLulgQwOohXuOfUWxyZvZhwSLtrGftye2nLgyVTsVU4P0IdMFlq5f2oXtaAXA+KcyvKZIS8SlaYLGmHPLavLM+cdy+qonRt7OrTTwNUARg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831889; c=relaxed/simple;
	bh=CkLIC3aAOF1vXuTCnrKp34byjzGGX71ub1LICjpBZuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjDHpSvfxCBhelB1Lk2Ehkg1C9mdTiAgGyAIgaGqQdSxe1opKyc11DIpDYYsO4P0uUp4t9rsPOe6cXzWZyijOTUXMun/QEeSTuGHHc8crzXR0Df2QEJ+C2iBxlFnwzad589JH+uKdc3irTI/vslkdXx6bqHDMq068peaU1crE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eccnEGpg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eccnEGpg"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a10d130b37so1722439e87.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775831887; x=1776436687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkLIC3aAOF1vXuTCnrKp34byjzGGX71ub1LICjpBZuY=;
        b=eccnEGpgm9ToBnXnvNk4Aop/LFhDBeQeMCodVvc0+0llDZHUeV/A8TA5AQ7FOo/11O
         /Q8fJYBxOQSw6YLjjxb4TnGWwXOLuDj41BdXNxu0lvb8VHBAsGAlt3IpIbfbv/ST1GJY
         tEU/Jo8Ln5tnJ9eTZVYkDYOAs0OJjBJPt1qgYReLenRkRbDeHMvdmHTubth31LdXP5V7
         8pmUjDTIltIJtCWjbuDbEE/FNvlrdgxoSqlfpUvkh1IU4YbGFCX4b9LKpSG1MwmoUwmz
         5y6DmQ3KC6Lt8HAouIe7s/hL6YcYVJe4DeHiYeGAbmXv/X3yGqrG64CAW06fdJFQ49o2
         3B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775831887; x=1776436687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CkLIC3aAOF1vXuTCnrKp34byjzGGX71ub1LICjpBZuY=;
        b=k5kgUpcUDROGZA/oKqZK9UW0OxK8AsMKZ0HTutp7WB+L2UiXQPX8zJuoQP70MIDm7c
         D0zT11BG5M6s1aJnOeddGpEY5p149kdtnXbmVS7w+PnanM92C6ber5FIjIaO0xOIPgcL
         D5GdgwA2vx3ED7sgVqelbwtcy0FO5iEFv+1/GCEQ/F9dExw2kphcXl5Qf+0novnRjGB2
         vfSzfwKKxLZQkzRKtD0+FxpkZjY13TtVODGzYSSjMX2sLabFbnWgj6q1g7Kw+eIZI1Qt
         xgbVVzVtKJzvh9Ew+jFR4sOWsbTii0m7P1ejyK944+/PkURkIoE+Iqc6VYPMdL2NjF58
         72+w==
X-Gm-Message-State: AOJu0YzCQqrLouaET4Gk2KsXYEfOHTZyvfaN0OwzkKMFrAKwLRFUEauE
	ChY12QpTiboslloOGP6eAKH2sqKmFN6/3hpXfB6RMNwXYfmKBoMPbmsy
X-Gm-Gg: AeBDiesJMlzKIpOuBKL+NrT9pguGT6rks22qZAAUhH6fT2yR6hDQ4O33fdJgIW64ImA
	pHs+K/0epgdQi0Mft/MC61roBYfDWaPypmvFpHi0knStbRrwKJid/6sbA9lVmm4bipUZQKeqPPI
	8/D7aAatPkUz2C3wyd50hQABncMLrHfcp/Tc5rutBAEIos3zzaCP58Rd/5RSL3ZFZlSscVMMuKr
	AxakzD/82vqyXlxkT55F1UKUkc2Qse7rPhzUp1agl7l0Hv8klHiefv6X/Pz7AFasfgBn2KX4fq4
	oLSJ5ON7VZa4/ibMgdJYr3HEc9oGWe5q1d9qS48xUmWNi/GrQLuwvazKVVuQWORlRABkq5+q3WK
	Sbb2SdidaAX6GzvZL2UoA1d+WAeN2LyntWuQwu55+gZbLoM5GwGWKVCWx4bQo9Q9OYfvpw8X0d8
	WQ7h3zO06SwrMnTIozYVOlrhTpCuvJ8p5vl56F3Yh/CzWN67Yw0Wyw7LtFD9QN3hc8wSqqyrFrA
	7r3M40apY7U8CgQ
X-Received: by 2002:a05:6512:31ca:b0:5a1:1de6:bc66 with SMTP id 2adb3069b0e04-5a3f08791f2mr1063472e87.18.1775831886272;
        Fri, 10 Apr 2026 07:38:06 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eee86761sm785775e87.13.2026.04.10.07.38.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 07:38:05 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: chris.torek@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Fri, 10 Apr 2026 16:38:04 +0200
Message-ID: <20260410143804.25993-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAPx1GvfGRx4rEEhqNbgsSKmW77o+uD2f+977cX_U_amyYdz8rg@mail.gmail.com>
References: <CAPx1GvfGRx4rEEhqNbgsSKmW77o+uD2f+977cX_U_amyYdz8rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I might suggest that this should recommend "git stash pop --index"
> (either always, or if the stashed index differs from the stash's parent).

Interesting! This is a new option that I've never seen before.



Harald
