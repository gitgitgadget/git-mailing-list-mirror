Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352AD274FD9
	for <git@vger.kernel.org>; Wed, 14 May 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229940; cv=none; b=P226A502V/2s6icM0jjMNoW1Ex+iK/CqI+zYjFTaBUSJl4ztLgGYsydqvi2QscQCiw5w45I2WsQd3ubm6JLWcwIgnfTCOYTP/exB5yM7berLD8zNERxqGDV68kk/9GY2AchsxtKKGNy6qLhURv3C5WVEepQi7gRgLdLL5TDwP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229940; c=relaxed/simple;
	bh=wRt+0A9Uh531hkt3K5X3Zdh6/j+BmAwDJGoA3WVTgL4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rluqMZnKpFM817OT92Hu9Nq8WPQAYXHlMlbYYBWgzElpcaVpiA0di4Emy8kA8LEBaMlRXJDjZmlx7mfVSJPhODFS8KokP1IzPSeq7WjYyFWr3uuYcEl+pf92hcfH1QUOoW1uvX7CKoyZ3NmwZJbBQNXN4yU9exghkxaBRQCi0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TqgnhHSW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UJMPo0D+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TqgnhHSW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UJMPo0D+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 47DF913800D3;
	Wed, 14 May 2025 09:38:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 09:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747229938; x=1747316338; bh=JoQQojGuAx
	poBSk6vE3ccACs9ztjx0MkfGcydYbprZI=; b=TqgnhHSWFuu6FMZ+ZP7SOgSJuA
	buiIkNjzPcxkvYPh0ZkYoYbn+d7a04/VAfw/XdhMYqDqgbE/6pqqfnD8ILAiW3QV
	zpViBdeZNWAqHXy/8oF2p93hO6krWwSYgPD1oLxBFiRYnWHIHYHj/6/v0t5gcRZu
	6lbHZrK8x6tD8xx6E5H4S1BVs/Zih3Mp1/ZBnaxzJszEpuBxQkXdvC+ob/3hTsyT
	9DJxC/QU5d7nD4KN0gaH4U2LMmWRa45hj0UyimuEiPuFRyxfbr9pylqg7q/PGc8x
	xgb8xlWhqNFDgVxwjIXn6DWzibr6WSTACX1/aSEX7ppMmbwcJECExnlm8R1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747229938; x=1747316338; bh=JoQQojGuAxpoBSk6vE3ccACs9ztjx0MkfGc
	ydYbprZI=; b=UJMPo0D+v2m7N9X2GtTCn2vbXC+ChQOSct+iYkEOkoVYPnKr8wg
	K1plqjLRb0v81KdcSpdc0YiMeIzInDMv7i7xiRDMYyqh+pLQNa0j0pzO8ZKwxSQl
	KOaV72BHO2j8NE04V2qNMn/b7LIZ1MUPHI/KsVyXdqmm37VUUmuhlG8b82EJjoEu
	vHKwYCu22H7tWuk0m6qvywxi9lvnTaqhMDCeA0w0MXJhwkIFEH8VcDnTJO9EKzbW
	9xQX/dIm3KB4c259iPW3VfGcZmz5pD5CbQFk9yvp3eZZsMe9Th/rh7vWIuWDtMTx
	1RaBQXnNXki2BCkA35YrzWsK/TBUrtqHmQA==
X-ME-Sender: <xms:8pwkaKVvyF47cDarVs2sMlnmHrxUbAym5koR0N47UvrcL-CXlTTh4w>
    <xme:8pwkaGnjt7mUoeT8bt4KjTn0BQORsDUNRPPq6g5oRZmk86CkKicgMepGA3ubvvMcl
    Hup9ehAtIQd6NwJQA>
X-ME-Received: <xmr:8pwkaOaByPMB6Z7k0-s1sSBprHcsPrPuSHqDc_8oEAZKpLTZo6AXf-fsJyRc6zH2XNlaDr0_2aOjFoEXcaqv0S9C40Q4-s3aAWCQvAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepke
    fhueduteekgfdtueegvdfgueeiuedvlefggfefkedvffduvddvkeeuhfeifeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8pwkaBVf_2lw41LsEpADuW1EEgWOOV7BjOYOuLu7eR4YeytCoqe5vw>
    <xmx:8pwkaEkeyKqV9nAyeoo8vSZnXwB2YD833rK3AC3Qg7CvxtqF1QTo0w>
    <xmx:8pwkaGcXnTwuobbaN_FGPXzL-cyEZDoBSzfEi_4YbaaMYwI2_a-oYQ>
    <xmx:8pwkaGESe0njF2iBbYe9X0KqfsYgAu3xMB0wTwxkPGwCiWEeO7fquQ>
    <xmx:8pwkaGVAb4XUbl-TCl6b46i-2ek6FfE0eNDUcs1cmpKh-W5OGHm51k78>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 09:38:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v4 4/6] whatchanged: require --i-still-use-this
In-Reply-To: <20250512190311.1451556-5-gitster@pobox.com> (Junio C. Hamano's
	message of "Mon, 12 May 2025 12:03:09 -0700")
References: <20250503005814.3030099-1-gitster@pobox.com>
	<20250512190311.1451556-1-gitster@pobox.com>
	<20250512190311.1451556-5-gitster@pobox.com>
Date: Wed, 14 May 2025 06:38:56 -0700
Message-ID: <xmqq1psrcnwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The documentation of "git whatchanged" is pretty explicit that this
> has retained for historical reasons to help those whose fingers

In 731a2c7d (whatchanged: require --i-still-use-this, 2025-05-12),
the above has been rephrased to

    The documentation of "git whatchanged" is pretty explicit that the
    command was retained for historical reasons to help those whose fingers

I won't repost the whole series, though.

Thanks.

