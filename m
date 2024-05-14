Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0017EBA5
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713667; cv=none; b=BB1hfpR0eFV5bnEMwWDxDjOa7lmvZYQAoD9bQKBK8l/8p5vjAR7HSAvmVR90Hyu7rb3+8GvUSfe+I14x6v6n1M2iTHHmqXhnol/ciAvtet6ipXT1Qn06XNfCRzSha8dI8kfROlLInVDzwYaN9hXnl3ww9MMvlhd5RzCDq6JLj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713667; c=relaxed/simple;
	bh=wCmgEBaiYvSwsTi2NXOhfNskWNUjjvwgCH0hNxvEU0A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gWf1P5aZiVBNwIFLn2Foim2dMQx4Hp6qGNt0ItMN7FCZabiSQpnOjTcvuWzbwMRYVps4J4Wouvyxd2kqhb2B4vF6TsFHl57Vxs4ubQhE/XP0IV8bWOb55pX1zmrBpPuu4c6vL6av+HsbNM9IhH1CBJa1n7I0zNrNg/vA+kPxghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=SQRuNVPv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="SQRuNVPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715713650; x=1716318450;
	i=johannes.schindelin@gmx.de;
	bh=OsPTRV1N2J8uQLWTHcDNE2Yvsf5EAQVduFmafp+DaPM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SQRuNVPv9sqYJ1rw5qaYTSTUQpHy1rKxXdtjzfWFONYyaBrqz8+uSU/OaCM0HwHe
	 SxWWEk08bvIcjqy2+RhQtS/XUWewdGO27ZutoU0GwOdnEoKecigkKPG5jaY1Ex466
	 H78WE6Bb3V+MqVIMebTV5uGJRYKvHHKHR7GgxvOj95381GEBnJZ634+d2jfjJMd4d
	 5moK7DnzLPTtHmiVHrcr7hCvNrHirnMHhOz+P0XNBDVLOXDIBTePg29SpB2NU/exS
	 E0NsF+Fzm1XP+paJrkO10HlWdu0DkXbA6T9R5AWdvsqUYOEORSknTw2k5hqiFGky3
	 o/RL/CGzv4wOBuPDUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTNF-1rudGx0gdx-00NSJM; Tue, 14
 May 2024 21:07:30 +0200
Date: Tue, 14 May 2024 21:07:28 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
In-Reply-To: <20240514181641.150112-1-sandals@crustytoothpaste.net>
Message-ID: <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zfBLJBk3o0UVcgDWihZj1VMfMJNVu+CGUmkQZnnAx0r6sqoQZLv
 nCYAtKDyl7QCSEqDxbYMNelbq/LF4FoidnesCHFDFXYL2k0umamqCx0QmsLNPx0GnPijgm+
 HLaatm9+yB1glKPzg898IYWKJ/yMIomshZmDQZypJR5WXyhUXhWDd1x83F7FAmqEZl6B1n5
 53VJJv10ue+o3vMJKwRnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9RJo8mlYc0s=;1OEeYK5SfcKFIl4kEJoKsZK+70+
 8T7lmkBVi/UGiSeClnGP2+GVR5JdzMoCC32JD2LI09N5ZdtmujH7r+xMB8f8DM9CFFw8XkTPq
 Gs4DvkMk6YiVfHprUXXHHgsowWFPCAWNxLy7h9Q0dqvRUVMje4ZYK/ys0Z0wDLtDieu6rSKbu
 IiSAJFezSRYSX5h6W1cchFpyk/zNFQ5v4ehBgk6SYjK7cuU49qsbWH0GeFO7Ra/Pb6OZ4y5zu
 iiJLfBUOHcSYOFx+CyOsH3YjY2Nd8pd8otC/XGmh4z3o7q7NDEyBTnwmL/nT5x1IfxoTneR0N
 qHHrJ3xcxRSbAvQ65nURkwMUi6qLxK8hpDeMQ+JLoI5IGv35qU5zFNwjFuNuWJQGuyd/aplap
 std80fZjMHAK8txz66SDDLiEHvkIzMwNUs/PaoyLJS8g6+Il2qR+9eAowIvg127PQYNDfMtGL
 t7EwmAgdVxJV4QqFTcP2udQ3mXwqb3GvHtAvgTwZ0iQeRJIakd+FTKi9FjS0pBnNqI7M9I19t
 SCZJvAHYubtvkp7HfNhwVTzFGvd1DY6VJIqdjeC1p8fjphVf74PJZA7WQK7YQq8Y5Jd/fzrAn
 ZdHLN/fjKYG9Fb3+jY9D1jpK0Y7R37eUlMbDhaR/Ef2+YKKvAqJc3R9asgfB61A1Kz06gUIK/
 FOkRYsrzuqDzCN23B+KLn3phQ86eES/hDCkIfJ8pa6EA2ZBwYVGxRujCi7lXqTx2drlL0fC5f
 jZy3wmhG24SmbVzsqjVSGQBski7+wcXnIWgSCQ62LxGfMdmNUuV0t8WwCBGdBzwDuudwItKpd
 7Ktu25sRTS+vkJYQITCIxDuw9zFSALUvC6gQTJUFcocyM=
Content-Transfer-Encoding: quoted-printable

brian,

On Tue, 14 May 2024, brian m. carlson wrote:

> The recent defense-in-depth patches to restrict hooks while cloning
> broke Git LFS because it installs necessary hooks when it is invoked by
> Git's smudge filter.  This means that currently, anyone with Git LFS
> installed who attempts to clone a repository with at least one LFS file
> will see a message like the following (fictitious example):
>
> ----
> $ git clone https://github.com/octocat/xyzzy.git
> Cloning into 'pull-bug'...
> remote: Enumerating objects: 1275, done.
> remote: Counting objects: 100% (343/343), done.
> remote: Compressing objects: 100% (136/136), done.
> remote: Total 1275 (delta 221), reused 327 (delta 206), pack-reused 932
> Receiving objects: 100% (1275/1275), 290.78 KiB | 2.88 MiB/s, done.
> Resolving deltas: 100% (226/226), done.
> Filtering content: 100% (504/504), 1.86 KiB | 0 bytes/s, done.
> fatal: active `post-checkout` hook found during `git clone`:
>         /home/octocat/xyzzy/.git/hooks/post-checkout
> For security reasons, this is disallowed by default.
> If this is intentional and the hook should actually be run, please
> run the command again with `GIT_CLONE_PROTECTION_ACTIVE=3Dfalse`
> warning: Clone succeeded, but checkout failed.
> You can inspect what was checked out with 'git status'
> and retry with 'git restore --source=3DHEAD :/'
> ----
>
> This causes most CI systems to be broken in such a case, as well as a
> confusing message for the user.

When using `actions/checkout` in GitHub workflows, nothing is broken
because `actions/checkout` uses a fetch + checkout (to allow for things
like sparse checkout), which obviously lacks the clone protections because
it is not a clone.

> It's not really possible to avoid the need to install the hooks at this
> location because the post-checkout hook must be ready during the
> checkout that's part of the clone in order to properly adjust
> permissions on files.  Thus, we'll need to revert the changes to
> restrict hooks while cloning, which this series does.

Dropping protections is in general a bad idea. While previously, hackers
wishing to exploit weaknesses in Git might have been unaware of the
particular attack vector we want to prevent with these defense-in-depth
measurements, we now must assume that they are fully aware. Reverting
those protections can be seen as a very public invitation to search for
ways to exploit the now re-introduced avenues to craft Remote Code
Execution attacks.

I have pointed out several times that there are alternatives while
discussing this under embargo, even sent them to the git-security list
before the embargo was lifted, and have not received any reply. One
proposal was to introduce a way to cross-check the SHA-256 of hooks that
_were_ written during a clone operation against a list of known-good ones.
Another alternative was to special-case Git LFS by matching the hooks'
contents against a regular expression that matches Git LFS' current
hooks'.

Both alternatives demonstrate that we are far from _needing_ to revert the
changes that were designed to prevent future vulnerabilities from
immediately becoming critical Remote Code Executions. It might be an
easier way to address the Git LFS breakage, but "easy" does not equal
"right".

I did not yet get around to sending these patches to the Git mailing list
solely because I am still busy with a lot of follow-up work of the
embargoed release. It was an unwelcome surprise to see this here patch
series in my inbox and still no reply to the patches I had sent to the
git-security list for comments.

I am still busy wrapping up follow-up work and won't be able to
participate in this here mail thread meaningfully for the next hours. I do
want to invite you to think about alternative ways to address the Git LFS
issues, alternatives that do not re-open weaknesses we had hoped to
address for good.

I do want to extend the invitation to work with me on that, for example by
reviewing those patches I sent to the git-security mailing list (or even
to send them to the Git mailing list for public review on my behalf, that
would be helpful).

Ciao,
Johannes
