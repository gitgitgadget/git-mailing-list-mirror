Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892932D45C
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678300; cv=none; b=uNK6Ict9QdecYWUqiGOxjjT82t3gqFVG/JDg3jVeBUPFC7zETymhWFnf/gVK5CtEzAFpj70xuZza7dEG3s0caQtKPy5qgqxxAaHMJxzbmn08u2ZNPQFEp9zNM4BEWPnsFAeNNeLMqL22PnZ8Ow50a6yE719e9SW9uIiiVEPZbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678300; c=relaxed/simple;
	bh=xl/igwf5FbBSDJkoOjpRXnFoIjsFGdGxvtiVFZYFKp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=reOqor4QSFI9rS97j0POoL28EwXeAZ/AiNRGj+pbebeCWo3xS/UcBIaWOYhirmOxwLK706EU22SJw7r4Z37CqjpeOFax99opkUd11A7IPD7EgKtyrs9HiEFohUltCHsvGj4DmbLOz4+hnLNKt/cVX22v7aA3NYX1CRABGCizZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QtRYqSDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cr6IRzdU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtRYqSDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cr6IRzdU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E809EC0554;
	Mon, 16 Mar 2026 12:24:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 16 Mar 2026 12:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773678298; x=1773764698; bh=+xbGACB57x
	elYuU9TBHAJmNSBBm8oujeHV7g3F7M1EQ=; b=QtRYqSDMEx6T3yLCfnL6Y5mRLW
	F1yi1wuEvovMtmntk21+Q9DmzTs3lMzd1dygvqLYKI3grFtN0Frupn/T4a0H8BAf
	zmGQsdb6HwMFoJl4dYge0642TkfT+sUcAFPz7llWMFRKMU7MmykM+7WdStDrBRyf
	2qHqw+zl8i5DuR9VQizEfiwqwziG9TOPE0EdOZ6FY8gQuILWuAgAa11ANkh60tXZ
	24GQV2czo0/bKha88rx3maSHHQ90IWYsxZ7uOSrh5v+/PTPhs48UzGmI53KDsBFK
	TzHMXg0F6oAyAlvuD6BGfrZlLtj4hW0onpwK6zaObAreoJrKPz1ZWg1297hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773678298; x=1773764698; bh=+xbGACB57xelYuU9TBHAJmNSBBm8oujeHV7
	g3F7M1EQ=; b=cr6IRzdU2soamqYA/IdeWi4TMFSjHuAWVLbJZtdPLDPhrFz3/Vn
	QAHkuA+Wk5RYBdC8Cil6IDD+iDrRULFmo6Tk5ssXrh7EUsppT2c7C0iJ5Em3ULhg
	dbuuiN5+pRNUaRcCH7c1yQtneLTRisjDfbsiOTU6IDN21xEtQc2VTXkLuyAsTuUf
	NDyRj1hZQbklxSO6xp+o8pd4Og70hzOHjr9WqNEFb/oDtxiesCU0Fm7Kzdqnr74a
	cunRkn1Kjf66yhOijkX7b2bfBbE8lYIKSeXgS0J3rUkQdkCbM3f6tOj90XIW0ZBU
	iO8MrEmoItlOMoTgJpxIfgDHrN97AswgNwg==
X-ME-Sender: <xms:2i64afUNwGwWjAgbUErbyfmRKpA7HyOdE4u9KNxZW2QOUDGtzMQiOw>
    <xme:2i64aZ0T-ix5q5GsD6u8UoUuC_X0GmELPecziIg5AP7w2EFiMho9tV7Y68NPXA-TG
    6XtTAAzQuGfwscDTe5SMhx3thDlUJ1TXXkOfOsEwMfobXA-jVTB>
X-ME-Received: <xmr:2i64adpDGfp9pI8Ozs02gil-2lSTDshmjy1Am4MLxqmCFXS2EVPkE6azCzd4yYaV9nFgZfczBilYZhcLZVYbEXSLgEE65Zve7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghrihgtrdhpvghijhhirghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvghrihgtjhhujeduudesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2i64aQUuX1d8NJHfJSZmIZD-6EqV1Vloqn9JXJG90gKN24ckuUCOng>
    <xmx:2i64aYbqL8HImM1LNpvpfO4lc4b1rlJz9yvvNYO08UQAdJ_H77Q9XA>
    <xmx:2i64adee8Ac9hGlI0m8JmNn-I2kGhSlHBR01CidOtyRGyqSTBuXv1w>
    <xmx:2i64aS0nN-RAA7gMTL9ktxHSsjCU-p4EHIgfnMMAopU0Ov8CfzwQhw>
    <xmx:2i64adqlbghw8M7zgY94aC0cVuMEvAJcgcEQ-ngr1GSRPb6xDHhB3pBY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 12:24:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  ericju711@gmail.com,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/1] refs: add 'preparing' phase to the
 reference-transaction hook
In-Reply-To: <20260316045102.70551-2-eric.peijian@gmail.com> (Eric Ju's
	message of "Mon, 16 Mar 2026 00:51:02 -0400")
References: <20260313193537.62827-1-eric.peijian@gmail.com>
	<20260316045102.70551-1-eric.peijian@gmail.com>
	<20260316045102.70551-2-eric.peijian@gmail.com>
Date: Mon, 16 Mar 2026 09:24:56 -0700
Message-ID: <xmqqv7evpwrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Ju <eric.peijian@gmail.com> writes:

> +	/* Preparing checks before locking references */
> +	ret = run_transaction_hook(transaction, "preparing");
> +	if (ret) {
> +		ref_transaction_abort(transaction, err);
> +		die(_("ref updates aborted by the reference-transaction hook at its %s state"), "preparing");
> +	}

On end-user's terminal, the above should look like

fatal: ref updates aborted by the reference-transaction hook at its parparing state

consuming more than 80 columns and having the varying part of the
message at the very end.  Can we shorten this and highlight the more
important bits?  Here is my attempt

		die(_("in '%s' phase, update aborted by the reference-transaction hook"),
			"preparing");

Enclosing the phase name in 'quotes' and moving it near the
beginning are both my attempt to make it stand out more.

Another thing you may want to consider is to extract the message to
a separate constant, i.e.,

	const char *abort_by_ref_transaction_hook[] =
	N_("in '%s' phase, update aborted by the reference-transaction hook");

and reuse at two places, perhaps?

		die(_(abort_by_ref_transaction_hook), "preparing");

