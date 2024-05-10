Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3713D25B
	for <git@vger.kernel.org>; Fri, 10 May 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715382546; cv=none; b=dX+IUPebNIijJ2BW4ozq66gR7ResEEFfc1StSPahQVwqG4nf+6y3OeqWi071K5XNBUaukaadX4/v3kd5hgwlcgPwXThLquiC3jLI+tLBNVhsEUvgdZOueoW4SUh84pYDu9OhuK5WdBoBS/+Vz7HFAYIsFZNs5H3H4r3p8GX5wyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715382546; c=relaxed/simple;
	bh=xDk0FuUV+ug35j4Hx3SJx3/FMqco4lgneVGARQr4m24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLCH7n409x3ef3MyHfeV6LeT/0GPd2h85hOdjNGF58qd0G/BGaZNPVHNLDE+vu6Ny0xnxVSUIbOMJ3CBw4MKc1EYCJqoPnyLerPFjPEGM1gdxyPytnba8paNO78BmsAz6DX1QN13I9VSLT44ISkIPnf3Gl7bKW0IdhKUYleuKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILhqT7/h; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILhqT7/h"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso46457211fa.0
        for <git@vger.kernel.org>; Fri, 10 May 2024 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715382542; x=1715987342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnNNRDWI/BltLDTXxw8KkY51Y4sHkxr9P0rOHQyQEGg=;
        b=ILhqT7/hFOzWLVi1CcmNJFtpMQOunIo6nSD06Ve8HSZjecT4rQG6LCpKSe9ikFS2EE
         E3FRZX9Lr5LuveYh7O64O7WDi7uTf2pJPASVAsJ2lUtGQAMt43eQ3TWpU462dNSbxjcw
         BuNDgy5tzVISx/C9qlNyON2FAYq1bBnGbKFgQRbXoem57CP7BYjxVr6rPhk+iFjeydfp
         LONLu6YkLxKZZ2NLHrWrooC/SqoKfTExwqw/3k3iGW24XNNZ1eM8Is+/2mw9BDKq9rFJ
         yYRYmAZd1D3YaxYZaYG4kOL8/5xD2Ymm2rMh9zZSZtFBpU2/7ozDq7mK9ZLMb8+xU1pS
         CcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715382542; x=1715987342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnNNRDWI/BltLDTXxw8KkY51Y4sHkxr9P0rOHQyQEGg=;
        b=mDReydwejqgolNvNzj5NTNJRU0EIumcqaLsT7dRDphl2I2PMppq+DJbtbLXgIcfBvk
         yVEYEy79Z9MGpZmW+Ld97qWvwBOkPAbuL+CGTREvwPbbsZ2HbFVUDt0EJOssN4ikFUwv
         g+rSdHTk4cnQlg9anv2Zm7JpYBjXIxyczHA8ud36yKI+7N7bVSJXoN7Pum4LA+Vk3cW5
         +H57o0Z+U7Xo3oTTb+nrpmJHri4W2+pA44xZyHPsPzRzK72MYOWIK9aKIJFz0/kKcmQl
         42tNFf/KSg1wW6XqsLv8s3XzvVu3x4YfeEd3ufQ/T1SeG1ixQEXJ+ahjemVPf0CUkLwG
         rNkQ==
X-Gm-Message-State: AOJu0YwKTWp/CYPsJztnodEt+wCyrZKuuPtEdM4VmyBiegTqb2fAFvZx
	fbXwd0Vvt9TS91Ay1RKjdsdw4DhhoHnTpp4BRRtKM0Jxb0H1X496AjaNjtrBdYK/ZUy8llviKA2
	hCtDKkoICnYe5JXvmRLe2+IH6gy7JvNCYTllWxb5KkkaZWQl4Rg==
X-Google-Smtp-Source: AGHT+IEBxoqcJK9LS8So0J0fDBQWMyY2C7KiFJTwjpfRtuUopSn6C7Qi4BGxVDDBTk87ELvquwWmYn0pwCz0+fcaYxs=
X-Received: by 2002:a2e:97d6:0:b0:2e5:685a:85b5 with SMTP id
 38308e7fff4ca-2e5685a8815mr4933021fa.1.1715382542384; Fri, 10 May 2024
 16:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715339393.git.ps@pks.im>
In-Reply-To: <cover.1715339393.git.ps@pks.im>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 10 May 2024 16:08:46 -0700
Message-ID: <CAO_smVgBASXOGkGFvB8Nu38SxxRR1VBcrSOg9km2SVGN459_pA@mail.gmail.com>
Subject: Re: [PATCH 00/21] builtin/config: remove global state
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> we have quite a lot of global state in git-config(1). For one, this
> global state is used to track options passed by the user. And second,
> there is a lot of global state that is really only used to pass data
> between caller and callbacks.
>
> This global state makes it quite hard to understand interactions at
> times. This only became harder now with the introduction of subcommands,
> where a whole lot less of the global state is even relevant in the first
> place. As an example, this global state has made it quite easy for a bug
> to sneak into the new subcommands where `check_write()` was called
> before the global data it access is initialized (see patch 6).
>
> This patch series refactors the code such that we have no more global
> state in "builtin/config.c". It's rather long, but most of the patches
> are really quite trivial and only move code around. So overall, I think
> it shouldn't be too bad to review this. But please, let me know if you
> disagree and I'll happily split this series into two.
>
> The patch series depends on 7b91d310ce (builtin/config: display
> subcommand help, 2024-05-06).
>
> Thanks!
>
> Patrick
>
> Patrick Steinhardt (21):
>   builtin/config: stop printing full usage on misuse
>   builtin/config: move legacy mode into its own function
>   builtin/config: move subcommand options into `cmd_config()`
>   builtin/config: move legacy options into `cmd_config()`
>   builtin/config: move actions into `cmd_config_actions()`
>   builtin/config: check for writeability after source is set up
>   config: make the config source const
>   builtin/config: refactor functions to have common exit paths
>   builtin/config: move location options into local variables
>   builtin/config: move display options into local variables
>   builtin/config: move type options into display options
>   builtin/config: move default value into display options
>   builtin/config: move `respect_includes_opt` into location options
>   builtin/config: convert `do_not_match` to a local variable
>   builtin/config: convert `value_pattern` to a local variable
>   builtin/config: convert `regexp` to a local variable
>   builtin/config: convert `key_regexp` to a local variable
>   builtin/config: convert `key` to a local variable
>   builtin/config: track "fixed value" option via flags only
>   builtin/config: convert flags to a local variable
>   builtin/config: pass data between callbacks via local variables
>
>  builtin/config.c  | 964 +++++++++++++++++++++++++---------------------
>  config.c          |   4 +-
>  config.h          |   2 +-
>  t/t1300-config.sh |   9 +-
>  4 files changed, 546 insertions(+), 433 deletions(-)

Left a couple small comments, but looks good to me. Thanks!

>
> --
> 2.45.GIT
>
