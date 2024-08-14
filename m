Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA21B0111
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660136; cv=none; b=h3jFpzR5c9X/yDNFCrrszaB4yO6oqdJZBzwPgh7AasLny5ExzjIbv23kQdxX3WkcQK8ToMTP4YSECVD6zb38adRbXDzFkoRO2XXEKDuz/RSGN8wrzPilXrHWwIy3phRl4s6rA265t6S0gQK8vEQ1gVxuTFQ7i2XwFU7wLu9T9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660136; c=relaxed/simple;
	bh=yz5BkKPWDhR1d8E/fW74QO3aMVldNwTSID32AbVCIAI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=McU4n7QR/kSTkXh6s+iJxn8grCdlfKXehK8TIDLHuvsnZINMA/FL2Cn4czHeXwOnKv8drZk8NXJC2bhu61bxB5u8WIUlmIfsXaoAaJ9Eun8QJ4df7c77Alkzdmrmn034rmQB7AAqLSxVCR+Q1qFugesHr0KDDtGdNkctN2kdv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0I8axvr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0I8axvr"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7bbe0ab18caso188703a12.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723660134; x=1724264934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xdQj+AVALsdVSqqwGCVfmo/b2XuFC6H3sw2e8nHV97o=;
        b=E0I8axvruQWYlXvKntLh7v5l2uaCCccU2o5u01iwCIGHOWN6zFz/vyTIU5TcqSlM9u
         5RHcPEW6FYRA0bwmjqg0AH89/7S7HyUmv8pbvTcyQMArGp1NIrLXj0Lf39Ap3hMH9Wwn
         BHklhCsllU2xXeFYJyu4j5Y++YFbYiLGSTeCx6XKAam8tf9utcPyVG47smjEwUv6+Gki
         VClfrJ7iN1w3i0gWHwZdRxE2vZPPen11RpmuB9XNbStskyGejaYZGF4n05+0zsVSpOsV
         90dEdhQKLpkOfZU/8s5eHKceMBKisGP5ZKE6XmP5eqKpwj5fC42Qzfj39XrXgFFkcD1X
         wv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723660134; x=1724264934;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdQj+AVALsdVSqqwGCVfmo/b2XuFC6H3sw2e8nHV97o=;
        b=aOO6aX8DmWH5MJ7VtdzRKlj7IXVmraTrMZkf06nI765bh9pMh+Gvw1AHKYyJDgCJor
         HIvrl/WPMIlD5Y6WjlBsebpbe+cKmv6TJDXD+6kpiKoxvdhEIp6+fMsv9c1zJIS4hvU5
         80yHk0xBv2HfLHD63AqPGBcPF/lMqk/yjmsPSqvHbWOsC1ikZpGt8YRLiCvVDVJlzePj
         sRHGoXyqeUXqZwrGqoGrUy5Gja0g8VSs7azyRMHhyioH705jkgkzdjDgMxFdkGuNKNWC
         eEgNEPMEwLS22a7OQM9r0FaH+tBKM8eet6BBYlzCaqNUvV2aEmvOs3+gEH7EuKvknXf/
         SfZw==
X-Forwarded-Encrypted: i=1; AJvYcCUUtxEzfKaeo+45HrE1tHdpGP8EDju3B+UDx4vNOs6kWnzp+yK5sENyxqe6lk+FHu1NZl20rttweDyyU+dX6P/MuqTR
X-Gm-Message-State: AOJu0YyAFTSBykrh2I/hi1hzZat9jAiosDinJf+c9nymFrnQOAiW/UP5
	YwdoXJnbmxPPq3nOXOBLedcrRNfTTEwGkdjejt6hNmJwuTTbg1TbdvQVStgp8xGDHFW4pONu+rf
	HH+qiC7jos3Iacg==
X-Google-Smtp-Source: AGHT+IEqASr3uqDtEBU/FcdNauCZFZKsloULMhUDnpjx0yvERBkNq8MgWhFknTPDql1mxHDu4UKSnw4jwNdL8IY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:5c47:0:b0:6ea:87eb:9493 with SMTP id
 41be03b00d2f7-7c6a568c523mr6363a12.2.1723660133789; Wed, 14 Aug 2024 11:28:53
 -0700 (PDT)
Date: Wed, 14 Aug 2024 18:28:50 +0000
In-Reply-To: <bbaa85ebad458c60c59784b690be8be2ddbe76fc.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240814182850.1273188-1-calvinwan@google.com>
Subject: Re: [PATCH v2 05/20] path: stop relying on `the_repository` when
 reporting garbage
From: Calvin Wan <calvinwan@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
> We access `the_repository` in `report_linked_checkout_garbage()` both
> directly and indirectly via `get_git_dir()`. Remove this dependency by
> instead passing a `struct repository` as parameter.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/count-objects.c | 2 +-
>  path.c                  | 6 +++---
>  path.h                  | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/path.c b/path.c
> index 069db6ff8f..97a07fafc7 100644
> --- a/path.c
> +++ b/path.c
> @@ -365,15 +365,15 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len,
>  		strbuf_addstr(buf, LOCK_SUFFIX);
>  }
>  
> -void report_linked_checkout_garbage(void)
> +void report_linked_checkout_garbage(struct repository *r)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	const struct common_dir *p;
>  	int len;
>  
> -	if (!the_repository->different_commondir)
> +	if (!r->different_commondir)
>  		return;
> -	strbuf_addf(&sb, "%s/", get_git_dir());
> +	strbuf_addf(&sb, "%s/", r->gitdir);
>  	len = sb.len;
>  	for (p = common_list; p->path; p++) {
>  		const char *path = p->path;

Callers have two options here for accessing the gitdir: one is including
environment.h and calling get_git_dir(). The other is passing in `struct
repository *r` and accessing r->gitdir. It's not entirely clear which
should be used in what scenario. Sure with the second option the user
has the option of passing something in that isn't `the_repository` but
practically speaking that's not happening here and also in the large
majority of other scenarios.

I'm OK with this patch for the purposes of the series, but do you think
in the future we should introduce get_git_dir(struct repository *r) and
change get_git_dir() into get_env_git_dir() that simply calls
get_git_dir(the_repository)?
