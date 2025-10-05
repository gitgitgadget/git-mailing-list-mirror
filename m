Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E23398A
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759623644; cv=none; b=Qsj3arZBAHN1dkbqm7EblzqhJkcmxnBiSm8P/VrM23mW9/dJvzOI3TlqExjdicdFkaaMXsIP0hIwC0ELN4jvPz9wM+r4RjrdrM++avEbhz+VmjK+PZ/iEoQuT3nCypOQZT2/HI19LxtnDttO36lO39MMGLOxLTLpl8hb2Wu3fTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759623644; c=relaxed/simple;
	bh=JaaR4TAclNvUgi7BbeRHG0YkHgIEvzWTfJ8FDE6oAxQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de6ypKlYzjj/imtHtUJWalTo2TmOTX0jd+rV2hp7n0YFtyb1sEg5knPlkLvrgk5czkqPhovhMfm8i7cOCUgAFTAwVmrn+BApexKHYdbi9Trcog4OGUiMbeMMCem0F+a5Je5QF5i+keyFD4QqGq1/0b8aD1tQ5dZiYIp9qSkOgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvleUi1/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvleUi1/"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e2f4167b9so3037125e9.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2025 17:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759623641; x=1760228441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ReGpRvn/L3VTrvLHq3gTiptTc6LFjHSMgt+g73xXf8Y=;
        b=VvleUi1/QMsbwLzEuzzADOr74ZLPDi0yUyso+7OOk32jrMBxTsqM22BbwBw3kRJahj
         mfNz5x7rzwY4sF0a3F8BiQ0DW4qjtq1GXtPwBJDxC+YL8u586MaWrpzhwEy+RPKP7Kyv
         kH3tzpQpQzFRKAwJHYSuGJ2K4t3xxdWHp66lj1/IS1k/FBWCgNOyBrVEEq8YwnkHe38y
         pWKzJooHnfnYVxJDPxij4oKRErSduwBhXg246vp5dtXUnrE63LLIx3kQxh1SlbQLgu+F
         0d72ZWGANmjh4md0o4mYMTS/5IPnkEpeFgEGVRbHqUyDZlRek7dU1nncHNbywOie2sp9
         m39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759623641; x=1760228441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReGpRvn/L3VTrvLHq3gTiptTc6LFjHSMgt+g73xXf8Y=;
        b=GYwKgSfHGbY6O3sgyaINhd28FU1cXWi6785H6/MnMIC67+VSiAuhbwocyBsDvYKMdz
         RBU7tCeaXM3iBT3/b/m0u7gn/Bi+RIyk0qPNBqG8qhAkzNG8JNnUfZwWbNryyM6vhilK
         b+sl4aP+EPQnVetZrEU2EB27JdLYKIUpaFesSEOCKXfaDFvo6rUYf6sGJOYsAh378PAo
         StRjNyACWZhUhl8+V8DC096B6etX0F7JpOB33WQ9Jz/eHlCGOtb/hoHwCzj71mvD2fXD
         TYvC9EA1kabyxOQlYv9BQQEzGolUjwBuVamjnvdB2cfQq6+YHb+foVCY9XFUc9pUlf6Z
         qLuA==
X-Forwarded-Encrypted: i=1; AJvYcCVh5n3KCgQHyaYv3oNvISbNCEQbi4OYOaWBc8/HtvMox7mQdQpmvKWEpps0NKHsvjtLQNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQb2bYQTlWhQUgaxwKltfJbcLBebQdJ4yCK8VMJYbnQZBaZZPh
	hGB6TNknKZciuHvV4x84fZKg4q+nAwHEghtRVLrMdVmbtu2p7GPF3NfB+s+ZNDbscKc=
X-Gm-Gg: ASbGncvJsBVzHtalxacMyadKIwkz8PtZbxNBWvYO4gz1j8i83sO2IoTVGsmQJK4QA+I
	eAjPqUvwjhGwf/6EhA1Aj3uA2v97Lt5WwQxpWvv02mvg3uIa7BLGjZMvIh8U5v14pOEtn4Nn8sF
	FK0RZhKKugY+FW9OtXwFfvJ43byhzsCkbwlPzuhnpKkALaGs8LpO5Px6jK+i4vyYdvo02qxIXgj
	ORTWe3WtDVn5DaC2gUvcA3Iw+AluR90ML96PWmrVmIgnJUFYQyprN0TRR5ieLfUo7219zmk4Szl
	liUzDpvZqY/FnUEqDkKS5I8qsMzvI80unw8wmXnDTNf8eSESDyzhDu+sEdYvGq/32IBSw+144pa
	NWjrVtxeKPCFBFKoWIaLD+fRRA49DTOf11ahRVk6vEtm7cY20qR9bTO93h+vF9RmqXGylwqbAtv
	UA3I3e9yQ=
X-Google-Smtp-Source: AGHT+IFXrERutKpIKMIXBHlGiTkcmkKabz9JwhhEZhFlyWxS6iSuciSyW3JBByr+BfO/pTT3NqoljA==
X-Received: by 2002:a05:600c:45d0:b0:46e:6042:4671 with SMTP id 5b1f17b1804b1-46e7115c938mr24639905e9.8.1759623640666;
        Sat, 04 Oct 2025 17:20:40 -0700 (PDT)
Received: from desktop (s176125235115.blix.com. [176.125.235.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b63b407sm114494425e9.2.2025.10.04.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 17:20:40 -0700 (PDT)
Date: Sun, 5 Oct 2025 01:20:38 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Devste Devste <devstemail@gmail.com>, git@vger.kernel.org
Subject: Re: Untracked files cache not used when --untracked-files is used
Message-ID: <lrahpvp3nj4rtewf3zbf67qsvwhc4mg6irbmrhklbizxbhqwom@cc25oeqex4il>
References: <CANM0SV3+4k5tsgRw0g8-HoVSFGb1AwZr+2hCUXLriFGSd33WQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANM0SV3+4k5tsgRw0g8-HoVSFGb1AwZr+2hCUXLriFGSd33WQQ@mail.gmail.com>

Devste Devste wrote:
> It seems that using --untracked-files(=all) causes it to either not
> use the untracked files cache (or untracked files are not stored in
> the untracked files cache if they are in an untracked directory?)
> Since various tools and IDEs use that hardcoded, fixing this would be
> a massive performance boost for many users

What's the value of your `status.showUntrackedFiles` config var? I ask because
I looked around a bit and found commit e6a653554bb49c26d105f3b478cbdbb1c0648f65
(untracked-cache: support '--untracked-files=all' if configured), which
includes:

> For most users there will be no change in behavior. Users who need
> '--untracked-files=all' to perform well will now have the option of
> setting "status.showuntrackedfiles" to "all" for better / more
> consistent performance.

Testing this out on a big repo (on my Linux machine):

    $ git init .
    # create ~100_000 files with plenty of directories
    $ for i in {1..10000}; do echo dir_$i/{1,2,3,4}/nested_{1,2}; done | xargs mkdir -p
    $ for i in {1..10000}; do echo dir_$i/{foo,bar,baz}/file.txt; done | xargs touch
    $ git add .

As expected, status with untracked files and no untracked cache is rather slow:

    $ time GIT_CONFIG_GLOBAL=/dev/null git status --untracked-files=all >/dev/null

    real	0m1.237s
    user	0m0.484s
    sys	0m1.150s

Status with untracked files and `core.untrackedCache=true` is just as slow:

    $ time GIT_CONFIG_GLOBAL=/dev/null git -c 'core.untrackedCache=true' status --untracked-files=all >/dev/null

    real	0m1.250s
    user	0m0.435s
    sys	0m1.216s

However, with `status.untrackedFiles=all` (i.e. matching the `--untracked-files` flag) it's much quicker:

    $ time GIT_CONFIG_GLOBAL=/dev/null git -c 'core.untrackedCache=true' -c 'status.showUntrackedFiles=all' status --untracked-files=all >/dev/null

    real	0m0.382s
    user	0m0.214s
    sys	0m0.568s
