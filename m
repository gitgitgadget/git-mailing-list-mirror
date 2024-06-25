Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F40132127
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340456; cv=none; b=pRCVnmtkbuassLM8SIGKM7VbToasIQ5Pd8iZl5wyk/zLdEZAs/MNI4hxiM3n6Jr4WdMOwLJTxB+i6Cl31DrpXzXGEUgA5pjG+5d1lMh5RRQrpLvxlxdX3Zoits6gV9fADg8CdiL1OFP81Hymi3tDi/ju8c7g55xVgTMDFcFIikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340456; c=relaxed/simple;
	bh=a0wYSuwVxkEbngB/c4OuM3TxfYF/9E5ra5NkC7S23OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4g2GF9cZNMM0BmXx1itajyoNIJhmgtZid8snXKsLHyOjn2k1KlEgTf5zzs9xmHl/Q93FZXID2cd9Wiv2X1uV+Ra3Ic/jcQt2hle3w1RMTCbFpQxWP9Xw9zPdmfFgYzELVY6YU4Efx59eO1tE2atuLd3vsuSC7bEfwzgwcSOPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wjrW0TES; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r8crNlb5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wjrW0TES; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r8crNlb5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wjrW0TES";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r8crNlb5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wjrW0TES";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r8crNlb5"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A7C7218F6;
	Tue, 25 Jun 2024 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719340452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0owWzJ4hA5fP+jbx8sWetXfS9MXfC3MnDnrzECA77XA=;
	b=wjrW0TESUR1LNN1V38gYSx+1Cibk1Z8VU8hvcwGZ5oNpluSyXrtdbga5/ZBe2TKYbSxWGk
	8bhuIRRlvwfdotz+rZuOOU26PnIjdHfP+jtKUFH2TsLzTtTxNrpOclEfVkjHycpTrtNart
	cIcbH2C3lXWvXqqTDG1jW+sTF40VkQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719340452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0owWzJ4hA5fP+jbx8sWetXfS9MXfC3MnDnrzECA77XA=;
	b=r8crNlb5qzw7kAUIF0dmlEwD9w0GXI17Tyr5QBtt8BHRdQiz5mEvKqvmH8b6bZW/ZumK8E
	VDJeYghvt9cz3NBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719340452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0owWzJ4hA5fP+jbx8sWetXfS9MXfC3MnDnrzECA77XA=;
	b=wjrW0TESUR1LNN1V38gYSx+1Cibk1Z8VU8hvcwGZ5oNpluSyXrtdbga5/ZBe2TKYbSxWGk
	8bhuIRRlvwfdotz+rZuOOU26PnIjdHfP+jtKUFH2TsLzTtTxNrpOclEfVkjHycpTrtNart
	cIcbH2C3lXWvXqqTDG1jW+sTF40VkQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719340452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0owWzJ4hA5fP+jbx8sWetXfS9MXfC3MnDnrzECA77XA=;
	b=r8crNlb5qzw7kAUIF0dmlEwD9w0GXI17Tyr5QBtt8BHRdQiz5mEvKqvmH8b6bZW/ZumK8E
	VDJeYghvt9cz3NBA==
Date: Tue, 25 Jun 2024 20:34:11 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"David C. Rankin" <drankinatty@gmail.com>, git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
Message-ID: <20240625183411.GW19642@kitsune.suse.cz>
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g>
 <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz>
 <xmqqr0cl6lxl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr0cl6lxl.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_ENVRCPT(0.00)[gmx.de,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmx.de,gmail.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

Hello,

On Tue, Jun 25, 2024 at 09:12:38AM -0700, Junio C Hamano wrote:
> Dscho, the f4aa8c8b (fetch/clone: detect dubious ownership of local
> repositories, 2024-04-10) is your brainchild and people seem to be
> unhappy about having to adjust their settings.  Are there any advice
> you can offer them?

while I am somewhat unhappy about the need to adjust settings this is
not really about that.

It is undesirable to implement breaking changes, especially in point
release. At the same time it's sometimes necessary, and if the change
is announced, documented, and actually works it can be acceptable.

Here git-daemon requests that repository be added to list of safe
repositories to be able to serve it. Clearly this is a security
requirement. A user that has write access to a repository can touch the
export-ok file, and then the daemon would potentially serve the
repository under some circumstances, potentially exposing the system
administrator to some other things that the user did to the repository.

Adding the repository to the list of safe repositories is a known
concept that was already required for gitweb and for working with the
repository locally, and applying it to git-daemon as well is consistent
although it does require configuration changes for some users.

The real problem here is that adding the repository to the list of safe
repositories does not make it possible to serve it by git-daemon.

Thanks

Michal


> 
> Michal Suchánek <msuchanek@suse.de> writes:
> 
> > On Mon, Jun 17, 2024 at 11:15:13PM +0200, Michal Suchánek wrote:
> >> Hello,
> >> 
> >> On Mon, Jun 17, 2024 at 11:47:20AM -0700, Junio C Hamano wrote:
> >> > "David C. Rankin" <drankinatty@gmail.com> writes:
> >> > 
> >> > >   Security enhancement in 2.45.1 have broken ability to serve git over
> >> > >   https and ssh from local git server running Apache. (web server runs
> >> > >   as http:http on Archlinux)
> >> > >
> >> > >   The fix of adding the following to gitconfig (system-wide and
> >> > >   per-user in ~/.gitconfig) does not solve the problem:
> >> > >
> >> > > [safe]
> >> > > 	directory = *
> >> > 
> >> > It is not clear what you exactly meant "per-user" above, so just to
> >> > make sure.  Is this set in the global configuration file for the
> >> > httpd (or whoever Apache runs as) user?
> >> > 
> >> > The purpose of "dubious ownershop" thing is to protect the user who
> >> > runs Git from random repositories' with potentially malicious hooks
> >> > and configuration files, so the user being protected (in this case,
> >> > whoever Apache runs as) needs to declare "I trust these
> >> > repositories" in its ~/.gitconfig file.  What individual owners of
> >> > /srv/my-repo.git/ project has in their ~/.gitconfig file does not
> >> > matter when deciding if Apache trusts these repositories.
> >> 
> >> 
> >> looks like the semantic of 'dubious ownershop' changed recently.
> >> 
> >> Disro backport of fixes for CVE-2024-32002 CVE-2024-32004 CVE-2024-32020
> >> CVE-2024-32021 CVE-2024-32465 to 2.35.3 broke git-daemon. No amount of
> >> whitelisting makes the 'fixed' git serve the repository.
> >
> > Same regression between 2.45.0 and 2.45.2 which allegedly fixes the
> > same CVEs.
> >
> > Looks like downgrading to gaping hole version is needed to serve repositories
> > in general.
> >
> > Please consider adjusting the fix so that repositories can still be served.
> >
> > Thanks
> >
> > Michal
> >
> > To reproduce:
> >
> > cat /usr/local/bin/git-ping
> > #!/bin/sh -e
> >
> > # Try connecting to one or more remote repository URLs
> >
> > while true ; do
> >         git ls-remote -h "$1" >/dev/null
> >         shift
> >         [ -n "$1" ] || break
> > done
> >
> > mkdir -p /srv/git/some
> > chown hramrach /srv/git/some
> > su hramrach -c "git init --bare /srv/git/some/repo.git"
> > su hramrach -c "touch /srv/git/some/repo.git/git-daemon-export-ok"
> > version=2.35.3-150300.10.36.1 ; zypper in --oldpackage git-core-$version git-daemon-$version
> > systemctl start git-daemon.service
> > git ping git://localhost/some/repo.git
> > <nothing>
> >
> > version=2.35.3-150300.10.39.1 ; zypper in --oldpackage git-core-$version git-daemon-$version
> > systemctl restart git-daemon.service
> > git ping git://localhost/some/repo.git
> > fatal: Could not read from remote repository.
> >
> > Please make sure you have the correct access rights
> > and the repository exists.
> >
> >
> > systemctl status git-daemon.service
> > ● git-daemon.service - Git Daemon
> >      Loaded: loaded (/usr/lib/systemd/system/git-daemon.service; disabled; vendor preset: disabled)
> >      Active: active (running) since Thu 2024-06-06 08:29:28 CEST; 6min ago
> >    Main PID: 31742 (git)
> >       Tasks: 2 (limit: 4915)
> >      CGroup: /system.slice/git-daemon.service
> >              ├─ 31742 git daemon --reuseaddr --base-path=/srv/git/ --user=git-daemon --group=nogroup
> >              └─ 31749 /usr/lib/git/git-daemon --reuseaddr --base-path=/srv/git/ --user=git-daemon --group=nogroup
> >
> > Jun 06 08:29:28 localhost.localdomain systemd[1]: Started Git Daemon.
> > Jun 06 08:29:39 localhost.localdomain git-daemon[31756]: fatal: detected dubious ownership in repository at '/srv/git//some/repo.git'
> > Jun 06 08:29:39 localhost.localdomain git-daemon[31756]: To add an exception for this directory, call:
> > Jun 06 08:29:39 localhost.localdomain git-daemon[31756]:         git config --global --add safe.directory /srv/git//some/repo.git
> >
> > git config --global --add safe.directory /srv/git//some/repo.git
> > mv ~/.gitconfig /etc/gitconfig
> > git ping git://localhost/some/repo.git
> > fatal: Could not read from remote repository.
> >
> > Please make sure you have the correct access rights
> > and the repository exists.
> >
> > git config --global --add safe.directory /srv/git/some/repo.git
> > mv ~/.gitconfig /etc/gitconfig
> > git ping git://localhost/some/repo.git
> > fatal: Could not read from remote repository.
> >
> > Please make sure you have the correct access rights
> > and the repository exists.
