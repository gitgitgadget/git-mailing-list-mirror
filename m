Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488F335555
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072881; cv=none; b=bKbYkQwVxtdHiK5RbXSKPDsuYbVP3j7g2ceyM1kI2u1P9Xg64moxtW1mLDPZurnLjJzDN2Uu0YTPRJgJlZe3ZnOqWIzcK/LhV4LNKyn0+oUslETJvb6X+rrWPLMKjDFeI/eX76WJA3JBjbykBeLFRwH7I84z3gBvnkAkxZZbRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072881; c=relaxed/simple;
	bh=EDOkxwjuF4MrSs+pk21r0HXU2FNS0wxSsy7maOJnJuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENH6OzIZL1/6Z5IjVhRdo9NofjDtJV5HcVcQs43yy6Aw3L6DhgmbwmWVwCjchTQls6P203q2S1tp4yEdDsMxfxs8lFG8El+CcUPelHUUu1iNOaQwz3nRjZMCk1Xob+hTIhBNsAgAgsX8bD9HZUaVIh7F9DCsbYgl12btQ4HN3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsp1ScLu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsp1ScLu"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59de0b7c28aso5777948e87.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 14:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770072878; x=1770677678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fX0xiToOgVUzQcGdVakJlx8GvWzBzpAm7CnQVlyKUk=;
        b=Wsp1ScLuqyrmWJmILGDceeOhy/kiYWoKwtkYZ5j/DVUAQKnd6xn/VUrga4d+anqFzu
         ZJUYS3BhBBRqZKSD/YkijGLnfDTm6I9958TADx6TZECVr6OMcgrhrhEtkR8o5BeehQLg
         Iop5v17ljVJGQXBrK4aeWf4Jcd9gBt3kKtJcoySVtIhdG0hUlfnmsOtdtxgZIXy1VQ7k
         e8L65s7EvmevNim3ah4hrgCT649rJy1eGyXBjpbc/s0TDijg+I1eeSm9kyEi7m7ABvv5
         mryDUJUwjLsWrOiAPrr47tgAEmCB0jA0Zmxqf8nRtBCvFvR/7BTg+TOfPTD2NfOkACVx
         96pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770072878; x=1770677678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0fX0xiToOgVUzQcGdVakJlx8GvWzBzpAm7CnQVlyKUk=;
        b=tfcvwxN0321msoylPgcefA0OUWE4gOQSrNf2Vsa++ngZ+ggoZvwOFYKJX9wYjUoEYU
         Cd900hOzzkk/gaL37dvyFUPFQusbIBEHjauWlrClQvgt2ugq4fBBld+xPwmo/TkX1fuH
         1Y7Ev1T+TMx+LoLIY1Wtq6lPUNrBeZL2CcbmbzZ+6SWdL70oqIQiqjiP8oTK7igd3iRK
         3ShpG7YK30xvBL7kVwMhau5XAccl/Zq4G05FpFgY1izrTzqAAcBVraEHZQLfeTAfKLrN
         OmG+tHS+HcdVYcHzixjg7kZT6CnIgV48JPJd6PHvMXnkKE7W0BVcTsHm1JtNbP9hbEVd
         mIeQ==
X-Gm-Message-State: AOJu0YyxVmQYN1r3W7JbzcGFIl4hvUlS3Q75JxDsXnpG1LcOS/PlFWaC
	zTfkSwao7VP2K3RBO+z1hqy71GF/RV09blO7Lqnx705CR7H+AyT3Nsu5
X-Gm-Gg: AZuq6aIAtTpQnzG16y5+pr9kRDLgoj+XjYoyLV8frEEFA/9Iv1y8GsvFxgzAjUBJ7Xy
	3DGqwKTWgDuzPkRdGWbNDbwTabIa5qSX8mnoCbqJ+djlxQC1wJyHCgE0ZOktU7JhrKg0Yb1mC3X
	9bSihMRDimP2O2XqO00b7ZstZUQ5n4XRJKSm39LaEqgAFUf4eG+zt2Vq649+ZN8oydxE4X0PSRM
	7dK7uW4PlU35G7U3v0llJ1mo/VAtXupvGTK4N+ZdAW/xA8hL3B1LZwHWVoDVXOSAz5BVsl0wa30
	o+t2xha5QbOhd9v3pcXO8hfFeb+p2WGTqIDAw3k7Qm9yb9GQgSW6KS9CxfVBrsoEFg4166EbUGb
	yc6+tam2IhCp/KktjphxjyQLGtFHGs0DRnGYdFD6no+j70zbBsBoHbAnptaEi8HAEu8/aby77QB
	V2uyxpm4Tnd0TJVbivAfY++UqvmhsSeH5IRvZczPrd61R6eaqbnzO/wZPh0rIG4SLSaxOY2kM=
X-Received: by 2002:ac2:51c2:0:b0:59b:6dbc:e507 with SMTP id 2adb3069b0e04-59e16438a68mr3952447e87.47.1770072878111;
        Mon, 02 Feb 2026 14:54:38 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a76sm3757729e87.76.2026.02.02.14.54.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 14:54:37 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Mon,  2 Feb 2026 23:54:36 +0100
Message-ID: <20260202225436.12409-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <A8942826-6235-4C46-9217-708671ED4678@gmail.com>
References: <A8942826-6235-4C46-9217-708671ED4678@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Yes, frequently :)
>
> I run « git switch -d origin » a lot to avoid having to keep a local main
> branch up to date (if I don’t use it for anything, which is often the
> case).

Very interesting! I'm gonna try this! I will also do this

    git config --global advice.detachedHead false

because that advice always looked to me like I was doing something very
wrong.



Harald
