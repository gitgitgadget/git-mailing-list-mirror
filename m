Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FD20326
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736146811; cv=none; b=aHbl+aV9EfKkZPYOYXuyNlU7UFqXW+AI2pJQTWiOA0yrTQwnlUPowimhPVXHBN3kXCfp4Tq1CWDGdgUJ8ma0iZADKN40oCGvGybnnTU1eUBouWGM6n/+03Lyq+Q5PB8UDIoJcBCrSit0rS9ZnvpqMKo9LUg/wSGWtltkqupU3eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736146811; c=relaxed/simple;
	bh=9nC9VlNu38lnOt3Bu/3YDP35yY9C+EPtgAGzGYWhOQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS83l/2JRD2A7XKyB0ZPSmmIPgzi6Dtah84L29fTduAS2scrcti8lS8FK1gbrCXDhyhVlk+iPj1uSi3J8SIQs3YPtFqnqImFGgks/nziVNallfWTJVuduNQcno2vLudAq10WUqSsOgCkQL9/3jkhay38dhDjsg5qPRml/xxeIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jWSo34iA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QKje6shn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jWSo34iA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QKje6shn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 74B121380169;
	Mon,  6 Jan 2025 02:00:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jan 2025 02:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736146805;
	 x=1736233205; bh=gVCHPWi9lMN9B/Yu9eIH8mHh3fiNQqrEp7TcLAvy7MA=; b=
	jWSo34iAJ5Q67HqrCOHTxQx4nUo5hdbwCDURC6+X6PKRVrwI8n4JZFwCDd4TahNS
	MU+vMiX/pR0blqyXuKfC2EfIXigPPbMCzQHH7WaAwMPnFcehpKZJYtXe/KcJNvy9
	Q7T+s4PBjF+Z5EJLvM8BadOheiJLf3kxC9jxjfGFJB8kvzSkWhsKWZmS3M+Ola2I
	mq+fhI4K/1YEDNw2DlDqPWwCGeQUMndV9eZ8AftdnLGkJajrOdnaS1NycbrrAeWN
	H8EHLuighJnQXpQcyrjjbw+7AEOiYRWuitIMEkMh7EX5wU7mN5HOu1RNEVby+dD3
	mmMI2fdtYvMPTHkQ710EHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736146805; x=
	1736233205; bh=gVCHPWi9lMN9B/Yu9eIH8mHh3fiNQqrEp7TcLAvy7MA=; b=Q
	Kje6shnSTKXpBXjxXkhvrQ0vkI6qC3uFa2BRymfL8abLOi9BeXeSD/Ol/DiRJMF+
	kwm0l90/l7EkJP6Ai8ohS+QOcTiLbrMgpBHYkuZH2Eu9DUOFKJu9WP/6i9rT/xyz
	131sIj0ChXuDOLI2UZ+sDgtIOhhHaMQui+ZFbdpJZAnXjPWkErqy2eBuJMmhkVl+
	0DaESA4fhJNo92WB7dy57eVCwuw7Ss9LVmoZSG+9DvIb3kvFS9S7ThDfGImrBsq9
	BMHgakzeNqR85wdd8LU9RtOWHiO7m0r8qEasWDG0NSWayIf629QapzLjtX+7bC1K
	97XW3wqSiuc2XCs81UNiQ==
X-ME-Sender: <xms:dX97ZwXMzD3Ht7RD-NuN6ZCyj2oC7dYC3m8_ACxb7vKkkScaRFbnzg>
    <xme:dX97Z0l4EQLf0RYEZUREUFFKxnN9LwCzrYln-7lMO6Nj69jda3Kjc-rgV2r129Sqt
    Knl38wDOyE-agIX0g>
X-ME-Received: <xmr:dX97Z0YlLryt3MsyO4tgY5aIEGGII0MtWutAetA4cpeI323aO5-JenCw60QspECjMdufTxvNHEuqu_PQos6X86AXgmJEh1HzfcNbxrwd19HPSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dX97Z_UujuqVQ_WyqNH4fjnttH6gc740lUPkR52Zqd1h7VvJEY1ZaQ>
    <xmx:dX97Z6ng2Zi3XCYVXs7tyBbA0LLH3-oy9eyXO_hxUaIhDoaRK57Z6Q>
    <xmx:dX97Z0caT__lRyJaRJOxWye65mHJrfbAABRvUvc5Cx8yNdC-bvMwig>
    <xmx:dX97Z8GLWwTUeOHQs3cMfsw0-QssBMCJ903CXSCBJCRVe0y3QnDtvA>
    <xmx:dX97Z8jhb9VMxdEFgjv2GsBxPm-elbylXeKP7GmTJKG5Lz0TNS7ethoz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:00:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 47676500 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:00:02 +0000 (UTC)
Date: Mon, 6 Jan 2025 08:00:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] doc: git-notes.txt: migrate to new documentation format
Message-ID: <Z3t_GvqfZL9y-_9p@pks.im>
References: <pull.1846.git.1735924216993.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1846.git.1735924216993.gitgitgadget@gmail.com>

On Fri, Jan 03, 2025 at 05:10:16PM +0000, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> The git-notes manpage files were converted to the new documentation
> format:
> 
> - switching the synopsis to a synopsis block which will automatically
>   format placeholders in italics and keywords in monospace
> - use _<placeholder>_ instead of <placeholder> in the description
> - use `backticks for keywords and more complex option
> descriptions`. The new rendering engine will apply synopsis rules to
> these spans.

I think it might be a bit easier to send related changes like this and
your changes to git-restore(1) in a single patch series going forward.
It allows the reviewer to bundle related reviews together, which
requires less context switching. It also allows them to more easily
refer to similar review feedbacks sent for preceding patches.

Other than that I've got the same comments here regarding the style of
the commit message as with your git-restore(1) patch. Ah, I also noticed
that the subject should probably be amended because we don't typically
specify multiple subsystems with colons. For example:

    Documentation: migrate git-restore(1) to new style format

> diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.txt
> index 43db8e808d7..70859f5c574 100644
> --- a/Documentation/config/notes.txt
> +++ b/Documentation/config/notes.txt
> @@ -26,27 +26,27 @@ globs.
>  A warning will be issued for refs that do not exist,
>  but a glob that does not match any refs is silently ignored.
>  +
> -This setting can be disabled by the `--no-notes` option to the 'git
> -log' family of commands, or by the `--notes=<ref>` option accepted by
> +This setting can be disabled by the `--no-notes` option to the `git
> +log` family of commands, or by the `--notes=<ref>` option accepted by
>  those commands.

Should this rather use "to the linkgit:git-log[1] family of commands,
..."?

> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 84022f99d76..02a3495986a 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -33,34 +33,34 @@ ENVIRONMENT sections below.  If this ref does not exist, it will be
>  quietly created when it is first needed to store a note.
>  
>  A typical use of notes is to supplement a commit message without
> -changing the commit itself. Notes can be shown by 'git log' along with
> +changing the commit itself. Notes can be shown by `git log` along with
>  the original commit message. To distinguish these notes from the
>  message stored in the commit object, the notes are indented like the
> -message, after an unindented line saying "Notes (<refname>):" (or
> -"Notes:" for `refs/notes/commits`).
> +message, after an unindented line saying "`Notes (<refname>):`" (or
> +"`Notes:`" for `refs/notes/commits`).

Curious. I'm not familiar with the modern best practices around where to
apply what kind of quoting, so why is it "`foo`" here and not `"foo"` or
`foo:`?

Thanks!

Patrick
