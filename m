Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB573C1093
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367160; cv=none; b=hgkKrZIKoLP2WLiL4y92TuZMOrJNsp9ArP9leHoSn/350vfX1O/jXK/SSFHtnIFtKILhbhuTWHRkzjj+8cP3ksCl4iuECTNdl7rnrRtkJ018sW0l4+f0iAtIWW4cfqHGSlmWb6vrVjGoa2uEAnsu/q2P15AX8a5RL0QTAnXTtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367160; c=relaxed/simple;
	bh=xYLi4fZeov/dEHO3r6Q6yvGmg7cVVnaepc0ti6Z/6UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIahUJGdt19StKxevrvVbz7fwc6oDrvbZ4VlfA0jMeXxz3YjLp83rD4qB+Wz5A8kkVALFkQTHjwjhgsuKYaBwYWHyjj+A/xlHeaM7rMjmJ01464DX8rDtdOpyPeU9LBaeX2cz1PpBeFLgFLhE1znaJF2rIWiKUmnWP3ga0MkJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tnT3paJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W8q46pk5; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tnT3paJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W8q46pk5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C82981D000B4;
	Mon, 14 Sep 2026 02:25:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 14 Sep 2026 02:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789367157;
	 x=1789453557; bh=cAgiBPPdXd8w/uVkhxrndaBo67Bmcl3wz14Isuep7YU=; b=
	tnT3paJ7M4urB8IRMjihQdBKqNNJ93qllcQhWAHHv13fO5UTpCWGsHRCWhACJC3m
	GNmDMpWsQWbsT498mroITmJvTE93/DXn+jb41GKP+xisp0Iv5U0Zz8bG62qQBEsS
	UtA04I4J3gxSfIphhxvZILiDGz8ViLao4BGHSSZv+HBF58ketk6p3Uy7eqOOzRio
	LnvUpGRvNdejULJoTFAeY5SALDyggnlZ/nj7NP4SfODZu8iD1qKsTWK3Jir4pIIo
	72MtsTqSw7NGbg4sXqRMx6hSpwE2na3J2mR8xpIdSAK3mIY8Fl/ypTrBDVMV7FZi
	raYpTEF1T7O+iByUHRoDbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789367157; x=
	1789453557; bh=cAgiBPPdXd8w/uVkhxrndaBo67Bmcl3wz14Isuep7YU=; b=W
	8q46pk5H+Oe5+FZGrzTB2Mzv9EnFS7DBMe8JZ5sl6EN42kmCKCDzdab7xbOWjklN
	7bT2FMMnXSdrVPZmEp5aS+zD9HN5CvIOT/u0tre/ExnSqPHeNo0Hz0w5acwNEQnh
	nQrB+81JWJZYblxrQaEn4XQNQMk/0gS0U50C+UyvXJh7XkxLhAAFaMdidx9N3+Gz
	CIXqcBtfvO+H93N066alzgKTT5EOlsd8EYAzP/le6fuVAH5MrvcwBuXy2HBBSLym
	iFghk5CcBmiuHb44fCL9VRUEgXEz29O0RvpYUl0aLtftxWL7w6ifjbffI9EXCGK7
	t0z/h2/cMTLgtdoo+XyXQ==
X-ME-Sender: <xms:dZOnatzkHeewjC79HQDY8ytrwGM63KBdtq-oUM_uEKrnfHGzPgNilg>
    <xme:dZOnaksR-rdYtPkXJD_9dk7Ucl6rr_J_GtY8SUYs-4R5vpp9DdGUUfaD8WGODh-_P
    glBumv3NnkGVN222IHSu9iYkVpGv4_kfHXWQQDGuW0CzPZPwlPYow>
X-ME-Received: <xmr:dZOnakvHpDDWbWcdA0uEpbOF1F6wvwFuTYyj8VoC3M7PdRWp-z82qEsE_Kp1a9GI22k1aw>
X-ME-Proxy-Cause: dmFkZTEUf/bQBqD5bvsJiYEtpa06/nOSyDoTt6dgZnOYKDold22MD9NMc02tDGJB/2/lwW
    mA3NUWEYyLb9EfL9L5sEDImtucDkZhley5zfKEVmk2CX6uGQhZP18GSvOhUaOPpqVsbl0S
    IplT9Okg6P7vkf0nkfzE0MgOH3vZETkLZh5YbRyWR9/LkeyUYQ7P3wUhzB6WkZQcCxOQ+2
    7WvHUf724GdeFFPJad3VxUljmWuqPP/kMfyi20U9Z4GZA3Uui8sK2eKrM6xxF6hoMJowLd
    +D96QdLpPrDUznwUaQ1JtSAJt0TJGDEH6e8XQmFUc7PEopySGwHgyrAKEl2JHrqxmojPsZ
    xTVrc2JLJp54Nl8o3QzlJBEeDXd/9XQ6NU32qpq4DgpCIHR90cKmzQ32J2DHD3XwHfdDsk
    BzrvLYf3IwPZvcOKhiK7ea8dPN0RVDGk/elQghkk4fuV8eYvKJol1OJe0VmubZlt9WFytP
    fRUXtROn3ttz+JDOfBNGt/UF6kAUkKgFTQFQ08nwAGJxt+6wxz7ryw9CBGbwP5DIfMboBr
    nft5tZM527b6i19utc0lRoYkPpe6nYbVsv4qz7YCG+DjzCaiWgSQNlH664lifZnXebZj2+
    StTCjXPaIaRlK0fKnRhwEkMZT5s6ArgAr8kbRkByz6OmuQYfF/NczkwJ5Avw
X-ME-Proxy: <xmx:dZOnapPAJG1Hqu2XkER_MrwfUQnAclS7989yCEE39kD9l9VRatL2FQ>
    <xmx:dZOnai2Mj-ltE-0uguxvJdeo4m9oigTMsP_DuK7M8NkrfkT2_mZcbg>
    <xmx:dZOnalOeHLTjzEZekVvHrpPHx5ROSEVx7RzhenF4XB4TmSRYMU_fMQ>
    <xmx:dZOnai0FxcJ4ks10gYvIjietr_4Cb2ItmCUrwW2rYTr0Bat4tnLTQw>
    <xmx:dZOnakLGdARaL6qfm_93ZdobXcDrcO_JoeHDGjbQNoQIZ8y4lglbYYfL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 02:25:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a542c2d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Sep 2026 06:25:55 +0000 (UTC)
Date: Mon, 14 Sep 2026 08:25:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] ci: drop no-op gettext link on macOS
Message-ID: <aqeTas30Vs3aGE9D@pks.im>
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>

On Sat, Sep 12, 2026 at 07:55:39AM +0000, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> gettext ships already linked on the macOS CI runner image, so this
> command never links anything. It only emits a spurious "Already
> linked" warning in every macOS job's log.

I feel like this is oversimplifying things a bit. The commit message
doesn't explain why we even orignially had it, and consequently it's not
really explaining why we don't anymore.

The gettext dependency in Homebrew is keg-only, which means that it will
typically never be linked anywhere visible into your system. Instead, it
is only being installed into your Homebrew cellar, which means that it
will not interfer with anything. And trying to link such a dependency
will not do anything, as Homebrew refuses such an operation.

By using `brew link --force` though you override that and thus override
any system-provided equivalents by symlinking the dependency into a
central place. Now the question is whether this is still needed. But
that question is not answered by your commit message. The warning that
you mention is this one:

  + brew link --force gettext
  ✔︎ JSON API formula_tap_migrations.jws.json
  ✔︎ JSON API cask_tap_migrations.jws.json
  Warning: Already linked: /opt/homebrew/Cellar/gettext/1.0
  To relink, run:
    brew unlink gettext && brew link gettext

But that warning only complains that gettext is already linked into your
cellar. It does not say whether it may have linked the library into your
system's path now.

So I'm still left wondering whether it really isn't required anymore,
and if so why it stopped being required. Links to passing GitHub and
GitLab pipelines with that change would've in this case also helped to
demonstrate that it works without that line.

Thanks!

Patrick
