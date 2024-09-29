Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E048824B26
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632611; cv=none; b=iJ596m33iwHekigyPGrx+Kl3P7eOkGPI6uG/Uhy1Qu+sLzpCvwDR8kvmrCCWI3hINK7vyhqelpIxwqAmEEj6mfcii+cGWftb70OJue/iuERQ7/v9JSuUYafePMP629hvId6r+NSofH01uZH6A6LAGqQohagio+KklZXS2foLzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632611; c=relaxed/simple;
	bh=g3rkp7nIfdMSYCJveq+MBoQ+G9lIIlReLNQ0dtWlZCE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZvDgjtVs5c1AfoPekGZUow/BFO6IENh+FsN19I7gWup/HdEuGfKo89MNZ793OUBUfRuflbZkBo6YQWG/Z8PJ7w/Y3cRcomgslKgmoLWiySEcIU90Epl8mEbYKWS7lNxvAwt4tleYjK0Uu3XxYRX6R7U3B4IhZx8P/fnYwrrYsiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZnP8nDMG; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZnP8nDMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727632587; x=1728237387;
	i=johannes.schindelin@gmx.de;
	bh=g3rkp7nIfdMSYCJveq+MBoQ+G9lIIlReLNQ0dtWlZCE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZnP8nDMGcoMSQEVZZY9P0P7tjN9kkEZ+V6xuXl/S1l9utOuTBW3x+ocKz2Xmmlze
	 NiAgu7arvmqFw5iw0mxDupeKfctOGOo8bhryRaA8LROrkeywNvumfupdsA2sWVevp
	 qTcMtxIu9AECvHWOwXho0+KJoLWrorw1u87DsGbXCh/eIAN/aFrbZ/LkuKcu2NUoH
	 HpAIBrHOpGqshZHE0CfEOGmTUAFBObxZNflbOXATWryKslsMr8eRRQbxAy19r0YwA
	 hLyIsAh/XbtpmV8w5DOj3rz/kSFun98yonC1gEbd1rzBg/WANqG90IlkcfKFHcMX0
	 VZrouYVLk3DN8M32xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxlzI-1rz8uS3SEY-00vfLk; Sun, 29
 Sep 2024 19:56:26 +0200
Date: Sun, 29 Sep 2024 19:56:26 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
    Eli Schwartz <eschwartz@gentoo.org>, 
    Henrik Holst <henrik.holst@outlook.com>, 
    "git@vger.kernel.org" <git@vger.kernel.org>, 
    Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
In-Reply-To: <xmqqv7yil70d.fsf@gitster.g>
Message-ID: <39508a38-d98f-3883-3887-971385a3805a@gmx.de>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com> <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im> <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g> <ZvKsH1Ct-YwBPA_f@pks.im>
 <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org> <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org> <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com> <xmqqv7yil70d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b9D7x3RbDv4m/O+EmoYFTG40JQrXF9jS4HL85KCneF73ovJm9BV
 Pnedelrtc35hZu6Vv46tzdrS+Qph5mbDKxMgAb00EFq53IMEUiJoiLIsjO6Ohxrh/XveIlR
 87LYQ6Ev6Z6jqnokRCWxyTk9TFAK8onCluI7WSYuv7sMOvWvcDhbGlC4/YHEAPVlpJYzPbx
 Prl63kjZYGAHWy+q0DpYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NOINTfj9rm4=;GwX5ZVXlb3beRW6dhcAZ/givfJc
 3Rh60gwpcO6FTG13Omml6KfxkhyWrDQrRUQDUV0I2PDrd6KgGiaPEvbjNkT9sKwUGC7zt5gX2
 rM5NYshqEBRKiPVQuaKo3Wm+XriqI+72vtfH27BTFAp49hG+f7t8fKiq6GOp/sf8aiSaeg5iR
 Ngl2FNii2B6bCP1AwUEZwmm09kqYeMPbmst4yGUzNJO2mYx2uc+9flIDQujX1NmkHAk6pwAzs
 6/BLsHeyw5WeUbtXHKIrkbyMUx2afxqGoUA6DMqOraKsarxbYGZROEU3JWAceKRjS0w2vsL+N
 bIAsyUsz2B+PT/D1rhFrc08rG08Yn8uq8WhqEP7Kb48m1dWTqYnyXTucFBmHHf4+GtT0j0lyB
 ssjCSTuOw/tiswMBpOhh/FV1zd8FOcLS0iwrmr5Q7V0G+KJAi8s5dyiukFFvjvFNP+b4wd0Ro
 Cy6y8AnMN7H9AYb7HXPHnHnS+bi/b8UhdXlDM8EVEoa3s/KovZqMny88Vatwhg5zTaF6yxQUH
 nqTPJcfVOP88xxuBSXuBE7l838iSeJSgNJm5JrPVudS1KjD+kgGOBnaVutxLoGhc+VJODEm0F
 LhAkcx2crv9Wx05nryJe96GaIIfbLv5tMD+iaWVPHnIzoruhPKAxBkBlsGwdBnG8W2T2+3pd9
 J8o/kMgb+0rJYQAEWFaSQA9v5rqgRtjIXIsRxjZb8ouGrg8XSTgOh0z0OkhVfF6Lq7N2ubyhI
 bzdeplWuWUXwJz9JN7ovRNWq2ojO5zEicj79T+GkrfM2eLScNs8bvBgoBlWAqaqb5A2QJrqYY
 fVB1w1Imv5hCDcnATYPkM5K+AX10E/l1GrAcEqJ4FIa+M=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 26 Sep 2024, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 25/09/2024 07:04, Patrick Steinhardt wrote:
> >> On Wed, Sep 25, 2024 at 02:02:34AM -0400, Eli Schwartz wrote:
> >>
> >>> I'm probably biased, but some of these failure modes are *weird*.
> >>> And they basically never require the CMakeLists.txt to do something
> >>> considered non-idiomatic in order to trigger the issue.
> >>
> >> All of this is very valuable data to make my case for Meson instead
> >> of CMake. Appreciated, thanks!
> >
> > One thing to bear in mind is why our CMakeLists.txt was introduced in
> > the first place [1]. Visual Studio's CMake integration means that so
> > long as git-for-windows is installed building git is simply a case of
> > clicking on a button, there is no need to install extra software or
> > plugins. I'm not sure the same is true for meson and I don't think we
> > want to end up supporting both.
>
> Is CMake the _only_ thing that is integrated into Visual Studio? Are
> there other possible candidates that could also be used to build for
> non-Windows and is usable by this project?

There is one other build system that is highly integrated into Visual
Studio, and that is MSBuild, using `.vcxproj` files. I do not need three
guesses to find out what you think about porting Git over to that system.

Other than that, there really is only CMake support:
https://learn.microsoft.com/en-us/cpp/build/cmake-projects-in-visual-studi=
o

Meson came up as an alternative, so the obvious question is whether it
could be used conveniently from within Visual Studio. It takes but one
look at https://mesonbuild.com/Using-with-Visual-Studio.html to see that
no, the instructions ask the developed to use a command-line interface,
which is the opposite of integrating well with an IDE.

In short: If we're serious that we want to stop treating Windows-based
developers as if they were unwanted here, we'll need to stick to CMake.

Ciao,
Johannes
