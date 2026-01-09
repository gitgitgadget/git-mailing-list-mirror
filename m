Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761F366545
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989094; cv=none; b=L5IA6bkHF6mifzi1sZ44mRFCnkVUTIL4+mU+BxQhawU5RqQoEfxBhOfgNCwgWhJRSNe198kQCd1ZlPxY4fy4BSNE/0w2El9uTSo7x0NZuMvBUCwTM05ugihgr+tg6f8zoBZZsflIiN4GRKSFeCYxdT0pPqsRTAIGCOt5lo6+esw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989094; c=relaxed/simple;
	bh=2Y+GaGB+HQqs1BIpAJMWrmQH8w7p3ub/t0EsGBcqFoA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f8QBw9hDs/id4M/cxpkOQNrE+uEizIGoOJovvZui+GyLH6wUzDyVGRCgp3Ge6msAsnCCtzP5Kq78A3rmkNw3qBv/jsGmLGus8PrMguq+1AqYTEU+OAHtA0PtCPvEO2/C3fLjg7RQMtCDRgNdSVElmtkh2grw9FLe73Q9P7D3leE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=WOlXDjNA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="WOlXDjNA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1767989090; x=1768593890;
	i=johannes.schindelin@gmx.de;
	bh=hO7mOVT+LLH72agqz1eXMU/d8e6G8YXI6wxIJGQ/iS4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WOlXDjNA7wQiwICmxlCEOs2jvciGYgtOvwkU3ouwLpXkUVDaIPAZiAKvSNjUTgOF
	 moMumw7EfIiyfDJ98gABipY7muGfIAGcg8cZSjJ41MMpUj9nS2N6MlHNeRHU1ML9z
	 eSBMcJ//6X7m5jO2MlYG+o9OeDSsInUq+1erDNMQi86nIUum87JsNIQFAJ4XmDO/N
	 GqzPEM3dtirLQ1/y34kczZScRz29kvFchIoKDsUiEMLsNSv/3zOcb0adOgo+JuiCA
	 YJJfdnno+wKfjsyiCs6bXmmPdsDG/A/tlV3XtIvDjaprYhrktFUvQa0vhknfHO7C/
	 1bv3bTDhYDb4YD/LbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1vusCk1Aaa-0110nI; Fri, 09
 Jan 2026 21:04:50 +0100
Date: Fri, 9 Jan 2026 21:04:48 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 13/18] mingw: implement `readlink()`
In-Reply-To: <8826825b-79ad-4700-aeb5-71e7847ca5dc@kdbg.org>
Message-ID: <5fe64b77-d10b-b66e-8622-14bec1e96f4a@gmx.de>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com> <8fef8220f4d60b48358882fbc961c4604eab3abf.1765980535.git.gitgitgadget@gmail.com> <8826825b-79ad-4700-aeb5-71e7847ca5dc@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LfALGdR+afwUjNHSSX0LA/zAiHL1qfnZx/4cMn97cRs/+Q+8WQn
 HOXvSTZOfaCc+k3X/Dgzg15eOxCmFLHL8dXHpgG10BVp9keVAXJ03CP6LRHCgFsxln9QRO1
 T6odIvOLEsqVpuiaB1zbjxlN+cXvVJGY3YDdzJfCX3rry7ojBuGoAElEDoeEaVvfl2drfRa
 rMEKOLmsi/X4f9wmdt/og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U2fPeMIYg5E=;5bJCFuu2FqkMgMR8faYBZvF203J
 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
 EJSyNlBI=
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Thu, 18 Dec 2025, Johannes Sixt wrote:

> Am 17.12.25 um 15:08 schrieb Karsten Blees via GitGitGadget:
> > From: Karsten Blees <blees@dcon.de>
> >=20
> > Implement `readlink()` by reading NTFS reparse points via the
> > `read_reparse_point()` function that was introduced earlier to determi=
ne
> > the length of symlink targets. Works for symlinks and directory
> > junctions. If symlinks are disabled, fail with `ENOSYS`.
>=20
> This last sentence is obsolete, I think, because I cannot see how the
> patch achieves a failure with ENOSYS.

Indeed, this is obsolete. Just like with the ELOOP commit message comment
of 02/18, I must have dropped this because reading symlinks should work
even if creating symlinks has been disabled via `core.symlinks`. Here is
the range-diff between the last version of the patch that still had the
ENOSYS logic and the first version that lacked it (Git for Windows-only
commits):

1:  4f353d988de4 ! 1:  1d079621427c Win32: implement readlink()

   @@ compat/mingw.c: int link(const char *oldpath, const char *newpath)
    +	char tmpbuf[MAX_LONG_PATH];
    +	int len;
    +
   -+	/* fail if symlinks are disabled */
   -+	if (!has_symlinks) {
   -+		errno =3D ENOSYS;
   -+		return -1;
   -+	}
   -+
    +	if (xutftowcs_long_path(wpath, path) < 0)
    +		return -1;
    +

So: Unfortunately I have no record that I can readily produce that would
motivate that change. Given that it happened during the same v2.19.2
timeframe as the ELOOP change, there must have been some broader
discussion about this, but I could not find it, not even in the release
notes of that version:
https://github.com/git-for-windows/git/releases/tag/v2.19.2.windows.1

All I can present is the reconstructed rationale that just because Git is
not allowed (or able) to create symlinks does not mean that they cannot
exist, and therefore Git should at least read and parse them as expected,
independent of the value of `core.symlinks`.

So yes, this part of the commit message is just simply confusing at this
point, so I'll drop it.

Ciao,
Johannes
