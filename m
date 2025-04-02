Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7B1EE002
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622466; cv=none; b=Lagt0JeVkxd8K08UJuXM1op+GJ/rEWepC6xS0TKgN3xjRIrM5vL0lc/mm4vFh6Kpi1gZoXOJD77S3iB12a8Pgv/akzCMR9Ls7jzxQNd3bkf4FfuzA/H9Ql5Lh4ZpisNrDTjVgcc/QGXkcnrLkNpbwgs+qsvgc9RdEnt8QpAHoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622466; c=relaxed/simple;
	bh=8k66L574wDdV3RKzjYNPpzZ6cplo7iaN4NJRtWSRcsk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LABIvJyfTEPM3mv5+FIx7B/fz8uJY4a4i81h02bDK71JN1vCQmeuTu3rclnx9c51ImHOk4wC/TP5AbUN7vlz0CbHag2tQxJ+yQRcxNzqa5h6r5ehZp0Xcr5j2KpkddjzpK2n6gg0xpXunzA+5ykEY/pkDopBDEk2ilqOMLlWpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZSZn83Qs6z9tPT;
	Wed,  2 Apr 2025 21:34:20 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Apr 2025 21:34:18 +0200
Message-Id: <D8WEKR5QQD3W.23CD3CXEPONGB@buenzli.dev>
Cc: "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Martin von Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
In-Reply-To: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>

Hi,

I would like to add one benefit to the list that I think is very important.
A change-id header would allow standalone code review tooling and Git forge=
s
(e.g. GitHub, GitLab, Forgejo) to reliably track different versions of a pa=
tch.
This would enable much improved code review experiences, not unlike what Ge=
rrit
users are enjoying already.

Mailing list oriented projects like Git itself and the Linux kernel actuall=
y
do code review more similar to the Gerrit model. There is a focus on the
individual commits -- what will eventually end up on the master branch.

A "force-push" to a PR/MR on a Git forge is conceptually similar to sending=
 a
new patchset to a mailing list. However, some people don't like that, becau=
se
it makes it hard for reviewers to track what they have and haven't reviewed
already. Their answer to this problem is to sequentially add meaningless "f=
ixup
commits" on top of a branch, making incremental code review easier. Often t=
he
branch is later squashed, to clean up the history a little bit. But that al=
so
loses important information in the process.

Mailing lists don't suffer from this as much, because mail clients don't go
out of their way to hide old patchset versions from users. However, they al=
so
don't provide any tools to help code reviewers associate old and new versio=
ns
of patchsets. A change-id header could be essential in developing tooling
for mailing lists that track patchsets and even individual patches within
them across versions. Easily being able to view the interdiff between the
last-reviewed version of a patchset and its most recent version is tremendo=
usly
useful for any code review workflow.

So I think that almost all members of the broader Git ecosystem would benef=
it
in many ways from Git supporting this header directly.

Remo
