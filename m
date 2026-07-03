Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8CD32572F
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067471; cv=none; b=V5dpq37sjnitqj7g2qR8EXNTbpBXjv6+IEItYykygkT8HZekLiRi9YzwbD+rbjIKDDbuK2NgTfM9QT4M9kyw/CW+xgxXZ+9G++qA+QGg+JRs4ZxiyxIk2LLzfknWtQeWBZ5PDEsQgsxJJ4ryQp0NnaZuKMSavbQ2E+95BFuf1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067471; c=relaxed/simple;
	bh=3fxzAR2NS8zE0lHaN1JZyattnJRCRhbXLMnDXAa6OQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSZSrTpTnoVTyDHWd8rYiXzkm1UXIpJWyhurvrCz/LAwkdwSFqNPYQ/7mBDv8nDmcplk5T052ZgHUsBJ2LtvgHUyboYtigILA9uX87NPVr/eBn8nU17GNohdfMIzlWeIIEzuX194cNnHhOZLcWNk+2k4WMPFSwHLNGeWtrKDkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WohqKwve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AEeVuNp3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WohqKwve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AEeVuNp3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F9C87A0064;
	Fri,  3 Jul 2026 04:31:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 04:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783067468;
	 x=1783153868; bh=WULDUQySBqjfUxVtotmy0ItDmMjopGdn+4Sbjf+4Ti4=; b=
	WohqKwveqxvE+M1t9k/YaFLxuqHcEeYrGyYJXrraSiy+gq8SPRHrpOa94kmdfdhW
	9N0f1KoXp3SMr6fDJ5RkVytOYLdGw+LeGFxWyIystT+tEve29qaavctOk47FpA8d
	KiEoDBsy4p2u5QRt7ZdmSsCWXLW3Sb/odkp8j96M63uL/3nr/RUoCsUgEvaaBhZK
	8HeY1/w3NxLIEGJq040Er9ru4rvc1nbrJlO+I7o5dMXpNzntw5cM6nhgeFWzkoTh
	rIN7pvkp7UeU49Kx/RGbZ6JrTQrAfRAfS+atHhEDsfGwqnZEpvl70+w6MVRMEZnD
	RU+fxYGyiNdPbfj890B+eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783067468; x=
	1783153868; bh=WULDUQySBqjfUxVtotmy0ItDmMjopGdn+4Sbjf+4Ti4=; b=A
	EeVuNp3H5DZlrNq9jNL/CCVD9bbEB8mIUvBGafCp1dIkhoyGVMRnle9TFWJI08ON
	1JTGM2z59yCCZpRjh9G4hSouRJohxTyigzgCZ41BaVpIYl2WjT3/h6eBieh6amx3
	ZqDeSbHrYvrGHG9oiTIVayXwfuGe/3eW5Bv17Z08jEZc30QEkf4c1DWcPJf5QlYr
	GZuIAHKhDJZEQGTl50C+wdeEznsv7rl+73i7psNOs/RZbZeCDvRwHxL252WEYQUq
	wKQV6+3tRW70imZNA5j/+BE2hzCR4WWFIubDRhPB7TROSTYg5PxpBTkhxqwKzfcH
	0RlE3MEqsZoJ3NG7xtMcQ==
X-ME-Sender: <xms:THNHap_SJk-rbjl6nw3KRmEsIXmWRGNG1J8voeAacoildZ_APt2qug>
    <xme:THNHajsn6nnIVlK1DAX1ieVRRn9JkCD6H-xIO3KYYumRkWNXst9f_F_diAiFUxitd
    qvYrcbLzQMbb8ypMgkLvoo5rHtQPxvdjWKUOIhLfnviq3GUXPVPBz8>
X-ME-Received: <xmr:THNHakqsntD-smEUTJJrkv9AUadS5qnOBiK98giONEH_gZtyfEFiQJgp2tJZaeqL4HAc6REN_NnyP-d2aMPUPrFCmxLUWqtTeCE7CqTBcA>
X-ME-Proxy-Cause: dmFkZTEYZ6Ay4PvXjtzIWXAty+8HjSW/jU9JtmXEigDx3UzD8qhZNnFrDODDUprfnSUwD0
    a4HIl2nZFBzW454J0RzsvGo/o6la071BeThG4DnFMRiBHEodObbpZVYGvGbVeOZ6uVHL05
    VJCZDluhB2knQRSDhjwM/NbFgWzEtiN/f9QzZ6fWBimx3NUY1A6Mn9sy/HD5InnN2Zd4h7
    o16VPMPoiT4f4IKzqWpx2zJd4owmE65VooQqcnrBY2K00MXGkvV9ZYuBAZ2vhq0DX11PZY
    I7VdLnGzKs0dO/SI0sv8SUVoWWP9iOESF2kPtQHzrKV4Q65lNXvRwvpGFDLQD+0CIg58Ws
    +M8tk/HMJePzoJjmYjbrCC1E1Bsnrjije88Ag0yLaadKiM039jhuNsSp5qd+XemzL0e5Ox
    u7L58WklzYAEC3cK2K+3z87hqL7hpm+wcky1JEFGUjB1PijVFz7Q/LvlGXP+zKadWBxq85
    MtMdr4nxn884aILqFtCsGJx+EdBHAmvYnMfM2vEsyZcfxorD6zC6LR7RE7lyEzboJ+GFt0
    lNaiPZVRsAPJBP2qqLnjxQQORaeK4R0F0/Vi80YztvaAFKrtNcSYmkGhh9U4yMHKmDap41
    L6J7G8i9d0fZ8ZU9UZh5+ZNT8Als1hcTF9KU+hzGUUN0sUOHQBjqhnNwVyFw
X-ME-Proxy: <xmx:THNHaokgbIrxUyBnM6LimoUJntTwVLO1DJ1B0_rOB2y5kDpQG5l2Nw>
    <xmx:THNHagxuV8s6-f4hnsf-THjUevxXcSHs45wKIL7OgynDEYbPpNvkqQ>
    <xmx:THNHaomOwJnp6SiAgEb2xorgSiaQX3RoiEEC4LNY4-Vygz2A-HWNeA>
    <xmx:THNHahd57IYi9GsGHfdLzbp8b3VVTbF6gOqesMT0azsLxjpdp6LoOg>
    <xmx:THNHar9vgXgweD8NPkP4AEp1Oh9-yIJ8efYjP_t-GGivMXePYvUs2czM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 04:31:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e299361a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 08:31:06 +0000 (UTC)
Date: Fri, 3 Jul 2026 10:31:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?0JXQstCz0LXQvdC40Lkg0J/Qu9C40YHQutC40L0=?= <eugene.pliskin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Unexpected recursion in 'git rm'
Message-ID: <akdzSHrJ4DfdUWoS@pks.im>
References: <323134122.20260702104910@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <323134122.20260702104910@gmail.com>

Hi,

On Thu, Jul 02, 2026 at 10:49:10AM +0300, Евгений Плискин wrote:
> Hello.
> 
> The following git command does recurse directories as contrary to the
> reference (https://git-scm.com/docs/git-rm):
> 
>     git rm -n *.json
> 
> Without directory specification before '*.json' this command is not
> expected to recurse directories, but it really does.

This is expected behaviour, as the argument to git-rm(1) is a pathspec,
and "*" matches directory separators by default, see also gitglossary(7)
under "pathspec":

  • the pathspec up to the last slash represents a directory prefix. The
    scope of that pathspec is limited to that subtree.

  • the rest of the pathspec is a pattern for the remainder of the
    pathname. Paths relative to the directory prefix will be matched
    against that pattern using fnmatch(3); in particular, * and ? can
    match directory separators.

  For example, Documentation/*.jpg will match all .jpg files in the
  Documentation subtree, including Documentation/chapter_1/figure_1.jpg.

Could you maybe clarify which part of git-rm(1) made you think that this
wouldn't happen?

Thanks!

Patrick
