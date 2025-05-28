Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241516AD3
	for <git@vger.kernel.org>; Wed, 28 May 2025 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466463; cv=none; b=uNOB0HdK2chuwvn92yO4Seg12j10WstJJvUQbPUKI/JKOXC0KiE/BcBoux2tMuIy2OEZ+uqAv4kiR3q/4bYkGOyFDPji8h77InbNwgy0a3a+3CLP3hdAfTq1OIusNzszGJlfRO2qB5r8/11liJgAlUTJcNavPX3SNE9TYADRXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466463; c=relaxed/simple;
	bh=rAFhX/J8ZeU4jEH6DWvrstryoGmMkzfNl6t0fvrvOas=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEpUZY3YUvw2RXHDpQyWE1w38W09Lr4mHSFF/0HZEQa7fQ34TVF3C/pxp38XUX/auJY6wa/Tuet1HkS5zTWbx0kfNE5aKqYws5IiCv4DUw+wGF2Lz+FXCikHrVQJDt4N/XUTc9SPcIK5eV9rlFwvulLvknqZrY1V6fBdbzxZx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=R5fvk/fM; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="R5fvk/fM"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 598A3DF990F
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:01:41 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id B931B13F8AD;
	Wed, 28 May 2025 23:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1748466093;
	bh=rAFhX/J8ZeU4jEH6DWvrstryoGmMkzfNl6t0fvrvOas=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R5fvk/fM8/lFzhsqoruACbsCm/GulG36/M9ihgb6g/3vEBWz8GkjPUclv0Nipr3eR
	 NEcxiTGZ2KospIaMComY43Lv8dGDAnwi1/O3cWw3WBVMoV1sRuq44L4RjMpt9arMSy
	 NO0R7WbuHPOHCbhZt3uyt46865/AZntFl3IQVZ6pwcWgyZId2J4BW02YXj6MTwX/zj
	 luJjUa5QV7djwQ+pUvJ9S1xl+3Ee42DkD01SgD7Bfs2+YLwfqQPEYyYoaSa2kFQjOG
	 xCx/ybl+6lCO6fCSePFxCwrisVNq62hly0RKhR74AMrqNf/lj2evlh/Jy4irwXXjrG
	 o+7f+mb4RuCpg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2025, #08; Tue, 27)
Date: Wed, 28 May 2025 23:01:32 +0200
Message-ID: <12673686.O9o76ZdvQC@cayenne>
In-Reply-To: <xmqqfrgptv10.fsf@gitster.g>
References: <xmqqfrgptv10.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 28 May 2025 02:54:03 CEST Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen', and
> aren't considered "accepted" at all and may be annotated with an URL
> to a message that raises issues but they are no means exhaustive.  A
> topic without enough support may be discarded after a long period of
> no activity (of course they can be resubmit when new interests
> arise).
> 
> Copies of the source code to Git live in many repositories, and the
> following is a list of the ones I push into or their mirrors.  Some
> repositories have only a subset of branches.
> 
> With maint, master, next, seen, todo:
> 
> 	git://git.kernel.org/pub/scm/git/git.git/
> 	git://repo.or.cz/alt-git.git/
> 	https://kernel.googlesource.com/pub/scm/git/git/
> 	https://github.com/git/git/
> 	https://gitlab.com/git-scm/git/
> 
> With all the integration branches and topics broken out:
> 
> 	https://github.com/gitster/git/
> 
> Even though the preformatted documentation in HTML and man format
> are not sources, they are published in these repositories for
> convenience (replace "htmldocs" with "manpages" for the manual
> pages):
> 
> 	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
> 	https://github.com/gitster/git-htmldocs.git/
> 
> Release tarballs are available at:
> 
> 	https://www.kernel.org/pub/software/scm/git/
> 
> --------------------------------------------------
> [New Topics]
> 
> * ja/doc-synopsis-style (2025-05-27) 9 commits
>  - doc: convert git-switch manpage to new synopsis style
>  - doc: convert git-mergetool options to new synopsis style
>  - doc: convert git-mergetool manpage to new synopsis style
>  - doc: switch merge config description to new synopsis format
>  - doc: convert merge strategies to synopsis format
>  - doc: merge-options.adoc remove a misleading double negation
>  - doc: convert merge options to new synopsis format
>  - doc: convert git-merge manpage to new style
>  - doc: convert git-checkout manpage to new style
> 
>  Doc mark-up fixes.
> 
>  Will merge to 'next'?
>  source: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
> 

Junio, I haven't seen your series about git-verify-* and others integrated. 
Are there any remaining points to be fixed?

Thanks,

JN


