Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE137F758
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705073; cv=none; b=OXZs5k9dinnb5us1d1GgWAOhiFjcCQcCcy7ej/14UbBCXLJp0WcMe5slDfvx2El3WQ2wtOeWfQlxS1Q7VLioNA7x3D1jmKne90v0Q+HfLrPCs874RHSzSuaTwwUa56oQJ8w8hmVsO4bd8P4KLJPEfHtotg5trtv38C68TOeCBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705073; c=relaxed/simple;
	bh=0fjTAeEY3qLDVdupWPNCxrXNLpnxggYUmfSYqR+1g1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mUhAlx+DRZmwCAMc5MniJLtP/tG45Cioh1WLvyh2Are2nBREEL4FvdNTIjcsvy7woni2B6fPnHpvULiePN9XKwgElVWl5Quu3MsoBPjl1C6hUNigO/CAkzX6bZbY4Jcb4PyK4II6riaSqO6v+YCqXdvhPlsTqgEgzaupNJtbq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TRaxhqUg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TwGwcVxD; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TRaxhqUg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TwGwcVxD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2EE91400079;
	Mon, 20 Apr 2026 13:11:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 13:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776705070; x=1776791470; bh=+Dae2VYiFu
	GfPDRBjNp/+ouJa6clynrypuRfowcfE28=; b=TRaxhqUg92pARX2nZIZ3gCw6hz
	B2cFtikkeTFpWXeeYR5di8o0QBl/I5KXItDwk8XTKIqOOdpF217gENwDyKH3WLWY
	9xQzkWhsoT6J6OPF5orzUTbklUWac5y+bhDNcfgu5JIrZj1qzp10i/a/yfoncW7n
	g0kJaLKhaEUIvaiixOB088oYtQOs9PwwlmacnJ/wCHVuwn+C9K3n8s79J3X0x8gN
	G5DDw6ur67pU3qyxsJmFtAoPOKu0sDkDEvZNPsOCW0l260NCAR2J9/lnYl1307hu
	9+0rC3rC01mcls0+FwlvKgM2yismgmbFR8gi+IruCDYERd+U/Y3N33LkW6xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776705070; x=1776791470; bh=+Dae2VYiFuGfPDRBjNp/+ouJa6clynrypuR
	fowcfE28=; b=TwGwcVxDhEsR41y3rY/wD4/tTV2KtsaahULyNyuKps1N3WdAkXL
	rXQDXotDpoSzr9r4GQreaRH0skj0rHpUz6HeJZY01VAPmZxgC3A6LnK2qJsS3vex
	eyiMacBe4TYDWKctQsUkifvN+pP5JweYfK8pr9qIXMBNJsvh6c24JycCtHHQQZFW
	4+RBlA0arPoE/r6/MVt2EsC7JyfZEsX+aTTHmaCdBeGQJkx0U9NBi/N0sfcQpUXj
	I7SFTKHIyYTMqB8BiUw/QhoFykSzK7vGQhHLwuSNAb8e6xEqVxTSXkduwRgj+s2L
	9yFGP6zCVuWUkDWjFoSoWIrDgGcXiej779g==
X-ME-Sender: <xms:Ll7mae2WoB78fzN91kSoxy7LK66L13cR9XOrwCreeJXk9Ck2xP8aDQ>
    <xme:Ll7maX8XohVVnMEX4at4_uNq-Bui58D5FmeZocC2vG_uD2kJ72AZNKKV6qHZrtSxU
    opHjk9i_n3PFCwyGO9RvHAmE-9H6TbmkwWmQUVeBqnT0E_huCPFag>
X-ME-Received: <xmr:Ll7mafOtRkWzkOYAJhNjyiLOi8CcJZ2F56RMfdvLBHABuA3Nortev4W3IM10q8Y8rkBCNtdBtj5DTnBXjQRZS4LP7OjTfrw8nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehledtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ll7mabeMBZtAyrBBH93gF_A1y7cYfxpoNOn9XZ0zIULrgyaZFT-2uQ>
    <xmx:Ll7maeUQk51epirD1iOKStMCmB8uSasQBny-nHbmhfcbMsZhg5k34w>
    <xmx:Ll7maThJ5GVtDt3_VCxzeWf-W50b7ZIy2qD86wMR6Ge184FI8LWrEA>
    <xmx:Ll7mad_E1OHM8tRtGh4751fefxuJbA_WtMRUj81nKQb6EUybxWGp4Q>
    <xmx:Ll7maatZt7IUPwblg-atcsSFUxeq70-GvhA-wxvYJiMp3z62fvPkcOSP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 13:11:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH 00/18] setup: drop uses of `the_repository`
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
	(Patrick Steinhardt's message of "Mon, 20 Apr 2026 10:22:30 +0200")
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
Date: Mon, 20 Apr 2026 10:11:09 -0700
Message-ID: <xmqqy0ihpnf6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Message-Id: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>

There seem to be some tool errors that made this marked as v1 (hence
no References/In-Reply-To).

>   -  9/18: setup: stop using `the_repository` in `setup_work_tree()`

> diff --git a/setup.c b/setup.c
> index dca32addae..80dd94b261 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -26,7 +26,6 @@
>  #include "trace2.h"
>  #include "worktree.h"
>  
> -static int work_tree_config_is_bogus;

Once we start "setting up" more than one instance of "struct
repository", "the worktree configuration given to us is bogus" bit
cannot be a singleton global that applies across repositories.

Hopefully nobody sets core.bare and core.worktree in configuration
files other than the repository local one.  Otherwise a lot of
interesting would break ;-)

I am not quite sure the reasoning behind removing "initialized"
global without any replacement was properly explained, with "should
ultimately be idempotent".  This can give us a huge performance
regression, if the callers have been relying on setup_work_tree() to
be _cheap_ when they call it "just in case" no other potential
callsites have called it, even though all of them know that the
current code works only with the_repository (in other words, they
call because the switched into the_repository---they do not know for
sure if other call sites have called it).

Or does the current code never call setup_work_tree() twice, because
everybody knows that we never work with anything other than
the_repository?

Other than that, the [09/18] step looks sensible to me.

Thanks.

