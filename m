Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4CA2661B9
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486303; cv=none; b=leDUp+PrCL45xbTuVCKqxsSqY93TvL35/1FySzrV0voZNKEtG+sKzfb5uABFvVbo+d0Qrxw0iny/J12g6GRDy83BA789G/RVuDLvBiwHFD6Inc5+pvoRbDDwxRmDXBRyCn874WQAyw4Ei8Jz9wfXt4Qi8M+8zAnJHf7g5yiDoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486303; c=relaxed/simple;
	bh=XYJ/0LMJdUButuyHbbyjm7xL69+KdPVjWYAiq3rrZNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEwqfu95wLQrdY5VzsqI5DFdcme1BI65PSACjmLcTzg3ODANNF3RPROzHQA0a3uFh0zSwruqqmON9/fSjIgWUzXxenS5zT6xPv15rxrYuGXHwa6JyEVaG82fea43JGiLFLg5SxDqgjtmKXD8fBHOy5ARruoNBk6m/s5b9KS8kFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UFmmqzPN; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UFmmqzPN"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f88509dad2so13474197b3.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 14:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1739486301; x=1740091101; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EoQPZQPT3R4oaDeSWREbazn8JDb5eNEgbVJfyQSiJXY=;
        b=UFmmqzPN3elPR1/4v+JieuyJ7D8F8fGtvnA0rIOpGrXC4yyWT+iQ2KqWj+KMnAkufe
         4RcacCa3uGHVeKHwahxGZvuqw7ig2ycJoUYA2jdz1MMAUPr2uqsw8UdgsyMkCMz0tujf
         UFiMFA1g2CIXxCIxZWqWWp84FBO5t8tnqpI2cOI2/f85zL0b9C2r+cCUhoowYVq6ixb+
         JT40+8kx+4b0e0qgcndi1BHKvQrGRORupH2C4mLSYx9EvAWqXttSF2P0B5jj/MMv6hKv
         /mTLsk4MiFnWaVSv1f6EGdLQe8fzRuVqaiURCEHXofswbIGygRswFBDFOouPE8SXfAu7
         4CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486301; x=1740091101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoQPZQPT3R4oaDeSWREbazn8JDb5eNEgbVJfyQSiJXY=;
        b=krp+pj61aFi1jMhbtU21O7u05hupFF9dFDChWfAowCLGIVbeJ3t9UtsvReO3prW13A
         l5oLrbBq4FaM+fTwFOtPvqMy7fgU4v86ugtGC3M4ZqF+Oz31dY/fk+kBnW5c7F8KYQbT
         9aHjfQKX1BVhyuzjphn1SYjifmt32wAw4fOXoYavsW5BVPuf6F3bfnu4zHLUH7S/HlLq
         Jzqvj0KxW9eUIz3J20Jb7jIEn1Xda43hPZocbq33yR4v2T9r4FQ7ai0SH5b9V1w6vLxR
         5sdBrKH9xpSBuL7JLa54sbywEwX1oEQbgc8oVa1y4VMBZNAESUSy++QzxuOZ2vRSHVYL
         KJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyERqNujzvtu5qiGeua7DlMQPAFf1dlX/TNEQsQcwbec4N8sbVBNJLkL3Fpk6tXei71XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxupVafA4SxyOkQonwOx76DZH/fA36j3sjJMAmBgtIW3319pYiS
	2z73naVpTkTGjWUebF4n200+0BSvKi6NpWSX9Dqt+FA6bxsBFqojB4IZqKPhalU=
X-Gm-Gg: ASbGncvecKeQs64TnMkD1kV5XL6C+8mSmXL4l6+bcZopzPrY3fgXvR0qQ/rUMTMkh4b
	1bvyA7TulCIKQJw7realFC7E3DMfHR6vF6MIbtVsKOiKHjH7OBn03BuqUswiO6WsqkKChilHrOK
	mJk/+Wm+NdX+bO/bFwyf9wljMPWkefKl3Xihx4X87q+1CpFVLJ7G9P/GqprA/aE52VXd8cyvGBz
	o017ZbWKR/bweBJVMnBRrMVAoM+ZxceMpjLtgKK6ABRTkCrrU1tL2uD9Z0ZfZxgwdVFErGqfwRe
	HAKsVmPGshuuc71vciJhlPwnGDD1cIt3u90v8GKMYc+/qE7EVE0URWzUwczJSZw=
X-Google-Smtp-Source: AGHT+IF0oRbA5tRO/kgHN43S6H2k7pPqa9voW8ymqXKpfj9xCYNTqzvjmTnx+snjtH7rMVydpwJeoA==
X-Received: by 2002:a05:690c:31e:b0:6f9:48c6:6a17 with SMTP id 00721157ae682-6fb1f681b61mr97595507b3.26.1739486300711;
        Thu, 13 Feb 2025 14:38:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fb3df74a0asm3368387b3.116.2025.02.13.14.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:38:20 -0800 (PST)
Date: Thu, 13 Feb 2025 17:38:18 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Igor Todorovski <itodorov@ca.ibm.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Tags are no longer fetched when fetching specific commit
Message-ID: <Z650WoqFwCSo6svH@nand.local>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>

On Thu, Jan 30, 2025 at 03:49:20AM +0000, Igor Todorovski wrote:
> Hi, we have noticed a change in behaviour with commit 3f763ddf28d28fe63963991513c8db4045eabadc.
>
> Here’s the steps to reproduce:
>
> mkdir git-test-dir
> cd git-test-dir
> git init --bare
> git remote add origin -- https://github.com/golang/go
> git -c protocol.version=2 fetch -f --depth=1 origin 16afa6a740fac7442e94dcd2ec5ea4a4853e45dc:refs/dummy
> git -c log.showsignature=false log --no-decorate -n1 --format="format:%H %ct %D" 16afa6a740fac7442e94dcd2ec5ea4a4853e45dc --
>
> # Expected:
> # 16afa6a740fac7442e94dcd2ec5ea4a4853e45dc 1734108730 grafted, tag: go1.24rc1, refs/dummy
>
> # Tags are not fetch when using 2.48.1:
> # 16afa6a740fac7442e94dcd2ec5ea4a4853e45dc 1734108730 grafted
>
> ---
>
> git bisect revealed 3f763ddf28d28fe63963991513c8db4045eabadc as the culprit:
>
> commit 3f763ddf28d28fe63963991513c8db4045eabadc
> Author: Bence Ferdinandy
> Date:   Fri Nov 22 13:28:50 2024 +0100
>
>     fetch: set remote/HEAD if it does not exist
>
>     When cloning a repository remote/HEAD is created, but when the user
>     creates a repository with git init, and later adds a remote, remote/HEAD
>     is only created if the user explicitly runs a variant of "remote
>     set-head". Attempt to set remote/HEAD during fetch, if the user does not
>     have it already set. Silently ignore any errors.
>
>     Signed-off-by: Bence Ferdinandy bence@ferdinandy.com
>     Signed-off-by: Junio C Hamano gitster@pobox.com
>

Thanks for the report and bisection recipe. I was able to bisect the
same issue myself, and also found myself at 3f763ddf28 (fetch: set
remote/HEAD if it does not exist, 2024-11-22).

> Is this intended?

I don't think this was intentional, though the commit's author Bence
(CC'd) can confirm.

I suspect what's going on here is that in 3f763ddf28 and onwards we are
explicitly adding "HEAD" to the list of ref_prefixes, which causes the
server to respond only to the prefixes being asked for. In a
pre-3f763ddf28 world, the ref_prefixes list would be empty (if invoked
according to your script above), which allowed us to learn about any
tags pointing at that commit.

One way to fix it is to move adding the "HEAD" prefix to above where we
check

    if (tags == TAGS_SET || tags == TAGS_DEFAULT)

, which would allow us to enter the inner-most conditional which guards
us actually adding the refs/tags prefix to our list.

But I don't love that solution, and I think even that is incomplete
since as of 6c915c3f85 (fetch: do not ask for HEAD unnecessarily,
2024-12-06) we only ask for "HEAD" if we have a remote in the first
place.

I think the real culprit is that we can no longer hold the same
assumption from e70a3030e7 (fetch: do not list refs if fetching only
hashes, 2018-09-27), which is that we can avoid asking for refs/tags as
an explicit prefix if we're (a) fetching literal hashes, (b) tag
following wasn't requested, and (c) the fetch is done with protocol v2.

So I think the right fix would really be something like:

--- 8< ---
diff --git a/builtin/fetch.c b/builtin/fetch.c
index fe2b26c74a..0e63621e6c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1770,9 +1770,8 @@ static int do_fetch(struct transport *transport,

 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
 		must_list_refs = 1;
-		if (transport_ls_refs_options.ref_prefixes.nr)
-			strvec_push(&transport_ls_refs_options.ref_prefixes,
-				    "refs/tags/");
+		strvec_push(&transport_ls_refs_options.ref_prefixes,
+			    "refs/tags/");
 	}

 	if (uses_remote_tracking(transport, rs)) {
--- >8 ---

But I'm unfamiliar enough with this area that I'd appreciate comments
from the authors of these various commits, all of whom have been CC'd.
Does this seem right to you, or am I totally down the wrong path?

Thanks,
Taylor
