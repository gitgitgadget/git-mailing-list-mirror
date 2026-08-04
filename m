Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887383AE18C
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853875; cv=none; b=a3oixOZzXw/DRfGvw6PldUFmkzDKFffVH3OlTUBGzTbZuk0nYaxyoElG5AH2TyJ0fI3j6/lW9RfoPSfWLnxhgeUNEOA8dMpOmhhKa0u3JwUIRXzIkUEqxzoZiBHmtDo/KWgrbD9/qEp6W3YUO79ph+09wH9HPWYQKEGpx86sXFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853875; c=relaxed/simple;
	bh=zSYUkbxJJLL1oAXxiWv4yWqmqcz/XXD8+UUf/l0DkTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAtXdyq4K3et4eYk33GP1Osfx8NsmDJK4Ivj+A0QQxyOxQJJ4evIaFUFyt8kEPsI1pT/PEhfRXJgoxq/tVbpLHy+JEQ4ZP8PWkQR4fk9HTiIwDYe3la8qOOvHG1U7eETcy70nR7qjtvNOe9UipWA5BnFpFAU2cUXPdzwyfMPtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YhU0+3nA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOkOE69o; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YhU0+3nA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOkOE69o"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58C7D1400129;
	Tue,  4 Aug 2026 10:30:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 10:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785853856; x=1785940256; bh=VneIl3VFWE
	CX+GgpMFR6GOSPne5n5UMBIdHaCVwpAgM=; b=YhU0+3nAWTaKIDZIy4xyZGhINA
	1dM8l/CQzl2f6DmVCjCm4jU1erFYgxVAHJD/MMDGfUFv14xGB9ZCCzHb/+JndBV3
	LFqOvxJlp4dmMPh0XBZGnfKEH/mBOAQneyec7sw6PXN96sKHQM4zqU8EQyhFrZ0X
	k7SR9Ju+3MvbbikEkzLyqliHjGBOZNVhuo4Wh2UOcWhQn0wNRniv4mZvWI/9Zg3B
	f2bwBr7gfg1Y1EUAZdbzHqGo6hH0DH5wzEbrqgkGBcYCwuOXBUILatoGir5LbtSH
	HyGFegrELjGREHE9fQDblenrAkCwCsgvykFtzMoiYy+QOKuKG091V4tMnRhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785853856; x=1785940256; bh=VneIl3VFWECX+GgpMFR6GOSPne5n5UMBIdH
	aCVwpAgM=; b=VOkOE69ocRkzQkwYF/qU+/LU+5iBxkr9vyaJqFaHiwjEGCrnalp
	oBraOA0Kcuy8K9yt+lVeg5eYib5b9hFx86KXbqLWKFl6SyC9eDtGMtOnaTSIccm4
	EsK7kisqG6qD99wC3AwoNeddezBrN1ErKUlahMg00a1oTIDDDot/HWlEqLgJESN6
	w0cWso76OLeZMfFSUdspO6BSr5SYyHcXgVXGhQyK1pZuh+kKAUPnT6xM3Vtmi14T
	7QuIO5HIiHTS6GBjYsMn2Z/fxErtfJQytxQMDmnu2VszShre3q2eI0RFn4pAqups
	V1FZM5gbJNIwGiwLT15KR4E2Xhfaecy6M4g==
X-ME-Sender: <xms:oPdxapKPY0tnEECZmo0Tn92WIkszUhmaVq7yGnQd9Q82LNYYjfXBKg>
    <xme:oPdxasINKObc4cDsiH6EzqcODpliK5oviGaBZxiHEb-SYRH9SivSRrBuN0d6hmu9H
    aU2oAFnODLPDhQ2hupOhxuRBl7HNBA0ZjwNv2FOPA6rVY3hgPHg1w>
X-ME-Received: <xmr:oPdxams1LFRC_kf7tAkHoGskOt4HQ2qDmIFO4XM7dtFcinTVtS1KaYvQltYv3u2NUrSiqoFiDevki5G_B6WLJ8pcQk6m29X_VdkzR3iw>
X-ME-Proxy-Cause: dmFkZTEOLWXGLpNyijzhPxnxMPOYE++w8gJ5d41nBoOT0Jz+yAnZb/lrIK/1MiM2Yx8N6o
    n+S6h2mskzzVw5X6+wL+fQN0ScspcC/xtKstBMlKIZS37TXMpl85kcKYfAFf+bXhTQV9eU
    PFCOgMQsgZ7cx14VqQhr5+4yO+uoe/ruA8gg07C67XDr1fKLHDJ+gBDvxOXLXmltV6sBu/
    Ckzh9rpde+oXkmfN/twCv3ImKd/rZZ4kx8KH00kcAjxE3ijytflN6ya+D/Pm5GRhq7pE+D
    E1Y/JzPR61MVYOh5x9oRcks99h5VxAUqHu6x9K+tx+LRO//luAxeQ7DukesHTdB+Hp3ksT
    rJA7b5/zqvSvtiSZ57kYBI7SFO6bY1/fAife4f17N9eJIrcRznq570RmsIh8HpsMntOA4E
    /Xsl0fUJqCcDiPajUIuslSFn4gwN2UitZafjFyZ+tJ8bslAn88Yquvoyq981CdVdpSqaho
    WCReGS8qgPUw/z5LKncd0bu66sUEU7lt20n+2sAlC5h8pYUYps8dIdm308VC+ERqE0dNi1
    7KUOvdmt+1/H2/LOvucd2a48fFVwZGew2Dl2stGnG3tvG3+XxLksgj2lYG+uHHedpoFFZO
    8msHXq1o/nYz/YAFwkWJO7mLF/GewAgeG4gv2qO9BRLIjYJalNCSuXm774kg
X-ME-Proxy: <xmx:oPdxapTulHBXjIZPbxdlhgc5fPIWFamcmbLeFw60jYfCgvLfWIqQxg>
    <xmx:oPdxasPCc7PTe0WYwKlG1VIfjideNsHv2bmbZZXD1r2Rm11zt4ilfg>
    <xmx:oPdxauZsn13coSfmmW9_e5GmXaknLeipM0jpG9f2z9ijKONcNfPzDA>
    <xmx:oPdxamwVq3gtakYS1xH7mPz-uLs541Nh8uUeGRzqszyg5aVjXzFQgA>
    <xmx:oPdxal6d1OFhFeOd3219By_6wJ9dTdSLmm2nQ7K45i496wyD1wReipBX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 10:30:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a47c6e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 14:30:53 +0000 (UTC)
Date: Tue, 4 Aug 2026 16:30:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] doc: refs: linkgit to git-maintenance(1)
Message-ID: <anH3mkk6K5RPMZlJ@pks.im>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
 <linkgit_maintenance.b0b@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <linkgit_maintenance.b0b@msgid.xyz>

On Fri, Jul 31, 2026 at 11:07:03AM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-refs.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index 98828041c23..1ec26be0b4f 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -46,7 +46,7 @@ The ref format migration has several known limitations in its current form:
>    ongoing migration. Concurrent writes can lead to an inconsistent migrated
>    state. Users are expected to block writes on a higher level. If your
>    repository is registered for scheduled maintenance, it is recommended to
> -  unregister it first with git-maintenance(1).
> +  unregister it first with linkgit:git-maintenance[1].

Makes sense.

Patrick
