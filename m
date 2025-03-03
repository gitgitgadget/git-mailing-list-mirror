Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610CE1A0BD0
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033802; cv=none; b=WF4lDk51LjZr5c9sGJdTO6vNnSboznSfJy3CAMthhCV1Y4u4qmCrXepPznnOn1JBD994Rsvq7zyn/M53H1Y3G9MiA7BelYpG4C+kg6rHt4+XaWIxdaW03UME/4OKGuxYxrHEDNjxDkuhgepw8m4kXA4hZJeu/oiyCHFLceWnwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033802; c=relaxed/simple;
	bh=vhQ5IN5OUpvEYMyGoyNQ8FjCkYeymqvzVimgQ8XODOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZAulvDz7YaGsjEG/YalFNvDCExr1H7LYDZytxYzESzk51/lu50BHjwZt+I6WqH3kaALD5ZokWK5TpExdk0hA8JBmbaJbZzzRjz1bImooKFlypKcVl5hJPVwZ6T64vhx1d8f1ghzPtzS20sz8KDMHN6lI7W82efTj2HwfWLsZiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nwf2sV23; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fi38iq9S; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nwf2sV23";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fi38iq9S"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 55C8B11401ED;
	Mon,  3 Mar 2025 15:29:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 15:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741033799;
	 x=1741120199; bh=KJi/wh8UWmUfhp4qPQfd7XAWoty4LSbV5paS2evk9HA=; b=
	Nwf2sV23fI4iPquig8lU9kBMVhXQoQpm3GxvD4NdhJA/etyw12se1hFqIelKksSF
	+9uqlaCkyvNU2wcCLE/YSb1k7biosi7OyHWLTmFpZhJw6yA38rodzHhVhWMnAOXu
	7xJT+6EgpWMheDXImpIo6SmkPaSyK+bA1RYwsxwa+0MxPHrFOJA4TQwbrL2lrAj3
	jhftjmzuqCc1jSffX8b30eiGd2ucGvrJvc9j6FniIflH2tBmStUoA8tqzEAyogux
	ZjajQcewTys98P0t1FDusB1FOAafUhzox4+xW1RUFJabrzx/0nVF94yKEY6gGDS3
	gzrjUjqdgB8H4E+pZVm6fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741033799; x=
	1741120199; bh=KJi/wh8UWmUfhp4qPQfd7XAWoty4LSbV5paS2evk9HA=; b=f
	i38iq9SoK6Hx1Ps/9e/C3yz9KNy8758z34eC7kwyXD+vAAOy1YqIBihUM7+/bhTO
	HluVWGnfxf/j4AL+6qzDRQ3CJb5wjgRoP5R8BNHDsQpMRH/kZnr5ONLI8eYihyEQ
	46T3Xd17i2lolnOK1hRmVOUiuGSeApkDwQ3opNdienKZBCBSTH65VU2JhdF9Xnmg
	BpVIZgxudqH7j0lp6dPuemGKJfCqqllD6EsJlaW8RH+wwiWXLP2wN05HWm+m+Bdc
	0CeY9PegVWXJuqujACdEKsQESxDOOCyQrRBPKH+ESeNfFemHlLdyhIhxqOpCyGnd
	AwZzLpKZ2aO1KjHjPsdZw==
X-ME-Sender: <xms:RhHGZ-v9Qsk-ytqaYlNpRX6StKzBCTw7gH8M8Y_QWXxUPzRbecvKpg>
    <xme:RhHGZzdbQQic-73N3XJvMbgEhZ8KwZHoQR9xm3lu1EbjfTrujo_cCWoD_FVoqj3oP
    Plf9J0J5jW25d8F4g>
X-ME-Received: <xmr:RhHGZ5yY2_vt9GGfQo8aeF3KfKxQHhUoE8UnmP3eZGMl8SLJk4EJ2NNgz-ljE0VN6EWvPF3g5IgW9ozlVR4qt3sfmSxvdciScc00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddttdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhhiugesmhgr
    nhguvghlsggvrhhgrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuh
    hnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RhHGZ5OOT8RTbsxW_gYF1qKa1RJy32R5vWIXPAa22gCaSHgovJpTgA>
    <xmx:RhHGZ--KvzWSVZxVNHuESr1otn1qKHr5aZFiWYagmGU1h7BIVDSuGw>
    <xmx:RhHGZxV-m9CFulvCNfvhJPFyw1gEvHGSHrFr67AVfpaZrs2V3W2g3Q>
    <xmx:RhHGZ3cedWmE4dv-FwaoJwC3ndx836irGlSV4vEWbnvmzxG0gdMBKw>
    <xmx:RxHGZzMhpIIL0tfpDgSJsEUnrLtqhdnAd8C4t0rH9GFyelzwfLKQO6ka>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:29:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: David Mandelberg <david@mandelberg.org>,  phillip.wood@dunelm.org.uk,
  David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
In-Reply-To: <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com> (phillip's
	message of "Mon, 3 Mar 2025 16:36:24 +0000")
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
	<95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
	<c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
	<2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
	<65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com>
Date: Mon, 03 Mar 2025 12:29:56 -0800
Message-ID: <xmqqtt89vovv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

phillip.wood123@gmail.com writes:

>>      local fer_pids=
>>      for ...
>>      do
>>          __git for-each-ref ... &
>>          fer_pids="$fer_pids $!"
>>      done
>>      test -z "$fer_pids" || wait $fer_pids
>> } | sort | uniq -u
>> That might cause spikes in cpu/memory/disk usage that aren't ideal
>> though.
>
> Yes, if there were a 100 remotes that's a bit of a fork-bomb.

And they are all competing for a shared common resource for read
access.

I wonder if a single invocation of for-each-ref for refs/remotes/
hierarchy would be sufficient?  That is, the calling shell script
can set up a shell function "foo" and then

    eval $(for-each-ref --format='foo %(refname)' --shell refs/remotes/)

and "foo" can do its thing avoiding as much forks as possible.  As
you are allowed bash-ism in completion script, you do not have to
limit yourself to POSIX parameter substitution but can use substring
expansion ${parameter:offset:length} and pattern substitution
${parameter/pattern/string} and other kind of bash exotics, as well
as shell arrays (e.g., define an array __git__remote_branches[] for
each remote, which may contain the remote-tracking branches for the
remote).



