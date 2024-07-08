Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48987E0EA
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442981; cv=none; b=SgOAPLyEQMtEgnYJUIGKe3FyIk+tN44yLxNlEJvOrvqaNQ81qURi6RVz71G576kW9yvhtA/ZbL2Qd/3ft0Zt6HHnnPZgo2oOss2XKCYGL5zXqomS0g0kLYDTOxgB/N+YceCU77lG9ZCP9EqMc0gjMxFfMQ4a9SK/1mvZBgrGCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442981; c=relaxed/simple;
	bh=paF7cxIu7m9QLHqh6JWBtM8Zgc+Hw/Y9ZSl05iUcOCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKdfEl9Mzlc+/dR4JpVha/Ay7d01uE0dGFAjB6ZaD8nuK4pK0M+ZiHsvTa/ZoAmfvDUuZu8FiBfsRyX+CaKTMfS4vho7GOuxCdkJyjXL9G+RvRRdtRs5evPkO+KtoBl0HhDE2tf+MOeu+vV46Y7mCfM7olXd7LyGmSiW+nVeBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7BmO9RB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7BmO9RB"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b447c513aso4473031a12.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720442978; x=1721047778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=paF7cxIu7m9QLHqh6JWBtM8Zgc+Hw/Y9ZSl05iUcOCc=;
        b=K7BmO9RBRflnn2S6P6FgewqEVI67KRm5GB/awNsnH3cj0UrF6iAy814ZIUoQVX56xO
         pt49Rh/HfUY+0JvtIL8rrkxk48YhezmripMlK9MhUs4AI+/XXmxqqgGpe+TICFvosiG5
         dgNCKvP2nMdnhYT3cvtD0g4jcOCSyvHXi1b+4EWMfbEXmMduzI9x4hhvS64DILHQwoOE
         44r3FGpPY+0hQJAzNwfRsEB5Xcn5GeQCJlVRb6jHEiP9vKiA7bjKg8CjbSQVxfBX08Je
         58W3BCSMODwnR2yNcQg+VPjRUl/dzFpbgmqo9KpjROHLT3c9w2aF6/OiFqH7t7VPqgLS
         Z1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442978; x=1721047778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paF7cxIu7m9QLHqh6JWBtM8Zgc+Hw/Y9ZSl05iUcOCc=;
        b=vdZHkZvvwCnaJJw8HMDpz68og+pci18VCpChi2xF4jRLcJq3Ied7ONAqez6ymz8+fO
         8gUsAvd3SSjVLk1YqyMFXda4NvpZgx7tOzTWew4bLHwjnUQiJnpOnr4mg3zKfm/n19TY
         TFkDO0fezBoONAqTfGhPe/5sA96uiT5d5n22xyeBWtTyP5AojumW4DyLOjQMpXBJyVER
         74uvdzvHESvDAtwY4qmH3xDnR/X4gPIbbd8Ndu3Kyez6oAS7eoX1dMTQqQKfUgXCPy9E
         rYev+Hq4INyZ0sFZSi6LS6BaBfePC+BCxpXAlH+PxAhOYUhQ2jXe2pZWdlIggEEUx6uY
         YHhg==
X-Forwarded-Encrypted: i=1; AJvYcCXOMnQuEm00fdQE+gnEljhzs97JD1oDZquah7/ejH5WXHzjqwxaelO9SNqVeQNEsAPOV+MI9n7h/BVhnQrKiIIh4/JS
X-Gm-Message-State: AOJu0YyZMDsisSHRTQRysV+E9aQYrWaDHRomOd+QmDdC7v463Gd5JjAs
	dNRcpN0o1EyBwRtkJv7W6dFOno40tRBb+UZbD72wcXOcAes6eeJa+ecvrzk2OiCDZmMts/grOZx
	1RChZGfKK2nWmEt+xL4N2LMLy2SE7RtPP
X-Google-Smtp-Source: AGHT+IGR7lW2lzVO+jjUSb5g199eIGNiK34QGsya8PvWZvZYRM0X0izJ5Wa42nLk77onf5p7jvUJkC1/KIb6iGrHZls=
X-Received: by 2002:a05:6402:350d:b0:58e:13e8:dc6b with SMTP id
 4fb4d7f45d1cf-58e5b4a791cmr7948753a12.24.1720442977869; Mon, 08 Jul 2024
 05:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJFVNCfz_-Dvd0ctc4w-2jsthyPFxy=HOutj=3PbNnQ-Gsz84A@mail.gmail.com>
 <Zohf7LzaRHaG9vX6@nand.local> <xmqqy16ematj.fsf@gitster.g>
In-Reply-To: <xmqqy16ematj.fsf@gitster.g>
From: Tiago de Bem Natel de Moura <t.nateldemoura@gmail.com>
Date: Mon, 8 Jul 2024 13:49:26 +0100
Message-ID: <CAJFVNCcrURr7h25BE76jd19=qO0e3umP5_Hhp1mHFrhXDB+DLA@mail.gmail.com>
Subject: Re: git diff-tree do not honor diff.orderfile config
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I agree with pretty much everything said here but then the
documentation must be fixed here:
https://git-scm.com/docs/git-diff-tree#Documentation/git-diff-tree.txt--Oltorderfilegt

I use diff-tree in a Go program[1] and I expected it to be plumbing
but I got an error report that was hard to reproduce then I read in
the documentation that diff-tree also relies on the configuration but
when I tried it didn't work, hence this report.
If you folks say it does not depend on the config and never will, then all good.

Thank you.

1: https://github.com/terramate-io/terramate/blob/af73c2b688fae94360169da6ab8de49ea5b07649/git/git.go#L466-L482
