Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10C13AD05
	for <git@vger.kernel.org>; Mon, 27 May 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838522; cv=none; b=j5rI7Yh9MenpDzHuxZwmQZPQjmZmWwriaE49Dx5yxHhcuDSr7zJJMdXHG5kvRkQg3mnuwCNXX0F8Q8E0aEdE/kKDexAxEuuftmMcDJPLLLnuSnoPn2/ySfoRah+ma3giPs02XQ7APmdPL7PQqhEdrY8cgPQK5PtXYotdYgFT6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838522; c=relaxed/simple;
	bh=vqgxUVoyWkCtXiN9FwTFpjEaNUk2gYUSZaPsE2yCyA4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m7LKZMyyPxGm3uxMx7/fz/0YMLggqmDqLmlCB0QCf/q/cHYdE5sJ+Q1l/C+TH5DvkSNzyEiGlRQOQzcxMiCxB9L+0hJUBkpXjNtKgaCrXmVo9rDLaY5vGJN30XZnERjFAmBf5OZ1VF/BmquK1tPIMdVtPoOW9rtZjIb3d7OgAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=hRH8bkC/; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="hRH8bkC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716838506; x=1717443306;
	i=johannes.schindelin@gmx.de;
	bh=GL6L/kbDgJx1QPTU6G1IeVRtR7FoVyY+tKjCZ8TYVoI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hRH8bkC/yo3ecROrS96DCj80AhAZeyf8A4JKIQ+68BzQ65X+Owj9OCQv3KEFpstO
	 y2zTm4SMkqIuoU3oOPyBsWiM5ezI6xWjof+Aunlh0REUt9OgAtpf8s7PA2bLLLFq6
	 Nd0c/S/LFtIa4wbDIe9Naj2U3xAq7OwpOVOMEsKjP8XUmUN353zGQtYSYs8x3fPG5
	 CfObE/cObCUHyUQto7ultt9KF1KuTtH7Bsx8bJmVxkt67WvYEuWuJBwpYnMvbL35N
	 Rtxmg8bdcGPqmvgFTBJmEpbBWcVv2T9xPCtEKPAExu3JwPCVntjlZF/GXHPD5wIYz
	 /Shp7mCtFAuGqfAQug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1sl10V0LTd-00Zdnf; Mon, 27
 May 2024 21:35:06 +0200
Date: Mon, 27 May 2024 21:35:03 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <id@joeyh.name>
cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
In-Reply-To: <Zk2_mJpE7tJgqxSp@kitenet.net>
Message-ID: <fbb89826-0d83-d4f9-bab4-9fba69e0e22d@gmx.de>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net> <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de> <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net> <Zk2_mJpE7tJgqxSp@kitenet.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wW3yz1Lz5d1matliUPTT1WQhtvN2P4cCSLJKMOLZ6bO0yzVl6ET
 dwfoahPpe/v3Y7JvWD2dF1+Yx/HLBnpz7Jvt1+o85TG+P12er6brGazHrZLb/ig/rHiMf6E
 1PPacY1NW/bEqxa+CKDHplMgAF1WR/ib8lg6V+qPHIhZ/LAor+F5AGRfiah8ZuTdh8wrCBG
 oyqbDw3s2lZPMm9HUpgaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e2EOr0Y2zbA=;AlTSQzi2is+vt+V/mWCG44wewQ5
 9/fJ6hrvA1pUkmkTqsRSWTl4mytifUPbe/kUiysGr+FLHEjsKcLMpIJLXh+oAbITDPNVvHYQV
 /HLy3CwqoA1ryL+XJ1NUjz41FP2MQybfoLgW+qLDq52PIo8rmd6Ly/xsWqiOWsLlVfoDMQoRu
 yX4Rdm9cWQoQLC1kpWt42E/hgxmGSLKJo/8CpvbEDsL6MvaVXfdUzDGASHs0AzlA6fVNdGPDy
 p7Y5Loxp9W31GbJagYoLloa2l3sSfhMgxCGftRCN3fv2OU3pcBxuiMq5g8rD94OBOnK5zZact
 opd0psd0adm0koUj0mTo5dbr4bz9uJbXuN3e50UK+NC7uly1wniVoDy4xQBbp6kyqubAU9d48
 lW5YHU3V4O5j6ti1YvFG5T0qfRLsJWvPNew0OdCWSHrMkicOXbsXph8xRGfh7n/FXRFpFgeIx
 ZCDBYrUc086anycrnUEYlnWjKPFNkuEJUq6DWOxeZbmWEDr0y/I8VvD7Z+LTpF0mQWtm5LPo6
 tyKzZc4DJGKYM+kZ7Y3YnGToZAoUXOyOnYaelVy/POWtpbHjYUYCL33YIF7wGidsnMJWJlVmO
 vzDlKqQFBjHr2O2k8uZjKaf6xGM6MrXqopYxa7VlIuHYV+Kj0dCazX2oPW6Uy8u8ZYGkSbYjB
 wiFyjzDMOuDIskI27C0K2ST7J+YPTMH2Ns9BOlvpH5xn9qycn7y+zWzb9869adHBFhSEnykZL
 KRsj23PUggqlbYdrUHuP921wNIBndXht1vgmBmo3mDassw0O0OhwTX7sqneOu/OqbmYtgeoE1
 RW5Go2K8enZTrL8GNZnWFPGPS/HDSQ/jM6Cnn3wCdB1Rc=
Content-Transfer-Encoding: quoted-printable

Hi Joey,

On Wed, 22 May 2024, Joey Hess wrote:

> brian m. carlson wrote:
> > If these protections hadn't broken things, I'd agree that we should ke=
ep
> > them.  However, they have broken things and they've introduced a
> > serious regression breaking a major project, and we should revert them=
.
>
> More than one major project; they also broke git-annex in the case where
> a git-annex repository, which contains symlinks into
> .git/annex/objects/, is pushed to a bare repository with
> receive.fsckObjects set. (Gitlab is currently affected[1].)

This added fsck functionality was specifically marked as `WARN` instead of
`ERROR`, though. So it should not have failed.

> BTW, do I understand correctly that the defence in depth patch set was
> developed under embargo and has never been publically reviewed?
>
> Looking at commit a33fea0886cfa016d313d2bd66bdd08615bffbc9, I noticed
> that its PATH_MAX check is also dodgy due to that having values ranging
> from 260 (Windows) to 1024 (Freebsd) to 4096 (Linux), which means git
> repositories containing legitimate, working symlinks can now fail to be
> pushed depending on what OS happens to host a reciving bare repository.

Likewise, this fsck functionality was specifically marked as `WARN`
instead of `ERROR`, to prevent exactly the issue you are seeing.

Are you saying that Gitlab is upgrading fsck warnings to errors? If so, I
fear we need to ask Gitlab to stop doing that.

> +                               if (is_ntfs_dotgit(p))
>
> This means that symlinks to eg "git~1" are also warned about,
> which seems strange behavior on eg Linux.

Only until you realize that there are many cross-platform projects, and
that Windows Subsystem for Linux is a thing.

> +                               backslash =3D memchr(p, '\\', slash - p)=
;
>
> This and other backslash handling code for some reason is also run on
> linux, so a symlink to eg "ummmm\\git~1" is also warned about.

Right. As far as I can tell, there are very few Linux-only projects left,
so this is in line with many (most?) projects being cross-platform.

> +               if (!buf || size > PATH_MAX) {
>
> I suspect, but have not confirmed, that this is allows a symlink
> target 1 byte longer than the OS supports, because PATH_MAX includes
> a trailing NUL.

True. That condition is basically imitating the `size >
ATTR_MAX_FILE_SIZE` one a couple of lines earlier, but it should be `>=3D`
here because `PATH_MAX` is supposed to accommodate the trailing NUL.

Ciao,
Johannes
