Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197C26289
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737355992; cv=none; b=fwZCVXCxxcDeHSW5C60KV3giPuJ0DxwhKdXybDsJ3eSXqNtyMOJ1He40NW9eDm3j9FEjBKXhjAZn8milUSD2tITiFs0/89N/hK10dRn6DcLF40nJPhDw/Yl1hUCz6aTG2GSDHCU3Qe2O4q/OrkssVVz819kHyF5pt/ldMWWvBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737355992; c=relaxed/simple;
	bh=z3U/I9gUNN1OYORYfY2DdFsS8qsAt7HM227Cnvv/wgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PncaSm+np1Pagyse6UgZ5/C/WwY8AOxGZDMtpjnaHkS9bnmA8Az+Qq2CYossLQtwMVc+kutGbHlSWezlpuEfJ9EBOvr2mvHD3uJviu7GtAQxLH68xkEeIRhajLJl73fPA8Azl3OwwylJedUsDWfHlmSyDqslGQxtBPDSZmnXBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+Y7+KKA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+Y7+KKA"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21634338cfdso100428585ad.2
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 22:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737355990; x=1737960790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJZMwKEF6zn1XEgjKkblAAYxHVSORdnMly92nbGtzf8=;
        b=Z+Y7+KKAT58WXy7iZeYrlJyYYLmN1ybfDXn5yt8zNRgcxUZ03C1Kd54vuKoD8ZQ2lM
         Ky+o0eLIoTmvVphSIdSk174lQEppobPhXQHhlC4IdclHSy7xTj//Q2r4GosQ1m+pQEol
         Dm92VYsbqIeJhz4NXqY4R3AG+sm3FRUF9aQKrpPLYwPi3N9f93ojRKjh+dcc1+w3LdK2
         HT8u51fe8L7l21dNQHOEJwIk6zGKEfMoH+sY0QV2B4ZjcaMfXeUZ/3ze1RRhPq6mM6Pr
         JGkwW5VZWwZ00dIk0ohFaXTncqkHuT078/QbHNKM6Lbi/L5/zrLyOB/q+RpIK/PB9oQI
         Uv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737355990; x=1737960790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJZMwKEF6zn1XEgjKkblAAYxHVSORdnMly92nbGtzf8=;
        b=a9Tens5OIPLruWJH8/18dDXaFmBkuTBRJDc5eCq7yjShj6En5eBt6kVCK7WhbTy9th
         54z3KvNAgqyiWTLsnDGqVAPvT8p3VynIiUdA0/NMhyrSWWDI38y68lAFZEfsIyn5GTkn
         LIKbU3c3GMosLdPA5U0nJvDiPZbIH49af0KI6Ba0ETDjc6p4vK/+6FpBg/pl/Wn7UIGS
         I+ta+9IR98+tq5QPvEL60YGhHEkiY2ekMuexEL4/YTuCyQBV8jtTLlrEVK+5JSiCmmou
         L7XK93PKmeo8r60uPQOIKxWiJmFJV5kgt/WyGgdiVPMWGpql7yIpNKIzi1IVz98T45l1
         HhxQ==
X-Gm-Message-State: AOJu0YyvPwDVUWOXkvojkjx/S0Lp/OM0YbjFRLcjy86T0OZjyLAznlGF
	TEqj1id9p/gNDaj3BnT91uva8dSWA5R0tGGAFKgUWsn5Bomq1IYM5ySftQ==
X-Gm-Gg: ASbGncvrwEWkCeXVE2FM97MeOgpu5tiAhjS4Zf95+GEW1lYjOruZcIMLRk+ppbq5JD5
	sJzGZX1fwrYZJUnCK6u5CHD9WjYsA02Pm/cGwGfmmfY0EoR68yXoYHc25sEQS4Oz0mtkfci2xpr
	aA/y/PJjhUxOc/3EUTYZ2Mt5v8NS9ivkHkcpClzTlKmG+NBJLFRdzTVn3opqhlc9yaW9X6hKPwZ
	hTF+7h6qPaHFF4TgcgZCdhl1V6WB7w1HG4ZTpSh5W9QoFBLb4XfJiccnvQtUVuLNA==
X-Google-Smtp-Source: AGHT+IGjfJfZ4aJECp90D+u3xzexcdMoOYJkDAx/FtORVSt5ZI0GIkwyW11QNUD5l4jOkP//KCj7tg==
X-Received: by 2002:a17:903:1cc:b0:216:2474:3c9f with SMTP id d9443c01a7336-21c357b6a7bmr150628305ad.52.1737355990378;
        Sun, 19 Jan 2025 22:53:10 -0800 (PST)
Received: from gmail.com ([172.56.123.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac64csm54912185ad.149.2025.01.19.22.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:53:09 -0800 (PST)
Date: Sun, 19 Jan 2025 22:53:06 -0800
From: David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
Message-ID: <Z43y0mNhHsEdF22L@gmail.com>
References: <xmqqwmetgdgm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmetgdgm.fsf@gitster.g>

On Fri, Jan 17, 2025 at 04:42:01PM -0800, Junio C Hamano wrote:
> * sc/help-autocorrect-one (2025-01-13) 1 commit
>  - help: interpret boolean string values for help.autocorrect
> 
>  "[help] autocorrect = 1" used to be a way to say "please wait for
>  0.1 second after suggesting a typofix of the command name before
>  running that command"; now it means "yes, if there is a plausible
>  typofix for the command name, please run it immediately".
> 
>  Looking good except for "should 0 and false be 'tell it without doing it'?".
>  source: <pull.1869.v4.git.git.1736760824201.gitgitgadget@gmail.com>

(The text below is from the original thread; sorry I don't have it handy
so I just replied here instead)

> ... but would it be simpler if we made it an extended boolean, i.e.
> 
>     true, yes, on, 1  -> same as "immediate"
>     false, no, off, 0 -> same as "never"
>     immediate         -> same as what we currently do
>     never             -> same as what we currently do
>     prompt            -> same as what we currently do
>     number            -> same as what we currently do

I do think that, "0 -> same as never," makes a lot of sense from a
usability perspective.

On the other hand, I don't think that, "1 -> same as immediate," is a
very safe thing to do. One reason is that we should try to do the least
surprising thing possible, especially when the command may be something
that the user did not intend to run.

Recall that this topic was spun up because a value of "1" was
interpreted as 0.1 seconds, which is effectively the same as
"immediate." The original interpretation is arguably a usability issue
that is not improved by these changes.

I would instead recommend that, "1 -> same as prompt," would be a safer
and less surprising behavior. If the user wants "immediate" they can be
explicit about it. "immediate" is the most dangerous of all of these
options so adding ambiguous routes to it seems like a step backwards.

I don't really think backwards-compatibility is much of a concern here
at all. It *would* be a concern if we were moving from a safe behavior
to a less-safe behavior (like this patch currently does) but not so in
the other direction like I'm proposing by making "1" mean "prompt".

Do we think this is a valid assessment and worth changing?
If so I can try to whip up a quick patch over the existing state of
"seen" to change the behavior to "prompt" when "1" is seen and
"never" when "0" is seen.
-- 
David
