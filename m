Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8F19D8BC
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579552; cv=none; b=KbbWC707vhTgYNubA0m6gOM56KJaD77rDhfZ21Jaldg7IvnJUBpw0E8yu7wl3dcv1lLAv3+u0uo1eRLT3nGlQUXOvHFb3HuU3HHnN4gbERqPrwaH1rDcafVh5rD5EQzWJI8rT/CIinxq5ET9bYqG4q0H0YShg5SKnRfNCc13p/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579552; c=relaxed/simple;
	bh=gJtjvv80UQPNT4Q/rMlyY3391n8qWoY023bgOlvaMB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+seoptn/bTd5bmEbAAUWXOPiiWTNXg06OXX23LRDu46+P0Qh8J00lZ75zICcNdEeAlmNrV0uTlYWZAdIDUAy4OaXb3VsiwnnZfF3f8Igb071X8J2eRJz9MD1IVP2yr3pCjF0uzIpwKq4YSTNaOZt8Wt/l1cP5SSCRKMe1VJopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QwVgsn21; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDpatJS9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QwVgsn21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDpatJS9"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 240951D00012;
	Mon, 22 Sep 2025 18:19:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 22 Sep 2025 18:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758579548;
	 x=1758665948; bh=mki6vp2qy9O4A9D3xku/hK1sKXeff2EmGSCm7c8lLFI=; b=
	QwVgsn21hP+0DwXp8usdB2an8+35DYAsQH5iYtcsJSvW+xbVCy9xQE7bwuNZm28F
	xTjWpwq4muY13cXg/duDiDLnD7s5XAJMNVa5gczZsPsY7I1y3fWu3RBuHj2+dUHN
	oxxPgwza6RY2X1clEtHiJjvRmNNoCXNswN/JEyeb+hMZgEDXpb2qZgEbKzqXfoRZ
	65/0SNCpjihRFOYymfl8GQ9oJuRkD/1kiKCpV01CzwKQ0GkCg0ulyY+HgvpWzrb6
	UikzQ82Jl//vXwVM0QoePOI7xLwPZskwta2jjNtq4nMUY5VWaBoOE/luPYkiTJNV
	jyZwhU4dvTDZzNme7cvL/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758579548; x=
	1758665948; bh=mki6vp2qy9O4A9D3xku/hK1sKXeff2EmGSCm7c8lLFI=; b=K
	DpatJS985CcpmocwH7pwzfL60B7zKjYC1lF897GzmrP0VbVewlqs81A65g4Q06zH
	yu4/Q6qo4sxYIrcbU/8UOoDU45jiOZUMToiqf3RSyaJCStmmh3XMStlf/2Ps17re
	6pKZZRlVf/AB/A77eluURgOGS/WakRx9H0pZQ5HC7FcRKGUmIDzRYN53tDn/S1I7
	W/X1NwdOeTJiBLilshmQCrm8ukgB/sQ467c5EhdsAJl1xqm+Y8QCGac+fO897WJM
	bU7jz04YfBTaeFLfY1MEnjvcHbdSMIgAZ0RRhoPB1iC5oQIw9wjFVR2BHHe3/y78
	e4QFcX5KYURU8m9GmK8uw==
X-ME-Sender: <xms:XMvRaLrD2_Cn1ptB0hEOFjX3dUV-vKwQ08whGljpzCuv9mMOIKCTgg>
    <xme:XMvRaMoyEh4rCrrQLsGrI_LuxUx7e1rn6xTe9tPtF9_PR-IkSIYpaeiS-g7eQ8dEP
    k2DnApXBEOl-xqzcEQGr18QOsIOwgtcrXoVJMOtYR43znhh--EbapI>
X-ME-Received: <xmr:XMvRaNMpg5Mgxya8Oz8AT6E_aW8horOKX73h_xiQLE6ge1gKK2DLq47kJtIFDYbex1qEYIeR5B_xxlOLMxhPe8BgA75upjjOokq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgeeghfdufeekgeeuiefgjefhjedvjeevtdehgeeuudekgfeileefueetjeei
    ueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlrghnuggrtghoshhtrgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XMvRaNxuEAi_Qs_hHU9dS4xaRxExfAKnCb2-zhZxVYsJyv2TUNqecw>
    <xmx:XMvRaGsRqtrCj8M8iruxNHJ3tiUaBq4ZBS5JyWvFG6iYU8C2VZ___A>
    <xmx:XMvRaG7aSQ1xSFPoIid1380v8c39t7Dpqjt0AWWlHKJYqhGnq90WWw>
    <xmx:XMvRaFToA0wBKpWN73IVRmM4ELH3bP_zpuaZGg9IyG14c4ZhQ9879w>
    <xmx:XMvRaMu1Wi5pKmda5lpopLhYsK5Ish9QX2EXSfRNbwqAN6oi4DQcS-TE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 18:19:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Alan Da Costa via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alan Da Costa <alandacosta@gmail.com>
Subject: Re: [PATCH] lockfile: add case insensitive filesystem note
In-Reply-To: <pull.2053.git.git.1758578084468.gitgitgadget@gmail.com> (Alan Da
	Costa via GitGitGadget's message of "Mon, 22 Sep 2025 21:54:44 +0000")
References: <pull.2053.git.git.1758578084468.gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 15:19:07 -0700
Message-ID: <xmqq8qi6ruzo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Alan Da Costa via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alan Da Costa <alandacosta@gmail.com>
>
> * Add note of case insensitive client filesystems may error due to a lock
>   on a case variant ref to more quickly identify failure in fetch/pull

This does not have to be a single-item bulletted list.  Please lose
the leading "* " from the first line, and " " from the second line,
and finish the whole sentence with a full-stop "."

> Signed-off-by: Alan Da Costa <alandacosta@gmail.com>
> ---
>
>     When running git fetch or git pull on a case insensitive filesystem
>     (e.g., default macOS), if multiple case variants of the same remote ref
>     exist (often after a case-only rename), both variant locks map to the
>     same on-disk path. When a local update is required, Git creates a lock
>     for the first variant and then attempts to lock the second, which
>     collides with the same lock file, so an “existing lock” error is
>     reported.

And the message update may help unconfusing the user who gets this
error, which is a good idea.  Thanks for working on this.

>     The underlying issue is mixed-case refs; resolve it by
>     consolidating the remote to a single-case variant and update local refs
>     accordingly.

This does not seem to match anything the patch does, though ;-)

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2053%2Fadacosta%2Flockfile-add-case-insensitive-filesystem-note-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2053/adacosta/lockfile-add-case-insensitive-filesystem-note-v1
> Pull-Request: https://github.com/git/git/pull/2053
>
>  lockfile.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/lockfile.c b/lockfile.c
> index 1d5ed01682..99a470bd3d 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -156,7 +156,10 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
>  		    "an editor opened by 'git commit'. Please make sure all processes\n"
>  		    "are terminated then try again. If it still fails, a git process\n"
>  		    "may have crashed in this repository earlier:\n"
> -		    "remove the file manually to continue."),
> +		    "remove the file manually to continue.\n\n"
> +		    "On case insensitive client filesystems, multiple mixed-case refs will resolve\n"
> +		    "to the same lock file, possibly causing this error. If so, ensure your remote\n"
> +		    "refs have a single case variant."),
>  			    absolute_path(path), strerror(err));

The two lines in the new part of the message seem to be longer than
usual by two words or so.  Can you line wrap to balance?

The error is about our "local" filesystem, isn't it?  If you do not
have control over what the remote does, you have no recourse.  If
using the reftable backend on the local end work around the local
filesystem's case insensitivity, that would be a better suggestion
to give that such a user can actually act on.

In any case, wouldn't it make more sense to do this change
conditionally by looking at the value of the ignore_case global
(which in turn came from the core.ignorecase setting in .git/config
when the repository was created by probing the filesystem
capabilities)?  If you get this error and you are on a case
sensitive system, the additional hints will lead the user to a
wild goose chase.

Thanks.
