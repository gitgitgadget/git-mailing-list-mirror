Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F017FF
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065302; cv=none; b=O7mpZvf7KIuv+CxGA/jgLVtneZFUuS9to8MPBI48ijjj7fk0H6Q/Tz1e1xCNXjEzZEUMMAVcGit+Ui7acULzar5MhHdXZfDzAp7M24exLSUMkVLDoDeVQTIHycfT8YSzdB3TnWHcfjG6xMMiuz3BXAC1BVOEj9t58brDypOvpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065302; c=relaxed/simple;
	bh=Amvzv4sAeYx4j9fFZiaka0DJpEA/DOHqMMj+7THa6qI=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=R65Cj+2jlZj38kf3rhlsFXk/mZFO/fJNJEhat2Ih0i9BbIHPvZVR3UP0UraYHP6DPW+cJtaGDZ5yJ2rLgkPSUhh8qA27nR3gdjcKf0Cq8cYSOpaWqCYBleyxaN6+2S31/Jz/CJ/Q4E+N+nx2NjQ+FiNLU2GlADvUtsWpp3UJtBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kfs+jk45; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kfs+jk45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=i6ywtmgzkjallhmps42vdbrir4.protonmail; t=1718065291; x=1718324491;
	bh=Amvzv4sAeYx4j9fFZiaka0DJpEA/DOHqMMj+7THa6qI=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kfs+jk45mg14VDTlXD3NCyx0iq7EGdEMT40oziMS0tKkrRvavwWrK3S+K3hLxAK29
	 QApK8KMLWlr6D7MvPpgXQGvgMZvgG/6NkWqva7fQDWYMH3zPg37uLLfZhaYEVRISKR
	 dK996fsbtdt+cuy5nQKUXudhNg8Fqi1jcumNo9XpY7RimdcR6ECuMLTdS8jE9Arq0M
	 PbSt2RjKKAffjMjXanuyoKa103MhKtF1LvR2pSYtOYZ3bWEGg9EsNqRWS1aCrqtp+r
	 3C3W5I2dBtiVevhw+vf6VznhNABL7F585jL4y+7aTw+VMeHcd/2owF5lwbtAyUREL4
	 23//7TgfusCCQ==
Date: Tue, 11 Jun 2024 00:21:26 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: rlee <rlee287@proton.me>
Subject: Question about Git protocol v2 status
Message-ID: <kMdINBpG8_XazfNJVjKkaYyCH4VKRgjQryAvNw2ceVZrNmJ8pqoowMgmGBhhDMS_-nQ02OX0dMglJA2EPrE39XIBtcZc8Wkr2Vcoh6_pzMg=@proton.me>
Feedback-ID: 61965011:user:proton
X-Pm-Message-ID: 1a73b71e05b27c6556e94d0ba66de7501d067288
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I've been looking into writing a custom Git remote helper. The man page for=
 "gitremote-helpers" states that stateless-connect is used to connect to a =
Git server using v2 of the wire protocol, but that it is "Experimental; for=
 internal use only." Moreover, the page describing protocol-v2 at https://g=
it-scm.com/docs/protocol-v2 uses future tense, implying that v2 has not yet=
 been finalized. However, the older blog post https://opensource.googleblog=
.com/2018/05/introducing-git-protocol-version-2.html states that v2 is expe=
cted to become part of Git v2.18 (with Git being many versions ahead of v2.=
18 by now), and my own testing shows that stateless-connect is used when pe=
rforming Git operations via HTTPS with Github. Could I get some clarificati=
on on whether v2 is still experimental and on whether a custom gitremote-he=
lper should declare (and implement) support for stateless-connect?

Thanks,

rlee287 [at] proton [dot] me
