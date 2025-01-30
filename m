Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45B1F03F9
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263840; cv=none; b=pswQSSRP+pJXkxjfOwOaWvwMNubMTGUxsJ0ZjzVdZ8mGnOfnP0BUXx5Xe5URBqouI3KhQ3N+b5tdcDLakLcLzu1vli0db8Aig5JsiZLSU4oWt1iqHGN6TPiX3YWdgFvEYTmVwT2ra9DweYlto2/0ksKyxTgxMu4UQXlroYhKa1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263840; c=relaxed/simple;
	bh=DqebTEhN84p/UYM3XAhZ26zFlFtagyVdchysUFUSt9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZZ0Vm14YNoqD4twMVsrY6o9f1ao/N9LmKlHC2cfofdyvZVsN9KB7koDo0/2vU4fNEfLo9qTaO784dfvsta1x+yJIj/5+ELXUYKdEoSvr6CQ39uIHPvNwrojjDgt/85Ytm7EWWibWyKFZCPKsqMfo82WHZClWoNxBGRoVq9/Rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=djMFC2O7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/SFJ/IF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="djMFC2O7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/SFJ/IF"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8235C11401B8;
	Thu, 30 Jan 2025 14:03:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jan 2025 14:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738263837; x=1738350237; bh=1Qin5SVYLA
	BHhGcBbe9cObhha/+CriWe6fWcLbtsSrA=; b=djMFC2O7Kq8x/xPg+fqj9bjPDo
	pBDxjJHFAFu8GVZu6JT4WIwPs9ofX4IEMEaxF7OBqbFpVlW+9XDwz+TAgRBmXXXv
	0KPSK9TZpXmZ8yNHQxYkmIK0scsQarLSdE6956hSYHIrm8XUYNCTb2IKijGMDT7D
	VcbP57cc/QxujxhZN74NdITmUsosrEKBxW5Fs7GcLpmUkPNvD1IztT7JRddTg/ch
	0bj5PN8c/4OCYnpmOOj2Za7o0oUEiiqNMwDy14xrM1RrEr3S5VK56zeHJpigyUeq
	PTzSzLjUtRarWxFBmW28Cch55c2fWrf6OpDEk79OR4VkVnywkV1vR+n/kpnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738263837; x=1738350237; bh=1Qin5SVYLABHhGcBbe9cObhha/+CriWe6fW
	cLbtsSrA=; b=D/SFJ/IFz9XUUAe+e35K/CnEeGZu1POol87A1wa/jcSzdDViVfV
	GqcXd3fVYNLbqlQYfsWXQrEAX5/M/3CcoGNllU7oRre0/DbsxEU/sUQhHiIva1IR
	HBcRtNIsrPpbx59lXgGgrM24dzcT5/75jyRaIGrdDFjoxB60b8YUFtxttft1MeMg
	EDTqVHfsg90Yo6CfWA8S7sI2iYjs1yaEUZlEhuWijGiGZoUhHPe5ve2e7vtd8bpK
	MCzuts8S5uLRTuq6TktUTzrccTF+2uT4p8oEdIIMVkR5meQb9lFtXg4dKIBFUNmm
	IIjqrS7A6XzCZbtd4SVhkhWB1LMOokWZRxA==
X-ME-Sender: <xms:Hc2bZ4tn9-k80fQ592D7BMR_fP7iRiLfxiR8N65VqNrCh-GWic0uQA>
    <xme:Hc2bZ1cUeCsa-JVLj8wnb3fgFpifkFQ0vZwe8x-I4j_Aoz1vWiAcR0tzjJEJFIKsW
    Yddo5Lx_yV1gnprGg>
X-ME-Received: <xmr:Hc2bZzwr-42LiHZEJIDsms5_rBkf8tFVITvCfyHXs-vkY2qaFpJLuhiQLPVCHWdpCle3FJvbl4invIyGfjlFmTnOYS8y3V6H4lvz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Hc2bZ7O8_ER03JUNB2NUnU3y-TNrDlnsBXkxoQHQwtmPEpApFkL-mQ>
    <xmx:Hc2bZ4_ubNyM7LVRvGom-sIjs-fqaLYqj6jWNHo1Z6_GrgMTDWiMDg>
    <xmx:Hc2bZzWpcCeJBTpRKqVozgLhJR5D8O6NdjtkpOLVRpx1v5qea5vJgg>
    <xmx:Hc2bZxc7d2g7nwMKpNd0WyM0GTZsqm64LQ6MK52yNnMDDWFdopBppw>
    <xmx:Hc2bZ4zFCQ1oD4ZtDcK3bXTDz54VDQbv2GfHs55Jx1UtaLL3_zSCAvZr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 14:03:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 8/8] builtin/fsck: add `git refs verify` child process
In-Reply-To: <Z5r7NnzvirWEljwV@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 30 Jan 2025 12:08:22 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r7NnzvirWEljwV@ArchLinux>
Date: Thu, 30 Jan 2025 11:03:55 -0800
Message-ID: <xmqqsep0ceec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> +static void fsck_refs(struct repository *r)
> +{
> +	struct child_process refs_verify = CHILD_PROCESS_INIT;
> +	struct progress *progress = NULL;
> +	uint64_t progress_num = 1;
> +
> +	if (show_progress)
> +		progress = start_progress(r, _("Checking ref database"),
> +					  progress_num);

I do not see why we need an extra variable progress_num here.  Just
passing a literal constant 1 should be sufficient.  The called
function has function prototype to help the compiler promite it to
the appropritate type.

Thanks.
