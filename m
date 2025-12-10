Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB9205E25
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365484; cv=none; b=ta0Qhz8UjIBYiFcZtEI4CheuLPXfe0MWJWhuklaAJznueoy0L69FOp7t3EGHnro8248jZLii+CXKl7uItyeJ3m6+zQdOonfK4Aei55rKn0d9nvMIuaqUDnrVcFsiOK9YKBqZ+kOd9JQwiHPXD8wlpUn1vd/RfAAiDdSrLywq08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365484; c=relaxed/simple;
	bh=GWy/wlMAOA8nIHte9hMSdML26RJCH/2XtibbWRjTYd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxCNjh62d0/5v4wpmq3avx0N66j9x2kRf016jy+ao1QJEgyqH9RBdTE/8CEXQNEjg1syFSh5IUvLbo+Lqpqk9tNCkts2g+HPoCu0dra9SLdIuvW8Zox7fp/YUBHzBugU9XdYWn6K9AQ2fi06Hw/1FoDTXl2DvZ54wBto0yta8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqTZiM9J; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqTZiM9J"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so7398369b3a.2
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 03:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765365482; x=1765970282; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P9DIUIcz/xCz+ZGvZX286HqBG0impqPEeDrpPN/kACE=;
        b=mqTZiM9JZ5wvrFVzh4I/jqKu16mVbtlq1bPfiO0UFTrwrR0D5opABoMKuQigIuXyV9
         ir22OW9XZRmFS5WOsORaCf3aW7hzdreO9m24w1CAolut7A6/RKTY4UrWMIrPwyjq4fFd
         DTli0elezt4W1us0dWzThO8GZHWrkQ6+nqQOVCLwZ/A7A8DCHsixIWMscoZ6lB/DMPDZ
         OYzQThnBpMGJkRTGh1+rcpDt1UOCXoALApMy4jcAo1AFXQ9dT84/oX+GfNCT0z9ZnhPL
         HSoFU8mex0SNvZ5rdcHc+WKtNMxnRO6ZeqDlJ4ExArdC7mtW8rTd1F2WLOz5ZQ9SE/pD
         tIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365482; x=1765970282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9DIUIcz/xCz+ZGvZX286HqBG0impqPEeDrpPN/kACE=;
        b=TJVhilZaEHinUojYNgA5BZSzjpuvHF7KlKBcQ+nLYJno7x7T04fiYFPlv1Jz0RcuQV
         PGIau5bDGa6OjMO2+bSJJ6pcffcbF1IDDCaVc5H5mRQzx5uk5JgJVljqnFpJe1aFIhxR
         H7O8K4fl+sRb5zhjV8cVQULUg/JPi16LD15MDQBYpH9IlJgMkseony8FjCcXkk3wu9nE
         NEMt7ttpyt4FVnQAMSg4xNIcS3pZ7cJCjju7dkGqEzPq9dfnSRz1wIBfMGyhYvxC0qEy
         ynhEGvuls5UdSnePmG16cwRaNYT1im/12tzJcq4awJ1iNEPK6o9Jp9r0ReDacZSjldQO
         8jrA==
X-Gm-Message-State: AOJu0YxGycDEyh1gY+wsFmx/hjoF363IzlPZ7qL0cJo029yXlflg7XOK
	ypRaPCiuRKNKXyhfPcZWlghEdyJY4vBYZM809EtQaKsBLlEQ2YQQMJY/
X-Gm-Gg: ASbGncsh5BimoLrcy9fJCvibDsqj82h1T+cs2rcRCgY0vVIZmb/2ZcwYY5neX1YH3BC
	Fkri5mIKu4UcyjM0piTLJwBmp0+LrcG9+Nf+l0YCzv2Ew2fAeCPQD3JMPV276cFDrIdIayZ7nhQ
	p5ZQ7QxSf16OuqIVXwxr2nvtRavdV0axixqeCoscyf5ReuQNNbfn6gYqKpLkB/UP4EegOLYRyiS
	fhSNd1i3ZNIcxS6FS9U1+My1//0w8rUKFA4GtXds+0XR99ZTE3JIYRt0F5b5+k4LegXGynavguY
	nY/6Ia/0B/vHjFaygNAJIxHc4zPrg9Y2SRZfaVBBtmkhkF41QX+Y5hjFZHgRSICvceCWSfqZ59R
	4PLVrcLvkMtu4tQIBp0CpeqSnS9nL94B/D6iK9riUuhPJWf/FtFeMuCCkdernBHZJO9uuWoLzC4
	UeflfpfBQUMTqKA/IsINJjqOQZeEosrrcR7n0r7fM3Hrm+QsUeQhBwXsX1xJeFhMcc1lHqjUYpR
	ypikjTIsq83PEQDxJ+QUgXVVA2fEil08JRaRT1zF74Sfg==
X-Google-Smtp-Source: AGHT+IH4xJsSN0ld4XrhAneXK38//JFKhOUgVwWlTW7qwoOlprzBvB49lltEPT4QI3Nje6UfOPUJ9g==
X-Received: by 2002:a05:7022:699d:b0:11b:ceee:b797 with SMTP id a92af1059eb24-11f296b55f7mr1680847c88.25.1765365482111;
        Wed, 10 Dec 2025 03:18:02 -0800 (PST)
Received: from macbookair.lan (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f283d483dsm7606505c88.15.2025.12.10.03.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:18:01 -0800 (PST)
Date: Wed, 10 Dec 2025 03:17:59 -0800
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
Message-ID: <qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>

On Tue, Dec 09, 2025 at 08:35:34PM -0800, René Scharfe wrote:
> The library function iconv(3) supplied with macOS versions 15.7.2
> (Sequoia) and 26.1 (Tahoe) is unreliable when doing conversions from
> ISO-2022-JP to UTF-8 in multiple steps; t3900 reports this breakage:
> 
>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
> 
> As a workaround, use libiconv from Homebrew, if available.

While I think Homebrew libraries are usually better than the ones that
come with the system, there are reasons why you would prefer not linking
with them and therefore forcing Homebrew as a dependency of your binaries.

One particularly good reason is that if you are building a fat binary (
useful if you target recent macOS which still supports x86_64 but don't
want to distribute different versions per CPU type) then the system
library (even if broken) might be preferred.

Slightly off topic, but should another patch that adds a `NO_HOMEBREW`
Makefile flag similar to `NO_FINK` or `NO_APPLE_PORTS` be added to help
drive this?

Carlo
