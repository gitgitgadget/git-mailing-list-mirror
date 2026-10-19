Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39FD421239
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393761; cv=none; b=rFSyXb6PaJqQZuSU3IDcVsQ5psDhrzASdeyRbgTteRmHcBoD/kddriaoRXNLzoF9pd2TfPeeUgg44jWp1RyEfv3jmOsfQIQC8p3gj+Vh/pg5D91WetrOej3f7soN7binuCq+Sys/Zd7vM3Ndj1nRY+B7VrH3mwdP7HqS8Ev0nDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393761; c=relaxed/simple;
	bh=wfxlozF3OxCzHXfBV0E5WmxSxRnCgfbwFn0UwfOezN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGZrA5xAXbq8JR/M2eLzz7EhFzwZHBjHE35v9qA4J8Tv7QQs8vTKtjLXiBaiamFKuP2rgNAfpJEZkNVkAH2DRGqU0DaHzuT/uDnf5oNuIGcN4CfKMH+DxgotfHyzNRb2orJ6TzrWVR9l9RFyDceJjBvH+mDBy1h7aSpOZn4bAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nv6MRAHs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A34FwpQP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nv6MRAHs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A34FwpQP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 332E21D00128
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 03:09:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 03:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792393758; x=1792480158; bh=pls0eb/gdv
	AMMkHFXnUusNjxttW//qDlpl8/5LoTf5U=; b=nv6MRAHsvUS5An1iWNGCTCsDEW
	IN2OTtPlieFXmvdnJeWDMX+zvk8YygalXNTaebmwKbXHglB4V2jraNJ7duoTwry9
	6GXGsHgOMIVAkCP+qE0Sb/VmoXvxMY54elAmF042O6DQ72O4TpVFR1XAPtNNankr
	0hPqu+zWw8En+W1AvM096SHiX1wL2fRXsfHgDh91QSVTkbaiK8+30d4snGtFidTM
	d2Exh/T0ad9FYPVzVGH4JAEF5lgW8WBxZAXyTDM2jlkz+mCRc4qT6eGu9ThCnLvD
	wWi24xEBuvEpVxlxBQKHAX+bNAA1QDbDzPwdTXNGllKDheV17do7hpxCCY9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792393758; x=1792480158; bh=pls0eb/gdvAMMkHFXnUusNjxttW//qDlpl8
	/5LoTf5U=; b=A34FwpQP6IPjdKHQLocHe6zsz/C/BnYzg9fTvA7HkzUEzN7S5H9
	1zP7z/h5r0YPDiyAFm6T3vHUx07Jsn9xy3o3shvAxToNBDK/foItQ78ESJ6aBqUr
	QOVVrpinJzvxmfaBqY5gPct/1uAOHYbVKpl0DgTnT7qysN3ojXHL8wwp5fkF0ete
	3Ebe9HXWTO3SDGIf2pgdcOwr5tqVsUbcaM8nGsSMd4TJiqCXUCJzDepSg+832gv5
	eNUzY0UZ2oatq1fdFI1Q6CrFimAAdvuXQvICYtPBWx+3rj8cB+7fC7GTPcebAohA
	BHJ+T+Iwt908nlDgZD7MHB96AWw7uj4ZLOw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792393758; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IFFacoFIlIxjia7NuzU2hdqlV2pmxep8wY08/KLzgy4zMIY
	d0kj65vAtxYMeC0sagwCEXKBOZ7JYN55Moxkyw21GokaYgLJyebivjpkOXH482gK
	dQora984ojphDBtKZDauvauC74Nqatg8gmJ02nM3UeIJm/5tK7AYzBmt1tR1EWxk
	mqsIyCV3+GulRXNQuyku88KenH03gxh1HnrucXVf4foxRI9SAbFuXheaFqoZh2ic
	eW/03JYGt7xIbcCtPBNc7lhhz2B2lnc/ZC5AGu7IqgzISHdsk04yYmBmOQ4Jk2OX
	uYfMb5GVLXOiHjX5j3bkTlldOey/Wq8dK4layPA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:irTakvucOQN24nJ8PE/wOfuTEZdoG3OVBmp2cyTdDTk=:wfxlozF3OxCzHXfBV0E5WmxSxRnCgfbwFn0UwfOezN8=;
X-ME-Sender: <xms:HsLVal23vxDl2ro1YzCDxlZXIMw6SPccdeu2kZCtVBu6Sdwv92GXQA>
    <xme:HsLVarKbg557FFBUnFqdA5Ps-9pVyFKTK0z03zJ4lorMlgbkm8K2fZT938yrXWPdI
    5uN5CukLq3N-6yDJTVYDwaElsRc-eiQBFNjXIjWBl2bWxYk-OX3uw>
X-ME-Received: <xmr:HsLVasH0jzOwS8Q7nOzHjhbIiFHi4x8Ww4-OdRlgNgPVQnYWfrjZkQ>
X-ME-Proxy-Cause: dmFkZTGX8x+uaYdZ0FLrnHx1jitvzT0HYQg8zgNnM7I8qeulIvA7/FgcOLYhjMKBhexk5C
    YpvvZmiLZ5+BrxjAeMTxrPp1Mr5BI8I9COYoqcnPah4X4rcJbA4bR4RYaOocMJe66J5Fsw
    uas1djWKNJ8viUB54E0cvlLAg9JljKmhBjLkDOhxdUw+1t/v9295S88ebCNZenx2clRDvD
    yY8ldV2MYe4aFE+JHK8eJt6LC9orroNUyRYsDX70er2912vxB6Q4wWj4YhC9qsnYWukcmM
    +K682wPiN8p8R87fS92qULF+OXe7lnzGmUhN/rDMNLl+iN19k4XVPXvjBZ1onowusMzOGS
    w7EIVfVdE2ZI3CbKphJ9ZCarFaQEwTCN5tIfzA6SYqqM/toleDsBOMiGNu2rQkIGxq06CM
    G0T8K/+XLxGe0DGk8eGpYBw5+jmN/lozD0kaMuc0ca8MAurq/82ilwcG/v8P8mnXud2sB1
    fdONQcfcvoR5LU/WLFav8qlJEDvvYbC1tZG2N18oP0OpFSMN2aCnU5gvrCUOCz8MhySHY9
    AcF0Bp8OGj5CjicBuiknvehnLSmecFrznwPjS9MD0k7m3RCwr/m+ihslb5IJlp2jVYQF8+
    SkULGAfv5Qm6HNozENCij0wAYC2hOVEbsAsUPn9E6kBwxEIntwpNDKsh/QRg
X-ME-Proxy: <xmx:HsLVavW5Bb9pRIl7ngtODTv45BWVlv-tLXD4vJ_aHZzJQBDfu4qYhQ>
    <xmx:HsLVaszZnIZKBndDaTJ2DhryXB6T3D8cBGzLemZDTKp1QGKbSJT6hA>
    <xmx:HsLVasQBPs3FBNlgQ-zgYK08nr9aLKjIWrjWTbFpMyTaqaHJiSYgbQ>
    <xmx:HsLVaggpcDRcmMVZN2jwfwWBg3UeqL9LXnIH8ynKBY1oy7AbTVMfGw>
    <xmx:HsLVaoWpitKwpJBAabHph_4uPRpg2nm-zdmmiReCViaSP7izGiwXpfT8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 03:09:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5583e9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 07:09:14 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:09:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shashank S via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
Message-ID: <atXCFxxe3Lg7fV2W@pks.im>
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>

On Sun, Oct 18, 2026 at 04:31:12PM +0000, Shashank S via GitGitGadget wrote:
> From: Shashank <shashu8660@gmail.com>
> 
> Right now, the prune_packed_objects() function uses the global

Nit: we typically refrain from saying "now", as it's implicitly clear
that you're describing the status quo in your commit message unless you
explicitly refer to an older commit.

> the_repository variable. To help with the libification effort,
> change this function so it takes a 'struct repository' pointer
> as an argument instead.
> 
> The function for_each_loose_file_in_source() uses a callback
> that only takes a single 'void *data' pointer. This means we
> cannot pass both the repository pointer and the 'opts' integer
> at the same time. To fix this, create a new 'struct prune_data'
> to hold both of them together, and update the prune_subdir() and
> prune_object() callbacks to read from this new struct.
> 
> Update the builtins that call this function (builtin/prune-packed.c,
> builtin/prune.c, and builtin/repack.c) to pass their local `repo`
> variables. Because we are now actually using the 'repo'  parameter
> in these files, we can safely remove the UNUSED macro from them.

The question isn't really whether we can safely remove the UNUSED macro.
The question is rather whether we can assume that `repo` always points
to a proper repository. And for that you need to research whether these
commands can be invoked outside of a repository, because if so the repo
may be `NULL`.

> finally, drop the USE_THE_REPOSITORY_VARIABLE macro from

s/finally/Finally

> prune-packed.c.
> 
> Signed-off-by: Shashank <shashu8660@gmail.com>

We typically ask contributors to spell out their full name, see
Documentation/SubmittingPatches [[real-name]].

The changes all look sensible to me, thanks!

Patrick
