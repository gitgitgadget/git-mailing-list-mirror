Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98BDDC5
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335517; cv=none; b=LJi1PJxg4EiWrCLAV82BF7edu/Vl26A8LhRMRIkfscsIu1RaYXrpCy9u3ECVAuWhWZm8sGhgD7nVJVaHMq+9uMJnvsHodzx66WRLBpb0HZz9ejawqXrWqcWlUPuINNmOnHx4lu+hxM9iv5f6g3jeL3b+YUf4YcPx07s7agq6Fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335517; c=relaxed/simple;
	bh=EGaLoI2knLmD7Ga4a6XkMdkoBOYILPE8Ii1xYz2J/rM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=aFz1zKkKaDicihGV+hhhVwGMQ1KezUjJdoeal3WeI2FSiCXgrVmhP62GrS7sufK4Lxa4hDNzIXpl6y4aAqoZP4PnkPIurqF6RHzc7WJv15M199bKA8y/Rd+/acK+BzvoF3+iluwYAL+yZlJBMaXyo+AinCGII8syllee5KicvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIiPl6Z1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIiPl6Z1"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so5932303a91.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742335514; x=1742940314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CiRmqh8lCSmdbKo2Y77BHoL1suzcO3chsVekJetT0dg=;
        b=BIiPl6Z1f9JZS0sio/523knOSCSRyyOc5uhjTKXz6xzlzYh7lWQXRK/rrg7mHLhwT8
         R9e1LYwUwNLFWLPIIB9SKW0Aal9UgHg2nWr0ro89kuP0tKE/6oZLGK42vWm3r0phR31E
         CstN2aWzTQcPW2OSLfvrL5q+9kDfaf1y/eHDmJ6yAof1pOnQNcXf8R2iwRASu20IJDT1
         +ONRCjp30ap8a7wP7PktFjqZF9kv+A9/4l1SNwGbOLIHVfQ8n9tXvWZ2dB41UpNeHOo+
         nnoawV4uou+RIvt1b2730ED2kVOVse9PwWVW1fCMPozT1jO0wxmOrxhM7Ug3ruN4sxlZ
         ppPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742335514; x=1742940314;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiRmqh8lCSmdbKo2Y77BHoL1suzcO3chsVekJetT0dg=;
        b=QIq6p3mFvY/spFhlDYifUv1p1kAXBZIEcByfWZUnGqvzYoiz0QVBNqE48X0ulUpmIX
         2TxCmpaMi3/RHTYAqsxJIc0WbtR2IuJD28j/dOoGx4B/PjN7SgCj2wbtKnoHRAbDRh4k
         bhf/kzZ1e89XNl+A+kOEtmE+jnD0k6eneuCme+l4dbqKLANsC8PFd+LnFNL+PtG2Dnfp
         bKPCwacGTbWBTDYkgfnKyd/rLQrC4MZPdIfC294FgpclxvxDVYD02meypG/QUOw83sbx
         YP3gPf1f7RgI018YAivUDWiewZUzYNcIPDKVnM+SOAR8grpCCue3o4lQbp8pbd64LhlN
         JFvg==
X-Forwarded-Encrypted: i=1; AJvYcCWvkJDJI2h9YhcIkFeTsEgoyZ6ehibQrJBMdhEMFEYJyNYiGK65jIYFRtV8PcuXQGVn8Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0MROvFHkQtuKweizjKWzPRrBQKSXJIDA+FkCIpKmL9SCETwb0
	sdcOvhEV1Irmigvo0ypDa336ylK2Q4/A8gwvxDVlD8Jq4a5CR+fM/NtF//cJkRIyd6bTDJMstdz
	JCBJFWjqUbyW0bg==
X-Google-Smtp-Source: AGHT+IGPpoXNvvbKjqpDhZcAiTkq9fiOeJGYO5HgA9wHSwTnOgq934XdQmtB6GPmGzxKk9s8mxvHHVNHQs4qgZA=
X-Received: from pjbpq18.prod.google.com ([2002:a17:90b:3d92:b0:2fc:1158:9fe5])
 (user=calvinwan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2541:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-301be2341edmr518367a91.33.1742335513919;
 Tue, 18 Mar 2025 15:05:13 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:04:53 +0000
In-Reply-To: <20250317235329.809302-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250318220453.1937685-1-calvinwan@google.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: add NOT_CONSTANT macro and use it
 in atfork_prepare()
From: Calvin Wan <calvinwan@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> Our hope is that the number of code paths that falsely trigger
> warnings with the -Wunreachable-code compilation option are small,
> and they can be worked around case-by-case basis, like we just did
> in the previous commit.  If we need such a workaround a bit more
> often, however, we may benefit from a more generic and descriptive
> facility that helps document the cases we need such workarounds.
> 
>     Side note: if we need the workaround all over the place, it
>     simply means -Wunreachable-code is not a good tool for us to
>     save engineering effort to catch mistakes.  We are still
>     exploring if it helps us, so let's assume that it is not the
>     case.
> 
> Introduce NOT_CONSTANT() macro, with which, the developer can tell
> the compiler:
> 
>     Do not optimize this expression out, because, despite whatever
>     you are told by the system headers, this expression should *not*
>     be treated as a constant.
> 
> and use it as a replacement for the workaround we used that was
> somewhat specific to the sigfillset case.  If the compiler already
> knows that the call to sigfillset() cannot fail on a particular
> platform it is compiling for and declares that the if() condition
> would not hold, it is plausible that the next version of the
> compiler may learn that sigfillset() that never fails would not
> touch errno and decide that in this sequence:
> 
> 	errno = 0;
> 	sigfillset(&all)
> 	if (errno)
> 		die_errno("sigfillset");
> 
> the if() statement will never trigger.  Marking that the value
> returned by sigfillset() cannot be a constant would document our
> intention better and would not break with such a new version of
> compiler that is even more "clever".  With the marco, the above
> sequence can be rewritten:
> 
> 	if (NOT_CONSTANT(sigfillset(&all)))
> 		die_errno("sigfillset");
> 
> which looks almost like other innocuous annotations we have,
> e.g. UNUSED.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile                         |  1 +
>  compiler-tricks/not-a-constant.c |  2 ++
>  git-compat-util.h                |  9 +++++++++
>  meson.build                      |  1 +
>  run-command.c                    | 12 +++++-------
>  5 files changed, 18 insertions(+), 7 deletions(-)
>  create mode 100644 compiler-tricks/not-a-constant.c
> 
> diff --git a/Makefile b/Makefile
> index 97e8385b66..605e2d7f61 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -985,6 +985,7 @@ LIB_OBJS += compat/nonblock.o
>  LIB_OBJS += compat/obstack.o
>  LIB_OBJS += compat/terminal.o
>  LIB_OBJS += compat/zlib-uncompress2.o
> +LIB_OBJS += compiler-tricks/not-a-constant.o

The name is correctly added here, but in `next,` this name is set to
`compiler-tricks/not-constant.o`.
