Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E761E50B
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568781; cv=none; b=KiKuMoueo04HcNRow3Z9Oc4HxYzhMSkEGGpKd4TXgN+TGpdW+5FhFRFZsr95oU0oHGzMjyyMkJh27oUSRY1n3tAdeOQpD1kmy3gOLn9PWH0lFnfQ+I3dJqSOimI/wC5GuYKW+aoCh95I2wvPduvHJPYJDV+SuGzaUjnoBPUd2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568781; c=relaxed/simple;
	bh=253//xx08E9NbnaTm+cmly68W44s4KUVqOsIzB0xXA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfzAA9sr5ql1DbbrSulrValGy1acI8EDGhKe2I2/vo4TZLim8OsjMkK4VVnHhi8L6oJM1jJEYjFZZqouyR++rOxkhzHaI5q56Zr8AR6gZn7MQS/yEdINXnl54FHJShCKbhsgmZz5OJ3gqTa5FwxeYetwaMPDCMBGqk5ObQwRJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=mZG8XSkK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="mZG8XSkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1731568772;
	bh=rcCUatGDzx9ZA28EK9O0lUYDtiP0q4EJL5ja6vcz3Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZG8XSkKwtCqjmSH5jUzyyGgU/OmvK0eJfT9Vv1gXSLuAZF9CypFoXZzBQmOTFx7F
	 rQsMFeXJE6FOKKgBuOQNuGYZXuCEMPB4JTg0wR+IKHnQaaLC8dCuBHkWnuzc9Nsg0l
	 I7A0yuELMnPE5+S8kn6U/qWgwZR3z/ECt2YEm6nwaDWiIjnX5QcFPXGGmIVT1ORPmN
	 W3lWbESjLuDZEdG7noTu4IwLoDcDNgGlpQhtmEOl4HCCRAEWApAnAPfvRk+s33HQ+m
	 kSFH1nYzJnxOou8rlnBIsdOsrp6Rtqgmj3OTa88FCpaLV6GlP0F6BbGywawftVGpZT
	 UfpD15JwRS9ZA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4Xps3S11B5z4wxx; Thu, 14 Nov 2024 18:19:32 +1100 (AEDT)
Date: Thu, 14 Nov 2024 18:19:29 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Beat Bolli <dev+git@drbeat.li>,
	Tobias Pietzsch via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Tobias Pietzsch <tobias.pietzsch@gmail.com>
Subject: Re: The health of gitk, was Re: [PATCH] gitk: check main window
 visibility before waiting for it to show
Message-ID: <ZzWkgblaoWehC0kY@thinks.paulus.ozlabs.org>
References: <pull.944.git.git.1610234771966.gitgitgadget@gmail.com>
 <bdaab72b-37f4-658a-716a-d6a958b6f709@drbeat.li>
 <ddee92a7-3d1e-f869-9cc4-72b70eee0dd5@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddee92a7-3d1e-f869-9cc4-72b70eee0dd5@gmx.de>

On Wed, Nov 13, 2024 at 08:41:42AM +0100, Johannes Schindelin wrote:
> Hi Hannes,
> 
> I would like to offer this thread as Exhibit A in support for the case I
> started making at [GitMerge '24](https://git-merge.com/) to convince you
> to consider maintaining gitk in addition to Git GUI.
> 
> Having one maintainer of Git GUI and gitk would make for a quite natural
> fit, I would think, as both are written in Tcl/Tk, neither is used by the
> core Git contributors because they are GUI programs, both lower the bar
> for new Git users because they are GUI programs, and either would be
> subject for eviction from git/git unless maintained by an active
> volunteer.
> 
> From what I see, Git GUI is in real good hands since you took over, I see
> reports and patches picked up quickly and the style of your replies is
> refreshingly constructive and friendly.
> 
> This morning, I woke up to find a new PR in microsoft/git
> (https://github.com/microsoft/git/issues/704) that cherry-picks the patch
> that was offered in this here mail list thread. That patch is almost four
> years old, i.e. just about ready to enter pre-school and to learn how to
> read and write. Yet apart from Beat's confirmation that it fixes a real
> bug, this here patch has been treated with silence.
> 
> Unfortunately, the original GitGitGadget PR had to be locked down and
> therefore Tobias would not be able to send another iteration even if he
> wanted to (which I doubt, given the experience on this mailing list).
> 
> Therefore I see the need not only to revive this thread, but also to look
> for an active gitk maintainer.
> 
> May I ask you, now in public, whether you would be potentially open to
> maintain gitk in addition to Git GUI? If so, I would then start a proper
> new thread to nominate you officially.

If Hannes is willing to take this on, I would support that fully and I
would also be happy to assist.  I know I was extremely slack about
gitk patches for a long while, but I think I have a little more free
time now, having retired.

There is another issue which will need to be sorted out, which is
whether to persist with a separate tree that gets merged into the git
repository, or just edit the copy of gitk in the git repository.
There have been tree-wide patches applied to the git tree which
affected gitk, meaning that my gitk repository is now out of sync.
I recently (as in several weeks ago) sent Junio Hamano an email asking
this question, and asking for his opinion on the best way to proceed
with gitk patches, but got no reply.

Paul.
