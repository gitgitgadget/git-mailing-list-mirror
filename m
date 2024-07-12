Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068A15ECE1
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798512; cv=none; b=OIYi7a3UZ8JIKRKon3N1R0T0Ah29lSFk78+JqJe3wlnkbZ/LtjYXBoIDuUmEAMsqxAteiHMHN29UiSIfkzNqBajt2h+zgrDB8CIVj/4g1SxrOOMA+F5E523/xPvBc69ZaUV67xhtqsj0Y5pQROLoEsHgV490uGH8h0dPZH6oH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798512; c=relaxed/simple;
	bh=/+t3IXEfINgudyvOVIk1l27y9I1fi5j/Coe4TRilUuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cg65CJalTM/kfLXYme3xHkds8TnV6Z5cdH1HhtvFQ8THeDjR/fyDCSW+z4WuFiEqtiF492clXTmhoYhIIqxrXlWd8yzEgt5C1e5P7jGDyJSHLOaME/5m+x5fxE0pRACizQSpsRePlD5WF4nOTCAq1+v/JGhG6G3NKdCtWh75/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gCD7bsZ+; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gCD7bsZ+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 55FA72F66A;
	Fri, 12 Jul 2024 11:35:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/+t3IXEfINgudyvOVIk1l27y9I1fi5j/Coe4TR
	ilUuw=; b=gCD7bsZ+e8Jf+BJxTHwS1HgZ+iyUfjQNZU8ucgi2AP6N4yTHwQaXeZ
	nl84aOAgmO5x7PNGOdPv8Rek6Vmxnct7W27LQyLz1QhGLysdfhewBsPwOQ+kfVHl
	DHkyHyR8OunnKFuKpwoBBtthx+cXjDVl/TcPPMQniYaYRfA9g41Gs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E1612F669;
	Fri, 12 Jul 2024 11:35:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5C2E02F668;
	Fri, 12 Jul 2024 11:35:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 7/7] var(win32): do report the GIT_SHELL_PATH that is
 actually used
In-Reply-To: <8bfd23cfa00c351ffdcc25bd29f3b84089544a56.1720739496.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 11 Jul 2024
	23:11:36 +0000")
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<8bfd23cfa00c351ffdcc25bd29f3b84089544a56.1720739496.git.gitgitgadget@gmail.com>
Date: Fri, 12 Jul 2024 08:35:03 -0700
Message-ID: <xmqqikxaoc7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4FF21A40-4064-11EF-A311-C38742FD603B-77302942!pb-smtp20.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, Unix-like paths like `/bin/sh` make very little sense. In
> the best case, they simply don't work, in the worst case they are
> misinterpreted as absolute paths that are relative to the drive
> associated with the current directory.
> To that end, ...

This does not quite explain why a hardcoded full path does not make
sense, though.  If you do not want "relative to the current drive",
you can even hardcode the path including the drive letter and now it
no longer falls into that "worst case" because there is no way to
misinterpret it as such.  I think the real reason is that the port's
"relocatable" nature does not mix well with the "let's make sure we
know what we use exactly by deciding the paths to various tools at
compile time" mentality.  So if I were rerolling this I would say

	Git ported to Windows expect to be installed at user-chosen
	places, which means hardcoded paths to tools decided at
	compile time are bad fit.

or something.

But it does not matter if the stated reason is to use the "find 'sh'
that is on PATH" approach was taken tells the whole story or not.
The important thing is that we do ...

> Git does not actually use the path `/bin/sh` that is
> recorded e.g. when `run_command()` is called with a Unix shell
> command-line. Instead, as of 776297548e (Do not use SHELL_PATH from
> build system in prepare_shell_cmd on Windows, 2012-04-17), it
> re-interprets `/bin/sh` as "look up `sh` on the `PATH` and use the
> result instead".

... this.  And with the design constraints that it has to be
installable anywhere and cannot rely on compile-time determined
hardcoded paths, the above design decision is a very valid one.

> This is the logic users expect to be followed when running `git var
> GIT_SHELL_PATH`.

And matching `git var GIT_SHELL_PATH` to what the code path does
make sense.

> diff --git a/builtin/var.c b/builtin/var.c
> index 5dc384810c0..e30ff45be1c 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -12,6 +12,7 @@
>  #include "refs.h"
>  #include "path.h"
>  #include "strbuf.h"
> +#include "run-command.h"
>  
>  static const char var_usage[] = "git var (-l | <variable>)";
>  
> @@ -51,7 +52,7 @@ static char *default_branch(int ident_flag UNUSED)
>  
>  static char *shell_path(int ident_flag UNUSED)
>  {
> -	return xstrdup(SHELL_PATH);
> +	return git_shell_path();
>  }

Simple and clear.  Nicely concluded.

Thanks.  Will queue.

