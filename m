Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9825F97C
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043153; cv=none; b=XrcRxGyxn/NTs7XwT3BtNSySf+7pXalP1tEIeYCQiyUdB/WjdvCubQ2fb0y7ifJEY3BSW5LQ8LmKRe8lGVSHE2BQnFclK6p9YT8HZ5w6KA6Q2I0Ca4aSjg0MWKaJs9RUCzuSB8k2oN+JRT7MiXG4Jpr2eU8pZgMkKItH+jBkCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043153; c=relaxed/simple;
	bh=u4NowZdUFITzcbKofaVZ/6GW7XswRDWX+dM6r/j4U/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPjBHXuzZqkOZYjyVebjh7jaMcu132SRC2qONDCMeHZKPUHAepuoQw7w379RvNbAfbdmDuTlvqi8jtnvmaCwNMbj5x+4Olru8/U5iw3MDv+trN54zN4tnouCG+8U94OY7+bdSqmMcfjzE9nRJb24XHAowbCqZsdekyH0LcSmU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZuN3/fCo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XNmbr1i/; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZuN3/fCo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XNmbr1i/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 609B9EC084F;
	Tue, 16 Sep 2025 13:19:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 16 Sep 2025 13:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758043150;
	 x=1758129550; bh=WEN5MmRF/yUZz2nMopDco9M2xexjSUhfaSlV9a/tLHs=; b=
	ZuN3/fCocxi35Zq8K8k6DOOj7wss64mzuYkcekQWuoJmJ+N68fz4JzRrXIG2ZZ+V
	Qgu67euX+sWIbsqgR0sx3lOWfXMKAe9mymAuFMCsEukb0uJyDa49u6yuAoMTojrX
	3KJNtWRfXajf1jBMenzO29PDNldLk9ERdOJHRQaRf6aw1JG1PfphwDTRow6VGdlv
	25xrpTG00psozOvJfe9VfawJPAFWDvqS2UDlfpF0KC6Ll0p7nIJTjdlv1MK2eGiT
	s58KmyTZfS0C7s2fQhxZgTzybgN/Jlc+QT3QszgwV1jDzeIa+HR4LNs/xnp7zfGI
	R4juCF4TYmc41mpJjb6Eig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758043150; x=
	1758129550; bh=WEN5MmRF/yUZz2nMopDco9M2xexjSUhfaSlV9a/tLHs=; b=X
	Nmbr1i/NZvweiQolZ6puSZO2FLvx0d8I6CjmveQtvrvQBWc4sCtf9bY7yPocT9W7
	ANsgM3TxHWfVg1dcqI0NrJN/P13Ntvd0b6JDZ6ztyaY1Me1cy+acF92X/lijnfm6
	05wwe6vjXB9z/JARTG15Q03bROTGsoY9w7ccqHWJ8B78CBWMSBV++VtQ2tDfETqS
	ofRixwaXdycPgNse/+yJikdfBKAND1l0a8ib0KtpbBF/PfJQxAFSGnAOJ2rf5WII
	ekv5Fb124ONWArc2YrKxzsWlD0BoyniKlQ/t/afXvu4JPFi1OjN38BNZ3v64YeqA
	AXmdPYUUE6HyfPeQ+Vvug==
X-ME-Sender: <xms:DpzJaMUdPLpIhoeTPmwRVWe5PRrd2KqVq41KqELKTj2AEt6m0uMclQ>
    <xme:DpzJaME9BjmzuskYHv7i5SGl5CIwgI8ap5edKXS3KkoMq1C08iWUx3mJLkBNlIfuy
    AMQC3eQfaotx1MjMw>
X-ME-Received: <xmr:DpzJaG3bsLS0tdBA29Ai_f_liZyNo-76loyQ1y0befPzOw2Qed-8LlmxkwMKxFNHfK_xsgkvE3s1ChmfKICDT1bHGigv9oyIbOC2Wlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephfetvdejheduheegleehfeeivedtgeelfedvffdtvedtudffieekieeijedv
    lefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhushhtrghvohdrvhgvlhgrshgtoh
    hhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhushhtrghvohdrvhgvlhgrshgtohdq
    hhgvrhhnrghnuggviiesnhgvthgrphhprdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:DpzJaGMYA9iAyK3ieRPwY-6UmLNVluR_TIv5Uz2hS7PJXptPpTAsYQ>
    <xmx:DpzJaN6tehopDUSpgRLswQydxiruokTDNbT0jRvkE4YlKaxmi_Fg0Q>
    <xmx:DpzJaI3DUqHI4LwE04WnSQDJMhKxCCUWlDvQdZ8owoHoStKwQuXuQg>
    <xmx:DpzJaGwyW49rL5U2TGp8iqipoKpGedHaIG_Pds37gzn5EWRchyBxSQ>
    <xmx:DpzJaFr_fq1edWqC2dpSPSMapZ0hD_HcW9d8-R7-DMMx2b4ETSymRv2J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 13:19:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Gustavo_Velasco-Hern=C3=A1ndez_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Gustavo =?utf-8?Q?Velasco-Hern=C3=A1ndez?=
 <gustavo.velascoh@gmail.com>,  "Velasco-Hernandez, Gustavo"
 <Gustavo.Velasco-Hernandez@netapp.com>
Subject: Re: [PATCH v2] docs: update description for '--mirror' option for
 'git push'
In-Reply-To: <pull.2028.v2.git.git.1758038628948.gitgitgadget@gmail.com>
	("Gustavo =?utf-8?Q?Velasco-Hern=C3=A1ndez?= via GitGitGadget"'s message of
 "Tue, 16
	Sep 2025 16:03:48 +0000")
References: <pull.2028.git.git.1754922884439.gitgitgadget@gmail.com>
	<pull.2028.v2.git.git.1758038628948.gitgitgadget@gmail.com>
Date: Tue, 16 Sep 2025 10:19:08 -0700
Message-ID: <xmqqzfaumi2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Gustavo Velasco-Hernández via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> From: "Velasco-Hernandez, Gustavo" <Gustavo.Velasco-Hernandez@netapp.com>
> Signed-off-by: Gustavo Velasco-Hernandez <gustavo.velascoh@gmail.com>

For this project to use a patch, these two must match.

Please decide, under which name do you want to be known as to this
community.  Once you decide, please use that chosen name to
configure user.name and user.email for the repository you use to
work on Git, amend the commit and update the sign-off using the same
identity, and the force push to GitGitGadget to /submit (I am not
sure about the last two steps as I am not a GGG user)?

> The current description considers only created, updated or deleted refs
> locally. However it does not address the case where new refs were created
> on the remote end, in which case, are also deleted. The description has
> been reworded to describe what is removed, updated or added. (Based on
> Junio feedback)

Drop "(Based on Junio feedback)" that is not even grammatical ;-)
If you want to credit others, it is common to say

    Helped-by: ...

just before your own sign-off.  See an example like

https://lore.kernel.org/git/2f78ab2e28c64f05d807cb9460fa62eb1011a57f.1757879060.git.code@khaugsbakk.name/

(by the way, oh, gee, that's an unwieldy long message ID).

>  Documentation/git-push.adoc | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index 5f5408e2c0..77ce4a27c8 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -163,12 +163,11 @@ already exists on the remote side.
>  	Instead of naming each ref to push, specifies that all
>  	refs under `refs/` (which includes but is not
>  	limited to `refs/heads/`, `refs/remotes/`, and `refs/tags/`)
> -	be mirrored to the remote repository.  Newly created local
> -	refs will be pushed to the remote end, locally updated refs
> -	will be force updated on the remote end, and deleted refs
> -	will be removed from the remote end.  This is the default
> -	if the configuration option `remote.<remote>.mirror` is
> -	set.
> +	be mirrored to the remote repository. This overwrites the
> +	refs at the remote by (1) removing what is only at the remote,
> +	(2) force-updating what both ends of the connection have, and
> +	(3) adding what only exists locally. This is the default if
> +	the configuration option `remote.<remote>.mirror` is set.

Reads very clearly.  Thanks.
