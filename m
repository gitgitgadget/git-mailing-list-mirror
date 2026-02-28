Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521B362136
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772319529; cv=none; b=R15woCTagq8Csfq2ksBGEVEMyzdFga7fRyvxCgew3rwFmG33So/Sp8roJtKTTrUPgRy4cYR9PIFjKtm/r0l6hZjS9UZi4HoGts6dllv2wB3y4FhYsMMezWENCZxtTyTVxKsEfdXlaBLJG4AnkJvgnsk/XQUAQ3hT5ST58DS1z+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772319529; c=relaxed/simple;
	bh=TrfkPYEuVg8nNbUHTjHp0hP0rN2Uviei87HXhUUed8Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h31XIguhyI3MS0WYOypxlSR/Dmx078HSgpfsq0qIPahaBxCmmEnKgM+lYzhLdOVPy65ynPcsW0lI9aTPUQwTKnddBFTFbuOKhnnp+aXG+SjXple3LZzleh/8o7a0oXi4y8wDBmf094mtx95g9XxquTO17P95labU3shBDHfsCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuXypJ7A; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuXypJ7A"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5674d8be45eso1373878e0c.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 14:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772319527; x=1772924327; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrfkPYEuVg8nNbUHTjHp0hP0rN2Uviei87HXhUUed8Y=;
        b=LuXypJ7AGgyKbQpQxK9zDi6tLufInF9tfE0zGWztEOp/hLqhMESmNyPjPpP0S6o5DK
         aPs0IQDo43HhO8E+uGmjo7F9dPuj2lNmEEjZx1Bqo59jALNHQraHYnUv2lZqh61Tpbai
         iHQk+1D27YB3iv73UinC9Zcjxjup1EUg7sJxqVAhcMSi0LsGx9ex0hdPZB+5tna2E370
         KGBQj1/qkgh5WD5hcosoSA5Nj5bacxRt9+PdyfUHrHKxzsN5nfmyB6triV7L5WgkiLgs
         /uamTxBvYWOCmbXFNbmZUa30j0mkmaeva2s6lw9fvegmT+WCHvOYBESXqjoO3vQSWT8i
         FtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772319527; x=1772924327;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrfkPYEuVg8nNbUHTjHp0hP0rN2Uviei87HXhUUed8Y=;
        b=HnuOS32/wJhTAqFcXzQM/s5OvlR0vWTT1fknTf64Yl1fPUC+JOqbTjK49JZ3lYBUza
         fI9ik/KLJEg2tGIyi8P7hlhx1/vOf541m45kbnSDwQ2F03livgVl0oo0I0qZldPWFdxH
         2jVYLKUHbBe7nPRSOHGPL1DVmQnMzFBQiSZWnJcxsvbEi27Reucnd/LBOqsb7WrWrCAt
         iHM6Di1FYiKMr2dWocLCxagtCgxbBZgWM3i4rA8CEWfgvcUUCAWeFIfXuc67yQN7Uw9F
         ExvO3WL8oHXWlDClxgjUWieSC7JvyN/jGg3YAGj1PU4iSYx9tpcB/otwIgtxcLcrDc4G
         y9Lw==
X-Gm-Message-State: AOJu0YwcMYv2Xmi7RdN6LBK2Iwv1xzAtxT4x41I3NIdS9tX7YBzwyXna
	M0j0o1LQ+K3kJ2LUuZQur5f873b+bZnJWflKOmMrgWNhmQZSWSFBRxkG
X-Gm-Gg: ATEYQzyXRO9VnIyljTjwIp02mOLITQwuNMRV73C1YJ59FRup1XUuud96A1aH64RJ7H0
	iNGHj9OPtccobdV4ZsvQmQmLJd2Rh/18vnlGwyiqNO6+4/Got852CR7BMnPEwz1sptAxwxdDUpw
	sLdlojY9v0VDP4tnKilbP0JNPdC2OPrbtT6C1tlaGSxyFbiOODllxQQRljaFFgkgHupvvL0qG//
	GfKjsA4uuQ2TJC4JjVlcNBt/R+GZzDt5gwBJl6WbR0aLRdhD+76U9qtiVesXUK5yGa7L5lH3uXn
	huc6QpHB/fEqW0PPR8BbBw+720fjBcJAUENjjuQP8l2hI1l9Jqq4uvX2yAEc516nClvy/mSoQK6
	HBDaP9hp4kTXJldJ6kEEfvNYGYHW6Gdt04MD225lsc1xTqJKWTfcN9pZavtiY1ERuZYZh1nQ8lw
	XcmHX/Ev6Gta14r0zkUv3/4utjwQKicVj5NwV3d9MUWSrwThy1ikFXYEkBe6ZL
X-Received: by 2002:a05:6122:4d08:b0:567:443f:a772 with SMTP id 71dfb90a1353d-56aa08c6664mr3410980e0c.0.1772319527216;
        Sat, 28 Feb 2026 14:58:47 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a922afe47sm10765991e0c.20.2026.02.28.14.58.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Feb 2026 14:58:46 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [GSoC][PROPOSAL] Improving and Extending the git repo command
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAFNBzOc=tuph7ecqt9TAY-aCWUkPyQ84DYjwMp3QS4-0J-wF_Q@mail.gmail.com>
Date: Sat, 28 Feb 2026 19:58:32 -0300
Cc: git@vger.kernel.org,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 karthik nayak <karthik.188@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8697AB9-9C9B-41C9-A2D8-1848CD966137@gmail.com>
References: <CAFNBzOc=tuph7ecqt9TAY-aCWUkPyQ84DYjwMp3QS4-0J-wF_Q@mail.gmail.com>
To: Ayush Jha <kumarayushjha123@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Hi everyone,

Hi, Ayush!

> Note to reviewers: I'd like to hear your thoughts on whether these
> paths should default to relative or absolute. My initial thought is
> relative by default with an `--absolute` flag, as that seems to match
> user expectations for CLI tools like `git rev-parse`.

I've just sent the path (trying to) add support for paths (the one
you mentioned). I don't know if it's the best approach. I CC'ed you
and the other GSoC applicants that are interested in git-repo-info.

I wouldn't say that the user's expectations is to retrieve absolute
paths by default, we need to check each one of the "options for
files" modified by --path-format and see what makes more sense.
See [1].

[1] fac60b8925 (rev-parse: add option for absolute or relative path =
formatting, 2020-12-13)
