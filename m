Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A883BE65F
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550748; cv=none; b=R9kk2IyPho8y1bvHWcGpbLLebnJ2gqnnC5uAu/gh0QZcBhEa4RXK+pCqORYK2YbBAW+olfbws8nYtdzdr+WdAcmyRKu/F9+DnNNNcz5OcUF7TywCOzJCgbzqPg+/RcHKiM8w0XeYV/V+aQyPg8MTZ7v741dGNvF0tbseYDfZGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550748; c=relaxed/simple;
	bh=O5kMrFtXNDXONsThEw9SGrC/fuMNJRozzpykGsqW/vM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E4Jij8EWyNAFVSlfz3sBj1xwWLFNUjKrxxe2XESuN01PcHtIyN0gwyvkX3r2MJCZlJVQVBPoVXxlWjc+Fhn3IOwEeJKnP605MfTLczQm1wH0EtKtmscPrTZuErXTcLrw3XcPozoZhyvjmpj6dAqtMYOEaBZrYo8nc9Id5R3GBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=iOswX/x5; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="iOswX/x5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1780550742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4h1OGXlfz9tZarWPu6/aluJrhmMcwUHaDQ5iml/2QI=;
	b=iOswX/x5tyeSNZXkHJSuzhmd2fhcj2nl0JuPf711Y/Ym1iTCYzJrsS8FZn3fZxJS/6dIgk
	xOEP0PqAo15PED18hfuOYsjjUnwvQqOdLASSr5rRFVEDA4mGvMUi9nKspTrlDm+CdL2G0L
	xD14ac+DTL6qyj8Hq3o9Qzy4GkirCXk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, Weijie
 Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 2/3] Documentation/MyFirstContribution: recommend the
 use of b4
In-Reply-To: <20260603-pks-b4-v2-2-a8aea0aa2c23@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-2-a8aea0aa2c23@pks.im>
Date: Thu, 04 Jun 2026 07:25:37 +0200
Message-ID: <87mrxa27xq.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The b4 tool originates from the Linux kernel community and is intended
> to help mailing-list based workflows. It automates a lot of the annoying
> bookkeeping tasks that contributors typically need to do: tracking the
> list of recipients, Message-IDs, range-diffs and the like. In addition
> to that, b4 also has many other subcommands that help the maintainer and
> reviewers.
>
> The Git project uses the same infrastructure as the kernel, so this tool
> is also a very good fit for us. Adapt "MyFirstContribution" to
> explicitly recommend its use.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/MyFirstContribution.adoc | 92 ++++++++++++++++++++++++++++++++--
>  Documentation/SubmittingPatches        |  6 ++-
>  2 files changed, 93 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 069020196c..fc0b06ae67 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -833,7 +833,7 @@ This patchset is part of the MyFirstContribution tutorial and should not
>  be merged.
>  ----
>  
> -At this point the tutorial diverges, in order to demonstrate two
> +At this point the tutorial diverges, in order to demonstrate three
>  different methods of formatting your patchset and getting it reviewed.
>  
>  The first method to be covered is GitGitGadget, which is useful for those
> @@ -845,9 +845,14 @@ more fine-grained control over the emails to be sent. This method requires some
>  setup which can change depending on your system and will not be covered in this
>  tutorial.
>  
> +The third method to be covered is `b4`, which builds on top of `git
> +format-patch` and `git send-email`. This method is the recommended way to
> +submit patches via mail as it automates a lot of the bookkeeping required by
> +`git send-email`.

The GitGitGadget method includes Running CI, maybe that's worth
mentioning the user is responsible themselves to run the whole test
suite? Or is this outside the scope of this series, since `git
send-email` doesn't include that too.

-- 
Cheers,
Toon
