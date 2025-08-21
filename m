Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F434DCC5
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805446; cv=none; b=OJPCCKM89Ig+w7M24mGT9hx7cruSLSceiyrRJojpegw9vM2z0tQtPRkPq4vy0tVuwGA27A5lozPYkHNOvVoupty7h4NPZZuGukjqeWN0BmbTwxj82n4UBkRcm/sN1OyzBxAcSyrtOx2tBYUTMQHDY6M+q7TiQIpL11VoK2WiR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805446; c=relaxed/simple;
	bh=4615DZXq0UgApuRJPEQE6Lqy6NDXG9vCf9AXa1wENaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U3Z3paQgo5Ccx1ZnSUrUT5amn6Wd0wgdH5uJQhYx6/nN74kEz40jufiU8Kb2v8hE/3u4OUbL3Mo98i6/GuP9vXzzeYPGjJ4h5Km/5IvfDrPCgo3LZo/bAevWGVUvS5kyKjtQZVyjw2n7BmRFgpi3+/ZQim3Mi44eFDI6LI3SC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LhbqA907; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3sgKnR/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LhbqA907";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3sgKnR/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7BD0B1D000DA;
	Thu, 21 Aug 2025 15:44:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 21 Aug 2025 15:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755805442; x=1755891842; bh=i2hcuAWhGd
	vPsDVArPfgsxDHFn1xFzJPzTmbGgVHg8E=; b=LhbqA907M7+iViyWqbiTiXCobt
	kDBAw9YxcrcbjG1os2XOrI5Dc+anaK4uOjS4Nitl8rMqi/JvE0glebUF8lk5jF3f
	QTOkBMjhq/DopgjzKQb5urvM3Vo0V1pO8y7dSU1PThZe7XWs2JwxG19Yn4bTTIjC
	0XenvoP+1DBjMLnLQEnjwpqUiZYMriR5w3mcUDJ9hcQCs8NFnFnKo9jgfoAl8E/e
	wz2M6ax6wVy4ubse84U56CiYkP4uRWj6SFC+kO0uIVllg0k3wWcC5GyczeoDwDrR
	7VvOu6NgfvRRofkN08U2EcXssOCQ62cyJDFeiCV1Qn/xeJzKdh6Lch4tV7yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755805442; x=1755891842; bh=i2hcuAWhGdvPsDVArPfgsxDHFn1xFzJPzTm
	bGgVHg8E=; b=A3sgKnR/TMYYKQYIR6TnMTQrPHCdr0F/vo1D2iNsMyftJ7q0NRN
	VDO1sRQpilaoI85P+DrYv4xlRauOUQf8V9jQj+fae1MAkYKsxqvVufrn6zOccJFG
	7HIcmDb5Moexx3M8glPn79KyEavMD/JrJh95dqejmQVqA03GN9pTrpL0aKmx+P37
	+C6avV4N6RjKW2MRey3Mogzh3AnQD07gXvxzhtXI/J3/5VcdV05fwWz+IU7sgLdm
	j9EUed3kl3cQp9LDUDkW3WJIty76ehB08VCnKUXGEI25vrYDUrA+hGpl3OeSnqPL
	S878KvPznSJHIDU51v6RIEANPERTLN4MPZQ==
X-ME-Sender: <xms:AnenaMjtxtoNmXY_GeAwx5Bq-ZjbhLt3hGq2HZ6zb5hpKQ20mAe1Fg>
    <xme:AnenaAiBxye_yigWmeL8uzwZAC-UWRpShCq81DdDH_M-UAdTt7JTs5R6Cw1Jer778
    tbTokdzlTBG2YGmgw>
X-ME-Received: <xmr:AnenaKhK4Ja0vRhpbav-MgP0Dm8g1WW7tf1dLSxSty3zpV8b8g0wqNAKHJreJxMFJVSwkv93tsbFONQBj0_BKGxXy-pypyp1OazEBfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AnenaIJ2iHgVQXb8TKmhTNooLdvc7IKb_Zjc-_bn05TuxCY_7POXPQ>
    <xmx:AnenaBGbZ-xfvvKCeqWhqRw8kJV-soiNzO13UNlAoK3y7L_tEVfAWQ>
    <xmx:AnenaESUU8Upvj14eHBcaFOi538uhh7MgxQfEf5EIlAyjZe7JSBl3w>
    <xmx:AnenaFd67Ln130LITcr7XIc5z0LQIdRnlEzZEk0MRQsONSGXILqQiw>
    <xmx:AnenaHgu2e5pzVXOaLVkmvInrLvQE6VgMGrrwUNzjoZw_fzGrlkgY4Oc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 15:44:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [GSoC PATCH 2/2] repo: add the field objects.format
In-Reply-To: <20250820144247.79197-3-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Wed, 20 Aug 2025 11:42:47 -0300")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<20250820144247.79197-3-lucasseikioshiro@gmail.com>
Date: Thu, 21 Aug 2025 12:44:00 -0700
Message-ID: <xmqqh5y01mv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> The flag `--show-object-format` from git-rev-parse is used for
> retrieving the object storage format. This way, it is used for
> querying repository metadata, fitting in the purpose of git-repo-info.

Yes, and extensions.objectFormat specifies the hash algorithm used
in the repository, extensions.compatObjectFormat specifies a
compatibility algorithm to use.  So objectFormat is a good name to
call this new "repository metadata".

> Add a new field `objects.format` to the git-repo-info subcommand
> containing that information.

Perhaps drop "s" from "objects.format" before it becomes too late?
We may also want to reconsider references.format as that is not in
line with either extensions.refStorage or --ref-format (taken by
'git init' and 'git clone').

Do these keys always have to be two words separated by dots?  I am
asking if there are other keys that would plausibly fit next to this
object.format thing.  object.count to report how many objects there
are in the repository, or things like that, perhaps?

> @@ -49,6 +55,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
>  static const struct field repo_info_fields[] = {
>  	{ "layout.bare", get_layout_bare },
>  	{ "layout.shallow", get_layout_shallow },
> +	{ "objects.format", get_objects_format},
>  	{ "references.format", get_references_format },
>  };
