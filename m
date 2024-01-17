Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E81E872
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531126; cv=none; b=tHY3YhSK7dzTh3fAv09rfCO3XtYus46NDUC+l88gsh5f1sm42VyvLNQll1yEtp7fiPCXNJr6+mydHCBOzP3YQ4PoeGEu7GptWc+ZwYLDuCgRLcn1+PuaUXdn6QXJhQ48tB+iSVw4KkERGtf2QPZxw3LYRMte29Zvrh9zIIWuTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531126; c=relaxed/simple;
	bh=MobclfhY0DELo4rsHoydLo3ZdNhmxlYmRqstWyopT7A=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=ti46FjTJNVZXxEaLAMgwNv4pNSpS99xhpOnSdi0G7yLZnY/cEB+wgx9rHOejiZCWTE8WpmGYsIl5hZUmMRsCWyUYWwNFKgna8M7Lh4KSBjqXnguRUW6tNgvkAQGr9Ryi6BBjc/DVJMH/DWKjwbzWsZkWnaXZVFNSqGi21DztHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ib0LjHGd; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ib0LjHGd"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 718FA22854;
	Wed, 17 Jan 2024 17:38:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MobclfhY0DELo4rsHoydLo3ZdNhmxlYmRqstWy
	opT7A=; b=ib0LjHGdF/KsebxPeiZsbYMUyaaHcDIMbzTMosSnCYF4xnRRsZa74P
	CF8u9M62BfhX/rZql3i+32a9UCwN714K4xvbuLNvRyNlh+vTuzNbDbptvlnqNEb1
	vh096NOzRxwso9En7QDqYfdaoufyA7edbNiQhhGdOR6lJBedb7Jp8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A13F22853;
	Wed, 17 Jan 2024 17:38:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0843222850;
	Wed, 17 Jan 2024 17:38:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] rebase: Fix documentation about used shell in -x
In-Reply-To: <20240117085347.948960-1-nik.borisov@suse.com> (Nikolay Borisov's
	message of "Wed, 17 Jan 2024 10:53:47 +0200")
References: <20240117085347.948960-1-nik.borisov@suse.com>
Date: Wed, 17 Jan 2024 14:38:39 -0800
Message-ID: <xmqqr0iftwk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 29BD97CA-B589-11EE-8BE2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Nikolay Borisov <nik.borisov@suse.com> writes:

> The shell used when using the -x option is erroneously documented to be
> the one pointed to by the $SHELL environmental variable. This was true
> when rebase was implemented as a shell script but this is no longer
> true.
>
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---

Ah, our mails crossed, and this is much better than my "tentative"
one.  Let me replace it with this one and queue.

Thanks.

>  Documentation/git-rebase.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 25516c45d8b8..2cd55aedc0f9 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -963,10 +963,9 @@ The interactive rebase will stop when a command fails (i.e. exits with
>  non-0 status) to give you an opportunity to fix the problem. You can
>  continue with `git rebase --continue`.
>
> -The "exec" command launches the command in a shell (the one specified
> -in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
> -use shell features (like "cd", ">", ";" ...). The command is run from
> -the root of the working tree.
> +The "exec" command launches the command in a shell (the default one, usually
> +/bin/sh), so you can use shell features (like "cd", ">", ";" ...). The command
> +is run from the root of the working tree.
>
>  ----------------------------------
>  $ git rebase -i --exec "make test"
> --
> 2.34.1
