Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E945BF9
	for <git@vger.kernel.org>; Sun, 19 May 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716125146; cv=none; b=c7BwDEpZ59qQp3bAfu11QCbLN+togxJZJTIhFnYTEkQC2xseQYPTcPYMy8hNAdyq9qoKcRftpXV0HHmzPAo2uu3vNFdmtKyMXSnGyWGQSRRN1CAFV9YY31utvipaxMNQ5xLOPzHsnFfhrFrwI+Z5ZJ1/nZY08C/tyBgvl5fk0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716125146; c=relaxed/simple;
	bh=3dCSoZdK2sm2WrUF9ABe+OUAmF+VIEsZZUSGJjze0LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLjx8dXd2uY/ZcgRgKL+rPo6EONUQTGDYc/waPPsGdOTl5LVul8WL5hBDKdSPZwBBhy9+0Lms0TMKcV4AaEn09mtu1lPlzNVufRUQlkLhyRuy4faWxDA/dkWDSt2oFxXG+/PRNU2wPg+Mw6f4em/MKsf6a+E4tPpWbl0F76iqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eC0/5SMo; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eC0/5SMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716125128; x=1716729928; i=l.s.r@web.de;
	bh=+A5JCmFZvv6Pm9tCZxTW3fjuas6vovn5oRRF27GNKa0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eC0/5SMoSN6fcxXJAR9eKOJQ6hc9edW49FLzOIHdbMY6tQE2IgclgHraiGSyQxJC
	 D+v/EuKPMChrGzY+L9UgxgqzNcm6a5X8mEUEkLUSb/6KmHPDS9FnWYuA0E77OZhPq
	 aULesRJDcvGFiIElYSIHYiJwPCEU3LEOVQG9eJkVfKfs1A6T2fue/bGno/NPPj+gq
	 eVRZWP+k0Gqv3CIbUJH1Mc5ljzQUA5PWaG9NBV7EJtxNV0GKfJsCruNNw4yiZ3NGB
	 pH1Zu4Ek9eWZ7/qKSHLvD6o8cHTWDFG4qbLU4sB0CKryM55lh+5ikIOLt8nnGS4ee
	 e+e3kZ6bzryK3J32ew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKB7-1ru0k11RjJ-00PnNA; Sun, 19
 May 2024 15:25:28 +0200
Message-ID: <bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
Date: Sun, 19 May 2024 15:25:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] archive: make --add-virtual-file honor --prefix
To: Tom Scogland via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Tom Scogland <scogland1@llnl.gov>
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
 <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qsjGMG4DpxXkpLBYusEtQLuTMGLQbE03EN9JND+GzvxRD4No28m
 jEq5phSPd3Y5ywz82Um6G5kjXXKQCgVXKjs3wp2FfIwagxUGZxRO/QHXaK0qFpRl7e2G1l1
 /td2CM37f0cUlO6ROfIugn7vUpmG/G7nY2VZzJujr3H24mKPiXOkpF5fsrliRlM/i/Ld/50
 ZQ2THry0HbCe+UYgGNOuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bx56OW9kZV8=;3PigMT7NQM5gNOZM1N0n9lsB1nG
 g4dYu+IQCMGGcJpUIJn7ASeSlLfRzRVvfWk79y60BIhQSL8beXuiUHou+1F+GllsGV9Lf1Kai
 BZXsZiHwLmbMdS3qyM8tkTtvnhqhm6dqsfBHO6NobZezpIiuB0fjqAq6orj0wlYyQwhC4t0J0
 nomXd51Zevaxf6oz4UcNxB+PGaqmPgA8f/twStQroIgrFjfNjOBpj7BdPWJMvGI9/qUvknQw7
 c5kNwEp88dMplmFhELtv/Iq2/9aWroO2jFqEc4fCRWTrQzA7n2bdLmcpZdO8FLddhZuSEirkU
 z8YgthAcnYpAXeSh1yMWdn0ZAyGzqg1eXmYHWsfgJG55Vh3ktwPmVHXp3+RkNos6SQDK4xUCb
 33fDfb9pgkRwaqrCnlDefKC4e4efDGca4teaFFF/OXNJ5PPx1QBGaBOH2wcbBp/RYAmawiHbH
 JDyt+e/cP1G+5HtyAFd9Z11eDmpRgsDmXZJvEzv4UDD0tIT8ZAJOK5wcUKYCyKnNdMzK9brmk
 EnAtMPxtyvMy85+f9yREQ12KeHWp+HpsqZbMQQ4qrgQsD7I7CBTxXqUW/XELNHoMLUaw498Ep
 zIiyrgOfnocR3DZ6vpKJrNfNSVmA8Vv5HiQbbL88kCAMcYrpVYTEbATbovhlJKyzY7p5nEjC6
 vRWfY1piZTEoO61HtQHvSU0jpTHskpSFvEVmNW9ythDmk8uzh2IKdG70eIcG/PK7MDN2mlDja
 espl7CZ2tJqNE3Fst2lvVzu8O5CLSkXmbBlaOnXdvTkeRorZsOuDclosy5VWeEqnSZ1Fwb/y7
 ANfPtsEiw3YCgRCYw2J40Zr0BMMO4OsPje0alvQHOM93Q=

Am 17.05.24 um 19:34 schrieb Tom Scogland via GitGitGadget:
> From: Tom Scogland <scogland1@llnl.gov>
>
> The documentation for archive describes the `--add-virtual-file` option
> thusly:
>
>   The path of the file in the archive is built by concatenating the
>   value of the last `--prefix` moption (if any) before this
>   `--add-virtual-file` and <path>.

The documentation does not actually misspell "option" as "moption".

> The `--add-file` documentation is similar:
>
>   The path of the file in the archive is built by concatenating the
>   value of the last --prefix option (if any) before this --add-file and
>   the basename of <file>.
>
> Notably both explicitly state that they honor the last `--prefix` option
> before the `--add` option in question.  The implementation of
> `--add-file` seems to have always honored prefix, but the implementation
> of `--add-virtual-file` does not.  Also note that `--add-virtual-file`
> explicitly states it will use the full path given, while `--add-file`
> uses the basename of the path it is given.
>
> Modify archive.c to include the prefix in the path used by
> `--add-virtual-file`

Aligning code and docs is a good idea.  Have you considered keeping the
code as is and changing the documentation instead, though?

The two options are related in that they both add untracked files, but
they necessarily have different arguments:

   --add-file=3D<file>
   --add-virtual-file=3D<path>:<content>

You can already specify any path you want with --add-virtual-file.
What's the advantage of honoring --prefix as well?

Ren=C3=A9

