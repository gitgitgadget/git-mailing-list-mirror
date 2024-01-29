Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B41586CF
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564954; cv=none; b=hz9BM8v4xjxGELGU4X8DgqothKtxUA5ajG8PyiRMeUH5ANqnmnw3Lc+w32jcyA+Hf4cdZaBt1t0Hk4hGvkX3TaAHv9njg3SI5kBz3PuFKyDbrBPHygks9z5t2URv7WW/D+b4yFcB2C/8V//sMZ3NkBek7gi9808mjned4PjRAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564954; c=relaxed/simple;
	bh=heSebRn9vcnebFAx4+2gmiMDgRju8nvwxg5pO0Mr9FI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KqWobp/wBETlSPSMIzTcoJn5FsiZgctLelB6BalWCJCTnqqV12zqBC/xC9NKewOYYHUG7GORxuGIYgj7lNL6NLNNbXezsSHkj1nfLlPz92Br6trK3ha7xbDiPIwrneeGfBFdqdTZt8PfgUn59Xm9FSDKB8omqiWfEPbos2KLjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzAT1AMi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzAT1AMi"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51117c00a69so602008e87.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706564951; x=1707169751; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PR7KDN1TEiOmuaRmE7vEYWBGEQiUHT3+POzBzv5z87A=;
        b=YzAT1AMi1uvnZw4D1+3mxF6qu4ovq8nObkHv5WyUjN5OBMdxwpgTCPzqenMj+OpA9l
         R/jg0dMXFTYkFD2eblCpD68KfxCA17tJHFuM4+skRSUpFwk7YrQSGZbljefKgfU4ys7n
         XShlt+IP0JpjONGRGZTHoaeRa5M2BR1ufNVtoiKmMtYSCNG2o6zWPBZnpwLOqaSfw5GK
         FExYzOyX14XYi69gb7CEgnP/5c9y9cGKKWcDNzpafmNjeSBKP1q4Eg51VXB7Mgy77PMz
         shoCF/aXCuD1gBH9jkOFVAAV6o+SBkr+s+gbSn8xA8t0daKpaP8Zxp18rznrGEOo1lPr
         Isfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706564951; x=1707169751;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR7KDN1TEiOmuaRmE7vEYWBGEQiUHT3+POzBzv5z87A=;
        b=k7o1FmwQK49rmf9Xz7JD6FggoFQKi0ozkoVWBr4ZSPDhhFkWw4k3nt8QBQsha34+f/
         V3fTFWAk8R3KWxqoJRENP3vx+W7Xj7TqGiHOVZ0NDM6aUDxbcmIHHj0DiIl47+XZMODh
         ha88K2GXPDKVIzfSPsodZrKGklurWtchZqFJ1BukLIkJtg2z4nMvn74pqHvUp5n5J9X6
         H70TFOpUMuTpY76oYwCAjemdfw6ojci1K/oP6BqjZS5JqxF45NFF3i0aSlWnPBXuxTK3
         /tjfVw2zmMnmLNrguu83J5llMTapK5v3e+wHdNneoXE/NAb26Czxplfhr3IBDhYiv+rl
         RFkQ==
X-Gm-Message-State: AOJu0Yw7AwEI6cfMQLJu0UWnrcYELYzs+rIWEtYOqg6qtaanr7L8anOa
	WgfYsNH0RvGWZ250TW7CqzGSjMAe+vATRzukegEodDI6g9h45Kk5IF6JaRXZ448=
X-Google-Smtp-Source: AGHT+IHJNpczNe740uNB3vVsnb6WgqS/HSUNVn/7VEHkBN9XZnWbwJBOgfKX02Rdn+Qv85va8qnm5A==
X-Received: by 2002:a05:6512:3050:b0:50e:50ee:f378 with SMTP id b16-20020a056512305000b0050e50eef378mr5057301lfb.65.1706564950436;
        Mon, 29 Jan 2024 13:49:10 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s9-20020a197709000000b00510ee2d0ce5sm757752lfc.81.2024.01.29.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:49:09 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,  Elijah Newren <newren@gmail.com>,
  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
	<87ede56tva.fsf@osv.gnss.ru> <87a5ot6tos.fsf@osv.gnss.ru>
	<xmqqzfwspmh0.fsf@gitster.g> <87ede4fg8s.fsf@osv.gnss.ru>
	<xmqqzfwrjdul.fsf@gitster.g> <87jzns7a8a.fsf@osv.gnss.ru>
	<20240129182006.GC3765717@coredump.intra.peff.net>
Date: Tue, 30 Jan 2024 00:49:08 +0300
In-Reply-To: <20240129182006.GC3765717@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 29 Jan 2024 13:20:06 -0500")
Message-ID: <87v87bx12j.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Jan 29, 2024 at 12:35:49PM +0300, Sergey Organov wrote:
>
>> >> I'm still arguing in favor of fixing "-n", and I believe a fix is needed
>> >> independently from decision about "-f -f".
>> >
>> > Even though I do not personally like it, I do not think "which
>> > between do-it (f) and do-not-do-it (n) do you want to use?" is
>> > broken.  It sometimes irritates me to find "git clean" (without "-f"
>> > or "-n", and with clean.requireForce not disabled) complain, and I
>> > personally think "git clean" when clean.requireForce is in effect
>> > and no "-n" or "-f" were given should pretend as if "-n" were given.
>> 
>> As a note, I'd consider to get rid of 'clean.requireForce' anyway, as
>> its default value provides safe reasonably behaving environment, and I
>> fail to see why anybody would need to set it to 'false'.
>
> Please don't. I set it to "false", because I find the default behavior a
> pointless roadblock if you are already aware that "git clean" can be
> destructive. Surely I can't be the only one.

Well, provided there is at least one person who finds it useful to set
it to 'false', I withdraw my suggestion.

That said, did you consider to:

  $ git config --global alias.cl 'clean -f'

instead of

  $ git config --global clean.requireForce false

I wonder?

Thanks,
-- Sergey Organov
