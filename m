Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DE13D515
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874609; cv=none; b=BBErDcpXvAAImlaNL5SlujFaPRdmb36sPlafMGYvZo4O4xVt9Z5HXgokvDxCLU/e8KvQWeFMV9JmNkRhvEgCO0SyN73t3j4oDvyatYLeD4xgMXwVF4wbvoXgSEtL2HSRFhJfQQ/Nxs+Totel7Z3/e9FrwmP6cOYgh7WM9UN+Tvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874609; c=relaxed/simple;
	bh=//ETGNxGdzQNTm9MSRp0g1kxlR1sVJ+Sxpi7/5Jk7Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLmnHktvMWMkN4lV97SpOg+JEUVUa1cWDJb5TsdHy1vwGQ5HxN7obTda1hb8yYJf+XKvyyC0wRlyJ86rSXhBAxmUQWIjt+Jmh96zENUsvzoP/rbpf/g+PLLo/WGRQ8D3rLgSfun+7wOatSLycTN4z4w9aZEbOShpFMgq0BqgwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n0tqhlu0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OMx5IXA6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n0tqhlu0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OMx5IXA6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n0tqhlu0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OMx5IXA6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n0tqhlu0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OMx5IXA6"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 659C21FCE1;
	Fri,  2 Feb 2024 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706874605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+kIO5YhdWBXCMQ4Hv+OhdHY9dKz6tOeiIvFYvJdUu0=;
	b=n0tqhlu0aDv13fVKvl46orshkLKppmB1yirBZ8nl0GGiPTQY+zw2ORgZD/GUyn4hJHy3io
	vadoFBuIIGxSb0GbfpUtn79h26c6UeMvM0PJF6doP0NVe8Cb5Hfzj0fvq/dqPBF2rnmqPa
	UQzfoh2z7w9zEz9AUpHTDXhGYHb+nVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706874605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+kIO5YhdWBXCMQ4Hv+OhdHY9dKz6tOeiIvFYvJdUu0=;
	b=OMx5IXA64gjalGQ812Rze6kJKNDATjBzcxws7lrEWNFDnTwQnR8VqOUt2C80CqjVvJaUz7
	gjzgtvmeOx4EnFDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706874605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+kIO5YhdWBXCMQ4Hv+OhdHY9dKz6tOeiIvFYvJdUu0=;
	b=n0tqhlu0aDv13fVKvl46orshkLKppmB1yirBZ8nl0GGiPTQY+zw2ORgZD/GUyn4hJHy3io
	vadoFBuIIGxSb0GbfpUtn79h26c6UeMvM0PJF6doP0NVe8Cb5Hfzj0fvq/dqPBF2rnmqPa
	UQzfoh2z7w9zEz9AUpHTDXhGYHb+nVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706874605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+kIO5YhdWBXCMQ4Hv+OhdHY9dKz6tOeiIvFYvJdUu0=;
	b=OMx5IXA64gjalGQ812Rze6kJKNDATjBzcxws7lrEWNFDnTwQnR8VqOUt2C80CqjVvJaUz7
	gjzgtvmeOx4EnFDw==
Date: Fri, 2 Feb 2024 12:50:04 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Hans Meiser <brille1@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <20240202115004.GV9696@kitsune.suse.cz>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
 <Zbx5Xzb3kyHvkp7C@tanuki>
 <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[hotmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 FREEMAIL_CC(0.00)[pks.im,crustytoothpaste.net,hotmail.com,manjaro.org,linuxfoundation.org,vger.kernel.org];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hello,

On Fri, Feb 02, 2024 at 11:15:26AM +0000, Phillip Wood wrote:
> On 02/02/2024 05:10, Patrick Steinhardt wrote:
> > On Fri, Feb 02, 2024 at 01:44:03AM +0000, brian m. carlson wrote:
> > > On 2024-02-01 at 18:36:48, Hans Meiser wrote:
> > [snip]
> > > > In the end, it's all just about git. You may create your own git
> > > > webserver (https://git-scm.com/book/en/v2/Git-on-the-Server-GitWeb),
> > > > or just use an existing one, like the GitLab server:
> > > > https://about.gitlab.com/install/
> > > 
> > > The Git project has tried for a long time to be neutral on any
> > > particular external piece of software.  Installing a GitLab server as
> > > our preferred development platform would promote GitLab as the preferred
> > > forge to other users.  Similarly, moving to GitHub would prefer GitHub
> > > over other forges.  That's not a thing we want to do.
> > > 
> > > We also don't accept patches or features for the benefit of one
> > > particular forge or external project.  Patches and features must be
> > > of general benefit to the project at large.
> > 
> > I think this point is indeed really important in the context of the Git
> > project.
> 
> Agreed, thank you for making it brian. If we did decide to use a forge we'd
> need to be very clear in our decision making that it was selected based on
> the specific needs of this project and was not a general endorsement of one
> product over another. We'd also need to address the important practical
> problems of finding resources to maintain the infrastructure and software to
> run it.

In this context using lore is basically also a forge choice. It is built
on top of git, and expands the functionality of what the project git
repository alone provides.

Unlike most other forge software it is based completely on open
standards such as e-mail headers and git itself, very open and modular,
and does not in any way tie the project git repository to this
additional functionality provided by lore.

This open and separate nature of lore is what makes it the tool of
choice for Linux and git, and any forge that aims to replace lore should
aim at similar level of openness. Of the forges I am aware of only
sourcehut comes close in terms of planned functionality but it's nowhere
near completed as far as I am aware.

Given the open nature of lore it should be feasible to provide
additional interfaces on top of it that cater to people used to PRs
on popular forge web UIs without hijacking the whole project and the
existing tools and interfaces. For some reason people are set on
replacing it as a whole, and removing the interfaces they personally
don't use, calling them obosolete.

In a project with large numger of collaborators with varying backgrounds
that's not going to work well. There are many people working on git
using different workflows, and adding support for new workflow by
removing a number of existing ones will cause problems. The goal of
changing the forge software should be to be more open, supporting more
users with more varying workflows and needs, not less.

Thanks

Michal
