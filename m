Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285486320
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854327; cv=none; b=S85GF55xYIJbwFiJ+ivTaJMpfmQ4X4El1CRW91KsRgKHmWGND82Ns7CcBL6GkwCkhNQXmN/n4B+2peLlwMeBaaZelq8FMkqYEdLOaXXJ5/Hdr4eu7Fth4j+I6rk+kNc5BF7hmcG5GZfVBGKbSG+1mFSj/pmt37ZiSonBmul+DkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854327; c=relaxed/simple;
	bh=lddkSLWVqVpz7bPJwML1C6sYb8VNYC53Wb+qB5D19O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYFfFBKnAQsYq5Gh0hbarpgMEjYhBu4WNbwpItJDWH8oIAUetqpb0tReSP9nmSSEWA2xuLVPgo+1/hbNOBKC8KwXDzRxPke2Y2dV3pcUUOBW1Zk44rDDgFDMgMn351qKb/Y3AGl1RZSAPJkvezbDTOoWkSQDaFEB/b8MhYLuT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhPSZK0c; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhPSZK0c"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3a0d9aab47so540463276.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733854325; x=1734459125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dPz1N38tsUF+OBDSJ0jV10Ibz+I65di8gJk4yQP2uak=;
        b=GhPSZK0ccPPfuY5gpz8AdGeordO4NrpSw4D3g8yLwWd1BOeUpWjjrMCW0VIfaPzkR7
         hquZ2AiUNP33lqt+IgXDVjM2NoIkkNVSZqcTD2puZXOYO6gdLGTy5Z1AWg0bdoPASbAi
         KvKkOzYftMtnoy6nADdJEj5iorA1368LUP71dlOOFrKZkPFjoyTUVrHMOsvpnAWOwwiB
         n47yFOwl/AUFGW/3mfeSbusL47Lm4P1eEfcJCT1r2YQMvKiY+wARedZT8RtMsyJc4B+I
         9pccOl0M7GkV5ODiXvjuTAly1X0kr7h8Vz2w7kR6mMQxG/WZ/k33EJn1D2ErUVsinLXF
         QRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733854325; x=1734459125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPz1N38tsUF+OBDSJ0jV10Ibz+I65di8gJk4yQP2uak=;
        b=trsuqKz1+CbZXh+qtx+TUDW27D8MdWpGN5+DcftZwaII2TVg4mUWUxSyz5XjA1zR0D
         xHqzVBxHeVihIWtQnbTT5VtxDk4N14GqHDXLA/RIkS8FyEadVfylrNeWGF3OcRZIMlI6
         TdHuZEFpWzFlzHXWqopy47CLBwn/Nld70QR6b6gXfWz+2xusIRznpctNT6p9jfMndyAH
         PwVqCw/mlGioBQZU7m20dUtwj/grCZDWgTQ0mzE3xbuJlDVsW+AT4AqGaSe+BXdOHn6t
         j71v8nJ4dcpqg6IIWzL7ti3WTplRd2X0tp9T2OmEVmLNkgonmEj4xbAyWfwk3dJ0XMoh
         BNoA==
X-Gm-Message-State: AOJu0YweQU1NAbgB20dFDW7GsqcyEkOLLieWViDrj25Rtup23RwvcLB/
	h5n6D4O2NxS3W2zinlz4nItDuCBdqsV2xtEzHc6er7cin+LSgo2NHQZtvStQ7nPHI1Ot81v2YA6
	5h2d8yFlLfLLKXDyW0SrSa0hsJ8A=
X-Gm-Gg: ASbGncs/tnQXlDVItZIMHPWXz6T2fsUWlqLAUjRSR5GaDvno4egxd3i3r2CDaTa61UH
	+PxHSIcNusA5mNnrDihaHwo2OGW8FBMK0
X-Google-Smtp-Source: AGHT+IFETym0whz+OR/agP5q42AD20QZdOzQtFflBC9ji6gUqbe04woSoWe5ah2fLrt0djeqyYlFt9uL9/+2Aaqn/qI=
X-Received: by 2002:a05:6902:168e:b0:e38:b87f:528a with SMTP id
 3f1490d57ef6-e3c8e72313bmr41110276.8.1733854324002; Tue, 10 Dec 2024 10:12:04
 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207135201.2536-1-royeldar0@gmail.com> <20241209165009.40653-1-royeldar0@gmail.com>
 <xmqq1pygo2ti.fsf@gitster.g>
In-Reply-To: <xmqq1pygo2ti.fsf@gitster.g>
From: Roy E <royeldar0@gmail.com>
Date: Tue, 10 Dec 2024 20:11:53 +0200
Message-ID: <CAOfFamkEmJgUUj8C_TGbjgKs35vSBzNCDpLvK+utqnTtxd5iHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] git-submodule.sh: improve parsing of options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> wrote:

> After reading this, it was confusing to see [1/8] still doing "1 or
> empty" boolean, only to be further modified in [7/8].  We prefer to
> see a single series stumbling in the middle and changing the course.

OK, I will remove this patch from the series and post a v3 series soon.

> While a simple wrapper script is generally easier to debug and read
> if $verbose variable's value is "--verbose" or "", there is a case
> where following this pattern is not a good idea.  If an option we
> are eventually going to give to the underlying command takes a
> value, the value can contain whitespace, and the option and its
> value need to be passed as two separate arguments, it is less error
> prone to use the "variable only contains the value" approach.
>
> Imagine that submodule--helper takes a "--foo" option with a greeting
> message like "hello world" in such a way.  We'd want to trigger it
> this way:
>
>         git submodule--helper --foo "hello world"
>
> as we are assuming that for some reason we need to pass them as two
> words, and
>
>         git submodule--helper --foo="hello world"
>
> is not an option.  In such a case, a wrapper script that takes such
> an optional parameter in $foo is easier to write like so
>
>         # parse
>         foo=
>         while ...
>         do
>                 case "$opt" in
>                 --foo=*)        foo="${1#--foo=}" ;;
>                 --foo)          foo=${2?"--foo without value"}; shift ;;
>                 ...
>                 esac
>                 shift
>         done
>
>         # interpolate
>         git submodule--helper ${foo:+--foo "$foo"}
>
> in order to avoid the value given to the option split at $IFS
> whitespace.  With foo='--foo="hello world"', passing it to the
> underlying command would involve use of eval and becomes error
> prone.
>
> I am assuming (but I don't use "git submodule" very often, so my
> assumption may be way off) that there is no such variable we need to
> pass, but if not, we may need to reconsider and use the "variable has
> only value of the option" for at least some of them.

Indeed, there aren't such variables; all of the options which take
arguments have exactly one argument.
