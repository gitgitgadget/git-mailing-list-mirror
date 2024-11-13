Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07A4382
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461259; cv=none; b=srGpaPV5LeZTvB1V4WO9v/t4mNAvoG5wMhzgYyU959ebv5xuEFURkIglYetgyKeGnrEHhoiNQYQmxuoO6VZIKNKiOhN5hAxzjJN8gWJkAlDpyga7Cd2ANoFWaZq81rK1SWzLz9cjsWIPxdp3sW5qQvPRmHF87uVgZGbBsDOMKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461259; c=relaxed/simple;
	bh=cOZ8iMXdiXBYZfCXHpyGA5uK8bcy0TQBx5SIExSRsxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rtYHBEysuQKwNtOlk5X+0v6enXYSEvtkvapit9R9w6X2AfkWt0GiipfIr+kfR28VslatHOZztoEoxFwwik02mG5Utf/St6+gkpUsdFRBS6olKdjsn+eh0F2gEzMs7Q9nwDg9wjxMdM2685Hob3FmJ6x4Oc5gy5vwllKTHaNxwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjLq66Sc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjLq66Sc"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DEB8114014F;
	Tue, 12 Nov 2024 20:27:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 12 Nov 2024 20:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731461255; x=1731547655; bh=HRsqjKhNSDzVm3K1F31TZ3pGWdT1nDlk+IN
	8pRYkamQ=; b=UjLq66ScnJ/Pgth/ip2Wv9h3TgXJpc9ssYSNqExCfyxkXadaYJr
	ifKf/Ga96y9E5Pb0qQgnwMkQKwvDPsQmMEv7crsG9ouxn9sU9HYbCfR4y29F/BXA
	5LwGKdmNxqUSCtcmPvMg5oziG9v01/Egn+0VO3Gih1hWkG/dQLZp4k8tdETLpOpc
	mUOh7yaDfgM0fMMpltSEMVVxhnBo9E52OHfYuNU/SYHsIKP93QZz/uuYeaU6tS6v
	FTklELoK/fc02cEFefazKr876rkRBYsDE3zzZnFpzr1jU55mEGD9SmvfHPR4xcIL
	dbw536xFUBlJxx67/WK/vMgZuzQBPhaXjzw==
X-ME-Sender: <xms:hwA0Z7_L4LdU7VieAAh6JKqGPHV1p8arHPeTROADRzxQYRlzZIhWxA>
    <xme:hwA0Z3t2zv-INFdZtaiV05v0zpsoYij2TZBd7W6VvQMNRc05zhnpZgKjYLcts4uxU
    cicK7P9RPUUvfZ7zA>
X-ME-Received: <xmr:hwA0Z5BMH0TyrFU-tjHC9hnDNAulPDpByqFtgjoX2AvqbsQKDaY5-ZzutAErf7ENkl1Hc8F3vAfsyINcv1HVvofUF4U_7DKIvm7x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshgvthhhsegvshgvthhhrdgtohhmpdhrtghpthhtohepug
    grvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
    pdhrtghpthhtoheplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hwA0Z3dlwNmgkgeF4Ha95Quvchhuav3OzWT0aICR2Q2WvphBvhzi_g>
    <xmx:hwA0ZwPiC4o-OVBvlIy_QF7AsgWusWHsV-QBx5WZAn6UTZu5BSDWxw>
    <xmx:hwA0Z5mJyOkxyNpOiuYUot5isHC7wSgHrCimGQGNkAmPjMowvMSPOg>
    <xmx:hwA0Z6udq6-BxnDzM7k5pScSjP7d9rwbJLZvpbL90OIyoMrpORuKgw>
    <xmx:hwA0Z3eVflKYce1qaUs21KsayzyrTdbvFX9ga3at4pN3w5xxxKmvELr1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 20:27:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Seth House <seth@eseth.com>,  David Aguilar
 <davvid@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Philippe Blain
 <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/5] git-mergetool--lib.sh: use TOOL_MODE when erroring
 about unknown tool
In-Reply-To: <6f7f553b283078ba3c81190686b150a87d901240.1731459128.git.gitgitgadget@gmail.com>
	(Philippe Blain via GitGitGadget's message of "Wed, 13 Nov 2024
	00:52:05 +0000")
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
	<6f7f553b283078ba3c81190686b150a87d901240.1731459128.git.gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 10:27:33 +0900
Message-ID: <xmqq34jv3ou2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> In git-mergetool--lib.sh::get_merge_tool_path, we check if the chosen
> tool is valid via valid_tool and exit with an error message if not. This
> error message mentions "Unknown merge tool", even if the command the
> user tried was 'git difftool --tool=unknown'. Use the global 'TOOL_MODE'
> variable for a more correct error message.

Makes sense.  Is this something we can easily test to catch future
regression, or is it too trivial to matter?

I wouldn't mind if the answer were "the latter" ;-)

Thanks.

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  git-mergetool--lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 1ff26170ffc..269a60ea44c 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -474,7 +474,7 @@ get_merge_tool_path () {
>  	merge_tool="$1"
>  	if ! valid_tool "$merge_tool"
>  	then
> -		echo >&2 "Unknown merge tool $merge_tool"
> +		echo >&2 "Unknown $TOOL_MODE tool $merge_tool"
>  		exit 1
>  	fi
>  	if diff_mode
