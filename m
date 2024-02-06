Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1F7F460
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204426; cv=none; b=J6kO6jM+f9q2EoxOqFSeXJMcujD9MBuDvRCAzi8GXW8wXnfXJ8VdTDO1cw+6fFzQv2O4UHJBvieIuZc60w+Eg2oUQw8+EUew94fAnbXF4um0+F2BMBigx69NhPqYrno708w8DsRE2Id80+P44Y7otkl/MfKeNQH98IV0p51Z6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204426; c=relaxed/simple;
	bh=WReHO0uFqkxpByKhnAfJtpRTypOIozWcsh1cYafoCAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=cfLIcMnqxldPwKAFvyqDj4i19Bf9vKrVEmtPK0L6H5zu9GKqCkNeZLDxG0Y1BBGw+oRCKudN+iomNOfR2wDwbASRim+oDy3wngK+oKc3WifRNhwjxOVlkhL+9NuN2a8vVDQWdo/TRWulAlB7CUy33YMl/LgoaQt4PhJ7+FNzZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4TTYmb0Bh7z5wTn
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:50:54 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4TTYmQ6XY3z5tlC;
	Tue,  6 Feb 2024 07:50:46 +0100 (CET)
Message-ID: <993e6823-7fa7-4130-8c0a-69ed31da5fbe@kdbg.org>
Date: Tue, 6 Feb 2024 07:50:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-gui desktop launcher
To: Tobias Boesch <tobias.boesch@googlemail.com>
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.02.24 um 21:12 schrieb Tobias Boesch:
> Hello everyone,
> 
> quoting from downstream issue:
> https://gitlab.archlinux.org/archlinux/packaging/packages/git/-/issues/5
> 
> -------------------------
> 
> "As far as I can see git gui cannot easily be used by me on arch.
> A .desktop entry is missing for me.
> I created one that opens git gui.
> It also adds an entry in the "Open With..." menu of file managers (I
> tested only with Nautilus). Opeing git gui with this entry git gui is
> opened in the folder where the menu was opened.
> If it is a git repository git gui open it. If it is no git repository
> git gui opens just as if it was called from the desktop launcher.
> Since it took a while to create it and adds value for me I would like
> to share it to be added to the git package by default.
> It is far from being perfect. It's a first working version. For me
> personally it is enough.
> Before tweaking it further to fit the packaging standards I would like
> to ask if is desired to be added.
> 
> .desktop file proposal

Thank you, this is certainly helpful. To get a .desktop file accepted,
you would have to submit it in patch form. Additionally, since there is
a dependence on the install location, it must be included in the build
process.

> 
> [Desktop Entry]
> Name=git gui

When I launch the program on my openSUSE desktop, the titlebar uses the
name "Git Gui". IMO, that would make it more consistent.

> Comment=A portable graphical interface to Git

I have two gripes with this Comment:

- That the program is portable is irrelevant for the user. The word need
not occur in this Comment.

- I had hoped for a more precise description. In particular, when a
program is advertised as "graphical interface to Git", then I would
expect that it can do a bit more than initialize repositories and make
commits. At a minimum, I would expect a history viewer; but Git Gui
doesn't have one. Unless you count the two "Visualize" entries in the
"Repository" menu that invoke gitk as such. So, I dunno.

> Exec=/bin/bash -c 'if [[ "$0" = "/bin/bash" ]]; then git gui; else cd
> "$0" && git gui; fi' %F
> Icon=/usr/share/git-gui/lib/git-gui.ico
> Type=Application
> Terminal=false
> Categories=Development;
> 
> 
> I think upstream has any interest to add this. Therefore I ask here."
> 
> -------------------------
> 
> The arch package maintainer proposed to try to to add this to upstream
> before just putting it into the arch package.
> Here I am asking if it could be added to git.
> 
> If it's worth to add it, I would take the time to improve it if there
> are suggestions or comments on the current version.
> 
> Best wishes and thanks for developing git.
> Tobias

-- Hannes

