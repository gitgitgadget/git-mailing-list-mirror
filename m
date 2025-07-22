Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E427F177
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204163; cv=none; b=ae20lHeKSFv0lnsNNM7h5hIlGmFDE/AJr5VWnP2q4TUeb9uejEVqiPwr8/1lIZrN23tswi+supfWcrctnUzaKe6fIg/5IYziQwcFBbBobiwpM3kBhThtrAdhLdWqv9B8tk8lal9L4NTnYFLJt8HBjfk8ESMGy985N3/skLUljrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204163; c=relaxed/simple;
	bh=JfJpTG1gQLA5cAAQzTas8C1+kid/xBNH5vF38qE+kww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWMCn2RmU88ij9/AQylvEahhDwvY4IPUi05zUAdw1htnlULSRk792c6aew1REROLBZFsTWBGbgrXnVbfsfZ2LSxmlBSnauWObjwoapTnYPY72n92wcwF9XAM/6sLVf3bDuMkIMpa2uQeZLB6OGfu67aT60CVu8p45o8FeX8gxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UQkNj4xq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTXyDwQE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UQkNj4xq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTXyDwQE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4A2C140035A;
	Tue, 22 Jul 2025 13:09:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 22 Jul 2025 13:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753204160; x=1753290560; bh=DxciZDkUoy
	M+nV1mLB17ou55GWsv90Kos4LDN0N5P/U=; b=UQkNj4xqsDOlRHVijh2yFCxKQN
	hm9y2eJ3RsRAph8xafOEgagLN1PCPWNJwkZZ9WWjzBMpXkw5ZSKgRs+Sz54YsdYV
	0Oqm18sLtg7Yg6+7buO739bPgScM+/9k4Lcw7j3orEJUkJPMBOwkx16pbo2qhM7J
	Ux4ITw/T4+m1K8MQUUeTzL+ZSU3N1MWc2Q10RvocX6lBgkDrjKhjNIol7mCWemoe
	rCqREfhGgBIWaxqhuY7Y7/NDsg4sWcZiGSGS/CQaZt4xXkzXjjK1szK+rvPvhJf8
	3iGqxhNtswTwE/SYg6qJrCaV4IV6AWouPUuix49btte5ENnOF0s/oDaFnIiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753204160; x=1753290560; bh=DxciZDkUoyM+nV1mLB17ou55GWsv90Kos4L
	DN0N5P/U=; b=jTXyDwQEKRHrrLlnMpODi+9gsYXtsTz32CQfG66nFWACQrmqWYM
	UFVrvW3tnYQ5cJ5UujlLKyCBDkVriQCVi3N3yQUsskIEP0TnaDbdsCDde1hdlMfq
	fxtrrRROpQJMSOvNSjtHOZK0/ohmpsQ/X3tK305FZUxPW4X+c0TkuBoXbpu/ygOA
	mtP7ugvRYi3kptCUOy7w+HfcO2jOjvlTzfOkDA00qkTMhHflGAkxTmX5lYyP1Znb
	37v0mrjvg+aumoJBGBVhJIPXAG08nKqo4ZdytMbPdmnnxyIJz5aC1WkrJkS2wooa
	bTVI55wktgMdHCF9OcPoN0oagZwvZd5dx2Q==
X-ME-Sender: <xms:wMV_aHYyvNphc8EyUj33Hh-7Wo_iALkYoNUb9DQMIU_KK5VoHfno3w>
    <xme:wMV_aO3aAlmD9gJLXL4IEKZZoK03uztwytjsCjNVGIfpIBvo1B3wVU1Kv-xAYzYWb
    y-hyxNxozXcsvsHWw>
X-ME-Received: <xmr:wMV_aKaUUbNi-wgaQwfJewHWh20wSyu0wI7w3nnG_uaL4SzM6CxlIfRMDlvjS3XYvvApdQZpuPBuEoxfob55agITjwgGZROw2_qshbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhishhtshes
    jhgruggvrdhfhihipdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsvggsrghsthhirghnrdhthhhivghlsehitghlohhuugdrtghomhdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhshh
    esjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:wMV_aOI9xwiVu586hQrvJrSHaMVdJfi0OAr_2CDOJTwiHxgs6vU5jw>
    <xmx:wMV_aBGE9lXQBRww7zmINvvFxK9saDxn9UWwmwbEcVPbQW2JNV0iyA>
    <xmx:wMV_aNv3UaBM_ACijuzTSAF38SMUoxZq6CPvGcKP1Zx0D5bEGybVCA>
    <xmx:wMV_aItOR07b0IF9YfFEkHjh9mYNABn2980M10oYjknt5IxjBLX1Sg>
    <xmx:wMV_aPz9VsjaA_dvTmrlf290c0gyIZ89bzoARFSl97g8iTwbZ0iFec7B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 13:09:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jade Lovelace <lists@jade.fyi>
Cc: git@vger.kernel.org,  sebastian.thiel@icloud.com,  newren@gmail.com,
  josh@joshtriplett.org
Subject: Re: Precious files and the .jj directory
In-Reply-To: <CAFA9we_yDs9SPL2pJU_WiUz8CqvQ8ZPHwXBfTzHHbt-QGV34qA@mail.gmail.com>
	(Jade Lovelace's message of "Tue, 22 Jul 2025 00:31:11 -0700")
References: <CAFA9we_yDs9SPL2pJU_WiUz8CqvQ8ZPHwXBfTzHHbt-QGV34qA@mail.gmail.com>
Date: Tue, 22 Jul 2025 10:09:19 -0700
Message-ID: <xmqqzfcwrw3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jade Lovelace <lists@jade.fyi> writes:

> I'm aware of the many discussions about precious files [1] [2] [3],
> but I wanted to highlight a particularly pernicious category of
> precious files that are really hard to do the right thing about with
> Git: namely, other version control systems. In particular, as I
> learned in [4], `git clean -ixd` will of course list `.jj` to delete
> and delete it if you have it in gitignore. But yet having it untracked
> results in it possibly accidentally getting added and also clutters up
> `git status`.

Yes, that is a very concise summary of what happens if you do not
support "ignored but precious" as a class of files distinct from
"ignored and expendable".  Git only supports the latter and we wish
we had also the former is where we are, after "many discussions" you
have read.

> It's my understanding that git has more file deletion edge cases of
> gitignored files than of untracked ones so the latter is theoretically
> safer. Is that correct?

Sorry, but I am not sure what apples and oranges you are comparing.

You list a thing in the .gitignore file or the .git/info/exclude
file (collectively known as "exclude mechanism") and the thing
becomes "ignored an dexpendable".  Your "add" will warn when you try
to add it, because it is ignored.  Your "checkout", "merge", etc.,
will happily overwrite such a path when it needs to be removed to
make room, because it is expendable.

You do not tell about a thing to the exclude mechanism, and the
thing is "untracked, not ignored".  Your "add" will happily add such
a path, because it is not ignored.  Your "checkout" and others will
play safer and more careful, avoid removing it, stop operation that
needs to remove the path in order to continue, because it is not
expendable.

The only solution would be to add proper support for ignored but
precious, I would think.
