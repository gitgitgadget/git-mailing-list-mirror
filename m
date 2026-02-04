Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697353E9F82
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203958; cv=none; b=tKeOP6hPscKrVP9+/M2NGLS1xmXmhTivp6IUXhdyfTxh5vFBrb1vka8QKaEQe29RwvAJ+Vd2h4JYzRuRFkddhquSfhAl9BipgKYHm1xZJX5hDcTcAOYQotgp2WJbr653Y5/K3LVjFfELxHY38vmPs1b+D7dt/Be7xKOtsjtKNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203958; c=relaxed/simple;
	bh=4I0ttxBthHNUmOPoteTCvUqqtFLYDlAdWBQOt8U2Gow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sE+7VkTd4Xkz8shJm16hMezuFhIWsCLmEQhSSPAjGd3JDIU+G66SeZ6Gwzit81vrLNkxByz6EswoWB9kUK4tcjGSXGKDjVzhud7Blp6CQ/vS2B1uVpSZD5uPSFZBHyuoK6uauZKrASNbDqSRPX7JZ8tb4mpOrkV2Uq0QJj514po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Usm/rcAb; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Usm/rcAb"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-435a517be33so4033275f8f.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203957; x=1770808757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB+dfQE0m5Z0bUDfcUDS51JklrXNzN2F5QXzTub1JOg=;
        b=Usm/rcAbZjDs11OF9QVWEDM75sckbLhldEUOaVUxUrecX9VNAiyOdfduqXFTaeF+ds
         EYll/40zU8eafs3YjNjRWge7sSdEGWnepjeUB6CXXGLgcUCFCP53czF4Jl36Dgqf/nJo
         Pmz4zBtB+LmTXhL47192SOEnEf7pVBnpaikFj7QPztwQBSUhpeIaremkOi720qYjwYWj
         XR1goFRK0Mp54zlseg/9jeWY8/RUDaza2990hp6o2x3ZzD99D+K+uL2QIjWH+QQQFFTN
         /J8lJnXTe4GBWcAe5rjAt8DjkdyZ5F8sQBLqITnrychgnfsqMcLeqDeDzCTcazgb5a57
         5NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203957; x=1770808757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BB+dfQE0m5Z0bUDfcUDS51JklrXNzN2F5QXzTub1JOg=;
        b=ubSd2GNF1zw3JXU1UEJ8BpY3sY9GoyBA/yr+hXTcnofTC8Zp2umxM6PjZ+b3FxVIAN
         JfK1EsEUriuxRaYZNC/GBb1HPwtCgTq/LIiF9v3GbL3Ay37HUbufob5R0Mr26YcgZ/Au
         El84WvameI5n1HZBvyJgu9YE6k2JTAFvN2MiO2Gl/3kXOYSPBySRL7d4a/I3W9mO0vUw
         6xtIvgFH7L0gsMLKBbf3WFDUGyyahMr2XKJxlYJuFlIODbuzabpicBZEbzRnzFBm2GGs
         A9HrDkdMv50WDDKU3tDeDun6V9SFHPgXFPwlIw4LIpXp3DKp3lS7wqnlAQSShee8I5CO
         mtNA==
X-Forwarded-Encrypted: i=1; AJvYcCWEBdIQI6XdV0FG8wiAEf8pAG2FD+7o35dDOkrG+Oooez7p7aEqraBi6osCBWzaYzYED8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4Ed+9GEf3k0gWRgHCC848GmvFDWKyHmZoBxNrSyO332S4cYV
	6M/CREag7Rco3hb3ZJGayFFkGliQwPCkcrQMod7UCR8zGZ9D6FBfJ6mX
X-Gm-Gg: AZuq6aIQhHKsNFBkYdrTxfrpNZ+DYsm0EId/sz243giNnqTPuNE+KckjvwKkKtYW0l6
	zpWKWmCTmQnTdJXOob16u1P0GmS6gpmdhSNmj9pPgZCzUGP+WCIGulqP2KRjZkImHF93NorAwrP
	IRDxJ+qnOo6oCfVxw7SeN7g4nVXxHs1iUa79UIXgDFPEz64IxM4NmuGAzDfXIjD/+Xzbs3IMp4x
	zIiWM0m2cZrw0kXEET/sjyz/jNgqLbH4gmbICv+ogGyDXzysnlmVxNtcZLTRERlzTFDyTupA7lU
	VUgm9ubvigorMIqCeWV+DNhgSqJ+dDHWdFgwGtkj7nviQqPU5YSfp5dhjntg8MljIFHCskatDpS
	h5x6JrGIXt08S+tqNUZ542vrCYb+11oGvgPrzoCw68JiURw9VehLpwzR61q7JDoN8T7zvQiQ4f2
	T/KVTfQuWUBSBFRkvs+iOp8kZigj/4Cia4nhTFAEtEQdMyxgnx3qRlq3y5519ZVpnR/PNlnpSWQ
	nAvrRYOWHFTo+omWPyKzLC8lM4=
X-Received: by 2002:a5d:5d84:0:b0:435:e061:9e10 with SMTP id ffacd0b85a97d-43617e39658mr4089689f8f.12.1770203956591;
        Wed, 04 Feb 2026 03:19:16 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e3a3bbsm5687133f8f.15.2026.02.04.03.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:19:16 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: avila.jn@gmail.com
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	newren@gmail.com,
	ps@pks.im
Subject: Re: [PATCH 5/9] doc: fetch: document `--filter=<filter-spec>` option
Date: Wed,  4 Feb 2026 12:19:07 +0100
Message-ID: <20260204111908.2920406-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.10.g12663a1c75.dirty
In-Reply-To: <4702585.LvFx2qVVIh@cayenne>
References: <4702585.LvFx2qVVIh@cayenne>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

(Sorry but I cannot find the email send by Jean-Noël in Gmail so I am
using `git send-email` instead of Gmail to reply.)

On Fri, 26 Dec 2025 14:33:38 Jean-Noël AVILA wrote:
On Tuesday, 23 December 2025 12:11:09 CET Christian Couder wrote:

> > diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-
> options.adoc
> > index fcba46ee9e..70a9818331 100644
> > --- a/Documentation/fetch-options.adoc
> > +++ b/Documentation/fetch-options.adoc
> > @@ -88,6 +88,16 @@ linkgit:git-config[1].
> >  This is incompatible with `--recurse-submodules=(yes|on-demand)` and takes
> >  precedence over the `fetch.output` config option.
> > 
> > +--filter=<filter-spec>::
> 
> The option itself must also be back-ticked.
> 
> `--filter=<filter-spec>`::

Yeah, I have back-ticked it in v2.

> +	Use the partial clone feature and request that the server sends
> +	a subset of reachable objects according to a given object filter.
> +	When using `--filter`, the supplied _<filter-spec>_ is used for
> +	the partial fetch. For example, `--filter=blob:none` will filter
> 
> Isn't this second sentence redundant? What new information is brought?

I agree it's redundant, but I copied it from the `git-clone`
documentation as-is because the goal here is not to improve on the
existing documentation but to fix the fact that some documentation is
missing.

That's why the commit message said "in the same way as it is already
documented for `git clone`". I have improved the commit message to
make the commit goal clearer though.

If the documentation was wrong, I agree that copying it as-is would
not be the right thing to do, but here it's not wrong. And it's better
to have some docs that are a bit redundant than to miss some docs.

Also I think it's better to improve on the documentation in a separate
commit because this way:

- the `git-clone` documentation could be improved like the `git-fetch`
  documentation in a single commit (so we get consistent documentation
  using consistent documentation changes),
  
- how to best remove the redundancy is just a separate topic that I
  prefer to avoid at least for now.

Thanks.
