Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0886717E
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750377742; cv=none; b=YFM1yCER8CS89VbWFhUyh5tv62NNvUrp9AJoJVs5N2X5eKn8ublVH73xjMw+2JVIl6pLyrXL3rUWOqSDSN/yY2H/hnzDtn7n6WeYftUf4NDqyyC07jU5Lt2jNRZEW0Mf3tVaKIrFEr9vssj1ijq12KmXi2GEeJjXFNGULN/D3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750377742; c=relaxed/simple;
	bh=6A0TlZi2ULTjjBXEhyxEGXgViNaS/PlojdVr0/vGHvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZfCMZx2f1G8wjHOx5ki/fTV++zWRxD1AVWrwqemIL2zjLIHWNFb/1yeeb8Iq0FGY+xLfTW0zP0idv8LKWE3B/rUKl2MYaOUpw3bmTAeyg4ly0Fy67hglBePSkifrgIchiH2Tv8Gu3C50eQdv7EDpDzZnzWca/AGRyGHJthRzLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C05kGuwc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKGpuTPF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C05kGuwc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKGpuTPF"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B6ED2114010E;
	Thu, 19 Jun 2025 20:02:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 19 Jun 2025 20:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750377738; x=1750464138; bh=625jzGecg+
	K7PxHEqK2kVwPJP2PIPLpEa1CeJkcwTfU=; b=C05kGuwc2uthCpgpfmoUX9t+uo
	GOu7kJJHIyhJNOr3ziyZhVif87zNMoyKnCubvWOD8mZvOBRL7d2zl5cOmUWOx5Wa
	oIrqj8WwgrVm5zJJss+6eYH1z0c+M5ylxgNKHwcKr18h8VnA84N9hf7iQTU77io2
	+iLP6ZmUiPXI3AJQqULAUFq9zHphgOpl8GNFs76LI2AOt8vgsWq4Z8VWVTzXdA72
	pF65YUqKlGRlbsSW/UH60+Vtb/pofLP4OJdZ3UN9ZdkqgXdj9fngf6sIfcyoRiTK
	tMREW7m/qYg7sy5j59UwSJsrttohLrACBht1WXWQnfZoHDphdJL0Wf3rnMMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750377738; x=1750464138; bh=625jzGecg+K7PxHEqK2kVwPJP2PIPLpEa1C
	eJkcwTfU=; b=UKGpuTPFBnTh5ILFC1LETQEv7D8JG+vPHzXojeIQv5PvVXOfkcg
	1feKag9WK/VQjkOjnkyHKbkbnYiSSuku6qOwAwVrSPgxCRsAuluW5MiNHmbJJnsg
	80+ZAR4T5cvQY0KAeHanOEggdJXLlmg3bxF/fu3YJcGc4LtbYd6y/TMtQ8oSoB+T
	oj3Ct4H4jVwhy/rpYlebvGEFN6AmjxW+ng7P99rC7DMESHxo6zgsm/TZQU6z8m30
	L41vj7wNrUWThlMRrK8vgNVWiRrgFnjsx+MTLwkfQGe54qJUtS7gnSmnJ4osY4Md
	rrtkprxI9i/K1y2xphpqJ5rOCUpycxUzBMA==
X-ME-Sender: <xms:CqVUaJQTzghpHN_XI1CHsV-V4LVpBx3HQJVd8zQmwwb37LoxkJ-yQw>
    <xme:CqVUaCxqu5EOsu0hZggGBEG3tCeIMJlhBVFaKZxcGwMfBFidtn5aGIpzO9MuUh0P3
    KMoro62OWSaiUoxXQ>
X-ME-Received: <xmr:CqVUaO0UIG5eMKaUHzkKL1GGPPsgsbhW9SSoVhELhNNGfMpOd80kNBP604keDo1FGBN_-KfNBvuIFUYbdj9a1WDgW7CFuBBak1LK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeileduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CqVUaBBD1csXvQ0s4_Fzkibm5qLwjlEWWWw2RStBPxwnxk2T4QNnDg>
    <xmx:CqVUaCiyEVNYXn9zcqesGCmupAPp4Sz-P9s1OgAZDrTSLa2Sa-gY7g>
    <xmx:CqVUaFpnX7IbznfIlgOWySCTIyCHC7ZkWswh663rJmV-DOAnBjCgXg>
    <xmx:CqVUaNhuD29PN7v0YPOCbJHFtOM3fNBi7MltZ9XOgqaJyLLczOICeQ>
    <xmx:CqVUaLGD-wfQoQr5PLySCjitxHx3TzsqFMMeReouul7RMRAytQxO6xa8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 20:02:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v6 6/6] ci/style-check: add `RemoveBracesLLVM` in CI job
In-Reply-To: <CAOLa=ZSiGxBHiMZbUoRN0nB24YdAWypgyMYMEe-EW9EHtbx7Kw@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 19 Jun 2025 15:25:19 -0500")
References: <20240718081605.452366-1-karthik.188@gmail.com>
	<20240723082111.874382-1-karthik.188@gmail.com>
	<20240723082111.874382-7-karthik.188@gmail.com>
	<xmqq5xgrdan8.fsf@gitster.g>
	<CAOLa=ZSiGxBHiMZbUoRN0nB24YdAWypgyMYMEe-EW9EHtbx7Kw@mail.gmail.com>
Date: Thu, 19 Jun 2025 17:02:16 -0700
Message-ID: <xmqqy0tn8elz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>    	failure:
>   -		for (cmd = commands; cmd; cmd = cmd->next) {
>   +		for (cmd = commands; cmd; cmd = cmd->next)
>    			if (reported_error)
>    				cmd->error_string = reported_error;
>    			else if (strmap_contains(&failed_refs, cmd->ref_name))
>    				cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
>   -		}
>
>    	cleanup:
>    		ref_transaction_free(transaction);
>
> We generally add brackets in such scenarios, but the style-check
> suggests to use them instead.

The above falls into "once the code is written" category I mentioned
in the other thread.  I do not mind the original, and I do not think
the suggested change makes it significantly worse, but there is no
significant improvement, either.  If the original is in the public
tree, it is not worth the patch churn to update it to match the
suggestion, but if the original is something you are yet to send it
out to the public consumption, it would be a good idea to take the
suggestion before sending it out.

