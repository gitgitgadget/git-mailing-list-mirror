Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B397153598
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888197; cv=none; b=UC1ZvkSYrNahlydfatNNb02npxU61M9+07vaSLZdM7V3RWdx8fC/3EEse7iiLEVniA+QpyEqTDxN2tLz5p0pshq8GxlVRQ0PvIOhWFpHFNB0bZBPhfSPzIxB8xVXADrDrfQp08A/fy+Ou1HbAl7Knh8kkcNiAB1H+NA7cXlTlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888197; c=relaxed/simple;
	bh=ilrQ2fdoLyBYwIlgM4A2gxtOTkgIV+oYvKp0VmkT/Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cnJ5o7hfiAl/2palYShC4zRu5GqvhLWppqyRfNzkFpItDFHowKLCLPXCQCR6j6YNE5ccaS3p8gJhsurX9PYrZWu+wM8raSWtHlHCWAKEkRLFpy6tOfCfpn2yA4WXxaBMAdpGM1KZqC5Sb95ErpbtiEZG+sDYY8sZjEd97QLUx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUNUiecp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUNUiecp"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac25520a289so227656566b.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741888193; x=1742492993; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyJ3w3yI33fBNMVbCP0pOQjamoohy6clyvzbkB9g66E=;
        b=TUNUiecph7I09uQ0X/V0l10OexpuRIX6fkGlg8wZ6yPlXR48PvWIbI8FxG5Cw9VSiq
         CZ07/3Jc1ctEiOQ94tsCTbiqjRSJqBxdew3rPnqtGHAHT4aFNwcAFlWe3z0ZnAtGgpa8
         aFKc5zRIfG7iK5Z5d0U0ChYxOhDCzt7EqVQ5yZd06TrPe2OIHyi0vS0ETRWHVdXg+Bot
         n33LlEPCPYnGFfw3P38jHUxRbinEuu0uZLtlLdT4h82nFylRc4wqK+8grrWlsGl5erop
         N+IMyVP87DjnCbjJftkWieh0fsT9W+Lm7IvWCWe815CQUKt0GiL5uv0eak6cZixJ2ljj
         xSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741888193; x=1742492993;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyJ3w3yI33fBNMVbCP0pOQjamoohy6clyvzbkB9g66E=;
        b=sGJXj8s5F7D+K6a4j3ljP5eQ64ommwGNryIFX3UtDVxP9z4zlwDCzqsZyXUasa7ZNk
         ehTaonwIHhh3NMG0pTO6ZKtQQeL3kdiO/yJeZMjQnpvdIvldPBOk946JgUXLG/LjB1am
         30J8Yu8U/vaAbOwcP4LAbOvnUbGfpjolmoXoaXsWOz8/HqHmgkApGqneXbszulv2T46W
         6vWemKWgvh+kDAU253PGheNghCu19CNsdEB7u733e/XMCPSeMNvazUYhIf1MdeXBMMK6
         J8L3k32HkF+v9iGyBJxPjGNfuOfOLOkY7nXlMYgPog4kvPh/+B8zem1uXRdZAP/XDCfp
         ugLQ==
X-Gm-Message-State: AOJu0YwY80VDWyUyzHGOyO8Fe35RJeurNAnhGUzZ6LZz9ZMf7E+seDcm
	IGhTbgFjDPIZU7TjGVpcpnWEp5/liYBWsDE98v1v84+SZ+dX/fBrkaNYmiRKyEvlmOUoG/YyfXt
	XiDyh3y2Vo9K5JxaoUd6VZvuUGh2WKQ==
X-Gm-Gg: ASbGncsfGeN4jGcZCzAtbJHDoQ9TR7nS99/9WrKpcEm678Aexcgb4sqPcZDoQOOi3Pv
	H4W/waYUA04JbLMa9rCp3+/5A+ZDa33po9lQF3qpW3TDQxzJIiVbQrbeiJkdvA6WI+tGGo4KyiJ
	pqcPG9ubV7HQToh9oA5tBYIlCuOV41YDfLwA==
X-Google-Smtp-Source: AGHT+IESFH7dtuBDJdQQOraXwM+ehscrr3rur7YrlaBqPRwsRMs9/Rwg5inXZWQUWuxbYEjlgu879fhlCKKuNvGtsxo=
X-Received: by 2002:a17:907:1c1a:b0:abf:6cc9:7ef5 with SMTP id
 a640c23a62f3a-ac3293117dfmr26577766b.47.1741888193411; Thu, 13 Mar 2025
 10:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJerikKVusF=7w6Wmmbn8a2sQ9OQOzZG3j8sJFx2_B=+Y6QGqg@mail.gmail.com>
In-Reply-To: <CAJerikKVusF=7w6Wmmbn8a2sQ9OQOzZG3j8sJFx2_B=+Y6QGqg@mail.gmail.com>
From: Tor Nichols <bustedchain@gmail.com>
Date: Thu, 13 Mar 2025 11:49:41 -0600
X-Gm-Features: AQ5f1JpAoEucpK9yJ-_3TVDDE_5qDj-rIr7phTliRpeJexLQk7nod5BasjxJyFw
Message-ID: <CAJerik+ZJdV+YW-XePfHRzwCn3CBekK42fA9M19AkduK_YW44g@mail.gmail.com>
Subject: Fwd: Suggesting config option for clone to always recurse submodules
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use case:
Top level project with submodule.
The submodule also has a submodule in it.

I would like to be able to set an option with git config that applies
the --recursive or --recurse-submodules flag to all clone commands.

Looking at the .gitconfig file, I would have expected this to work:

[clone]
     recursive = true

OR:

[clone]
     recurse-submodules = true

When I checkout a branch, it is sometimes nice to have it go ahead and
checkout the submodules too.  Other times it is nice to checkout a
specific branch without changing the submodules.  So I don't want to
change the existing behavior with a flag that affects multiple
operations.   Besides, the current way of applying a config for
submodules recursiveness excludes clone anyway...    If clone is going
to be excluded, it would be nice for clone to have its own flag.
Clone is the place where I would 100% of the time want to go ahead and
clone submodules without executing another command.

Since I use an IDE and the CLI, having a config that makes it work the
same in both places would be really nice.   The IDE is "smart" and
will clone the submodules automatically...  it would be nice to make
the CLI configurable to the point where I get the same behavior either
way.

Thank you for considering my request.

-Tor
