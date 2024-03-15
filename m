Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97811CBD
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710539008; cv=none; b=M4n82bzS6ChBz5mtAM54KmCDC4GYJtWtFBrHC25O/NmZis6TWFzFsPYqco9ZW+IEmX/LWkWV3QsRasPf3VmWLn1sIeMt9p/pum0+stry0xiBRuwM1tRYDkvF2rup/yueHQos5QNPhOUSSEajNn5oFCI4XpCuyPc+J3JuF4hA+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710539008; c=relaxed/simple;
	bh=UcUyJWC65HcZUTceFLdm9GmRLru8pbG7nFe8N1tko1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jL0w3fMKiqKutAr4OjDZXplx/3VhanmahlCAEV7HqHC0iJ3M55hBETco4FszgyzmAAqj2huqildsBD8wcrZ/tWChkxwqjJPH/XcIp71pnmlrpGsxMj9YQEieQr7vy+NVpnlnLeZiUzITJAXLmAdLQqsMa92BqNjRCekr1biTkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vNvHfTHM; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vNvHfTHM"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FFEB3496F;
	Fri, 15 Mar 2024 17:43:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UcUyJWC65HcZUTceFLdm9GmRLru8pbG7nFe8N1
	tko1E=; b=vNvHfTHML7ahYqCHIOmL7vonrIxDsoUG6v3yof/YoAIzO1+kydDd8W
	Y51yykCtOswQO82mCLpLrj5qp7711TcqcAHQJFSZ5xlOsTWb9db8jFTjYJUEf7DL
	ePx8VvXByqdxIWoFjgZOYTAav+tqPV49sQOeF7OqkUR1Xk5WMcZoo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 171363496E;
	Fri, 15 Mar 2024 17:43:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A57263496B;
	Fri, 15 Mar 2024 17:43:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 0/5] Unify trailer formatting functions
In-Reply-To: <owly4jd741ph.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Fri, 15 Mar 2024 14:36:26 -0700")
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
	<xmqqjzm3qumx.fsf@gitster.g> <owly4jd741ph.fsf@fine.c.googlers.com>
Date: Fri, 15 Mar 2024 14:43:18 -0700
Message-ID: <xmqqv85np3wp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A9CBCCC-E315-11EE-9078-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Linus Arver <linusa@google.com> writes:

> I realize now that it's because I copy/pasted the "Cc: ..." lines in the PR
> description from
> https://github.com/gitgitgadget/git/pull/1632#issue-2068188239, such
> that when I pasted those in for the PR description for this series at
> https://github.com/gitgitgadget/git/pull/1694#issue-2187804953, it
> carried over the email addresses as Markdown-formatted hyperlinks.
> Currently it reads
>
>     Cc: Christian Couder [chriscool@tuxfamily.org](mailto:chriscool@tuxfamily.org)
>     Cc: Junio C Hamano [gitster@pobox.com](mailto:gitster@pobox.com)
>     Cc: Emily Shaffer [nasamuffin@google.com](mailto:nasamuffin@google.com)
>     cc: Josh Steadmon [steadmon@google.com](mailto:steadmon@google.com)
>     cc: Randall S. Becker [rsbecker@nexbridge.com](mailto:rsbecker@nexbridge.com)
>     cc: Christian Couder [christian.couder@gmail.com](mailto:christian.couder@gmail.com)
>     cc: "Kristoffer Haugsbakk" [code@khaugsbakk.name](mailto:code@khaugsbakk.name)
>     cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
>
> when I click on "edit", where the last line must be from your manual fix
> which GGG picked up. I've cleaned up the PR description manually now,
> and for this message I'm also attempting to clean up those square
> brackets.

The last time I asked the author with the same question, we
unfortunately did not get a clear answer on what should be avoided
(probably the author was happy enough with the message resulted from
the updated pull request and forgot that it is more important to
help others from having the same issue).  Now we have an example we
can point at when a similar issue arises.

Thanks.
