Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044A1E0DB3
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201788; cv=none; b=nDDk6OZvruARxVDKgFAUIXhWIThLTveqcrfgTvbLyOOojpIjh4CNeOh+ahiUdLismqHX9fXF2eZWQ1imvwf+FPYXXf5/Wbvup+s61ZoUZRZrnCUvxgj/SpLOeiXymFt1ZTMeQ5dG9K5LyY49JTycVYzrkJ0Gt9C3fWmx3ABNrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201788; c=relaxed/simple;
	bh=gTn7XWmih8IHhdSj8h5MfaqFYE04T/ORGg/+eujFEa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhHhWqh9SxCxCM+DFcMNJqhDQBaeN5a6VYCiSFY738ZP+drWFFTKGlkXFNmy5p8BNhS3IJdc9azBnNcdDTXuqAwX37Vp7s8xmEPv/RQad9QqGtUtl4081FG3flxcxF/EZtV731UtmzGjgRaq71hLYQH40gV09Jl/kDUZhQ0JwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IiFjyxFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4c8Mz8H; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IiFjyxFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4c8Mz8H"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A397E138016A;
	Mon,  6 Jan 2025 17:16:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 06 Jan 2025 17:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736201784; x=1736288184; bh=PpaP4XLGJ7
	KoAr3KgioYTbU+hr840M+hHVdop+FGa/s=; b=IiFjyxFRNUJCq8tbGNJygxb/4d
	VDnUoOB+URBEG7HoWkXxJQMLb72YgpJQS1+QxvaN0i8I/QWtUVADR7D5WbkeEzr3
	NSFNrOQjTc617eqdTX8+9WtklprboxgRZ1k/yiV9etZ5fyCmbxpN2r0MVAuD+2tu
	ZUPoSJbHh8g5dZfuT95Hg79dWa1HJlWPWkPQqNwjJuzHbcwgruIUOpyx7z7lULEC
	Toem23y9VYPUsGe6wWw/i6m2PNW/T5FjObijVG+IntcPPEX/+Fl63+DYouPhasDx
	ddloSFMz8UhL+unNe/BazF0xpNBRoPShKCzKqLWFBiidtoooSksKgki6JFyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736201784; x=1736288184; bh=PpaP4XLGJ7KoAr3KgioYTbU+hr840M+hHVd
	op+FGa/s=; b=Y4c8Mz8HTmTKHNJixESk8vgfK3g/QtuFgbeh7Fu4f9j5PGrCcgI
	TkPj0a4L87b6bn8ixNzBNbkviC2JjdESULkjFYBst6Ge0XGA+7MxoJcoO3iQxZgU
	ij9X316s5dAiQtiO5PyYzs8O4ZsR9Og3UTphJLmxgR0YqRahvWBxcAniUa5rJzIs
	lUMaKbUvF0L6kJMjXD3Q144YDx7emDzHC87O4lNII8ZE+VquU6I1lTzR6myFDsJd
	N8fK84a5gyW9ng/kDSe0TcPtx7oxqrLZzzeaoSntshlh65J12FXjKK5XJqq8apCC
	aLAZdDNl/OcMrANQgsXJqwq0AAL5bbgtDHw==
X-ME-Sender: <xms:OFZ8Z9xJPq12ppOpI8NjdzO9i2L0RHJnhCSCPna2voUNp2wDXHoTCA>
    <xme:OFZ8Z9Q2p-BpGAopZhN-7_ccAT6Smu05PFXX3WNO5dBjfyoHnzJBRdikugn2PVomf
    YKh8rB0HdGRP20IFQ>
X-ME-Received: <xmr:OFZ8Z3UoRT3NSGJ9vNuV6zeRJEtHjCKK_DbX98Cuq8Htw9pLWqlkjnOc80qelxm_WT1KAgTNGfTIQrOyMPE7embH0jGED1Sd4LmV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdr
    mhhithdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OFZ8Z_jDij9jwEqrBRa9XwunL7ERjOGLerAMFZzrgT57SGfDRo0GZw>
    <xmx:OFZ8Z_AECq_y2SXLSLsP1XFQUBttxrFxOyFyjo9uAluw33JC-lhvBQ>
    <xmx:OFZ8Z4JW2rUE5oVDNg3tvbzzcTHbOf4I7ohBzogIOM8KP2tqz5eQAg>
    <xmx:OFZ8Z-AyJYZrtLRzpU_XqKptWJzztdoh1uNYk3RWiiSojx7euLkkow>
    <xmx:OFZ8Zx3egRwgEq8aJ-6fiSbrwWGmIcQ68nakTs6N0O49tLq4kGheOq1x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 17:16:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/10] builtin/fsck: add `git refs verify` child process
In-Reply-To: <Z3qOM5M1ioZ0Px4T@ArchLinux> (shejialuo@gmail.com's message of
	"Sun, 5 Jan 2025 21:50:43 +0800")
References: <Z3qNUizvHJLgMx1y@ArchLinux> <Z3qOM5M1ioZ0Px4T@ArchLinux>
Date: Mon, 06 Jan 2025 14:16:22 -0800
Message-ID: <xmqqv7urwpu1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

>  builtin/fsck.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 0196c54eb6..a10e52b601 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -902,6 +902,32 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
>  	return res;
>  }
>  
> +static void fsck_refs(void)
> +{
> +	struct child_process refs_verify = CHILD_PROCESS_INIT;
> +	struct progress *progress = NULL;
> +
> +	if (show_progress)
> +		progress = start_progress(_("Checking ref database"), 1);

This had an obvious semantic conflicts with a topic in flight.

I've resolved it in the latest integration after pushing out the
2.48-rc2 this morning, so there is no need to resend, but please
remember that it would be a possibility to rebase on top of an
updated 'master' *IF* the other topic graduates to 'master' a lot
earlier than this topic hits 'next' (IOW, until that happens there
is no need to rebase).

Thanks.
