Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451EE6FB2
	for <git@vger.kernel.org>; Mon,  6 May 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714961570; cv=none; b=TYNndMUYRajIR40ck8RcGItxfSNrSY1SZ1pZU5k6X2evnG4IEWN4UsKb2Cis6RcLG3oqU+945yWJydcTcCLrlgrTKNYchSlIGsheUKws3zCsxELGp5ldjZamNQlBzCYTHM5cXsUCrcV8rhEBKCKzDzcB5/oP9Q6jkamnCumlI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714961570; c=relaxed/simple;
	bh=PZ3VEth5W6l/IMpyHWVAgfIUUIfWUQtRDR8/WF/I/zk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SsyojhWtQTXLyhLK0ss/oNRlI610I80MiorHchEjhGlg+RCL/rMKyadoal8Lc6xgIIz/sjYT6Ntq827AwLp+FW07NTWV2CBRDCWbiPJ1+a9vTEaezxv7SyYEQdSWex+LK/YkqQqxBRKktPANF16zoYnXBa1DER28SVGTtCvw+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMMJghSY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMMJghSY"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1151514a12.1
        for <git@vger.kernel.org>; Sun, 05 May 2024 19:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714961568; x=1715566368; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/bWMVYCLXuus5qJaos0FfiIU2YxUlTm8Gt5figljXE=;
        b=KMMJghSY4YVGhXscJR0VIjYWtUeuQL1Ox/pFwPHHyyEdfs025fI9JBvPuso7LIpGJ+
         /Me4sYD/kPx2l1iwd45n/t8ix42iftg99KmwUFHChoXN8KcgCguc3j6mKvzm05rwppAE
         ll8bl3U4+xfRNR88bGAk8ZfIqq0Gw2ywyZlhZSJkcctK6zeVxLVOxXCE1MdQYoTQ9y0U
         MXksfOXOhpWX7PMWxFcr3/+AMqA1AJrVqTRb/eUDS945daPWf8MoIu2MmULnBv2eJ2ar
         j2OiFBFEDOZhSrohXlTJw/IfZBPNpVwT6hxk5E5dYCrkCK8+N7tmYQ6ZZlIN1utcawFX
         /PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714961568; x=1715566368;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/bWMVYCLXuus5qJaos0FfiIU2YxUlTm8Gt5figljXE=;
        b=CelMC3ALlVFYrwzaXY7UyWfwy0qaq+EqISznplzWH8Yn4tHB9k9g+NdzJCUeZTmcyl
         FaI904qQvR3cl87UF54ETELiK4tfRAiX2lBh5eG6KKzGRjTEdbQJci6KafMnuFkB+t5c
         /REB3A5rj6Jq4B+WR6XWEDJMZp+YrV9WAt4245sm9lp5NWL7KkGQnMlh5FsJmXcVKIra
         Jm+kiFgBKrdIOndx/06UxHsZs2doySlYhvncGMlSzI9EDX4saIrE0nGPEL575hs9DSa9
         tjb9zpoyYs/86A7nBRX4YUI5PYKLXgK0eizY9gUekpBzLgjw8A1ggpjkQoov/sDR0Pfb
         5iTw==
X-Gm-Message-State: AOJu0YwnzHhNCwUg35T5EhNkcId1YaEwWdt5QucaVT9T2tPnWgP5BcJH
	94RC75OUhUvAIA2f0PcH8WsERJyBpyDcjYg7YbdVDajxAQYPwaW1V7G/Xg==
X-Google-Smtp-Source: AGHT+IE0ECx4YH1Wg3xDznFe2a2jtw3fsrRD9m/ghUCeFvMzdlwiDAYYquV0nzEM6Wz1lel9N92U0A==
X-Received: by 2002:a05:6a20:2589:b0:1af:a4d0:1615 with SMTP id k9-20020a056a20258900b001afa4d01615mr5312755pzd.22.1714961568071;
        Sun, 05 May 2024 19:12:48 -0700 (PDT)
Received: from gmail.com ([172.56.121.16])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170902fb4400b001e8d180766dsm7064975plb.278.2024.05.05.19.12.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 19:12:47 -0700 (PDT)
Date: Sun, 5 May 2024 19:12:44 -0700
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Subject: [ANNOUNCE] Git Cola v4.7
Message-ID: <Zjg8nBh9ksW1h9pj@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The latest feature release of Git Cola is now available.

Git Cola is the highly caffeinated Git GUI, a sleek and powerful
cross-platform graphical Git client that is well-suited for casual users
and Git experts alike.

Git Cola features a specialized editor for Git's staging area,
a built-in Image Diff viewer, a GIT_SEQUENCE_EDITOR-based Rebase tool,
a keyboard-focused user interface, and many other features and
tools for Git users.

Follow the release notes link below for a full list of recent
features and enhancements.

- Release Notes: https://git-cola.readthedocs.io/en/latest/relnotes.html

- Source Repository: https://github.com/git-cola/git-cola/

- Downloads: https://git-cola.github.io/downloads.html

- PyPI Releases: https://pypi.org/project/git-cola/

- Pre-built Windows installers: https://github.com/git-cola/git-cola/releases

- Homepage: https://git-cola.github.io/

Have fun!
-- 
David
