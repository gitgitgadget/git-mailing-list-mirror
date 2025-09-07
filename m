Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A41E0B9C
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757247857; cv=none; b=C+oTEjS+t9PBXCa2V0Eu6/+WA5gUkbSGlf5EKu7jvIJ+A6tVOlpGrYJuRuDD/61TWeAV3QCEj6cOXtT+DcepN2O0s0dMokVICLBn+9eZBMwZ4gatIysp+h3mwAdLOYUuXLaNe+KRspRogv6C2ns3Jdxn7wnmqzr9ZwHKlqR20lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757247857; c=relaxed/simple;
	bh=238OrZxzV8mBFzocsbmWxdXfr5jAIV3wnhneXwf/JQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTu2e4UzsDugmegfx8GY0pO8G+x7UTL6qSMyFfcRoLRv+oaUMvb4feG2viHrfgDLWyQQ9w8VxLUpSQzKqWMGgNOPU6LKQMosuo7DR36CGQEAqcNCUYwGAY9y4GgXgxuHeakG9vlMNKAff7hhG9acadY5Xk9G2MDaLCiAKC80td4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuNsJBrw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuNsJBrw"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-772301f8ae2so2946037b3a.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757247856; x=1757852656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7qmGdJE4+gELUJ/10lzsHDclkZvtfzdeHuHwm1XpCk=;
        b=BuNsJBrwTyTGxY2HSgBf2HdG8pnLQtdxkClLlO7UaUfqKOO+gQEEEn4UAe1JXzM9E1
         og+bHVd8VyBBeXFzKfOoh97HV+DFxM8YLylUUm5VeozV6/iBAtwIZBPkSAKdxP7JHb5J
         C2vguMkVDUd+FtLDkoYjZy5TwQK6zV1nyN5KVoBd1GkQAIZQqw2axM7OeCKF0ACDevAM
         b6h0zIyD0k/NqRl4LwA1/0J/kbSfUCZuGZ4ges2twiFqaEdUiqQABiSEkrf3oP3iT62+
         7Zn+kO2Ci+XPz5x8eXZi+dDh+TSxwE8VVntP3kwshIE2N3w4wxY1GHdSZspTAnYUq9fL
         5sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757247856; x=1757852656;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7qmGdJE4+gELUJ/10lzsHDclkZvtfzdeHuHwm1XpCk=;
        b=lcPZghE+n8PUUUdUMkqiDBgaUZzP0d45y79wvA6F6DZI3KpsxRH44Tg+vTmpyFfPuV
         sc0sR3opAiwrkTti817ssw09P9pnL8/Eygw+etxf4tsnDpIIj0JE3yQpnpsu1FvV5V0p
         4RWKPW34bHglAcyD6VyD4IbXN4kKWlQvJnaLFE4PAjEbVI28uG6Gw2R9OgNJRgCGbM7F
         EvqZIjldMRfDuSYwvCNacZjNIZB2mhwVFdW/H1Lh9dLdvZBYOl3eM7eoXABHxKSZiqCo
         nRmF9Pfr+wbG9C9p305DiYBYXlxxraoIRgzWWSU/uRYnwU7mc532UHAUy78XCM64DnZM
         EM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMc0Oe0Q3A3wZDsAHBti64Ce5Q6VPE9GKzB5QPYfZoGkmnbwRE9tFs9Gb9Vi8BUhx0QuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/Gwalgz+ucscENJxRUPGHKxtxnhd9BpP2tSJIv6yh0xEZvtq
	mS9k+xvexko5Sk+8wjsWui3cFGqmFJlrbhmsT7Pae61CK9Jg+j/m913n
X-Gm-Gg: ASbGncv+nO3TkumUEBaS7zz+NZOY8xC2+p90NONp0aOzC9figu5UWArJqQ6QpCraWOi
	WcJ9yT4ml1b9lSINNY2hcHIu1LmVhtlUs69h1eGxvklwVjbbHXZBlCCrZjbzYJSB9eyRsKv9f9z
	wjX6ek1N5Dw0frgnldHZZmByb7nD7mjPHoVlQHStGbYsgw08uc03jSONF+6CSWyInRCxr7vrqhk
	V8Nmt6W5PKaFZoZgNAnBvdlhiBzX11ivrwcWEFcx0SvrUSNPBTpHIYbZ/2EUZgR5hfpxVnB7hs9
	qFs/eNh5sAB0HfKEO5r0rIla+Gia8Dq7HlFtDl3/FOrcK3RweCt7JRBAJ9Dh0puUAFPSXvFBx6G
	nc2xk5r0usJf0WOQotV/RuzMRInwmJbUfd4nxC5FO7PkoJjoKRy956ZIXx6eA
X-Google-Smtp-Source: AGHT+IHwT14tT+FhgJ0uovI8ic6R5xLUDHbsbWi5GQK7XvG6bFfC9iMewp5FLzWOYPwg9iFN+bxlOg==
X-Received: by 2002:a05:6a20:6a25:b0:251:43f5:caba with SMTP id adf61e73a8af0-253466eb5b6mr5769126637.53.1757247855689;
        Sun, 07 Sep 2025 05:24:15 -0700 (PDT)
Received: from Seonghyeons-Mac-Studio.local ([220.94.153.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd309439dsm23982274a12.43.2025.09.07.05.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 05:24:15 -0700 (PDT)
Date: Sun, 7 Sep 2025 21:24:09 +0900
From: Seonghyeon Cho <seonghyeoncho96@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Seonghyeon Cho =?utf-8?B?KOyhsOyEse2YhCk=?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] add-interactive: reject malformed numerical input
Message-ID: <aL15aTmKQOsNrF0D@Seonghyeons-Mac-Studio.local>
Reply-To: aLaz7yCXWGG2_oP_@pks.im
References: <pull.2044.git.git.1756553495661.gitgitgadget@gmail.com>
 <aLaz7yCXWGG2_oP_@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLaz7yCXWGG2_oP_@pks.im>

On Tue, Sep 02, 2025 at 11:07:59AM +0200, Patrick Steinhardt wrote:
> Okay, that does feel fishy indeed. It would be good though to have a
> test case that demonstrates the new behaviour and at the same time
> ensures that we don't regress in the future. You can have a look at
> "t3701-add-interactive.sh", which has a bunch of other tests for this
> command, as well.

Okay, I'll add tests.

> In general though we're not doing a good job here of error checking. We
> don't at all verify whether `strtoul()` returned an error, for example
> ERANGE. So if a user passes an integer that exceeds whatever we can
> store in an `unsigned long` we'll silently proceed with a bogus result,
> won't we?
> 
> Ideally, we'd use a saner interface to parse these integers, like for
> example our own `git_parse_ulong()`. But unfortunately, that interface
> does not handle the case where we only want to parse a substring in a
> longer string. Too bad.

Good point. Would you prefer I introduce new parse method here, or
should this be handled in separate patch?

> Coding style: the `else` should sit on the same line as the closing
> curly brace. And furthermore, if one of the branches of an if-else chain
> requires curly braces, then all branches should have curly braces.

Ok, I'll fix coding styles.

Thanks,
Seonghyeon

