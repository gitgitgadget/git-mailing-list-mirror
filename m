Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714A1534E2
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539256; cv=none; b=YHyQ+0DTTXoKHb659iHsk9vd6AOI4zOuh1MMKkepg9EeLK7YBh0gHlyl+LBDLCIHxuG6NPVz7awjBCo/xGZ5Ydf9rveZmztg5cvfw+27QHzfkYBDc0b1KMFDaMlqF8eMlrkL9sxZWh1OnTiCXcv0AEIyX3YmDOVu/3xj8xpjst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539256; c=relaxed/simple;
	bh=TT4mHZEr19ooB3ZdENBqe8LkR7l4nZydXR0HWTV0hQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CfBY5pTGWLnieeaQj7pwdBxbD8166M8Roa/q3Cx18SKqNwzTuQ/ezI02T83u35m85+lyqwXI/Y702Awg1GgsJbEG8vdEzADaBO0oL5/M5y4Iz7+unFi+Uips1qguuiNQcIcVDU9DkldDxGzs9S87uaaLKDhGlZwtvbLcWJvoxL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=BiJwkzny; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BiJwkzny"
Received: from mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2a0c:0:640:2804:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTP id 9D21660F6D;
	Mon, 29 Jan 2024 17:40:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id neZ0Swpn3eA0-95HTcCDu;
	Mon, 29 Jan 2024 17:40:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706539250; bh=TT4mHZEr19ooB3ZdENBqe8LkR7l4nZydXR0HWTV0hQc=;
	h=In-Reply-To:Cc:References:To:From:Date:Subject:Message-ID;
	b=BiJwkzny55EvTpHI097zjJmgQbwRvEo+/hMBgcPO+rfgyM18UBGtuVCse+AgESIim
	 vru+dXimfZCewWQPKqErtJkHLaIidbBSZIcEgWezvWf2j6NJ8csZoQvbwPzbadZjCY
	 VV2D1xwhsZfDbvxNV0VcDqyl/R5lCreum0s2++k8=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <694c9c01947a7a2e67ea225b12112dcccdafbc9a.camel@yandex.ru>
Subject: Re: How to execute a command on git am/rebase/cherry pick --abort ?
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Date: Mon, 29 Jan 2024 17:40:49 +0300
In-Reply-To: <4dd609ae2a33f3729291ff26b40632c8eb5decae.camel@yandex.ru>
References: <d66ef46827fc7391bd74ece943afa2c5245896d6.camel@yandex.ru>
	 <Zaknu0nwBucHVJPP@tanuki>
	 <4dd609ae2a33f3729291ff26b40632c8eb5decae.camel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 17:35 +0300, Konstantin Kharlamov wrote:
> On Thu, 2024-01-18 at 14:29 +0100, Patrick Steinhardt wrote:
> > On Thu, Jan 18, 2024 at 03:53:21PM +0300, Konstantin Kharlamov
> > wrote:
> > > (please keep me CC'ed, I'm not subscribed)
> > >=20
> > > Hello!
> > >=20
> > > There's a well-known problem of git not fully checking out
> > > changes
> > > while doing e.g. `git checkout` and similar commands when you
> > > have
> > > submodules. So e.g. if HEAD changes a submodule commit and you do
> > > an
> > > interactive rebase to HEAD~2, you may be lucky to find a
> > > submodule
> > > commit change in `git diff` (because if you don't get lucky, you
> > > won't
> > > notice that and commit the change to the unrelated HEAD~2).
> > >=20
> > > As a workaround I have a `git submodule update` inside `post-
> > > checkout`
> > > hook.
> > >=20
> > > Now, the problem is I still often finding myself having the wrong
> > > submodule ID, and I tracked down that problem to commands such as
> > > `am/rebase/cherry-pick --abort` also not updating the submodule,
> > > nor
> > > executing `post-checkout`.
> > >=20
> > > I looked through `man githooks` but couldn't find any way to
> > > execute a
> > > `git submodule update` during these aborts.
> > >=20
> > > Any ideas how to fix these?
> >=20
> > Are you aware of the `submodule.recurse` config? If set, it should
> > cause
> > git-checkout(1) and many other commands to recurse into submodules
> > and
> > update them accordingly. This should both make your post-checkout
> > hook
> > obsolete and should also work with git-cherry-pick(1) et al.
>=20
> It doesn't seem to work =E2=98=B9 I've set it, and now supposed my top co=
mmit
> changes submodule. So I do a `git rebase -i HEAD~2` and "reword" the
> previous commit. After "reword"ing is done, git returns me back to
> HEAD
> commit and when I execute `git diff` I see the submodule ID changed =E2=
=98=B9

Well, FTR, I just figured out why that happens, but the option being
broken still stands.

So, turns out what happened is that I have `git submodule update` call
in my `post-checkout` hook, which that `submodule.recurse` option
doesn't account for. Unfortunately, if removing it fixes the situation
mentioned above, however git breaks elsewhere: if I know execute "edit"
on the previous commit and use `git diff`, I see the submodule ID in
the changes.

So=E2=80=A6 I guess my initial question still stands: is there any hook to =
fix
the problem of git not updating the submodule upon `git rebase --abort`
and co?
