Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA702DF125
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824417; cv=none; b=TGXG+F66S2SbfELHqXpP5gCfra3quuaKZ3jsPSS15Ap0V0moFhYMMP1pmtthyJq0ZOmLxZca7pg07IcoHigp2tD8+/+f+39Dkj7Xg4/UnUssoR+ukUdEu+yMSnep6zVvVEvpvyk88cfXC+smoh9Uvg5UTgjGXIVsGkbErpkPiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824417; c=relaxed/simple;
	bh=lERsYnTzsiTZgBOR25WoyQMz+8LHZyFR6L8xjkdj2gM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GAe0juDIASnlijVZGdoTHhotbNiswlAtNudL6qjItDJcxYlxmykookt+IhSWjkgcqMGv9OWNiEd/U+d1YTw7T4JrhmDiZ9rgselwsaynJHlRmmliJvuJ9LK/pDY1bOOftm1hg1fqmAJZDtwYbgri4JYvtBjwIgDxKlEj4PzJ1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eYKfp+oX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z02MOiRX; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eYKfp+oX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z02MOiRX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id AD6691D00362;
	Tue,  2 Sep 2025 10:46:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 02 Sep 2025 10:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756824414;
	 x=1756910814; bh=lERsYnTzsiTZgBOR25WoyQMz+8LHZyFR6L8xjkdj2gM=; b=
	eYKfp+oXHmoRjVAl+0CVw2OMxqXK9Mgfko3wxbRbe+SA5bnkpqdB1hhjeNKb/TRz
	dpe/UQqMRCbUVWJciqUrejWBtvLXUhPwSLT+98kSVSFmKeqxGv/gkAy4i8Z0w+6P
	ubd5c9XTEtnlx4IwEhdn+41pmhM5u2SUq37ggkuT7RZhX7xAKBBmbhTgUdDh4yQ1
	AWas/eOQh0h15HRDp+3w2YDSbiElEof94heNWRfsvS8Uc3+WTxMHr4XJ9UNGw0qF
	DJqnNdZfwePiABZhqmndoHrMN33K0s8AUVPq3LMRABGkGrCUz3T4Pa18ZFs8pkxP
	n3arhDKpRTsr5r7W4Gyx8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756824414; x=1756910814; bh=l
	ERsYnTzsiTZgBOR25WoyQMz+8LHZyFR6L8xjkdj2gM=; b=Z02MOiRXLGWvsXhWc
	3k/qnKU3amQpqiX0P5MYZawDzMzYDFIFN6lAtfB7m1Gs3wAEpU80gG26P/xx/D4w
	BeQGRM8HXieEx/nhRacI1cNxSjYbxsvG3TdSIwO9GK1ZQ4hL9Egty8W3d2GzK+2C
	b19ygydhAn0+DzMhLXi/R2tkWp4tc5fEjSOVF2DYff4SpUAQ4PtET2jHpEff2rVG
	OQ4yLNoePIH2cE2+vJ6p9REORUr4aJjepFTHYZlWJ3STLgummasc5jJoE8tIdzoi
	hXBTMMFVqHjjRFoh4iwk4JE6GX8BwJeu+Mei3r+KdFHW8yt5nZJkOHxuE3Pikj8r
	aJY4g==
X-ME-Sender: <xms:XgO3aHgFsd_5AJjVYLsoDlV59W7CYKfu-moKgReVe9vHO9i5wjXtLa8>
    <xme:XgO3aEBA36v4QGLnclbI3rArTlQ61gRaUwTkAhOXjZHkZnypzJY2JZBav4N-9hmho
    WhJTb5Z4sDg2SRCyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtje
    enucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffjeekvdejgeeigeefjeekgeelveehieettedtvddvgefhgeehgeelleel
    veffudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehtrghruhhnrhgrmhhsihhnghhhrghnihesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XgO3aLm4ylOnBTJGLg3RQJEFL-IsZGGjm7FGTqTSwjoMCZlg5HVCLA>
    <xmx:XgO3aHxamXElvFPQlewNuJnu2srcb-c9jxvFgZDByatmjHDDvJq3UQ>
    <xmx:XgO3aDnafrUwAalv0sAiXlmrFkLChHQuQ92nmpCJAydRpZ2z63lXaQ>
    <xmx:XgO3aAfTMrUk-T8aFJFDcPgiptYmowua9o93gzkZ7yyvh0qUxC3zIg>
    <xmx:XgO3aPt75Rj8NnFclXKp9D4A6LABOtCzXuIxb1zukHspmRUq54QRnRbd>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 46CCD1EA0068; Tue,  2 Sep 2025 10:46:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApP4gqYI_F_R
Date: Tue, 02 Sep 2025 16:46:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: 
 =?UTF-8?Q?Tarun=E3=80=90=E3=83=84=E3=80=91?= <tarunramsinghani@gmail.com>,
 git@vger.kernel.org
Message-Id: <829c6e09-c834-461f-820d-981512a02a76@app.fastmail.com>
In-Reply-To: 
 <CAGAx-2Ac2Tt4-jTH=AApK3m=U7d2RJBaTW=uX6jBHzmpWU9NYw@mail.gmail.com>
References: 
 <CAGAx-2Ac2Tt4-jTH=AApK3m=U7d2RJBaTW=uX6jBHzmpWU9NYw@mail.gmail.com>
Subject: Re: Git fetch Failure
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025, at 16:08, Tarun=E3=80=90=E3=83=84=E3=80=91 wrote:
>[snip]
> What happened instead? (Actual behavior)
>
> Git fetch failed with error
>
> error: cannot lock ref
> 'refs/remotes/origin/users/ajya/sqlservermoduleimportM146': Unable to
> create
> '/Users/admin/Repos/tasks1/.git/refs/remotes/origin/users/ajya/sqlserv=
ermoduleimportM146.lock':
> File exists.
>[snip]
> [System Info]
>
> git version:
>
> git version 2.51.0
>
> cpu: arm64
>
> no commit associated with this build
>
> sizeof-long: 8
>
> sizeof-size_t: 8
>
> shell-path: /bin/sh
>
> feature: fsmonitor--daemon
>
> libcurl: 8.7.1
>
> zlib: 1.2.12
>
> SHA-1: SHA1_DC
>
> SHA-256: SHA256_BLK
>
> default-ref-format: files
>
> default-hash: sha1
>
> uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Mon Jul 14 11:30:29
> PDT 2025; root:xnu-11417.140.69~1/RELEASE_ARM64_T6000 arm64
>
> compiler info: clang: 17.0.0 (clang-1700.0.13.3)
>
> libc info: no libc information available
>
> $SHELL (typically, interactive shell): /bin/zsh
>
>
>
> [Enabled iHooks]

It looks like a casing issue caused by `default-ref-format: files`.

```
$ git for-each-ref --format=3D'%(refname)' | grep -i sqlServerModuleImpo=
rtM146
refs/remotes/origin/users/ajya/sqlServerModuleImportM146
refs/remotes/origin/users/ajya/sqlservermoduleimportM146
```

You could try

```
$ git clone --ref-format=3Dreftable https://github.com/microsoft/azure-p=
ipelines-tasks.git
```

--=20
Kristoffer Haugsbakk

