Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D74E0204
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407777; cv=none; b=jcPZAfEvdMibXge2LQ12X0c3Kj8Fr0Dp1EvxzP4SL3bkTuerZwMtV+L4V8n+hTbFXUPBcTAQujyoOcg/I9TqkfHUTGQHl0AVruv9Vug62bKmk1nhpYhcPPtS9Cobqc0V05AsBazHK7doJGPa08u5BKrvQOZoAYrIiSB7veAUQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407777; c=relaxed/simple;
	bh=m70VEScLvsbDWONQrj5vLsYZMlwJZEkHU0mslKet3Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKcimELl4ssmkumXi+pZiQfIiBXI5c7PnmO16ZceCfvZe7bbwoEwDSbulriuEQR1klBZp+4pJ2Uu6raNX5p/0hykOsFP/W9zDAjBqnZPIE12tEyLFcZ0rxMgQ/FuOL/Gt3rX3stXLAbDSzzUnD6CR/sdJ1+aoaTa1keC6/CF/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com; spf=pass smtp.mailfrom=gitlab.com; dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b=WzE03jUu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b="WzE03jUu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso974597f8f.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1792407775; x=1793012575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2pjxVgUNxhynd0Dacvzr/ZW0rtX2twa5tBPr9t8ECFc=;
        b=WzE03jUukxbFOk4cnCmeKpPj/jFF6Gw7ZIomUt0XCa/hC9QjAY47y0oq4LGoC0N8Et
         ildM1N3atCnz+Bl1e+x4PAwjCBaMz156Qjo1bBCvbgFVwaZirMbEXtSUly/l5Nq/zjqt
         g2wAU6RcGzueT+WspnrurfWPmn+/9jr2fL3go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407775; x=1793012575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2pjxVgUNxhynd0Dacvzr/ZW0rtX2twa5tBPr9t8ECFc=;
        b=j7Hl7mS66AhMaOmnXlePVV43JXPi5Bc7cqjqLRilleBbg16EiEeKjEvGvR0kyGavcU
         pxgYT8W8mhAusPu//DOmDVs0o8jcoCrwQNzUhGGu3B7uX1OYtytScwIHOmVwGgsZsTzu
         uD+bhLDm2wTyO7W+AN5C7Z02lULK/Kf/KuEpPTwwQwEPyazsVlnKsEimxQttkD7PSRWg
         Ex3JerntnMzv5lffNZKynAiUkMcMSklTAyNCtNKA8dwBustQxp7ChEwRRsa/DwT7PWtZ
         MeNkT7OQrRfyMfOlN+PTIEQD5eBWRbbNnzPn834wZ+3A74q6AxCtJzT1KUIAEg3LJLy8
         jtdA==
X-Gm-Message-State: AFq9FYKQ67h+Vborl0Xvms/VWZsvjoSI8ci7RPsnDnFNTwK+fUHMIi6i
	Lvhe0g+9fN+Ua/F23WUYt3XzuT+5vStr6Ch0DTQ+3fQu96Ox3IG/fuJw0JhmwPg/dYg=
X-Gm-Gg: AYBFou26pibDqinlxJGgKcMV6B1lU8xOQ9dz72D26VnVOh5Z/3CgIpU3kB6aLhPA4Zs
	oLDEbdatADII9kxFvoT94EMx7eEGQ5OS3zdxBKN20xOSebijxBsUr4ReYGfRtWRn1NekcZe2cRB
	JF+7hwy92T+fcOttRwpy/MB21yijqvud+fq86+PJa/zT8OIZEQldAiA96UnuLkbQ6zyo5nS4Ev3
	HxLsJ3+ZMu2Un/g/DZpDDkk1BUgldk93Mftv0SaTOcRVAbSSqXIaRgQ7A9BXTkWubn1AqgDKhOK
	D0dq20YwS0lcCZfevSSbdQY+Mc4no8I+PXdzqGG0c4pF72tHyinYtfwQHeE+X335gjb8EdmB4V1
	E2I+HGTpwT0d/XL9cK3s1ksCt7ZM6qckw9Kv0HvYQt/wS6/YkpJdZw1mCx72jiD3Gv7dt6uef4u
	Y3sKwZUY3axZPL3uYDsULCYcZVkQAA8XLcj5yUSXDgyGsQZvofT6fiO3vRn7E92BbedVwTHphYZ
	kUNmkOrmPQXRhZgdBrQiqiyqL3K72OeYB4mng==
X-Received: by 2002:a05:6000:184e:b0:48b:f08:8162 with SMTP id ffacd0b85a97d-48e07fd2898mr15322943f8f.39.1792407774463;
        Mon, 19 Oct 2026 04:02:54 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:a97:4482:588f:b276:463d:6918])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1afbf534sm822776f8f.35.2026.10.19.04.02.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 04:02:54 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	jltobler@gmail.com,
	Igor Wiedler <iwiedler@gitlab.com>
Subject: Re: [PATCH v2 2/2] odb: ignore refs of shallow and grafted alternates
Date: Mon, 19 Oct 2026 13:02:49 +0200
Message-ID: <20261019110249.70341-1-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016031439.GA3437448@coredump.intra.peff.net>
References: <20261016031439.GA3437448@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 15, 2026 at 11:14:39PM -0400, Jeff King wrote:
> This seemed to fail the windows ci job with cat-file reporting:
>
>   error: unable to normalize alternate object path: /d/a/git/git/t/trash directory.t5618-alternate-refs/shallow/.git/objects
>
> Just a guess, but it might be the Windows vs POSIX path thing? So
> perhaps something like this would work (...)

Thanks, I will include this fix in the v3 patchset.
