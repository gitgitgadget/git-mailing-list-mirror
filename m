Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F19199EBB
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744557089; cv=none; b=MdFz44FvDIN5Um+3l6JgqJ6OmdG9FGrehlf2e36/wFhDhLn4mbKM1SlaEPxigDRrRTofppNZjN5khTyqq1zsaAmhs0/ndeG8nrCkTJym8ocLstY34KoiiHLzy6jN/jD2Vz+13lLvPmqRdaO1xNXjS5MNgocMjJXl6fZZFrUjxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744557089; c=relaxed/simple;
	bh=WBPtzVQQmuVVzb8PM5ZLr62BVOFq3jwWvt+HdUfUyhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV1SAGko2bX0XTy0/mx4FCriO8cEpa4BSRC0ghoSJH7BdxmSxx1JvIk/lHeG/3wjKfTJ3FfND82VrlfMw0FnBFD9HQvccp/ptqcL9ZBqr+sauQ8QR8Nt8vElbEeMH0KU6Gi6N2x8MhFTfxjioDnqRh1fnibGbSWYnFxO6tlD9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELEh4TnT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELEh4TnT"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7399838db7fso3312537b3a.0
        for <git@vger.kernel.org>; Sun, 13 Apr 2025 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744557087; x=1745161887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBPtzVQQmuVVzb8PM5ZLr62BVOFq3jwWvt+HdUfUyhI=;
        b=ELEh4TnTsjLbEhwt1GZS3JkEsn9ygI+GJs9rM/JQygSqHw8ak2jLHlo3LfeC9A6vf9
         UGlQxFOnmbuwLliSQPhfvgYU5NouzQs7EIaAVhEh9QXguDHwBRswXAwTd4di+69o5yQo
         tBsCsfR0CyjHKVuA1RG10936rEQLQQfKMZXcSIg0QfYVYVskgzukGoaASaeNZuUWivEY
         24oLPd2U46uR73Drk1v+DqhA6YKI8tkA+Th9X7oSLdMB8cCa/p66pCgzn9Qy9eZJI1vr
         raKybvKa2O6GcAjZZvAO+R/84mR8xKVNddfuZSZ/RisE+3LeX/fC6xMOetgaQdVuCGsm
         5FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744557087; x=1745161887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBPtzVQQmuVVzb8PM5ZLr62BVOFq3jwWvt+HdUfUyhI=;
        b=dIMz7Z84vJJsf3yHG1dfxeM1yN7JUn3E/C+fWAYLrUtJQP8bfTMGg21dXTwi4uY7le
         QiDflIg03SbDVJHBEuL5o/nD+/3redmZDSP1lrAhPUsWonVNiPrazLQRLc8DPInbsS8M
         VCEgIhLCL05D+E9Fk+Tfqq6rOS17Dyj+JDUw3cRQ63V2kPo6QB/opxjqXHQorkUDWTQM
         2phePLjar/Ib3oPU3A0Yzr9eWj1aq+ZrjWw5kjBDPuUgc8974utf1Q3BSYNLzEJi7hvO
         +CqssuR0okPWf/U5xXuZisXvck3waxbDS5/tOXKNeoGC4sXRKXG0vu0d+ydKT21Um/Nj
         YFPg==
X-Gm-Message-State: AOJu0Yw95SFqR29WprZDPiHlZkG9phJw/htZve6cmWzQYvsWxi9ZSi6E
	UnXV1FPCZcYwpPD6+6t27LsWAQhvqBEpbIiT47Hrt6/q5jsTsfoPLhjUVQ==
X-Gm-Gg: ASbGnctReBKtdvQj60EMRc5KVCZFxCHbzLxfgfDchrcEPpqaw9qZiU8itKuNZOeqHzZ
	1dBvNvg3w0n6mbA3iVg+yQ35Eok23zJR4QrbOq/4TwtfxL5HASTnEjvgE/cXaPuhwIfplqupycz
	xah6JvgCOR0v9Szm78sKz6LezqeaCO4I8KLKzkM7g+kfEoR+Mkczi4uI0K3/lfTMJmGl70Dckp1
	GQj2GiMaRM+BIzlluCSl3Ko+34JStsN2SXwoycv7Tw8kWzvVSJuVEsmp6vknvTF1tsFVF98pW89
	rA//HQA03j3ZQR7VqBSue0GGlQwx+Id1MVZzgweOd6BZTFblBPHCA3M5BUyAOdZ/F3Jt8iiFPRY
	=
X-Google-Smtp-Source: AGHT+IGWOoN3sypK/HS8qV7ciHPFeEisxC1Hbcxdv/KWI+xyFHpt5hWYEAK2kvNpF9dAFKubMPnhqA==
X-Received: by 2002:a05:6a00:11c7:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-73bbf610990mr16389221b3a.11.1744557086937;
        Sun, 13 Apr 2025 08:11:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198a89sm5065977b3a.5.2025.04.13.08.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 08:11:26 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com,
	ks1322@gmail.com
Cc: git@vger.kernel.org,
	Jayatheerth // <jayatheerthkulkarni2005@gmail.com--FIXED>
Subject: Re: Bug: git difftool --tool=meld -d HEAD^ lose copied file
Date: Sun, 13 Apr 2025 20:41:11 +0530
Message-ID: <20250413151111.76851-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAKFQ_Q93M=x_xNuCm_evjUSfi_cNGQ0LuZSHVua1vTZHc0e-7w@mail.gmail.com>
References: <CAKFQ_Q93M=x_xNuCm_evjUSfi_cNGQ0LuZSHVua1vTZHc0e-7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jayatheerth <jayatheerthkulkarni2005@gmail.com> // <-- FIXED

On 2025-04-13 14:07 UTC, Kirill wrote:
> Hi Git developers,
>

Hey, Kirill
Thanks for the detailed report.

> I believe I've found unexpected behavior when using `git difftool -d`
> with an external tool like Meld, where actions within the tool do not
> affect the working directory as might be intuitively expected.
>
> [Steps to reproduce snipped]
>
> My understanding is that `git difftool -d` operates by checking out the
> compared tree-ishes into temporary directories (e.g., `/tmp/git-difftool.XXXX/left`
> representing `HEAD^` and `/tmp/git-difftool.XXXX/right` representing the
> working directory state).
>
> Meld performs the copy operation successfully *between these temporary directories*.
> The file exists in `/tmp/git-difftool.XXXX/right/file` before Meld exits.
>
> However, upon Meld's exit, Git cleans up by removing these temporary
> directories entirely. The copied file within the temporary 'right' directory
> is discarded, and the change is never propagated back to the actual
> working directory.

Yes, your understanding of the temporary directory creation, the successful
copy *within* those directories by Meld, and the subsequent cleanup
by Git discarding those changes is entirely correct. This is the
designed mechanism.

> While this might be the intended design (operating safely on temporary copies),
> it leads to counter-intuitive behavior and data loss (of the action performed
> in the difftool) for users expecting interactive modification capabilities
> similar to, perhaps, `git mergetool`.
>
> This behavior was also reported against Meld, but it seems unlikely Meld
> can address it, as the temporary directories and the cleanup process are
> managed by Git:
> Meld bug: https://gitlab.gnome.org/GNOME/meld/-/issues/555
>

However, you are absolutely right that this intended behavior is counter-intuitive for users interacting with graphical tools like Meld, where actions like "Copy to Right" or direct editing feel like they should have a persistent effect. It's a frequent point of confusion, as evidenced by the Meld issue you linked as well.

While changing this core behavior of `difftool -d` would be a significant design shift with potential safety implications, perhaps the most practical improvement would be to enhance the documentation. The `git-difftool(1)` man page could more explicitly warn users that when using `--dir-diff`, modifications made within the external tool to the temporary directories are *not* propagated back to the working directory.

For achieving the outcome you expected (restoring the file from the previous commit), the standard Git way remains using commands designed for working directory manipulation, such as:

`git restore --source=HEAD^ file`

or the older:

`git checkout HEAD^ -- file`

Thanks again for bringing this usability issue to the list's attention. Clearer documentation might help prevent future confusion.

>
> [System Info snipped]
>
> Thanks,
> Kirill

--
-Jayatheerth
