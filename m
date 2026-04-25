Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205B30DEA5
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140474; cv=none; b=nfPAehgsAVKvGrUp2Fqtqbcx/fKyiWFs4rhPfmk8XZ9oKcTnQUEczdLB5Nx7jWkjXmpDvOhzXITEsvx+lGcbfq0chOjCZmyrKwx98IDdNv5/AIHDaFbYSX/Rr9H9IuD6+VqZaRRYpTmdIHSya/gAFS6g6d6JCSv/I8tWvi5h3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140474; c=relaxed/simple;
	bh=8CimbWmf/Ezx1Fdz3VIVNWSUEKHHR5IdU/6kgPh17dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aahIEsizqTItZXU+ap1mxlLVS1hd+zTfOWqNGXEM01uCpaFXSuGy2CpYSI27BfYIvoyaer+5ePGJWRt+xGya7PlxvCfqX7fX+iFLrTdSgNHzJLPp8z6NGajX6a/tGK12ON0f3H+0OQ0OsvZduFSeROO95xdppEGAuECZ9+aaw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpOtR/QT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpOtR/QT"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e91416cc0so95699431fa.1
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777140471; x=1777745271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CimbWmf/Ezx1Fdz3VIVNWSUEKHHR5IdU/6kgPh17dM=;
        b=EpOtR/QTii/ML/yv4Ux0R9nfALcSTEj50igdNeOMjI+AbjLl23D17yABZLfyCVgGNY
         09mnk5valZrJdk4u5jjVMy57Tg/eoZkWQ7ZtyVFvgVFnZWTP14BoC+L2pCzJqwSs02TX
         VHc9qIBkdZS4DPBRlCuCsgdx2VrAIR6rWAh75MkiXkKdhFrPqU/6mEcKpxnHj0Zyi2m0
         zwHY5dOO+jYZbVioZgx+TN8M+u8N9Sz5na0ZYnK70sYllgS454vmBCKafOzDHitbqjWw
         TKsPKGfTLIsE2f8x0iSA+xoqR0UfWPzo4JfMe1VvtdhLgNRiTLg7i6jQxWJqtTHnH1jP
         j+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777140471; x=1777745271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8CimbWmf/Ezx1Fdz3VIVNWSUEKHHR5IdU/6kgPh17dM=;
        b=rzw6hpGqnpa+qq4SRzojRWCDso/W+bLm3SgoOnBzhVoCfdGp7W2RQ3xXeMY0fHuiwX
         Xh1Q8d3gaBERBlSOBjQlqnJbhB2YabQ14ETy7MFLpNeJB0JdygPbSPLgFyedAvyee6VO
         4xvzH2ht1ifF520huM5014YyU/HoJoZbaRrf9wYWHWtiji8VAzS/nHcaOemkleKm6iNw
         3jF8BNEUDj8CtcONk1q9RQwPjXhjLHsZLnCUYa3hAqkjJpA+MO1xw6f3LP8ScgIVaR8V
         qS/Ose42qZ3X5oErPhrd6oeGebykYArUNL9mw2kBDOBLnEhxUTiHPkZf1JKkfj2KBb7D
         al1A==
X-Gm-Message-State: AOJu0YxID08N1OEQJBslmiwZLVdbhrRpGjY4CzHSVelRWoWI8z6+EDO+
	NjpW6T6Hy1Q7p/6dvB0VIZUhRBv4NcuCDGvwILoz2zLOYslbTFi1GRdO0EsgpvS9
X-Gm-Gg: AeBDietcwdwq/EZAoqhW9KQ9RBZBCo1xVVk5w8rdZhgKKzmweFMj+a/BSHM+uEHD7NX
	RG1+9sda7U4/UBa1PKiO32/7wFA2LnGS9rSA2HZjW3n3o2BFjtIZR+0sHyt5vfiRieOPfBInEi4
	hzF3wz6gAoj2EvkpUFxL0QvKNNmbQNOJ69R90D2x3rMtsnBOFvh14GLuwQiN4sHLwcw0Z2tXJWB
	qPJEcCm6CBRnBKTOlNS+bmLwyJwKukBXzRyvFag6Qsa6YcNg0oHjttqyIpLhAtM0PQA6Jv6+HWm
	ChQpl8soouMOVIarVsLLzL/ftwx7beYKrO9t68/lK3/ZvMlFnmZbrsuli7euQBbx/yEx99PRSyZ
	80fVyYVv+2osqmwaRfEQg4SLlP1zKYXxyBaH119c6lIQkHn2iAQmtYR/NUlNfTUodFw0VPGapKt
	qlKpCceRZCHwVwQjh6K66LqP0ClzBaAPSmRsFD0PJ0xXa7HE7abRAyb/5XuVMDnHhEpJjvgv+r6
	qrrhJKqwBIMZ3zjySgU8yZl0Qs=
X-Received: by 2002:a05:651c:e0a:b0:391:1570:b6a6 with SMTP id 38308e7fff4ca-3911570b8dcmr31502431fa.12.1777140470711;
        Sat, 25 Apr 2026 11:07:50 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f501dsm57084341fa.9.2026.04.25.11.07.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Apr 2026 11:07:50 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: gh
Date: Sat, 25 Apr 2026 20:07:49 +0200
Message-ID: <20260425180749.49933-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <6F9060F0-20EB-4B60-8677-86DA2AB39B35@gmail.com>
References: <6F9060F0-20EB-4B60-8677-86DA2AB39B35@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I’m not totally opposed to this convenience, but couldn’t we also just teach gh to run set-head as a second command?

We probably could, and maybe we should.

One argument for this new options is that I believe 'git clone' has this
behavior, so it's attractive if forking (adding a secondary remote) could
work in the same way as clone (adding the first remote).


Harald
