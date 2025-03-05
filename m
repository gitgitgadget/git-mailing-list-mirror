Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795D1E7C20
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219019; cv=none; b=m9ch4kalYJUTtg8F91+iv+TGwXi7O8YjgZluxvmCHHVzk8yBl2Aq1CvBqov5qNzJLalVoL+izknN/vhTxnumpk5xfXGtYO2ocRbSdsC9Lf/BtpSt03/rs22yG+jo8Y+hYw5MYRkpjFU6RedxbTuD7FVuTy4GedyIeU5aCQBWyyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219019; c=relaxed/simple;
	bh=8WwiJjElJqAXYjc5yU/HvX66sZNnGvfp62QMwh4Sc5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugN/eYJRY3V3J6mwCGoPxOLJNa/0QkuT2BrxyiaTV82caGAkMeYdUMUNUoVf/+YBNRn/M4qAEzZVLE489DZWZc6P8u73VCK9a7sM3+6zrEpFD+xVaGYh1/oFy5dOA9CDFtN8QNO0CqPXdbsR6TW2kuuZ7oc/0ndNwO/lncWnZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=On+oT9xw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARcB9mFi; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="On+oT9xw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARcB9mFi"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D064F138272A;
	Wed,  5 Mar 2025 18:56:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 05 Mar 2025 18:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741219015; x=1741305415; bh=8WwiJjElJq
	AXYjc5yU/HvX66sZNnGvfp62QMwh4Sc5c=; b=On+oT9xw23sx+8aURDnLQ9OjnG
	jy4f7+zRmPU2bINBMagH9BOu2/Fm1/CIA45hX1VpizM82py9+8oqPXGn8zVLlNTy
	RTdoiSSpE25LVEFfYEpeWcrZIjD+5uMdawk20q5iSJvXPDPOuQb40bMAcJHeZy6M
	861acTJ2stZsCs41hb5vm+Dk5PZf7nTW3vzbe2FmQVDPKTi6zGFSdM5EnWbX1bjq
	rvngd7ZqDfPcZNl6Pq0YuWx7gBkTQwoFcYbSk+As9Bac6EU9vaBYBYQuc28BIPpZ
	0ftcQhwZpdswLzNLZoxEwYLnrM6QwLGVJbaL5b71xQf95vUUkwlzcLBYqRWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741219015; x=1741305415; bh=8WwiJjElJqAXYjc5yU/HvX66sZNnGvfp62Q
	Mwh4Sc5c=; b=ARcB9mFiW/ek5vd6Dw3DKPKC7OpvX8Ep2bOBHrMh87aeNEwecex
	ICds+Sn32300Tb0DPQGTl6uDnN0+JtOEe/C9eL9uKFRAe86yTC7HE+oibEScO3Sn
	xZ4GN+x+T3ZQVlYb6M0oXKkwsoOOUZ0O8UzM1wQdVDHDIeBbBdnZdyzpo0Si6gL+
	kZrimgjg9sh6GG0GrduVyt+zLpRA+/x6Z0E0wYL0wq8ZXmvpinGgreo1nktDCjbj
	vkVmE9rwyltUIqumX/UZqwZue9bxheKk0vjsjPxBR3WSxT2x3p5d0/EazSx0p8YY
	BTR5FqY62spLlCx3BSCz9PfCpAGwm4hk3Jg==
X-ME-Sender: <xms:xuTIZ_-X0iyNoJ1AKqkbbu1HwVU4_xLiCRvioH6_4AZ9Th_SebJV_g>
    <xme:xuTIZ7vtQ9P2y9tObpJX26jvMoYJlyjFvBwNUJW1I1iSLg5PNk8YfYomrETnE9Isv
    SlQ4w6Clp-M6M_jQw>
X-ME-Received: <xmr:xuTIZ9CSRkWXQFg7AQj8F66MP1Z9MDyF50ro2NVEoQtHHnAjCz0cb3ayoCmL-Hvjabag_ZtTYlCle7ZvCqjFx1UtN39ebbWJGlud>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhlvghgthgrrh
    grnhgvnhhkohesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehtvggthhhkvghnhigrse
    hprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xuTIZ7fOluOC4SmGqdYvQ0K3ESVevTE5Tq30fW09jBSdJuZNcmm1tA>
    <xmx:xuTIZ0My5uPvvf83hppezQojRKqyxgUWP98cvbftiCBcQQO0lFHbVA>
    <xmx:xuTIZ9k01srJ29cG3i2tTNPIpSfG16ILn2gb1_wO0S8d8WlevsAbRw>
    <xmx:xuTIZ-sHWSmOftGmT_tDPRv5KU7qj8OhGajI9rqnJNHWdGcN7mDDDQ>
    <xmx:x-TIZz2ycVFKzaAon1p4CwrW5rTumKz42NKQChxbNvDf_3OkOceYQsWj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 18:56:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Oleg Taranenko <olegtaranenko@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Tech Kenya
 <techkenya@protonmail.com>,  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suggestion: Enhance git init with Language-Specific Templates
In-Reply-To: <CABEd3j-36C_LUOetg0qLofrby9M1Hixkh4o7sQkkyyWuTqHQvQ@mail.gmail.com>
	(Oleg Taranenko's message of "Thu, 6 Mar 2025 00:53:30 +0100")
References: <qMn1k_iuZCe353x0BBxdD5z4-17Abk_ZHoPr8nVDLOgLhGf8Nxb3-bsXPH2GiATUsuGLVqAaEESua5G9qBaW0qqxwz-7AbcNyRwSXJzbKMs=@protonmail.com>
	<Z8jTjt1CQ7hp8KSP@tapette.crustytoothpaste.net>
	<xmqq1pvbks3i.fsf@gitster.g>
	<CABEd3j-36C_LUOetg0qLofrby9M1Hixkh4o7sQkkyyWuTqHQvQ@mail.gmail.com>
Date: Wed, 05 Mar 2025 15:56:53 -0800
Message-ID: <xmqqsenrjaka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oleg Taranenko <olegtaranenko@gmail.com> writes:

> On Wed, 5 Mar 2025 at 23:53, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I wouldn't have thrown objects in the --template directory, and I
>> wouldn't count on things outside what the mechanism was invented for
>> (namely, .git/hooks and possibly .git/info/ files) would forever be
>> copied in newer versions of Git, but certainly "git init --template"
>> mechanism sounds like a good escape hatch than mucking with Git code
>> base to teach it myriad of languages and their dialects.
>
> It sounds like creating a copy of the .gitignore structure requires
> the user to learn bash script syntax. :-D I'd like to suggest adding
> one more option to the init --template <template/dir>
> --only-gitignores. It will not deal with all the complicated mechanics
> behind hooks/etc, and will only look at the template folder structure
> and copy **/.gitignore into the newly created worktree. In case of
> existing .gitignore files, just put warnings and do not override
> those.

I was referring to .git/info because of the .git/info/excludes file.
