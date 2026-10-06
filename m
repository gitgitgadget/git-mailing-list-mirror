Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30F3B5850
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289102; cv=none; b=KhuoW16FqyzFxKUqHjX9ECOoO1Jkb23VzIyWM580TncJ05hLv3UIuvoeX/fszTi626yiZuE0qultzextMecR1tJViNPbnXYPj+Ff1w+aYfQq7e3XZys+/zYqCFs+S+4p3hNMJI1CBkig8pptRlDkjSVA/C2par4KFcZXtCs8shQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289102; c=relaxed/simple;
	bh=EoKg5c1tTbiGUlJFo0At63qRyVQ9vuRrPdA2lwgDhC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5ZUqdYIxFuk4v3KEQ1QTOK5EHeRWGh4Evs737CBSNogtR+iMFyGypm7p+OmSdtmBzkCv1L/FmEuP08lpSvhDbkwZ0mQb5OliCa2kn5MQq+O/WrvnSzqgBcDXwpgmwihWogPgLQCGsOHZXwgDlO6k0lD1EupkvPSohnH5w3lxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cCGY8Xjg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Frt2e45G; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cCGY8Xjg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Frt2e45G"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 213551D000F1
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 08:18:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 08:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791289099; x=1791375499; bh=aU3H7Pb8gm
	W8/o8zjkMc/T1fHOrR2JFb5oIinNf2IrM=; b=cCGY8Xjgwv2yM0JzZLVweyXE3n
	qtHB1Yk5xpJmLbYAse/Q+c7gBXREd60yQ4rlBS8tpcUJZb9WgwK+w1oRLd7/T0ip
	WZ4H6XZtRHy0/3WhFrL+xUum1jMdb0L4N0Zs2W/o1mAMRt+6Gp+tbETl9m/5n7SF
	Tz/ijDSXdXcVRLVT7nUIL53sA+N57me4+qpyqEzhXYAxaEmg1Pwgpp/CaDxjsOFH
	FbhPxBUiPOZ4v7y3xEEuQavQAlMuzYPWT3H+58S5nfz3YhPv0eTrqmQ04B4vhF7D
	pG3PNBR3ZJptlTrE9RVVOSXlznN00Rs99ILWulnIx/ZubxJsT/V/YrpVo25g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791289099; x=1791375499; bh=aU3H7Pb8gmW8/o8zjkMc/T1fHOrR2JFb5oI
	inNf2IrM=; b=Frt2e45G+efxuKlRQVUPtyooFsnQuNUecKN1zJ3y8OPGhKd1AjU
	d8yny6GBKC+l0z4I+B20rHB5gz4HCmi/TBNn4CXAwmIL3b1W1dGzcsyDFz1BVfcN
	4xDLaR8WT6b0WGAdMBmE7Z8ED42w/5oZhZqRC0IE+P6H9vEUsfzkMB8KLyLNUGKp
	aHsvlahyvw2a1MSwSuetE5U0G0zjBf56CB7ZUFynCMC0sOPqnx0XwjmLq86UwpR+
	hkQ6Gq2ep+Pe4O9mx47GEw6gPuVFITuuiMaNnttXC05xfcXfq1oQhi+qwO9YdaER
	Ej2uIwx0ROWrxTkBPetpIKMLVPYiVCX0zQQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791289099; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vLruHCeBw8XU46WhX/b5FtCk7g1X4U5b1KkhSlub6uNhOk0
	R8WboYdTDbD1Y/Vfn5Yy2TB67cJv2EwDHbPhb2xmjI+nqFdXbzzMc8ruAfypecT6
	LdKH0gDX6hHuITw9HjwWYug265/yuG83nFoS0t9NIHhyILKbJv52sEQsi6mkcCzL
	waW17OxD6jqwC4ueNgGhKtKXQhZUxeIWRG9yL/sQOOPfg4YFJZFLkAKkthly/5Bm
	D4PNhgBWK21M4dI7AhQYfD3FmL3jcdKVRrk6lFPQU0WfcmWqvfUza8Zw1T1pHcus
	L4f9cyc/t1LMb2g4/+N5ejc7HuGxaQBUopQFwSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yv6JJvwTO9ALny0o6fpKOTuD2GLCjjzGZNzXD3EMTDM=:EoKg5c1tTbiGUlJFo0At63qRyVQ9vuRrPdA2lwgDhC4=;
X-ME-Sender: <xms:C-fEavErJsAISzZuPkEplyEl3GFMa6NwsBEjQWIY-sPuiwjmullhnw>
    <xme:C-fEaiXbenSy7B3jsm3Y9peDJxWrcwpnuaIqPKEyyWzBR6BtNOEUp-HoWxbu33Zpu
    lun7jTHgdnr7qUQ7Fx7hvjbNv5MIfYpQp8hTDZc6IuG4i9w7CcAh0s>
X-ME-Received: <xmr:C-fEauyCl0n6ry95V5Jods5089GxqtWi7QvQuGD6_4HMncVwgSwARAaWxQW0_0SCXA-P-g>
X-ME-Proxy-Cause: dmFkZTEF0L99oYUMzJXGZpA4ofOyNnRBlHizyaiugAYDwy2FHltS+Y2IaGErp910eMvqGR
    JzxkcCIqo2yhI4uEsmwS394aea8oDVmU6kMNe5TsqlOYLUbnETCYYzy2KVLO97bh6kUHx/
    snVi/pE2TnpHexcIJ2nx6DU9FWqCiLLOGW+9HAxROVPbnxs+RvJJTz2X4GuZvZTnnC6cP1
    MTE3vXOM6ND8q3VT5PZyWdGZ2O3jFFF+K+hrfD6BrH2ONawpPkKosXWk2ZyKa6oLrtrk4u
    MjcyFgJQFr3go1Zh1Y2fuZnBxnVCxdtyU//B7KwbuutIpXguOQ1UUUAw5m8782jqdXcXlI
    cvIuAQKytI79cMHd9Vw0lHJUirL2rOLKBd1HmfgvLxhAxgnCGS7hY8tZB0CTbw+jYnpkWP
    mzw7L4Rg+Cw3671P8sTuM/u+KVSf9lWj6zvTz4dXTgmR++x20yVRs/4t/e/ZoX7z+rAqGV
    wUTHL4KuS8/z+XE2W8gD91arE6mkdXkWqk3BIXdrPEKfqZNiYP7uaUIr8ARqxVmAjKwy6H
    IjmESoe+tjz1gjtqe3xelPNNIqZGyOmjSaThrBhWG5tXv2mREyHl8oEfIzxjHWVyOtST6U
    boxgj8GSOkXERDIwIlKtVRFmLwMYhNCfBGEfVvyCVsNy5X9knk7X1AhQs0Iw
X-ME-Proxy: <xmx:C-fEaoMPjfaaPyFlK_X-QGTC1JaZifDw7YH4ZrLX1webrZVwWloa7w>
    <xmx:C-fEan7KiYZwKhAc2EWhmMFjrWPBsNqtYsfJOgP727lpy2ztoqWZjw>
    <xmx:C-fEahNXWKIWLjhufBXT2zWpzJlIEqDpbnCayvb0OiXWRDdsSiF0TA>
    <xmx:C-fEatnX8BgdHx56tCTGfhSxRaFqZIyd62w-nfek35Ev3OX1LwSyzg>
    <xmx:C-fEav29wgQqdPWMVfMDBAno262sKJF3fDYUKAN5lwAAf9A07pxkDZ3r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 08:18:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a05a99d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 12:18:17 +0000 (UTC)
Date: Tue, 6 Oct 2026 14:18:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/13] commit-graph: require resolved packfile paths for
 `stdin_packs`
Message-ID: <asTnBsWxEvgphOV7@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
 <20261002-pks-odb-move-alternates-v1-1-8a63507b88c4@pks.im>
 <CAOLa=ZS_S3bYXEufor7AgXpX76NwtV4NJdGRO57-bpSkYZrzvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS_S3bYXEufor7AgXpX76NwtV4NJdGRO57-bpSkYZrzvw@mail.gmail.com>

On Mon, Oct 05, 2026 at 03:27:27PM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Users can ask git-commit-graph(1) to write a commit graph specifically
> > for a set of packfiles via the "--stdin-packs" option. Those users are
> > expected to pass in relative paths, and those eventually get resolved in
> > `fill_oids_from_packs()`. This ties the logic in "commit-graph.c" to the
> > specific object database source.
> >
> > Refactor the logic to instead require the caller to pass in resolved
> > packfiles to untangle that dependency.
> >
> 
> Nit: the changes look good, what I'm missing is 'why' are we doing this
> change.

It's basically this sentence:

  This ties the logic in "commit-graph.c" to the specific object
  database source.

With the current logic we have assumptions in "commit-graph.c" about
where a specific packfile lives relative to an object database source.
But with the next commit that becomes a bit harder to realize So
resolving packfile paths early on gets rid of parts of these
assumptions, so that we don't have to resolve those paths in
"commit-graph.c" anymore.

I'll rephrase this a bit.

Patrick
