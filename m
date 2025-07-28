Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C790275871
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716924; cv=none; b=Ib8/nLzeZ0vacm53mciJIPQrtwQ+mjclbNfNOTCYghzE4QQ/HLvfNsJeWSRdvAcJvav25+QJmCgbJp7/lGM/VTzbaR+1s4JVUFJZmG4MHU9MxpVicv+FgUq4Peh41QNrYh/AoQ2xaNUKzLWOKsV0d79yv5F0Yghrqz5MCzirAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716924; c=relaxed/simple;
	bh=kxzp/CGS+YSN+6hv1oGFrs+HppzPIhGriUM9fGc346c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHNyVkAzf+L7iGD5br878hAqEKfjwN9VZtnRP7xtK967rng5yHd7UD8r9SOpI3lk05jE7o3MGL7/iJf+dEB5MPPxBgqR3yekE1LQ7Ao8+SAaPNjvGzaMsR5guKwZly/etp/E/7yapC+ZJYEZIIJf5MbhYPn9z0JEZYC7uw9ztDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kK+EueGw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OGQoVdec; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kK+EueGw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGQoVdec"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F509EC007A;
	Mon, 28 Jul 2025 11:35:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 28 Jul 2025 11:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753716922; x=1753803322; bh=g9/f7W9gJv
	eIzjhYPhput6iGscZg6nUNn5syZzKrtFg=; b=kK+EueGwy/CpdLCcbOzKwa98qy
	qHWTxNtVayoOkmsXzyWWIISezYmhsiFnn+ELQa/00+sP6bcWMyyPiS4BRGN5nNIn
	O6WD104OaJKjqjoj7f+QrTbijpkrN6tvr38j9nd6n1v0jvMUTkk+fTrNCHbipwnq
	+F2tFF8Q2h7FlF7wR/9bpw/0YWc8xtnp6Tf+rMK4hqrK3sDtC34729kTvejavPEo
	rnyLMQ+oxT+Hsck1csqbFSIxoy5t+bZwh3shmIsNdxbRyb4IoE6m7YNrjpKmqc/V
	NMpjMKTQJBZwdV2iyAgjLuzTuP7YFbS9joAT1GQeznkPEWoP3dcnrOxqd4Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753716922; x=1753803322; bh=g9/f7W9gJveIzjhYPhput6iGscZg6nUNn5s
	yZzKrtFg=; b=OGQoVdecKXzk1pyZ3vv6KXqs5Zj5wjuPecOBllIwoFPRT5fM71P
	bnaP3s2ShhumKcNsb5WWzOLgoMWQCuAMO26pVdDdjgG7rscNi2PC7VHBcOYwA5Cy
	6Y+3j7H/UhTD7x/8r/F/g/i5x8GrGLSDEB1AvIhtGrN7G9NOx7j4/N8zwv1DYlQ+
	tS2xrULAFIGGRRSjwuP9Lpiw0WjmPaEV5x9Naa32ZK/JpS9+wYVYtEJUEINByPOI
	lLyedVBDW1TDNbHRf32xG8fU10qHQn8NeV29RZYNa0wTw14R+J8LVQTdbRrE3x64
	MBtuwu0TA4blkCaoxUoM0PKmA44y0FcA+NA==
X-ME-Sender: <xms:upiHaHU0-OeB76k9c4_9rRpH7xpEnilKnTqAQ37OPYe-VnfpGovPOw>
    <xme:upiHaIDObt5HO8vkOO0awLf0kCiqXrRrMFB5cSTKQXKnpvVKmy64kB8meGnB9D7Zw
    yRc9a9OBqNIxt9ZdA>
X-ME-Received: <xmr:upiHaD1cooQLzc8MVH3ngC2PQ7u26Bwnr3sS8gnqKAkQQWj5s_LNEpsgbM_zsFsNyOw1x-FH1E1gVR5mc7ivjD0_x3tOQYwVZYlrdn8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejfeekteegkedtjeevgeekudduudefhfdvueefieeuteetveelieelfeekveef
    ieenucffohhmrghinhephhhtthhpqdhpuhhshhhinhhithdquggsihhnshhtrgifvggsrd
    hshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghi
    lhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:upiHaC3jsayWUtWDSipqAYVs6NTyuFFQo7bO5fn7JZWikIx_76c_Eg>
    <xmx:upiHaABHhFyczElsQT2-Z-3MwdvHUVIcguySyGNR2EVldFXB9_24rw>
    <xmx:upiHaJ6xJL6OanfPiF2Hxo89aQpZVCkm-XwkZE9Ne-AEvw9Hgzr61Q>
    <xmx:upiHaJKYqa2HGbrkBTvzqJe1jbs2gWV11hCavv1vlJwdsGclfhTS7Q>
    <xmx:upiHaOswaJOadwqR6muxuKVvQEapGLDX2JXR1T8mqplcxcqemQ78JoOH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:35:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Jeff King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/4] t1517: fixup for ua/t1517-short-help-tests
In-Reply-To: <CAPSxiM83fpNXsfBrtG4xpRt=yYaU7e0OFkAHK8dkLGpF7jtDxg@mail.gmail.com>
	(Usman Akinyemi's message of "Sun, 27 Jul 2025 03:27:28 +0530")
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
	<20250726165320.4039-2-ben.knoble+github@gmail.com>
	<CAPSxiM83fpNXsfBrtG4xpRt=yYaU7e0OFkAHK8dkLGpF7jtDxg@mail.gmail.com>
Date: Mon, 28 Jul 2025 08:35:20 -0700
Message-ID: <xmqq8qk8xr9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> I expect this and other fixes to get squashed into the upstream branch, but I'm
>> including it here so it's easy to create a clean build.
>>
>
>>         difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
>>         http-backend | http-fetch | http-push | init-db | instaweb.sh | \
>>         merge-octopus | merge-one-file | merge-resolve | mergetool | \
>> -       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
>> -       remote-http | remote-https | replay | request-pull | send-email | \
>> +       mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
>> +       remote-http | remote-https | replay | send-email | \
> Thanks
>>         sh-i18n--envsubst | shell | show | stage | submodule | svn | \
>>         upload-archive--writer | upload-pack | web--browse | whatchanged)
>>                 expect_outcome=expect_failure ;;
>> @@ -125,7 +125,6 @@
>
>>
>>  test_expect_success 'update-server-info does not crash with -h' '
>>         test_expect_code 129 git update-server-info -h >usage &&
>> -       test_grep "[Uu]sage: git update-server-info " usage &&
>> +       test_grep "[Uu]sage: git update-server-info " usage
>>  '
> Looks good to me.
> Thanks.

So, can I ignore this step from the series and expect the fixes to
be already in your updated series we will see in the future?

Thanks.

