Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EC1898E5
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971115; cv=none; b=ScGu5JzUiGOVSd3NvonBrpDkzyQYILS4zPuiE7xRGIFp53kRxY1Xezxqn2QiYOE1K5fvBiXE5F9BXu0WCVrDFlzP+lMZuMRKDL+KSZD6TbFnR0vCJqlm5PHntmTdQbxjHxsAzx5FuVHN1hHaWxVitpeVOaGtTYcmJNFtiiOy2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971115; c=relaxed/simple;
	bh=BtIJlgY4b4ErneDFyd5LEw/NvjmybDoVIjM6Wa2NxaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHwuLJmFdCtWBbbXQm18jjjqfiZ/floc16u0iCHrzFgP0fuT42ofeaoLLYAW5TeQe2WYT9lrNSdG5iuAyzFEg4GoF/j6hGkpbqWZlY/wrIohjTnQ1UpF+rPO+S8PZrI+gQXaLHzpot8+oZ1dMLY1QvxoI3L1TntUQ5vBOMNVvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CYJ91XPi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CYJ91XPi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E05D2693E;
	Thu, 29 Aug 2024 18:38:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BtIJlgY4b4ErneDFyd5LEw/NvjmybDoVIjM6Wa
	2NxaU=; b=CYJ91XPiOZbmfI3Pv2+OZQjmnjfHNFma3V0KNIoSbhXZVpaZIcd36S
	uuLIESNQPbMxkXuX5bzaP5vPy+7n+qtSrehMZniTBu6ywgpF33M4AplHAQWOsM75
	fLZJLoiO7CVAbV8laCaEVLySQDHLcFzO5RZN032TR1Pvld3LaK1P8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 360772693D;
	Thu, 29 Aug 2024 18:38:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B5792693C;
	Thu, 29 Aug 2024 18:38:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Yukai Chou <muzimuzhi@gmail.com>,  git@vger.kernel.org
Subject: Re: Tags auto fetched by "git fetch origin" but not "git fetch
 origin main"
In-Reply-To: <ZtD0kJU_OdBBktZ2@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 29 Aug 2024 22:22:08 +0000")
References: <CAEg0tHRbGBBq7i78bTSfws_WZO=2W7xuDwiT2qFA5iOza8qDDA@mail.gmail.com>
	<ZtDo--AY43-bPTHG@tapette.crustytoothpaste.net>
	<xmqqy14ft36l.fsf@gitster.g>
	<ZtD0kJU_OdBBktZ2@tapette.crustytoothpaste.net>
Date: Thu, 29 Aug 2024 15:38:29 -0700
Message-ID: <xmqqjzfzt0nu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6A7C8288-6657-11EF-918D-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> But the `--tags` option says this:
>
>   Fetch all tags from the remote (i.e., fetch remote tags refs/tags/* into
>   local tags with the same name), in addition to whatever else would
>   otherwise be fetched. Using this option alone does not subject tags to
>   pruning, even if --prune is used (though tags may be pruned anyway if
>   they are also the destination of an explicit refspec; see --prune).
>
> That implies that all tags are fetched.

That is stronger than "implies", I would think.  Indeed I know from
the code inspection that the auto-following only triggers when neither
--tags or --no-tags option is given, i.e. builtin/fetch.c has this:

	if (tags == TAGS_DEFAULT && autotags)
		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");

where the variable tags is initialized to TAGS_DEFAULT,
--tags/--no-tags sets it to TAGS_SET or TAGS_UNSET, and autotags is
incremented only if a refspec we use has right hand side after the
colon, i.e. stores what we fetched in our refs/ namespace.

> I think we need somebody to test things and clarify the documentation.

Done ;-)

> In addition, it might be useful to add a `--relevant-tags` option or

A similar option is called "--follow-tags" on the "git push" side.
I _think_ it is just the matter of adding the option and have it set
the tags variable back to TAGS_DEFAULT, i.e.


diff --git c/builtin/fetch.c w/builtin/fetch.c
index c297569a47..f22c00a39d 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -2186,6 +2186,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			    N_("fetch all tags and associated objects"), TAGS_SET),
 		OPT_SET_INT('n', NULL, &tags,
 			    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
+		OPT_SET_INT(0, "follow-tags", &tags,
+			    N_("auto-follow tags"), TAGS_DEFAULT)),
 		OPT_INTEGER('j', "jobs", &max_jobs,
 			    N_("number of submodules fetched in parallel")),
 		OPT_BOOL(0, "prefetch", &prefetch,


but I didn't look too deeply into it.  It needs compile testing,
documentation updates and new teststo cover the behaviour.

Thanks.
