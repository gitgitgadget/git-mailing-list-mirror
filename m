Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0A20DD51
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091555; cv=none; b=aHYwmWsl1YROsSl6msgXROIQrWZq4+45NcrEYozTE7NFBkGqDRg/uJwthIGw82FlIldu/mI8nJk0z+W5LkOiP9Frli21GC0+PgtX9+5fwf4v2Av4iMF488iJvwMUu4pHe4dmHnC00RNF4AM27HJAbP7lYOhJX2LbiRKtTJHt2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091555; c=relaxed/simple;
	bh=NOh2dYGMG/WhXl1IlDQs/SR6lz32DkYfNmjUPpTOmdM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nhjp1wRWZniUmQL9z13+5QEPz598Q9c1cu2yO0U8zohTtF/nUc21CHvvc0/cZoPzHffrYo3rHLduhJRvxCinqaEnQG1qrJVJNXOUXT43QONSwNYx7OuzIZOvnSjyArb0SZAXXfEaITPiZh3c5f/o1O7JHC594lr7v0sKgAVdo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Da9I/nGo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Da9I/nGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764091542; x=1764696342;
	i=johannes.schindelin@gmx.de;
	bh=l5LpnpvxyfRGp78wS7ZnGAwpNrgWvxYInVDQMuIe2gM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Da9I/nGoYVVYmDHMQMrBtRVw+W5KuB83HYxAD1dXDQiduaHBdtmZ6kDGeAAMwDXy
	 ytMDr4AujNTVxpQyZe7Sf+KiRp9OAm5UQ7fH16TyIf56xyXUblwZFM+eGygwzxotb
	 hdQcohQhoHPjTL8Cn4Ezn7diXNETPQ2EZVRWv1fN662lUyam9x9Xn44TX72i6u2iR
	 pGoAVSx1a5vTp0r6rLwAJoSIe11jG7v6E5lw1N80UjxKzTTlHuSVVUdvHvQP4Z8xz
	 sjv099Z0cq0Zm0yvjiWlwp/FzzxPuPMVsHpvyPS0Xh2VfuxiqcJ0OotVo2lPq57/R
	 8shEfCqaUEDTlrf4Qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4axq-1vNOIV3bV8-00GJcr; Tue, 25
 Nov 2025 18:25:41 +0100
Date: Tue, 25 Nov 2025 18:25:41 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
    newren@gmail.com, gitster@pobox.com, phillip.wood123@gmail.com, 
    phillip.wood@dunelm.org.uk, karthik.188@gmail.com, code@khaugsbakk.name, 
    rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, 
    johncai86@gmail.com
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit
 changes
In-Reply-To: <20251125170056.34489-1-siddharthasthana31@gmail.com>
Message-ID: <4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eVv4+M8mVM9mvNLSm806yN68W2dZ+GMFkgI4TL9fWNGwwTfVX/W
 1vZQFmJ1d+O3FKHqg2BN3DuajE+uh/DIQd/LE7CwE3VnYQDOSJw0IY4UDLaHXVecIyS7zBD
 FH9lP26ybrKtsx6FaUH4djUQDDwtpaEycpgvJwzT/UKyogBl/vcNlwRKki812TY1D7kdU2A
 thHxSAmDzF7YG2zFykoOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SIeFkvLNgcM=;OM6UAJosJiwhzGpkBiVAHp/eH2u
 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
Content-Transfer-Encoding: quoted-printable

Hi Siddharth,

On Tue, 25 Nov 2025, Siddharth Asthana wrote:

> The `git replay` command currently supports cherry-picking commits for
> server-side history rewriting, but lacks the ability to revert them.
> This patch adds a `--revert` option to enable reversing commits directly
> on bare repositories.
>=20
> At GitLab, we use replay in Gitaly for efficient server-side operations.
> Adding revert functionality enables us to reverse problematic commits
> without client-side roundtrips, reducing network overhead.
>=20
> The implementation leverages the insight that cherry-pick and revert are
> essentially the same merge operation with swapped arguments. By swapping
> the base and pickme trees when calling `merge_incore_nonrecursive()`, we
> effectively reverse the diff direction. The existing conflict handling,
> ref updates, and atomic transaction support work unchanged.

Are you reverting rebased Merge Requests commit by commit? If not, I would
suggest the shortcut to use `merge-tree` directly for the entire Merge
Request. That is, if `$BASE` corresponds to the base branch onto which the
Merge Request was rebased, and `$TIP` corresponds to the Merge Request's
rebased tip commit, then the following will revert that Merge Request:

	git merge-tree --merge-base $TIP HEAD $BASE

The upside is that this can potentially avoid a lot of unnecessary merge
conflicts. The downside is that it does not revert the rebased Merge
Request commit by commit.

The patch itself looks fine to me, if a bit too extensive on the side of
adding tests: Remember, a nimble test suite that catches a bug once is
better than a long-running test suite that would catch a bug several times
_iff_ it didn't tax the developer's patience so much that it is
interrupted and aborted. You probably agree that Git's CI runtimes are
already counter-productively long.

Ciao,
Johannes

> The revert message generation logic is extracted into a new shared
> `sequencer_format_revert_header()` function in `sequencer.c`, allowing
> code reuse between `sequencer.c` and `builtin/replay.c`. The commit
> messages follow `git revert` conventions, including "Revert"/"Reapply"
> prefixes and the original commit SHA.
>=20
> This patch includes comprehensive tests covering various scenarios:
> bare repositories, --advance mode, conflicts, reapply behavior, and
> multiple commits.
>=20
> Siddharth Asthana (1):
>   replay: add --revert option to reverse commit changes
>=20
>  Documentation/git-replay.adoc |  35 +++++++-
>  builtin/replay.c              |  86 ++++++++++++++----
>  sequencer.c                   |  23 +++++
>  sequencer.h                   |   8 ++
>  t/t3650-replay-basics.sh      | 160 ++++++++++++++++++++++++++++++++++
>  5 files changed, 295 insertions(+), 17 deletions(-)
>=20
> --=20
> 2.51.0
>=20
>=20
