Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E52673AF
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386186; cv=none; b=l3QBjKvd8BlqGpFFpZZKGshWzI7RT4tPJagQKIAB2CbEd+Hu+BR9Hev5WINv+mtCn3nh3jkmxsHsM8nTSzsrJJBp/2i5S66HffIHV6CRNtkQOwR/crSlasmZJE4efgxkLxLlPfDJ01F0rJ+sgC/Z8Bie3yOSuCEdATN+ighI79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386186; c=relaxed/simple;
	bh=XZi0WZAODhP9SOm/AjJXHJ2wnQAVAGxlMbwApGIowiM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t+K5SNSe9mswefEW9KIioHLRJ5AvXQRhSOm0MuP6bGxztWVxwmvjUhNQzF1eP25AXo1Zzat5oM3ICynb2VdoeiLfOZA05QD5OGD9H0E7MkHp5x2mfg4mkVE1fkFIY0HA+0hZOyPwBgbMKrXDmwiRR3mRi0o/2YaZJrCslxkgCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=DICiAlQ8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="DICiAlQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763386175; x=1763990975;
	i=johannes.schindelin@gmx.de;
	bh=TSJvMxuUa1bSnirZOt0yBy8Fi49j2B0Lb6sMcGmtF+s=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DICiAlQ8l7ogCAPmgNadnONfo/CTYzaucTysIYZriVqMspdff/flMFy2XI3g4m7b
	 dvPLwFJ+t1GWO1kgqhTrtqRq/+Hd9EL/wattlVgKGD2J73veZtrNuJ/1Y8/hZn76K
	 SBuztxDw2UJvmpjrEo4s/eUi2RlpTxCeqtO7NqQUhTqRI1MoVDCNoPxWXJYnS27t/
	 b1YCEmpNh42yPf7mg2xxhYYM9FQ3/+iw5P4bDTjhzaUBO31/80E0RZSPbfqmnEAFS
	 K1s7IUHuTx9AH7cQaQ1i5U9rcOhfJjkgges4IKaq4MvEsanfUROEqIDqjzNXt8nFh
	 Zxikzc6MOg/wJ58a1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.224]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1vhJWa2UGl-00OYmt; Mon, 17
 Nov 2025 14:29:35 +0100
Date: Mon, 17 Nov 2025 14:29:33 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Delilah Ashley Wu via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Delilah Ashley Wu <delilahwu@microsoft.com>, 
    Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
    Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Subject: Re: [PATCH/RFC 0/4] config: read both home and xdg files for
 --global
In-Reply-To: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
Message-ID: <8e2b868d-8753-bbcd-840c-8eaefaa7cbd1@gmx.de>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ccoxx7wIGDFhvzMPxjr0Y9CHGld/dxVraUDnxehPmQCYiNuULe4
 +rHiYV3TqUWqgiAfZ1jpcobPCoiWbI/MGS86NS32dSk0+mMn2J1Pm7Ff5fIY63ebZ4Mpj/t
 cUer9j1u1ZKn5SAWJ2kdu9cMv/BpOt1rf1yA1WFM7h71u5et43Scq5pKrjjNPV7pPIlF9/l
 HFFL6Y9/Qt8yGT9Q08ppw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DJ1Nr14xDcs=;j8LUSZ+JOiBLSQ6UjXL5dS3HR+M
 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
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 10 Oct 2025, Delilah Ashley Wu via GitGitGadget wrote:

> As reported in [1]: `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config`=
 are
> both valid global config locations, but `git config list --global` only
> includes the former in its output.
>=20
> Suppose we have this config in `$HOME/.gitconfig`:
>=20
> [home]
>     config =3D true
>=20
>=20
> And this config in `$XDG_CONFIG_HOME/git/config`:
>=20
> [xdg]
>     config =3D true
>=20
>=20
> Then, to reproduce the issue that `--global` only shows the home config:
>=20
> $ git config list --global --show-scope --show-origin
> global  file:/Users/delilah/.gitconfig    home.config=3Dtrue
>=20
>=20
> Git correctly applies the XDG config in its effective configuration, but=
 it
> doesn't show up when `--global` is specified. We can confirm this by
> checking the output without the `--global` flag:
>=20
> $ git config list --show-scope --show-origin
> global  file:/Users/delilah/.config/git/config    xdg.config=3Dtrue
> global  file:/Users/delilah/.gitconfig            home.config=3Dtrue
>=20
>=20
> The expected behaviour is both configs should be shown when `--global` i=
s
> specified, so we'd expect its output to look the same as above. This was
> confirmed in [2], which quoted the `git config` documentation:
>=20
> > OPTIONS
> >     --global::
> >         For writing options: write to global `~/.gitconfig` file
> >         rather than the repository `.git/config`, write to
> >         `$XDG_CONFIG_HOME/git/config` file if this file exists and the
> >         `~/.gitconfig` file doesn't.
> >
> >         For reading options: read only from global `~/.gitconfig` and =
from
> >         `$XDG_CONFIG_HOME/git/config` rather than from all available f=
iles.
>=20
>=20
> The first patch fixes forward slash normalisation on Windows paths. The
> second patch introduces tests and regression checks. The third and fourt=
h
> patches implement the fix to include both config files when `--global` i=
s
> specified. Johannes has kindly pre-reviewed this patch series via GitHub=
 on
> GitGitGadget #1938 [3]. You'll notice some force-pushes after the review=
,
> but I only changed commit messages.
>=20
> [1]:
> https://lore.kernel.org/git/CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1ML=
E5HRxBQ@mail.gmail.com/
> [2]: https://lore.kernel.org/git/xmqqmt5lezi3.fsf@gitster.g/
> [3]: https://github.com/gitgitgadget/git/pull/1938/
>=20
> Thank you all for your time!

For the record, my "Reviewed-by:" still stands, if lack of reviews should
be the reason why this patch series has not even entered the `seen`
branch.

Ciao,
Johannes
