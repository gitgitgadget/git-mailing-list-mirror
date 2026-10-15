Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294F57F727
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088470; cv=none; b=Oqzx3lS9mmy4xXnqGcMqFJHwQEzFAaOdNMd+sY4813vRcpWax4LrrHWzA7DdE5ie1/hPXN5+lM+BwF3JMqWO3p22B2X+XoSnoQOBZ1x98xNP8VB6i1u3WPREYkv3uC9F8jHbPtfdO3vPC1MtJElaa97Lhxd3rvv88MIVZiD9b4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088470; c=relaxed/simple;
	bh=+SuhsVuFTzgadieyXevcblQ3NeyDrdnE/U4612s3wwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a0ft8ESxPVUh515nWs5CbrDEGVBmbyo3eXGFocC8XnrqgX1n9g9VLNpspJoFjcxHNBtZJ051h3O83EQaiPkmov8197LiOiqhHWg4tyasRwjiKIDbR/7YFVrycEf3U8brYAj0W3bNzKRhI2/SIjVzqVwgSBZrQtjKsmzl8RPu8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d5MalQNu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QocydxWU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d5MalQNu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QocydxWU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 874D47A011C
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:21:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 15 Oct 2026 14:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792088461; x=1792174861; bh=sJYnD7HhJq
	6VJC+kYNwBUK2yT7Z4RjCuY6WB7aDe69Y=; b=d5MalQNuA9E06ed2b0KXZERAYi
	/2u8FAimsmpBOWppC42UJmk+c8zUX7SnkfROGSNaxuF7ZWEzDeMbAuuwBUOL4rfi
	zjyGHrClP1iCyI7o8VXLiLxzL+Dvh9EHIq3AbLco4aBBa8aWHJi1PXgNfuCyHl/S
	u+wJnABgmzqf9Ux7N2baqxAs1pmkEynYu7Vewv5tcKF2no3BYKjtrYq9L2cDmUrt
	VUQja3o2QlnW3a5okdA36G4J/8SjePa4Ar3hlT2PnB+A/gINf2pE2bdZZ0Nis/WN
	UwbijBMCO5u/MEspAjaL3k81q4EnQkK4xjVnKYpNGSiOH2EJj2JD0aeBCrhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792088461; x=1792174861; bh=sJYnD7HhJq6VJC+kYNwBUK2yT7Z4RjCuY6W
	B7aDe69Y=; b=QocydxWU/5W+8z9PEn45taK80SiPn+GPwTNVDUQF+hj+hL5dxLT
	JUqFaqCvFbGSmMXWkunVbwTjYLydyZXqrFv0WprOLJcFvmiDRtHrt0eltasLNshK
	rZHyuP9wjkv9SqT/gckxP5J5JTRwBoaplFq6IQRvikxq6n8cGGoSzK6/AFBq4fuB
	todHko56fAMbTbQGSAh7zUY6CVIuCj8ZFRaJvLAYLP6QHXmnBfAWr/ubtWVV/KyO
	NzymMovAV0XV41t/lfnFqBSUpkc90tQcG1GxfG6lBakIeTen7vl/w/fpau6grmUY
	NfzunlRSA/BxX1aSr5MlzlqmzyhPqduZClQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792088461; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CnsyI6+OMDaNDAlP3TXPRDJw8kysD839Q+yf6DuWCq5utMX
	3JoT7a1GtFimmteASbHnPHskb4iyUz/xGaMV0+pS6LubLZB3UAkM9mdeXqEUYT7Y
	VlvphA67oquGYLPrZ7oI13LnlubrgeKR2z0eQLgO19N5Fl0BEKHuowkMO3grCkit
	gQtvLGS2sKVoebqWkNWIOFAlx8YAOYhSsVrKC2L0eQkP/Rk8L40vzVId1Phlk7RT
	uiATJQPOq7G4QI91fYchMYvOyAymflRHoQNmXxq520YzsNGmoJ8HNjox6E3RwD1N
	C+Ed4ac8z0ukcFyrDIJPEKQmU4bb3zd8rS7hNnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8v+ccvnc+X70/Yt58Le2zryeFYYZeIcQoBmBfRqyC/0=:+SuhsVuFTzgadieyXevcblQ3NeyDrdnE/U4612s3wwE=;
X-ME-Sender: <xms:jBnRahjkVkdfdLGbGWmg0HLrNmHfN_c8Gj2QQOXLi8PaWSwT3oA-5A>
    <xme:jBnRatwx12-9HXdwpDkGtkaxaiSmv8sgWIx_u6ce5ijpcBAIRpx4q9L-DpEisF3cG
    -KNs2zmVVI-Wdj8IZoCKcFYj___8ooYLCckrgTv4O2WHK1LMKzt3-Y>
X-ME-Received: <xmr:jBnRakJenR4y4yBv6qLkP9_4Xq2mZCw7PPLfc-xPEBZmy8MRPfbGEqXvv-K-Ez2mZYaNPMW7VUpbQ6UpjgnCOWguRryqkl-K-CFC>
X-ME-Proxy-Cause: dmFkZTG3rTR9I7RB0gcRrjEe3jmGoTqt/hIDobs3oMfmy+6F365Zy3QRsAeV/eXSi6HySI
    i/rf7ioerSkxfpbtIKzOtMFT5SFzOYsbRWlvTOXTCRHekpj923TPOnqeKpSpssxmOAIpBj
    jTn/xWuBJdlYyHWrBnty+z1s9oXUH8pkVQo/q38W6OTT0CcON/k/+NnTQK59mVKir430tT
    Z1csFs8X8kW+x98T7EZvptPCLbaio732WoAI5xI0EZCXbk2PtHGrcWeMyWeyyPImJfxoz9
    WREfTiJZLutNICV9QEyzQlz8klxAcRJnv5b44Q+daLpLG0OgvJ+qSvHTIZEaNSDZfIOmaf
    Kjbe+1ZLi5/G2twKwMnhi0CtpZm0AtT/b0/OvMdAiJIILDG2//DzvTIsW7shJM2LvLKpFW
    avHWz1sBzmxZTONIvBOhMxnQ2kurBfEHWFMhmWpcInMvgwRzNVux4LZY1GsYGuzIaIAWhk
    +kqHAGAHh+6auwrGONdw9Wd22sTuXMtRei/eck+aEPkRuuybeXNAbgzUqwlRQnYuo8RIlt
    a6lbWVM3XpGXTNaqAbqOf48r8kgpecJq0bwADpD3lI75gsMw1CRRAMVeaBWR9EPoLz/48x
    ya5/94CQKoyGHaZi+PTMKYfFqVcSczM5/B5p15tyZKo6gRIWpDNDZDuJHOiA
X-ME-Proxy: <xmx:jBnRakTvGZe53t8vSyWCtH-oeyasVV2ncM1aeoChUcRDHpvU9oUOzg>
    <xmx:jBnRasoBhZsHMeUok_eCXfhL01tiQq5GXit8iyaE7CnftYCSNc7-ow>
    <xmx:jBnRapr_o-zJsIbKU3GdzKCOrmf6eFB9S_l1ELRpSymaz0e7qHcupw>
    <xmx:jBnRamM-WrUM9pTCx0U-ZqLKPPJWSoNjc-fYT-6cWlNTGA4ZYBD3Vg>
    <xmx:jRnRas_ppgdAntkPLtTS0rZ4UKoNeOMzdUMf_9rtp_E0b2zDAcU_Kk3v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 14:21:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: John Wilson <jwilso3@ed.ac.uk>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git help user-manual looks for incorrect filename
In-Reply-To: <VI0PR05MB12991467F7BD29308AE8D5F4ED09C2@VI0PR05MB12991.eurprd05.prod.outlook.com>
	(John Wilson's message of "Thu, 15 Oct 2026 07:17:03 +0000")
References: <VI0PR05MB12991467F7BD29308AE8D5F4ED09C2@VI0PR05MB12991.eurprd05.prod.outlook.com>
Date: Thu, 15 Oct 2026 11:20:59 -0700
Message-ID: <xmqqzewen7uc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

John Wilson <jwilso3@ed.ac.uk> writes:

> Hi,
>
> I would like to raise this issue, as suggested when I erroneously
> posted on the git-for-windows repo
> (https://github.com/git-for-windows/git/issues/6466)
>
> ## Issue
>
> On Git for Windows git help user-manual looks for the wrong file.
> Git looks for gituser-manual.html, instead of user-manual.html.
>
> The Git User's Manual is installed as:
> `C:\Program Files\Git\mingw64\share\doc\git-doc\user-manual.html`
>
> However, git help user-manual fails with: `fatal: 'C:/Program
> Files/Git/mingw64/share/doc/git-doc/gituser-manual.html':
> documentation file not found.`

Thanks for reporting.  I can see that this is not GfW specific.

    $ git help --guides
    The Git concept guides are:
       core-tutorial    A Git core tutorial for developers
       credentials      Providing usernames and passwords to Git
       cvs-migration    Git for CVS users
       datamodel        Git's core data model
       diffcore         Tweaking diff output
       everyday         A useful minimum set of commands for Everyday Git
       faq              Frequently asked questions about using Git
       glossary         A Git Glossary
       namespaces       Git namespaces
       remote-helpers   Helper programs to interact with remote repositories
       submodules       Mounting one repository inside another
       tutorial         A tutorial introduction to Git
       tutorial-2       A tutorial introduction to Git: part two
       workflows        An overview of recommended workflows with Git

    'git help -a' and 'git help -g' list available subcommands and some
    concept guides. See 'git help <command>' or 'git help <concept>'
    to read about a specific subcommand or concept.
    See 'git help git' for an overview of the system.

Any of the documents that are listed above can be seen correctly

    $ git help -w everyday

But user-manual is not even listed among the above.

A few things probably needs to happen.

 * user-manual and any other "missing" documents need to be
   identified and added to the above list of --guides.

 * any of these "missing" documents are not installed with "git"
   prefix (e.g., "user-manual" becomes "gituser-manual"), their
   install path may need to be adjusted.  The old paths for them
   may also need to be retained if users have been accessing them
   via the old pathnames.


