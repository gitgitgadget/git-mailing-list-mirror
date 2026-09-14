Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36483F4DE6
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372391; cv=none; b=LcBE9NH3+CXDyzR8tlqJGWTsLTOQWnjpVVciZ2HCWWr8ITf1ypy2A/xdh3AMaIyYhNIC34lFwzP3N1w1ncBzFDCTi6jefngsPjjiIas5PNhr12glwr2vVMI8R0r6OVAuAnWXrlDSVVbt6gbHN530z4wKm2VjdGu3vQLlxkm/gVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372391; c=relaxed/simple;
	bh=X5YIB2dsK+DZEqJp2gzZNS99wPcQhoBYjMX/GRmlZQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8rFbTANpIyhGfmpEewCymd0N7ostFN3h+b22nxNcS3kU4NQMe6n2YJyznkj0O2xO9IqkbrAqh+FblcB4JfGhKBv3UDmbPqRzbL2cSG5gue8aV2IFL/YUkeErKSY+a4rCw04Unm1pQDqJglpUeTx1C9/BZFpP0pDU5eoAGiy3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eJ22d5ye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fK63aSfz; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eJ22d5ye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fK63aSfz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CBDA1D000B0;
	Mon, 14 Sep 2026 03:53:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Sep 2026 03:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789372388; x=1789458788; bh=ntZqRyUu4S
	TLZ17KlvJwdTmEgEPPESKxWiS6aE6bedI=; b=eJ22d5yeTqZgNHRzq2kyTAvuTk
	+lrmQBRdI4oWDMt38zJ8Ogo6k4MUWTLR98WuUNLIbx69XwAPzrtYPwf4XeUesXDz
	AtQto1ol1U9ItBHPmf+Ac4lM0NCIUZL5vWpppIsiSbml8s8fo7bFxc9JHKQCOmFj
	t5ZbbF6NfBRVXAQ715LID+3QEO5kgmYXz/3gHk8h98yz69N0UDd4IeVZv+h20pal
	UFFit2Y/lWhuqnrHH0+hSdQOZJi1soN9tTJj8RQX/9QyVkUS/h7OjM2KQVVGH6O9
	FJhZOnnXuvP51w7stB/MZV6fihnTFNU2HIGu7vrq4d4N5ER+9LPy958+nEaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789372388; x=1789458788; bh=ntZqRyUu4STLZ17KlvJwdTmEgEPPESKxWiS
	6aE6bedI=; b=fK63aSfz7KimL6/ajq/Qp2HjkBt5ojBjk9B963chJRO9xhOzYjv
	zBFatkzQnZ17A4fBxg/moBvChlHQmLbMyAptl71ESJ8XM2ykLXoM0zd4quTxkvVV
	FKCS6281kzV3mz4D4ULjI2HFOoiGRrzRJdR9X2hWfyvM1vxQtR8+zcv1wqJVyAmp
	CEOlkorBnkHai7fF+JkZ37o3XsAiSI37G49axT5peGNTxE8628G6tljE6/xrkLIz
	dFxBbHxOA4NkMNFwrs+e/2dT+i+BFcjhiJ8KFfjbg3n2RWsLqJDoyxRKY19X8XRu
	K8dR4+jCeoZzwgZNvPJmP3334fvkCu8qn4A==
X-ME-Sender: <xms:5Kenam8G0c15Nz0AcjuZ4LzFOx4TMc8lVvL2vL-MEtVEotFyXWvLZg>
    <xme:5KenauJu7U-BduFDs1nyGO8STfexYeriXnD-XZiFX81FDJSp6PAQGagnN3GnBYoZD
    O9pPJ-POw-5olVUM3b3Zs1IyYJLTe62J0KILoByqvnVs77MRWyCJDQ>
X-ME-Received: <xmr:5KenapZKjcLWPeECByNXCyqV8bvqQKDiN-nQT6KO_TSklkoWbbGD6reduLVk3egzxtsilA>
X-ME-Proxy-Cause: dmFkZTFOKBzKNfWCUjTUil7FqIOf8WXq15Nlw9+VzWGhrpQeBgrvkEWprXF3fYxb/OVdNr
    ztJqGx0VShfEiPPkHKzerPloWxWEXMOhsgmc32ZKGnQ9ZEBzVxncI5KILcaa+ZyckkRkmN
    nF0sQ+CXaZyE6REPCda0scxOQebTKEBL4SBYQwMrHLsXc3guvug9Mf1ThS0Hn/3uq25mVA
    Idpb4r/xkBCYaChqn2d7ubIz9DzIA4HMkLvpsk7CDEuS/PEIIU9GFWZ9oAUDm8PGxunlTA
    Mb0kRyHPJ3Opr0OxLBxaoNF3mUHnzz7XzAqqPailUlD26+vd2WNXpzjnpw/aOnVlnUhmBx
    ZJ2PYVQWbjAVb/BelCgx8zosJ78vZ7NF9UyEhiQTkdVtg9gjLqp6Y+I4ZDbp4D0A5oHl/a
    Ks8zZ1YctXvDPWCoAXv/0RZe7nQJ/gxXQ3e5LSaaCCnk71izQnAOH9WomCu2w+Qe419vfb
    ijQNfVJKikRcabfgGOlQyyTOqQ3ddKUgSW41vRTD3bb6YO4gBenali3TzmIoD5Y8Tj6OnK
    TKvoHSWJ+to+unsp0uR7+khWe+p0uKC2D0wleal1OeVyBOYmsl+Hf9EkMyjo4fwaYOaJWg
    zFl95+BT2w6T/Wm4R3v4Azs93TxfW7ZMJy9Kidb2KrZT3OsW24KEK3r27YKw
X-ME-Proxy: <xmx:5KenaoIJPoaEVohsULg1p_Wy2mg4Pc4Gi7H29wAaMlbDiShsskB_hg>
    <xmx:5KenavBTLs9HZfjf4CPVwUIcLLS6n5ISZ2sa26sFAc1p8dJdEoumGg>
    <xmx:5Kenalre9GFCcj6p0sF72RYLoQDTpUO7CCfaBkeYoYz_aUCcLtDB0A>
    <xmx:5KenaiiS0imqYyDlGnhpqToGsWDgXYImGBDa63KYdcp2gJG3v-J0QA>
    <xmx:5KenaknlAbys8cNX2xxVA4SvhHSRUEaEFu_951J_aJM0DaEDVM1tLTxs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 03:53:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 975acb78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Sep 2026 07:53:05 +0000 (UTC)
Date: Mon, 14 Sep 2026 09:53:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] ci: drop no-op gettext link on macOS
Message-ID: <aqen3lVdecDqo89w@pks.im>
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
 <aqeTas30Vs3aGE9D@pks.im>
 <CAHwyqnUG_ta=m5e7rk-35D0Dve+GeQX3eNuFf_U4kSd5+Sqy+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHwyqnUG_ta=m5e7rk-35D0Dve+GeQX3eNuFf_U4kSd5+Sqy+g@mail.gmail.com>

On Mon, Sep 14, 2026 at 08:57:49AM +0200, Harald Nordgren wrote:
> > So I'm still left wondering whether it really isn't required anymore,
> > and if so why it stopped being required. Links to passing GitHub and
> > GitLab pipelines with that change would've in this case also helped to
> > demonstrate that it works without that line.
> 
> It passed on GitHub: https://github.com/git/git/pull/2402
> 
> I'll take a look at the rest of your comments as well, thanks for the help!

If you look at the pipeline though you can see that almost all of the
jobs were skippped. And in particular, macOS wasn't tested at all.

Patrick
