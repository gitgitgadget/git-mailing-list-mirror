Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE01FECCD
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692000; cv=none; b=cZ1I/YxG3kfHSri4Zm/3oXPeSENZc/TAWDvcKKBkL6eKpn6NkXxHyB6JjO22BOiAJviUZ8m2Jq8JMY16L0ceWWV9Jp7rPe8wgy8jX3rZSstkuVQEgunYl4Orz+w8kjzWx8LfyfeXM7Vmt/ZQsBsGOIqH08LNWZSk1bY/axe27ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692000; c=relaxed/simple;
	bh=dZJqQ5UoLYC7EUjFt/+ung3nQZcTNH8cBs94Kh8KQVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKGD6EOpW3dev28PIf6ogDVKBXBdjCMXb2cIIOPFgxymMGmXp+ibaLK80CnVaNrat3Xax8i0kMHuK3w5eh/VCqRJ4gTI1Eb/p9bkNEkthkkqyhbE3tSCjXuwLPWvyWLWWOXBrmQzUHmiaC4ONw8ATlXSNKiSiAAiMYFqlB3KRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S57o5t4H; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S57o5t4H"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc0d7255434so501778a12.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 01:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767691998; x=1768296798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/MPeN69jKFiN9CVRoymZr/vrqA/mLM9tpeR2iioBIQ=;
        b=S57o5t4H8wox6+nzmQDU+34FiPGgBErj8KuMcycogEGIMDx09Y5hHnO5crxDq04QVK
         d94X0PIzrzikf7U+bHkzH+nLFIoGuun65jxraBFSxeTWCTgCC7Vyd4NqdraR+oltwEsB
         zQJsFGa5VDjH62MgkhknMYFxa4j5HRAdZgj07+yn05Iqo5fp7Ulr5iKLy3SgCBqEp0t9
         7Eu1QCfnsvPRiJI6PdKzKUwSrK5RuicwFP1Y6nx3t+KbJJ/CtTFRMqnt1xryQwItYBm5
         xG5olE6UL3BCim3uGDZAqFcG9EdIL8n8LlNtDsvLIPv+cfsfeZ6g2w/qfxlKz+dORL4s
         m8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767691998; x=1768296798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/MPeN69jKFiN9CVRoymZr/vrqA/mLM9tpeR2iioBIQ=;
        b=pX0+SuukVGkGZas3f2+/bAz+7TqtcieddQtW1nDlpkD6WvvrZb1OmYXuBh0rsoahup
         q4AKWuERkYdSpzd1vA4T+2aRrolcXcS5abFjkRQALsNvw9usjnnBYzECI8hAi/WsxJkK
         34XF7l7biDeW82U28wuTGYXMlaTvdfD0cCs/MUoftkIoH/rIb0N2JzaT4tAOgZA/gW+C
         /1gZs4iYp57px+ZZaGhN8+On0vx54RNjDJhWRcT0Nmj+q5aXsfRuD+lnVTQEKzye5uOm
         Wi2MZT3qRb5QBxqBREmcZU1WKuUaL5or0MtoOOdnL40dc3exofAyW4KM6mip9G+DRv1Z
         HPng==
X-Forwarded-Encrypted: i=1; AJvYcCXPOPlxG36OgFbFPyaThtCH+cJ/dlkDxLpw9t+k3qGz2jIvRtuu99LrSoyI9jBMiGUMNp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzesTevHts0e+O4Byp8hvgalC0SZyWn7WjjJksoVBy02E6rAdEh
	AeOXdlmiGEFSTWi3jOxQmGZb8xUokopwW69QdnSpLdGQKZdNh7TorSfu6aijJto5JsvBXJrjfv6
	S5Grpd3jXpZAx6w8hhF18O+MAsLS4bQiz08DGzY3xAw==
X-Gm-Gg: AY/fxX6hI7ZL4+5t1Uapna4CVrzpHAOSKjMX8FFzT4ZOI2VcsRp3X9NheLRSAI7dXDh
	Mxms1HcvyJl+DcDuHnVa5PAYP3iER5Gc5ZyFiPYVl6ALkLbe98VDgtMwtjbtme83hN4hS+E0zum
	PVfb6PNhQ13RglmspewKBzepJrV/TC9trkE2QYPIR63bEt3AI3Lxp83dbFZ7JaJRAltKhVfDxMx
	rkx1rp5x/foVVukLwvUItC2LvbMgC5cK0ZlnnMW48BqCfkhpbhxfQYz3OuWwvRnpGl3WEpyxWQ=
X-Google-Smtp-Source: AGHT+IFUmZ2/VcE3Egj25sFGAFpYg5GHbF052mocSAph9y504rvEqYwjEFLLf0c3+f7sNmdWGFhewM6kkXMC75Dd3aE=
X-Received: by 2002:a05:7022:252b:b0:11b:a73b:2327 with SMTP id
 a92af1059eb24-121f18e1d51mr2144133c88.30.1767691998437; Tue, 06 Jan 2026
 01:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVfzMsN2ouY3UBFG@ubuntu> <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
 <3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com> <xmqqwm1vk83a.fsf@gitster.g>
In-Reply-To: <xmqqwm1vk83a.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 6 Jan 2026 10:33:20 +0100
X-Gm-Features: AQt7F2o1TtmH0zrkng6Eev1SdgsMVshOlDaxDecfwcVc-TYTC1-0Qgxk17BOn1A
Message-ID: <CAD=f0L9BEPSQivgpM7qURT+WFDY-+Ys_M6Knv8hE0JDw4Wjj5A@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into repo-setting
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jan 2026 at 23:28, Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 05/01/2026 14:23, Phillip Wood wrote:
> >>
> >> It is quite common that moving from parsing config settings eagerly by
> >> calling repo_config() at startup to parsing them lazily via 'stuct
> >> repo_settings' causes regressions like this. We really should find a way
> >> to address that before moving more settings into 'struct repo_settings'
> >
> > See
> > https://lore.kernel.org/git/d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.com
> > for some discussion about a possible solution.
>
> Nice, but I suspect it would be an improvement already without
> passing repository instance via git_default_config() and instead
> have the code use the_repository; it is even possible not to have
> any repository when the callchain executes.

Thank you Junio.
Okay, should I move the variable into the repo struct or repo-settings struct
as the case may be, then initialize it in git_default_config()?

For example
`
         if (!strcmp(var, "core.attributesfile")) {
              FREE_AND_NULL(the_repository->settings.git_attributes_file);
              return
git_config_pathname(&the_repository->settings.git_attributes_file,
var, value);
            }
`
Does this sound reasonable?

Also the `git_default_core_config()` is used to initialize the
variables to store the settings
in the "core" section of the config file.
So how about other functions like `git _default_branch_config()`,
`git _default-sparse_config()`.
Do I use the same approach above?

Thanks
