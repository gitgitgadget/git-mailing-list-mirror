Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D8C306482
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952331; cv=none; b=c3lDUty39KBELX8QHSu/Ra/oIzpoSVd0LVGJsJUXAEmmP9z27efGX9lM1xLnHAZTVX5AaKU0ru0Gccg682n/EyzR7+cVFSWmzSl23BndRVbSy0HTH2AMakz1JNDPgF+kiDWbcLK/xWlozuv6fefiUUWQ1+b2TH7XcTf1mIHL+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952331; c=relaxed/simple;
	bh=6Ne8jxMcTWPXvmn5OMXSj81CvLQxFvNKG3Lkle18TIU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=pZF2WZ/UbhVH9xGJzHzcTE7Ef+NqtClfyMUkUzQuO+8drqgVD+BwTsre4whvol+cvVmCy4JsDDNvo3ITet7W0kZHIsZQph6iRsC0wHwnV9E/Yx+yVx1BRdqyQMBkkLNhBVYtchYGmLOS2LhjidzQwWGUrTkGAsJQ5nU46S2Pqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V3RD49eb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V3RD49eb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V3RD49eb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V3RD49eb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF9871F453;
	Wed, 12 Nov 2025 12:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762952326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Ne8jxMcTWPXvmn5OMXSj81CvLQxFvNKG3Lkle18TIU=;
	b=V3RD49ebnvYXKNDAOznakvhzJ+TVvUvk9nu7LkKfNTgwrqt4bx4OhHkQOWKKIf5T5hgGaW
	jLNWkJ+O0UNW1J2I+40rG1MW/7QSFJDhSieTviJ0g0gHKEZFRXQarMzCN063o2x51NGBrp
	SDVy0rHolZzJSgbaVIydp6IBx1+wrYQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762952326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Ne8jxMcTWPXvmn5OMXSj81CvLQxFvNKG3Lkle18TIU=;
	b=V3RD49ebnvYXKNDAOznakvhzJ+TVvUvk9nu7LkKfNTgwrqt4bx4OhHkQOWKKIf5T5hgGaW
	jLNWkJ+O0UNW1J2I+40rG1MW/7QSFJDhSieTviJ0g0gHKEZFRXQarMzCN063o2x51NGBrp
	SDVy0rHolZzJSgbaVIydp6IBx1+wrYQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4FC33EA61;
	Wed, 12 Nov 2025 12:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nk7kJoaEFGmlVAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Wed, 12 Nov 2025 12:58:46 +0000
Message-ID: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
Subject: git fails to checkout SHA1 submodule in SHA256 repo with --depth=1
From: Martin Wilck <mwilck@suse.com>
To: git@vger.kernel.org
Cc: Adrian Schroeter <adrian@suse.com>
Date: Wed, 12 Nov 2025 13:58:46 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

> What did you do before the bug happened? (Steps to reproduce your
issue)

# This is a SHA256 repository with a SHA1 submodule=20
git clone -b next https://src.opensuse.org/mwilck/multipath-tools

cd multipath-tools
git submodule init

# Submoudle URL: https://github.com/openSUSE/multipath-tools,=C2=A0
# branch "next
git submodule update --depth 1

> What did you expect to happen? (Expected behavior)

Successful checkout of the submodule.

> What happened instead? (Actual behavior)

The following error:

fatal: couldn't find remote ref 37f9a4c9c4658da7f9b2b0345836360d2fb119a0000=
000000000000000000000
fatal: Fetched in submodule path 'multipath-tools', but it did not contain =
37f9a4c9c4658da7f9b2b0345836360d2fb119a0000000000000000000000000. Direct fe=
tching of that commit failed.

> What's different between what you expected and what actually
happened?

It failed.

> Anything else you want to add:

"git submodule update" (without --depth 1) succeeds.

The problem occurs whether or not I use "git submodule set-branch" to
select the correct remote branch before running "git submodule update".
Neither the "branch" setting in .gitmodules nor in .git/config seems to
matter.

The problem seems to be that "git submodule update --depth 1" fetches
the remote HEAD only, even if submodule.<name>.branch is set to
something different (here: "next"). (In my case, HEAD was not an
ancestor of the desired branch ("next"), nor vice-versa).

I found the following workaround to fetch the desired commit:

SUBMODULE=3Dmultipath-tools
SHA=3D$(git -C $SUBMODULE ls-remote origin | awk '/refs\/heads\/next/ { pri=
nt $1; }')
git -C $SUBMODULE fetch --depth=3D1 origin next
git -C $SUBMODULE reset --hard $SHA

but that's not the desired solution, because the checkout needs to be
scripted. Ultimately I want to run
"git clone --recurse-submodules --depth 1", which currently fails as
well.

A plain "git clone" of the submodule works as expected:

git clone -b next --depth=3D1
https://github.com/openSUSE/multipath-tools.git

In a SHA1 repository, all these operations seem to work as one would
na=C3=AFvely expect. (I was using different repositories though, I currentl=
y
don't have a SHA1 clone of the SHA256 repo I experimented with).

[System Info]
git version:
git version 2.52.0.rc1.458.g3549877.dirty
cpu: x86_64
built from commit: 3549877a16bc196d0d99bc2f8441eedf0102fcc8
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
libcurl: 8.14.1
OpenSSL: OpenSSL 3.1.4 24 Oct 2023
zlib: 1.2.13
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.4.0-150600.23.70-default #1 SMP PREEMPT_DYNAMIC Wed Sep
10 10:54:24 UTC 2025 (225af75) x86_64
compiler info: gnuc: 7.5
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
