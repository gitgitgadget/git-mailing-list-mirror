Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8821CC64
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513244; cv=none; b=TGQSvyOADyaehCRr9Xqy4u23x4cNz4slk4KlzM2C8GImTl9xaruuAAUw6Eib11NNbLtzrLdzqaiKhZt5o6dr8MptidMcJJ2veDmJCj8zSGmzM38pmTC+Qn3jmqqSNAgP5ttgm4l44WgR3kh/S70F2I3PYdMpLz0NP3TrQHK7SFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513244; c=relaxed/simple;
	bh=9GGo2sU+DzyiZPddNCg6noj8a4iDHnVrpNxO0QRC9Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIK21QnYjbMX+uYbQccmGAaSR2NM9Hc6FVAvU59XwIHgh7UjGyF9vnwo4vx5HCLT9IUZVmQBWOjc5hVpixaNhUb2zZxF9ckYhNE3NKRZbCE7tqzdu90y7/rXwbWY0cjL7jXFJXZuivU+uJF64eOaaNDUP/kJAhTM43yeJqVY6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX1pgZvt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX1pgZvt"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78a034f17so229223f8f.2
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754513240; x=1755118040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1gICBDnk0Lc7G70xFFGp2smrUfRp2i5gSmmRfzsFwY=;
        b=EX1pgZvtCM/8+PbQhYgWJ3EH75Ca/JbmWFBuyWERbiyW3G4BSVxah69wPBZabTEjnR
         4kNM0h3bvhSQX5Uv60kn0mF+/1MFmj6x7rwkJDZRuUgTLYqX2bRBMH64svmLvq701soX
         ygY763FI5Soe3/CFn2mhxi8hvsSZ5zL4OnwaBfnvcdc/u4gzawUexgLEy76ygBeIZKOg
         XCrsWSVFoerf4RNkHeBpMzKZDCDthEG41Kjq6cDaf73dOs+mqX6lIQUeje06KzgRL2kc
         9SJGOdEdsz6Wkh4F82f8QIG5ahuj5m9NyLS2w3l7vSOs18I18qpEFqNozvYkIvCwIucr
         i9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754513240; x=1755118040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1gICBDnk0Lc7G70xFFGp2smrUfRp2i5gSmmRfzsFwY=;
        b=UTdFnUH+sCb+AVSg0c3gKqWpZ95iSp2XSCFla8zgGi8AU23yIsh6DlRKVhsNGn1mUv
         S8XPQEBbFIcja3KOqHLC6v8KJ0vKo6wv0CQkReBzJ983kJzKpE0hxQUHzd4HkoABHcR+
         lytGir4Y5x+7qfiFLa2TZjshkIqyO1v8ioPwqVgpI9BIMx0LI5dpII+1RCgEkwkVYILU
         ir7vKm9eRDCZPtgQKtXCDF8Qzl/RD5jNECT1bn6RMEJFCf2CC6MzWgOmrmjlvBMtCdXX
         XoKQ/sig+6dVr2awIayLlWI6/g/lXqP0mSizUlXfiJ0kcP5OfUde6ReTx7h/cHEsrBnx
         ha5Q==
X-Gm-Message-State: AOJu0YxV9fV5OGtPY2n5Frvfc1Q5g4eIQndNTWQOkaeDn0MdHAHP0TgU
	BsE4Q6HDunPmfFoERrNGMMMqUCcwkC9OehH3nz/4w0CRwbGfQ7LG07kRVc8oJQ==
X-Gm-Gg: ASbGnculYcJcghmGWXk0Bg2pVWAMq3Rpq6h/t9IobkZoasQebNGFCGGMZif3RJjTYf7
	lnvXNox/5ycoLd4lnJNhDNJslV8E3/f5wQTAe1qinwGSNac6ACBAumaezfBi2FpO0P5andoZyX4
	hNV0WRl1nk418j6xnwInsUGlnQdZTuDNUNKEM6Dra0V8mVg4iS4shEGEqOm3zbrZ2yFwE4SJObC
	4SXA+t3ywDKu9beFlLSrEFHMCjLL7m0ZcsumMTu6AYVKikFg7Km8zun2XZ1thapCbT15kzXPyob
	0X0TIjBFQyqcETjXuvOuE9qPfimlKutqT8MTARScnBwNZNWuyqs0/oRUInGfHLNCOvjxa53Tmct
	2nvDD00SLY9hvsNhZHP3/DHKEsWvRUjL0Tx4BlY28kAiVYwpjzhynd0PqWaYGCBs=
X-Google-Smtp-Source: AGHT+IHS1/tKF0yiJyoTvbKGcT4S5/1HH2JHiwL9IPl7a9pL84OzSfhVLU22FBq9ZDLlQb2RUxsQSw==
X-Received: by 2002:a5d:584b:0:b0:3b7:9bfe:4f6f with SMTP id ffacd0b85a97d-3b8f491ec5bmr3479934f8f.44.1754513239547;
        Wed, 06 Aug 2025 13:47:19 -0700 (PDT)
Received: from localhost (78-131-17-158.pool.digikabel.hu. [78.131.17.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453d6esm24292403f8f.37.2025.08.06.13.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:47:19 -0700 (PDT)
Date: Wed, 6 Aug 2025 22:47:18 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Aug 2025, #02; Mon, 4)
Message-ID: <aJO/VhvaH7FgluZA@szeder.dev>
References: <xmqqectr57ax.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqectr57ax.fsf@gitster.g>

On Mon, Aug 04, 2025 at 10:24:22AM -0700, Junio C Hamano wrote:
> * ps/remote-rename-fix (2025-07-31) 7 commits
>  - builtin/remote: only iterate through refs that are to be renamed
>  - builtin/remote: rework how remote refs get renamed
>  - builtin/remote: determine whether refs need renaming early on
>  - builtin/remote: fix sign comparison warnings
>  - refs: simplify logic when migrating reflog entries
>  - refs: pass refname when invoking reflog entry callback
>  - Merge branch 'ps/reflog-migrate-fixes' into ps/remote-rename-fix
>  (this branch uses ps/reflog-migrate-fixes.)
> 
>  "git remote rename origin upstream" failed to move origin/HEAD to
>  upstream/HEAD when origin/HEAD is unborn and performed other
>  renames extremely inefficiently, which has been corrected.
> 
>  Will merge to 'next'?
>  source: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>

Before merging please make sure that the topic can be built on its
own.  Currently all of its commits, including the merge commit the
topic is based on, fail to build because:

  $ git log --oneline -1
  fc33fe7eff (HEAD) Merge branch 'ps/reflog-migrate-fixes' into ps/remote-rename-fix
  $ make
      CC builtin/reflog.o
  builtin/reflog.c:7:10: fatal error: object-store.h: No such file or directory
      7 | #include "object-store.h"
        |          ^~~~~~~~~~~~~~~~
  compilation terminated.
  make: *** [Makefile:2817: builtin/reflog.o] Error 1

