Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614101465B4
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300265; cv=none; b=H1KSqdw0Sm1eL5f11s6Ab++I8ELr9uL6Lt72/Ax6+w+pEF9V0Pd2w7b6hjeyDjAEzQSFSoACOq9gCOY9Vh/HIxVCa0dkLcKL4RoJmG6g3kcy1TpUxP479kh14Ixhd6UW1aAgxO/cMKgAgK41wCxPhN9t55Yq5qZ2D0YHaxznH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300265; c=relaxed/simple;
	bh=DrDmMLxSIwt8CPoc4qPNZBhPqHUSDiP6Z8XGRlznOBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCCeZV8f/kA5rQ+8yq/eXAsfwVo+b4RO6NVZnMXlKGqx7vRFbDBvesvQNDUDFiFm7CgZTcsf9xKEYky0Bo0o/4y8JupODTUpYYr1NrsbBE4wybSkpsbF7hg/a+YPewImY9SlKDD/GftdPT6D5bZk39LNsXnTUdPU7SgimDdmHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jyP8z2JR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3w8Bj3ZZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jyP8z2JR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3w8Bj3ZZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jyP8z2JR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3w8Bj3ZZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jyP8z2JR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3w8Bj3ZZ"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15BBB1F7D3;
	Tue, 25 Jun 2024 07:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719300261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEhzwzsEdzBvofgpagf0R/WGEdN2f8pp8CXRxd2DAgs=;
	b=jyP8z2JRcd250q0ykBVmp1bqg1vGKhi5YbflXY/KXm+5o6RTsd0DOSyTwx/OK2HP0M54eZ
	VGw98NevKyt8xclVUiOD8G24fmFipIAtYW4FcyP8i3Jmniyb+TTSC16QD3VVl2oFUV/yo4
	3YCkxskk9J6RsdwbZxGDaGa6+0j5L6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719300261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEhzwzsEdzBvofgpagf0R/WGEdN2f8pp8CXRxd2DAgs=;
	b=3w8Bj3ZZIeO0NpLq9bfCQNKOoU9e5jmE9JgFAfNKZ8NPVwOvZoaCXSlxnBsMs8YVuF3nEj
	d/t7viKUrgT8nICg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719300261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEhzwzsEdzBvofgpagf0R/WGEdN2f8pp8CXRxd2DAgs=;
	b=jyP8z2JRcd250q0ykBVmp1bqg1vGKhi5YbflXY/KXm+5o6RTsd0DOSyTwx/OK2HP0M54eZ
	VGw98NevKyt8xclVUiOD8G24fmFipIAtYW4FcyP8i3Jmniyb+TTSC16QD3VVl2oFUV/yo4
	3YCkxskk9J6RsdwbZxGDaGa6+0j5L6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719300261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEhzwzsEdzBvofgpagf0R/WGEdN2f8pp8CXRxd2DAgs=;
	b=3w8Bj3ZZIeO0NpLq9bfCQNKOoU9e5jmE9JgFAfNKZ8NPVwOvZoaCXSlxnBsMs8YVuF3nEj
	d/t7viKUrgT8nICg==
Date: Tue, 25 Jun 2024 09:24:19 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: "David C. Rankin" <drankinatty@gmail.com>, git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
Message-ID: <20240625072419.GU19642@kitsune.suse.cz>
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g>
 <20240617211513.GM19642@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617211513.GM19642@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Mon, Jun 17, 2024 at 11:15:13PM +0200, Michal Suchánek wrote:
> Hello,
> 
> On Mon, Jun 17, 2024 at 11:47:20AM -0700, Junio C Hamano wrote:
> > "David C. Rankin" <drankinatty@gmail.com> writes:
> > 
> > >   Security enhancement in 2.45.1 have broken ability to serve git over
> > >   https and ssh from local git server running Apache. (web server runs
> > >   as http:http on Archlinux)
> > >
> > >   The fix of adding the following to gitconfig (system-wide and
> > >   per-user in ~/.gitconfig) does not solve the problem:
> > >
> > > [safe]
> > > 	directory = *
> > 
> > It is not clear what you exactly meant "per-user" above, so just to
> > make sure.  Is this set in the global configuration file for the
> > httpd (or whoever Apache runs as) user?
> > 
> > The purpose of "dubious ownershop" thing is to protect the user who
> > runs Git from random repositories' with potentially malicious hooks
> > and configuration files, so the user being protected (in this case,
> > whoever Apache runs as) needs to declare "I trust these
> > repositories" in its ~/.gitconfig file.  What individual owners of
> > /srv/my-repo.git/ project has in their ~/.gitconfig file does not
> > matter when deciding if Apache trusts these repositories.
> 
> 
> looks like the semantic of 'dubious ownershop' changed recently.
> 
> Disro backport of fixes for CVE-2024-32002 CVE-2024-32004 CVE-2024-32020
> CVE-2024-32021 CVE-2024-32465 to 2.35.3 broke git-daemon. No amount of
> whitelisting makes the 'fixed' git serve the repository.

Same regression between 2.45.0 and 2.45.2 which allegedly fixes the
same CVEs.

Looks like downgrading to gaping hole version is needed to serve repositories
in general.

Please consider adjusting the fix so that repositories can still be served.

Thanks

Michal

To reproduce:

cat /usr/local/bin/git-ping
#!/bin/sh -e

# Try connecting to one or more remote repository URLs

while true ; do
        git ls-remote -h "$1" >/dev/null
        shift
        [ -n "$1" ] || break
done

mkdir -p /srv/git/some
chown hramrach /srv/git/some
su hramrach -c "git init --bare /srv/git/some/repo.git"
su hramrach -c "touch /srv/git/some/repo.git/git-daemon-export-ok"
version=2.35.3-150300.10.36.1 ; zypper in --oldpackage git-core-$version git-daemon-$version
systemctl start git-daemon.service
git ping git://localhost/some/repo.git
<nothing>

version=2.35.3-150300.10.39.1 ; zypper in --oldpackage git-core-$version git-daemon-$version
systemctl restart git-daemon.service
git ping git://localhost/some/repo.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.


systemctl status git-daemon.service
● git-daemon.service - Git Daemon
     Loaded: loaded (/usr/lib/systemd/system/git-daemon.service; disabled; vendor preset: disabled)
     Active: active (running) since Thu 2024-06-06 08:29:28 CEST; 6min ago
   Main PID: 31742 (git)
      Tasks: 2 (limit: 4915)
     CGroup: /system.slice/git-daemon.service
             ├─ 31742 git daemon --reuseaddr --base-path=/srv/git/ --user=git-daemon --group=nogroup
             └─ 31749 /usr/lib/git/git-daemon --reuseaddr --base-path=/srv/git/ --user=git-daemon --group=nogroup

Jun 06 08:29:28 localhost.localdomain systemd[1]: Started Git Daemon.
Jun 06 08:29:39 localhost.localdomain git-daemon[31756]: fatal: detected dubious ownership in repository at '/srv/git//some/repo.git'
Jun 06 08:29:39 localhost.localdomain git-daemon[31756]: To add an exception for this directory, call:
Jun 06 08:29:39 localhost.localdomain git-daemon[31756]:         git config --global --add safe.directory /srv/git//some/repo.git

git config --global --add safe.directory /srv/git//some/repo.git
mv ~/.gitconfig /etc/gitconfig
git ping git://localhost/some/repo.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

git config --global --add safe.directory /srv/git/some/repo.git
mv ~/.gitconfig /etc/gitconfig
git ping git://localhost/some/repo.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
