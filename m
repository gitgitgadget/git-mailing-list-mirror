Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB08494
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733102787; cv=none; b=THz9uw8S7m4pQhbL8sOT3bxVJqrNhmpDQ9FswViSS/jCyCP8lsa1MnO8zoDzz0z0vf5gpoaP1m/Cws3yovY1fO+m91RVB3yGJKqg7LATxRM/dFYlhFspyrFVRH5F4AZpV1nxzPOJ+TNqAGgq3wnbvtmYHX9PclkGBKERJIFRa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733102787; c=relaxed/simple;
	bh=aGw5mBaE90wa0mISTM3p+w8Z5VbmGP8+QqfnbJ6HvO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OOD3n5g1OdZX1Lwfgmg+YEdKDuf64wTKtGChLw5+YaqJgUfjoQ1lDfWzZ7XuCBYcejK6W1UuOktNg8rKOCNyCr2vilp38a6xjyhiCISe8J46gCxR0kX/RwAW8HUSz8Kfqh3O9XTeGcD6FXivcfAesrzAX/os+sL1KGKOZt1qREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yfmfOMcF; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yfmfOMcF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 42A4D114013C;
	Sun,  1 Dec 2024 20:26:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 01 Dec 2024 20:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733102784; x=1733189184; bh=96EyPKuJZH6XFmvsk3bPu52i0RHyysCDmQG
	kaklP7kw=; b=yfmfOMcFt9hE5GHFUNNGBhidzz1Jq8EpV8xqcKc4uSS2MyuzUBt
	migIma9ZS/H3HDg15Pl8q+Vw2ucaMkIPC5KsCs47XjHspG4KAlKDgn0fs/Tz6CEX
	yR3MLmgXuIWo58tUoM875U48DiVBxaZ3hk6qv/4tMM75w5xMHWRd4Oz0qGj0xzsL
	ezX77txpPoA7nJmyqJKiXsvmsx+tQHp/vTu+LfXM24wq5zV2JZU082dyjwb/OVIk
	uSlqpHvrBwxtTOWyFE/qlnX6alkiiDf3vVUeSzBZ0mESgPJPC5PFxNyvnIV79Xch
	/wHRzBgu1a3Yb0gc24PSF9lEgHDG+R176cQ==
X-ME-Sender: <xms:vwxNZzTh--esQJTaIxscdkhJG7ffgBdy74xKiSELZlx_AdCjSX8RkQ>
    <xme:vwxNZ0y3eQ60vyrGLpZ3ZF2aJ5XwvVHM2s__MRl3Q_umJWht4vnUanV1SDB_dAPCe
    lMTXfrQALAbxDDS7g>
X-ME-Received: <xmr:vwxNZ42r8V1nLSTffbOfsgh6LALCauRR3YQg51gb0NMsb7346lzXCJK5lqfse5KJjBm2qnbbg828TFEbNe8OxA5rd66pIpvCwviI8Ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vwxNZzAl5tAQvoUZyRrAK6HnvOuGTD6UBTbqXbGfIrSFhAbcYfGNGA>
    <xmx:vwxNZ8i56tvgRVrDeRcl4mWfgd6lQCo0BkhhtLq5Fz-TPNUHLbnlxA>
    <xmx:vwxNZ3pmIbvV-L5h6VbqzguZePDVTbWjK0VQyaCdOuEHSwL5JcwCzg>
    <xmx:vwxNZ3jPX2bXQDhGrau5IDIo5rKj73qXq8xGENMIpR6Zk3FwL6-9sg>
    <xmx:wAxNZ0fVfo2X4d-8xforwWw4eyQrTq7dRjhRAzd_X3340hbp4pmhiB8N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 20:26:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Johannes Sixt" <j6t@kdbg.org>
Subject: Re: gitrevisions: be more chatty about shell metacharacter gotchas?
In-Reply-To: <702d88e9-c62d-482c-a457-6d6642e8488e@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 28 Nov 2024 20:30:17 +0100")
References: <702d88e9-c62d-482c-a457-6d6642e8488e@app.fastmail.com>
Date: Mon, 02 Dec 2024 10:26:22 +0900
Message-ID: <xmqqttbmkh8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Part of why my eyes might have glazed over (I think) is that this is very
> technical phrasing.  Yes, technical phrasing in a technical manual.  To be
> expected.  But the topic is the revision syntax; all of us Git users of
> varying levels might be primed for less terse but more evident paragraphs
> like
>
>     Keep in mind that you probably should quote the search string.  A search
>     string like `:/fix nasty bug` could be interpreted as just `:/fix`
>     depending on how your shell splits words.  Try to stick to
>     `:/'fix nasty bug'` or `:/"fix nasty bug"` (whichever is better in your
>     shell) for that reason.
>
> Because this leads with what the gotcha and remedy is about.

I am very much sympathetic to the cause to help people avoid making
mistakes, and reminding of the basic rules of command line syntax
"as needed" may be a good idea.

Any arguments and options you give from the command line are subject
to the same shell quoting rules, and we at least need one single
place to say exactly that to help beginners.

On top of that, there are probably arguments and options that more
often contain shell metacharacters (like '*' and ' ') than other
arguments and options, and it may be helpful to beginners to remind
the need for quoting.  But "as needed" is relative to the level of
reader, and if we overdo it, it would make it less readable for
other readers.

There already is a note about '*'; we can add another note about
whitespace next to it, perhaps here.

 Documentation/gitcli.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
index 7c709324ba..0a67005fc6 100644
--- c/Documentation/gitcli.txt
+++ w/Documentation/gitcli.txt
@@ -57,6 +57,16 @@ When writing a script that is expected to handle random user-input, it is
 a good practice to make it explicit which arguments are which by placing
 disambiguating `--` at appropriate places.
 
+ * Arguments, options, and option values given on the shell command
+   line follow the usual shell syntax rules.  You'd need to quote
+   your string with whitespace in it appropriately if you do not
+   want it to be split by the shell, for example.
++
+--------------------------------
+$ git commit -m "my message with whitespace"
+$ git show "HEAD^{/^my message with whitespace}"
+--------------------------------
+
  * Many commands allow wildcards in paths, but you need to protect
    them from getting globbed by the shell.  These two mean different
    things:



