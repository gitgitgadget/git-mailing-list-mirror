Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E004356A05
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027290; cv=none; b=O/Y1GqUGilF3GhQTBL3aZLT0Rk7q7wBiG779DO/eyighg1yPlcPZrt6OTZzVjsN9VIKD4x8ExoY34uW49Ty1dOIJS/jQep5OTa9pV+JPfNxd6+Lio7vBwDeHBu+mRsk6We4blL2KOpqro5l0nEo6rqjNWuIWoDiauBtSoQt5WQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027290; c=relaxed/simple;
	bh=A8wii0uZ/BCem2V+X87yLnUG8TYgNmqT+TP5WvhFd5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ev8BL2FOCiFfsw+dUuOOH3QkJZEr8IvgS3hIJfv/Q19eM4uXDIn9LW9t/AE9UU6CEvxg1qKMiVOzf7GC8jsSrhznpMMiAuM3x9YdHHYdc2wEFDhwI6OJRT4OqYdMwTDS3EevLHIg8Trl/+Cms2cCmE/ZNYYPpui/OOjwqrtgxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiNibcUm; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiNibcUm"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-385b9be0759so33019771fa.3
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 02:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770027287; x=1770632087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/Z7yJXYM5Ca/eK4CK+mJRhJw64WNgOZe/7Ad34M7e8=;
        b=SiNibcUmI/5nw3YZsmOKXZAgGSLkj15odiY3RGWTDtLJvOvBkm4xVXu7xvpX0JKBGB
         CcVBzIpGTMEQ//HuhV3un4WU9OBfS/pbKvTY7jCDH/6gqroIOiXSqjq0+HoZ4BiwN/lO
         XJsvWBF8wlWMkrOyo61TRy1e1JsTPMF8y0695mnH2EywZo7vkqxuJgcJ/bFTeceeHriJ
         IACDLSXbrzy6E8nXcB/lTSo3+cbGXo4mYYkMWQ9qWasac5Lb6DTO44VRflQJIy5kk06Z
         GWx/TGs+KhK8bjzPKPBW1KQqsYSaEolcjfYZRrrdCspexhvAOChBY4RVw/s1bbJbY5BC
         +j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027287; x=1770632087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/Z7yJXYM5Ca/eK4CK+mJRhJw64WNgOZe/7Ad34M7e8=;
        b=mosbQ954N3V8fFGLerSYbw3zXNtSnDpv3RyRPV6yJ12gHP0Qz9EF3NCmJJXWtvw2AT
         th30P0HX8V1J2c55uvV9OISeW+okK/ZtMQ20Cj2Dg6X8lXPCbqRuPoNHWh+pCU4eJn6g
         ub4RdOn5Dp+02d6XAKdi7wRQ1+FyoRsLJqwO88Rm4NVPhm/bozohiP2PPof07p3ZxNTw
         1ggAeBoWAfj1EwkpYDr88ahxcHArTuIvakFnkAEX9pkvPrd5cGW37Vog3SE7XSHbbtRZ
         stgZQsAk26pNXWILntL2cLa6WE48O8wxXFCo93kne2IvTzGpcisMLLefUsS+sEmqMGGe
         41JA==
X-Gm-Message-State: AOJu0YzDaXcwUof4CQ3B3yRWIQcXJ8y3UhmG+lxqtbcNmGll1+3nTmnX
	E6UrvV40r8wYeQ3Om1PW4g8m3GSf1d6szaUEqHm0DRYyLnpwGUxeLPRg
X-Gm-Gg: AZuq6aIP7bm78pAYA6sRo++OWDVgc2II18AJOeVieF/rwm5/BGHc66kP64LP/ZfNf/b
	fyQIi0iwQKFdpBRlk3dn8w3TYwnUZfmsbr5ePXDQ7jL3AztMzEJLs/WVCNBgJKt5TyPf3FqGq54
	+agqT4Q4IMpC8RwUpejgjt9DQiUfzF2B8GHPQhrDTR+svOk36iJ3ctiBS0XF0gxYzCqjJSA2ue+
	kNJTo2LWS9NTXde1BGdE72lmFqnHJoHAFyF0jWAYs9Yy6A32+Aqijhs9uBG9Fxs7JQNc8R/BLPL
	3z6y5N2Cbm9OHlRdcSiQQAbZVLDhZGqwyfZfstar6cOgkLAwbiMfKk03RrDe8+Jwouy3CILFpby
	eQIRwi05URtA498+m2qV9OopGKBBNhHGYXQXdOPROTF+szt92DisUkzoCZYRaX3SV0yKQqVSluF
	KkIYyfCyHCiuCB8z63DusEhDlHcw9G2BklEN2HZGKaOfuQTm7GoOPWiC5r7HWcKu8cUbF70IpLn
	NSA
X-Received: by 2002:a05:651c:3253:b0:385:f612:cb69 with SMTP id 38308e7fff4ca-386466ad707mr33233641fa.31.1770027286736;
        Mon, 02 Feb 2026 02:14:46 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625c43e36sm29018351fa.8.2026.02.02.02.14.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 02:14:46 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Mon,  2 Feb 2026 11:14:45 +0100
Message-ID: <20260202101445.13790-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <d92bd08f-abee-49a6-89ad-3be5e0c06ad6@gmail.com>
References: <d92bd08f-abee-49a6-89ad-3be5e0c06ad6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I don't really understand what you're trying to achieve and I'm not sure 
> if the suggestion above is a good idea but it might help understand what 
> it is you're trying to do.
I didn't realize I was so bad at explaining 😅

What I want is a shorthand for switching to the local version of the
default branch of the repo. This but with less voodoo:

    git switch $(git rev-parse --abbrev-ref $(git remote | rg '^(origin|upstream)$' | tail -n1) | sed 's@.*/@@')


> you say you don't work directly on the main branch but then later on
> you're then creating a release from it. Is  "main" just a mirror of
> "origin/main" or are you merging local work into it as well?

My main is a mirror of upstream/main. I never commit to it, just do
'git pull' to create releases.

Also, I switch to it when I discover a bug on my branch, to try to
understand if the bug is already on main or not. It's the baseline all work
is compared against.

>>      99designs/gqlgen
>>      refs/remotes/upstream/master
>> 
>>      amplitude/experiment-react-native-client
>>      refs/remotes/upstream/main
>> 
>>      Antonboom/testifylint
>>      refs/remotes/upstream/master
>> 
>>      cli/cli
>>      refs/remotes/upstream/trunk

I want a shorthand so that when in any of these repos, I'm switching to the
default branch, I simply have to run

    git switch @{primary}

and I would end up with

      99designs/gqlgen
      Switched to branch 'master'
 
      amplitude/experiment-react-native-client
      Switched to branch 'main'
 
      Antonboom/testifylint
      Switched to branch 'main'
 
      cli/cli
      Switched to branch 'trunk'


Harald
