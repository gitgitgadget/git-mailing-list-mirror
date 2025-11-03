Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC817D2
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130840; cv=none; b=YDBVGVLl5ANRjcdIMwuH3zRmDMl54IEOXOXi137rpC/Wy/dqm/0+sYNy5ZVkj7V0UqPJz8pSkyvnAw3eIH2hgy9i1usJcjjfj4aT6Uy51vua0VvY3N4Foe/jmNq2+Tq1BTyQrRDZ9rtYFD+xe7NMH6H3Mu52ka3/zcnmRh1MyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130840; c=relaxed/simple;
	bh=8fYjG1Zc0ynegOseDKPHr3JQ7UGHSxvLWcoRJUNxjJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYm8FXqEnsfWG4mrtLIhECYfv4OMkJKe6pNtnj0STsnF1MFp4H43OKr0A59dhlTZm+rgCmNO8jv9mUGlt9eyCEwEaPjT3150mGP3U9Z37rmpIRaGKDFSfB1VoQ4IvhWuAfr5voAf1tVZJt8lTJIjVQGV4VXzz04qAsPIL8I7qIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpRpI+Aq; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpRpI+Aq"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63f976ef4bdso2053359d50.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 16:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762130838; x=1762735638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j10y+mDA3dZy51W+j7yMnlSio8gfvhdPUrftC6wQljs=;
        b=fpRpI+Aqo265Y6NfwPwAbGkD0ZFH2ur/mQl6+BlcLICYOBhkBFOaSOO3VQviF7LWA3
         HaATKWVTNWSkYm36+39zCVs0vGZUJUzz9he+ME9CtWmi8MDo82jUgdqZtIUFTBMKhylU
         yqp6gdf+YSpiKDmn/Pvjzv6AjkRxQusyzG8oYjDGUTQcCHrYlrEBIOHY/Nln2LN30a/S
         vQu0c9qhbgfvvC5wX/23FXP06U/tjpHrvIbdrhRK6ATc5duvjv19fOXeRdIjwhcijYoO
         DPWKcJPB12Sf92q3pbB+5HUJkiZHSQCpV4TdB5YfjFDhtR1K1f8RDMeB5zivEiuv8c8Y
         FMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762130838; x=1762735638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j10y+mDA3dZy51W+j7yMnlSio8gfvhdPUrftC6wQljs=;
        b=UcCsMFVIJh1wQFn8B7VF7gzROqri1k1Xx13dqY8+QRXJH/OS+PqVkdYSdyt5o2mcQr
         0oU6cENNr92mpOjlKJ2ozmaNk61AV4PoQx+4NGP/ubKf2LNAW0W2eRiW+6qTXruWd7rH
         sVdzwY5NiSN1Z2qX+2x+rXsJB4xMaVsMipvz5i10lDphc/mq9slVab1HfLU/4DgARavF
         U7RUknpa5UyzSF0MhpCD7wNwAJR8c2mBv6KlF8B6WGZe5+Gm60Mjl/Wm5wlW/afnBoti
         GfvfkjnMQx6wyyB4UvGW0cKKsgdIma+/RHjHBPaTkAhkiBgQw4aop1uz2yldJ0BPpoFm
         mDeg==
X-Gm-Message-State: AOJu0YxkoMa5gXXgaXbdQe9FTmIIVQUfnfv5hPZNuJbazIMJXyn80+ZP
	A65ka6zv3n77h/Yuf1J8AAvvDvJpAlxF+oS1b+bd5BliRdXSK7tABf19hgQZvXddcl/DiHVZYC8
	IAwFG5IEhYmyE8EPN8wewVo5Tyqxv7i8=
X-Gm-Gg: ASbGnct/ED0nV1JmlSOmlRCiwVhOgdU6Q1ZDZoXFOAJEsPTxfObbeBqMmn5vwAzz9T7
	ga0sc2VbglgnkQAruZ0yz2mY62SvMy5u0SK5XGZm6PgMT+zeP5J62VLFE+mskERdWGIUeSqJfVz
	x3GyDLb2YyKjnRzHJWCt3YMjWXZKdYPHWGkfj8FbJGS9T+crnHzoFTBziEO+Qk+KN7+5JPOYfvS
	G4Re15fr8vs/14bLOQ+fR9suVu5PGxFzwFzVOP7hsyFmMWWI0wC3tkwLn8eecsq+6zG9rsvRdMZ
	Dij9B/X76KMz/oe+NdkGz1xQ
X-Google-Smtp-Source: AGHT+IGJYpXqxbryvTackZ1P2CN5rqN/JrZv0fvW4uLkHMswm1TXHH91JvsW5nCiZV/JGYL/WCNymJTVMMPAa5wDQ5Q=
X-Received: by 2002:a05:690c:7288:b0:77f:949a:d08e with SMTP id
 00721157ae682-7864840b229mr95780837b3.26.1762130838366; Sun, 02 Nov 2025
 16:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com>
 <xmqqcy8418me.fsf@gitster.g>
In-Reply-To: <xmqqcy8418me.fsf@gitster.g>
From: David Bohman <debohman@gmail.com>
Date: Sun, 2 Nov 2025 16:47:06 -0800
X-Gm-Features: AWmQ_bnF-hbT8NRUMdPVXTrpZ0Be9ea2vUBSMert3xk1sgGPFb5pflwaLwky-kE
Message-ID: <CAB9xhmPw6P1J2a3P+btUT1chhNQrhcx3pSkq+vqZbhFhCqcX9w@mail.gmail.com>
Subject: Re: git-2.51.0: Fetching tags does not work
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am sorry to have to bring this up again, but I am still occasionally
seeing this problem with git 2.51.2.

What is happening is that I am cloning a repository as bare, and then
later I try to fetch the new content including the tags:

% ( cd bind9.git; git fetch --tags )
From https://gitlab.isc.org/isc-projects/bind9
 * branch                  HEAD       -> FETCH_HEAD
 ! [rejected]              stable     -> stable  (would clobber existing tag)
 * [new tag]               v9.18.41   -> v9.18.41
 * [new tag]               v9.20.15   -> v9.20.15
 * [new tag]               v9.21.14   -> v9.21.14
% ( cd bind9.git; git fetch --tags )
From https://gitlab.isc.org/isc-projects/bind9
 * branch                  HEAD       -> FETCH_HEAD
 ! [rejected]              stable     -> stable  (would clobber existing tag)
 * [new tag]               v9.18.41   -> v9.18.41
 * [new tag]               v9.20.15   -> v9.20.15
 * [new tag]               v9.21.14   -> v9.21.14
% print $?
1
% ( cd bind9.git; git tag ) | grep v9.20.15
%

As you can see, it is getting an error for one of the tags, but it is
also failing to record the other new tags into the repository.
