Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846314C5AE
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264636; cv=none; b=Eet365BjDtfbvr2sALOsx5BFd4yUE/Ywsx9Com9euoeT7iY82MHBX4EjI7QW7fY7e9M9GvjF0e38MR8EYf7BAOm4UyOXtKhFVPyt/96ukjiOk7b4vvlLiijmDsU4fkX8PEQiUDBEpFV3YZo9ywRXzAwaRZbQrHpx5xipr1lFZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264636; c=relaxed/simple;
	bh=ZOXjTU50EqQaVZXBjxyVsmqXy5gYCtx4NZL0IPIzUDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE+daa+m36vT9qGhh5bijuD+yyDb4MevGjxeB1pu1dGvhXQCekvk0h+TmiPLu0q5NppQaYPMscrGYBX9gTbMqeNmcYAPdRMskc73h6DS0/XU5hnOYiZNap3wYLSXsVqBV65qvZTADRR86Hhxn2g279ftrLguNeGnnaSBX/F0d3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ieCO3O/h; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieCO3O/h"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202018541afso21105ad.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724264634; x=1724869434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ElCBrTroCknMXm0mgjhLhqe1gD/O8GfzJ5vgUPkmOY=;
        b=ieCO3O/ht+XLJ+URKUTm4ZQb/VV/2osWmefAoe3jPjgzmnvnl0TNdU5B70//zdWGQs
         GSmBIe2qvfKEi8xqD7mW09sWzKHLpK3/bdRc/psboDsjwupiTPg0SnnTF7P42DVwfufu
         AiUC6mo4vTFTct4C0NtwNtBPMYA+AUe0lZeLJcyFyd/3K51GeZc5pmYwRpMXeMEDhhcd
         tkAWDa197sUEf5NcIY4Qi3rFD2Crp3NCzTA8uEQdvPqvwrbJ4UHVWxJGsd2w62vM8Vs0
         7S7Ul8XL7rsyGxbx+KekzS+x/unAslfxu0fzE3JQjL79gLRW7yNUeezx4Z7zEMgo3x9s
         /vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724264634; x=1724869434;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ElCBrTroCknMXm0mgjhLhqe1gD/O8GfzJ5vgUPkmOY=;
        b=wasrP6OrhJLrbHGcIzB448d7SirMF+gpB6E3pZ+QoMkSMIUjJGzsCF0+C0vWizEE5B
         QL63nw3ywEWNhAOLZDbBI+lXkpP3LPliZxu/9YroF9PkIz6Fu3dEnC4CdlKOs7YJICY9
         8ZfkfN9gVNNd+btwmUi9GGjqyIwVZ5D4a+V9W6XhdZFvXUHaIIM11eGlInmSlBrVur8K
         X6lY7npAohnND3sZRNZhMBU4gRhYwkgX+JEwmI8q7u0Ma+8ljHDaVL22yY0hd4RQHgE5
         0MPJxFH2gkekUXE/Jp5zq65gOjpLfonoZuCgWMchyD/t6Z4QidPbNgyJwMshmrXl9gYB
         sDsg==
X-Forwarded-Encrypted: i=1; AJvYcCXqtOZhAwgmeh+uKBQZwZgTMOkXfklzYdbIPVGMyvLYvqqNXrqoYR0u7HmDFDmaHP+2PvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIB2lJFlNd/Kw+IZ0c0AKmqYm6/ZRBt6GvkfapIByPyYnU1+P
	q9AWv8qIzSMp06TenmVEHh0G9ffWrevCHQCBDDHTUIWERflSNxaTwujm5R05Rw==
X-Google-Smtp-Source: AGHT+IHfpmjq0xAGiUxNg6+sErsheBxyAlSmtaPFL8rf87In6jgC60BMJRozbx2yZeubcKDRhBoDuw==
X-Received: by 2002:a17:902:cec8:b0:201:e646:4ca with SMTP id d9443c01a7336-20382370792mr275915ad.14.1724264633517;
        Wed, 21 Aug 2024 11:23:53 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:b433:fc59:16ec:53b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0378952sm96806835ad.133.2024.08.21.11.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:23:53 -0700 (PDT)
Date: Wed, 21 Aug 2024 11:23:48 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] send-email: add --mailmap support
Message-ID: <ozlr4xnrfk5vggtwhgwmnk7ewthfu4lpuerk3lpludj6ggpgux@zngcfcr6zve4>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Jeff King <peff@peff.net>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>

On 2024.08.19 17:07, Jacob Keller wrote:
> I recently sent a series to enable mailmap support in format patch. The
> discussion led me to realize that the true problem we wanted solved is to
> map addresses at send time, so that we do not accidentally include a dead
> mail address when sending an old change.
> 
> Instead of worrying about what the formatted patch has, this series
> implements support for mailmap at the send-email, which will translate all
> addresses, and not just the author/commit addresses for a patch, but also
> the email for any trailers.o
> 
> With v2, we now have a configuration option (sendemail.mailmap) to enable
> this behavior. In addition, I enabled support for email-specific mailmap
> files.
> 
> The intention of these is to allow a maintainer to map the known-dead
> addresses of former colleagues onto a current email for an owner within the
> team. This would be used to update the send addresses to avoid including
> no-longer-valid addresses when sending patches. This is intended for cases
> where the original author is no longer valid such as when they are no
> longer employed to work on the project. While sometimes pointing to a
> canonical public address of that person may make sense, in other contexts,
> removing them from the email makes sense.
> 
> I believe this version solves the use case we have of ensuring that we stop
> sending emails with invalid addresses, and may be useful for others as
> well.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Changes in v2:
> - Loosen restriction on git check-mailmap by default, rather than
>   introducing a specific --no-brackets option.
> - Re-write commit message for the send-email changes.
> - Add --mailmap-file and --mailmap-blob options to git check-mailmap.
> - Add configuration options to git send-email for enabling mailmap support
>   by default, as well as providing send-email specific mailmap files.
> - Link to v1: https://lore.kernel.org/r/20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com
> - Link to previous "v0": https://lore.kernel.org/r/20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com
> 
> ---
> Jacob Keller (3):
>       check-mailmap: accept "user@host" contacts
>       [1] check-mailmap: add options for additional mailmap sources
>       send-email: add mailmap support via sendemail.mailmap and --mailmap
> 
>  mailmap.h                           |   7 +++
>  builtin/check-mailmap.c             |  25 +++++---
>  mailmap.c                           |   9 +--
>  Documentation/git-check-mailmap.txt |  18 ++++--
>  git-send-email.perl                 |  20 ++++++
>  t/t4203-mailmap.sh                  |  33 +++++++++-
>  t/t9001-send-email.sh               | 122 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 215 insertions(+), 19 deletions(-)
> ---
> base-commit: 87a1768b93a67d0420255a43d9e07387b2e805ad
> change-id: 20240816-jk-send-email-mailmap-support-1a9e86867c72
> 
> Best regards,
> -- 
> Jacob Keller <jacob.keller@gmail.com>
> 

This looks good to me, just some small test complaints in Patch #1.
Thanks for sending the series!
