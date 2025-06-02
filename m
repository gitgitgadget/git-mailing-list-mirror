Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE82040B6
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887619; cv=none; b=FD16SSuI5nw+H2sACtPF7xJXrhfjaxxvbqoAJmRNwRBXAyMEVbW0YqNSXnuAOh0DvpAwSuIpbuR4mNHI+Op1P3swEqqAEMiKq/DhQTRcY2YpN+gteL5EgcuqU06gQRS7213VoIgME0crr7oYXl+z9wUiI5Le6joNhWmKmBH1FSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887619; c=relaxed/simple;
	bh=5jpQciou0heZoK5NU3lHNbvyHMrsV/DuNPCvrW/H484=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=KqE1lbD0MP5ENj90I0QRsaZQChE/G9lmRwU0ZHffF9Y6U9fXqI6MknHDAPZxibSgoBC7FFmxkAmqfkbyUHc6uu3EOkK8PPtDHj3tQpJRPixqRGcGg1h0Y4xM4UazCGeo9YCciXi83w/rG1JjfKgY1hWYlDmib7WD3prIHvwlwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETDxrWbm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETDxrWbm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2320d06b728so41247955ad.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748887617; x=1749492417; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpbE8fEWUbUw/CjtAtjyq6n79bh+XvOXEFZ+SU+qIvw=;
        b=ETDxrWbmNyurCs1THCMujU//fFuAaiNe3uxslT54+vGvPVlLkocdIbivKChNr+K08A
         SQWxP+axs7s8vUHqYgQa9znGa0XNXO7K7sYz0KaCpJAHRU63ca3ndmMKiuM0lOihiyvm
         Us4CB3OJySXhbkYTs1iGGpK9KmfP8SZmZdVjp+/EHArnACR7yXNpNqmqbzHr2W0t5bZe
         Y8ycqrBvrL/uIILjCQka+kOIUGWdEfUgVeIbfCMSnRq5m7O390896muWhHgTWdZnq+jT
         SPgw60hMN+ZuO2+lJsnH9HCV83cy+yhQ34cNs1vTqNvqBvcgpyXXUrtKaQ7o6UoQbdJL
         tPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887617; x=1749492417;
        h=mime-version:user-agent:message-id:date:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpbE8fEWUbUw/CjtAtjyq6n79bh+XvOXEFZ+SU+qIvw=;
        b=p2+ANPaCIMjV89BFn3q+Jjq1DtDZr/U7yDPj/H4MzGGK9KVPuz0tV/wae4GEfY0ZVy
         mVukI6z2PlsPdRZwhGlZeMT3hineWX0TSkDqNNhOe18AzZVqrgQ/aE3a/j8LcOVhGOBv
         ly/QqHXshYsdRm7HD/mEK+Kp4ToDqHi7tKJqKICTGxXmafs7kXQZPugrl8GX+Fv+aN4U
         bcrDjbHp3IQxkBwFqlZHFdXB3AaP0cD0aChSkdQ/gPtRjwOB1/lil1SJPcCBNTV3BLTU
         yk4/KVqqxApB5oGCDJoS5LxHb+3kc9xZPoz1d64hGDEJebfbiNgN5YDhTXLvwOMTQyOt
         TRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcOJ8i3VBkn6M4TCZTUUvxCoyr6E4R53Lve9Bs6m5RnGastNKgjZQMXMIbAc+5+y0ZFp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WmMELgLffBemEVBwLs5MjFJ24GqkrNml/xS+C58OmHTxcDHi
	iKZgeEQ0CKvDGmW1o3UNJRKmeM6hBmH+TQGpQYBZ6Bjg56lUrEkPUv8vPEGBXQ==
X-Gm-Gg: ASbGncuXsf5qd18/gRILlbay4rzgFmiXmTxDmgvPfERB/qgD4FwaFgnKzI42dkIWFMm
	9hkjmPBGnqSBdhqjRT1fwl4cosoAkJMzsJfpQZkambeAWvAgnXxEOr0+iipcd5FuII6BSx1R+xl
	2egO2e36v16gi+z4R8xUJUX8UYTP3gxQ+ZFfg4LloNsvq66d6VVbsJi6aPHgPd35XchDJOGbAt7
	cr6zD+nE6IzGdLmBsX94sYuanfrP4R68jkqKkg9fdKeYQRN+Jtt9mDZHTDrdKiZoDiELpbLk/nk
	Nf3v7VQvk32dF3OC+vC9QQytbuwp0rY=
X-Google-Smtp-Source: AGHT+IEo6zYCroXNzGeMoJ6DXjN4iuorhuYEUd6HR45OceTmwWjNdh8564Gy5gLCqfRJCvBipuKfwg==
X-Received: by 2002:a17:902:da90:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-235293f44e7mr243117055ad.21.1748887617042;
        Mon, 02 Jun 2025 11:06:57 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8669sm73800275ad.13.2025.06.02.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 11:06:56 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Brad Smith <brad@comstyle.com>, git@vger.kernel.org
Subject: Re: [PATCH] compat: fixes for header handling with OpenBSD / NetBSD
In-Reply-To: <aD1SvlRypkhczxRS@humpty.home.comstyle.com>
Date: Mon, 02 Jun 2025 11:06:55 -0700
Message-ID: <87wm9ut3uo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Brad,

You wrote:

> Handle OpenBSD and NetBSD as FreeBSD / DragonFly are. OpenBSD would
> need _XOPEN_SOURCE to be set to 700. Its simpler to just not set
> _XOPEN_SOURCE.
> 
>     CC strbuf.o
> strbuf.c:645:6: warning: call to undeclared function 'getdelim'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>         r = getdelim(&sb->buf, &sb->alloc, term, fp);
>             ^
> 1 warning generated.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  compat/posix.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

I noticed this as well when testing your other fixes.

Just one question about this chunk:

>  #define _DEFAULT_SOURCE 1
> -#define _NETBSD_SOURCE 1

Why remove this definition? I think it might be useful on some older
systems and seems harmless otherwise.

Other than that, I tested on OpenBSD 7.6 and NetBSD 10.0 and this patch
fixes the missing declarations. So:

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Collin
